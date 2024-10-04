Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5FDCFA773
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 12:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swhUm-0001nJ-LG; Fri, 04 Oct 2024 08:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1swhUl-0001nB-RD
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1swhUj-0003Yq-QY
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728045196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pfv4DknXvi7c0Dm9LageDMB1E0xGomxiqlYSwB0brCQ=;
 b=WXTzEB6H5npIq5Vp92EVr1SocK9+zvw/dzd5Y+GZsUYNheEyu/GFQSKDqGS/7LOCa+LV7g
 sf+jXzQduaR42YfEqI1gTdjYjwMPKmGRuIm3/ZLMmD4tUu3/Tajt50x+uqHfEf8j2PTArx
 7aQL4CtiMhF0OdB/dSWo6E2ztY61SlA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-yiws8Qp0M3GJ7uWBeVpFhw-1; Fri, 04 Oct 2024 08:33:14 -0400
X-MC-Unique: yiws8Qp0M3GJ7uWBeVpFhw-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-82ce3316d51so183264339f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 05:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728045194; x=1728649994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pfv4DknXvi7c0Dm9LageDMB1E0xGomxiqlYSwB0brCQ=;
 b=FHZKybNpjIGgPis6+g1XNa/wGlemNGaqJWF8WImnMboGPx3ipO/jlEMGhrQnYcRXHf
 Am3QW7bhckECQ3soK/X1VwY7FW6d3IYZ/+IT/41mCc2I49g8vbALfw+g/NGwEK68bGC7
 Kcw4AP05YUkDUOFyjDKCrjfleIOeA0OhIoAEjvgt5wc5r/jGmdrKbPakAAxvtswYSaKx
 +3Ml/4wsdC9pFjK+k95RIpX4Mr8XM1/dscSWkmBcjNtjWIp9VPfgJuyLcvIcFKgyNouJ
 lU6jmf2uFIFOXi8c6YkdXz+cGd80TXQBLhM1nfCPEdZeP48pokh9ldoXKqPSUdQ+hzAP
 Q+Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW8D3GwXbZwSoxd5PmmWMELtng9/1SAaeHZ6qsIDO4gZRfj79KSYBj8WULJulY2kfhjyrMp8LFH6ZX@nongnu.org
X-Gm-Message-State: AOJu0YwxUuaygk3dNOt43LaXo5Xf86yve8HS1CY8Sp9uCBVsHnje7JyL
 /JIQuT2f5vQ+x/DfC7On/MjYuGto9itfhdufqhvHmSxhlTtY16BJiih2sxp776FPl+4TqKTdH0L
 fXp+LsVi3et4dz6BhA48iHiSrnTmsF4kXSStMPRFy57B57cituCPm
X-Received: by 2002:a05:6602:13d4:b0:81f:75bf:6570 with SMTP id
 ca18e2360f4ac-834f7ca9049mr199050339f.5.1728045194039; 
 Fri, 04 Oct 2024 05:33:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsPbcYH6zwO/BFfqdtuNMTNYCDwPYWhNxZS7tnx1461BuZLmvjxUovf/T3oDYkU9ZhIp1krg==
X-Received: by 2002:a05:6602:13d4:b0:81f:75bf:6570 with SMTP id
 ca18e2360f4ac-834f7ca9049mr199046539f.5.1728045193573; 
 Fri, 04 Oct 2024 05:33:13 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4db55a639d0sm722368173.89.2024.10.04.05.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 05:33:13 -0700 (PDT)
Date: Fri, 4 Oct 2024 08:33:10 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH V2 01/13] machine: alloc-anon option
Message-ID: <Zv_ghrH6i4QOzne8@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-2-git-send-email-steven.sistare@oracle.com>
 <Zv7C7MeVP2X8bEJU@x1n>
 <2143f803-439e-4b8b-ae92-07caa913d646@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2143f803-439e-4b8b-ae92-07caa913d646@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Oct 04, 2024 at 12:14:35PM +0200, David Hildenbrand wrote:
> On 03.10.24 18:14, Peter Xu wrote:
> > On Mon, Sep 30, 2024 at 12:40:32PM -0700, Steve Sistare wrote:
> > > Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
> > > on the value of the anon-alloc machine property.  This option applies to
> > > memory allocated as a side effect of creating various devices. It does
> > > not apply to memory-backend-objects, whether explicitly specified on
> > > the command line, or implicitly created by the -m command line option.
> > > 
> > > The memfd option is intended to support new migration modes, in which the
> > > memory region can be transferred in place to a new QEMU process, by sending
> > > the memfd file descriptor to the process.  Memory contents are preserved,
> > > and if the mode also transfers device descriptors, then pages that are
> > > locked in memory for DMA remain locked.  This behavior is a pre-requisite
> > > for supporting vfio, vdpa, and iommufd devices with the new modes.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > [Igor seems missing in the loop; added]
> > 
> > > ---
> > >   hw/core/machine.c   | 19 +++++++++++++++++++
> > >   include/hw/boards.h |  1 +
> > >   qapi/machine.json   | 14 ++++++++++++++
> > >   qemu-options.hx     | 11 +++++++++++
> > >   system/physmem.c    | 35 +++++++++++++++++++++++++++++++++++
> > >   system/trace-events |  3 +++
> > >   6 files changed, 83 insertions(+)
> > > 
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index adaba17..a89a32b 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -460,6 +460,20 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
> > >       ms->mem_merge = value;
> > >   }
> > > +static int machine_get_anon_alloc(Object *obj, Error **errp)
> > > +{
> > > +    MachineState *ms = MACHINE(obj);
> > > +
> > > +    return ms->anon_alloc;
> > > +}
> > > +
> > > +static void machine_set_anon_alloc(Object *obj, int value, Error **errp)
> > > +{
> > > +    MachineState *ms = MACHINE(obj);
> > > +
> > > +    ms->anon_alloc = value;
> > > +}
> > > +
> > >   static bool machine_get_usb(Object *obj, Error **errp)
> > >   {
> > >       MachineState *ms = MACHINE(obj);
> > > @@ -1078,6 +1092,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
> > >       object_class_property_set_description(oc, "mem-merge",
> > >           "Enable/disable memory merge support");
> > > +    object_class_property_add_enum(oc, "anon-alloc", "AnonAllocOption",
> > > +                                   &AnonAllocOption_lookup,
> > > +                                   machine_get_anon_alloc,
> > > +                                   machine_set_anon_alloc);
> > > +
> > >       object_class_property_add_bool(oc, "usb",
> > >           machine_get_usb, machine_set_usb);
> > >       object_class_property_set_description(oc, "usb",
> > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > index 5966069..5a87647 100644
> > > --- a/include/hw/boards.h
> > > +++ b/include/hw/boards.h
> > > @@ -393,6 +393,7 @@ struct MachineState {
> > >       bool enable_graphics;
> > >       ConfidentialGuestSupport *cgs;
> > >       HostMemoryBackend *memdev;
> > > +    AnonAllocOption anon_alloc;
> > >       /*
> > >        * convenience alias to ram_memdev_id backend memory region
> > >        * or to numa container memory region
> > > diff --git a/qapi/machine.json b/qapi/machine.json
> > > index a6b8795..d4a63f5 100644
> > > --- a/qapi/machine.json
> > > +++ b/qapi/machine.json
> > > @@ -1898,3 +1898,17 @@
> > >   { 'command': 'x-query-interrupt-controllers',
> > >     'returns': 'HumanReadableText',
> > >     'features': [ 'unstable' ]}
> > > +
> > > +##
> > > +# @AnonAllocOption:
> > > +#
> > > +# An enumeration of the options for allocating anonymous guest memory.
> > > +#
> > > +# @mmap: allocate using mmap MAP_ANON
> > > +#
> > > +# @memfd: allocate using memfd_create
> > > +#
> > > +# Since: 9.2
> > > +##
> > > +{ 'enum': 'AnonAllocOption',
> > > +  'data': [ 'mmap', 'memfd' ] }
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index d94e2cb..90ab943 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
> > >       "                nvdimm=on|off controls NVDIMM support (default=off)\n"
> > >       "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
> > >       "                hmat=on|off controls ACPI HMAT support (default=off)\n"
> > > +    "                anon-alloc=mmap|memfd allocate anonymous guest RAM using mmap MAP_ANON or memfd_create (default: mmap)\n"
> > >       "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
> > >       "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
> > >       QEMU_ARCH_ALL)
> > > @@ -101,6 +102,16 @@ SRST
> > >           Enables or disables ACPI Heterogeneous Memory Attribute Table
> > >           (HMAT) support. The default is off.
> > > +    ``anon-alloc=mmap|memfd``
> > > +        Allocate anonymous guest RAM using mmap MAP_ANON (the default)
> > > +        or memfd_create.  This option applies to memory allocated as a
> > > +        side effect of creating various devices. It does not apply to
> > > +        memory-backend-objects, whether explicitly specified on the
> > > +        command line, or implicitly created by the -m command line
> > > +        option.
> > > +
> > > +        Some migration modes require anon-alloc=memfd.
> > > +
> > >       ``memory-backend='id'``
> > >           An alternative to legacy ``-mem-path`` and ``mem-prealloc`` options.
> > >           Allows to use a memory backend as main RAM.
> > > diff --git a/system/physmem.c b/system/physmem.c
> > > index dc1db3a..174f7e0 100644
> > > --- a/system/physmem.c
> > > +++ b/system/physmem.c
> > > @@ -47,6 +47,7 @@
> > >   #include "qemu/qemu-print.h"
> > >   #include "qemu/log.h"
> > >   #include "qemu/memalign.h"
> > > +#include "qemu/memfd.h"
> > >   #include "exec/memory.h"
> > >   #include "exec/ioport.h"
> > >   #include "sysemu/dma.h"
> > > @@ -69,6 +70,8 @@
> > >   #include "qemu/pmem.h"
> > > +#include "qapi/qapi-types-migration.h"
> > > +#include "migration/options.h"
> > >   #include "migration/vmstate.h"
> > >   #include "qemu/range.h"
> > > @@ -1849,6 +1852,35 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
> > >                   qemu_mutex_unlock_ramlist();
> > >                   return;
> > >               }
> > > +
> > > +        } else if (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD &&
> > > +                   !object_dynamic_cast(new_block->mr->parent_obj.parent,
> > > +                                        TYPE_MEMORY_BACKEND)) {
> > 
> > This is pretty fragile.. if someone adds yet another layer on top of memory
> > backend objects, the ownership links can change and this might silently run
> > into something else even without any warning..
> > 
> > I wished we dig into what is missing, but maybe that's too trivial.  If
> > not, we still need to make this as solid.  Perhaps that can be a ram flag
> > and let relevant callers pass in that flag explicitly.
> 
> How would they decide whether or not we want to set the flag in the current
> configuration?

It was in the previous email where it got cut..  I listed four paths that
may need change.

> 
> > 
> > I think RAM_SHARED can actually be that flag already - I mean, in all paths
> > that we may create anon mem (but not memory-backend-* objects), is it
> > always safe we always switch to RAM_SHARED from anon?
> 
> Do you mean only setting the flag (-> anonymous shmem) or switching also to
> memfd, which is a bigger change?

Switching to memfd.  I thought anon shmem (mmap(MAP_SHARED)) is mostly the
same internally, if we create memfd then mmap(MAP_SHARED) on top of it, no?

In this case we need the fds so we need to do the latter to cache the fds.

Thanks,

-- 
Peter Xu


