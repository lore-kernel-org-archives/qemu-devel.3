Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7ABCD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ48c-0004oG-NG; Thu, 21 May 2026 10:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ48a-0004nk-MJ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:12:36 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ48Z-0003RH-9v
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:12:36 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-65c305f381eso6605294d50.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779372754; cv=none;
 d=google.com; s=arc-20240605;
 b=bC4zFZgIVbz32T0LF+5ygcA7wwFCp+2F3/JyjOXzqwv5MJx1RXInyCcub1ppSb0Zfk
 RC+WBucFlO/EQkOwPJRuf+89O/hPRMkkgsWmN55eDfkhz3r+M/ppuilA+SYlLRrrrrO4
 GuRqOV4HQpTW61UAy3DcQMUVZ2HEn+bazQlY7rpMmIL0CYbU5EcRWCrjOKNGIkVknDoW
 dyokPOYh3sfwdajDlA/uiH1N8B2RjnjkOAPTtVxuuX01SozdZ+khqVvrBtGrLjVApJKO
 vHH/kqND0Ep8YDqglBDzGRrXH81k7p2nzqvxf2qlmi6+iBKrrH7zMOzUu50GAK8scNcK
 +AxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mT/AbABjzM58u3C5Q9GG366NHFjzePd8p9hzPdUhed4=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=hzNIUTq1NCMH8BtzO8MdMO/2hHV2pZ30IdcBlBOqSfcDg/4RSvWYvCdG87LXUv9zPL
 0QmBmYWYNFAqCjX89fBQaiU9JZsw6UGC/uno1dgupEb+eY7TEZi+7Qcr1KdF5KSQSEJW
 pSmRFG/VvZR8GbaKIuzOcaKyMiuvObKuKjSHDRLx6UmalUdHzo0R4LwCAiA1WU8AYOTn
 4ila3Ff9ghiXIF++5w0UUVA1YZeIdoHICoLMxoyew7/EL872H2x6NJ0fTxbOv/eGyvgg
 OJnSVKXchR/eX6uukfNEcqljP1plWmNpOFl0N4z3Vbp5i2NNMMbngfqQ5H+TrXLnflRQ
 H2Bg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779372754; x=1779977554; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mT/AbABjzM58u3C5Q9GG366NHFjzePd8p9hzPdUhed4=;
 b=yw143KftKysLIZ0IR7P2dB1+lfJdHfq0rxQ4C1XqLrKSPOIfCHrPNA02j6jI6Zqju1
 XYResAAQodxEmZ8Ii62bUfvfDSriO3L34iXX/o9z97fNzCiMWuDUII4P7bJ1hgFZTiDv
 PH94AnL0Eo7dNYO+rJWE77bzlEgY4nr/5kNu2LSZypDoeSYgnqJcCpcbnzPTQUaOjVMu
 K9niE5RNdwBiMKgKrnZa/Ljua8IEV1WrKjmyp5PHfnptXF5PlO71rE34vHU9AmmaAAp9
 jcQ62pIZKGKYDVuA3EsCxrQEaLFBnhuc8quTyVH4WSC/svdDykGCLzOkWIMxfHRCuODl
 0Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779372754; x=1779977554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mT/AbABjzM58u3C5Q9GG366NHFjzePd8p9hzPdUhed4=;
 b=P+V1/PcmDgHfJtCg0R4NOZQ4E2tqT2Su6+aIU4Fl2SEJcF5hHeSOtKcqj0UqLxqw2m
 qZqeSB1r9djVJeriQ+dKex0b2n+Cq8gOvJtxtkXbxn5k69yFpoGJw9BQwXYOoDhVdDoQ
 L/ma8h27YPptRyQUcWfbFgsdiCAf2FKDOFMYqc9cdC+9Dxjdyw83M9LNkggBvMBfH+mI
 1BOh/q3IOoxutMkGwAbl4gsdy/aJApl6F5JIbliWAwIp1IO0xNOV6P0R/woFIFUlIkgy
 WVdTDbmyUKao4y+cBbsqNU3xFQMDy0HGVVtBZnlQf6uAmpw/7Oin6tFoQLtMduJHuD55
 PHJQ==
X-Gm-Message-State: AOJu0YwkcKbYIMyjLonWcjTgy6U6MlAxYuG9gwKyejBvCRwqywGE1tzs
 EIriKg74/nlGNIx9QDcbCLMrsSKd2rud0Wkb/HKerDzSfrph2cOAZlvLsH7yhFYNWm9S+bpZGYw
 /d4Jlhf48J5RuUMkg3X+GPtc4RTBuMtFYZc0qM/qcpw==
X-Gm-Gg: Acq92OG93jLERFKebWXp0INXKoca9BT88aJ6b7ymNG4MDh9CfQa+ef4JR6lt8AJ/nvD
 ZYEVN9127hbeeBveI0UT8anUNVAQ942RxiawO53nPFAQXB1yRYHXg0pU5LeGd6hIeEfGn7xSiR1
 j/FYPDlnNAGnvODw1vTXcTAxkEKdtR2abAqP0fgsmeXdA/VjLkECtz4ZIVbANZxz6J8citQi3/9
 iVPOa1HZ/NILBl9tv6NDdQhWCLPF8Q4P/5BEHnAspB8Z3a/AxxYaAjeLT02I4/tIG46o/KW5LLh
 ppf0jSOiye/Z0M5W9zRYkksJo7jFdJ8T/enGe+wScrYzH37GmnDq/KbKx+sJH9Vzx/c=
X-Received: by 2002:a05:690e:4005:b0:64e:d622:9d1a with SMTP id
 956f58d0204a3-65eae045b97mr2637745d50.4.1779372753959; Thu, 21 May 2026
 07:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-9-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:12:22 +0100
X-Gm-Features: AVHnY4LQxL8I8qb7HnS3AHNVviYTR7M_w_hzxrbQDzacAUwMOfGewCJmpHFs7Ms
Message-ID: <CAFEAcA-F_UuHZV5USWQCiDZ+693aK4=g2d+2arpJ+-iRK9kxTA@mail.gmail.com>
Subject: Re: [PATCH v6 08/64] target/arm: Introduce FPMR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Introduce the special register FPMR and its fields.
> Migrate it when present.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

