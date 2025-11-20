Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83307CF856E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 16:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM7CX-0004be-Co; Thu, 20 Nov 2025 11:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vM7C3-0004aj-O6
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 11:07:38 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vM7C1-0006qY-SI
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 11:07:35 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42b53b336e6so123382f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 08:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763654852; x=1764259652; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwDZm74JaHS0AeW1drZH+ePWA1Bi8JkQhOFaFz/hUqA=;
 b=BsMnz7t7M4FsVYZcqi8iZIPvd/kkKXzUf0Z72Sb4wX/88M8Ddas/N+kdIvKE33+S92
 4QYy6i2456oHhX1LcxqUv+SRPIotKBmLq3BtsZrR+jYTMXR79MVq/LgADZXt6U7xVjPf
 wtJIrIALcTBby+SdqhrN9Kaeqm+u1uHFaQCBRZwUolGnYAuXIs0NRV92742G1Z2KTG8Q
 vwBDALFubiFHpnvwSWGK65UPmLws4P5JHMBr9+C1As29YCd3hqhCZJqhfsaTwdTFSzrL
 f1uKrzfmK+yaVInryP9+qQ0xkO6peTVS686YmlTP6XOWMT4znolX3vn/7CyfuSHsWwN0
 AI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654852; x=1764259652;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HwDZm74JaHS0AeW1drZH+ePWA1Bi8JkQhOFaFz/hUqA=;
 b=w+9azFh+1GSGPvrymbI57OhHISYP1lgRGjl7qo0DOxK2IQfMNkI7UILAaHRU4BdSPB
 Tv6RWOjFoEJ0ttFNUgDPLB93D70Nl1ft3njLUd9yYo4dZQjpcDJgb5f/SqIYCeG1vvsD
 fB5mabcZZOPfl8TPAVWYAiYz57SCCsnWzeW8i5N1cpCaJ4rCpL+1Odfet6exwXG7bCYY
 dLnmn2UsFfjyza2Ji+OL/xVCyYB/hrxpVH+2DFspI3ttwiR7OmbMIa7jyMWnREHi8s+B
 5dTrc3RrHGK0o67f/xlDP82GZhNefpXK55ebVoQvrKQn4BGgeTaWkv4n0ju5DkYl4LdM
 qtMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvvBZgiFgnNl18oezlXKKQrt/mCy1O/kkS5+W6hcHPlq//drkNdd5ZR7/MaBbfk7fstlCLsIUUwNBg@nongnu.org
X-Gm-Message-State: AOJu0YzA1WSRRdW2Zla6Rc0rJRZ+vQEocWMyYKuOhFqVAYzVey++U/ft
 W2mYKx7hkmG9bpbtRE89XkmLh9gB2GmByAXJcfejJwoZmkb6pM3L5VKwhZYtrDN4bJI=
X-Gm-Gg: ASbGncs2CppmxxnDxYidLRTqFHHPUzC6UuHkA6v99DOBbf3gn3lyXLY4nyP1/0H04TF
 yVSqCcrSKahyYICXUDiest9lCafk9YLXpZMFiaqjfYVq/tbE+ABmJ0p4jX13Pj93GoVdQ9wzXLA
 dJXpZ0Vw6EGcmWLniZMQ/51/M/YydWISnCcdlCF8oNRiM3NXZzjBkiucBhmkmyyL8m0KcVJyQBP
 o8jvuvcBKZ+wQIGz+GFrDuhXCMbzwZBwTiRrrN5JRTtn685cT9rP/Nxw6ykfB259u/67cDZeaED
 LNg8OMZdzxnT15UWXJtjJjJ8SGnJEuZiy1mn1EAuUsiqGBBucS1PG7LGYKq37471cfKlVURVtz9
 LnVSIHcqsWaiZ9OwxFb/Usup5LeB09jIxYcHk4h1RjKBnnHaq8lourG5u+YRqwAUhmWHJ9W0lLT
 VGdyCIvO8N3g==
X-Google-Smtp-Source: AGHT+IELpcDxQD4WNFYaL4c92bZ3UNCcsP/Y8nWQWjpvJGLwo5+YzDKUDA+VkO23jFmmLkFBhoNPZw==
X-Received: by 2002:a5d:588f:0:b0:429:bde0:1da8 with SMTP id
 ffacd0b85a97d-42cb9a82d9cmr1921315f8f.7.1763654851505; 
 Thu, 20 Nov 2025 08:07:31 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::3052])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42cb7f2e454sm6452245f8f.2.2025.11.20.08.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:07:31 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Nov 2025 17:07:03 +0100
Message-Id: <DEDNGGQCPNKP.25HNT2IHYB0C2@ventanamicro.com>
Subject: Re: [PATCH 1/7] riscv: implement Ssqosid extension and srmcfg CSR
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Alistair Francis"
 <Alistair.Francis@wdc.com>, "Weiwei Li" <liwei1518@gmail.com>, "Daniel
 Henrique Barboza" <dbarboza@ventanamicro.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "Nicolas Pitre" <npitre@baylibre.com>,
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, "Atish Kumar Patra"
 <atishp@rivosinc.com>, "Atish Patra" <atish.patra@linux.dev>, "Vasudevan
 Srinivasan" <vasu@rivosinc.com>, "yunhui cui" <cuiyunhui@bytedance.com>,
 "Chen Pei" <cp0613@linux.alibaba.com>, <guo.wenjia23@zte.com.cn>,
 <liu.qingtao2@zte.com.cn>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: "Drew Fustini" <fustini@kernel.org>, <qemu-devel@nongnu.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-1-3392fc760e48@kernel.org>
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-1-3392fc760e48@kernel.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-11-19T16:42:17-08:00, Drew Fustini <fustini@kernel.org>:
> From: Kornel Dul=C4=99ba <mindal@semihalf.com>
>
> Implement the srmcfg CSR defined by the Ssqosid ISA extension
> (Supervisor-mode Quality of Service ID). The CSR contains two fields:
>
>   - Resource Control ID (RCID) used determine resource allocation
>   - Monitoring Counter ID (MCID) used to track resource usage
>
> The CSR is defined for S-mode but accessing it when V=3D1 shall cause a
> virtual instruction exception. Implement this behavior by calling the
> hmode predicate.
>
> Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/download/v1.0=
/riscv-cbqri.pdf
> Signed-off-by: Kornel Dul=C4=99ba <mindal@semihalf.com>
> [fustini: rebase on v10.1.50, fix check_srmcfg]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> @@ -216,6 +216,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
>      ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
>      ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
> +    ISA_EXT_DATA_ENTRY(ssqosid, PRIV_VERSION_1_12_0, ext_ssqosid),

Just out of curiosity, where does PRIV_VERSION_1_12_0 come from?

> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> @@ -1759,6 +1759,37 @@ static RISCVException write_stimecmph(CPURISCVStat=
e *env, int csrno,
> +static RISCVException check_srmcfg(CPURISCVState *env, int csrno)
> +{
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +
> +    if (!cpu->cfg.ext_ssqosid) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    /*
> +     * Even though this is an S-mode CSR the spec says that we need to t=
hrow
> +     * and virt instruction fault if a guest tries to access it.
> +     */
> +    return env->virt_enabled ?
> +           RISCV_EXCP_VIRT_INSTRUCTION_FAULT : smode(env, csrno);
> +}

The check is missing interaction with mstateen0.SRMCFG.

Thanks.

