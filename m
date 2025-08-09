Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA800C87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 12:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukj1B-00009c-5f; Sat, 09 Aug 2025 08:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukj19-0008Ut-SP
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:49:47 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukj17-00078w-LO
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:49:47 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-24022261323so40289495ad.1
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754743784; x=1755348584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w09CCBVYqUo5pbgfurzsAoBNtKNzmPl0DGwTqnWOIG4=;
 b=BvdhP8t0JTv3mcidfOWh6BRozAeigboZJptAjnYBao9h2J04crczJWl+qwpUdm1GA4
 aTc3jX2n6YbU3UEAI6pPU8aQcLxuIj+k73Wc1pHhx0Qb+U4soKGeqY2bvKbWshYAnXTe
 sFrwHDvn3Ff1TI0OiGeqsJ2Dut5CYVXiNhFQfSAexnq4j81VOltUuOBDqnOqM/B7KVs3
 AvcveXc1ph09a5PdNsN+gxfkDFIpBw5LVc+0pGSvvajd3qehk3kmmigYN9xBFzksiaih
 Ak1UqCqFUzil8J1T4VTFpinGwgAeuhW9mu87Ftjj6Biz7BHkt1DBpKz9lmV9F6fPgpcW
 B5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754743784; x=1755348584;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w09CCBVYqUo5pbgfurzsAoBNtKNzmPl0DGwTqnWOIG4=;
 b=BwThksSKYTHsmhyJ1tfZVeNh1Ke1RFyTr4coEn6kLBIMX1YD6zo+3pzfosu0nnLJc/
 UjIxie3CX/m49VY0sO9nFdJ1oTAIFF2XMOM6wflyhXQsLQ37Y/u9hGg778/7Oq9FkeNU
 XMOJaLbmplpxNTSoVEHJRAPURPf+ikVjOZ49QOB181Vhtm96p0xJFGpv5/CsPD8NSMGl
 wmy2yUDqvlD/Yc/4QtSuBgs4o+XyrlwOY5N3RsG19L6Wl7b24msPJZ2t8n4uk9FmNcwW
 iicZsIuzGEEidVozNMYsle1Y3ZKNHKMRP7WZ/07/aYuEj0V4zdJBqgAmQFOlGo2aPL/K
 QYUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnLsLtDxZhGFi/8xM0N+PhNbzxzXLBYCuRy/MDTPylAgqOAEHlmotLcQNfBzvwLR+p5YUotSuIk6l/@nongnu.org
X-Gm-Message-State: AOJu0Yz4wy8D+w0TnXHxeSuo3cAJJdzTsZKdi+qtUQ2Tt7hx4cltVYBo
 NPgaYFa/JuSw40KESR+s3qy71naW/q/vVBn1/We0KU73DSG8kRJlLTvM57wEDCPFht0=
X-Gm-Gg: ASbGnct46zKYmVLborrEqKGxCxDB3xbTkNgpxTkK1dKAc98Vas+65FoigfZ11nMqVQg
 QlOusY1+z3FQl3MsNOvFVZE1BpxgBTr0yDTNEOWrt35jJaTWlIlWxyxkzA6b1d6XpJdA2vKyrac
 RE3avnCJfZZx1MR0JhxkGCWA5XPZiZTUvIuRgK9VzUtij9cVHf4iJWpdk2T1WYzSI8hJk4RQAaD
 dkaDU0LkwASYLLLIskma3CYhKW94jGiehBTN1CNI3IbVXkTri0EhJbWP1IWAGwqmB8vK40iUWlv
 Qa4mnklJyQdbYkcFTl4MKHJMKtTaeN/ev0iNJcaYZAseiPp2G+O+ylU2i41U0MAMdSgskBeWEtt
 EwyDwKL2x7D1zHCRyQXMKqfnPp9S7qCzq8unB7w==
X-Google-Smtp-Source: AGHT+IH2Fciw8X05TFXG1pDAD73gDFYh2OONxZm9M8tzQuRsrchUI1YkD2KJKjxtu2GG1aU3+zfSSQ==
X-Received: by 2002:a17:902:f54d:b0:235:e1e4:edb0 with SMTP id
 d9443c01a7336-242b0792788mr189784435ad.22.1754743783918; 
 Sat, 09 Aug 2025 05:49:43 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef83f3sm229602175ad.28.2025.08.09.05.49.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 05:49:43 -0700 (PDT)
Message-ID: <5c159058-83a5-487e-87ca-6d2d3211b0f4@ventanamicro.com>
Date: Sat, 9 Aug 2025 09:49:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/18] target/riscv: Add defines for WorldGuard CSRs
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-9-jim.shu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250417105249.18232-9-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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



On 4/17/25 7:52 AM, Jim Shu wrote:
> Add CSRs for 3 WG extensions: Smwg, Smwgd, and Sswg.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_bits.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index a30317c617..7705c6995e 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -408,6 +408,11 @@
>   #define CSR_DPC             0x7b1
>   #define CSR_DSCRATCH        0x7b2
>   
> +/* RISC-V WorldGuard */
> +#define CSR_MLWID           0x390
> +#define CSR_SLWID           0x190
> +#define CSR_MWIDDELEG       0x748
> +
>   /* Performance Counters */
>   #define CSR_MHPMCOUNTER3    0xb03
>   #define CSR_MHPMCOUNTER4    0xb04


