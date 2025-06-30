Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD72C7EE39
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 11:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWCtO-00042H-8K; Mon, 30 Jun 2025 07:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWCtM-00041W-1D
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:41:44 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWCtJ-0006WN-Qp
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:41:43 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6facba680a1so24312776d6.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751283697; x=1751888497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7lAMPt/pj50WRkfjltobwmgNsB/GGXp6kM/HsYWsPgg=;
 b=YVYX4WngmDhdmDzUEj+5b7A9CUe7KCTAzcnM/d2ZWtGiPJjwRncsLUY4DT2hB0Y+0o
 lsBMpRGdEFlldfZmm36DXg0CfsCqlv6ej0WktTHifnZE9r7GzWZT9Pi8zAf/lu563ZQY
 TMIqQ0PZ37Yqx9CCm3+RRq1GOH7K3MoBDyfA64xT0EXZwt7ojPDyHT1DAkd7NjhV2JCg
 BjZCksVIS+UsCzfFpmKgFknnTsBel64glgJringokRhnFM5BTIrh9gIdLiECnGwP1tCN
 Df7RQnSrc9PQHK/+8PzLoIp/yI4PSCtD7C4VDDiXN8PynW4eQyNyh9jrYHgl7sOsEZRQ
 nKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751283697; x=1751888497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7lAMPt/pj50WRkfjltobwmgNsB/GGXp6kM/HsYWsPgg=;
 b=np/sgjiBLcyQ3xyS2MrJQwMJAV43r3sdXDRNq5ILwIABhmCu25zOcroQuJxDO3WLVv
 04SjKp8dHHjAtTUqxn66Gnwd3IXt1g3jduM5NURM/Q9HWo7DQRSTTfBfOGyVR+ddZVHn
 UYBxeojGK6yq1o9NA0cUGfyjoQukQLR4IqBU6qQzrketAdpQQFz4rNCyeF4DAMI1HCyO
 V/MeRA3MI1cuQojgDdOUxY+U5CehkLhvMpHjf72P84JCYbavtzLCHgYGq0hFUpjJxK0V
 ysAQGg82DKiajy/ax3Kf5tYPZW4iRxIGzLcBT5UYxM1fYGPBCgtDZzMf6imzmwz5t9P1
 c9Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGqUld39G/rXqpMqYX3TVwOAeP3hcMOogMBXWk1V2IK9Z8Pccg6C+yUY5e22432k9J1+we7gxonA9m@nongnu.org
X-Gm-Message-State: AOJu0YyfbSsaI4jFnPGr7d7Zk5kvZSXwHo4HgMkm30a6v3bsKcJObu+r
 J4v6vvS0uCTR9xPQ5A9wM0zbpU6S0yfGx75Olk6p2nMMViEkQJ49j7jiQM1BfIoV0C8=
X-Gm-Gg: ASbGncuZwje6vzbOFL5dkGsd8jSx3GKqFZpA5ad3PN8+K20nk3dzWyucmBpaXEe6Qhi
 69z5mabX9tqTaYARHjW543+r4/I54x0liEb6ikAw+RPaACiB9hjSBK6aUBVPsxx4PeR99VGC79i
 jho1fCyG0bLU0rQ6i0cXZhZfaCMcHKflumshRfCrTpo2YSHsKElxnRmmkIfwIEnqiJtPIEObeWX
 FZl6U6K967PrGl8V3YcOS+iNlGKikzRToDv8if7fOoKC/T3hxN2rLfEJbtxSEX4O61JnaYYlmiU
 ahMPyTtzE6uP6UehMomrGlBQntcIYWWFHhh0+SUsfZ0gtriCddNIfWWtwUHb7yAXRmuvyYSkfm0
 =
X-Google-Smtp-Source: AGHT+IENwUJpuba5vfcQgp4Rt52itQO7CIMW2tNeW7PG+hjXhCMYuY7kL8OB8cd8759y5cvvdaIstg==
X-Received: by 2002:a05:6214:234e:b0:6fa:cb05:b455 with SMTP id
 6a1803df08f44-700141348ccmr203997366d6.35.1751283697232; 
 Mon, 30 Jun 2025 04:41:37 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd772fc8f3sm65716716d6.84.2025.06.30.04.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 04:41:36 -0700 (PDT)
Message-ID: <9b0f4a24-f1cd-4973-947f-49a5459d28a3@ventanamicro.com>
Date: Mon, 30 Jun 2025 08:41:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] hw/intc: Allow gaps in hartids for aclint and
 aplic
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
 <20250625141732.59084-2-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250625141732.59084-2-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf32.google.com
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



On 6/25/25 11:18 AM, Djordje Todorovic wrote:
> This is needed for riscv based CPUs by MIPS since those may have
> sparse hart-ID layouts. ACLINT and APLIC still assume a dense
> range, and if a hart is missing, this causes NULL derefs.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/intc/riscv_aclint.c | 21 +++++++++++++++++++--
>   hw/intc/riscv_aplic.c  | 10 +++++++---
>   2 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index b0139f03f5..22ac4133d5 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -292,7 +292,13 @@ static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
>       s->timecmp = g_new0(uint64_t, s->num_harts);
>       /* Claim timer interrupt bits */
>       for (i = 0; i < s->num_harts; i++) {
> -        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
> +        CPUState *cpu_by_hartid = cpu_by_arch_id(s->hartid_base + i);
> +        if (cpu_by_hartid == NULL) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "aclint-mtimer: invalid hartid: %u",
> +                          s->hartid_base + i);
> +            continue;
> +        }
> +        RISCVCPU *cpu = RISCV_CPU(cpu_by_hartid);
>           if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
>               error_report("MTIP already claimed");
>               exit(1);
> @@ -481,7 +487,13 @@ static void riscv_aclint_swi_realize(DeviceState *dev, Error **errp)
>   
>       /* Claim software interrupt bits */
>       for (i = 0; i < swi->num_harts; i++) {
> -        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
> +        CPUState *cpu_by_hartid = cpu_by_arch_id(swi->hartid_base + i);
> +        if (cpu_by_hartid == NULL) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "aclint-swi: invalid hartid: %u",
> +                          swi->hartid_base + i);
> +            continue;
> +        }
> +        RISCVCPU *cpu = RISCV_CPU(cpu_by_hartid);
>           /* We don't claim mip.SSIP because it is writable by software */
>           if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0) {
>               error_report("MSIP already claimed");
> @@ -545,6 +557,11 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
>   
>       for (i = 0; i < num_harts; i++) {
>           CPUState *cpu = cpu_by_arch_id(hartid_base + i);
> +        if (cpu == NULL) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "aclint-swi: invalid hartid: %u",
> +                          hartid_base + i);
> +            continue;
> +        }
>           RISCVCPU *rvcpu = RISCV_CPU(cpu);
>   
>           qdev_connect_gpio_out(dev, i,
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 8bcd9f4697..360a3dc117 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -899,9 +899,11 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>           if (!aplic->msimode) {
>               /* Claim the CPU interrupt to be triggered by this APLIC */
>               for (i = 0; i < aplic->num_harts; i++) {
> -                RISCVCPU *cpu;
> -
> -                cpu = RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
> +                CPUState *temp = cpu_by_arch_id(aplic->hartid_base + i);
> +                if (temp == NULL) {
> +                    continue;
> +                }
> +                RISCVCPU *cpu = RISCV_CPU(temp);
>                   if (riscv_cpu_claim_interrupts(cpu,
>                       (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
>                       error_report("%s already claimed",
> @@ -1076,6 +1078,8 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
>           if (!msimode) {
>               for (i = 0; i < num_harts; i++) {
>                   CPUState *cpu = cpu_by_arch_id(hartid_base + i);
> +                if (cpu == NULL)
> +                    continue;
>   
>                   qdev_connect_gpio_out_named(dev, NULL, i,
>                                               qdev_get_gpio_in(DEVICE(cpu),


