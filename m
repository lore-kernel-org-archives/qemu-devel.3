Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34C8E7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 23:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIyzB-0004gO-8S; Wed, 04 Dec 2024 18:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIyz6-0004fV-Rw
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 18:40:45 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIyz5-0001mj-5D
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 18:40:44 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-71d3e506981so90238a34.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 15:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733355641; x=1733960441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X0uueNgZo+lnfnqqxlnsrVMa9vkhOKu0rJ260PIxZ0U=;
 b=iuYfYtCOAViwTN4w4WXZAfRVxxXqEjbhdBtujkBckEtC10pMhd2sLeEBXfci6tpDkK
 V7LUyQrUVf6c/lkeZw+n0kSkAb/D7XhdWHFsIqf3dRnBXjjmlhoVhWgh1kuDAji245zR
 JAOKvOVi/SjlYlqFQZiB3P5qU11Y8zy5GR1MQ7Wo5H8d2HL7pSWkE1h3rQD8MwiqU+wd
 kQerteiRksQYJDJEq0ItzYm+1k5FUeYaMxy85H1EWfRClC6jW1we9/sGO0shHwvMLQMR
 ZA/3463Oy0yTPSmlhw4c/piI2dSvqU5MVf+bH6R4AJCMBLvbyTkfoCxRLa+o9/DFzlBJ
 zu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733355641; x=1733960441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X0uueNgZo+lnfnqqxlnsrVMa9vkhOKu0rJ260PIxZ0U=;
 b=YiYaoO77GN1lpHLLIJDyCRPtdGW/PglG3hYV4ZJfSbmKxI2xqp3UFxEkfXwgDnsDtS
 gvTw49S/MRISdQDvenXXfx6gXKY5DFI8gOdB1ZNmsnqMvyeiuCAiDf66XkZcQRQR0zJz
 L402oiBsTnOAKIbSV0mo/DisrDy5/4nMusFyrhqhfc+gxzEf7biP20voGJ+GnD4H0zdM
 COHbhMwYKlpQUx9QcPCp7JkU10Smw0Cx3NWERtEkBw0dhI4ELKKCVWEykZdgLBzQ18s1
 tsilA2Zm4js8hxU7cSCr4bO8pLRbW8HTKJrCi1KiXU0wa2U/BX/ddDd8H1w71L1NNgkb
 wLew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCADVodP8vgRhY6WWjQcK8qk5mzK3MLIqJFu5JeBMGVjvFsK+F4ts/z8vuStFqSJFNjMvdjFeEnQ1w@nongnu.org
X-Gm-Message-State: AOJu0YxTWfEJ24P76VkrrI4SwYcrkd+sVCjs4dek85ICo8zxse5Mmt/m
 wnx47UqoUd7AUye0ikxrMmHzV0k9XiiAX7mKXbigE18KR/uen8fyNZsnPnWYpZ4=
X-Gm-Gg: ASbGncvGjSmPjdiDGlbqIH16vS1KcxWVBr1JQUCCWUrkvnolyWULwXklyGBrEkZGODM
 HtedkK5sdvEVjRpJsnFVkeAEtzhrGZxGWTur0bpg94mqWzxBFKLv+jQo6rwlXilpcW6oNIES5j8
 WU7TYxPLLaJ3+CgY2xOx1tV9NYyKaeM+ZD7cHhy9/EaN6evb3oJfvVqdWt049LdAQIYUoqXzb90
 AQ2VPUEX/2wFIef9C47uF4QF1MWhLd5KL0AIsdRyAt4k/TvYEA0coPIJ3K23gXFuCRktjBHEoB/
 2eU+6sd9z0tASoM2cnrMRKXJncQG
X-Google-Smtp-Source: AGHT+IFQHYOMQfa7B6HazZ0zqEJu0IPyWF6t9qfaZVLqhG6yg6b7iNWv4VNVZPVhCdgPFf81FPivOA==
X-Received: by 2002:a05:6830:3814:b0:71d:5209:5cec with SMTP id
 46e09a7af769-71dad606a5amr9568639a34.3.1733355641669; 
 Wed, 04 Dec 2024 15:40:41 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f279248359sm81539eaf.26.2024.12.04.15.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 15:40:41 -0800 (PST)
Message-ID: <7bfc605c-e870-484c-967e-94f71e46bf33@linaro.org>
Date: Wed, 4 Dec 2024 17:40:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/20] disas: Use cpu_datapath_is_big_endian()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Zhao Liu <zhao1.liu@intel.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org
References: <20241204202602.58083-1-philmd@linaro.org>
 <20241204202602.58083-18-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241204202602.58083-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 12/4/24 14:25, Philippe Mathieu-Daudé wrote:
> Rather that using the binary endianness, use the vCPU one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   disas/disas-common.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/disas/disas-common.c b/disas/disas-common.c
> index 7377de0715c..ef91c43449e 100644
> --- a/disas/disas-common.c
> +++ b/disas/disas-common.c
> @@ -7,7 +7,6 @@
>   #include "disas/disas.h"
>   #include "disas/capstone.h"
>   #include "hw/core/cpu.h"
> -#include "exec/tswap.h"
>   #include "disas-internal.h"
>   
>   
> @@ -61,7 +60,7 @@ void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
>   
>       s->cpu = cpu;
>       s->info.print_address_func = print_address;
> -    if (qemu_binary_is_bigendian()) {
> +    if (cpu_datapath_is_big_endian(cpu)) {
>           s->info.endian = BFD_ENDIAN_BIG;
>       } else {
>           s->info.endian =  BFD_ENDIAN_LITTLE;

I would much rather remove this if statement and force cc->disas_set_info to set this value.


r~

