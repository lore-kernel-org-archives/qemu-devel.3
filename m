Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69DCCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZU4j-00017p-Jz; Tue, 16 Jun 2026 09:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZU4h-00016J-QJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:43:31 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZU4g-0002uZ-8T
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:43:31 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6611689dc10so4680834d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 06:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781617409; cv=none;
 d=google.com; s=arc-20240605;
 b=FHEs9YJVvyl2j+OffFqV+lOZg7U7hkQCQaJnTEG1x1p+QdYjVZTaFs/G3XM8dqGesi
 s3pD316daKuaqR3DG+KEXHDRq2D6NIMhxtsvXotLUSbs7wCsk3Va8pbRf+mpUxoLRR4x
 4ojHJJFvnDooI5RadJb/yFlUQ51LCD/u8Fph+QdVKU+wdJgUp5PjGUi2Lz4hjMpjwzuU
 q2WrrLzcWdNo4iJyXTD4o0fgGu/IKi/7uXcpMn+V+GYnzgXFiMUd6BVoMY1Uk15FZM01
 bz/x6IJAC9EPd0vOV48MQrvMtVv6+oBSBFuSBVKK5zJ2SWK3kDRxCiTfayOqoeTKGxTC
 mbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rFx0EQzEcHO811YSsAQIZMlh7Pfymft/YImwBbwytGc=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Q0ujPtTiw3RIqpcnaE0ecMYj5LjLB46yVR/93ej/pDVGGuInl+w4ElZAw7f0At1IJa
 IE5aSDCBHU9/608Z1N8ciM67cmg6HHygfS1Cv3LYpERYrd5+04LGru2Vrrb8v389Myu1
 Z2urP9mI05H4GFUcEvcbjZKwLfvhaGSB+3P5QRgo2CQuSmVPb9/Vf5LhjOw3BY6SmfoP
 XJS3w3yTNGyZU3U/QBJdA0JLE6wVAs8jnCHTUoW8DdKRIcsJ5C2d2uoMm+MDQV1WcBYQ
 nn49nh0WjflltcBJLtvT9fnAysv38ctCMezLCTZ3+2AM3UnnFs9NRmpLngFg1sbwveb6
 G/Tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781617409; x=1782222209; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rFx0EQzEcHO811YSsAQIZMlh7Pfymft/YImwBbwytGc=;
 b=hddOmwUFbTT1gtvjuTUSPWOP2eKuWBwOlB2HhqH6q6L/8zV9eXbUIU2ncTFYPtxHSm
 3A60og2zZFzm6D7ZuxvuUjFtHWXt+IlOvQMxkj5imyIAiIdozD201jH8G4m+q7+lwhW4
 BRYjDw4ZkuS5iENldt5+W6ry8BpmhZ+qsrMhSTkfV0e7pZa6pQFtAAZ4MpeIwhePPSay
 lVeXnIaICckw9aEVgGc17iFmCLi0lexoHcSe3IFpkB3p1Mb1elIIS7NAoU0TqaUWQgEi
 k4LFFd8d+NOVk0DD6NvxwmOC2aZ7lQEMLXvuhAb4Bjr8TFVl88DuFE1T65wBjN8wOlmd
 J8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781617409; x=1782222209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFx0EQzEcHO811YSsAQIZMlh7Pfymft/YImwBbwytGc=;
 b=BJfOT78Xto+HOk5e1xcVSForfGlvKOzLcHi/SHFm1jDOSbbFd4HJCuXAXc0swzHAHb
 xKtaz1gulFIdbjgH4KUb4Qr3UoSwSEEXO8t4S9Gq18wtzIOfKNzDspz+7F53a4iZ8Lc1
 CbET6WLpJW0j40hclBdr4QgYNZXQ66suztjGt5/ImNk9xz/1M6Tgi7OjtDYlZv1d8ZhL
 jU2s4FWDMU0rfiQUWLr2bwhVjV5cMACvst8taov4g3Y7eYi8FgyQ6MfrmOJVg/GN9/sd
 OltvCyuACNbcqWHnj2SrtiS16kR/RebcnlTy5i2v4rR4hityWPSpWgtHj1GOIzymQ0qm
 5kMw==
X-Gm-Message-State: AOJu0Yy/bkgrATPtuJsfoS9YCYjdYZ7T9g4mWjuhwrlqTO05QxajmlLU
 zRNOqcRlxKoMo5eT2xeAIt+ODOyLsasaS+c+f68byzwvrnl4Gpog+59llUFvjkOExDlIDGQtlwi
 KwUV/+dnnFTl2D2WE2qT3NusWi3eOLX0IzHolWaBLxA==
X-Gm-Gg: Acq92OH2F3KFOFTcwyDecD8NvMLvg7wMHaIpNX3GC1k9hugpPShrFJhzt4ac52OaHel
 UqCvaQLAVVFUjcYQ/HnCXGl7kAQjeBON/3daSEJ9sJIA7pYHnhV4esHuY2Ci/Qh74KHEUVGjxN2
 3IVls3ttVgFmH5j3kzFaY3u2UcuKC87aEJFMrkBFpLJ4ELxrmROq+1vi94/nsEAo3GnMjPGzLp2
 UNONA8nlCG7em+LN2AWt92kftORPJiLL/X2+VISzWbeO2UurcLlOKeqONjg6O2lKiKgfCGQ2ALw
 igFPpHr80ieohkjVbbVZMzJQG/ntvxOLcKb4OTXdgnrihjCJrUyB/MBxn5h3tAml0eg=
X-Received: by 2002:a05:690e:e89:b0:65e:1d95:29cd with SMTP id
 956f58d0204a3-662782d4ed5mr16406881d50.40.1781617408870; Tue, 16 Jun 2026
 06:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-24-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 14:43:16 +0100
X-Gm-Features: AVVi8CfWAkgaeP3TjuE937BV1pQiu8H52TgM5b0U_LOfA_D46dmutV0RS98U4T4
Message-ID: <CAFEAcA9zRtLb_judmNjvXSq_ZgASNyQZJMGmhcgaQ+p2RkcKKw@mail.gmail.com>
Subject: Re: [PATCH 23/25] target/arm: Enable FEAT_SVE2p2 for -cpu max
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

On Fri, 5 Jun 2026 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c  | 1 +
>  target/arm/tcg/cpu64.c        | 2 +-
>  docs/system/arm/emulation.rst | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)

This is fine as a patch, so
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

but maybe we should hold off on enabling SVE2p2 for "max"
until we have SME2p2 ? Architecturally if you have SVE2p2
and SME then you're supposed to also have SME2p2.
I know we usually don't worry about that kind of "feature X
implies feature Y" when adding a new feature, trusting the
guest to check separately for X and Y being present, but
I feel like SVE/SME versions are particularly likely to be
something guest software might make assumptions about here.

thanks
-- PMM

