Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6691D75E22
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 10:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tER2U-0006hQ-Qg; Fri, 22 Nov 2024 05:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tER2T-0006h7-9R; Fri, 22 Nov 2024 05:37:25 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tER2R-0000Z6-3G; Fri, 22 Nov 2024 05:37:25 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B989FA40E67;
 Fri, 22 Nov 2024 10:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDB0C4CECE;
 Fri, 22 Nov 2024 10:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732271839;
 bh=DgUsnE/Iq2GfNLfNuPyO9qTX5uILPd/ZA6hXdILi7Zc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AAQ833H0e0snGV45Z6HmgISZ7G3F0fvjyJy2GYHSJGfDNghJ5RbgQ6PpaaPoyNSM2
 vOV/aCA0Zyw+04TduaoF5XtOPl1yCwLNMuEwXWgx80K4gjxyul0MM368VoGNxmJYD6
 5g5F4U8pCDGjEOHPZWJf0irQiQQIihRg7J49XPtb6hhjzzhAd223kPaAmDdOPoZPwn
 KWTCU96gAauuz7VDiTQr+5i2710XwneKA/qDnzLEhEP2UrQLLiI3NCxiSNlCIKsrit
 A9jHZBJ448nMT+nNVOb4qp7fci6Vx2osgDiB6HabUDwSLZwW233UExpC8BSdE5JwUU
 8izNGbaaKbFqg==
Date: Fri, 22 Nov 2024 11:37:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/6] acpi/ghes: Use HEST table offsets when preparing
 GHES records
Message-ID: <20241122113714.04450f6b@foz.lan>
In-Reply-To: <20241120145930.00003895@huawei.com>
References: <cover.1731486604.git.mchehab+huawei@kernel.org>
 <cf60aee0059d12755c1b9deb2dddb355d8543297.1731486604.git.mchehab+huawei@kernel.org>
 <20241120145930.00003895@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Em Wed, 20 Nov 2024 14:59:30 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Wed, 13 Nov 2024 09:37:01 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > There are two pointers that are needed during error injection:
> > 
> > 1. The start address of the CPER block to be stored;
> > 2. The address of the ack, which needs a reset before next error.
> > 
> > Calculate them preferrable from the HEST table, as this allows
> > checking the source ID, the size of the table and the type of
> > HEST error block structures.  
> 
> It is preferable to calculate them from the HEST table.  This allows
> checking the source ID, the size of the table and the type of the
> HEST error block structures.
> 
> A few comments inline.
> 
> Jonathan
> 
> 
> > 
> > Yet, keep the old code, as this is needed for migration purposes.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/ghes.c | 98 ++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 88 insertions(+), 10 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index c93bbaf1994a..9ee25efe8abf 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -61,6 +61,23 @@
> >   */
> >  #define ACPI_GHES_GESB_SIZE                 20
> >  
> > +/*
> > + * Offsets with regards to the start of the HEST table stored at
> > + * ags->hest_addr_le, according with the memory layout map at
> > + * docs/specs/acpi_hest_ghes.rst.
> > + */
> > +  
> /*
>  * ACPI 6.2:
> 
> to be consistent with local style.

Actually, the local style inside this file was preserved. See, before
this series we have:

$ git grep "ACPI " hw/acpi/ghes.c
hw/acpi/ghes.c: * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
hw/acpi/ghes.c: * ACPI 6.2: 18.3.2.7.1 Generic Error Data,
hw/acpi/ghes.c: * ACPI 4.0: 17.3.2.7 Hardware Error Notification
hw/acpi/ghes.c: * ACPI 6.1: 18.3.2.7.1 Generic Error Data
hw/acpi/ghes.c: * ACPI 6.1: 18.3.2.7.1 Generic Error Data
hw/acpi/ghes.c:    /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
hw/acpi/ghes.c:         * ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
hw/acpi/ghes.c:     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source

> 
> > +/* ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> > + * Table 18-382 Generic Hardware Error Source version 2 (GHESv2) Structure
> > + */
> > +#define HEST_GHES_V2_TABLE_SIZE  92
> > +#define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET)
> > +  
> /*
>  * ACPI 6.2: 
> > +/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source
> > + * Table 18-380: 'Error Status Address' field
> > + */  
> 
> > +static void get_ghes_source_offsets(uint16_t source_id, uint64_t hest_addr,
> > +                                    uint64_t *cper_addr,
> > +                                    uint64_t *read_ack_start_addr,
> > +                                    Error **errp)
> > +{
> > +    uint64_t hest_err_block_addr, hest_read_ack_addr;
> > +    uint64_t err_source_struct, error_block_addr;
> > +    uint32_t num_sources, i;
> > +
> > +    if (!hest_addr) {  
> 
> Trivial but I wonder if this should be named to indicate that it sin't the start
> of HEST but the first bit of the header.
> hest_body_address or something like that maybe?  I don't care that much
> though if you prefer to keep as is.

I prefer to keep a simple name here, so let's keep as is.

> 
> 
> > +        return;
> > +    }
> > +
> > +    cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
> > +    num_sources = le32_to_cpu(num_sources);
> > +
> > +    err_source_struct = hest_addr + sizeof(num_sources);
> > +
> > +    /*
> > +     * Currently, HEST Error source navigates only for GHESv2 tables
> > +     */  
> 
> Feels like duplication of the comment below where the type check is.
> Maybe drop this one?

If I recall correctly [1], Igor asked to place such comment, on one of
the past versions of this code.

IMO, placing it clearly there helps to identify what needs to change when
support for non-GHES tables is needed.

[1] this is the 12th version of this code - my memory is starting to fail
    to remind were exactly each change was requested.
> 
> > +
> > +    for (i = 0; i < num_sources; i++) {
> > +        uint64_t addr = err_source_struct;
> > +        uint16_t type, src_id;
> > +
> > +        cpu_physical_memory_read(addr, &type, sizeof(type));
> > +        type = le16_to_cpu(type);
> > +
> > +        /* For now, we only know the size of GHESv2 table */
> > +        if (type != ACPI_GHES_SOURCE_GENERIC_ERROR_V2) {
> > +            error_setg(errp, "HEST: type %d not supported.", type);
> > +            return;
> > +        }
> > +
> > +        /* It is GHES. Compare CPER source address */  
> 
> It's GHESv2 (of course this bit is the same, but none the less comment
> is misleading). I'd just go with
>         /* Compare CPER source address */

I changed it to:

        /* Compare CPER source address at the GHESv2 structure */

to better state what is there. IMO, it is important to let it
clear, as, with:
ACPI 6.5: 18.3.2.11. Error Source Structure Header (Type 12 Onward)

what happens if that, if type <= 11, the struct is:

	offset 0:	type
	offset 2:	source ID

When type >= 12, the structure changes to:

	offset 0:	type
	offset 2:	Error Source Structure Length

As ACPI 6.5 doesn't define type 12, we don't know yet where source ID
will be placed.

> 
> > +        addr += sizeof(type);
> > +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
> > +
> > +        if (src_id == source_id) {
> > +            break;
> > +        }
> > +
> > +        err_source_struct += HEST_GHES_V2_TABLE_SIZE;
> > +    }
> > +    if (i == num_sources) {
> > +        error_setg(errp, "HEST: Source %d not found.", source_id);
> > +        return;
> > +    }
> > +
> > +    /* Navigate though table address pointers */
> > +    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
> > +    hest_read_ack_addr = err_source_struct + GHES_ACK_OFFSET;  
> 
> > +
> > +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> > +                             sizeof(error_block_addr));  
> So this points to a registers
> > +
> > +    cpu_physical_memory_read(error_block_addr, cper_addr,
> > +                             sizeof(*cper_addr));  
> and this reads the register. I'm not sure the spec defines the
> contents of that register to be constant.  Maybe we should avoid
> reading the register here and do it instead at read of the record?
> I 'think' you could in theory use different storage for the CPER
> depending on other unhandled errors or whatever else meant you didn't
> want a fixed location.
> 
> Or maybe just add a comment to say that the location of CPER storage
> is fixed.

Sorry, but I missed your point. The actual offset of the error block 
address is defined when fw_cfg callback is called. When this happens,
this function is called:

	void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
	                          GArray *hardware_error)
	{
	    /* Create a read-only fw_cfg file for GHES */
	    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
        	            hardware_error->len);

	    /* Create a read-write fw_cfg file for Address */
	    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
	        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);

	    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
	        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);

	    ags->present = true;
	}

The other calls for fw_cfg functions ensure the offset of the memory read 
inside the hardware_error firmware and this never changes, as such offsets
are defined when the hardware_firmware is built at build_ghes_error_table()
function. This will only change if such function is called again, which
would, in turn, make acpi_ghes_add_fw_cfg() be called again.

In any case, no matter if build_ghes_error_table()/acpi_ghes_add_fw_cfg()
is called only once or multiple times [1], at the time 
get_ghes_source_offsets() is called, such offsets are stable.

[1] On some tests I did adding printks, the GHES build logic and the callbacks
    are called twice - both before loading OSPM.

    If migration is used, I suspect that it will be called again during
    migration but before starting OSPM. Again, when get_ghes_source_offsets()
    is called, the offsets are fixed.

Thanks,
Mauro

