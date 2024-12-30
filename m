Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F896E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHap-0008Jt-1g; Mon, 30 Dec 2024 10:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tSHam-0008Jf-Lm
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:22:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tSHah-00018F-8o
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735572115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1EN7DLzR1HZrNYFPod8zGEp4dVofApGCkxFK8VuMak=;
 b=NYya0XmuO5+Zxjf2MrAZ+t98Rin18P7jxMTNbMfZmsrx/xb5K0IUZq4bJXGQKtuTy7h6XN
 gbINRA4lv4qGxiFBzhuamKQkj/70jqgnigIRa8u/2/KTzW/336o4bQ+xX23+zFD9hy+IBR
 Tq00QRinCGO1fINKcyy/BV/KNjwGfqw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-vZl2DTe1OxKtcEdthkt5kw-1; Mon, 30 Dec 2024 10:21:54 -0500
X-MC-Unique: vZl2DTe1OxKtcEdthkt5kw-1
X-Mimecast-MFC-AGG-ID: vZl2DTe1OxKtcEdthkt5kw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362153dcd6so8438535e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735572113; x=1736176913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1EN7DLzR1HZrNYFPod8zGEp4dVofApGCkxFK8VuMak=;
 b=cF3HcNQeAlyAUKSvbuPhJywjXlVfotdoiCwcmR8947aqPKi2vvKpww9ixIeNVXTRqi
 yNIvAkL2yeYZzvuRj9/7tDzU/Ye2qGcfeUnPcJ1ESByAnrWjqUF/GorM00UQBHdySUrz
 2hqUtg3q3HRZ+zrWxh2+JnW7WKbmtdMLcemQRb2dQSpqoEgVaZOnLAxAIUeShSLBPIdu
 wnXun/YxVXeDaVyezT/OIgNEoDV3OYA/4/j89+wjRRUd3MbezOYAG1tRFLIpxcXUTQNi
 J+7TawakYRLoloD+8USOzAa8EzMW8Z9qrutNtvDIPjz8iNuvNJU96agkcSlqF1cvURGI
 C7Rw==
X-Gm-Message-State: AOJu0YwEW/MBnAGZRDgCtfzCSpeYymv4FQm/NOOTRffnydDm15riUyJT
 6fjFaA9WEp3H2PpmaYMJe3Nzfk8kgU/Fudv3l019O2Bh1Gql1NwvKXWO8yS17joU0dto8TqiLow
 zaUJnSVJSFkp6m6qjGl3E3ZH2Q/DyAT5nKMwXHjmwETLODizq8L+T
X-Gm-Gg: ASbGncumWBD1hP4LnY7039nQqdRzMcVMKn/05FLkk908+Q2i312s6yXu4XWXvwp9mak
 PDEqvXoAvN66CheoEY/lkuDgt381/RCSTlrHXELY2ByVyEuR2sUKS4/rf5lusUz2T+LHlVjdo8F
 m0Tr1xhvRjjEdCuIdLW+dkuiaapZ79YJmR91GhfVFqTqc7Sflxes7KslRAc0glyx3Q6c6BQmLw4
 OMfXrr/DWhYYkLlZ91hKqw5nvEtb091rzYg594+IJ9dqnJacluIXwEWQX5s7JTpazrV4Y8SpYrN
 dASr6Z01U9bYhCUcWKuqAE/CAq/E
X-Received: by 2002:a05:6000:4024:b0:385:f6b9:e750 with SMTP id
 ffacd0b85a97d-38a221f31a9mr26121132f8f.9.1735572112903; 
 Mon, 30 Dec 2024 07:21:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxaCG3ZBg29ThpPpEVszCpcJHnN3Rj8wQvGS7JlzpDKwHVzDsn3fb2JU77PkW1I0JIhFFJDw==
X-Received: by 2002:a05:6000:4024:b0:385:f6b9:e750 with SMTP id
 ffacd0b85a97d-38a221f31a9mr26121120f8f.9.1735572112542; 
 Mon, 30 Dec 2024 07:21:52 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1cesm29828430f8f.64.2024.12.30.07.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 07:21:51 -0800 (PST)
Date: Mon, 30 Dec 2024 16:21:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Hal Martin <hal.martin@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com
Subject: Re: [PATCH v4] hw/smbios: support for type 7 (cache information)
Message-ID: <20241230162150.14a1a629@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241222104005.10501-1-hal.martin@gmail.com>
References: <20240926160501.593c2b96@imammedo.users.ipa.redhat.com>
 <20241222104005.10501-1-hal.martin@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Sun, 22 Dec 2024 10:40:05 +0000
Hal Martin <hal.martin@gmail.com> wrote:

> This patch adds support for SMBIOS type 7 (Cache Information) to qemu.
> 
> level: cache level (1-8)
> size: cache size
> 
> Example usage:
> -smbios type=7,level=1,size=1M
> 
> Note: this does not change the actual layout of the CPU cache(s),
> it simply allows the user to specify data in SMBIOS to be presented
> to the guest. This is useful for example if you have software that
> queries SMBIOS for the CPU cache levels/size.

when posting a new version, do not put it into the same thread lest it would be lost,
send  it as a new patch with vX prefix.

Also put after --- line
changelog and a reference to previous revision

PS:
use ./scripts/checkpatch.pl before sending the patch
 
> 
> Signed-off-by: Hal Martin <hal.martin@gmail.com>
> ---
>  hw/smbios/smbios.c           | 116 +++++++++++++++++++++++++++++++++++
>  include/hw/firmware/smbios.h |  29 +++++++++
>  qemu-options.hx              |   2 +
>  3 files changed, 147 insertions(+)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 02a09eb9cd..9885e902b0 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -18,6 +18,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
> +#include "qemu/error-report.h"
>  #include "qemu/config-file.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
> @@ -83,6 +84,13 @@ static struct {
>      .processor_family = 0x01, /* Other */
>  };
>  
> +struct type7_instance {
> +    uint16_t level;
> +    uint64_t size;
> +    QTAILQ_ENTRY(type7_instance) next;
> +};
> +static QTAILQ_HEAD(, type7_instance) type7 = QTAILQ_HEAD_INITIALIZER(type7);
> +
>  struct type8_instance {
>      const char *internal_reference, *external_reference;
>      uint8_t connector_type, port_type;
> @@ -330,6 +338,23 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
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
> +        .type = QEMU_OPT_SIZE,
> +        .help = "cache size",
> +    },
> +    { /* end of list */ }
> +};
> +
>  static const QemuOptDesc qemu_smbios_type8_opts[] = {
>      {
>          .name = "type",
> @@ -733,6 +758,80 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
>      smbios_type4_count++;
>  }
>  
> +static void smbios_build_type_7_table(SmbiosEntryPointType ep_type)
> +{
> +    unsigned instance = 0;
> +    size_t tbl_len = SMBIOS_TYPE_7_LEN_V21;
> +    struct type7_instance *t7;
> +    char designation[50];
> +    uint16_t cache_size = 0;
> +    uint32_t cache_size2 = 0;
> +
> +    if (ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> +        tbl_len = SMBIOS_TYPE_7_LEN_V31;
> +    }
> +
> +    QTAILQ_FOREACH(t7, &type7, next) {
> +        if (t7->size < 1024) {

> +            error_report("SMBIOS CPU cache size (%lu) is too small (>1k)",
> +                         t7->size);
> +            exit(1);

using error_fatal() would be better here, and avoid having to call exit manually

> +        }
> +        SMBIOS_BUILD_TABLE_PRE(7, T0_BASE + instance, true);
> +        sprintf(designation, "CPU Internal L%d", t7->level);

try to avoid sprintf(), use a safer alternatives from glib instead
()see: g_print() && co and also g_autofree

> +        SMBIOS_TABLE_SET_STR(7, socket_designation, designation);
> +        /* cache not socketed, enabled, write back */
> +        t->cache_configuration =  cpu_to_le16(0x180 | ((t7->level) - 1));
> +        if (tbl_len == SMBIOS_TYPE_7_LEN_V21) {
> +            if (t7->size > 1024*MiB) {
> +                error_report("SMBIOS 2.0 doesn't support CPU cache "
> +                            "sizes more than 1024 MiB, use "
> +                            "-machine smbios-entry-point-type=64 option to "
> +                            "enable SMBIOS 3.0 support");
> +                exit(1);

ditto

> +            }
> +        }
> +        /* size is defined in 1k granularity */
> +        cache_size = t7->size/1024;
here and below, that will silently round up input of not right granularity,
I'd rather have explicit granularity check and bail out in case value is
not matching expected one.
Maybe put it in the beginning  along with 'SMBIOS CPU cache size' check above.

Also here and elsewhere try to use KiB ... instead on plain numbers

> +        if (t7->size > INT16_MAX) {
> +            /* set granularity to 64KiB */
> +            cache_size = cpu_to_le16(t7->size/(64*1024) | (0x1 << 15));
> +        }
> +
> +        t->supported_sram_type = cpu_to_le16(0x10); /* pipeline burst */
> +        t->current_sram_type = cpu_to_le16(0x10); /* pipeline burst */
> +        t->cache_speed = 0x1; /* 1 ns */
> +        t->error_correction_type = 0x6; /* Multi-bit ECC */
> +        t->system_cache_type = 0x05; /* Unified */
> +        t->associativity = 0x6; /* Fully Associative */
> +
> +        if (tbl_len == SMBIOS_TYPE_7_LEN_V31) {
> +            if (t7->size > ((uint64_t)2 << 45)) {

instead of shift use numbers with KiB/MiB/... suffixes to make it more readable

> +                error_report("SMBIOS CPU cache size (%lu) is too large",
> +                             t7->size);

it would be nice to also tell user what expected range is

> +                exit(1);
> +            }
> +            cache_size2 = t7->size/1024;
> +            /* For Cache sizes greater than 2047 MB, the */
> +            /* Maximum Cache Size field is set to 0xFFFF */
> +            if (cache_size2 > (2 << 20)) {

ditto wrt KiB/...

> +                cache_size = 0xffff;
> +                /* set granularity to 64KiB */
> +                cache_size2 = cpu_to_le32(t7->size/(64*1024) | (0x1 << 31));

and here too

> +            }
> +
> +            t->maximum_cache_size2 = cache_size2;
> +            t->installed_cache_size2 = cache_size2;
> +
> +        }
> +        t->installed_size = cache_size;
> +        /* set max size to installed size */
> +        t->maximum_cache_size = cache_size;
> +        SMBIOS_BUILD_TABLE_POST;
> +        instance++;
> +    }
> +}
> +
>  static void smbios_build_type_8_table(void)
>  {
>      unsigned instance = 0;
> @@ -1120,6 +1219,7 @@ static bool smbios_get_tables_ep(MachineState *ms,
>          }
>      }
>  
> +    smbios_build_type_7_table(ep_type);
>      smbios_build_type_8_table();
>      smbios_build_type_9_table(errp);
>      smbios_build_type_11_table();
> @@ -1478,6 +1578,22 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>                             UINT16_MAX);
>              }
>              return;
> +        case 7:
> +            if (!qemu_opts_validate(opts, qemu_smbios_type7_opts, errp)) {
> +                return;
> +            }
> +            struct type7_instance *t7_i;
> +            t7_i = g_new0(struct type7_instance, 1);
> +            t7_i->level = qemu_opt_get_number(opts, "level", 0);
> +            t7_i->size = qemu_opt_get_size(opts, "size", 0);
> +            /* Only cache levels 1-8 are permitted */
> +            if (t7_i->level > 8) {
> +                error_setg(errp, "SMBIOS CPU cache level %d is invalid (1-8)",
                                                                  ^^^^^^^^^^^^^

it's confusing, how user would know that (1-8) is an acceptable range

> +                           t7_i->level);
> +                return;
> +            }
> +            QTAILQ_INSERT_TAIL(&type7, t7_i, next);
> +            return;
>          case 8:
>              if (!qemu_opts_validate(opts, qemu_smbios_type8_opts, errp)) {
>                  return;
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index f066ab7262..996d36fead 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -220,6 +220,35 @@ typedef enum smbios_type_4_len_ver {
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
> +    /* SMBIOS spec 3.1.0, Table 36  */
> +    uint32_t maximum_cache_size2;
> +    uint32_t installed_cache_size2;
> +    /* contained elements follow */
> +} QEMU_PACKED;
> +
> +typedef enum smbios_type_7_len_ver {
> +    SMBIOS_TYPE_7_LEN_V20 = offsetofend(struct smbios_type_7,
> +                                        current_sram_type),
> +    SMBIOS_TYPE_7_LEN_V21 = offsetofend(struct smbios_type_7,
> +                                        associativity),
> +    SMBIOS_TYPE_7_LEN_V31 = offsetofend(struct smbios_type_7,
> +                                        installed_cache_size2),
> +} smbios_type_7_len_ver;
> +
> +
>  /* SMBIOS type 8 - Port Connector Information */
>  struct smbios_type_8 {
>      struct smbios_structure_header header;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index cc694d3b89..a85bfac647 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2644,6 +2644,8 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>      "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
>      "              [,processor-family=%d][,processor-id=%d]\n"
>      "                specify SMBIOS type 4 fields\n"
> +    "-smbios type=7[,level=%d][,size=%d]\n"
> +    "                specify SMBIOS type 7 fields\n"
>      "-smbios type=8[,external_reference=str][,internal_reference=str][,connector_type=%d][,port_type=%d]\n"
>      "                specify SMBIOS type 8 fields\n"
>      "-smbios type=11[,value=str][,path=filename]\n"


