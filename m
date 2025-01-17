Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44318C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiF4-0002kM-VS; Fri, 17 Jan 2025 04:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tYiF1-0002ah-03
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:02:12 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tYiEy-0008Bh-Ol
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:02:10 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso974470f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737104526; x=1737709326;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jCt7kzcuNwkvxmtrk64kX3QJrtJaNrqEtkO0ONKUO8Y=;
 b=cFw6uKTDyXfXVLAxd1+/HbHKxWSkRSukRoMeZZxAH1ENwrBKWkr43MEUITUZbHl3Xy
 uuXEh0SBa/uHWNFjWxhadJMCWmxTCwpkvsSe/PC6JFV1Q83N7aADM9WFPqmb/TLO2KxO
 xl31zGQnMQA9TqFU3zMl8tof7QTizm+y7xzkUv/zQ8Mz1VJ7MDHrGV/0AiReSYNUu8jp
 lfUg9oK9UEAQh/s1nHwtFh+Al2c7fC3wqdFJm4lx+9+0Q6aBCq2Hzeic7/zcWkHjqJlJ
 YFgStUYXQuJ4YpQclxQo8FG6lsabnJ0bMjlvrFyEKebYZaBmPa0N7+UFdMF/werPMiVa
 jxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104526; x=1737709326;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jCt7kzcuNwkvxmtrk64kX3QJrtJaNrqEtkO0ONKUO8Y=;
 b=EbltINbVoOUrPuKwkMP5vGj/VPuchQm6xQGHf1rh1AUyPNj9ZlugOF3V5+jZ5W3AxU
 HD9PgAME/6FQT9UDmrbwxbAVK8z14LahTaVr1tBAwuRBzgIiPj9HswZsBy/xkJrT/cEH
 e5HRe9ZyhCRn+AHeiHhuJi5OSp5RrHw+5EcyUmxg0C1fhe4Mt9OH+2+0z8q1L7HVFsxP
 Ovtxonm5F5SC3H99Vyo+eXpzd5QdpbHEKqAEyoiDJcuDknY0GmZCQIXlIPEtGWAVTbyv
 YSxdjumACsDXm2Vjh+pcODKT61HtRgCLA7A+WR0PZ5zwgxU4KRVaQtezJ5SeTRy+zObK
 CJ7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPdYjtOyAhLWKzRXUv+VNQ/m76xdB+CbDhPUXDBvgHBPJyhGSkI6/WLA3IYdwHWVZIlQ0rbRACGzgg@nongnu.org
X-Gm-Message-State: AOJu0YyvVIGuZzmdO3lOaNB7+PXAt1/APzB5SQ6TiiWfxfQ0ifJ+06qG
 4qX32VaXmrCk1hXChzvaw5vfp7bjtj0tOnrpme3MGLyRt4qrW2G16pCFv/WLhz4=
X-Gm-Gg: ASbGncsToZ1IuR49KH5Rp46Dx8gd0etwfYB3jYsmO+nKa/vQukKhywZR49L9P5w+2VW
 E4owfBkkOt8Z+u/bah1lh5cYzd9fxcQxmwP1tnWOnBLbVyTZMGtqdEKIEKSUQH9MiuWP54jUW/J
 ha38jYbZIpLTDh5D74p3Z9QF4bPQKbc4dH1vDAXVZXxBy/8METUib4Njp3okhNOXKLY6ksSEZ+K
 tjVkIHd8UoZ+MCD0wQ1uJPUc+hySthAj/JPF9pVsnrK+Rmpst0uYGluN2mbVrky6RRzqduS+b24
 RicXPuWB8WeVTP/RPoCK/CZpaA==
X-Google-Smtp-Source: AGHT+IHwlm2AlHTH9dL9npjSppF7Cz+cBUZyqohmpo8XmZ5VECIMfKv/oboP8ma9XvwZdk5d4pB0Yw==
X-Received: by 2002:a05:6000:1a45:b0:385:eecb:6f02 with SMTP id
 ffacd0b85a97d-38bf5798338mr1197135f8f.28.1737104525992; 
 Fri, 17 Jan 2025 01:02:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890468480sm26174905e9.33.2025.01.17.01.02.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 01:02:05 -0800 (PST)
Message-ID: <957cd781-7d3b-4483-b2b1-5f1ec18beac7@rivosinc.com>
Date: Fri, 17 Jan 2025 10:02:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 47/50] target/riscv: Add Smdbltrp ISA extension enable
 switch
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
 <20250117055552.108376-48-alistair.francis@wdc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250117055552.108376-48-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hey Alistair,

While doing a non regression with default bios (OpenSBI 1.5) and max
cpu, Atish found that this breaks boot with OpenSBI 1.5 since it does
not have support for double trap clearing. On Henrique guidance,  I
resent this patch alone with an associated fix. :

https://lore.kernel.org/qemu-riscv/7d3df2ef-14b0-47ad-a843-668f146e26de@ventanamicro.com/T/#t

Sorry for the trouble, thanks,

Clément

On 17/01/2025 06:55, Alistair Francis wrote:
> From: Clément Léger <cleger@rivosinc.com>
> 
> Add the switch to enable the Smdbltrp ISA extension.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-ID: <20250110125441.3208676-10-cleger@rivosinc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e3ed11b0fd..bddf1ba75e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
> +    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>      ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
> @@ -1626,6 +1627,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>      MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
>  
>      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
> +    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
>      MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
>      MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),


