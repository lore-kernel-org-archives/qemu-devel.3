Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DA8EA3C21
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmDd-0001CY-4g; Thu, 09 Apr 2026 06:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAmCZ-00010k-6S
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:01:36 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAmCS-0006sl-SF
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:01:28 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-65032e9cf01so630043d50.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 03:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775728882; cv=none;
 d=google.com; s=arc-20240605;
 b=ilw3BhbOKAEadslZBJr0PiV6+kdiVwsLt1qo7IfzOklRkHR+w4MlcIF80D/T1kVJtU
 hAaO2YQwzx3gLkLHO0L5p+/oNrRzDfo6OtL7DERVhrmfuLsJaJf+vU/1B/T7Sd6IcI82
 8MIaUIf4BiP1gU2OdtORhyr4Azs1c8m1XfNJr6eVHxIbalMWUO8lRFuZhWURVDS8b2K+
 KoQwIX+KvRFoBz1XPHwYuPMUPxMvS6MRGK1rtp8CLwt2nF/1sqktID/O/oqGEyltl5Dp
 luySYznmQ5txziOQVfKc+MC2uZOtua87Gda/40ej4c3k2TB2QYJA/mTDDCgSO6WM9zGQ
 Cf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xYdyAJ1ZBVzWNAlvsnmeiUZEob1hhv0ZSCbc1WMT93M=;
 fh=JXvZJDaVkVWOnflwW69YBz01iw7i6OeI2P6voW+7aI8=;
 b=dGVQgPXRsYiRT6grdEOaRTs8bDtvMdyLg3s//eougZPFTHpy5dgOypjqRdVq/Sgys/
 7lyMbAHHbQA0AnIxYhMLDAwoFwcBQ2tA4n4xVzN+XHwLoHbRPdPTzuzcrxmTYnngq+UW
 pu2eiAWdjpKrngjSRy6gtHn91ml30v5hgYswdRj+Kx/lmHLJRdMfxIo+YRhy9YZ85Xsq
 9dr8aUngSzlPnFWucjO0AbRx2vbTjY4AqRtVzQclz/AZ0GV8suz11vkYjKWMsT+Wyd/l
 IqGx+gWZDn50ECSb/rRVgxhhyDbEJa7kbJAc6i/CST2/xuEhdo8f1NztEIVMLIikz3hh
 Y2gQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775728882; x=1776333682; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYdyAJ1ZBVzWNAlvsnmeiUZEob1hhv0ZSCbc1WMT93M=;
 b=ITTbm/D4OFYfZ5ZVSMih36tkrBwUWTScOLBvC7mhloBUZV6aR3Kf9Hj0ZR/zUZp28j
 O5Uw9GegU+7AqYPt1aeZE5aWh52a7lX62/cTkKXCvFcEtt6eor4LV/lOR/ButZgCGQdQ
 qhwdYMPeG26KO0TXum60C9tUr2wRhnZinDofrNtBiM99XV5upoDMI07X/1rxywlTDbwV
 cG0Vtemt/ADDGksiNCqdyhkQ0tE3QEskHUQ4LFfdPDfx7OV+CqieII1oCU2ibHoHAeDq
 pbrsQ+bd32MPomk6zo/rYrGCZXwpsG6ad0WiQUH/B6F2dgsGDvFKdjgHH+ITzxhhCdW+
 k6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775728882; x=1776333682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xYdyAJ1ZBVzWNAlvsnmeiUZEob1hhv0ZSCbc1WMT93M=;
 b=IsUoF03NhXUsOdMiMhOd47Y0PCzWfJng7UAWoigqtoHB1QXEwZK1hYoPEny0W4jnEA
 MQ74YxiatTkR5cirZGkyMSrTfu05X0je6/RLng6zc9eM5Ysd0+wYa7Auu2IrG+C1bq8j
 9+LBkNJDgQx0FH0KuoHb15Eb/DKP+1gkajFrOkK+Dd0CMwQO3YVCQ2U8yYQFgxsfiGcI
 KDHZxD9Nv0RAJyrUhS8D8uRU1anUmiNjPJc0Q5pdDr5KQyk0rTn8fNnDYRETsymuNoh4
 WhPFntdq7pAK9oGuPVhgqcL0/5g+bDhkaBmEKI4aTakvNNVgrUge705ClJ6R2y/C0UL0
 hAhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKCpm7U7fMxH+w30BOgLCMSqQJ4TNXeKMyL4sZHFOGYIEkL8jEgMXdogWPCAES29QqHfaVq8Pwjs21@nongnu.org
X-Gm-Message-State: AOJu0YwJs+mnvd8fyXX0kUhCnDG+V3nAM+wloja9j7ADeo4aAJkSOfll
 qgEhX07uSAVQID94UIU5XvDAvukl4zMTQIxkneMucipp7PDY2uORYm4xm5YXDdaxKnVCjTssHMO
 lRqqOyTU2Rt2K5rfQnnTt8STJU+BC5YtFvbffhRIAjQ==
X-Gm-Gg: AeBDievCFJd9ji1nIf4dGf5plrovvrzn6fghkpJYKInktYQ0o4QpdvKUjp93rA+1uH3
 NZk9MO7oPC9GLEMqkV7mvxbOW0XaI6JS+Up0ZHpy5NaNW2BfxLFCXz9tGEGShiim5GuLLxslEGV
 oZ+uF0rwgkViY+5xzQ39qfSCjuvCc4BJ00rC/KyuZAkZMuP4YGOAe8nGaDVkh5NWYkMwIFgBDd6
 hxvxzDpMC8XKceiYGnGycwH2Vooa59tW5DhQAEX3rFob9IuJa8Oi2cgeuDDL9gJpObIUqRAWU+3
 pYo++xW8+SaRz0Y83zp83d822mJBSC9VhCAc+4iSuLKWZ4oaIt4se2Qn5RD62D8RwnQ=
X-Received: by 2002:a05:690e:1c1c:b0:650:5316:1756 with SMTP id
 956f58d0204a3-6505316228bmr19792260d50.57.1775728881898; Thu, 09 Apr 2026
 03:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
 <20260409-fix-unit-address-v1-1-946840930af2@iscas.ac.cn>
 <b7273509-0161-4b2e-bf4d-28b648f71209@linaro.org>
 <18a3a770-9d57-47d1-9edf-ac55edccb8f9@iscas.ac.cn>
In-Reply-To: <18a3a770-9d57-47d1-9edf-ac55edccb8f9@iscas.ac.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 11:01:09 +0100
X-Gm-Features: AQROBzCVASMzofaqQYGDV-WL1MRwPfn_32V7Z_sr4ZIpjr7tv-upq2Ck3Hldy7s
Message-ID: <CAFEAcA-mTY3VksBcANok4+49UvVDv_w9X6ubKooQZ-kvWZ7r1Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] hw/arm: Fix unit addresses of FDT CPU nodes
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>,
 Stafford Horne <shorne@gmail.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 9 Apr 2026 at 10:46, Vivian Wang <wangruikang@iscas.ac.cn> wrote:
>
> On 4/9/26 17:39, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 9/4/26 08:40, Vivian Wang wrote:
> >> The node unit addresses should be based on the reg value (which is in
> >> turn based on MPIDR), rather than some arbitrary number [1]. Also, the=
y
> >> should have been in hex, not decimal, as per de facto convention [2].
> >> Fix them.
> >>
> >
> > Maybe worth to add:
> >
> >     Cc: qemu-stable@nongnu.org
> >
> As Peter Maydell mentioned in other replies in this thread, most
> software don't really care about these node names, so I don't think this
> needs backporting to stable.
>
> I'm unsure if this is still worth fixing then. Peter expressed that it's
> not something worth fixing.

For the virt board, I think it depends whether the spec really says
that the node name must have the MPIDR in it and that consumers
can rely on that as a source of the MPIDR. I hope it does not.
If it's just a node name, then I don't see why it matters what
node name we generate as long as we're not generating the same
nodename twice. We're not trying to generate DT files that are
intended for submission upstream.

There are other places where our nodenames don't match the
conventions upstream prefers; I generally prefer not to mess with
the existing working code in QEMU unless there's something actually
broken about what we're doing. Thread from the last time this came up:

https://lore.kernel.org/qemu-devel/CAFEAcA9OWDiWh3S=3D0Co7Z27EtOp-1B9H7FxyQ=
y1T2sFnTyNdqA@mail.gmail.com/

Essentially, the set of things that it makes sense to have a
convention for and perhaps to validate for a hand-written DTS
file is stricter than the set of actual requirements for a
generated DTB, and I prefer not to potentially break some
guest code that's looking for a particular node name purely
to bring us in to line with conventions intended for
hand-written DTS files.

thanks
-- PMM

