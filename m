Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B88C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPQi-0005J8-WD; Tue, 18 Feb 2025 10:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkPQX-0005Hn-V8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:22:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkPQR-0007GR-W4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892139;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ot+fYgSVKyy+rAYXe+wg7VR70oe9I02rM5x2Ee3gz8M=;
 b=cdUAWoN3C9IixDYkPjXuI6S5VB+61OJAvv4HB2bEDktAnLB3qy4CkHVWirWacuAxo+guxA
 0zaTgUa4ouxcZipsY714CACzXjliWKG0+pMjwKeQeW8Ebo6ijVXN0em6jhIHGfem1nJhLJ
 oIXmdRG79utoKyTIrX7o95bJtZGAa7g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-qi9b2W7cPbKSCwLCPk47Fw-1; Tue, 18 Feb 2025 10:22:17 -0500
X-MC-Unique: qi9b2W7cPbKSCwLCPk47Fw-1
X-Mimecast-MFC-AGG-ID: qi9b2W7cPbKSCwLCPk47Fw_1739892137
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f4e6e004fso1659286f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 07:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739892136; x=1740496936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ot+fYgSVKyy+rAYXe+wg7VR70oe9I02rM5x2Ee3gz8M=;
 b=r/mb9gc+kfnV1oUfUsQ64EOZZYnTFzV88O3CBnSJ30LNUl1gM/FMMF0FcTRHJ3BYO3
 nbNkZDAkoRHGK7TX1e8A69xhHOpKX9encUYoMX1Yv52L30MikgGCJE36rhMPxVf4Sehg
 n2YlFCuKVPAL5K2LvSU8NvpzYLw6YXNC38sadoz1lAzYltiBDWjvQgdepMbxkGf6FdsG
 D2BfKfls+PdhcpINJ2u856WAaCEnwMhDT4NOFLJfLdLtQbIijpCLzGi3Tm/NBHlYSU6i
 aiQLrgcw9KWnj3UgoRvJNpGoX/U9uJxaU5ThEXY7+A2bmbsVKTSwEB/buUJ+LsmMsSjG
 4EOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhAag14A+mUKVwaMlN3ZL88n6nj3QUaspEowWgkrsCD+ztlSfAm9JAcXMC6GzeId/NFGcOUMPO3AsY@nongnu.org
X-Gm-Message-State: AOJu0YxoBDawbci8/dy81OPvfPgZdgT6wIzwjHwN1zzYQEhLJU7E4iAF
 Z/6sqKSM+hSHDMX+QzOkcN5+8KtENLKJViRk9EwQbKmCpoQ1YopTWDXxja8ZrMJy0eRGepkIgv5
 yQhc5Hf3AAbQ6xc5gOyInTW7ZBvfGrcBB0KxYBQSkfKIOccn2Ozgn
X-Gm-Gg: ASbGncu/ycTpFtTG5irScm7bDI0ssmj69c5rvYIAPGvamDb4e1QDAEQAq940FlyoJcA
 5wWiRZp5kWbeKNzem6Tq2w4DU/rGm58VxMig8pMjNVPeXvS+RnQIjYT5ObG5DrvO0TifSH4219t
 iIUgEAOpXMDZwUQNAzL+HmzyQodrUrilbb06e9+mdSBwdYG7qBcsCUT2zs+NIlr+MyAsXtB8BPh
 nBalbteoaL1/Akzboc8+4i7bR8ec1g851yOkZ7owKV7unOLCHNDeug3fhF3hTOx0gd15qjMnbVw
 /GUEscJ/cLE3lgm7pkn90I/KK+Ezk7Gg5aHtxDa+3sZVm/McKBAc
X-Received: by 2002:a05:6000:2a7:b0:38d:e190:b713 with SMTP id
 ffacd0b85a97d-38f33f4acbdmr9880404f8f.37.1739892136443; 
 Tue, 18 Feb 2025 07:22:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMnTLi7/TR+3t7v4Awn2y8jepWE1m8Q0WLeR24iE4GrUJAg7Jv+YiQ6wp1cS+aqYQDUDQPzQ==
X-Received: by 2002:a05:6000:2a7:b0:38d:e190:b713 with SMTP id
 ffacd0b85a97d-38f33f4acbdmr9880373f8f.37.1739892136005; 
 Tue, 18 Feb 2025 07:22:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258f5fb6sm15062981f8f.44.2025.02.18.07.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 07:22:15 -0800 (PST)
Message-ID: <6030fd76-e7f1-47ca-9eb7-8cafe48bd639@redhat.com>
Date: Tue, 18 Feb 2025 16:22:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] arm/cpu: Add sysreg definitions in cpu-sysregs.h
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20250207110248.1580465-1-cohuck@redhat.com>
 <20250207110248.1580465-2-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250207110248.1580465-2-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,


On 2/7/25 12:02 PM, Cornelia Huck wrote:
> From: Eric Auger <eric.auger@redhat.com>
>
> This new header contains macros that define aarch64 registers.
> In a subsequent patch, this will be replaced by a more exhaustive
> version that will be generated from linux arch/arm64/tools/sysreg
> file. Those macros are sufficient to migrate the storage of those
> ID regs from named fields in isar struct to an array cell.
>
> [CH: reworked to use different structures]
> [CH: moved accessors from the patches first using them to here,
>      dropped interaction with writable registers, which will happen
>      later]
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/arm/cpu-sysregs.h | 131 +++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu.h         |  42 +++++++++++++
>  2 files changed, 173 insertions(+)
>  create mode 100644 target/arm/cpu-sysregs.h
>
> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
> new file mode 100644
> index 000000000000..de09ebae91a5
> --- /dev/null
> +++ b/target/arm/cpu-sysregs.h
> @@ -0,0 +1,131 @@
> +#ifndef ARM_CPU_SYSREGS_H
> +#define ARM_CPU_SYSREGS_H
> +
> +/*
> + * Following is similar to the coprocessor regs encodings, but with an argument
> + * ordering that matches the ARM ARM. We also reuse the various CP_REG_ defines
> + * that actually are the same as the equivalent KVM_REG_ values.
> + */
> +#define ENCODE_ID_REG(op0, op1, crn, crm, op2)          \
> +    (((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
> +     ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
> +     ((crn) << CP_REG_ARM64_SYSREG_CRN_SHIFT) |         \
> +     ((crm) << CP_REG_ARM64_SYSREG_CRM_SHIFT) |         \
> +     ((op2) << CP_REG_ARM64_SYSREG_OP2_SHIFT))
> +
> +typedef enum ARMIDRegisterIdx {
> +    ID_AA64PFR0_EL1_IDX,
> +    ID_AA64PFR1_EL1_IDX,
> +    ID_AA64SMFR0_EL1_IDX,
> +    ID_AA64DFR0_EL1_IDX,
> +    ID_AA64DFR1_EL1_IDX,
> +    ID_AA64ISAR0_EL1_IDX,
> +    ID_AA64ISAR1_EL1_IDX,
> +    ID_AA64ISAR2_EL1_IDX,
> +    ID_AA64MMFR0_EL1_IDX,
> +    ID_AA64MMFR1_EL1_IDX,
> +    ID_AA64MMFR2_EL1_IDX,
> +    ID_AA64MMFR3_EL1_IDX,
> +    ID_PFR0_EL1_IDX,
> +    ID_PFR1_EL1_IDX,
> +    ID_DFR0_EL1_IDX,
> +    ID_MMFR0_EL1_IDX,
> +    ID_MMFR1_EL1_IDX,
> +    ID_MMFR2_EL1_IDX,
> +    ID_MMFR3_EL1_IDX,
> +    ID_ISAR0_EL1_IDX,
> +    ID_ISAR1_EL1_IDX,
> +    ID_ISAR2_EL1_IDX,
> +    ID_ISAR3_EL1_IDX,
> +    ID_ISAR4_EL1_IDX,
> +    ID_ISAR5_EL1_IDX,
> +    ID_MMFR4_EL1_IDX,
> +    ID_ISAR6_EL1_IDX,
> +    MVFR0_EL1_IDX,
> +    MVFR1_EL1_IDX,
> +    MVFR2_EL1_IDX,
> +    ID_PFR2_EL1_IDX,
> +    ID_DFR1_EL1_IDX,
> +    ID_MMFR5_EL1_IDX,
> +    ID_AA64ZFR0_EL1_IDX,
> +    CTR_EL0_IDX,
> +    NUM_ID_IDX,
> +} ARMIDRegisterIdx;
> +
> +typedef enum ARMSysRegs {
> +    SYS_ID_AA64PFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 4, 0),
> +    SYS_ID_AA64PFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 4, 1),
> +    SYS_ID_AA64SMFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 4, 5),
> +    SYS_ID_AA64DFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 5, 0),
> +    SYS_ID_AA64DFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 5, 1),
> +    SYS_ID_AA64ISAR0_EL1 = ENCODE_ID_REG(3, 0, 0, 6, 0),
> +    SYS_ID_AA64ISAR1_EL1 = ENCODE_ID_REG(3, 0, 0, 6, 1),
> +    SYS_ID_AA64ISAR2_EL1 = ENCODE_ID_REG(3, 0, 0, 6, 2),
> +    SYS_ID_AA64MMFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 7, 0),
> +    SYS_ID_AA64MMFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 7, 1),
> +    SYS_ID_AA64MMFR2_EL1 = ENCODE_ID_REG(3, 0, 0, 7, 2),
> +    SYS_ID_AA64MMFR3_EL1 = ENCODE_ID_REG(3, 0, 0, 7, 3),
> +    SYS_ID_PFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 0),
> +    SYS_ID_PFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 1),
> +    SYS_ID_DFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 2),
> +    SYS_ID_MMFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 4),
> +    SYS_ID_MMFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 5),
> +    SYS_ID_MMFR2_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 6),
> +    SYS_ID_MMFR3_EL1 = ENCODE_ID_REG(3, 0, 0, 1, 7),
> +    SYS_ID_ISAR0_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 0),
> +    SYS_ID_ISAR1_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 1),
> +    SYS_ID_ISAR2_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 2),
> +    SYS_ID_ISAR3_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 3),
> +    SYS_ID_ISAR4_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 4),
> +    SYS_ID_ISAR5_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 5),
> +    SYS_ID_MMFR4_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 6),
> +    SYS_ID_ISAR6_EL1 = ENCODE_ID_REG(3, 0, 0, 2, 7),
> +    SYS_MVFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 3, 0),
> +    SYS_MVFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 3, 1),
> +    SYS_MVFR2_EL1 = ENCODE_ID_REG(3, 0, 0, 3, 2),
> +    SYS_ID_PFR2_EL1 = ENCODE_ID_REG(3, 0, 0, 3, 4),
> +    SYS_ID_DFR1_EL1 = ENCODE_ID_REG(3, 0, 0, 3, 5),
> +    SYS_ID_MMFR5_EL1 = ENCODE_ID_REG(3, 0, 0, 3, 6),
> +    SYS_ID_AA64ZFR0_EL1 = ENCODE_ID_REG(3, 0, 0, 4, 4),
> +    SYS_CTR_EL0 = ENCODE_ID_REG(3, 3, 0, 0, 1),
> +} ARMSysRegs;
> +
> +static const uint32_t id_register_sysreg[NUM_ID_IDX] = {
> +    [ID_AA64PFR0_EL1_IDX] = SYS_ID_AA64PFR0_EL1,
> +    [ID_AA64PFR1_EL1_IDX] = SYS_ID_AA64PFR1_EL1,
> +    [ID_AA64SMFR0_EL1_IDX] = SYS_ID_AA64SMFR0_EL1,
> +    [ID_AA64DFR0_EL1_IDX] = SYS_ID_AA64DFR0_EL1,
> +    [ID_AA64DFR1_EL1_IDX] = SYS_ID_AA64DFR1_EL1,
> +    [ID_AA64ISAR0_EL1_IDX] = SYS_ID_AA64ISAR0_EL1,
> +    [ID_AA64ISAR1_EL1_IDX] = SYS_ID_AA64ISAR1_EL1,
> +    [ID_AA64ISAR2_EL1_IDX] = SYS_ID_AA64ISAR2_EL1,
> +    [ID_AA64MMFR0_EL1_IDX] = SYS_ID_AA64MMFR0_EL1,
> +    [ID_AA64MMFR1_EL1_IDX] = SYS_ID_AA64MMFR1_EL1,
> +    [ID_AA64MMFR2_EL1_IDX] = SYS_ID_AA64MMFR2_EL1,
> +    [ID_AA64MMFR3_EL1_IDX] = SYS_ID_AA64MMFR3_EL1,
> +    [ID_PFR0_EL1_IDX] = SYS_ID_PFR0_EL1,
> +    [ID_PFR1_EL1_IDX] = SYS_ID_PFR1_EL1,
> +    [ID_DFR0_EL1_IDX] = SYS_ID_DFR0_EL1,
> +    [ID_MMFR0_EL1_IDX] = SYS_ID_MMFR0_EL1,
> +    [ID_MMFR1_EL1_IDX] = SYS_ID_MMFR1_EL1,
> +    [ID_MMFR2_EL1_IDX] = SYS_ID_MMFR2_EL1,
> +    [ID_MMFR3_EL1_IDX] = SYS_ID_MMFR3_EL1,
> +    [ID_ISAR0_EL1_IDX] = SYS_ID_ISAR0_EL1,
> +    [ID_ISAR1_EL1_IDX] = SYS_ID_ISAR1_EL1,
> +    [ID_ISAR2_EL1_IDX] = SYS_ID_ISAR2_EL1,
> +    [ID_ISAR3_EL1_IDX] = SYS_ID_ISAR3_EL1,
> +    [ID_ISAR4_EL1_IDX] = SYS_ID_ISAR4_EL1,
> +    [ID_ISAR5_EL1_IDX] = SYS_ID_ISAR5_EL1,
> +    [ID_MMFR4_EL1_IDX] = SYS_ID_MMFR4_EL1,
> +    [ID_ISAR6_EL1_IDX] = SYS_ID_ISAR6_EL1,
> +    [MVFR0_EL1_IDX] = SYS_MVFR0_EL1,
> +    [MVFR1_EL1_IDX] = SYS_MVFR1_EL1,
> +    [MVFR2_EL1_IDX] = SYS_MVFR2_EL1,
> +    [ID_PFR2_EL1_IDX] = SYS_ID_PFR2_EL1,
> +    [ID_DFR1_EL1_IDX] = SYS_ID_DFR1_EL1,
> +    [ID_MMFR5_EL1_IDX] = SYS_ID_MMFR5_EL1,
> +    [ID_AA64ZFR0_EL1_IDX] = SYS_ID_AA64ZFR0_EL1,
> +    [CTR_EL0_IDX] = SYS_CTR_EL0,
> +};
> +
> +#endif /* ARM_CPU_SYSREGS_H */
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 2213c277348d..4bbce34e268d 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -30,6 +30,7 @@
>  #include "qapi/qapi-types-common.h"
>  #include "target/arm/multiprocessing.h"
>  #include "target/arm/gtimer.h"
> +#include "target/arm/cpu-sysregs.h"
>  
>  #ifdef TARGET_AARCH64
>  #define KVM_HAVE_MCE_INJECTION 1
> @@ -832,6 +833,46 @@ typedef struct {
>      uint32_t map, init, supported;
>  } ARMVQMap;
>  
> +static inline uint64_t _get_idreg(uint64_t *idregs, uint32_t index)
> +{
> +    return idregs[index];
> +}
> +
> +static inline void _set_idreg(uint64_t *idregs, uint32_t index, uint64_t value)
> +{
> +    idregs[index] = value;
> +}
> +
> +/* REG is ID_XXX */
nit: we have MVFRx too so maybe we shall rather say that REG is the

ARMIDRegisterIdx litteral without  _EL1_IDX suffix or just remove the comment

 
> +#define FIELD_DP64_IDREG(ARRAY, REG, FIELD, VALUE)              \
> +{                                                             \
> +    uint64_t regval = _get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX);   \
> +        regval = FIELD_DP64(regval, REG, FIELD, VALUE);                 \
> +    _set_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX, regval);             \
> +}
> +
> +#define FIELD_DP32_IDREG(ARRAY, REG, FIELD, VALUE)              \
> +{                                                             \
> +uint64_t regval = _get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX);       \
> +regval = FIELD_DP32(regval, REG, FIELD, VALUE);               \
> +_set_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX, regval);                 \
> +}
> +
> +#define FIELD_EX64_IDREG(ARRAY, REG, FIELD)                     \
> +FIELD_EX64(_get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX), REG, FIELD)  \
> +
> +#define FIELD_EX32_IDREG(ARRAY, REG, FIELD)                     \
> +FIELD_EX32(_get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX), REG, FIELD)  \
> +
> +#define FIELD_SEX64_IDREG(ARRAY, REG, FIELD)                     \
> +FIELD_SEX64(_get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX), REG, FIELD)  \
> +
> +#define SET_IDREG(ARRAY, REG, VALUE)                            \
> +_set_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX, VALUE)
> +
> +#define GET_IDREG(ARRAY, REG)                                   \
> +_get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX)
> +
>  /**
>   * ARMCPU:
>   * @env: #CPUARMState
> @@ -1040,6 +1081,7 @@ struct ArchCPU {
>          uint64_t id_aa64zfr0;
>          uint64_t id_aa64smfr0;
>          uint64_t reset_pmcr_el0;
> +        uint64_t idregs[NUM_ID_IDX];
>      } isar;
>      uint64_t midr;
>      uint32_t revidr;

Thanks

Eric


