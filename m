Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72850C83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 15:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZWxq-0008Jz-HB; Wed, 09 Jul 2025 11:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZWxV-0007wC-9o
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 11:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZWxS-0003aT-MJ
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 11:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752075820;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TeZxkdbH7GyNFotC4rmzScYNntVB9IpHF3NisgULRxM=;
 b=DuV38DlXvwbJY/m9niHOYZPrY2uHG/PC1qmakBS7dsWUsNJfWbnGUhcb7978Mu2DI9mLwA
 +5VbOX5MqivLlqgMvJqyTr3yDF783PvTrwnwrRkpkx4Dj00fJGANGRydE80RYAkbMb85I4
 2HQHYkRiL0CXfq3B3Ppev9DoJp+Nfrk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-L0t1qhaeP9qwA5Tf-AhlPA-1; Wed, 09 Jul 2025 11:43:39 -0400
X-MC-Unique: L0t1qhaeP9qwA5Tf-AhlPA-1
X-Mimecast-MFC-AGG-ID: L0t1qhaeP9qwA5Tf-AhlPA_1752075818
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4fabcafecso35609f8f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 08:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752075818; x=1752680618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TeZxkdbH7GyNFotC4rmzScYNntVB9IpHF3NisgULRxM=;
 b=ce9Z/Ebn4He4Ic1/PV2oYCy3ec7BVm5Zi88/u0UxO9Dlnzh5xin9D70W3T4S1dOOTg
 /ednq+mfSbc4yj9jfHgFy/mbwlI8X2UKDaEENcPXF2nyBP0MsHwneOtNPvUcLP1ZFLTd
 xPgtYBgxASyuFZJcz47RnGorwNB9mm0tVrsMvWqBVqQKIpRBfbIR3ssupiIcxHUomC+D
 IK1jv7HJ8jnwp7pzHFI+bNEyNO0GT5iagAZn5hdkIk9QACMO5N/RP3G2+ScrxjxQrOZP
 Ezl7gGaKzh6jp4dGdgsCerIATfwvi/KUl7QlQ+Pz6wexCfR3X72iSLx9CrVjHyzP4Gs6
 8PZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9vQFLwEjfjoTw7/sqty5JnQsPNbXgC7rKMzT1ptLdEgePe3nBfobfNFxRH+YCBeXAnU28ZJNRMwPZ@nongnu.org
X-Gm-Message-State: AOJu0YxF1BhDm9xE6jcOVKI6VgERHjF1eSl5FVxgk8GkdF2MBKBl2MD+
 ZRO58Ce/bCMc8b1m0NPvkhkXWoUgRgH00IEP8a8d/3iM9DQpEqxHHxuzN4j9m04BYxCWyyGMW0n
 qlYt9JKjSgfsxBrMFCbCwg1hj3TTSFjLXpquRIpm+tbMsn07icFbm4alq
X-Gm-Gg: ASbGncsFRbj0igezIEe+4hMGxG1i2zi3NABhg3g+IAAt/ysHsBfQva5/MMs9myMeu+0
 MX4VlA5W7MqQZZrBVqCh0GS9AWTLtx2y6VsRcbe9uJDnEda9OS4iC47OjElDhbN3RgqNWR1qDjr
 oAGM/oh0imC/fsftqHofxuumlU7bAL3Xdn7N7tiy7BcDIgSjC2ydsWU3ClDEtpjC5nLOAiw3AVy
 tdv/kM7fAnER0xDtr+nb8qWNhEWkbDRlIciR8blN5n9S/G+Ht+jol87Gray2AlLLTKXi5atptN2
 84HCAhX3Am+d3Kw0GHj698YecuiIyyli1Ky2t/HQr2JWF5b+nCrpv+vO0EKUNqSmnsFmgw==
X-Received: by 2002:a05:6000:400b:b0:3a5:2575:6b45 with SMTP id
 ffacd0b85a97d-3b5e4538a89mr2713353f8f.48.1752075817766; 
 Wed, 09 Jul 2025 08:43:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhwPCFhmNCkA64kCeIgqUF7MHlhZIV0QKVpErG8qTFR9aMS8Yq3b+EojY9sWTqGggPNLKycg==
X-Received: by 2002:a05:6000:400b:b0:3a5:2575:6b45 with SMTP id
 ffacd0b85a97d-3b5e4538a89mr2713314f8f.48.1752075817185; 
 Wed, 09 Jul 2025 08:43:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5032fcbsm30666395e9.6.2025.07.09.08.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 08:43:36 -0700 (PDT)
Message-ID: <50296610-8268-47cf-aa3a-cf3db738fc83@redhat.com>
Date: Wed, 9 Jul 2025 17:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm/cpu: store id_aa64afr{0,1} into the idregs array
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
 <20250704141927.38963-3-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250704141927.38963-3-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 7/4/25 4:19 PM, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  target/arm/cpu-sysregs.h.inc |  2 ++
>  target/arm/cpu.h             |  2 --
>  target/arm/helper.c          |  4 ++--
>  target/arm/tcg/cpu64.c       | 16 ++++++++--------
>  4 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index b96a35880430..44c877245eea 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -4,6 +4,8 @@ DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
>  DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
>  DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
>  DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
> +DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
> +DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
>  DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
>  DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
>  DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index ca8ad1cc27a8..793c157d873e 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1066,8 +1066,6 @@ struct ArchCPU {
>      uint32_t reset_sctlr;
>      uint64_t pmceid0;
>      uint64_t pmceid1;
> -    uint64_t id_aa64afr0;
> -    uint64_t id_aa64afr1;
>      uint64_t clidr;
>      uint64_t mp_affinity; /* MP ID without feature bits */
>      /* The elements of this array are the CCSIDR values for each cache,
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2f57ab4d87da..6acbb2bcd9bd 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7983,12 +7983,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 4,
>                .access = PL1_R, .type = ARM_CP_CONST,
>                .accessfn = access_aa64_tid3,
> -              .resetvalue = cpu->id_aa64afr0 },
> +              .resetvalue = GET_IDREG(isar, ID_AA64AFR0) },
>              { .name = "ID_AA64AFR1_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 5,
>                .access = PL1_R, .type = ARM_CP_CONST,
>                .accessfn = access_aa64_tid3,
> -              .resetvalue = cpu->id_aa64afr1 },
> +              .resetvalue = GET_IDREG(isar, ID_AA64AFR1) },
>              { .name = "ID_AA64AFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 6,
>                .access = PL1_R, .type = ARM_CP_CONST,
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 3f4fb003f440..00e12ed44ae8 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -428,8 +428,8 @@ static void aarch64_a64fx_initfn(Object *obj)
>      SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000000);
>      SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408),
>      SET_IDREG(isar, ID_AA64DFR1, 0x0000000000000000),
> -    cpu->id_aa64afr0 = 0x0000000000000000;
> -    cpu->id_aa64afr1 = 0x0000000000000000;
> +    SET_IDREG(isar, ID_AA64AFR0, 0x0000000000000000);
> +    SET_IDREG(isar, ID_AA64AFR1, 0x0000000000000000);
>      SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000001122);
>      SET_IDREG(isar, ID_AA64MMFR1, 0x0000000011212100);
>      SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011);
> @@ -676,8 +676,8 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
>      cpu->clidr = 0x82000023;
>      cpu->ctr = 0xb444c004; /* With DIC and IDC set */
>      cpu->dcz_blocksize = 4;
> -    cpu->id_aa64afr0 = 0x00000000;
> -    cpu->id_aa64afr1 = 0x00000000;
> +    SET_IDREG(isar, ID_AA64AFR0, 0x00000000);
> +    SET_IDREG(isar, ID_AA64AFR1, 0x00000000);
>      SET_IDREG(isar, ID_AA64DFR0, 0x000001f210305519ull),
>      SET_IDREG(isar, ID_AA64DFR1, 0x00000000),
>      SET_IDREG(isar, ID_AA64ISAR0, 0x1011111110212120ull); /* with FEAT_RNG */
> @@ -927,8 +927,8 @@ static void aarch64_a710_initfn(Object *obj)
>      SET_IDREG(isar, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
>      SET_IDREG(isar, ID_AA64DFR0, 0x000011f010305619ull);
>      SET_IDREG(isar, ID_AA64DFR1, 0);
> -    cpu->id_aa64afr0       = 0;
> -    cpu->id_aa64afr1       = 0;
> +    SET_IDREG(isar, ID_AA64AFR0, 0);
> +    SET_IDREG(isar, ID_AA64AFR1, 0);
>      SET_IDREG(isar, ID_AA64ISAR0, 0x0221111110212120ull); /* with Crypto */
>      SET_IDREG(isar, ID_AA64ISAR1, 0x0010111101211052ull);
>      SET_IDREG(isar, ID_AA64MMFR0, 0x0000022200101122ull);
> @@ -1029,8 +1029,8 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
>      SET_IDREG(isar, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
>      SET_IDREG(isar, ID_AA64DFR0, 0x000011f210305619ull);
>      SET_IDREG(isar, ID_AA64DFR1, 0);
> -    cpu->id_aa64afr0       = 0;
> -    cpu->id_aa64afr1       = 0;
> +    SET_IDREG(isar, ID_AA64AFR0, 0);
> +    SET_IDREG(isar, ID_AA64AFR1, 0);
>      SET_IDREG(isar, ID_AA64ISAR0, 0x1221111110212120ull); /* with Crypto and FEAT_RNG */
>      SET_IDREG(isar, ID_AA64ISAR1, 0x0011111101211052ull);
>      SET_IDREG(isar, ID_AA64MMFR0, 0x0000022200101125ull);


