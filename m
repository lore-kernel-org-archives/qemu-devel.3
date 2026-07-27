Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2229BC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHrW-000566-Gd; Mon, 27 Jul 2026 05:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woHrU-00055b-72
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:43:04 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woHrS-0004G2-ND
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:43:03 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-667b0ced2d3so3131786d50.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 02:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785145381; cv=none;
 d=google.com; s=arc-20260327;
 b=r0EFhTy+zvwpcI6Og+/S1YGaH4rLmtmVKHHC4cVGylZTdCW0pr3LpFk9f5gCKbdZZg
 P+oRa0PVyVJHHG2n1Zjcvh0IN0wokRCst7dcnD/OFYFDU9Ih1wGOBeQ39hhDeErETnua
 JFvgFsBvlUVC1gsdxMedO/c4jr1/zPGhcwSb4RDArumiAFdqVsxqh+4LmCHlsn2SyU63
 tQ956/VJ2rs00Fm7dejTbLPANi+XRW0nXxSIzVNGXOLtR5Gq2I8r2VAemG1RKkI3Zi48
 h+mWm91xEYa1vMt8cvvIFBtR8IZU20BFd8rDxgqY2WT3A89FD6PNWN0T6+bGfEY/gcID
 lg0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rNC7jCSwV007iM9m2mqhwvJOl1JGiDv5uBvtV3Jzpb0=;
 fh=u1c3/IXl5CmiKMzxJdRHz+iEKmJKRUT+Ef/pzAHYPE8=;
 b=IxkKeT8ABNaGt7EBpQ4VFTOViEBHS6kMqCkkK8aD++EIP9aZY1i2lkHQxcCsEJBMoi
 r1eFKo4ON58f1btB1CyLjnpcT+iIcGT/19+Z3XEEVeBeCC4sSaew9S3J1zUAFcELBZkB
 g83iaauB4G0oCPJlPkgmktH2fCG8wGwwYuq+zc5G8WX3tB09ZwUGNGNq/zrsC1lBdgqC
 wL96dNm/52+BsxW4cdselrOzZeO6XfxhSAMxXBacYD0890LOsgwvcVNUNkXbctSeJGDd
 nUhfM44OGDwZVdgrzqRDmPZEMBKmw8UWeb4ZwLnRsjTkIUGbHriNsTt0Rs4ChEsJj8OR
 wlRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785145381; x=1785750181; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rNC7jCSwV007iM9m2mqhwvJOl1JGiDv5uBvtV3Jzpb0=;
 b=ieBzf6AZb72HrRuyU5c3L8xIO09+RRHHvoM0z05zUGzuHagDJJZtGL9kNZNoBi6yEJ
 uwS8S0dIK2vZ96FvZwxTt2Hcy0s2jWndYx+gmNQgKvJAv5rl8xki6grc4lHLR0ujRkuo
 VlBTjxhUjTeTL5gplh5BYsoku6XV/tt6kY7cwCu2SuL7Rs0X18Vme/AXqswtpvu48Mh4
 INFu3zlOoWj5nfDg7Vo39z3i3CF7LlZaWWrws+h8YtqRKRHNbhehYw6TsP6focE1/fTZ
 uLsHF5fNa9FYoB2cLkMMDQQ6BoQNGbVs0yi/QCVq4M6RdT7yXi0xlS12tRD3gMQwP70G
 oWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785145381; x=1785750181;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rNC7jCSwV007iM9m2mqhwvJOl1JGiDv5uBvtV3Jzpb0=;
 b=fhAB6PoVVgEKk2asYMq0qX3SUR6Lu0GJ5vs9eSQ1u/ASACAiB72mkoST9sIYo4h7xQ
 xEI69USrAUfwQFIDKDX/lzR3eyPbh/9emY/eCmsCJWM+vMY7tZpteu25qeVLgOnC6Y8m
 5uAo214CiUwirRCa+Ijn6bVgzrFlrkYumKLpbC43unOIxzFYX2VVmkcMq/9YBLg3Q5kR
 TfQRkMy6MVxRVVfxssMCdKbYqLn8KiFa77mP+o31bB/HVqcAXUN39xuG3J4dBUzf0FHd
 WTcy0YPE2dDMAf/5zwT/sywcHTVijLTU2AHPqkIuqWazdsIKFcCy0J+cF7FEjsSxQSEJ
 MsrA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpzbfno+JcCwSPsiOyiMaH+mBOP8R8Eo9UlwefivPMLDZvqN6n4Vtd2Z460z0SuYxYuiyWZOEp2frWV@nongnu.org
X-Gm-Message-State: AOJu0Yymdi+NVXX41rZWfGJHZgKTgSjHJORweyP314zpDvAJp9R9ayyr
 uamYommfEzThwQYvEc4jIts8CJDpUQ/ij6tL4i+VYDpIR9nB6ri2LtbGWQr1usnbIbAthNoSJWa
 af66colbrGRc2dGZMtJEN0WG6Q6YKrOcgZi0N11OjDQ==
X-Gm-Gg: AR+sD10/RfTpqgBeJqB5D1YpbWV8ELmBmGbQbkiZc7mzheWZW2j8fmZgulVqyay9PKN
 uI3Po7hYQFbfxfjGmsKOxyRoimG3s1Av+L0TZwuZ+/Gc6VkBd8ibpPU09waL4Zrqe++FMkSqRtA
 P8hDGsr7RiAd6P8lUNSxm9RQDR7rQJ01tgDE6FT/3tv3+gYKX/JnAF2+bxkWsSZ+Hica4DC3LFH
 S8R8YInpDWIChTGTeMvL1iSbhywy2Ft7r/VuXvLelpysrO+iKwY4WaBEyRPpvN6Q9T5+m9iS5Tm
 hsfNa0vvHtaFZzgUnajI2RM00s4od1ixkTee64lw01Jw0G/Qj4DpuTjl0fN72tJ/T52j0Thd0Tv
 X2Z/+t9bblC47JyRFEUCe+BKib9+rbA==
X-Received: by 2002:a05:690c:23c3:b0:80d:66b2:852 with SMTP id
 00721157ae682-81f69e3c5d1mr22464207b3.44.1785145381144; Mon, 27 Jul 2026
 02:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260614222131.5795-1-imaginos32@gmail.com>
 <CAFEAcA-GGP6aALn4Az5By31q1R3d75Mm+p_YXN0y=tO3GxDYrg@mail.gmail.com>
 <CAFEAcA8zLzVLzTq-EJQ9+OpxytMdPuFkUbOF7xjmY0JrhPhYhA@mail.gmail.com>
 <CAMvPwGpaYiE0uwY6oVJjxdoVwGf8Mxr40o_m+PAhdZqqcShf1g@mail.gmail.com>
In-Reply-To: <CAMvPwGpaYiE0uwY6oVJjxdoVwGf8Mxr40o_m+PAhdZqqcShf1g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 10:42:49 +0100
X-Gm-Features: AUfX_mxx67fGGJifqxDU2DvcQ166qe0p3xyKUN5CLsJQysQ49Xr6Ir4PeSQiyN8
Message-ID: <CAFEAcA9AMaK0CNQkWur4Cg=Uwx0RDBw87m1fkprD8_XH4pEiUw@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c: pmbus: NUL-terminate strings received via block
 write
To: Titus Rwantare <titusr@google.com>
Cc: imaginos <imaginos32@gmail.com>, qemu-devel@nongnu.org, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-arm@nongnu.org
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

On Tue, 7 Jul 2026 at 00:01, Titus Rwantare <titusr@google.com> wrote:
>
> The adm1266 has a strange access pattern for the MFR_* registers, I'm
> creating a series with the patch that fixes it, but a quick summary:
> the data written to the register is the length of the data to be read
> back, the actual string contents are read only.
>
> I'm sending the patches that update SMBus and the adm1266 up.

Did you send those adm1266 patches? I can't find them on the list.

thanks
-- PMM

