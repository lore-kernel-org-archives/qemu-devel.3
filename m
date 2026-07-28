Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3600BC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojeX-0000mk-0x; Tue, 28 Jul 2026 11:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woje9-0000aO-A1
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:23:14 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woje7-0000Kl-SG
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:23:08 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso6386498a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252186; cv=none;
 d=google.com; s=arc-20260327;
 b=hgbfwOgQSvFKs4wmJNQz+eosgwvN4WeDbBX9QoidABV0bhLK1VvEz0SaNKDrPoY+aJ
 eYMFYPdzscNx7/tGlE0Ta8HAEHurMveEhoMP0Y1AYqofg35pFZf1ReubGUwvF2bGp+ZA
 vOkE/yL7xH0Ny3F59x/MZc3+ho56DW5sCP99OPXetr71VDp2t4KOlNglV2yezgzzSwLx
 chJxOThg9bjJUY7K7jaAxQHM9t8GGL4akhpaLPCVteycgww0BZKs1MR+hbxqJ39ZkfDZ
 kPjIDSvKQmcO28iWn4YE2gJbUYbZqq1Ks4Qb+Y2MTH6tXsto4WoDNBGzOTVQkm1B+ReL
 vx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6tpV9v/Kg119xk54JR97ciqjzzxdkwIqP4iGztEVIJI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=QaTHva6iyLYLhTyOR29uii3uuiShfof6NESspVxMyePW9EQ5dSMGWqTzTEfGhxOrz6
 EZBc2UOtwwD9ujg6AGUVnL2Dnxr/J78EaC/AShvC4ovneLbMtocgTDaaDpCKZyR18stQ
 X66MhNKgWoVuOnWQrNaMRiOhAOjaOqr1tVbikbHaQSYmUwn1o1B2+l208D5co3Arcebh
 jwZGRbrY8/pZk3wr0eRgbkqlbZM48zJ2Zv51ziqWYLXZ2C+YhRrtgFGGzznepV+IUXyN
 nzTzM+gboCWzXuUH0c2MaS29wKpCEMo3fhSdrjFKJI3tvezczfDvVCMwD+Z/mtRExn83
 EWEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252186; x=1785856986; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6tpV9v/Kg119xk54JR97ciqjzzxdkwIqP4iGztEVIJI=;
 b=mX/qKdL41pb4fhQ8mb9y7l8Zusr3hF+dmjaW65HzxqxDVw3bIXs1OnQjysgL2N27IM
 +KvKjRbP6Og8F++/3ZkUoyWR89W1EU4ijx8BIrIONLtTRSwEm4mw4rnt74SzP+NefWmw
 JWAevqBWeClOCULS6HMK8sRO6toOOgaqGP9WXEZM+naNuLRmo5NBDcjgPI9QcFO3V/6S
 1ACPBBVJ6WuLSlOns+uE7+vyxpepPqIHHkQbMP+AJizUIrjjEA9xJhK6T1jgDO0okBY3
 NBu3HawL+hcxDr8LsVdskC4FnBP0YKizQCF+yDBk4me0csSxrJJ1W7YbPW52HG5jnqj2
 PYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252186; x=1785856986;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6tpV9v/Kg119xk54JR97ciqjzzxdkwIqP4iGztEVIJI=;
 b=Ly6MgkwIPnGJUZBjM2X7I9BXQgoqa6eIjM2mIsiGxxgnUQpCb3AgSrMLYWxTF0rrJr
 krDb1zmQxplN1lOQ0pscWty99YBeoqcCSsc7DEzerGmFyDCxJBmwWth52LZtLIw8JGbl
 SpzdOiTEcfPQslDW1ohdFh6dr8OabENak+NH3FBW0RiWpdmO4tZOtAJApp/rjTXWO/49
 VHu7spBX/cqp+z9DDQbzfMHZB8qKAmqr5gLFRGOU4Moh7iunTi8+eL6bJ3G9ADTKnFuv
 MINDjVrlqg/awaFpm5H0Y9vd+/Rm87PGbERLwzPTMHMEzaiSc2Qx9HXazIFZlOi6Ibr/
 Jhsw==
X-Gm-Message-State: AOJu0Yz2W3EWA21M4R6jEiucNfSPKDPyvIc2B7xBs2wjQicbSRsRnkxg
 U2NaftTJ9zuYzxUTKYY05Edm7WW15OLaBY3EF18vFGj8ltKnTaIO94CnTqjX+8wlaXkYRfdYXgp
 K/0g80Dov00EvxhsMGT57ruQyf3qew4af3lfTpF+kHw==
X-Gm-Gg: AR+sD10F4KSi3J5jrJypbEc+TuNtWd2gLVSKIEvPi2QzMoQX327tsXmwlSH4B2rYly+
 u2oxR5uJoSmKvfp93R3VOszik8HM2liDnCbFfwLcJ8RmH4mzLIiNHvsxOA1BDBuW3eHX0GrYOx3
 TmNmYRthrI98L9JKC2cbjvaKbpgKaxXv+ep0hBOjPoCBpu1IkLAPRX67unSOeLICLMR8594/EWJ
 YofQQgiizkaroYHGdr1CeUffc1gz2Mne/KkE2UWg5eXaUk4GGspSPGma+X4Httu11cAiT/DafZQ
 aE9JBCWfl69nM075IuEu35sbNwt3qEz6R1bY5Ib0lGu5xw==
X-Received: by 2002:a17:907:3e9c:b0:c1c:4a80:30cc with SMTP id
 a640c23a62f3a-c1f72251cc6mr161154966b.46.1785252186333; Tue, 28 Jul 2026
 08:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-4-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:22:50 +0100
X-Gm-Features: AUfX_mwh-YNdXFyiWCCOCm44OL2O1x9X-npQ-uURM_q36bA5bauGyq3oqAMX-VM
Message-ID: <CAFEAcA_V5gNCQZzXJbX4dqYDXsFkpvvbNKFKH0j-bEKucJiWXQ@mail.gmail.com>
Subject: Re: [PATCH 03/20] target/arm: Remove DO_ZPZZ_AH_FP from
 translate-sme.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 21 Jul 2026 at 19:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Expand the macro at each use site.
> Merge the two arrays and index by fpcr_ah.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

