Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3836C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we8Z2-0008U9-Gm; Mon, 29 Jun 2026 05:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1we8Z1-0008TO-NC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:46:03 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1we8Yz-0000dD-DO
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:46:03 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-664db84f074so677553d50.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 02:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782726360; cv=none;
 d=google.com; s=arc-20260327;
 b=kTOeRkANTLZYtc8UhXh4Q/s3Xxiw64l5KyaX6ZvyqtPUhqfsQsTFhV//GkxWE24j8T
 EuNFRbtc45qKktJi7UVMtGIOJfGMx98MsucxOjF9pUBDKYBF++03ewBDn+ZF9RFzaEEh
 NKJSOcdmV0iFnD0WhaYTiNQCpDmxlDkUR7BX70en9KQXFstw9PiZuXLdnuRe6yEW+4Nl
 NpLTWj/TBwxNAAICmzYVAR6dQqirEwoQihZn2FUa+HUxyhS7iriMBvSI02AS82uccQno
 QmcUJ6AnirIYtUsUBP4x0JS4RXC6dltCUHQiSy4E3o0jlNBgDibkkg89QSxEyDKVIUeC
 BVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bVaKb0wHoqpaDhBnMrXMM6BN6qpR1i8rRXClnmPUMvk=;
 fh=FJnpbpVSsh9hCR3krRCT8SuKUBTqJkfxMTUrjK2fGCA=;
 b=WuukCiCOP4rKQ9wmVgTRR9rk1y74klTAcY/CPpOmwMAUCj12zGbjOFpIhtN0Xe/n6a
 jERGU7bFzw1xWujXMceVDJXlTXuVDDxhpopssUEfDgJwWErKn5brcfa8As8FKerKrYYi
 QdxyAvuyiSofn6MbZR9pJ4rBQ5unuE4bGXROUh4K76VeQ6ZRBBl2MCV3vQLixYQWO7NO
 kuuaxoOB+SJD4aFMvVZv7O7JbFF3GV1K2PWwjQDA19g+Ch6dRLYoeOuYTcvR0691aHRL
 CKhoM6dNT9kTLmb7DBhs1BnEZ3o+/3PGN9ETrcWOH+i5fA0bf6qD04T8J+qL02gQYOhg
 yjbg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782726360; x=1783331160; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bVaKb0wHoqpaDhBnMrXMM6BN6qpR1i8rRXClnmPUMvk=;
 b=OFLSI5mkRKH/ubov4d+cCJVjGD3bxQmFPyxbUlqlvVRw2BRSUsjrzV1kxkYsKFCXmv
 dZdz9toLVvkNlv9GPnKdlfrrKZ/cnQE9t0l8K0xwhPUO+MK4iGHyazOo8xq1NF0ptE8O
 7vASVTdR8rg4VS4zC5mPcxr/CdTrGD2PlE+6mlfAkcLfLH0Sm+FRxgFS7dgaRYhptOw6
 hv8exGb2MGCwXJPkCRSKmUhmQ6m6hH3leuAj5s2p+DejprONb8BpgPwG2PgXOheoJvRI
 OPJAiGBMxhZh0FYPzOHKub5zyMwndT+5hOE7k53lpRmVQ7gt6Zk8oiQUquqoeXZz6rzy
 ARGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782726360; x=1783331160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVaKb0wHoqpaDhBnMrXMM6BN6qpR1i8rRXClnmPUMvk=;
 b=cVIWyHUiOmpNX0vu8997ebxrN9LQIlRVizKgkRuj7nHo8Nxo6XaTxHIw2iJBZklSER
 IL2BKUFiEuzJ61M9JB87Bps3COR4qgmzMzvb7DxvbPFJ5gjera4mG904iqNWEATzW23Q
 FrwFRLxxJMtK1e3hjwOK7CiNN0DBpEszAcv6mEJoTQCKQly7agzs9cLKIL9suo84Wij8
 lh8bIAaT6XwjFT8qaNjpYKH0CmeH9vvpct2nLK305W+D9HrReq+wT5PLMJxZmet0XU9v
 U3PHv6sMY615XFcpnMf6SfsCepMMlWzJ+itAeGm0M8PDChXQ2EsbMGehn3oKt3kkXHgD
 4bSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMC0MHIIKhVtOzTzAgH0uqQ6ojSu7tgv8X+eCeq9W7IeT5kxWbeIfiFOajweYx/JjS9Q/XQWJrlwU6@nongnu.org
X-Gm-Message-State: AOJu0YxnTNmuTV+kVLOz/zZ4rQV0g3Nsf7NktQwYgg3ppf801pYBAgWJ
 5mJsiNSoKdyktxPuj4B4t+7/8kztllpsgUbtA6S2YTwr6mf5FJ5swAKWsH+B8rFOGXNJ63WuqO1
 yUUbmZKuWZzmttAdss+5+9jCInW//CTdR97G9u+mJHQ==
X-Gm-Gg: AfdE7cnMmkb7+xWsF7JRX6iO5oB/lCWwb97BqAOB3OlF5Wz6RQdCLtglXMxBjsl1lJl
 CcNjlMM4S07Z09+jVNP2C9I+3IzIKBKpyvDmTKnW/3+1tDCrF+2l/5fE21/CUIoE4laanEMakcC
 z7xWOmRKOnWtqpqY5GoGzQB4GpGr8wyvbiZqozYeOTi6E8n4yQ9T5q0S7xdl2r00uEP8vjjicch
 dj0UCRqytLDyw7O2n0UPeu6OLrWJqOxl//lM/Onk2JKQfyueSXiji3z1pSrPYKcCu61WI+/fKMH
 R7Xc9FOcVURRaUVEy5ZRgLxfru8b4s0/z3/vo4PYnpQxmT2wedCrscOB
X-Received: by 2002:a05:690e:11c9:b0:664:cd1c:3c1c with SMTP id
 956f58d0204a3-664cd1c64c7mr3255148d50.0.1782726359943; Mon, 29 Jun 2026
 02:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260629074133.187549-1-yujun@kylinos.cn>
In-Reply-To: <20260629074133.187549-1-yujun@kylinos.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 10:45:48 +0100
X-Gm-Features: AVVi8CeWgaXs7Up3Ocp6tnWSRn3h06_o6FPOpy1hHVj7NW3tv_SjqrN5zicIzK0
Message-ID: <CAFEAcA-wA3vMctLFwEct2QTbz8JZeNPP0ei+3RLbFbyeH8HHgQ@mail.gmail.com>
Subject: Re: [PATCH] hw/gpio/pca9552: fix off-by-one in QOM led index
 validation
To: yujun <yujun@kylinos.cn>
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 29 Jun 2026 at 08:42, yujun <yujun@kylinos.cn> wrote:
>
> pca955x_get_led() and pca955x_set_led() accept led indices equal to
> pin_count, but valid indices are 0..pin_count-1.  For a 16-pin device,
> led16 passes the current check and then accesses an LS register past
> max_reg.
>
> Use the same >= pin_count bounds check as pca9554_set_pin() and the
> gpio input handler assert in this file.
>
> Fixes: a90d8f84674 ("misc/pca9552: Add qom set and get")
> Signed-off-by: yujun <yujun@kylinos.cn>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

