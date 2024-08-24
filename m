Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22234C5321D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 00:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sheRh-00040Z-Aq; Fri, 23 Aug 2024 20:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sheRU-0003vd-8d; Fri, 23 Aug 2024 20:15:45 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sheRK-0000PL-UL; Fri, 23 Aug 2024 20:15:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D2AEF60E03;
 Sat, 24 Aug 2024 00:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129B6C32786;
 Sat, 24 Aug 2024 00:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724458525;
 bh=0ysFmC192SkHIJjk2TNUy2pwoFkiA9pwOdZMjj9oUrY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aWlxwaOME97BZ7btvmNBWtUyk3CEr9u8KT3Ml7LMJ6P/cA1capcVbLfqsw9erL53L
 SD2Vs3UJBPymNQlGA4e2tkzM3jToh3+kEO3kOzjgYp4W/xf3jo0cx6/Pj8Rf9PLkRw
 XEhTaL0GQR+mflI9GquNE411QyvboNeFGTPjEDgk+9qFR1X1K+k16MIrFp/Gv05Ej/
 t3/Q5Vtr17qMri7H9Ez7DGp+xkUGf8AtejD5pO5FZITKD/1cFLBNkGjSLzc2BhZDTd
 mCjqKd9LVOLO4mEO5ogj7j5uq7rPGj8lyp52rClVj7PO0RM0gnDUjrxGLv820JHYlh
 qhmcLxkIpF4mg==
Date: Sat, 24 Aug 2024 02:15:10 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 13/13] acpi/ghes: check if the BIOS pointers for HEST
 are correct
Message-ID: <20240824021510.71451b57@sal.lan>
In-Reply-To: <20240819160733.464ccebf@imammedo.users.ipa.redhat.com>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <52e6058feba318d01f54da6dca427b40ea5c9435.1723793768.git.mchehab+huawei@kernel.org>
 <20240819160733.464ccebf@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Em Mon, 19 Aug 2024 16:07:33 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +    err_source_struct = le64_to_cpu(ags->hest_addr_le) +
> > +                        source * HEST_GHES_V2_TABLE_SIZE;  
> 
> there is no guaranties that HEST table will contain only GHESv2 sources,
> and once such is added this place becomes broken.
> 
> we need to iterate over HEST taking that into account
> and find only ghesv2 structure with source id of interest.
> 
> This function (and acpi_ghes_record_errors() as well) taking source_id
> as input should be able to lookup pointers from HEST in guest RAM,
> very crude idea could look something like this:
> 
> typedef struct hest_source_type2len{
>    uint16_t type
>    int len
> } hest_structure_type2len
> 
> hest_structure_type2len supported_hest_sources[] = {
>     /* Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure */
>     {.type = 10, .len = 92},
> }

Sounds interesting, but IMO it should be done only when other types besides
ghes would be added, as:

1. Right now, the file is acpi/ghes.c. Adding non-type 10 HEST structures
   there would be a little weird. It should likely be renamed to acpi/hest.c
   when such time comes.

2. ACPI 6.5 has made clear that the above will only work up to type 11,
   as, from type 12 and above, the length will be added to the error
   struct, according with:

   https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-source-structure-header-type-12-onward

3. some types have variable size. Starting from the beginning, type 0, as
   defined at:
   https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#hardware-errors-and-error-sources

   has:

   size = 40 + 24 * Number of Hardware banks

   So, a simple table like the above with fixed sizes won't work.

   The code would need instead a switch if types are <= 11.

   Adding proper support for all already defined 12 types sounds lots of 
   work, as the code would need to calculate the size depending on the
   size, and we don't really initialize the HEST table with other types
   but GHES.

Ok, we could still do something like this pseudo-code to get the
error source offset:

	#define ACPI_HEST_TYPE_GHESV2	11

	err_struct_offset = 0;
	for (i = 0; i < source_id_count; i++) {
		/* NOTE: Other types may have different sizes */
		assert(ghes[i].type == ACPI_HEST_TYPE_GHESV2);
		if (ghes[i].source_id == source_id)
			break;
		err_struct_offset += HEST_GHES_V2_TABLE_SIZE;
	}
	assert (i < source_id_count);

---

That's said, maybe this will just add unwanted complexity, as QEMU
is already setting those offsets via bios_linker_loader_add_pointer().

So, an alternative for that is to merge the code on patch 13 with the one
on patch 5, dropping the math calcus there and relying that QEMU will
always handle properly bios links.

See, the logic which constructs GHESv2 source IDs do this to create
the links between HEST ACPI table and etc/hardware_errors:

with:

Per-source ID logic at build_ghes_v2():

    address_offset = table_data->len;
    /* Error Status Address */
    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                     4 /* QWord access */, 0);
    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
                                   address_offset + GAS_ADDR_OFFSET,
                                   sizeof(uint64_t),
                                   ACPI_HW_ERROR_FW_CFG_FILE,
                                   source_id * sizeof(uint64_t));
...
    /*
     * Read Ack Register
     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
     * version 2 (GHESv2 - Type 10)
     */
    address_offset = table_data->len;
    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                     4 /* QWord access */, 0);
    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
                                   address_offset + GAS_ADDR_OFFSET,
                                   sizeof(uint64_t),
                                   ACPI_HW_ERROR_FW_CFG_FILE,
                                   (ACPI_HEST_SRC_ID_COUNT + source_id) *
                                   sizeof(uint64_t));

HEST table creation logic inside build_ghes_error_table():

    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
        /*
         * Tell firmware to patch error_block_address entries to point to
         * corresponding "Generic Error Status Block"
         */
        bios_linker_loader_add_pointer(linker,
            ACPI_HW_ERROR_FW_CFG_FILE, sizeof(uint64_t) * i,
            sizeof(uint64_t), ACPI_HW_ERROR_FW_CFG_FILE,
            error_status_block_offset + i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
    }

Using those, the location of the CPER and ack addresses is easy and won't
require any math:

	/* GHESv2 CPER offset */
	cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
                                 sizeof(error_block_addr));
	cpu_physical_memory_read(error_block_addr, &cper_addr,
                                 sizeof(error_block_addr));

	/* GHESv2 ack offset */
	cpu_physical_memory_read(hest_read_ack_start_addr, &read_ack_start_addr,
			         sizeof(read_ack_start_addr));


Regards,
Mauro

