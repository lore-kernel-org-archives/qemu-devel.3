Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67CFCA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 14:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umvou-0001Xg-W0; Fri, 15 Aug 2025 10:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umvos-0001X3-Kg
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:54:14 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umvoq-0006Ry-Hx
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:54:14 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e931c858dbbso1956277276.0
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755269651; x=1755874451; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fvfeZwHHBjyuO32X9FpJxi0Tl92QFHSaBaQOeCudLDQ=;
 b=d65hOC0uE/L3Z/9VOr7Q3o6UO/YJvBsAUrg/GoZ7hT1+PJ7ns9BAlQ9/Zg0eMl/eAo
 M2gtnAvDNd/UPvhRzEAXJYza2BIsnDUbYrZbeqTRLRems+VdzVDnGjBaqLr/0JSkgksY
 Hozn1SMu5X4OE/YFkOPM0xam38WfnSiTUUpA/DkOuyfFzprGzPtnQdHuNGcPoOpD13fj
 W4Va3QLJVhIpyl7U2TZejQlScM+iFGW2rQajBtkPTU/fyquj0JkgngcT3yWBhTmI0xlm
 VirqWz3yG85b2uT2BXrIzIEz8TKp2q9ERhp52wfGK/goYYKWxQqAEDHDHTDDmQo133KP
 dTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755269651; x=1755874451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fvfeZwHHBjyuO32X9FpJxi0Tl92QFHSaBaQOeCudLDQ=;
 b=Xztnn+ekU/3NGnO/EpF9qzpMyqG/lTm63YF66T9M0bBibtEVjxBRDyyidJLVAmJ1ut
 DMM7zfHMy6Du5srImdUtKx17ON3HjsxaeBWG1so1y2REdhX2k9gxvW13vaRYzNjrmADR
 ++j20YPmBi7w3c7HKeTlLhM4NzNNgsTvZg/St+9JWKHpBy5I8fJStF9gZsGJZmbNs3iV
 pYgQRShAPbPUoTIGY54lvINd7i5gcIkI9AedEqcUs+FFRi5eu+RoQr1zDB5i7Y13KtVW
 jauOz8vJ8ql3JhhRoqYxNKMARW+cqDXJ/h1wnpw1H08v0U1N52P7Nk3sSMLkGxk5fuMc
 RSdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+/+XbOrRT1Xl8qq4SqnDo0w/sggrBlA629/XCULNsgCkxXQB7xduhGULvpzcd0LPQtDFsCy1TKp1z@nongnu.org
X-Gm-Message-State: AOJu0YwgDG5JfIIsnQna1DltBYqqf4+2dpKlsNrCOUaSENbJsqH1l7PW
 QUx+y86PGeTdWgL/XTeoDZcKgAxwNKzRQLmyk28LpneovRPr1Dnh72it/2v8aJod/GKbohO5Qtn
 BOSgzJnvDpvWpX4NvpE0SfCO8iZXFXYTw0GYvgd/bhA==
X-Gm-Gg: ASbGnctpoG1lcTHnTxbesOzMkh57UlVABxmoDj+LQf7kEgoG+9HWOi7fzN482P0VXyU
 YW1gaRA1dnKa/224+InRqPExSqRTsmIUmgFwwqNNb+XcTUlu1ntQ/s5qOD8v0R2VGzhHsB0vENj
 Y3HTAMN9a/BAthWDtZ9tREnHqi/z7vAEm6xzvChC71NwtuCr+yQTa//ZbSUJ+4vze4+0c9RaIKr
 7gvmYtA
X-Google-Smtp-Source: AGHT+IEsBLer46kf9vbvrEGwQFmIAPaHps/8pAOOghqqKZ+0ehKAM8YP8UQUJ9fWphpKFTlGj9mVf2qw/ueD+mljhR8=
X-Received: by 2002:a05:6902:2b01:b0:e90:6d24:6741 with SMTP id
 3f1490d57ef6-e9332473822mr2750647276.31.1755269650855; Fri, 15 Aug 2025
 07:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-5-tangtao1634@phytium.com.cn>
 <0b38d386-9d8b-46bd-a981-718cc7281eb6@linaro.org>
 <f74b4d64-893f-4b39-aa95-4e9ff52edebd@phytium.com.cn>
 <4ff26d30-3b0d-4392-8bac-698ecb0fbdde@linaro.org>
 <CAFEAcA-imgF9NLPWeXfE1JRL0gaKpVyfbbNKxojHDVz0t7EBKw@mail.gmail.com>
 <0c95f7de-ffbe-4787-ae14-6039bc4f31a3@phytium.com.cn>
In-Reply-To: <0c95f7de-ffbe-4787-ae14-6039bc4f31a3@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 15:53:57 +0100
X-Gm-Features: Ac12FXzkQfvxibV9G55eklQwhWGGUwwGvUTYgiC3We9iJBp_i86y--_8Ce0ZSSk
Message-ID: <CAFEAcA9MUhRX7yVx23Aw3FRPAnxNn1PifSjR3hJ2eK8KwFvXJw@mail.gmail.com>
Subject: Re: [RFC 04/11] hw/arm/smmuv3: Enable command processing for the
 Secure state
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>, Chen Baozi <chenbaozi@phytium.com.cn>,
 smostafa@google.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 15 Aug 2025 at 07:02, Tao Tang <tangtao1634@phytium.com.cn> wrote:
> This leads me to two questions on the best path forward:
>
> 1. How should the SEC_SID be propagated from the device? The only thing
> that is certain is that the hardware transaction will carry a SEC_SID
> value that is consistent with the manual. My initial thought was to
> extend MemTxAttrs.secure to carry the four states, but I am unsure if
> this is the best approach.
>
> typedef struct MemTxAttrs {
>      /*
>       * ARM/AMBA: TrustZone Secure access
>       * x86: System Management Mode access
>       */
>      unsigned int secure:1;
>      /*
>       * ARM: ArmSecuritySpace.  This partially overlaps secure, but it is
>       * easier to have both fields to assist code that does not understand
>       * ARMv9 RME, or no specific knowledge of ARM at all (e.g. pflash).
>       */
>      unsigned int space:2;

The SEC_SID is the information in the transaction that tells
us whether the device that initiated the transaction is
NonSecure, Secure, or Realm, right? I think we can
straightforwardly use 'space' for this. (The mapping between
SEC_SID and space can be written "space = sec_sid ^ 1" but
that is perhaps being unnecessarily clever.)

"secure" is (as the comment notes) for the benefit of code
that doesn't understand Realm. It should be initialized to
arm_space_is_secure(space). (Currently that function is in
target/arm/cpu.h, which is an awkward place for it: we
should probably move it to somewhere that lets code that's
not tied to the CPU use it.)

> To accurately model the SMMU, our smmuv3_translate function must
> ultimately use this SEC_SID value. Taking the translate callback
> signature into consideration:
>
> IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
>                             IOMMUAccessFlags flags, int iommu_idx);
>
> My understanding is that we can use the iommu_idx parameter to carry the
> SEC_SID value for each transaction.

Yes. You also will need to implement the attrs_to_index method,
which is what converts from the attrs in the MemTxAttrs to
the iommu_idx that the translate method gets passed.

(We do actually have hw/misc/tz-mpc.c that uses the IOMMU
APIs to handle Secure vs NonSecure transactions differently,
though it's such a long way from a real SMMU that I don't
know that it's a very useful thing to look at.)

> 2. What should we use as the internal bank index within the SMMUv3
> model? I see two potential options:
> a) Use the existing ARMSecuritySpace as the internal index. This would
> require conversions from the SEC_SID carried by each transaction.
> b) Define a new, SMMU-specific enum that perfectly matches the SEC_SID
> hardware specification (e.g., enum SmmuSecSid { NS=0, S=1, REALM=2,
> ROOT=3 }). We would use this new enum as our bank index internally.
>
> I am leaning towards option (2b) as it seems to offer better
> encapsulation and fidelity to the hardware specification, but I would be
> very grateful to hear your opinions and guidance on this architectural
> choice.

Yes, I like 2b here. This is what I am doing for the GICv5 --
there the architecture specifies various "interrupt domains",
and there's an obvious encoding from those to 0..3, which is
what I use to pick the register bank to use. The MemTxAttrs
don't quite line up with the domain index, and they are something
we need to figure out less often than "which register bank", so
it's OK for that to be something we do via a function or
whatever.

For the GICv5 in fact I have opted to create the MemTxAttrs
ahead of time at the point where the guest enables things
and we know what they should be (roughly, the device state
caches various bits of info about the configured state
in a struct, and one of those fields is a MemTxAttrs; so
you can pass cfg[domain]->txattrs as your attrs rather than
computing it on the spot every time -- especially since you
need to initialize both .space and .secure this seemed
nicer to me).

thanks
-- PMM

