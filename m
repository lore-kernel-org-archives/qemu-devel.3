Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC96C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 01:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpzoq-0002xY-CS; Wed, 05 Mar 2025 20:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpzok-0002pR-H9
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:14:31 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpzoi-0004wi-Fe
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:14:30 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2234e4b079cso1085485ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 17:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741223666; x=1741828466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IZNSX40B0LWPocH4d937YtNReVbf2z70/WFhXiXVLeg=;
 b=vbfEO/o86y3yQwvMgTDIER2Sr706HnDKGpQwY1UliQ083n87XMUFFQcxCdOFwUQXHF
 225ahz6IPufK6Z+9/Tz+syH/HjXVB4Q3zRhfDsMeEiKrdwvBgAxDJ3XHbxPsgTcCQlAG
 zS1wMQKRk70tWXNkR/VFBpWo3VO2ipiP/rvqnFeD4vzmSybddupwwqOJaQf6oX1Q9Yw8
 uiUA3Iv41EUjgMdszj83x8Eh73uPhl/c9eaNhWrWoRNoOLFH32uB8ccnQR0Ne0deK57r
 z55dN0y/RJEtkVTHoOdYx/EL3rVshaIdcNpy92PGjHIY77kRoEk6QVnli9uaGgmY/k+k
 NsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741223666; x=1741828466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IZNSX40B0LWPocH4d937YtNReVbf2z70/WFhXiXVLeg=;
 b=xJhSa2zh5AxMhCnDSKPRwbRM/J+vvMCPx7Ggz1sap/wYeeq4ZOoh+lBAX+zSLjxlq6
 n+VfHnhCKBszWb/j2kPqbKGpmu5HTte+/ePlBbbsRiIADE8wW2VH6Em6oI23/QEN+yFR
 gozYCmMdRaExJAYINrea7iyWaP3CvdP1V1+bOPYQh3l3efHXbjXtfp7CO68LScPHGhFx
 HiERXPYhcOQ25GmJ9xoxqI0pTopntqwFxjUFSNttCzn3l+PpHsrZEy3X8Xwgkn4k1Kio
 j9HIa6O2g1h2D5WIWuqJqAQvT5aPhhv7O2fbRoodiaaPXfXAN6B9AQTxpunn4DVd9mH1
 v/ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf68k1393FIv5avlFXmRScS1DVvzEKnT8KoccKcBCRwRGINiM2WwzjO1bPSu6MtGTIAv7TS5y5FrDo@nongnu.org
X-Gm-Message-State: AOJu0YzVZxLIl6jUYVPFFO2KhMX3jjpNaXa0YAYJm/wRY+bt9O5gPZXg
 oGpKyCoO+WenWiYQSHP+mssR9HFzJxxHQf0WmQnFvxEBaLbZTs5Ml9FJmXXyXoQ=
X-Gm-Gg: ASbGncucJAuptRkavntV61hkYWYtq2fBVWr7Aw7CbH8dSqKFjpCEKh/2SvJtZb62APs
 xKziZ6DIuuefE9Iv3ovh1e6iqWAo5FkwzH3lo4bre2IzmF6+Fm76Do0aHTSHgYiHwmij+dCU/Lz
 GdxsR2V1o1+Mv8x7fW2hub2qohgAwx++PmDi5FzFogPlFe9zspRD6GVPX9Ux7JxxxG9brHRKfNV
 1bdxMTrivFyliGhVIE28a6tId1xMY3aSdR4ANezyZS/LxSMYp2CrR1gCIGfANXWZDZAhOi5Wf3K
 Sd8whtSJb84NCUedtNKhzvAiDDxdpw3lsFvyf6yYfO+qWGP/nyCWegHnujYGiLCQFAcD+VaAmH8
 qg64f2a1t
X-Google-Smtp-Source: AGHT+IGXAOH99+JMKbDDMTO61pZ4BpDGxWBANf54nFDjX3JNoiGqYPQphtgz0nlQ5EED/deQGJmUoQ==
X-Received: by 2002:a17:902:d48d:b0:220:e7ae:dbcf with SMTP id
 d9443c01a7336-223f1cf61aemr82910775ad.23.1741223666070; 
 Wed, 05 Mar 2025 17:14:26 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109e9fbfsm671265ad.92.2025.03.05.17.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 17:14:25 -0800 (PST)
Message-ID: <1f8bfd50-669a-41be-95e1-b277255a96a4@linaro.org>
Date: Wed, 5 Mar 2025 17:14:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] arm/cpu: Add sysreg definitions in cpu-sysregs.h
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250305163819.2477553-1-cohuck@redhat.com>
 <20250305163819.2477553-2-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305163819.2477553-2-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/5/25 08:38, Cornelia Huck wrote:
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

Again, you should NOT place this array in a header,
to be replicated in every single user of the header.


This can be a bit more automated to avoid mistakes.

--- target/arm/cpu-sysregs.h.inc

DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
...

--- target/arm/cpu-sysregs.h

#define DEF(NAME, OP0, OP1, CRN, CRM, OP2)  NAME##_IDX,

typedef enum ARMIDRegisterIdx {
#include "cpu-sysregs.h.inc"
} ARMIDRegisterIdx;

#undef DEF
#define DEF(NAME, OP0, OP1, CRN, CRM, OP2) \
     SYS_##NAME = ENCODE_ID_REG(OP0, OP1, CRN, CRM, OP2),

typedef enum ARMSysRegs {
#include "cpu-sysregs.h.inc"
} ARMSysRegs;

#undef DEF


r~

