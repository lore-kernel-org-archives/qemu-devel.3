Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44CFD2502F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 14:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vewI4-0004AB-6v; Sun, 11 Jan 2026 09:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vewI1-00049P-Uc
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 09:19:33 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vewI0-0003vc-GW
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 09:19:33 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-8c24f867b75so581282485a.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768141171; x=1768745971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZrIcxqO11z5lrg+fSJf4h7AmJUJg9emo0uGf4IqW3qI=;
 b=XSp2TXE+RVefsuuRhhbbHDKghcLPGQpTg/whXZxHasTWre138Y/6fpCvAnEWXYMo+L
 E98Rs3IuFMLnb1tzZFxiPRoNwZz7jZz2AKIkj9cqkmv+HBHJUMsywhoooXJNb0h2CI5n
 Fc5VoA3molEowtVRdK9xDSfwzO5/okWCxz39DP1QOIS4lCgOe65aCBNPEPDw8K4hEbWu
 hYDYV6Gb37cdAv9AQ+myEOZu9wbJPSE8sFSFCIZL59xOALSMtfyVhVvHfIuw1x7kWKOx
 laY5CadHIEmQGyw/kw4Ptz8RVm4CehQirpGios8/KLEsKIQagCnSl5oxMDbvOPyYBlSf
 aX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768141171; x=1768745971;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZrIcxqO11z5lrg+fSJf4h7AmJUJg9emo0uGf4IqW3qI=;
 b=mqWwBQHt1wDkqxnatPkcFNUpADHit1VPSSftp75tUzomKm8V8AKAUViaLadPB2laIL
 6Cbu/wcDfptRAL1qoagu1/cgD/Kkr0ZupXWSoFy4q3lPM671jG1oyH32pmWXqess4ypn
 Plj/2DzqCnGdAHKu7VMVnTDGZ7tLvuA6zkkhM5L73Ac3532CFhvMYFrJ6rPk8KhBw2t3
 sIdA/p4ctZhUftConJbciCW50V5pyKNdRdBtXLSg5TExHH0EzSz57u8hckwNXHlr8iFj
 5reYfFf0Wy2L0vJPZz05Xg6gMndInReasMmTz7vtKJ0XoDrpUmLTVE2/pbb07GmDQ6Pt
 Z6mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnOeycuuvmzEhJ4HE0GH0ZVy7XTSDz93J2FuYV9nz2fceutQFSc7PI54fSHxduOxG3XLRngqAkCkJ9@nongnu.org
X-Gm-Message-State: AOJu0YwyGlgMx5XrfX/XyMs5h2GvhONx2NCX34moFdgYkmxcfWtw3m8y
 QlUEg0pztzHeMc8aorJ+K53znsLT49MWa8aKArzXKVPHOzEWPgkaKEnKGqokX7EcaXw=
X-Gm-Gg: AY/fxX4gqD+0kbblceRNtMq7fr7vYOld0PMfg3yFe2HaJySKtxqfs82jJmRpF0EXn+W
 /J03d5eZBoYCHDJPdeBk12mDasZF9LcEfWspcCh6MU2p3Z6eEq978YqakGW2e9BQoI4QqFApTvj
 YHCOMpLbBHKpT44Lijm4bCq83/Z0OmCdhK2k3PsnXCy6PO27Qp/1+hRttTL2M1yOhgtWz+OVNFX
 F4qW28YlPREPOJgupgdZ0xO6b/kyLzd8SSGKRxzRmh4d6sbjiduCXb84A15xYevO1Ic6FPd5B5y
 1tKgI5OqsaI4FgmQUy2CsP0TlbbeJoEAN1KE/IHoCr62uDxnkTNd2TqiV+jp/a+S7rT8tvBNjNy
 zDUgguP5biSP5qkDP3hDgMHCDuAgsBdjpD9Hx8vgVwUpZrSLvQ4XVtlMJVepBramn1BaZUn4gP6
 7FVWWftxNIyQTXICF4TqvEOo07s7O2xLFUhDHwlD5n
X-Google-Smtp-Source: AGHT+IFpmMptkGw2sHNeXvQndKk6z7CfDhWUZg49DuPWDnwDT8D9GbKFzpzTO9ramY3wTxL9emzr4Q==
X-Received: by 2002:a05:620a:290f:b0:8a4:4156:17b with SMTP id
 af79cd13be357-8c389400353mr2048918085a.70.1768141170923; 
 Sun, 11 Jan 2026 06:19:30 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890770e8cfasm118610996d6.21.2026.01.11.06.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 06:19:30 -0800 (PST)
Message-ID: <ef42103f-5eb0-46a5-a3fb-fa6d466b29d3@ventanamicro.com>
Date: Sun, 11 Jan 2026 11:19:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: tt-ascalon: Add Tenstorrent mvendorid
To: Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair.francis@wdc.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
References: <20260109134145.398565-1-joel@jms.id.au>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260109134145.398565-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x733.google.com
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



On 1/9/2026 10:41 AM, Joel Stanley wrote:
> JEP106 has two vendor IDs for Tenstorrent. We will use Bank 16, hex 0xa1:
> 
>   ((16 - 1) << 7) | (0xa1 & ~0x80) = 0x7a1
> 
> Add it to the Ascalon CPU definition as the mvendorid CSR.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


> This stands alone from the atlantis series and can go in asap.
> 
>   target/riscv/cpu_vendorid.h | 2 ++
>   target/riscv/cpu.c          | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
> index f1ffc66542a0..751a13aace47 100644
> --- a/target/riscv/cpu_vendorid.h
> +++ b/target/riscv/cpu_vendorid.h
> @@ -8,4 +8,6 @@
>   #define VEYRON_V1_MIMPID        0x111
>   #define VEYRON_V1_MVENDORID     0x61f
>   
> +#define TENSTORRENT_VENDOR_ID   0x7a1
> +
>   #endif /*  TARGET_RISCV_CPU_VENDORID_H */
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index efdec49e49ed..85ce4d83a371 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3190,6 +3190,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.ext_svnapot = true,
>           .cfg.ext_svpbmt = true,
>   
> +        .cfg.mvendorid = TENSTORRENT_VENDOR_ID,
> +
>           .cfg.max_satp_mode = VM_1_10_SV57,
>       ),
>   


