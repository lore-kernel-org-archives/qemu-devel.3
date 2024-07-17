Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D99C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6JV-0003B0-SH; Wed, 17 Jul 2024 11:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sU6JT-00034W-Hs
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sU6JP-0004lD-Jt
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721229081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+2eEQqMVahplQkPO1QZpWYgPdQH3Abe3puMcFP922d0=;
 b=NHTqGu0np/JjKbYh7kRFfI44iDiwPs+Nb7S1QsJ1D2/k7Ki0HUttvEAzkIY7US83MOSyBO
 ImVnbqlWZMyLKuppn2PZkXFsQ+tdgQ5GElRZLKac/PjLwUMmt/NIkoOpYjIIUCBZ2j0wGX
 ujIuvD6suC7C3cy6NqxiK+rs+u+/H8s=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-8gfWenH6NBiXHFYWFtVGsg-1; Wed, 17 Jul 2024 11:11:20 -0400
X-MC-Unique: 8gfWenH6NBiXHFYWFtVGsg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52e982ad660so6758944e87.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721229079; x=1721833879;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2eEQqMVahplQkPO1QZpWYgPdQH3Abe3puMcFP922d0=;
 b=TJQyo0fwW2D/D15erVda2spq4wlrDckyUAxthe+34HRffFSoRm+B2HpLf39YJMfXX4
 3963ZMNZ03/Be49+6Rt1v9JViR2nyxfgnH3UsypXmperJ9S08hQVyAUFKpxBmxKA2DL1
 er3+oZFFZsFz02++XHmN4sidbfWnvQQ4ldBDKa9iqb9uHB0uRJ7dWVdVky2kkIY7aQlo
 Qzhdm2OpzEjoWAT3Bw/N9CfZvzDD7iLOF/ZkNMRKXgpmALSudgbKQdYJwBrXGf+gX+zw
 GKYhCQ5RL9bG0AVD3G0InDIobhYVlMu0Z9j4w9ClSevyTF3jglVJqqLSgFL2CeHaa/t+
 446g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4delbdfOCFsyMDbYNSjrZGMv2g6+28PHIekaSxpU1fyXhcMdGZLuPYTZVWUHLU0mxv71RSyKS24B/ckyewalV1o5bD4Y=
X-Gm-Message-State: AOJu0YzyBI/66oqYj0RpwsD63S6KKUQLjW6uCOYYIIB4nRvecu4gw9/U
 IuL51DAa2tUAFKRBN1rXXXVV6lCdEAilWjtkIRJiz3d0w2FC0D8mQxaXtepWFJSP5TZVT6//MvH
 NnNq+++hyyevUaWLRpMRDJSK/OhuwygHoq8pWKc/YOI7YonpsxEyw
X-Received: by 2002:a05:6512:b8b:b0:52c:dbc2:ea1 with SMTP id
 2adb3069b0e04-52ee53ac96dmr1486914e87.6.1721229078674; 
 Wed, 17 Jul 2024 08:11:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGctBApGLdqc7W6VrXOK8eveuOEKOM5CfE2dy3t/5syryB++d9P7PT0eJVhp62J4+/JQPoTmg==
X-Received: by 2002:a05:6512:b8b:b0:52c:dbc2:ea1 with SMTP id
 2adb3069b0e04-52ee53ac96dmr1486857e87.6.1721229077673; 
 Wed, 17 Jul 2024 08:11:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:c194:849d:f1e:3618:dc03])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c7799f1fsm1613445e9.6.2024.07.17.08.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:11:17 -0700 (PDT)
Date: Wed, 17 Jul 2024 11:11:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 ankita@nvidia.com, linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, eduardo@habkost.net,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 10/13] hw/acpi: Generic Port Affinity Structure support
Message-ID: <20240717110827-mutt-send-email-mst@kernel.org>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
 <20240712110837.1439736-11-Jonathan.Cameron@huawei.com>
 <20240715164841.1979fdea@imammedo.users.ipa.redhat.com>
 <20240717160258.00006893@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717160258.00006893@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 17, 2024 at 04:02:58PM +0100, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 16:48:41 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Fri, 12 Jul 2024 12:08:14 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > 
> > > These are very similar to the recently added Generic Initiators
> > > but instead of representing an initiator of memory traffic they
> > > represent an edge point beyond which may lie either targets or
> > > initiators.  Here we add these ports such that they may
> > > be targets of hmat_lb records to describe the latency and
> > > bandwidth from host side initiators to the port.  A discoverable
> > > mechanism such as UEFI CDAT read from CXL devices and switches
> > > is used to discover the remainder of the path, and the OS can build
> > > up full latency and bandwidth numbers as need for work and data
> > > placement decisions.
> > > 
> > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > Tested-by: "Huang, Ying" <ying.huang@intel.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > ACPI tables generation LGTM
> > As for the rest my review is perfunctory mostly.
> 
> The node type points and missing descriptor applying equally to generic
> initiators. I'll add a couple of patches cleaning that up as well as 
> fixing them up for generic ports.
> 
> For the exit(1) that was copying other similar locations. I don't
> mind changing it though if something else is preferred.
> 
> Given tight timescales (and I was away for a few days which didn't
> help), I'll send out a v6 with changes as below.
> 
> Jonathan
> 

I'm working on a pull and going offline for a week guys, what's not in
will be in the next release.  Sorry.

> > 
> > > ---
> > > v5: Push the definition of TYPE_ACPI_GENERIC_PORT down into the
> > >     c file (similar to TYPE_ACPI_GENERIC_INITIATOR in earlier patch)
> > > ---
> > >  qapi/qom.json                       |  34 +++++++++
> > >  include/hw/acpi/aml-build.h         |   4 +
> > >  include/hw/acpi/pci.h               |   2 +-
> > >  include/hw/pci/pci_bridge.h         |   1 +
> > >  hw/acpi/aml-build.c                 |  40 ++++++++++
> > >  hw/acpi/pci.c                       | 112 +++++++++++++++++++++++++++-
> > >  hw/arm/virt-acpi-build.c            |   2 +-
> > >  hw/i386/acpi-build.c                |   2 +-
> > >  hw/pci-bridge/pci_expander_bridge.c |   1 -
> > >  9 files changed, 193 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > index 8e75a419c3..b97c031b73 100644
> > > --- a/qapi/qom.json
> > > +++ b/qapi/qom.json
> > > @@ -838,6 +838,38 @@
> > >    'data': { 'pci-dev': 'str',
> > >              'node': 'uint32' } }
> > >  
> > > +##
> > > +# @AcpiGenericPortProperties:
> > > +#
> > > +# Properties for acpi-generic-port objects.
> > > +#
> > > +# @pci-bus: QOM path of the PCI bus of the hostbridge associated with
> > > +#     this SRAT Generic Port Affinity Structure.  This is the same as
> > > +#     the bus parameter for the root ports attached to this host
> > > +#     bridge.  The resulting SRAT Generic Port Affinity Structure will
> > > +#     refer to the ACPI object in DSDT that represents the host bridge
> > > +#     (e.g.  ACPI0016 for CXL host bridges).  See ACPI 6.5 Section
> > > +#     5.2.16.7 for more information.
> > > +#  
> > 
> > > +# @node: Similar to a NUMA node ID, but instead of providing a
> > > +#     reference point used for defining NUMA distances and access
> > > +#     characteristics to memory or from an initiator (e.g. CPU), this
> > > +#     node defines the boundary point between non-discoverable system
> > > +#     buses which must be described by firmware, and a discoverable
> > > +#     bus.  NUMA distances and access characteristics are defined to
> > > +#     and from that point.  For system software to establish full
> > > +#     initiator to target characteristics this information must be
> > > +#     combined with information retrieved from the discoverable part
> > > +#     of the path.  An example would use CDAT (see UEFI.org)
> > > +#     information read from devices and switches in conjunction with
> > > +#     link characteristics read from PCIe Configuration space.  
> > 
> > you lost me here (even reading this several time doesn't help).
> > Perhaps I lack specific domain knowledge, but is there a way to make it
> > more comprehensible for layman?
> 
> This is far from the first version (which Markus really didn't like ;)
> It is really easy to draw as a sequence of diagrams and really tricky
> to put in text!  Not so easy to get the kernel code right either
> as it turns out but that's another story.
> 
> Perhaps if I add something to the end to say what you do with it
> that might help?
> 
> "To get the full path latency, from CPU to CXL attached DRAM on a type 3
>  CXL device:  Add the latency from CPU to Generic Port (from HMAT indexed
>  via the the node ID in this SRAT structure) to that for CXL bus links, the
>  latency across intermediate switches and from the EP port to the
>  actual memory.  Bandwidth is more complex as there may be interleaving
>  across multiple devices and shared links in the path."
> 
> > 
> > > +#
> > > +# Since: 9.1
> > > +##
> > > +{ 'struct': 'AcpiGenericPortProperties',
> > > +  'data': { 'pci-bus': 'str',
> > > +            'node': 'uint32' } }
> > > +
> 


