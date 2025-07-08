Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F6AC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 19:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZERR-0007KH-Mv; Tue, 08 Jul 2025 15:57:26 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZBOa-0008Jt-22
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZBME-0004Ql-7C
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751992626;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCc6X7dKrB7u2+4+jJD84N05Emla9+M/j2i1RXjqv8I=;
 b=UdVxjzFGhLVadV/kqfXFT+t+ftIROHnCvLdf58HcRFhGQjfFKCIE0ssf/BSc/8KgWXQKzr
 +1f3Zs5RZ+wF9ppajCnwvlsPIwxFTs1KEqAORPCDkCgcC65+kVS0gzdZwlkhrxqWnM/vwd
 mmefRqlR9+KFNCudiwu9qsbKPVn8dZ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-OfC5L9VjOcaQv6ISvCK11g-1; Tue, 08 Jul 2025 11:58:09 -0400
X-MC-Unique: OfC5L9VjOcaQv6ISvCK11g-1
X-Mimecast-MFC-AGG-ID: OfC5L9VjOcaQv6ISvCK11g_1751990288
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so1666122f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 08:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751990288; x=1752595088;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iCc6X7dKrB7u2+4+jJD84N05Emla9+M/j2i1RXjqv8I=;
 b=B83CRbt9M82/g7OmmCIa0aAfektLjT0GvTmLE5Yqga1R/FVj7dKgldkfDDLviimejv
 ENT16pyp41aQLVFfgvgrYjDqz5Q8mGZ2TaQrVkWD8cnhw4SUQHUe5Hy2rtgVC4QPa9EQ
 +vK9HIk7RX/BBhpEN1ciGuTHRMOvvvnyPwUO9DGoBL3HNVNMcjT/MpU6QpgY7n5dhmVe
 Wp/dC34oP95EuTwz7iUH0WlyQaVNa9Mi+ZpLruMOFqgh2qwdveEmUrBW67Kd/DXgxpe9
 P0RTuU+zWSy2yGEGcNjjuNwMgCUvHwNJFibC+lvG2wKY6ZIxgMhxV10CyWnE6WBzWCnt
 iEIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6QG5CpYfKnOypiRmVpeWKOSK4xd/ViOMWyPoJKPhUOWrV9vXIu1eY+4CsYsSK+y028SjWp/ENyBeM@nongnu.org
X-Gm-Message-State: AOJu0YzxQUTZ7KOmDEYxilR5t9Q4VSH3q5fp/c7XE5u0jIVw7ShIK2WJ
 Y0h9Yi+xoG3k6OEor5elbxuxdT1L0tKtwgQ5wItcA5LbRaAAv2KpwW94nTHr5xvKCV271i4MpwZ
 oNJED4YnMZlyo2srZqNLUYbW/ZUh9NvnOPejG5y4AqeG5TPWtT93uahrS4SwKhWEO
X-Gm-Gg: ASbGncv/RPPClEPojrdmANtc3ZbrZv52q8DPo3Xbe5P6uox9VKsaqUtyo7htBxrwCVa
 rRsQGwDhRgCyxuI2F3NrA31tAteObDyZl9AXxaKkoyfzXzQNnFXD4CtAXlIG7qiQnjVpSdNKk56
 jzC5s94RsANSIwcyV4TWMyGKQw3qzYldE/jJcfNDbOFojLCYf6x8xNgMKycLNDZSUcNdADGLkpX
 LGZn8X5jDyhAojyfJh70ZppEmuWniQMb5v75aCEzrKDbNiaf7qv6ZXe2SJfkCvP16KYIxM7zdX1
 WE4Fz3oqcA35ZHc229W6g0QqxrWiFNup0Yr8jpo+ILqzjkmQx92FAQijeQes58yguLssGw==
X-Received: by 2002:a05:6000:1447:b0:3b4:65d4:8e27 with SMTP id
 ffacd0b85a97d-3b5ddeccff7mr2910052f8f.29.1751990287794; 
 Tue, 08 Jul 2025 08:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvHa7qpVLByvPoq4yVyth+o0ZOrNB/m1HsZJz8NoB5pw8Y1LeLbrjHx8fm3DY9E0UsevERHA==
X-Received: by 2002:a05:6000:1447:b0:3b4:65d4:8e27 with SMTP id
 ffacd0b85a97d-3b5ddeccff7mr2910024f8f.29.1751990287224; 
 Tue, 08 Jul 2025 08:58:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd43cfe3sm26562235e9.2.2025.07.08.08.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 08:58:06 -0700 (PDT)
Message-ID: <647d17ed-1b23-4ec4-9b97-84aa67717ae6@redhat.com>
Date: Tue, 8 Jul 2025 17:58:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/intc/arm_gicv3_kvm: Migrate GICD_TYPER2
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250708115238.667050-1-peter.maydell@linaro.org>
 <20250708115238.667050-3-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250708115238.667050-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 7/8/25 1:52 PM, Peter Maydell wrote:
> The GICD_TYPER2 register is new for GICv4.1.  As an ID register, we
> migrate it so that on the destination the kernel can check that the
> destination supports the same configuration that the source system
> had.  This avoids confusing behaviour if the user tries to migrate a
> VM from a GICv3 system to a GICv4.1 system or vice-versa.  (In
> practice the inability to migrate between different CPU types
> probably already prevented this.)
>
> Note that older kernels pre-dating GICv4.1 support in the KVM GIC
> will just ignore whatever userspace writes to GICD_TYPER2, so
> migration where the destination is one of those kernels won't have
> this safety-check.
>
> (The reporting of a mismatch will be a bit clunky, because this
> file currently uses error_abort for all failures to write the
> data to the kernel. Ideally we would fix this by making them
> propagate the failure information back up to the post_load hook
> return value, to cause a migration failure.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Looks good to me
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric
> ---
> v1->v2:
>  * fix comment missing bracket
>  * fix reset handling so this works on GICv4.1 hosts
>  * move get/put code to be with the other GICD regs
> ---
>  include/hw/intc/arm_gicv3_common.h |  6 ++++++
>  hw/intc/arm_gicv3_common.c         | 24 ++++++++++++++++++++++++
>  hw/intc/arm_gicv3_kvm.c            | 25 +++++++++++++++++++++++--
>  3 files changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index a3d6a0e5077..bcbcae1fbe7 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -267,6 +267,12 @@ struct GICv3State {
>      GICv3CPUState *gicd_irouter_target[GICV3_MAXIRQ];
>      uint32_t gicd_nsacr[DIV_ROUND_UP(GICV3_MAXIRQ, 16)];
>  
> +    /*
> +     * GICv4.1 extended ID information. This is currently only needed
> +     * for migration of a KVM GIC.
> +     */
> +    uint32_t gicd_typer2;
> +
>      GICv3CPUState *cpu;
>      /* List of all ITSes connected to this GIC */
>      GPtrArray *itslist;
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 1cee68193ca..7b09771310e 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -275,6 +275,29 @@ const VMStateDescription vmstate_gicv3_gicd_nmi = {
>      }
>  };
>  
> +static bool gicv3_typer2_needed(void *opaque)
> +{
> +    /*
> +     * GICD_TYPER2 ID register for GICv4.1. Was RES0 for
> +     * GICv3 and GICv4.0; don't migrate if zero for backwards
> +     * compatibility.
> +     */
> +    GICv3State *cs = opaque;
> +
> +    return cs->gicd_typer2 != 0;
> +}
> +
> +const VMStateDescription vmstate_gicv3_gicd_typer2 = {
> +    .name = "arm_gicv3/gicd_typer2",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = gicv3_typer2_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(gicd_typer2, GICv3State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_gicv3 = {
>      .name = "arm_gicv3",
>      .version_id = 1,
> @@ -304,6 +327,7 @@ static const VMStateDescription vmstate_gicv3 = {
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_gicv3_gicd_no_migration_shift_bug,
>          &vmstate_gicv3_gicd_nmi,
> +        &vmstate_gicv3_gicd_typer2,
>          NULL
>      }
>  };
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 3be3bf6c28d..8e34d08b415 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -405,7 +405,16 @@ static void kvm_arm_gicv3_put(GICv3State *s)
>          }
>      }
>  
> -    /* Distributor state (shared between all CPUs */
> +    /* Distributor state (shared between all CPUs) */
> +
> +    /*
> +     * This ID register is restored so that the kernel can fail
> +     * the write if the migration source is GICv4.1 but the
> +     * destination is not.
> +     */
> +    reg = s->gicd_typer2;
> +    kvm_gicd_access(s, GICD_TYPER2, &reg, true);
> +
>      reg = s->gicd_statusr[GICV3_NS];
>      kvm_gicd_access(s, GICD_STATUSR, &reg, true);
>  
> @@ -572,7 +581,10 @@ static void kvm_arm_gicv3_get(GICv3State *s)
>          }
>      }
>  
> -    /* Distributor state (shared between all CPUs */
> +    /* Distributor state (shared between all CPUs) */
> +
> +    kvm_gicd_access(s, GICD_TYPER2, &reg, false);
> +    s->gicd_typer2 = reg;
>  
>      kvm_gicd_access(s, GICD_STATUSR, &reg, false);
>      s->gicd_statusr[GICV3_NS] = reg;
> @@ -707,6 +719,7 @@ static void kvm_arm_gicv3_reset_hold(Object *obj, ResetType type)
>  {
>      GICv3State *s = ARM_GICV3_COMMON(obj);
>      KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
> +    uint32_t reg;
>  
>      DPRINTF("Reset\n");
>  
> @@ -719,6 +732,14 @@ static void kvm_arm_gicv3_reset_hold(Object *obj, ResetType type)
>          return;
>      }
>  
> +    /*
> +     * The reset value of the GICD_TYPER2 ID register should be whatever
> +     * the kernel says it is; otherwise the attempt to put the value
> +     * in kvm_arm_gicv3_put() will fail.
> +     */
> +    kvm_gicd_access(s, GICD_TYPER2, &reg, false);
> +    s->gicd_typer2 = reg;
> +
>      kvm_arm_gicv3_put(s);
>  }
>  


