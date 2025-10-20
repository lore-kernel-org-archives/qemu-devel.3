Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F41CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAp6y-0006Y0-03; Mon, 20 Oct 2025 08:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAp6o-0006PL-Rc
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:35:31 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAp6h-0000UF-Qy
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:35:29 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63d8788b18dso4185769d50.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760963722; x=1761568522; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vfST4r7ZUA1mtVLAp9ex5adyjzQZmnaMFdXg0DZoOhM=;
 b=PT+e6vbFtTTtiYzwaO1HpqoncwbT/TQweflKJDeAgzJsh/utDhQs3hXiM5noC0Bz7f
 DDPfvaQnzkzz4ibOQeMFM1zvDE12+jDGoBZV4Q7Tilb9QsgY/1MhcwxOIk4BpzSjCPdo
 GvKn/fEDDf+Jg4qxE/KnLwM4/h6HOaa96IQKnUeb50FobVF/NB6kU0UimFKffqwvirs9
 tZBpO9lMIo2edun1ea9srNxzAh9NOU3V/UbTUWfC1/0+a8+vJI2a+TLiaBAOYgvoqAay
 +9kOc87mbvHIwTWkEojDjoF9G9K35rFSLyLR2S1SxQ+OzBrjACKnaajDmED97fmt/1nJ
 5f8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760963722; x=1761568522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vfST4r7ZUA1mtVLAp9ex5adyjzQZmnaMFdXg0DZoOhM=;
 b=wddRUR9kr3Hv9MH2wVPXMsqv3MXLchptrC+AmQ0/U27bdyXPhWT29J7SrIHiWyNXCX
 Zuhjrt5Oeu1eFYEOw4IjB/APVA8Ap0PlceUTd/V6ovmfImpnDj7dD5toS2Qrjm4MamXU
 h4NoYfMIUyXBSvk7KF4wfrQTSPBbKoSttW7vVNDuJAFI/OfPkfYdbCHtdhPOK5Am7Lqd
 KM61SWk6fNOYPP8BFvf0vvP3Bv/cwIaxuqweYRfNFRR310X/Ne3OFuWXEPQAsLk22ToI
 a/1P/dmM0SHby86lmFrNESoxJUHqlMTrS6ksR7JYrimYrdDVG3skp85RwPfAfDu+b/DW
 8vrg==
X-Gm-Message-State: AOJu0YzE2VR/mDHpyjVpJHfgTrvckExRIzVVdPbVQpyaoVer2wcT5qZW
 R4eYp8YiANKMB2WMCYCGneYiLj9XF7iHpTO6ejwngbkLXbRD/S3ocnpDSb8R9/Wxe2b+iy8+6FX
 jqPzgEfGMpGOKF9v2H3x5aFrVQ/NBlRBtCddWZRJ0ew==
X-Gm-Gg: ASbGncsVlYPSpzG8WddOK4oRTMblO1xlhK7x7aX+LC1dCnK1DIHSiRdGPdVRNln2jaO
 8ICFEX1YNVdwKL87wv3Ds6PvZ6UgLy3Sq3aFKFL4goIqwJBSFm1/InzYHWzQoejJmQ6byj0bSH5
 U2117ItSQ7LhyfoCfAtwx6gVl2eZr/pqNBK9UtaciaaLXDIQFHoZfJte4xsVR6N5JiX0djd1b+j
 /YaRX8z5IVPUpTIJCd5OOcY9DJYdaNXxq4FtoBTHvJ079nVvDp+FahLKePqpw==
X-Google-Smtp-Source: AGHT+IHfZBg0ujGgIPBY1Z16mBAD/R/nScS/e0R+yZ9xqByKwJ95OGvGBb1LmR2GL4nXoaJ6pwqtYr6afDdgHu5k1zk=
X-Received: by 2002:a05:690e:1548:20b0:63c:fabf:e8d0 with SMTP id
 956f58d0204a3-63e161fc56cmr9291471d50.64.1760963721724; Mon, 20 Oct 2025
 05:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-15-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 13:35:10 +0100
X-Gm-Features: AS18NWDC9khac6BSWxIEOMKzwD3frwFpK6lB4dPYLA47X1u96rTCZFjQdrfOvzY
Message-ID: <CAFEAcA_4SNBhe+p6ggpr-ZjKuYzyk02A2=66S5Y4Zp0CPmsS+w@mail.gmail.com>
Subject: Re: [PATCH v2 14/37] target/arm/hvf: Assert no 128-bit sysregs in
 hvf_arch_init_vcpu
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Tue, 14 Oct 2025 at 21:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> HVF has not yet enabled 128-bit system registers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/hvf/hvf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 0658a99a2d..aa42fa09c3 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -897,6 +897,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>      env->aarch64 = true;
>      asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
>
> +    /* No support yet for FEAT_D128 */
> +    assert(arm_cpu->cpreg128_array_len == 0);
> +
>      /* Allocate enough space for our sysreg sync */
>      arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
>                                       sregs_match_len);
> @@ -920,6 +923,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>
>          if (ri) {
>              assert(!(ri->type & ARM_CP_NO_RAW));
> +            assert(!(ri->type & ARM_CP_128BIT));
>              arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
>          }


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

