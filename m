Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C45CCF9E4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU36-0008K7-5j; Wed, 25 Sep 2024 11:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU31-0008IV-28
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU2z-0003ih-FL
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfHyjlV4+MV8F272k1DKLQ0/7Rg5osM61UO5gaDk8HQ=;
 b=GEfiNnHoyEaZaxvmFcFgUb9e+oH4dkY5/ysHHUMJaXdZKHNNt5G+Mv2QJEstRddxZwPOCl
 ywy4+4Ph3swSOTyqoNvVh4fFrUXvrg6jX8HQAAY8q2qwp8BhOE28Cj006Q4YKjIhBYHxqc
 92rHx29wuVJgJLq9FXrBCplnoklxcGs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-9Au4847KNsSYrQTo08qNiw-1; Wed, 25 Sep 2024 11:35:19 -0400
X-MC-Unique: 9Au4847KNsSYrQTo08qNiw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374c9b0daf3so2650302f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278518; x=1727883318;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SfHyjlV4+MV8F272k1DKLQ0/7Rg5osM61UO5gaDk8HQ=;
 b=D1d8ZHsv7uSU0z708a52szlOy90ElUGbL+Jf6nycoh2XIeClShVivo/JUSYcr6sUci
 XKitkvKWXlPGkeWMRCBWZwUGBugvEzWPXLgG9Z51MJeAZd+FbCqPEOPzINCB8awVVohA
 ah500FFNBv4/ddILFqIsxB5d1BW4GU5oUBGTH1ze2Xw6+ZzNgd/gbwHYFw6GTTT2NrEA
 dp4/Dv3K9NT4PhOrgBGFIP+anfMvXqNVKSl26xiv1t2MKBtwumxD806jJiNk1P/xgjdD
 bJV6m28deUh3xgArbfIk2vxYPbGNrYT5cMyHHitY+bM9//lBw2AfZ93KJF0eVCPJ4EUJ
 DDEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhTWQVmBMv7euSg9N1sln7Zp4BN0YRIeduj0k3/SI1zkWhMkItdD74dq8VZDiKNM+aFcnGLAGy1RnB@nongnu.org
X-Gm-Message-State: AOJu0YyYtfaFmPnAusx10S6qWkYMeVCOgj7VT37yQzMKPfD5n4O5fNZV
 NEzaCDzl9lphiYhYo/oV37dLozN1D+vfpkEDn1XwtCLazHBwBGe0bFFFbQ0il4kTIcrGXiQRxXJ
 BOsZdaNUqi7kiEQxdFm5d5qHrlVnEdMcPnBIQuInFK5720GM0W8px
X-Received: by 2002:a5d:4807:0:b0:37c:babe:2c49 with SMTP id
 ffacd0b85a97d-37cc24685aamr2109260f8f.19.1727278517790; 
 Wed, 25 Sep 2024 08:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN8pf9Q6R7wRTbOoy3fHfY8/71w7SO0a2NiSpekylUq9rvtq8wekjtKxcx2a673mTDp4wrJQ==
X-Received: by 2002:a5d:4807:0:b0:37c:babe:2c49 with SMTP id
 ffacd0b85a97d-37cc24685aamr2109229f8f.19.1727278517279; 
 Wed, 25 Sep 2024 08:35:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc31f77esm4364053f8f.108.2024.09.25.08.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:35:16 -0700 (PDT)
Message-ID: <72a2d6aa-07c2-403f-9db5-5a17d98de6ad@redhat.com>
Date: Wed, 25 Sep 2024 17:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 01/23] hw/ppc/e500: Do not leak struct boot_info
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-2-shentey@gmail.com>
Content-Language: en-US, fr
In-Reply-To: <20240923093016.66437-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/23/24 11:29, Bernhard Beschow wrote:
> The struct is allocated once with g_new0() but never free()'d. Fix the leakage
> by adding an attribute to struct PPCE500MachineState which avoids the
> allocation.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/ppc/e500.h |  8 ++++++++
>   hw/ppc/e500.c | 17 ++++-------------
>   2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
> index 8c09ef92e4..557ce6ad93 100644
> --- a/hw/ppc/e500.h
> +++ b/hw/ppc/e500.h
> @@ -5,10 +5,18 @@
>   #include "hw/platform-bus.h"
>   #include "qom/object.h"
>   
> +typedef struct boot_info {
> +    uint32_t dt_base;
> +    uint32_t dt_size;
> +    uint32_t entry;
> +} boot_info;

or simply move the fields under the machine state struct to avoif
the struct boot_info which doesn't seem that necessary. Is it ?


Thanks,

C.



> +
>   struct PPCE500MachineState {
>       /*< private >*/
>       MachineState parent_obj;
>   
> +    boot_info boot_info;
> +
>       /* points to instance of TYPE_PLATFORM_BUS_DEVICE if
>        * board supports dynamic sysbus devices
>        */
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 3bd12b54ab..75b051009f 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -80,13 +80,6 @@
>   
>   #define PLATFORM_CLK_FREQ_HZ       (400 * 1000 * 1000)
>   
> -struct boot_info
> -{
> -    uint32_t dt_base;
> -    uint32_t dt_size;
> -    uint32_t entry;
> -};
> -
>   static uint32_t *pci_map_create(void *fdt, uint32_t mpic, int first_slot,
>                                   int nr_slots, int *len)
>   {
> @@ -919,7 +912,6 @@ void ppce500_init(MachineState *machine)
>       bool kernel_as_payload;
>       hwaddr bios_entry = 0;
>       target_long payload_size;
> -    struct boot_info *boot_info = NULL;
>       int dt_size;
>       int i;
>       unsigned int smp_cpus = machine->smp.cpus;
> @@ -974,9 +966,8 @@ void ppce500_init(MachineState *machine)
>           /* Register reset handler */
>           if (!i) {
>               /* Primary CPU */
> -            boot_info = g_new0(struct boot_info, 1);
>               qemu_register_reset(ppce500_cpu_reset, cpu);
> -            env->load_info = boot_info;
> +            env->load_info = &pms->boot_info;
>           } else {
>               /* Secondary CPUs */
>               qemu_register_reset(ppce500_cpu_reset_sec, cpu);
> @@ -1274,9 +1265,9 @@ void ppce500_init(MachineState *machine)
>       }
>       assert(dt_size < DTB_MAX_SIZE);
>   
> -    boot_info->entry = bios_entry;
> -    boot_info->dt_base = dt_base;
> -    boot_info->dt_size = dt_size;
> +    pms->boot_info.entry = bios_entry;
> +    pms->boot_info.dt_base = dt_base;
> +    pms->boot_info.dt_size = dt_size;
>   }
>   
>   static void e500_ccsr_initfn(Object *obj)


