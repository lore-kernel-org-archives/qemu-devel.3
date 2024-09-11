Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A63EE4997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLOQ-0001qQ-0U; Wed, 11 Sep 2024 07:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soLOL-0001lj-4x
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soLOI-00006a-C8
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726053605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pnkS05BRUyyEXgt9lXRphLEG8xWP3Lkyw39IXABWMMI=;
 b=dp+kilG/dj5GXIS806VSMh+ClY0tKFLAKI/rXr/NuNgbuKhBcTQnQILpy0KQqGkU6R27/u
 R/XWKKgDb/4xdNacg0hYKUhmsw1mupSj4Z9FY7NiRAqZh4Y9/3fZFmTTAsfj55tSR5g6/b
 93TwjVil56nqT/v/O5rCuLI6E2Z34i4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-WnWALfXxNVm4P5KFp6pDqA-1; Wed, 11 Sep 2024 07:20:03 -0400
X-MC-Unique: WnWALfXxNVm4P5KFp6pDqA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c3c27141c9so1180923a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 04:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726053601; x=1726658401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnkS05BRUyyEXgt9lXRphLEG8xWP3Lkyw39IXABWMMI=;
 b=ZJ/L0i2X2glUMXh9o5TU7FFciz+zO8ABRnd89yncFwtONAazoRyYYweqqtIv0ymrJ6
 ELRH+l6DJUS+8jBs85Zxe1odVu0hGe9T++al8FaetTnge4KCOWlub1O1jCjgSchefwu9
 TMOlBqeJNTLRNtg+/OOrppV1DoT2MlBC+38/HwmliE274C4CVkRuLwZ8YMggq+WuZO2z
 xVc1U1ZOLxffODeGzihCfSxXgZqmPSf5mZuIt08mKuXnAaB1TJcR7USwgJB5h+ao+9E6
 fimSx/ZGxGtIWp6gLN1HmUV2KypcKFf3TL4ilu76mqOisZP1ZNBBAUak3ZxHiSRdfpOQ
 qtng==
X-Gm-Message-State: AOJu0YyOsQQ4UgEU+oRmu3DgmPxlcORiAWRBwnru084Dcq1BNWUl4KcN
 pUQ5hctLxDplTjnfCXSxwz9XEVt72VkS7bCDwDAYY9bKMExlUx7A36hmtGroZ3jlPMhJiHDk7pN
 uoZJy1l5AdGn/wPBgeh+ndT2bzYzUM0WJLFZs+B56LOJsFQTpUKFZuCM1gLRI
X-Received: by 2002:a05:6402:27d3:b0:5c0:8ea7:3deb with SMTP id
 4fb4d7f45d1cf-5c40bc50412mr1896049a12.22.1726053600981; 
 Wed, 11 Sep 2024 04:20:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVHY1t9S+NiRwCQ1jMlvwfPQ4DSrTv6u46sALcF6vok/ScZNAKdbCAf5I4b6CTAg4kcgEBlg==
X-Received: by 2002:a05:6402:27d3:b0:5c0:8ea7:3deb with SMTP id
 4fb4d7f45d1cf-5c40bc50412mr1896019a12.22.1726053600078; 
 Wed, 11 Sep 2024 04:20:00 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd8cef8sm5352108a12.89.2024.09.11.04.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 04:19:59 -0700 (PDT)
Date: Wed, 11 Sep 2024 07:19:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hal Martin <hal.martin@gmail.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, anisinha@redhat.com
Subject: Re: [PATCH] hw/smbios: support for type 7 (cache information)
Message-ID: <20240911071848-mutt-send-email-mst@kernel.org>
References: <20240811104538.14223-1-hal.martin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811104538.14223-1-hal.martin@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Aug 11, 2024 at 10:45:38AM +0000, Hal Martin wrote:
> This patch adds support for SMBIOS type 7 (Cache Information) to qemu.
> 
> level: cache level (1-8)
> size: cache size in bytes
> 
> Example usage:
> -smbios type=7,level=1,size=0x8000
> 
> Signed-off-by: Hal Martin <hal.martin@gmail.com>

A bunch of style issues here:

> ---
>  hw/smbios/smbios.c           | 63 ++++++++++++++++++++++++++++++++++++
>  include/hw/firmware/smbios.h | 18 +++++++++++
>  qemu-options.hx              |  2 ++
>  3 files changed, 83 insertions(+)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index a394514264..65942f2354 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -83,6 +83,12 @@ static struct {
>      .processor_family = 0x01, /* Other */
>  };
>  
> +struct type7_instance {
> +    uint16_t level, size;
> +    QTAILQ_ENTRY(type7_instance) next;
> +};
> +static QTAILQ_HEAD(, type7_instance) type7 = QTAILQ_HEAD_INITIALIZER(type7);
> +
>  struct type8_instance {
>      const char *internal_reference, *external_reference;
>      uint8_t connector_type, port_type;
> @@ -330,6 +336,23 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
>      { /* end of list */ }
>  };
>  
> +static const QemuOptDesc qemu_smbios_type7_opts[] = {
> +    {
> +        .name = "type",
> +        .type = QEMU_OPT_NUMBER,
> +        .help = "SMBIOS element type",
> +    },{
> +        .name = "level",
> +        .type = QEMU_OPT_NUMBER,
> +        .help = "cache level",
> +    },{
> +        .name = "size",
> +        .type = QEMU_OPT_NUMBER,
> +        .help = "cache size",
> +    },
> +    { /* end of list */ }
> +};
> +
>  static const QemuOptDesc qemu_smbios_type8_opts[] = {
>      {
>          .name = "type",
> @@ -733,6 +756,32 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
>      smbios_type4_count++;
>  }
>  
> +static void smbios_build_type_7_table(void)
> +{
> +    unsigned instance = 0;
> +    struct type7_instance *t7;
> +    char designation[20];
> +
> +    QTAILQ_FOREACH(t7, &type7, next) {
> +        SMBIOS_BUILD_TABLE_PRE(7, T0_BASE + instance, true);
> +        sprintf(designation, "CPU Internal L%d", t7->level);
> +        SMBIOS_TABLE_SET_STR(7, socket_designation, designation);
> +        t->cache_configuration =  0x180 | (t7->level-1); /* not socketed, enabled, write back*/

bad comment style, line too long, bad math style

> +        t->installed_size =  t7->size;
> +        t->maximum_cache_size =  t7->size; /* set max to installed */
> +        t->supported_sram_type = 0x10; /* pipeline burst */
> +        t->current_sram_type = 0x10; /* pipeline burst */
> +        t->cache_speed = 0x1; /* 1 ns */
> +        t->error_correction_type = 0x6; /* Multi-bit ECC */
> +        t->system_cache_type = 0x05; /* Unified */
> +        t->associativity = 0x6; /* Fully Associative */
> +        t->maximum_cache_size2 = t7->size;
> +        t->installed_cache_size2 = t7->size;
> +        SMBIOS_BUILD_TABLE_POST;
> +        instance++;
> +    }
> +}
> +
>  static void smbios_build_type_8_table(void)
>  {
>      unsigned instance = 0;
> @@ -1120,6 +1169,7 @@ static bool smbios_get_tables_ep(MachineState *ms,
>          }
>      }
>  
> +    smbios_build_type_7_table();
>      smbios_build_type_8_table();
>      smbios_build_type_9_table(errp);
>      smbios_build_type_11_table();
> @@ -1478,6 +1528,19 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>                             UINT16_MAX);
>              }
>              return;
> +        case 7:
> +            if (!qemu_opts_validate(opts, qemu_smbios_type7_opts, errp)) {
> +                return;
> +            }
> +            struct type7_instance *t7_i;
> +            t7_i = g_new0(struct type7_instance, 1);
> +            t7_i->level = qemu_opt_get_number(opts,"level", 0x0);

bad comma style

> +            t7_i->size = qemu_opt_get_number(opts, "size", 0x0200);
> +            /* Only cache levels 1-8 are permitted */
> +            if (t7_i->level > 0 && t7_i->level < 9) {
> +                QTAILQ_INSERT_TAIL(&type7, t7_i, next);
> +            }
> +            return;
>          case 8:
>              if (!qemu_opts_validate(opts, qemu_smbios_type8_opts, errp)) {
>                  return;
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index f066ab7262..1ea1506b46 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -220,6 +220,24 @@ typedef enum smbios_type_4_len_ver {
>      SMBIOS_TYPE_4_LEN_V30 = offsetofend(struct smbios_type_4, thread_count2),
>  } smbios_type_4_len_ver;
>  
> +/* SMBIOS type 7 - Cache Information (v2.0+) */
> +struct smbios_type_7 {
> +    struct smbios_structure_header header;
> +    uint8_t socket_designation;
> +    uint16_t cache_configuration;
> +    uint16_t maximum_cache_size;
> +    uint16_t installed_size;
> +    uint16_t supported_sram_type;
> +    uint16_t current_sram_type;
> +    uint8_t cache_speed;
> +    uint8_t error_correction_type;
> +    uint8_t system_cache_type;
> +    uint8_t associativity;
> +    uint32_t maximum_cache_size2;
> +    uint32_t installed_cache_size2;
> +    /* contained elements follow */
> +} QEMU_PACKED;
> +
>  /* SMBIOS type 8 - Port Connector Information */
>  struct smbios_type_8 {
>      struct smbios_structure_header header;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index cee0da2014..3b49813fcc 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2706,6 +2706,8 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>      "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
>      "              [,processor-family=%d,processor-id=%d]\n"
>      "                specify SMBIOS type 4 fields\n"
> +    "-smbios type=7[,level=%d][,size=%d]\n"
> +    "                specify SMBIOS type 7 fields\n"
>      "-smbios type=8[,external_reference=str][,internal_reference=str][,connector_type=%d][,port_type=%d]\n"
>      "                specify SMBIOS type 8 fields\n"
>      "-smbios type=11[,value=str][,path=filename]\n"
> -- 
> 2.42.0


