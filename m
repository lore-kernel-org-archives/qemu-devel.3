Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13F1FA3754
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp6KP-00058U-8b; Fri, 13 Sep 2024 09:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sp6KN-00050y-Fr
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sp6KK-0004Lp-I8
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726234027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sXO6xhJcEZ/xpvunD2vf+i968Lb3apUbBziQrSJQN20=;
 b=Homhu7KZfmfQyUAyjRohrRWWn14lFwKaJJMvpzNouiO9w6AjvNKFUe74YJZHLnMptGWlC9
 UHeFC6Q/akJtz6LH7eT63mdvCIFAcafrMfxm3o5IFF7ZSuzf5gZEKBb9nNEnzE60Egq3VY
 TnhhivIrh7qMGyTJ5qlblfRl35w3/Hg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-qZbjpriRMNaMw2JcMmK4vw-1; Fri, 13 Sep 2024 09:27:05 -0400
X-MC-Unique: qZbjpriRMNaMw2JcMmK4vw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cc4345561so13890825e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 06:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726234025; x=1726838825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sXO6xhJcEZ/xpvunD2vf+i968Lb3apUbBziQrSJQN20=;
 b=S39PKLqC+5lnn1njhGzN1Pn5xnRjJlurgQgKZ1TYAMPN/ZHKneauccCFguLA2JuodP
 bnBvwcORrRLCk7bRp2rcR4McL/fgyS4diWxaqFvS2WHYlG0HtcaDLLwOSvcy1woDNqGq
 QRmzM/Yi79s97/TjU4+qQ6Inx7JQQxidEoy/mUYoyiZAg+1MU51aqC8Ufp29q4apnS6S
 XQeqbdDGSV62nMmsp+qEDwaMmyRdDt51Ij+ywpSGSZlpQG1DMGAWQ+N/Wk0lBGohyIpi
 3MUCTvg5RzVWnlEnLHI7gOa7fomNAclSExNesBfJVROwsywP+PNvVShLfX8wwBa6YBWN
 kZog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWodHn3atqS8LGErvciiq5kr5Lv9rrSyV2qWs/U/acFHh/SEkmfNEFOwBvZfoaL4zlYTIZe3ovq56mC@nongnu.org
X-Gm-Message-State: AOJu0Yw63qN0NF4K5khmKgdPYFIa+wwMzC4hTeOVvBadPQnB+aFjFwoe
 QE/YzlOb3WTJkKAUivHb8OROx+k4g0JQObnP2+9ixjUkI9w2v3aGN2sNSlPWu5s2DpvK6rdgFYv
 aRkLDhFHV3uIfiUXaqbylS5cS035z/27Dg57kbfKbmS77/xhbVLcS
X-Received: by 2002:a05:600c:548e:b0:42c:a802:a8cd with SMTP id
 5b1f17b1804b1-42cdb529fbamr45142135e9.11.1726234024624; 
 Fri, 13 Sep 2024 06:27:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFISBORVoOtSf46uEWW7cElplgNkNkD42jImCK1VDBBI8gu9rS4soC9E7zoVJdbOSfEysf3fA==
X-Received: by 2002:a05:600c:548e:b0:42c:a802:a8cd with SMTP id
 5b1f17b1804b1-42cdb529fbamr45141835e9.11.1726234023989; 
 Fri, 13 Sep 2024 06:27:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9aff579asm27606245e9.0.2024.09.13.06.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 06:27:03 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:27:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 03/12] acpi/ghes: rename etc/hardware_error file macros
Message-ID: <20240913152702.3dc97c88@imammedo.users.ipa.redhat.com>
In-Reply-To: <866a06839420e69fa5a96ea3e0384658abb7e70a.1724556967.git.mchehab+huawei@kernel.org>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
 <866a06839420e69fa5a96ea3e0384658abb7e70a.1724556967.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 25 Aug 2024 05:45:58 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that we have also have a file to store HEST data location,
> which is part of GHES, better name the file where CPER records
> are stored.
> 
> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 965fb1b36587..3190eb954de4 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -28,8 +28,8 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "qemu/uuid.h"
>  
> -#define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
> -#define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> +#define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
> +#define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
>  #define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
> @@ -255,7 +255,7 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>          ACPI_GHES_MAX_RAW_DATA_LENGTH * num_sources);
>  
>      /* Tell guest firmware to place hardware_errors blob into RAM */
> -    bios_linker_loader_alloc(linker, ACPI_GHES_ERRORS_FW_CFG_FILE,
> +    bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
>                               hardware_errors, sizeof(uint64_t), false);
>  
>      for (i = 0; i < num_sources; i++) {
> @@ -264,8 +264,8 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>           * corresponding "Generic Error Status Block"
>           */
>          bios_linker_loader_add_pointer(linker,
> -            ACPI_GHES_ERRORS_FW_CFG_FILE, sizeof(uint64_t) * i,
> -            sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
> +            ACPI_HW_ERROR_FW_CFG_FILE, sizeof(uint64_t) * i,
> +            sizeof(uint64_t), ACPI_HW_ERROR_FW_CFG_FILE,
>              error_status_block_offset + i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
>      }
>  
> @@ -273,9 +273,9 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>       * tell firmware to write hardware_errors GPA into
>       * hardware_errors_addr fw_cfg, once the former has been initialized.
>       */
> -    bios_linker_loader_write_pointer(linker, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, 0,
> +    bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
>                                       sizeof(uint64_t),
> -                                     ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
> +                                     ACPI_HW_ERROR_FW_CFG_FILE, 0);
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> @@ -315,7 +315,7 @@ static void build_ghes_v2(GArray *table_data,
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
> -                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
> +                                   ACPI_HW_ERROR_FW_CFG_FILE,
>                                     source_id * sizeof(uint64_t));
>  
>      /* Notification Structure */
> @@ -335,7 +335,7 @@ static void build_ghes_v2(GArray *table_data,
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
> -                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
> +                                   ACPI_HW_ERROR_FW_CFG_FILE,
>                                     (num_sources + source_id) *
>                                     sizeof(uint64_t));
>  
> @@ -389,11 +389,11 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>                            GArray *hardware_error)
>  {
>      /* Create a read-only fw_cfg file for GHES */
> -    fw_cfg_add_file(s, ACPI_GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
> +    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>                      hardware_error->len);
>  
>      /* Create a read-write fw_cfg file for Address */
> -    fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
> +    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
>  
>      fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,


