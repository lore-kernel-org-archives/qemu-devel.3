Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D275C88E66
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x65cS-0000xU-Qu; Mon, 14 Sep 2026 08:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x65cR-0000x8-4P
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 08:17:07 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x65cP-0001IB-Dy
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 08:17:06 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6714af30a2cso719412d50.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789388223; cv=none;
 d=google.com; s=arc-20260327;
 b=cm4HLGgFgPs+P/t+3yS9Exn4CGYzyQ5dUOiyD9omkHqmUOan6OhWSPDl+9ZTMYRS1C
 Q/V4qrEMp/Ax1hXxiu0oUPn1ijDRlYnI155TbYwHaeA1+W8EuPFVcjVDnVbf3Mzwqc+U
 W6EngrvMOQqV9fvDeEgfetSyfLr3Hal/A9z21be1/KZd0CMMSRQ+a7NvwAsOIFfFKdio
 +xgFQAATP3SAaSiDcfQDrL9pTwpriirmEIDGYX1YPJood0/mlxdv3FmsRVWffljGScL4
 EiIZc8Y+TPC+/0lUSTuyqhad7QRnYwJ3NG6CeA729rZ3GK4f7koitLJQTeSzrFYvWyuN
 EOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JcaGD9CD+W/ivWBfEUgg4X0MaxjX3d/zpeZO65l6kuk=;
 fh=QyNjYlMI7VGOmz/hJIVWJx6bokmCUdPoLcl0N21/7DI=;
 b=anpwc4u/3kQNZDqb5y6K3xF9Q/fmjkElfYrJmi7l3hOV/9+3Y/aTef0dPHAwr4yB2n
 9GX8ONy9jeDqVRCLFdSc8OqOqRL+5bPnviuYw44Hb4WW16HMvmb0TZcXNq67/7o+OMkY
 N/Kd9mMl7NgFKXK4rlsUQWWyY34jFssgGwm/na4ynPrtsJXtDbtqy3vK6DUPkEWQh6sD
 eKiC3rtAGmQhCOgja8Bqzn7sj0UoKG8NyFleT1b/3FScRWXwy3QnbrPHnuhssMTKlvSI
 cyO9mYAKQ81zlSux1y9/QjP0Agiy8gqKzaTBQ3Bo7K/+e1mTgb1L4iVwl7r77hLiPMmE
 EQlA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789388223; x=1789993023; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JcaGD9CD+W/ivWBfEUgg4X0MaxjX3d/zpeZO65l6kuk=;
 b=GxmUBswfqvopg/qpRRQ47x1a90hqeNwOZQm/uwfTeT4GAJCtTwZMgHrn6BZ+mVaxU1
 8zz2ya5djJudD3HE3DHA5+fcB8mVAQy7AbmDTA71/KLpHICPq+DgxOI9sN323gRkYi7E
 caR43/gd43AlYVzl4dy1PFzYfO8cAoj/vzX0NCEWIwGKOrJp6XoSxif63fb6I/kdsawN
 1K5e5AgLSV5Nz5ZBZVmH2HKWHtsg5ZTU064UWAaexcBWEoCX2RcUhyaI2bZJf2Bpe4r9
 o9TcsnFUjeY8ThBTsocbE86EECgibG6uYEYm6lnaP4o5lp+28WVUdvXSmcil3u1vcJv5
 fhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789388223; x=1789993023;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JcaGD9CD+W/ivWBfEUgg4X0MaxjX3d/zpeZO65l6kuk=;
 b=BXGM3xh8TxEnsp5qlb+NA9mBks32mfO6AtNmUKGjBnOOA8Yx3nuUTsD0cgsj9OU1Dt
 0NEHCML/h8vtyrKu+S0dzhYxNvPyWKGx8AFJLuMn2DXUZarM8x2vr2IOUewfHvssZSGT
 uNkohd3vf+RZXA37paZdxOKTttK6pKsZrLTUu29T57C1L5fEeTM5fPeb+XlFIOxyIn3n
 9mbfl4ogYb1cdBnaebTJieXR3VoMXIeuzOxmScOxac5chrD3bU9/YJpvXFXAvb3IGF1U
 6/M43Fumj1GnqsiaWbyoN/B+/gtDIdyPgXiVBTESXvXQwN/DKCTtWCJhn4XAto4TOWcW
 0C3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzW6YeecDKEIujj9pqhzXOR67mhcl5vMou104rqrN5j0pt7KoblG1FlkCZ3Dp9Oe5C4+KmabEt6Z9SD@nongnu.org
X-Gm-Message-State: AFuF++n18eu89LaBXMKkZ4159wGGnW1FvBTuOimX1v7lMw9+X8Mi1hte
 LBBAnIghc3V+rXthBl/B/Ehf0TxtlG+NqGRXWIo1f7AP4mOwS/aadwpL3Zp19Fy2V0Qf/BTqkJh
 zE3RhSfOzZhWj54y0GftIne7mh82kuF1RDcbZm15RuA==
X-Gm-Gg: AYBFou0w0oBC7whH3i2YthNoMWXLQZl+F4PeaNPVAAzyZEkP5/l19NeRjeosfKLcNRy
 zyRVzgCVkUwbxwQu4cPNTW4x+b+AbT/Fg9E5q4d5EqTp0Hq4deVe9TARc4/DtbCLtRTpa7Au9Ho
 DERsav6Gov0hp5eSZO1ph7FF91uL5sMH/FD1l1hF8VlBRvKOOdJqG/cWKZ0IDT+1OV/rHYFvLmm
 GfTOk+QMyxd6glhFugVLvSkvhiZCC+V105t6FprDRN7Dt2hlGCpKfDft8KZB1k/AYTt8vpoPQ1B
 DNLp+FxmMlpDWqKNjP/lxb9IwrNH4bW7qzKbUFZA9xdYzHTAumQvjGvUPl9Wllk9IivGb0ZYtFS
 tV5MYcfJn6SR5lZZzNvwvF7CTRVma/Rfl516X+M0=
X-Received: by 2002:a53:cac8:0:b0:671:1a5:c561 with SMTP id
 956f58d0204a3-6714e1bebb6mr331988d50.99.1789388223248; Mon, 14 Sep 2026
 05:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260909144151.26803-1-sebott@redhat.com>
 <20260909144151.26803-4-sebott@redhat.com>
In-Reply-To: <20260909144151.26803-4-sebott@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 13:16:50 +0100
X-Gm-Features: AcwNN1VjWCl3r1TgFgbFV7Y0VJR1-LUKemc_Mp9GXe9OwSykgUQbU7A652Ju89g
Message-ID: <CAFEAcA_ikXxw+J10+3mbhJxa_KoAd3PeyT+0khqVo_UPOJL2Cw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm/kvm: get demuxed ID registers from kvm
To: Sebastian Ott <sebott@redhat.com>
Cc: Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, 
 khushit.shah@nutanix.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

On Wed, 9 Sept 2026 at 15:42, Sebastian Ott <sebott@redhat.com> wrote:
>
> From: Cornelia Huck <cohuck@redhat.com>
>
> We now have the infrastructure in place to handle demuxed ID registers
> from kvm. Use it to get the values that kvm emulates for CCSIDR_EL1.
>
> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  target/arm/kvm.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index ed99be7fd8..1230acaff0 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -244,6 +244,33 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
>      return ret;
>  }
>
> +
> +/* CSSELR values supported by kvm; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
> +#define CSSELR_MAX 14

This is a bit misleading as a constant name because that 14 limit
is KVM-specific, and doesn't apply to the architecture or QEMU.

Somewhere in here we should document why the KVM number is different
from what QEMU has and why it doesn't matter (i.e. that neither KVM
nor QEMU currently handle reporting separate MTE Allocation Tag caches,
so CCSELR_EL1 bit 4 is always 0, and that a Level of 0b111 is reserved
and so CCSELR values 14 and 15 are never valid and will always make
CCSIDR read as zero).

> +static int get_host_cpu_reg_demux(int fd, ARMHostCPUFeatures *ahcf,
> +                                  ARMIDRegisterIdx index, int subindex)
> +{
> +
> +    struct kvm_one_reg one_reg = {
> +        .id = KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX,
> +    };
> +
> +    switch (index) {
> +    case CCSIDR_EL1_IDX:
> +        if (subindex >= CSSELR_MAX) {
> +            return -EINVAL;
> +        }
> +        one_reg.id |= KVM_REG_ARM_DEMUX_ID_CCSIDR | subindex;
> +        one_reg.addr = (uintptr_t)&ahcf->isar.idregs[index + subindex];
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +
> +    return ioctl(fd, KVM_GET_ONE_REG, &one_reg);
> +}
> +
>  static uint32_t kvm_arm_sve_get_vls(int fd)
>  {
>      uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
> @@ -454,6 +481,10 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>              /* Read the set of supported vector lengths. */
>              arm_host_cpu_features.sve_vq_supported = kvm_arm_sve_get_vls(fd);
>          }
> +        /* Grab demuxed registers. */
> +        for (int i = 0; i < CSSELR_MAX; i++) {
> +            err |= get_host_cpu_reg_demux(fd, ahcf, CCSIDR_EL1_IDX, i);
> +        }
>      }

I think I would favour being a bit more explicit in code about how
we're converting from a KVM-ism to QEMU's underlying format here:
have this loop go from 0 to QEMU's maximum CCSELR index (currently 15),
and then have get_host_cpu_reg_demux() handle 14 and 15 as "this ID
register value is 0" (with suitable comment). At some later point
if we need to handle Allocation Tag cache ID values then that code
will expand to "read cache index values 16 and up, with suitable
fallback to 'is zero' for older kernels".

thanks
-- PMM

