Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743B8D44C7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQRy-0003Vl-2I; Thu, 15 Jan 2026 11:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vgQRw-0003UN-1y
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:43:56 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vgQRu-0001jV-If
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:43:55 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-5014d4ddb54so11516381cf.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 08:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768495433; x=1769100233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X89QpuI6QDEihOpyrs/cvhqZeN6bdh9pqeSWXqR7ryk=;
 b=JXmnAs1arjG6ocIP1EV2QzsWKl+JwnHGpR+lDoXyDES+gcBtv6kLu6p7swBIXA9qZN
 lVdLUI/TMZIeuDB01wXaDVzLESpxdLN+YPNGNjgzpJiIywpH1XL4kUjFK25gcwyDD4Fk
 NLyog1chW9cAux3PDYBIFt/3XTfV/nqaAF4sV4bFk/mJpMuVuA9IUJT/1aY5qozMZBat
 J0cORDRvK1fjlgbuTDGolsdMT14qC5KzZJOKztBu6oLaqUddH5w/IDs23kaWwO21YLCW
 ryyT2XU1lHG0DaZxbgkMjmiDXFKQt0vNTlmm2J1j9gssMawh6Tw2y2K76OS1JSysN3YN
 t3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768495433; x=1769100233;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X89QpuI6QDEihOpyrs/cvhqZeN6bdh9pqeSWXqR7ryk=;
 b=mKfK4wUBo0d3uZL5g8z0cvFu8m6YHpsayCoC17hvKbaV1+eczELh+iOKTTcghHz0Vd
 tivAYQ68FHVW9I0phwqyC4i8GAQreZQNi+xRgGZvDciN1Ha/uQJ5ofSVKeU+N1poHlvn
 lW/Jswq9Odd1PeuSlPKVt08pgq/o1QpHgHqPmb6CCqR0CSdhyaFv9m3Z3kI4cW+p0Dw/
 MGHy4XVvsJF/VlOsOokPhMKdsLv4FxJJhu0ojJq4on302gtrg8/kIRblViTmASS3Beod
 lp6E0+iC2jjDFcqmJ5Ob326NNVm+jhCXf1wnWns8fyqO4q/68OxviOA1RgkNs42murWZ
 ppsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ5CB7JOG7eRvfWVzvEpzOKUeeNy8T8qj2AtD8Shpdx4O8CqL8JOMUtZA01ydRWD5FC3RiRrts5EdJ@nongnu.org
X-Gm-Message-State: AOJu0YwsWWl3VumioOQqGpgjuUtKiXCGtCruFyk1Mt83DpvM/QwTYeLG
 7asqlHckkCJXsUOVuvIXLQsFs9Y7voeO63FvBSAkVgQJHXCzxDuIrJUteMpfN/5dX6Q=
X-Gm-Gg: AY/fxX6Q2BEigfQ0huEYypFKGiGTlB9zpddo5f/8nQvb+yohUvJbuH3554jm9f9woOO
 OqmZiP/bCtP2IHVz0jm4ph5JIpBnRdBWKuKpKzLgMNGJHedePHmFEIB4iUCY46IbRKHZJcpivux
 Yd/MCe/pivju2MmikkDqFcVgxKLRNP7yhD/7DzxTSAEx8P6ua/mk6tReav1jLbap2veNEnwha4E
 REzmFqxJiX3VJmppEoB1AJFL60KRWTwwWf4DlnJrGia3rtWhHPMf2TR5le9IgdaZdVrjpMVUEmm
 T68dirMal+wF4ZJslOdxSjDYftFl80Uz8XGhxUy3QHtuO0wmXPeo4jlIX5rXnSArFF5i83ImiTg
 Sp/Fs7rPMaeWKo3BeTWb6qu7EsuuJ+4U9wzj4T+9I9YANzb02ATHwfeWiNz6dMIb0godYRdCHgH
 bY/b1qC0eMzIu+gKIiDABiP/JmpL+4UkX4UjdCXsFS
X-Received: by 2002:a05:622a:44e:b0:4ee:1b0e:860b with SMTP id
 d75a77b69052e-502a168934cmr1481261cf.23.1768495432735; 
 Thu, 15 Jan 2026 08:43:52 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50148ebac91sm38903051cf.21.2026.01.15.08.43.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 08:43:52 -0800 (PST)
Message-ID: <5c30fdd8-4d97-4424-aba6-f10a6528d74b@ventanamicro.com>
Date: Thu, 15 Jan 2026 13:43:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/riscv/boot: Describe discontiguous memory in
 boot_info
To: Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Vijai Kumar K <vijai@behindbytes.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
References: <20260109131657.396794-1-joel@jms.id.au>
 <20260109131657.396794-2-joel@jms.id.au>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260109131657.396794-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x833.google.com
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



On 1/9/2026 10:16 AM, Joel Stanley wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Machines that have discontiguous memory may need to adjust where
> firmware and images are loaded at boot. Provide an interfaces for
> machines to describe a discontiguous low/high RAM scheme for this
> purpose.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/hw/riscv/boot.h |  7 +++++++
>   hw/riscv/boot.c         | 11 +++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index f00b3ca12245..115e3222174f 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -28,6 +28,10 @@
>   #define RISCV64_BIOS_BIN    "opensbi-riscv64-generic-fw_dynamic.bin"
>   
>   typedef struct RISCVBootInfo {
> +    /* First contiguous RAM region. If size is zero then assume entire RAM */
> +    hwaddr ram_low_start;
> +    hwaddr ram_low_size;
> +
>       ssize_t kernel_size;
>       hwaddr image_low_addr;
>       hwaddr image_high_addr;
> @@ -43,6 +47,9 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
>   char *riscv_plic_hart_config_string(int hart_count);
>   
>   void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
> +void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
> +                                        RISCVHartArrayState *harts,
> +                                        hwaddr start, hwaddr size);
>   vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
>                                      hwaddr firmware_end_addr);
>   hwaddr riscv_find_and_load_firmware(MachineState *machine,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index e5490beda007..9babb85b0458 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -69,11 +69,22 @@ char *riscv_plic_hart_config_string(int hart_count)
>   
>   void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
>   {
> +    info->ram_low_start = 0;
> +    info->ram_low_size = 0;
>       info->kernel_size = 0;
>       info->initrd_size = 0;
>       info->is_32bit = riscv_is_32bit(harts);
>   }
>   
> +void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
> +                                        RISCVHartArrayState *harts,
> +                                        hwaddr start, hwaddr size)
> +{
> +    riscv_boot_info_init(info, harts);
> +    info->ram_low_start = start;
> +    info->ram_low_size = size;
> +}
> +
>   vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
>                                      hwaddr firmware_end_addr) {
>       if (info->is_32bit) {


