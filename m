Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CF3D58065
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 11:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFXJn-0005MX-Lb; Mon, 25 Nov 2024 06:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tFXJk-0005JJ-7u; Mon, 25 Nov 2024 06:31:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tFXJh-0003TL-OF; Mon, 25 Nov 2024 06:31:47 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xxk4H5x5Xz6K9Jr;
 Mon, 25 Nov 2024 19:29:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id DE5821400CB;
 Mon, 25 Nov 2024 19:31:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 25 Nov
 2024 12:31:34 +0100
Date: Mon, 25 Nov 2024 11:31:32 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/6] acpi/ghes: Use HEST table offsets when preparing
 GHES records
Message-ID: <20241125113132.000069e1@huawei.com>
In-Reply-To: <20241122113714.04450f6b@foz.lan>
References: <cover.1731486604.git.mchehab+huawei@kernel.org>
 <cf60aee0059d12755c1b9deb2dddb355d8543297.1731486604.git.mchehab+huawei@kernel.org>
 <20241120145930.00003895@huawei.com>
 <20241122113714.04450f6b@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.93, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


> >   
> > > 
> > > Yet, keep the old code, as this is needed for migration purposes.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  hw/acpi/ghes.c | 98 ++++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 88 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index c93bbaf1994a..9ee25efe8abf 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -61,6 +61,23 @@
> > >   */
> > >  #define ACPI_GHES_GESB_SIZE                 20
> > >  
> > > +/*
> > > + * Offsets with regards to the start of the HEST table stored at
> > > + * ags->hest_addr_le, according with the memory layout map at
> > > + * docs/specs/acpi_hest_ghes.rst.
> > > + */
> > > +    
> > /*
> >  * ACPI 6.2:
> > 
> > to be consistent with local style.  
> 
> Actually, the local style inside this file was preserved. See, before
> this series we have:
Ah. That's me being lazy and unclear :(
What I meant was

/*
 * ACPI 6.2:  18.3.2.8 Generic Hardware Error Source version 2

So open the comment with a blank line.
 
> 
> $ git grep "ACPI " hw/acpi/ghes.c
> hw/acpi/ghes.c: * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> hw/acpi/ghes.c: * ACPI 6.2: 18.3.2.7.1 Generic Error Data,
> hw/acpi/ghes.c: * ACPI 4.0: 17.3.2.7 Hardware Error Notification
> hw/acpi/ghes.c: * ACPI 6.1: 18.3.2.7.1 Generic Error Data
> hw/acpi/ghes.c: * ACPI 6.1: 18.3.2.7.1 Generic Error Data
> hw/acpi/ghes.c:    /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> hw/acpi/ghes.c:         * ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> hw/acpi/ghes.c:     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
> 
> >   

> > 
> >   
> > > +        return;
> > > +    }
> > > +
> > > +    cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
> > > +    num_sources = le32_to_cpu(num_sources);
> > > +
> > > +    err_source_struct = hest_addr + sizeof(num_sources);
> > > +
> > > +    /*
> > > +     * Currently, HEST Error source navigates only for GHESv2 tables
> > > +     */    
> > 
> > Feels like duplication of the comment below where the type check is.
> > Maybe drop this one?  
> 
> If I recall correctly [1], Igor asked to place such comment, on one of
> the past versions of this code.
> 
> IMO, placing it clearly there helps to identify what needs to change when
> support for non-GHES tables is needed.
> 
> [1] this is the 12th version of this code - my memory is starting to fail
>     to remind were exactly each change was requested.
Me too! :)


> >   
> > > +        addr += sizeof(type);
> > > +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
> > > +
> > > +        if (src_id == source_id) {
> > > +            break;
> > > +        }
> > > +
> > > +        err_source_struct += HEST_GHES_V2_TABLE_SIZE;
> > > +    }
> > > +    if (i == num_sources) {
> > > +        error_setg(errp, "HEST: Source %d not found.", source_id);
> > > +        return;
> > > +    }
> > > +
> > > +    /* Navigate though table address pointers */
> > > +    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
> > > +    hest_read_ack_addr = err_source_struct + GHES_ACK_OFFSET;    
> >   
> > > +
> > > +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> > > +                             sizeof(error_block_addr));    
> > So this points to a registers  
> > > +
> > > +    cpu_physical_memory_read(error_block_addr, cper_addr,
> > > +                             sizeof(*cper_addr));    
> > and this reads the register. I'm not sure the spec defines the
> > contents of that register to be constant.  Maybe we should avoid
> > reading the register here and do it instead at read of the record?
> > I 'think' you could in theory use different storage for the CPER
> > depending on other unhandled errors or whatever else meant you didn't
> > want a fixed location.
> > 
> > Or maybe just add a comment to say that the location of CPER storage
> > is fixed.  
> 
> Sorry, but I missed your point. The actual offset of the error block 
> address is defined when fw_cfg callback is called. When this happens,
> this function is called:
> 
> 	void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> 	                          GArray *hardware_error)
> 	{
> 	    /* Create a read-only fw_cfg file for GHES */
> 	    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>         	            hardware_error->len);
> 
> 	    /* Create a read-write fw_cfg file for Address */
> 	    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> 	        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> 
> 	    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> 	        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> 
> 	    ags->present = true;
> 	}

My question was intended to be a little different but was based on a misread on my part.
I'd failed to figure out this function is called on each addition of an error
not just once.

Code is fine as is.

Jonathan


> 
> The other calls for fw_cfg functions ensure the offset of the memory read 
> inside the hardware_error firmware and this never changes, as such offsets
> are defined when the hardware_firmware is built at build_ghes_error_table()
> function. This will only change if such function is called again, which
> would, in turn, make acpi_ghes_add_fw_cfg() be called again.
> 
> In any case, no matter if build_ghes_error_table()/acpi_ghes_add_fw_cfg()
> is called only once or multiple times [1], at the time 
> get_ghes_source_offsets() is called, such offsets are stable.
> 
> [1] On some tests I did adding printks, the GHES build logic and the callbacks
>     are called twice - both before loading OSPM.
> 
>     If migration is used, I suspect that it will be called again during
>     migration but before starting OSPM. Again, when get_ghes_source_offsets()
>     is called, the offsets are fixed.
> 
> Thanks,
> Mauro


