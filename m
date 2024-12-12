Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D42E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkKQ-0005cy-0L; Thu, 12 Dec 2024 09:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkKM-0005cM-Jo
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:38:06 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkKG-0001Ky-SY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:38:06 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3eb5a870158so251704b6e.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734014279; x=1734619079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WClgGnNKhbkqYl2M5kjAPX27ot9J1JWOs4M4aBmFm9w=;
 b=Tbc9bLofgkxBhI/JzoWC+RJXQc7OAbD8neUc7yDSeewISqegKCeIHT4q1N2rcRace5
 ftlBB4NwgyHggpo8u4WmvJrl4L/1/zubdvVCU741dZWtaUbsaZKvO7yu51fsjtAQdN5K
 0OhXyP84i1bbyCku2v7Fvr6HPxEmFiRA8I71zHpXw9VlmFVZIcdDQGhedZsBJs+czMIO
 hWLSTDEiJfy253/KtumLXZHGHeBGtT1+Jet3PpbPltp3X+ItnkENdAEvOR6Jhjgploqp
 SJ4eMc66RITwvtJTAzKSL6a6nfaerRD03hEdek5tp8OHpmv9jduJBKE8+tgV7Ju0OBdr
 rzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734014279; x=1734619079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WClgGnNKhbkqYl2M5kjAPX27ot9J1JWOs4M4aBmFm9w=;
 b=hbUzFV4DEvJH+c2FtkNYTsryMXhE5XtUFGKgBgpdlEPXlqTFDaYiG9tVM2eCC+19lE
 nQiWlk9WIm1sR5r3RG684/2+LTdAmTcNCW60uABXN3Ew7ZcY40XwjS0ans/qbq04ZC43
 HHQ4emHeJmbhAlFVNF2nNPjLQEMcaDXyjrw9/1o6XcjviVwQikjutrjWVAaq1baE1Gge
 Eow8zyNxqePEH0SMo+3BHt7ydzxWo8tmEMiO+Rwr3k7wzuIf4q3mVRpUi0xJcjEMVMhH
 OYGZvtPk7igwwPrcAFuU7R9IJ919SI2YsFCL+m9vV0v6ht7ojDQW+J6BtkBqr+6AFqw0
 vWTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVx/BmO6T/3PAI6bnNb75/k0BUC4xr3oGCja3cL3XD2hpL/0lycACbOR7t6NCkj1Yt2iKUc9RYQwmE@nongnu.org
X-Gm-Message-State: AOJu0Yxrl+aP9fRGu2Noz4FACpPwR8ke6fDwQNknsgiwbrYi/lzmS4WZ
 +J1f/G3tWq6qnGhwXH8l/jJAYKcVR8wAm1E1ZOKzUUYKyGRG+RMRVY00eay0p/Q=
X-Gm-Gg: ASbGncunqmvcj/ssC0ONGr6Azw87DfGC3jBc3frj1v4k3cemJiltApcwYcJm+YZw98b
 ZsxtxB/Rb9UnOJKrvyJJ/5jwZco3XRsHsvvz7ieFE0lxiErDU3ja3Kx/oVuHknlNAnGV8+zLOmz
 K1FF1axBOBBHpKYdKVydzE3fCzvCgWKl5nW/y4ZvlH+xJMwyqyRgamiowBw0t7Fibvbfd6NAwhq
 UV3S0U3BIgHLhdqTZUwO/63Sl4kagXDWACn65sia2cwbjEutnFUzXmpm72lYIJe7u+22/Q+Oa9m
 zjqzSvmxeUg7l4WSnN/g0HEgzw/loJKufSE=
X-Google-Smtp-Source: AGHT+IHzcsNqE4IFEDtNAAVXxkbmviqgknyI1oXeRyYPRBrNN3gZRaB7NkY5HJTFgq2pBMw1QofjPQ==
X-Received: by 2002:a05:6808:1381:b0:3eb:66d7:a33e with SMTP id
 5614622812f47-3eb93f95d83mr2328391b6e.5.1734014278863; 
 Thu, 12 Dec 2024 06:37:58 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb8d6da3ecsm608895b6e.50.2024.12.12.06.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 06:37:58 -0800 (PST)
Message-ID: <2a83a49b-6863-4fb8-b5de-c3eacf3cdb77@linaro.org>
Date: Thu, 12 Dec 2024 08:37:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 02/20] arm/cpu: Add sysreg definitions in
 cpu-sysregs.h
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, alex.bennee@linaro.org,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20241206112213.88394-1-cohuck@redhat.com>
 <20241206112213.88394-3-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241206112213.88394-3-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 12/6/24 05:21, Cornelia Huck wrote:
> +#define SYS_ID_AA64PFR0_EL1                             sys_reg(3, 0, 0, 4, 0)
...
> +typedef struct ARMSysReg {
> +    int op0;
> +    int op1;
> +    int crn;
> +    int crm;
> +    int op2;
> +} ARMSysReg;
...
> +static inline ARMSysReg sys_reg(int op0, int op1, int crn, int crm, int op2)
> +{
> +        ARMSysReg sr = {op0, op1, crn, crm, op2};
> +
> +        return sr;
> +}

Not a fan.  Why take 20 bytes to represent these?

Our existing ENCODE_CP_REG and ENCODE_AA64_CP_REG macros seem much better, even if the 
argument ordering doesn't match the column ordering in Table D22-2.

> @@ -841,6 +849,51 @@ typedef struct IdRegMap {
>       uint64_t regs[NR_ID_REGS];
>   } IdRegMap;
>   
> +#define ARM_FEATURE_ID_RANGE_IDX(op0, op1, crn, crm, op2)               \
> +        ({                                                              \
> +                __u64 __op1 = (op1) & 3;                                \
> +                __op1 -= (__op1 == 3);                                  \
> +                (__op1 << 6 | ((crm) & 7) << 3 | (op2));                \
> +        })

Ah, well, this answers my question re patch 1.

It seems a shame to use 128 slots to represent all 9 id registers in the op1={1,3} space.

Do we really need anything beyond the defined registers, or even the defined registers for 
which qemu knows how to do anything?

I'm certainly happy to replace ARMISARegisters fields with an array, but more like

enum ARMIDRegisterIdx {
     ID_AA64ISAR0_IDX,
     etc
     ordering arbitrary, either machine or macro generated,
     but every register has a symbolic index.
     NUM_ID_IDX,
};

enum ARMSysregs {
     SYS_ID_AA64PFR0_EL1 = ENCODE_AA64_CP_REG(...),
     etc
};

const uint32_t id_register_sysreg[NUM_ID_IDX] = {
     [ID_AA64ISAR0_IDX] = SYS_ID_AA64PFR0_EL1,
     etc
};

struct ARMISARegisters {
     uint64_t id[NUM_ID_IDX];
};

This seems trivial to automate, and wastes no space.


r~

