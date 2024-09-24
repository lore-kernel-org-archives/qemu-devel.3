Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9D1CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 14:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st6Xk-0000CS-Ht; Tue, 24 Sep 2024 10:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1st6Xh-0000B0-J8
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 10:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1st6Xc-0003f9-LT
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 10:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727188162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1YyH42C9GrHIfxB6/cez2HW11STB126WUWZwtd/0DrY=;
 b=hsAHthqXaj/E0pDKksOdp0jI6iXGHJX0f7AKsiYG+ctrtXhpU7A3IRIa9GCgZeEOgs2FOl
 XtpsJdslJvTeUR7vcrLlrmZg/Jm/enwWtJQVRhhr38l6gSEwjbEuVSefto7AH/VWVu8Y3t
 8GkYPkUIDvg3eTkXNTx+YPzKtMuCrck=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-DHDQd9McPYaskTZDCkMhLQ-1; Tue, 24 Sep 2024 10:29:20 -0400
X-MC-Unique: DHDQd9McPYaskTZDCkMhLQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb33e6299so37036985e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 07:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727188159; x=1727792959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1YyH42C9GrHIfxB6/cez2HW11STB126WUWZwtd/0DrY=;
 b=AN0jSr10MyiNQsJvxn0F1Bxgba2Vi/VVrYlZk7aRJaWTGjq83sEWohBSP+BeplPJHQ
 i7s1kajCiB5YQSulhWgB7tSy1+CwJoHdkY1lKcUr+lwqEqBkZEImMkUL3xFw4mujMBCK
 8oWRFIxXmrOkqlXiEl9EyxYU4D2mPzw4/vKik+S2d1rdLuzpX3jn3DpFkjsIJpSVNJbW
 TEPnvU95wJYBOdunqQ8gMAS7QXmRIBKl6NJn2XIFNtfRJ3xyuRlvH/kDlKIS1e5PUhNt
 HZc7b85/Onk2fuxhar2qGKWwCspaE6qV6xAoYIGmrp/Oh5adqjzdF3M6KdLuZFJfp/K5
 Yvdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqJpWPEwr924vZxd0u0aDikTSMNckfqNSjAtd0s1Rtf5Yrfzn4rRPYkdZl7gRyb4cdro5mglLSVxjo@nongnu.org
X-Gm-Message-State: AOJu0YyvieBfBnENi/xebl/tFrTn8h+LStcN2Sqeg5oU6lnNGTfhXPkB
 L1zEMCBcoKt+Nr8nc2XG48vYTNRk0Uy/aMAb6RFlyDFmFCbfv6V+7WXpQ1kYdmnqw2wdd7f5Del
 L1bXOonWLj6/7Xocl2KxIHLgAbMe8wGgd4U6AqdMEwn//c6sGgN0t
X-Received: by 2002:a05:600c:4f82:b0:42c:bdb0:c61e with SMTP id
 5b1f17b1804b1-42e7abf9544mr121579305e9.13.1727188159466; 
 Tue, 24 Sep 2024 07:29:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx9+RwmkPsq1aH9yBlgRJ75r9wwbG2YlsKN8LHNDJEirtlA+seICT7ifOIfVp/0bul8i2OzQ==
X-Received: by 2002:a05:600c:4f82:b0:42c:bdb0:c61e with SMTP id
 5b1f17b1804b1-42e7abf9544mr121579095e9.13.1727188159034; 
 Tue, 24 Sep 2024 07:29:19 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e9029eed4sm24245935e9.24.2024.09.24.07.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 07:29:18 -0700 (PDT)
Date: Tue, 24 Sep 2024 16:29:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Hal Martin <hal.martin@gmail.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, anisinha@redhat.com
Subject: Re: [PATCH v2] hw/smbios: support for type 7 (cache information)
Message-ID: <20240924162918.3be98058@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240921072955.7150-1-hal.martin@gmail.com>
References: <20240911071848-mutt-send-email-mst@kernel.org>
 <20240921072955.7150-1-hal.martin@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
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

On Sat, 21 Sep 2024 07:29:55 +0000
Hal Martin <hal.martin@gmail.com> wrote:

> This patch adds support for SMBIOS type 7 (Cache Information) to qemu.
> 
> level: cache level (1-8)
> size: cache size in bytes
> 
> Example usage:
> -smbios type=7,level=1,size=0x8000
> 
> Signed-off-by: Hal Martin <hal.martin@gmail.com>
> ---
>  hw/smbios/smbios.c           | 64 ++++++++++++++++++++++++++++++++++++
>  include/hw/firmware/smbios.h | 18 ++++++++++
>  qemu-options.hx              |  2 ++
>  3 files changed, 84 insertions(+)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index a394514264..b71d5b0a92 100644
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
> @@ -733,6 +756,33 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
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
> +        /* cache not socketed, enabled, write back */
> +        t->cache_configuration =  0x180 | ((t7->level) - 1);
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

for any field that is larger that 1 byte, please use cpu_to_leX
to make sure it won't break on big-endian host

> +        SMBIOS_BUILD_TABLE_POST;
> +        instance++;
> +    }
> +}
> +
>  static void smbios_build_type_8_table(void)
>  {
>      unsigned instance = 0;
> @@ -1120,6 +1170,7 @@ static bool smbios_get_tables_ep(MachineState *ms,
>          }
>      }
>  
> +    smbios_build_type_7_table();
>      smbios_build_type_8_table();
>      smbios_build_type_9_table(errp);
>      smbios_build_type_11_table();
> @@ -1478,6 +1529,19 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>                             UINT16_MAX);
>              }
>              return;
> +        case 7:
> +            if (!qemu_opts_validate(opts, qemu_smbios_type7_opts, errp)) {
> +                return;
> +            }
> +            struct type7_instance *t7_i;
> +            t7_i = g_new0(struct type7_instance, 1);
> +            t7_i->level = qemu_opt_get_number(opts, "level", 0x0);
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
> index d94e2cbbae..21c05821d5 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2706,6 +2706,8 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>      "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
>      "              [,processor-family=%d][,processor-id=%d]\n"
>      "                specify SMBIOS type 4 fields\n"
> +    "-smbios type=7[,level=%d][,size=%d]\n"
> +    "                specify SMBIOS type 7 fields\n"
>      "-smbios type=8[,external_reference=str][,internal_reference=str][,connector_type=%d][,port_type=%d]\n"
>      "                specify SMBIOS type 8 fields\n"
>      "-smbios type=11[,value=str][,path=filename]\n"


