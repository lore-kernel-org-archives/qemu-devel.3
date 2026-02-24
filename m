Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F68E9B24D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqTF-0005sj-HJ; Tue, 24 Feb 2026 06:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqTD-0005eo-73
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:20:51 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqTB-0002yR-EW
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:20:50 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ad8435f46so4848340d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:20:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771932048; cv=none;
 d=google.com; s=arc-20240605;
 b=KiWzJxOnvd1izEV9TYvIDyfJQ+sk2T65nRCNpUtRUIhaMU+AOoeNVs+sJAHpSym2KB
 aifLVWuNKDE5BHK6fngqMo0L0vd3zcKpDbcauKaJp75zU0oUK4uAIDimv7xta2Ok6btp
 52XFGlSPLnTWGxMMb7hy23S6AEXhDU4Dnjp07wwAKpofRI5d9iYcA0M1NipYZI0D3s1r
 PCyoXH7J3+1jjDBa3blKml9KFQuq8MA8rb2hBY7fPeccJSACHc8zoXzGNzymxm95mvpv
 Zs8uVZyQMNX0WMet05HK7ake7J4+1rUYuOHBbaE9FheANdCXFmKphu2T0JOdevCPIH2q
 GYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Iu0tbVQseP/ba2U+BTwo7uXn9iBtyXOY7Am9eLC7jcM=;
 fh=ub/zH6y+WPJijJytJEhlCd5PKbYleOIQ1GJXfRlIPlM=;
 b=eneA0gxJbZj96Tetmkl8jM9irdCnl9OFazOe+ECF5bbKsjnPUdV4Exko2/zT6W8N6o
 Ptjw9KVJb29GGXK3shE1stwLlHkh3DnT6K+AaJE6ChKd+ewfMYl7Ykyyh4hExsgX3Fk7
 O39kwXEZCmuQyO4/MOaoXnX6ZVdjETzjL31C5AyHDyWwMa4/Dv4WO5jLE1SQ411Nd4G8
 q35YQ2BdrbQKAF4CGSmnGi78OSw6tjM1WfpM8G85toEJB/uulOk+szf4EdFKgnVvef00
 Mi/y3Hm6kZJ4b9c4IYD9LMQN8Mntr90mu1GofIraLuB7qSlpcW+eAmmG/pyXsvbD3Y0j
 ArzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771932048; x=1772536848; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iu0tbVQseP/ba2U+BTwo7uXn9iBtyXOY7Am9eLC7jcM=;
 b=FSPYKOz2qQmigG8aBcCyaGpkGRrmn89IIifhdFr0A1LGm1lW1jXh0yaAvLxFVGY7th
 Uduav72rH45sdiqobp0PCF3+8Kcti4DNLu/cWtOPl+AeKisqDepCN7DY4GU4Jh5RSIyz
 NySNpI9JyFcdXT+xDXDzyvFTr2yhNDir3oOnj8HW95R1KTUGz+P5/GqnOHMUPAaXA39z
 UHal6hfIueWjHD41Uf20pXni9R/7/u76ijeP7iTCgTaFFRaUWY1zD82istVaQfyr9Dgd
 OgdYZJP7ZRgEc2TAq8JP3anoIhwMKNYSQeSibts45oPQAz4KciFsJQbfMUokyNBgsyTh
 7oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771932048; x=1772536848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iu0tbVQseP/ba2U+BTwo7uXn9iBtyXOY7Am9eLC7jcM=;
 b=AWbHBQhWhpMFeH9dRAwY2pUWkFNpCJEL1ZiLGXiWwRLYkqMAjGKzfdGQm1iyN52Tmp
 BQBR1hBpJYD0BFBAqxqAPXqsm3SJuIFluUAov4inxnWG9iVHvNyJU3N+ndOAaOE5IfUW
 dgoakET6cuglQqxlybPc379KL40NwMRF/9X/qtlM3xsA0BtzFc5hChZEeZ09wYEsjZDV
 azH4k50cAlDZqvec1NqtEACLQK59vxDuZxB5bkr1XOzzUlouL4cVWj4EZHGlz6hDrnwL
 dpb4SoPq2FsUzFsEtcKBScJtQLl7QbmBFZ/pSEfnQ9+EGBLRB2DN3NSAU98et+AHGVy+
 3SVg==
X-Gm-Message-State: AOJu0YzgF9+8UZv6YlHI3jjYlq++LHoDGQafGKhuWQUGklx6kL3DpWMS
 6zqiiJL+efVgRaXoO7B7egQLYYFywIA6dJMgQY4mePzqoPbdGk6LFkBL2nUlZzKSH3SwzRdXGGw
 NdxMbTaQYcldgInZ+rWHETqowsq1E0juMhLELDC5Ihw==
X-Gm-Gg: ATEYQzyRl5pP9yxOlGRLdX9vEWDEGzCy6w8wyNujB0LwhXr5Sw83BWOdMcJlm+4biha
 /vg3h0HV3Z0JU0CLCJoOpEYhG1tELxbymuJa0nv2seG4BFyOtECfrqgnWiyDpIOZyPIWzraBAmX
 EXFShsATrMHNhk5IihwFxTwjUthDq0B+nLtFSfY3l8Gh2s1UsF1hXD3+Ngt9eHJDd1y4dxgbykx
 KSw3SFQ8tQ7h4UUNLyuo7h8lQmXohwhqUYy1BXUngqMIyMepKbCKQrPZv44ogGGkZlX5BIgm6MG
 929rbehMG1W8UajpzBiTrdxYWUaaRhW5mFhx9cmktqNjjz9CYpcFt7RB03B6bmOBjVs=
X-Received: by 2002:a05:690e:b42:b0:64c:a0c6:da8e with SMTP id
 956f58d0204a3-64ca0c6e1b2mr707107d50.29.1771932048203; Tue, 24 Feb 2026
 03:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20260220171945.1065102-1-alex.bennee@linaro.org>
In-Reply-To: <20260220171945.1065102-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 11:20:36 +0000
X-Gm-Features: AaiRm53ORj6AJMwhJVxXCQsyYwC4uwXebvfspEo9Df4aMCGz7EyGf1oI8zBQFfc
Message-ID: <CAFEAcA_rhRnJWQoC501HimdutMKessVbAF3VV=J6tFFvHMzriQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: set the correct TI bits for WFIT traps
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 20 Feb 2026 at 17:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The WFIT trap should be reported as 0b10.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/tcg/op_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index 4d708635068..aa14f15eb62 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -448,7 +448,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
>
>      if (target_el) {
>          env->pc -=3D 4;
> -        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false), target_el)=
;
> +        raise_exception(env, excp, syn_wfx(1, 0xe, 2, false), target_el)=
;
>      }

It would be nice to also report the register number in the
syndrome (especially since KVM will use it if it's there),
but that is architecturally optional, and getting the TI bits
right is a bug fix.



Applied to target-arm.next, thanks.

-- PMM

