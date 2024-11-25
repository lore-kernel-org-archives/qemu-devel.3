Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B89D5808D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 12:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFXtd-0001rE-75; Mon, 25 Nov 2024 07:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tFXtb-0001qg-5r; Mon, 25 Nov 2024 07:08:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tFXtX-0000YW-VE; Mon, 25 Nov 2024 07:08:50 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XxkxH0Jmyz6LDQq;
 Mon, 25 Nov 2024 20:08:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 2DDD7140C98;
 Mon, 25 Nov 2024 20:08:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 25 Nov
 2024 13:08:32 +0100
Date: Mon, 25 Nov 2024 12:08:30 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, "Igor Mammedov" <imammedo@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 5/5] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20241125120830.000025bf@huawei.com>
In-Reply-To: <7505ad000ed66099bf443fd7769c83bd7d5d4136.1732281080.git.mchehab+huawei@kernel.org>
References: <cover.1732281080.git.mchehab+huawei@kernel.org>
 <7505ad000ed66099bf443fd7769c83bd7d5d4136.1732281080.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.93, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 22 Nov 2024 14:14:15 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Create a new property (x-has-hest-addr) and use it to detect if
> the GHES table offsets can be calculated from the HEST address
> (qemu 9.2 and upper) or via the legacy way via an offset obtained
> from the hardware_errors firmware file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Hi Mauro,

I think we still have a few inconsistencies in here on what can be
NULL and what can't.  See inline.

With those tidied up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index b5e3e2891445..a10f7e266a6a 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -359,6 +359,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> +    AcpiGedState *acpi_ged_state;
> +    AcpiGhesState *ags = NULL;

I don't think you need to set this any more.

>      int i;
>  
>      build_ghes_error_table(hardware_errors, linker, num_sources);
> @@ -379,10 +381,20 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>       * tell firmware to write into GPA the address of HEST via fw_cfg,
>       * once initialized.
>       */
> -    bios_linker_loader_write_pointer(linker,
> -                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> -                                     sizeof(uint64_t),
> -                                     ACPI_BUILD_TABLE_FILE, hest_offset);
> +
> +    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));
> +    if (!acpi_ged_state) {
> +        return;
> +    }
> +
> +    ags = &acpi_ged_state->ghes_state;
> +    if (ags->hest_lookup) {
> +        bios_linker_loader_write_pointer(linker,
> +                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                         sizeof(uint64_t),
> +                                         ACPI_BUILD_TABLE_FILE, hest_offset);
> +    }
>  }
>  
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> @@ -396,8 +408,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
>  
> -    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> -        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +    if (ags && ags->hest_lookup) {
> +        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +    }
>  
>      ags->present = true;

if (!ags) which the above check implies can happen, then
boom.  So I think you can just drop the check on ags above.

The current caller can never pass that in as NULL anyway and it would
make no sense to call this function with it as NULL.


>  }
> @@ -512,7 +526,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    if (!ags->hest_addr_le) {
> +    if (!ags->hest_lookup) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                               &cper_addr, &read_ack_register_addr);
>      } else {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index bd5582bc75f8..46ce3f3bb07a 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -893,6 +893,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
>      { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
>  };
>  
> +static const AcpiNotificationSourceId hest_ghes_notify_9_1[] = {
> +    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> +};
> +
>  static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
> @@ -946,10 +950,28 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> -                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
> -                        vms->oem_id, vms->oem_table_id);
> +        AcpiGhesState *ags;

Could push down to the scope of if (acpi_ged_state)
I don't think it really matters though.


> +        AcpiGedState *acpi_ged_state;
> +
> +        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));
> +        if (acpi_ged_state) {
> +            ags = &acpi_ged_state->ghes_state;
> +
> +            acpi_add_table(table_offsets, tables_blob);
> +
> +            if (!ags->hest_lookup) {
> +                acpi_build_hest(tables_blob, tables->hardware_errors,
> +                                tables->linker, hest_ghes_notify_9_1,
> +                                ARRAY_SIZE(hest_ghes_notify_9_1),
> +                                vms->oem_id, vms->oem_table_id);
> +            } else {
> +                acpi_build_hest(tables_blob, tables->hardware_errors,
> +                                tables->linker, hest_ghes_notify,
> +                                ARRAY_SIZE(hest_ghes_notify),
> +                                vms->oem_id, vms->oem_table_id);
> +            }
> +        }
>      }
>  
>      if (ms->numa_state->num_nodes > 0) {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a35c4a8faecb..00521a1963ba 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,10 +34,12 @@
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/acpi/generic_event_device.h"
>  #include "audio/audio.h"
>  
>  GlobalProperty hw_compat_9_1[] = {
>      { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
> +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
>  };
>  const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 237721fec0a2..164ed8b0f9a3 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -61,6 +61,7 @@ typedef struct AcpiGhesState {
>      uint64_t hest_addr_le;
>      uint64_t hw_error_le;
>      bool present; /* True if GHES is present at all on this board */
> +    bool hest_lookup; /* True if HEST address is present */
>  } AcpiGhesState;
>  
>  /*


