Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CD6C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gx4-00067e-6n; Wed, 08 May 2024 09:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4gwu-00066Z-SF
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:03:12 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4gwl-0005Wc-UX
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:03:08 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e6a1edecfso164298a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715173377; x=1715778177; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BFkISJ3hiYQ1bEQIj1j8vsw6Im/kbugGk/F1oVAO2HQ=;
 b=klCRt/LjA7lrsxXyUtj1XQHfz8rXh7tOAXJKtcoCVXAOum1H9ySyL9Vg92swAnNXep
 up7D6gNltjtH33vp1PHkvbuqrnwaYQaqQxxq5KcPkUgQiUqV5Q8yA5WzhYgkil+rDVtZ
 KHHbo00I6fBZdF9HbDFQu9GJ9eywMzMrD9gSqiFEWpQNQoC2wLlnP8EwU2KTYfiMFosg
 Zuh/pAJ8ZuSpocIqkTfqdzPYIhzH0m6DKuSCk3AnZQhY/0eGuTEsbCdUdhEC6Z4Zx0/+
 J6McUl3M1ry9dun3mDIGTSDGWe7roFAVZPbhTq4mL/0hvGYHSyfa8ZOPEKzHZ4NliXk5
 zCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715173377; x=1715778177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BFkISJ3hiYQ1bEQIj1j8vsw6Im/kbugGk/F1oVAO2HQ=;
 b=qBtPBwBz7aje9QUDr6+xjiTRqGBP2zyXtLA+064XIvzdGv4HfapOJLXMgPUDiaH/4v
 mHZbEXUQ+SF76NWpmtinYmlJrs//X51Pwe45Eo8XklEROyFISKDgrf9ETcJj+3kG7VYY
 Yo7TYP11PUmtg0vT5ppc8/jetz0yq2qqBcdoD6MIYQI5XvnkuoQir3nGA+Yfe7HtLVNT
 slG2oz4r0u+A6W14PwYPJkIH7gm2B2JGQP2oPeGPI4nzEVogxl/XBf05U8vxQzKRqyE5
 VT6CosWxtOSLEoVSnULCAID3FTRW2nJpYAhXRCNZ7gBKVwmII6lC/hH1dNg7nxigIpOr
 fNXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAySUE+8O/N3Fzg86E6pRroBLka5vqbz+AFOmcVzjPkEXUuuNv9ZXWd5QefdWOYsuYqMqpn5GlJwm3CDy2pNkU5anwnB8=
X-Gm-Message-State: AOJu0YzOufr/JfNAYG2mMUiURWiAN13bPRCIbBkffLLs7vvY5nZh5pQv
 /fjZbwDmC3bkHOfEkptpLqyzczSc2HFW1cSV+y5nB4oPmfzoAHmWo/e5Uuy8NkFm1xlTL3Fjc04
 cm8ez+bPrs9ybWQVeX61T90+b8t8ZuBchHDvlsKdDH3kccjjd
X-Google-Smtp-Source: AGHT+IEMKflFgzB0PLQtTSeQBMjb3HG7UVABdjDgV16PnHrhC7WjFdsC0J88wdiMwK6Y4V4toAUZjSS82wH9hCGlVEM=
X-Received: by 2002:a50:9fe6:0:b0:572:7142:22e0 with SMTP id
 4fb4d7f45d1cf-5731d9cd37bmr1725733a12.4.1715173377454; Wed, 08 May 2024
 06:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240508023031.3127531-1-gaosong@loongson.cn>
In-Reply-To: <20240508023031.3127531-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 May 2024 14:02:46 +0100
Message-ID: <CAFEAcA92bwWvf8NiOtM4M=gDZ0NbsewhsPo1+UMQHM=dnhxDKw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/loongarch/virt: Fix memory leak
To: Song Gao <gaosong@loongson.cn>
Cc: mjt@tls.msk.ru, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 richard.henderson@linaro.org, zhaotianrui@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 8 May 2024 at 03:30, Song Gao <gaosong@loongson.cn> wrote:
>
> The char pointer 'ramName' point to a block of memory, but never free it.
> Use a small fixed-size buffer for 'ramName'.
>
> Resolves: Coverity CID 1544773
>
> Fixes: 0cf1478d6 ("hw/loongarch: Add numa support")
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
> v2:
>   - Use a small fixed-size buffer for 'ramName'.
>   - Link to V1: https://patchew.org/QEMU/20240507022239.3113987-1-gaosong@loongson.cn/
>
>  hw/loongarch/virt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index c0999878df..ee690ad981 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -887,7 +887,7 @@ static void loongarch_init(MachineState *machine)
>      const CPUArchIdList *possible_cpus;
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>      CPUState *cpu;
> -    char *ramName = NULL;
> +    char ramName[32];

Please don't use fixed-size char arrays for writing strings like this.

>      if (!cpu_model) {
>          cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
> @@ -946,7 +946,7 @@ static void loongarch_init(MachineState *machine)
>
>      for (i = 1; i < nb_numa_nodes; i++) {
>          MemoryRegion *nodemem = g_new(MemoryRegion, 1);
> -        ramName = g_strdup_printf("loongarch.node%d.ram", i);
> +        sprintf(ramName, "loongarch.node%d.ram", i);

The nicest way to fix this is to use the g_autofree mechanism
so the memory is automatically freed at the end of the block:

   g_autofree char *ramName = g_strdup_printf(...);

>          memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
>                                   offset,  numa_info[i].node_mem);
>          memory_region_add_subregion(address_space_mem, phyAddr, nodemem);

thanks
-- PMM

