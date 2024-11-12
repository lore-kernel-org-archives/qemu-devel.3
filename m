Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFADDD42B9B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 15:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAsjX-0003l2-Ct; Tue, 12 Nov 2024 10:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tAsjR-0003kN-Q5; Tue, 12 Nov 2024 10:23:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tAsjP-0005ly-SN; Tue, 12 Nov 2024 10:23:05 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B320E5C2803;
 Tue, 12 Nov 2024 15:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAC6C4CECD;
 Tue, 12 Nov 2024 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731424979;
 bh=ygmiDec5oZDSySVozuUuRvuYRB9Cjy50S5yr7boJjtg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EDkeT8Ykv6F+Cv5+aRlUN6E5pI0wm6BtmuxfT5EtZvxeIyXsEZ1XuXN83ALX+JO2Q
 7WvfpoJES3dV30Uveev/lUWY4TILE4YzHsQx6UjLNbs3qNrTFKyyJhuQVvqt79F2Hh
 X6kInZryDZWaBqztAq9xgwoTxR135P8sny5eLX3tG+L8p03EM5nEeGwcU4+ZAsztWh
 WNhiwxzE7XAO0fjDgsGZRw/S6wJAMPYZmcE/5TcrL7BXKaQU++uR5hthjm/WVaTsjr
 O3SyVgFhW6y25E6R0SrSGQsOeVfWGjRNXt6/+tEpM583VXUyCtUVxt57J6GoiopJWN
 sEPdQtrTEuJgw==
Date: Tue, 12 Nov 2024 16:22:54 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 4/5] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20241112162254.65cc3efc@foz.lan>
In-Reply-To: <20241112155557.728e9d68@foz.lan>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
 <176693e011a411db92be9e912bfc4a9da0e664b7.1727782588.git.mchehab+huawei@kernel.org>
 <20241003162728.1de6fc62@imammedo.users.ipa.redhat.com>
 <20241112155557.728e9d68@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Em Tue, 12 Nov 2024 15:55:57 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Thu, 3 Oct 2024 16:27:28 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > > +++ b/hw/acpi/ghes.c
> > > @@ -513,7 +513,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> > >      }
> > >      ags = &acpi_ged_state->ghes_state;
> > >  
> > > -    if (!ags->hest_addr_le) {
> > > +    if (!ags->hest_lookup) {
> > >          get_ghes_offsets(le64_to_cpu(ags->hw_error_le),
> > >                           &cper_addr, &read_ack_register_addr);    
> > 
> > just fencing off lookup is not enough,
> > to be compatible with qemu-9.1 (virt-9.1) we also should not publish hest_addr fwcfg.  
> 
> I tried this:
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 201e72516608..6bb962d3c449 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -402,8 +402,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
>  
> -    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> -        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +    if (ags->hest_lookup) {
> +        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +    }
>  
>      ags->present = true;
>  }
> 
> But with such change, boot fails:
> 
> EFI stub: Booting Linux Kernel...
> UpdateRegionMappingRecursive(0): DF100000 - E1B90000 set 400 clr FF9F000000000B3F
> UpdateRegionMappingRecursive(1): DF100000 - E1B90000 set 400 clr FF9F000000000B3F
> UpdateRegionMappingRecursive(2): C0000000 - 100000000 set 6000000000070C clr 0
> UpdateRegionMappingRecursive(2): DF100000 - E1B90000 set 400 clr FF9F000000000B3F
> UpdateRegionMappingRecursive(3): DF000000 - DF200000 set 6000000000070C clr 0
> UpdateRegionMappingRecursive(3): DF100000 - DF200000 set 400 clr FF9F000000000B3F
> UpdateRegionMappingRecursive(3): E1A00000 - E1C00000 set 6000000000070C clr 0
> UpdateRegionMappingRecursive(3): E1A00000 - E1B90000 set 400 clr FF9F000000000B3F
> EFI stub: Generating empty DTB
> EFI stub: Exiting boot services...
> UpdateRegionMappingRecursive(0): 139AC1000 - 139CD0000 set 400 clr FF9F000000000B3F
> UpdateRegionMappingRecursive(1): 139AC1000 - 139CD0000 set 400 clr FF9F000000000B3F
> UpdateRegionMappingRecursive(2): 139AC1000 - 139CD0000 set 400 clr FF9F000000000B3F
> UpdateRegionMappingRecursive(3): 139A00000 - 139C00000 set 6000000000070C clr 0
> UpdateRegionMappingRecursive(3): 139AC1000 - 139C00000 set 400 clr FF9F000000000B3F
> UpdateRegionMappingRecursive(3): 139C00000 - 139CD0000 set 400 clr FF9F000000000B3F
> UpdateRegionMappingRecursive(0): 139AC1000 - 139AD0000 set 60000000000400 clr FF9F000000000B3F
> UpdateRegionMappingRecursive(1): 139AC1000 - 139AD0000 set 60000000000400 clr FF9F000000000B3F
> UpdateRegionMappingRecursive(2): 139AC1000 - 139AD0000 set 60000000000400 clr FF9F000000000B3F
> UpdateRegionMappingRecursive(3): 139AC1000 - 139AD0000 set 60000000000400 clr FF9F000000000B3F
> SetUefiImageMemoryAttributes - 0x000000013FE60000 - 0x0000000000040000 (0x0000000000000008)
> UpdateRegionMappingRecursive(0): 13FE60000 - 13FEA0000 set 70C clr 0
> UpdateRegionMappingRecursive(1): 13FE60000 - 13FEA0000 set 70C clr 0
> UpdateRegionMappingRecursive(2): 13FE60000 - 13FEA0000 set 70C clr 0
> UpdateRegionMappingRecursive(3): 13FE60000 - 13FEA0000 set 70C clr 0
> SetUefiImageMemoryAttributes - 0x000000013CAF0000 - 0x0000000000040000 (0x0000000000000008)
> UpdateRegionMappingRecursive(0): 13CAF0000 - 13CB30000 set 70C clr 0
> UpdateRegionMappingRecursive(1): 13CAF0000 - 13CB30000 set 70C clr 0
> UpdateRegionMappingRecursive(2): 13CAF0000 - 13CB30000 set 70C clr 0
> UpdateRegionMappingRecursive(3): 13CAF0000 - 13CB30000 set 70C clr 0
> SetUefiImageMemoryAttributes - 0x000000013CAA0000 - 0x0000000000040000 (0x0000000000000008)
> UpdateRegionMappingRecursive(0): 13CAA0000 - 13CAE0000 set 70C clr 0
> UpdateRegionMappingRecursive(1): 13CAA0000 - 13CAE0000 set 70C clr 0
> UpdateRegionMappingRecursive(2): 13CAA0000 - 13CAE0000 set 70C clr 0
> UpdateRegionMappingRecursive(3): 13CAA0000 - 13CAE0000 set 70C clr 0
> SetUefiImageMemoryAttributes - 0x000000013CA50000 - 0x0000000000040000 (0x0000000000000008)
> UpdateRegionMappingRecursive(0): 13CA50000 - 13CA90000 set 70C clr 0
> UpdateRegionMappingRecursive(1): 13CA50000 - 13CA90000 set 70C clr 0
> UpdateRegionMappingRecursive(2): 13CA50000 - 13CA90000 set 70C clr 0
> UpdateRegionMappingRecursive(3): 13CA50000 - 13CA90000 set 70C clr 0
> SetUefiImageMemoryAttributes - 0x000000013C960000 - 0x0000000000040000 (0x0000000000000008)
> UpdateRegionMappingRecursive(0): 13C960000 - 13C9A0000 set 70C clr 0
> UpdateRegionMappingRecursive(1): 13C960000 - 13C9A0000 set 70C clr 0
> UpdateRegionMappingRecursive(2): 13C960000 - 13C9A0000 set 70C clr 0
> UpdateRegionMappingRecursive(3): 13C960000 - 13C9A0000 set 70C clr 0
> SetUefiImageMemoryAttributes - 0x000000013FE20000 - 0x0000000000030000 (0x0000000000000008)
> UpdateRegionMappingRecursive(0): 13FE20000 - 13FE50000 set 70C clr 0
> UpdateRegionMappingRecursive(1): 13FE20000 - 13FE50000 set 70C clr 0
> UpdateRegionMappingRecursive(2): 13FE20000 - 13FE50000 set 70C clr 0
> UpdateRegionMappingRecursive(3): 13FE20000 - 13FE50000 set 70C clr 0
> SetUefiImageMemoryAttributes - 0x000000013C7B0000 - 0x0000000000030000 (0x0000000000000008)
> UpdateRegionMappingRecursive(0): 13C7B0000 - 13C7E0000 set 70C clr 0
> UpdateRegionMappingRecursive(1): 13C7B0000 - 13C7E0000 set 70C clr 0
> UpdateRegionMappingRecursive(2): 13C7B0000 - 13C7E0000 set 70C clr 0
> UpdateRegionMappingRecursive(3): 13C7B0000 - 13C7E0000 set 70C clr 0
> SetUefiImageMemoryAttributes - 0x000000013C770000 - 0x0000000000030000 (0x0000000000000008)
> UpdateRegionMappingRecursive(0): 13C770000 - 13C7A0000 set 70C clr 0
> UpdateRegionMappingRecursive(1): 13C770000 - 13C7A0000 set 70C clr 0
> UpdateRegionMappingRecursive(2): 13C770000 - 13C7A0000 set 70C clr 0
> UpdateRegionMappingRecursive(3): 13C770000 - 13C7A0000 set 70C clr 0
> 
> At this point, nothing else appears, and bios doesn't boot OSPM. 
> 
> (I'm using an arm64 BIOS with debug enabled)
> 
> Thanks,
> Mauro

Got it. In order to be able to remove a call to 
fw_cfg_add_file_callback(), no calls to bios_linker_loader_write_pointer()
can happen.

That basically explains why we can't do:

	if (!ags->hest_lookup) {
	     fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
        	 NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
	}

We need the BIOS file callback to solve all the pointers that
were created between HEST table and the hardware error table.

This hunk worked:


diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 201e72516608..245efde75a8f 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -385,10 +385,12 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
      * tell firmware to write into GPA the address of HEST via fw_cfg,
      * once initialized.
      */
-    bios_linker_loader_write_pointer(linker,
-                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
-                                     sizeof(uint64_t),
-                                     ACPI_BUILD_TABLE_FILE, hest_offset);
+    if (ags->hest_lookup) {
+        bios_linker_loader_write_pointer(linker,
+                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
+                                         sizeof(uint64_t),
+                                         ACPI_BUILD_TABLE_FILE, hest_offset);
+    }
 }
 
 void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
@@ -402,8 +404,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
         NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
 
-    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
-        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
+    if (ags->hest_lookup) {
+        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
+            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
+    }
 
     ags->present = true;
 }

Thanks,
Mauro

