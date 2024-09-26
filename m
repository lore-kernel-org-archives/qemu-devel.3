Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919E1CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 14:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stpLA-0002z4-CO; Thu, 26 Sep 2024 10:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stpL8-0002y9-GE; Thu, 26 Sep 2024 10:19:30 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stpL6-0005Rt-En; Thu, 26 Sep 2024 10:19:30 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1610A5C5817;
 Thu, 26 Sep 2024 14:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB2FC4CEC5;
 Thu, 26 Sep 2024 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727360359;
 bh=2osnQDz0LxKw4i1NaGRSjr4kpgAji49Rc3tJuNnxvYQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gKeYqO+ce9pS5qu95pV6p0ksXn7YVD3O0XkWGMqelZ+nWaWPlgLVilDOvqg1c/eKb
 Jg56HVwWZTAEd059/HhfFHK0KFnOum4mw7U/WMmTkjW5VsDv7Wg68MH1veITUV9Hwv
 Hq1aowIB30BgpssImhGG5kUUSfhzj7EjB/LAi9SJp77uQm3llZKCHw1Ong6MxIoFbk
 b+TC6pNb/SvH8XUNsGVaeVbXnWwfAWY+WJGXamIrZsYUWAhs2qDODezHScIi1Fa82P
 q9zhDlY2Yp2zRC4iZ4F64SO6S7wR/CiOZcL420KsGiOw7EOUGXuJl6Uj3uBZUq3O2/
 PfHMRObjYVR4g==
Date: Thu, 26 Sep 2024 16:19:15 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 09/15] acpi/ghes: make the GHES record generation more
 generic
Message-ID: <20240926161726.3945f835@foz.lan>
In-Reply-To: <20240926130056.00001e12@Huawei.com>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
 <9b256923695e2202f549cbbb11dc22982cb22abf.1727236561.git.mchehab+huawei@kernel.org>
 <20240926130056.00001e12@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Em Thu, 26 Sep 2024 13:00:56 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 25 Sep 2024 06:04:14 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Split the code into separate functions to allow using the
> > common CPER filling code by different error sources.
> > 
> > The generic code was moved to ghes_record_cper_errors(),
> > and ghes_gen_err_data_uncorrectable_recoverable() now contains
> > only a logic to fill GEGB part of the record.
> > 
> > The remaining code to generate a memory error now belongs to
> > acpi_ghes_record_errors() function.
> > 
> > A further patch will give it a better name.  
> 
> That bit is fine, I'm less sure about
> ghes_gen_err_data_uncorrectable_recoverable()
> Maybe you refactor that later, but I'd suggest doing so in this
> patch to make it 
> ghes_gen_data() with the uncorrectable and recoverable bits
> passed in as parameters.

For now, no need. When using the error injection script, such
function is not used. The script can already play with what's
defined there.

Besides that, I tried to generalize it, but it is not trivial,
as passing some things as parameter is really hard. So, instead,
I opted to keep the code as-is. It can be changed later once we
add internal events that require a different setting than what
we have with ARMv8 memory errors via SEA.
> 
> Jonathan
> 
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/ghes.c         | 118 +++++++++++++++++++++++++----------------
> >  include/hw/acpi/ghes.h |   3 ++
> >  2 files changed, 74 insertions(+), 47 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 340a0263faf8..307b5a41d539 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -181,51 +181,30 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
> >      build_append_int_noprefix(table, 0, 7);
> >  }
> >  
> > -static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> > -                                      uint64_t error_physical_addr)
> > +static void
> > +ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
> > +                                            const uint8_t *section_type,
> > +                                            int data_length)
> >  {  
> 
> That's an ugly name .  Suggestion below on instead passing parameters
> for the uncorrectable and recoverable parts and amking this
> ghes_gen_err_data()
> 
> > -    GArray *block;
> > -
> > -    /* Memory Error Section Type */
> > -    const uint8_t uefi_cper_mem_sec[] =
> > -          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> > -                  0xED, 0x7C, 0x83, 0xB1);
> > -
> >      /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> >       * Table 17-13 Generic Error Data Entry
> >       */
> >      QemuUUID fru_id = {};
> > -    uint32_t data_length;
> >  
> > -    block = g_array_new(false, true /* clear */, 1);
> > -
> > -    /* This is the length if adding a new generic error data entry*/
> > -    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
> >      /*
> > -     * It should not run out of the preallocated memory if adding a new generic
> > -     * error data entry
> > +     * Calculate the size with this block. No need to check for
> > +     * too big CPER, as CPER size is checked at ghes_record_cper_errors()
> >       */
> > -    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> > -            ACPI_GHES_MAX_RAW_DATA_LENGTH);
> > +    data_length += ACPI_GHES_GESB_SIZE;
> >  
> >      /* Build the new generic error status block header */
> >      acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
> >          0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
> >  
> >      /* Build this new generic error data entry header */
> > -    acpi_ghes_generic_error_data(block, uefi_cper_mem_sec,
> > +    acpi_ghes_generic_error_data(block, section_type,
> >          ACPI_CPER_SEV_RECOVERABLE, 0, 0,
> >          ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);  
> Maybe should just pass in ACPI_CPER_SEV_RECOVERABLE 
> and ACPI_GEBS_UNCORRECTABLE in parameters.
> 
> Main advantage being that should allow reuse for other combinations
> and it gets rid of the nasty function name!
> 
> > -
> > -    /* Build the memory section CPER for above new generic error data entry */
> > -    acpi_ghes_build_append_mem_cper(block, error_physical_addr);
> > -
> > -    /* Write the generic error data entry into guest memory */
> > -    cpu_physical_memory_write(error_block_address, block->data, block->len);
> > -
> > -    g_array_free(block, true);
> > -
> > -    return 0;
> >  }
> >  
> >  /*
> > @@ -399,14 +378,19 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> >      ags->present = true;
> >  }
> >  
> > -int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> > +void ghes_record_cper_errors(const void *cper, size_t len,
> > +                             uint16_t source_id, Error **errp)
> >  {  
> 
> > -    return ret;
> > +    read_ack_register = cpu_to_le64(0);
> > +    /*
> > +        * Clear the Read Ack Register, OSPM will write it to 1 when
> > +        * it acknowledges this error.
> > +        */  
> 
> Indent issue.
> 
> > +    cpu_physical_memory_write(read_ack_register_addr,
> > +        &read_ack_register, sizeof(uint64_t));
> > +
> > +    /* Write the generic error data entry into guest memory */
> > +    cpu_physical_memory_write(error_block_addr, cper, len);
> > +
> > +    return;
> > +}  
> 



Thanks,
Mauro

