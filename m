Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7D0CF31B7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 11:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svxbw-0005Kx-4o; Wed, 02 Oct 2024 07:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svxbo-0005Kg-Bs
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 07:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svxbm-0000KA-Ht
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 07:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727868807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OacWMmgHv0FrxXSdwcMjjtcw/9BGKunCsYuHMoUyHTo=;
 b=dIeo1UOOsj6TkJvPc0C33+6iSiOxkNDvT0z2XwP46N01jNeyRPOnDHgh+V2ifhswfSep7p
 /R2R5xBi1k1KC7WqXy79P1Q8YenwwmTBc1RzvxgrUC6SsQsaZ2T2e3rX4gvkD4X/vxRu3D
 CirIRxdpdBzxPC6DD3qSUzW1pzqql30=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-eYtGvsb7P_m4TEKv9tk-mg-1; Wed, 02 Oct 2024 07:33:26 -0400
X-MC-Unique: eYtGvsb7P_m4TEKv9tk-mg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb998fd32so43601185e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 04:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727868805; x=1728473605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OacWMmgHv0FrxXSdwcMjjtcw/9BGKunCsYuHMoUyHTo=;
 b=sYjpifrQpPHZivX+5k/n3l85tMtf9NBrMSKmR30mPoykJkqLCynIiVjUIj3NcQVv1U
 W1tT+zQkR1ySdFMdOHx6duVlFL1TJt7Tph/s8uXTQnNgnCQftYtfA3NED6FoKBQPQRT+
 O+Wj+Q3c9pAFepbO4tvyfXpaZL50nc/ZlmShOJufgRQnyw3zfeGfor5y9TPlwb98IWFx
 PeaocAafiQvCyhsvGRJVKBwrIjO0R/YTNmM9iLO9HyhKu6YRofQ1C33uAc/5Ai1xSrcJ
 yI677hkDlv9F8Yd3elX/mxsRjXo/HnDx1XNGLa5B6gugqdBbuZbvwlnKR3zkHkW6bSk+
 GWbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7vqtJ5iElmEmGxtOXrxdpLUYhc6G1wWZp8nwfAlGri/KEQBva3l4ERg3lUy5Myn08pgoVDg5QwGnK@nongnu.org
X-Gm-Message-State: AOJu0YxlS+Bbh22JOH0cVkZ0wGkOd36Qjs5jZsG135U613X3skri+ow7
 bI/SkqFuHJ/DU9NCJKDRmCm8/jERNQzEynwNhqPVDZTMFAM3SoMujDUjcY8fu3Q4qv+wBfXXM/0
 2haof/aH/9G2ujcjKtC1YJnquBFbAquQ+wwKzNZslGoIPRHtKkKib
X-Received: by 2002:a05:600c:350b:b0:42c:bcc8:5877 with SMTP id
 5b1f17b1804b1-42f777b8a2bmr17790505e9.13.1727868805494; 
 Wed, 02 Oct 2024 04:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh5kdLRHXNQVHLO4IQ4s+jfxD3RDKilLZCa1Pgo4DWYJ9Dawkz+/hVrM32DY8BuRLQmFZ8Ug==
X-Received: by 2002:a05:600c:350b:b0:42c:bcc8:5877 with SMTP id
 5b1f17b1804b1-42f777b8a2bmr17790285e9.13.1727868805009; 
 Wed, 02 Oct 2024 04:33:25 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79ead8d8sm16206855e9.19.2024.10.02.04.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 04:33:24 -0700 (PDT)
Date: Wed, 2 Oct 2024 13:33:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sandesh Patel <sandesh.patel@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, paul <paul@xen.org>, Rob Scheepens
 <rob.scheepens@nutanix.com>, Prerna Saxena <confluence@nutanix.com>,
 Alexander Graf <agraf@csgraf.de>
Subject: Re: More than 255 vcpus Windows VM setup without viommu ?
Message-ID: <20241002133322.18a4f1fa@imammedo.users.ipa.redhat.com>
In-Reply-To: <7571cdc42d6d69db0ac98ffc99801d11de1de129.camel@infradead.org>
References: <B75A5788-630B-4898-8758-52B57D3D5895@nutanix.com>
 <a80c99b0e10e71a5a301c884d699eeaff3893349.camel@infradead.org>
 <7571cdc42d6d69db0ac98ffc99801d11de1de129.camel@infradead.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Mon, 30 Sep 2024 16:50:21 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Sat, 2024-09-28 at 15:59 +0100, David Woodhouse wrote:
> > On Tue, 2024-07-02 at 05:17 +0000, Sandesh Patel wrote:  
> > > 
> > > The error is due to invalid MSIX routing entry passed to KVM.
> > > 
> > > The VM boots fine if we attach a vIOMMU but adding a vIOMMU can
> > > potentially result in IO performance loss in guest.
> > > I was interested to know if someone could boot a large Windows VM by
> > > some other means like kvm-msi-ext-dest-id.  
> > 
> > I think I may (with Alex Graf's suggestion) have found the Windows bug
> > with Intel IOMMU.
> > 
> > It looks like when interrupt remapping is enabled with an AMD CPU,
> > Windows *assumes* it can generate AMD-style MSI messages even if the
> > IOMMU is an Intel one. If we put a little hack into the IOMMU interrupt
> > remapping to make it interpret an AMD-style message, Windows seems to
> > boot at least a little bit further than it did before...  
> 
> Sadly, Windows has *more* bugs than that.
> 
> The previous hack extracted the Interrupt Remapping Table Entry (IRTE)
> index from an AMD-style MSI message, and looked it up in the Intel
> IOMMU's IR Table.
> 
> That works... for the MSIs generated by the I/O APIC.
> 
> However... in the Intel IOMMU model, there is a single global IRT, and
> each entry specifies which devices are permitted to invoke it. The AMD
> model is slightly nicer, in that it allows a per-device IRT.
> 
> So for a PCI device, Windows just seems to configure each MSI vector in
> order, with IRTE#0, 1, onwards. Because it's a per-device number space,
> right? Which means that first MSI vector on a PCI device gets aliased
> to IRQ#0 on the I/O APIC.
> 
> I dumped the whole IRT, and it isn't just that Windows is using the
> wrong index; it hasn't even set up the correct destination in *any* of
> the entries. So we can't even do a nasty trick like scanning and
> funding the Nth entry which is valid for a particular source-id.
> 
> Happily, Windows has *more* bugs than that... if I run with
> `-cpu host,+hv-avic' then it puts the high bits of the target APIC ID
> into the high bits of the MSI address. This *ought* to mean that MSIs
> from device miss the APIC (at 0x00000000FEExxxxx) and scribble over
> guest memory at addresses like 0x1FEE00004. But we can add yet
> *another* hack to catch that. For now I just hacked it to move the low
> 7 extra bits in to the "right" place for the 15-bit extension.
> 
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -361,6 +361,14 @@ static void pci_msi_trigger(PCIDevice *dev, MSIMessage msg)
>          return;
>      }
>      attrs.requester_id = pci_requester_id(dev);
> +    printf("Send MSI 0x%lx/0x%x from 0x%x\n", msg.address, msg.data, attrs.requester_id);
> +    if (msg.address >> 32) {
> +        uint64_t ext_id = msg.address >> 32;
> +        msg.address &= 0xffffffff;
> +        msg.address |= ext_id << 5;
> +        printf("Now 0x%lx/0x%x with ext_id %lx\n", msg.address, msg.data, ext_id);
> +    }
> +        
>      address_space_stl_le(&dev->bus_master_as, msg.address, msg.data,
>                           attrs, NULL);
>  }
> 
> We also need to stop forcing Windows to use logical mode, and force it
> to use physical mode instead:
> 
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -158,7 +158,7 @@ static void init_common_fadt_data(MachineState *ms, Object *o,
>               * used
>               */
>              ((ms->smp.max_cpus > 8) ?
> -                        (1 << ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL) : 0),
> +                        (1 << ACPI_FADT_F_FORCE_APIC_PHYSICAL_DESTINATION_MODE) : 0),
>          .int_model = 1 /* Multiple APIC */,
>          .rtc_century = RTC_CENTURY,
>          .plvl2_lat = 0xfff /* C2 state not supported */,
> 
> 
> So now, with *no* IOMMU configured, Windows Server 2022 is booting and
> using CPUs > 255:
>   Send MSI 0x1fee01000/0x41b0 from 0xfa
>   Now 0xfee01020/0x41b0 with ext_id 1
> 
> That trick obviously can't work the the I/O APIC, but I haven't managed
> to persuade Windows to target I/O APIC interrupts at any CPU other than
> #0 yet. I'm trying to make QEMU run with *only* higher APIC IDs, to
> test.
> 
> It may be that we need to advertise an Intel IOMMU that *only* has the
> I/O APIC behind it, and all the actual PCI devices are direct, so we
> can abuse that last Windows bug.

It's interesting as an experiment, to prove that Windows is riddled with bugs.
(well, and it could serve as starting point to report issue to MS)
But I'd rather Microsoft fix bugs on their side, instead of putting hacks in
QEMU.

PS:
Given it's AMD cpu, I doubt very much that using intel_iommu would be
accepted by Microsoft as valid complaint though.


