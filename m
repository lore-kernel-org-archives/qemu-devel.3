Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1623DCDE009
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wchAc-0004ps-Io; Thu, 25 Jun 2026 06:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wchAZ-0004oW-1k
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:18:51 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wchAW-0000d5-Q6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:18:49 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-662dc3879acso1944683d50.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 03:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782382727; cv=none;
 d=google.com; s=arc-20260327;
 b=mFPKhSkW1nFJlxWrg2DJ+xUEiA+y6/mkNuINXTh4pjLYS/XuZK/I9iINq4Qd9pIXVc
 ubOZwyK40p35bqXxgY3U8WcUUOhH2HY469yaXPVnt4EdwFmukZSK+idVgUrv42KHtAN0
 X2re+wQKZt/yzWvNOgfQDyfM+T6p5G9Kzo8biLz3NJkpXreTqJqcPXyTuv4gUoLJeBC6
 XaWiEWkFyd6xyTCZdKvN6YR6u0H6HonW7NnrTZ2KjuW9bmUhx+lmRbNtskhhfaLpJTeh
 pdjQB+sbC/2tEqKkuQtCHhuyLUyZfmV/F9takzxbqSTEsz1To22iM30DUgBXgviIZ0o6
 6Y5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pef0KSqlE53j11M1THHyB9ckpH37jgBeeV7muOuxDAs=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=bkgivlb7tUe6O9YP2ebvyCC1OB//2dOkyXU1bOoz3SUdFXk3ac1NOf8XpWfS10P6BP
 2O5k49RsOvUS5COhg6aT9saVhedB6n7sW0RBmMcCpg2ffM+D9fLWziDRlM0pvjl+IF0Q
 pWE2Og/a79QEZf8JBx/5ZmTfNBPazGsDk0qngJwzc10CXejJTe8bT1bihra4EzN2zpBU
 XhkjG8j7ndhOG/cNnh6sXnXIOju51mDG6kHvD/if4nUeCuX895D3mGRossjhqnsRiW/T
 qO0rO10udxto4Xm27+HXddC9pHHSSu6saIIPeFg1TZ3Ukiet0acsOqG8V5+fb/i8k8NS
 iXdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782382727; x=1782987527; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pef0KSqlE53j11M1THHyB9ckpH37jgBeeV7muOuxDAs=;
 b=XuWAlsp+yhGSmvfQyT81RjD1NqhHn54H6hkb8aUDZx+6ILvPYfDlgAom2gjWmEtwp0
 DBZpL2oq2WeqvExUzNEjpKaQcJBCaTYKgYbThwZnXJa2KOCX78gcqqGnbykXrK2D6q8K
 kC3loXhPAezrMB09zRSDEOR6JwxALmhCWFidl3ep9KpTulmdWCYMlfLUtO+ksxnfQMfG
 jYHMzvsfWcu3AYfZhkOb1Mhk+7H9rBF8mx9H1EqSXSxhM+VxOQePsVTZyq7WASZSkLxS
 Pz+Mz36No7u97QOXaA9kowa1NMFhGXH6yRXNg646dXN8Ou584oZjIzkJsZWahkdnaJ6o
 OF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782382727; x=1782987527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pef0KSqlE53j11M1THHyB9ckpH37jgBeeV7muOuxDAs=;
 b=tImk78bcTqfc2cRIlZI6iFwzwVpo22BRw3GTGlLWXA8owADrPSi/6f7R+aNXboyUgj
 qFbLUDQyEMYW1CkoJWXPpvy9GOORxTHQuKjZ74MRyNfngrwmdIE6yh9dM6jKGRbxdHwu
 4WPK27PPVOMamg8Nq/EocxRppfdCKNRLzegeD429p7ipYd+beGOwB3a8cm961jFYuCsJ
 y7w1pj1fbfIrAhQVkwEXgxcVRam2PkgRVC1C/sEbbhGCNmMgm8eHdbWQq1N9TlvyQvh0
 qyMSc5BjxVFpNoZcW9s6yHoEOnKVhckAJNwQEHcWhYMGSZlusOpNO7aMIWOtyWWM2Zmi
 aiUg==
X-Gm-Message-State: AOJu0YyqFt7I2eFqgaAoNNy2DYsifk7YTAHtdFkwEzxa0e/URD1fzWCJ
 rxsOsNvZva/v/QozHhQER+EJ5yQKcHGMN+0zJLfBwCrQ+o9tjbC5XYwvokjVxP47tzFfvS/BKpJ
 x0OpPfy/lP1oc6oqyUzqGHdbpUSZfjXDg9WTXswNjqV+LCZPcAWwuUDQZjcmFtsE=
X-Gm-Gg: AfdE7cmqE3R35IbjBw5Hpt0kZIYkPwt7rh/e5bqqboO9WmF3msajny8uKi+iIy00F3U
 mfRD+wbwwER0SPkGW8K2s/28D66TGrn4OfzgxyAdw1cVmNP0zV8QOuWf+8acVCsXRiSbVKcCC3/
 4GTL+V3NIt/d5cGdpZT006kY6I6drsB7t+7MB566Ky9EszItEqEH2fChCEQ+MPfnnO2lfUinRaG
 A5Ni/dtgJPhxttFCMsFWWKm2O04cG5vYlBTDPI7p6FMsB195sLR/jaJ1lXTMtP+WRo7oHSJfbS8
 wXv6Po+qlH0u90YlNXrboekUcuFr38z1loKESXnV04H8/n6PrL2CqzGF
X-Received: by 2002:a05:690e:43d0:b0:662:f0e3:cc2d with SMTP id
 956f58d0204a3-66487e6c626mr978360d50.24.1782382727478; Thu, 25 Jun 2026
 03:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260625015159.719300-1-richard.henderson@linaro.org>
 <20260625015159.719300-11-richard.henderson@linaro.org>
In-Reply-To: <20260625015159.719300-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 11:18:35 +0100
X-Gm-Features: AVVi8Cfge2_3Jq_b9rev9-Zh-42jdONRE0uvGPA0w2UQwRuhWxSmSTPh0KrD0lE
Message-ID: <CAFEAcA_1LQRUzrw7AmChs6OTg_H-6Q_QHdaRoNif2AunGOfkSA@mail.gmail.com>
Subject: Re: [PATCH 10/10] target/arm: Enable FEAT_SME_F8F16 for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 25 Jun 2026 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c  | 1 +
>  target/arm/tcg/cpu64.c        | 1 +
>  docs/system/arm/emulation.rst | 1 +
>  3 files changed, 3 insertions(+)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

