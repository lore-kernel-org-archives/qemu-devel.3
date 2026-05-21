Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695EDCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4JF-0001fb-GQ; Thu, 21 May 2026 10:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4J5-0001S2-5W
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:23:29 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4Iz-0005aB-6G
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:23:23 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-65c52bb5dd7so6053971d50.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779373399; cv=none;
 d=google.com; s=arc-20240605;
 b=LtfhL0tWO7JLUVlSyl/Pw5XuSY2AlwCr8Ovzk3XtN4Cf/+uohd/YiBiz/SUevWn8w+
 nqazc5AEfOol+K/yg6SetiwTPCKJseEXP5JV2vCM4U6Mec94+Kd8Rh9cn42EUVF3cCAJ
 iPC00JXSpXUrnCW1M/OxGp1XGI0wFc98Z+px86kbrwDVg7ZEkQKCdLl/cDJ1pJcHm7B+
 8LQ2dxFDTy6oOOobH9YMYzqkQ1RmzwcjdyM046Tog9o8TuX9mB9wItPUgJ/YBD1X9+WN
 8zajJMQ/fA+xraS3Jl+3ViYvvBepYAwq1vsId0ChSFxYDl1quj9ntqvaO5twM5TCcbCE
 w/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Tx00YSWoNN3QtonE9PblQbU/nys/V09n1+FQnSga8Kg=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=kijtzNpezTlbpk69pgbJgq0bJgzSsSEvGi38JWnqDTqiQwG5gbboocR6tCMYK45cLs
 Y3Q7iyiF+ycilrU1vCfNl3YVqT3pw9ZOstPaT1K3HavSiAJYA2pRhfrn/ZRhxLNeFLfi
 B7xM1jrY1G80Gba9VQTpOwZQde0yzxTsf7Jr0zTP/72hbgHjPPELHyvupGqfmLtl5IIP
 vFm3FADxHhpL5IUUmrZ9PdOuWOR4IkmsAa0YC3xfntO8YapBxusQgyxBqzcy0fV6zs6/
 ydmRL4L7A1CZPEO3D1sdqYxv+S/hu82a5SmOfCVUVELxSfEsHOSFBWQEFfZCayo05QpL
 r4bQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779373399; x=1779978199; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tx00YSWoNN3QtonE9PblQbU/nys/V09n1+FQnSga8Kg=;
 b=LnqtjkoZ+jncM8SBQ2ue8TiHowIAledroqY4pev24bKAnZ47uZFpwrR5C+aAubEKLx
 4389+FkWiaP2cW9PDIh0OOErIJv9U7AGvMRsJsxH3H5qUODAvyB01kp2t6jq5dDcfbxC
 5L8uxMPOP1EnLTuuH8sGKp1zGABSUmeAqMU+o3j5fs7+RISUYItRjL3esA8Zbs8LyamI
 K2nzSw9UY8tCZmO/uM7pcoBN8mcYDPfZQZJMpIh22TD0gzDEdrtjqB+cElWRXZbQ1mKo
 dQK66Dvmd1wE/NapXThrXNGzG5ylNliXGZui7AEPUhn4Ds88C+SUjXTF7WgSZyACM4be
 DkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779373399; x=1779978199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tx00YSWoNN3QtonE9PblQbU/nys/V09n1+FQnSga8Kg=;
 b=jxz9O+Hh2H/vCUni4C8uSKV7TOUQ0aP26iSp2xQP73pVOd785nr2cSSVP8WXJJBPAz
 bY7dDSNsqUomTSjICdcfSmacks84wh/6WJBgdkQdUh1d0VuD9rQV+7y/2jjCgohDLVKp
 BSlCHVICKMq8bJ9B3uH7aZJA7TuFOgpFSjzrswib4Exri/wbP+4NtB+jC1BvuDl1K5JX
 rVQ5sGivei5YGtPY0L67UqOZz4PzfalsUUdJnWsQwuiDAAgFQKd1oIqHl8YCjNXgnAMT
 WMleNFHpFowD/mTV3gaqsxvCplSV+44+SnHr1mzc5qqEqDUA4e8/LLj9Pq7AwqQMg1id
 5Mcw==
X-Gm-Message-State: AOJu0YyJ7Ebic6qSOSfkNaqQGXizIQcvWXnSDHThJMGJcJoA12CjoyfF
 3I7qu1BUmuIZtAnvM4ftGdtY/PawUpGaZz9MVNl/5uYcuzAi+x63QHhemzsFSXAk9d5UGP+EZ2m
 iuMk9Gvbc+hmICABAlLVoVPOlpL3UBTs01qwWZeNz+A==
X-Gm-Gg: Acq92OFKEnKTk8pxaMETjQfAD5xbqQ/RfcUctjUeVVdfZMax32bmE9mGn1zlqtvVsQ9
 w30AD3IgkAMIQlbY5jiDqOwePM8A8w9x/Dh1rozrAiv7xv6lRlbma0bI9hbrvIA23pkeYbJ4ieh
 npCkxCVZJQTVkD6okX8p6E8qGT9meHQA+wqoNRi5behsiJTttHTDR9Gxj/0LWCdQsoapnLMLnmC
 8yu9R/CDIuAiIVTz56nkE8faA5BRLiitWPeNmRniJX3wkK6qBLNgBxQPrF/Ck93qKHJY/RChEKT
 zna1aqgaD2JnLBcWX9mq3MobPmcZ8NlPs41B4LuFkUi+metXETf8F8Yib2vpD7a5VY4=
X-Received: by 2002:a53:acda:0:10b0:653:8ef:935 with SMTP id
 956f58d0204a3-65eae22f601mr2046041d50.54.1779373399358; Thu, 21 May 2026
 07:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-16-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:23:07 +0100
X-Gm-Features: AVHnY4LZiB9EmzHWt3A8O2YvdeFvmhc7FKzXIKaX6bJjgb1HwUdI5bUErDsCrQk
Message-ID: <CAFEAcA_96ThP1wcTUtESz6sEa7QWnh-1Fx4o8Ww2XZ0K8kCB7A@mail.gmail.com>
Subject: Re: [PATCH v6 15/64] target/arm: Dump FPMR when present
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Wed, 20 May 2026 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

