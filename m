Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D93C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnard-0002yO-Lj; Thu, 27 Feb 2025 05:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnarN-0002vW-QW; Thu, 27 Feb 2025 05:11:17 -0500
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnarK-0006rg-HN; Thu, 27 Feb 2025 05:11:17 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BF7FF61188;
 Thu, 27 Feb 2025 10:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82F0C4CEE9;
 Thu, 27 Feb 2025 10:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740651070;
 bh=3VbG0f+R5quSXn4piQUIOSAIYO8Kb99nmMmrqQDcbgI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=eiYV5XgphA4L9gSM2Liy1EkmaHuBYOrU+Oz6IdWNgqqX1RyDWbpU+95EgZ/R9Nk+H
 SXGGT1PU/Y6/qVFkWVPJFuLyLzlnJQ+SwMq2ZvB8S8J8p5uUzoa/A7gAvRV32Jkcub
 ocsEAN3Sywe+P5i247MUC1V4pUS2lPqfX6d9iedWnJNuKNpsvtwXfX1xHYcmOwvXyp
 mOg4qXUUzRzw3w7I5BDK4e6ZhiWhRWD2/OhQcwYqm7g4gRQtnrzCj28Aes8eXc64q2
 TKaZi5XKJidI+j2q3zy1KbjQrSBV5yrzK+O5MBXL4+zhC2PbJkb7qdV4MIAALEDov9
 AzbyKSR92m5gw==
Date: Thu, 27 Feb 2025 11:11:05 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/14] acpi/ghes: Use HEST table offsets when
 preparing GHES records
Message-ID: <20250227111105.194037f1@foz.lan>
In-Reply-To: <20250227102255.6843705e@imammedo.users.ipa.redhat.com>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <9610ff88cf6fdc59cbfc8871d653fd890391be1e.1738345063.git.mchehab+huawei@kernel.org>
 <20250203153423.3e4de17c@imammedo.users.ipa.redhat.com>
 <20250221070221.329bdfb0@foz.lan>
 <20250225104327.0a2d1cb4@imammedo.users.ipa.redhat.com>
 <20250226171406.19c2de6b@sal.lan>
 <20250227102255.6843705e@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04::f03c:95ff:fe5e:7468;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Em Thu, 27 Feb 2025 10:22:55 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Wed, 26 Feb 2025 17:14:06 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Tue, 25 Feb 2025 10:43:27 +0100
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Fri, 21 Feb 2025 07:02:21 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >     
> > > > Em Mon, 3 Feb 2025 15:34:23 +0100
> > > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > > >       
> > > > > On Fri, 31 Jan 2025 18:42:44 +0100
> > > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > > >         
> > > > > > There are two pointers that are needed during error injection:
> > > > > > 
> > > > > > 1. The start address of the CPER block to be stored;
> > > > > > 2. The address of the ack.
> > > > > > 
> > > > > > It is preferable to calculate them from the HEST table.  This allows
> > > > > > checking the source ID, the size of the table and the type of the
> > > > > > HEST error block structures.
> > > > > > 
> > > > > > Yet, keep the old code, as this is needed for migration purposes.
> > > > > > 
> > > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > > > ---
> > > > > >  hw/acpi/ghes.c         | 132 ++++++++++++++++++++++++++++++++++++-----
> > > > > >  include/hw/acpi/ghes.h |   1 +
> > > > > >  2 files changed, 119 insertions(+), 14 deletions(-)
> > > > > > 
> > > > > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > > > > index 27478f2d5674..8f284fd191a6 100644
> > > > > > --- a/hw/acpi/ghes.c
> > > > > > +++ b/hw/acpi/ghes.c
> > > > > > @@ -41,6 +41,12 @@
> > > > > >  /* Address offset in Generic Address Structure(GAS) */
> > > > > >  #define GAS_ADDR_OFFSET 4
> > > > > >  
> > > > > > +/*
> > > > > > + * ACPI spec 1.0b
> > > > > > + * 5.2.3 System Description Table Header
> > > > > > + */
> > > > > > +#define ACPI_DESC_HEADER_OFFSET     36
> > > > > > +
> > > > > >  /*
> > > > > >   * The total size of Generic Error Data Entry
> > > > > >   * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> > > > > > @@ -61,6 +67,25 @@
> > > > > >   */
> > > > > >  #define ACPI_GHES_GESB_SIZE                 20
> > > > > >  
> > > > > > +/*
> > > > > > + * Offsets with regards to the start of the HEST table stored at
> > > > > > + * ags->hest_addr_le,          
> > > > > 
> > > > > If I read this literary, then offsets above are not what
> > > > > declared later in this patch.
> > > > > I'd really drop this comment altogether as it's confusing,
> > > > > and rather get variables/macro naming right
> > > > >         
> > > > > > according with the memory layout map at
> > > > > > + * docs/specs/acpi_hest_ghes.rst.
> > > > > > + */          
> > > > > 
> > > > > what we need is update to above doc, describing new and old ways.
> > > > > a separate patch.        
> > > > 
> > > > I can't see anything that should be changed at
> > > > docs/specs/acpi_hest_ghes.rst, as this series doesn't change the
> > > > firmware layout: we're still using two firmware tables:
> > > > 
> > > > - etc/acpi/tables, with HEST on it;
> > > > - etc/hardware_errors, with:
> > > > 	- error block addresses;
> > > > 	- read_ack registers;
> > > > 	- CPER records.
> > > > 
> > > > The only changes that this series introduce are related to how
> > > > the error generation logic navigates between HEST and hw_errors
> > > > firmware. This is not described at acpi_hest_ghes.rst, and both
> > > > ways follow ACPI specs to the letter.
> > > > 
> > > > The only difference is that the code which populates the CPER
> > > > record and the error/read offsets doesn't require to know how
> > > > the HEST table generation placed offsets, as it will basically
> > > > reproduce what OSPM firmware does when handling	HEST events.      
> > > 
> > > section 8 describes old way to get to address to record old CPER,
> > > so it needs to amended to also describe a new approach and say
> > > which way is used for which version.
> > > 
> > > possibly section 11 might need some messaging as well.    
> > 
> > Ok, I'll modify it and place at the end of the series. Please
> > see below if the new text is ok for you.
> > 
> > ---
> > 
> > [PATCH] docs/specs/acpi_hest_ghes.rst: update it to reflect some changes  
> 
> s/^^^/docs: hest: add new "etc/acpi_table_hest_addr" and update workflow/
> 
> > 
> > While the HEST layout didn't change, there are some internal
> > changes related to how offsets are calculated and how memory error
> > events are triggered.
> > 
> > Update specs to reflect such changes.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > 
> > diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> > index c3e9f8d9a702..f22d2eefdec7 100644
> > --- a/docs/specs/acpi_hest_ghes.rst
> > +++ b/docs/specs/acpi_hest_ghes.rst
> > @@ -89,12 +89,21 @@ Design Details
> >      addresses in the "error_block_address" fields with a pointer to the
> >      respective "Error Status Data Block" in the "etc/hardware_errors" blob.
> >  
> > -(8) QEMU defines a third and write-only fw_cfg blob which is called
> > -    "etc/hardware_errors_addr". Through that blob, the firmware can send back
> > -    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
> > -    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
> > -    for the firmware. The firmware will write back the start address of
> > -    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
> > +(8) QEMU defines a third and write-only fw_cfg blob to store the location
> > +    where the error block offsets, read ack registers and CPER records are
> > +    stored.
> > +
> > +    Up to QEMU 9.2, the location was at "etc/hardware_errors_addr", and
> > +    contains an offset for the beginning of "etc/hardware_errors".
> > +
> > +    Newer versions place the location at "etc/acpi_table_hest_addr",
> > +    pointing to the beginning of the HEST table.
> > +
> > +    Through that such offsets, the firmware can send back the guest-side  
>        ^^^^^^^^^^^^^^^^^^^^^^^^^ can't parse that, suggest to just drop the phrase
> 
> > +    allocation addresses to QEMU. They contain a 8-byte entry. QEMU generates
> > +    a single WRITE_POINTER command for the firmware. The firmware will write
> > +    back the start address of either "etc/hardware_errors" or HEST table at  
>                 ^^^^ drop this?
> 
> > +    the correspoinding address firmware.
> >  
> >  (9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
> >      "Error Status Data Block", guest memory, and then injects platform specific
> > @@ -105,8 +114,6 @@ Design Details
> >       kernel, on receiving notification, guest APEI driver could read the CPER error
> >       and take appropriate action.
> >  
> > -(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
> > -     find out "Error Status Data Block" entry corresponding to error source. So supported
> > -     source_id values should be assigned here and not be changed afterwards to make sure
> > -     that guest will write error into expected "Error Status Data Block" even if guest was
> > -     migrated to a newer QEMU.
> > +(11) kvm_arch_on_sigbus_vcpu() report RAS errors via a SEA notifications,
> > +     when a SIGBUS event is triggered.  
>  
> >       The logic to convert a SEA notification
> > +     into a source ID is defined inside ghes.c source file.  
> that's cheating and not documentation by any means

I'll drop the last paragraph. I guess that (11) were here to document a hack on the
original design:
	"supported source_id values should be assigned here".

The new code doesn't do any assumptions like that. All it needs is that the caller
need to specify the notification type (currently, SEA or GPIO).

So, IMO the only thing eventually useful there is:

	(11) kvm_arch_on_sigbus_vcpu() report RAS errors via a SEA notifications,
	     when a SIGBUS event is triggered.  

Yet, to be frank, I'm not sure if this should be documented. So perhaps
the entire section (11) can be dropped.

Thanks,
Mauro

