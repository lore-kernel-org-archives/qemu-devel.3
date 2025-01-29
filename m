Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E451C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 06:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td1Wt-0005US-4G; Wed, 29 Jan 2025 01:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1td1Wn-0005Tm-E7; Wed, 29 Jan 2025 01:26:21 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1td1Wj-0005LT-Uq; Wed, 29 Jan 2025 01:26:20 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6C086A412F5;
 Wed, 29 Jan 2025 06:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC2FC4CEE0;
 Wed, 29 Jan 2025 06:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738131971;
 bh=Vdik5QjUxtGOf3zWCkXL3d1o6WJi+pyGk0bEJ2cgek4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EzxJKEQWTBb9ufFcL4YmfNz9XaLl9kL+/9HuFw7Wusa2a3kLqf6vwJq2fIpbEXQ4Q
 1HUy84kJXALc+NWGEpzhN20mD8iVoyh64JN549zVT5nT92Z6lfZTUUTU3UD/cwoxaM
 /Yf1lvlokkDzZhq2cYZL1YJtyVWJGXHY3vo/nw/tUFwgc2PJllHUJPk6X2MRjTUmmZ
 ryAuXg8zGsSVLk5DoJBQYeC6T31tNfhQ3Jvym/gxlUzW7sD4sPZX+/60Nhxsjk1VlS
 XUSlJI0Nm1Ix1K5eVsdj3mHiVYaSrviygDDuHgO9aNV8HlUR4FPaZIPd1yMahkho8Z
 irsMKHUOgFRew==
Date: Wed, 29 Jan 2025 07:26:05 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] acpi/generic_event_device: add logic to detect if
 HEST addr is available
Message-ID: <20250129072605.4d306d4b@foz.lan>
In-Reply-To: <20250128122951.6bd52b89@foz.lan>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <556c19c1f3fa907c6cc13b62e060f6baa6faf2cf.1737560101.git.mchehab+huawei@kernel.org>
 <20250124112346.4751ccf2@imammedo.users.ipa.redhat.com>
 <20250128122951.6bd52b89@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Em Tue, 28 Jan 2025 12:29:51 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Fri, 24 Jan 2025 11:23:46 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Wed, 22 Jan 2025 16:46:22 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Create a new property (x-has-hest-addr) and use it to detect if
> > > the GHES table offsets can be calculated from the HEST address
> > > (qemu 9.2 and upper) or via the legacy way via an offset obtained    
> > 
> > 10.0 by now
> >   
> > > from the hardware_errors firmware file.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  hw/acpi/generic_event_device.c |  1 +
> > >  hw/acpi/ghes.c                 | 28 +++++++++++++++++++++-------
> > >  hw/arm/virt-acpi-build.c       | 30 ++++++++++++++++++++++++++----
> > >  hw/core/machine.c              |  2 ++
> > >  include/hw/acpi/ghes.h         |  1 +
> > >  5 files changed, 51 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > > index 5346cae573b7..fe537ed05c66 100644
> > > --- a/hw/acpi/generic_event_device.c
> > > +++ b/hw/acpi/generic_event_device.c
> > > @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> > >  
> > >  static const Property acpi_ged_properties[] = {
> > >      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> > > +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.hest_lookup, true),    
> > 
> > s/hest_lookup/use_hest_addr/
> >   
> > >  };
> > >  
> > >  static const VMStateDescription vmstate_memhp_state = {
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index b46b563bcaf8..86c97f60d6a0 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -359,6 +359,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> > >  {
> > >      AcpiTable table = { .sig = "HEST", .rev = 1,
> > >                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> > > +    AcpiGedState *acpi_ged_state;
> > > +    AcpiGhesState *ags = NULL;
> > >      int i;
> > >  
> > >      build_ghes_error_table(hardware_errors, linker, num_sources);
> > > @@ -379,10 +381,20 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> > >       * tell firmware to write into GPA the address of HEST via fw_cfg,
> > >       * once initialized.
> > >       */
> > > -    bios_linker_loader_write_pointer(linker,
> > > -                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> > > -                                     sizeof(uint64_t),
> > > -                                     ACPI_BUILD_TABLE_FILE, hest_offset);
> > > +
> > > +    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> > > +                                                       NULL));    
> > 
> > the caller, already did lookup,
> > just pass hest_lookup as an argument and use it here  
> 
> for all the above: OK.
> 
> > > +    if (!acpi_ged_state) {
> > > +        return;
> > > +    }
> > > +
> > > +    ags = &acpi_ged_state->ghes_state;
> > > +    if (ags->hest_lookup) {
> > > +        bios_linker_loader_write_pointer(linker,
> > > +                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> > > +                                         sizeof(uint64_t),
> > > +                                         ACPI_BUILD_TABLE_FILE, hest_offset);
> > > +    }
> > >  }
> > >  
> > >  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > > @@ -396,8 +408,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > >      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> > >          NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);    
> > 
> > btw shouldn't we disable hw_error_le if hest_lookup is active?  
> 
> Despite not being used, we still need the fw_cfg logic to recalculate the 
> table offsets, solving the bios_linker stuff.
> 
> At the tests I did, not having a callback causes some fw_cfg issue when QEMU
> tries to load the firmware or tries to update it.
> 
> > >  
> > > -    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> > > -        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> > > +    if (ags && ags->hest_lookup) {    
> > 
> > why bother with 'ags &&' if we don't do it hw_error_le?  
> 
> Legacy stuff. I'll drop "ags &&".
> 
> > 
> >   
> > > +        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> > > +            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> > > +    }
> > >  
> > >      ags->present = true;
> > >  }
> > > @@ -512,7 +526,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> > >      }
> > >      ags = &acpi_ged_state->ghes_state;
> > >  
> > > -    if (!ags->hest_addr_le) {
> > > +    if (!ags->hest_lookup) {    
> > why? !ags->hest_addr_le is sufficient  
> 
> Either checking for "hest_addr_le" or for "use_hest_addr" would
> equally work, assuming that address == 0 is invalid. I opted to use
> the latest one because you requested on a previous review, and also
> because it makes clearer that this comes from the migration logic,
> which dictates what kind of lookup should be done.
> 
> From my side, either way works fine. What do you prefer?

After sleeping on it, IMO checking for !ags->hest_addr_le is better here and will
align with the new code from this patch:

	acpi/ghes: Cleanup the code which gets ghes ged state

that will remove ags->present in favor of checking for both hw_error_le and
hest_addr_le:

	AcpiGhesState *acpi_ghes_get_state(void)
	{
	     AcpiGedState *acpi_ged_state;
	     AcpiGhesState *ags;
 
	     if (!acpi_ged_state) {
	        return NULL;
	     }
	     ags = &acpi_ged_state->ghes_state;

	    if (!ags->hw_error_le && !ags->hest_addr_le) {
	        return NULL;
	    }
	    return ags;
	 }

So, I'll drop this hunk.

> 
> >   
> > >          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> > >                               &cper_addr, &read_ack_register_addr);
> > >      } else {
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index 3d411787fc37..ada5d08cfbe7 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -897,6 +897,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
> > >      { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> > >  };
> > >  
> > > +static const AcpiNotificationSourceId hest_ghes_notify_9_2[] = {
> > > +    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> > > +};
> > > +
> > >  static
> > >  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> > >  {
> > > @@ -950,10 +954,28 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> > >      build_dbg2(tables_blob, tables->linker, vms);
> > >  
> > >      if (vms->ras) {
> > > -        acpi_add_table(table_offsets, tables_blob);
> > > -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> > > -                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
> > > -                        vms->oem_id, vms->oem_table_id);
> > > +        AcpiGhesState *ags;
> > > +        AcpiGedState *acpi_ged_state;
> > > +
> > > +        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> > > +                                                       NULL));
> > > +        if (acpi_ged_state) {
> > > +            ags = &acpi_ged_state->ghes_state;
> > > +
> > > +            acpi_add_table(table_offsets, tables_blob);
> > > +
> > > +            if (!ags->hest_lookup) {
> > > +                acpi_build_hest(tables_blob, tables->hardware_errors,
> > > +                                tables->linker, hest_ghes_notify_9_2,
> > > +                                ARRAY_SIZE(hest_ghes_notify_9_2),
> > > +                                vms->oem_id, vms->oem_table_id);
> > > +            } else {
> > > +                acpi_build_hest(tables_blob, tables->hardware_errors,
> > > +                                tables->linker, hest_ghes_notify,
> > > +                                ARRAY_SIZE(hest_ghes_notify),
> > > +                                vms->oem_id, vms->oem_table_id);
> > > +            }
> > > +        }
> > >      }
> > >  
> > >      if (ms->numa_state->num_nodes > 0) {
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index c23b39949649..0d0cde481954 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -34,10 +34,12 @@
> > >  #include "hw/virtio/virtio-pci.h"
> > >  #include "hw/virtio/virtio-net.h"
> > >  #include "hw/virtio/virtio-iommu.h"
> > > +#include "hw/acpi/generic_event_device.h"
> > >  #include "audio/audio.h"
> > >  
> > >  GlobalProperty hw_compat_9_2[] = {
> > >      {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
> > > +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
> > >  };
> > >  const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
> > >  
> > > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > > index 237721fec0a2..164ed8b0f9a3 100644
> > > --- a/include/hw/acpi/ghes.h
> > > +++ b/include/hw/acpi/ghes.h
> > > @@ -61,6 +61,7 @@ typedef struct AcpiGhesState {
> > >      uint64_t hest_addr_le;
> > >      uint64_t hw_error_le;
> > >      bool present; /* True if GHES is present at all on this board */    
> >                         and perhaps reformulate this as well
> >   
> > > +    bool hest_lookup; /* True if HEST address is present */    
> >                                  if device should use HEST addr for error source lookup 
> >   
> > >  } AcpiGhesState;
> > >  
> > >  /*    
> >   
> 
> 
> 
> Thanks,
> Mauro



Thanks,
Mauro

