Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64DFC79F83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Rzz-0000RR-J3; Fri, 04 Sep 2026 07:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2Rzy-0000Qq-Qz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2Rzw-0003XF-BX
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788520938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZtNHj4dJNQM8XNol7kcuN6tcN2rtdw5KbaZPWFxkZ8=;
 b=AIr/gL6OFTp1xK/r9Pgnw9sM2YdxfnZamYnlwwbTWSQpPGGIdP8fa+A7wISCxZoZRkil7N
 wFsveyohXqtYtKeLcPWTT7YmuTx5vOGMU1yIunG/Qn/3Cw4ctOT0EK0ZnxjQmbTw5/IXci
 oz5QTz6Z2PIGzHhmJ5BczirySKiAYno=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-HmhwgVrGMYCUrad92udVNA-1; Fri, 04 Sep 2026 07:22:17 -0400
X-MC-Unique: HmhwgVrGMYCUrad92udVNA-1
X-Mimecast-MFC-AGG-ID: HmhwgVrGMYCUrad92udVNA_1788520936
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48436db95e1so595481f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788520936; x=1789125736; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DZtNHj4dJNQM8XNol7kcuN6tcN2rtdw5KbaZPWFxkZ8=;
 b=IyySem2Slt/OxtUfAB55NFom328dSxt5Y8jltU5aKsyddNCmI4sn3gLDprel20k1RI
 8wCpthdFCcEAQEZALZHbFVbv+hIn34lguwphbUSSXwS3yuxEbVmWVIutLZUWHhO1iY0W
 4AikszHJ0IRRM97Wb5GR00D8o3NU0DiSug4Tzp9nqLeFXqYQgWGTGX+Bk3pX1+zd4vVS
 XTFq2H0XYuTx1LsqLklzoSzVoib2g9grUafsOz3x1/dBPfiVjzberue/UQuoCu3Itwmb
 38rkx62V/bUt6BrXSYDZnHOG5guXPx3mdKNa2jgK9EWlmVQB7VAIDbEgWJMIZPVbEMA0
 e+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788520936; x=1789125736;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DZtNHj4dJNQM8XNol7kcuN6tcN2rtdw5KbaZPWFxkZ8=;
 b=kfygcht3q7DIkCv7Eb1JRBibYHQ0dsd0PcVTOowbFkTHzyoNsPsLAzzM3cPmYQwZ4y
 H3aGx/+XzrwffU7fTzNfjS9mjGUXZLTS85rwivbtymMAwRR4632l4Hh9TG9pmU9rdvQB
 C3QzPgZFOhawo6HMA7Lsw7wkUInB4t6O1B1DIJJ68/LXRMyGwxmBx1eCgy/HU+bSTWNE
 cSxqGcJxk91nHEVhHYjOcRuUkllkRC76PZVMJKiB52yKiKY8cp+7BdSUWPi/B8S7oK3K
 Yj7XgC4NZqLH3YvwU6FrO4mwaTSpBYLINZb4wfXdBTxKYhL/AlNbnbPn+IbpsTrL5BMB
 abew==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoQFIRM0EbLQ7RHsvtEIEQsQz1Xw3rr3A7ii0EuQR+qtG/Oeo9nnOM3dCwXUGKr7zLOHE+4q1J7OBu@nongnu.org
X-Gm-Message-State: AFuF++lvJk3QYVTLNTu7/Agxpvr6OaFv4Ks19qZccOiLQ0xbwqymeX5n
 EoEVKgjqh+O5b9l7z6QD9r0spXBen21S8rbzA0khdk+VOG/DJUDRGgaXYxCh1Wox1y+XwzNTATl
 u7R/Xuhjk36SWE2AyNNEmfQ1wXFfMGKSV9pixfnS2FvMoGTHl09zS1OBp
X-Gm-Gg: AYBFou2gWNwKF6AFIaqE62cJcY5aBG8f9G6paXb4ybMmEKZOBp4g6NFSQKLtwrAJB//
 k42rCdDpv4KsEx7c4KAiSh090vLAPAq/gChLkXyFkWg5+K2FZfPHWWfUY/PAqyf2WPlAxTPrBKB
 E6O/rL+xAfNzTXUqBBtTewBHeVVaqfvd1WRdzxXDfwTDCaMYYxSP+Oqz24MmtsvMTpR4c1QUtVH
 rkaXg5QjI06elJ3D+omSM2l5wjLfPMkiyGYvpSA6lbql0IaRltPQd4SqWRNxGEWQGPyTO0PcK9e
 HUuPmQDet3Pur08/DyQq+zWpiZ6lUPdp/nYosREBsCFLymCAb85k+A+bzf3Tl1ncYQ2IUJdAp/6
 +IKE4ac5poFl2YOU5YSdcZLU=
X-Received: by 2002:a05:6000:38c:b0:484:3fce:6ad2 with SMTP id
 ffacd0b85a97d-485872cd602mr9297376f8f.15.1788520935762; 
 Fri, 04 Sep 2026 04:22:15 -0700 (PDT)
X-Received: by 2002:a05:6000:38c:b0:484:3fce:6ad2 with SMTP id
 ffacd0b85a97d-485872cd602mr9297283f8f.15.1788520935123; 
 Fri, 04 Sep 2026 04:22:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bfe14sm5761659f8f.35.2026.09.04.04.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 04:22:14 -0700 (PDT)
Date: Fri, 4 Sep 2026 07:22:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, dave@treblig.org,
 anisinha@redhat.com, philmd@mailo.com, aurelien@aurel32.net,
 mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, clg@redhat.com, akrowiak@linux.ibm.com,
 jjherne@linux.ibm.com, sstabellini@kernel.org,
 anthony@xenproject.org, edgar.iglesias@gmail.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 joe.jin@oracle.com
Subject: Re: [PATCH 0/8] Force detach PCI devices for ACPI-based and PCIe
 native hot-unplug
Message-ID: <20260904072052-mutt-send-email-mst@kernel.org>
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
 <aoxY4Rxst2qAyn5z@redhat.com>
 <01ee4841-76d8-4749-a80e-eb945ab8799a@oracle.com>
 <20260903172835.0e253a25@imammedo>
 <20260903160401-mutt-send-email-mst@kernel.org>
 <20260904130709.6769caee@imammedo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904130709.6769caee@imammedo>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 04, 2026 at 01:07:09PM +0200, Igor Mammedov wrote:
> On Thu, 3 Sep 2026 16:17:20 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Sep 03, 2026 at 05:28:35PM +0200, Igor Mammedov wrote:
> > > On Wed, 26 Aug 2026 09:15:47 -0700
> > > Dongli Zhang <dongli.zhang@oracle.com> wrote:
> > >   
> > > > On Mon, Aug 24, 2026 7:44:49AM -0700, Daniel P. Berrangé wrote:  
> > > > > On Sun, Aug 23, 2026 at 06:13:30PM -0700, Dongli Zhang wrote:    
> > > > >> Hot-unplugging a PCI device can require cooperation from the guest. For
> > > > >> ACPI PCI hotplug, QEMU notifies the guest through ACPI and the guest
> > > > >> eventually writes the ACPI PCI eject register. For PCIe native hotplug,
> > > > >> QEMU notifies the guest through the PCIe hotplug mechanism and waits for
> > > > >> the slot unplug flow to complete. Only after that completion does QEMU
> > > > >> unrealize the device and emit DEVICE_DELETED.
> > > > >> 
> > > > >> This can leave a device stuck in the unplug pending state when the guest
> > > > >> does not cooperate. Examples include:
> > > > >> 
> > > > >> 1. The guest has panicked, or the relevant ACPI/PCI hotplug driver is
> > > > >> unavailable.
> > > > >> 
> > > > >> 2. The guest is stalled and cannot handle the hot-unplug event. For
> > > > >> example, stalling the Linux [irq/9-acpi] kernel thread can reproduce this
> > > > >> for ACPI-based hot-unplug.
> > > > >> 
> > > > >> 3. The device was attached to a slot that the guest cannot use. For
> > > > >> example, a pcie-root-port only supports slot 0. If a device is added to a
> > > > >> non-zero slot below a pcie-root-port, the guest may never discover the
> > > > >> device and therefore may never complete the unplug request.  
> > > 
> > > all of above is actually expected, no (functioning) driver => no hotplug/unplug.
> > > it's the guest problem. Once device it exposed to guest its life-cycle
> > > not longer owned by QEMU.
> > > 
> > > That's what one would see in real hw as well, you press eject button
> > > but it will not do anything if OS doesn't process it.
> > > also see comment at the end.
> > >   
> > > > >> 
> > > > >> The non-zero slot case has also been discussed in:
> > > > >> 
> > > > >> hw/pci: warn when PCIe device is plugged into non-zero slot of downstream port
> > > > >> https://gitlab.com/qemu-project/qemu/-/commit/    
> > > > > ca92eb5defcf9d1c2106341744a73a03cf26e824    
> > > > >> 
> > > > >> hw/pci: add comment to explain checking for available function 0 in pci hotplug
> > > > >> https://gitlab.com/qemu-project/qemu/-/    
> > > > > commit/67d045a0ef5b9c5f871c3a1d87325a8a42d2b9d5    
> > > > >> 
> > > > >> pci: don't skip function 0 occupancy verification for devfn auto assign
> > > > >> https://gitlab.com/qemu-project/qemu/-/commit/    
> > > > > e228d62b4af29bca698ec57efdceb46f392f5444    
> > > > >> 
> > > > >> For example, if root-port.1 is a pcie-root-port, the following command adds
> > > > >> a vhost-scsi-pci device to an invalid slot:
> > > > >> 
> > > > >> (qemu) device_add vhost-scsi-pci,id=scsi01,wwpn=naa.5001405324af0985,bus=root-port.1,addr=01.0
> > > > >> warning: PCI: slot 1 is not valid for vhost-scsi-pci, parent device only allows plugging into slot 0.    
> > > > > 
> > > > > This rather looks like it should be a fatal error, not a mere warning.
> > > > > 
> > > > > If I follow the commit ca92eb5def it links to https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> > > > > which states that this configuration is going to lead to a crash in
> > > > > QEMU on guest OS shutdown. IMHO that crash is sufficient to justify
> > > > > making this a fatal error.
> > > > > 
> > > > > If we actually wanted this to remain a warning, then that shutdown
> > > > > crash would need to be fixed.
> > > > >     
> > > > 
> > > > Thank you very much!
> > > > 
> > > > I see that the issue has been fixed. The ticket mentions the following.
> > > > 
> > > > "What I am observing is that it seems when the slot ID != 0, the guest OS seems
> > > > to ignore this and we never seem to hit ich9_pm_device_unplug_cb()."
> > > > 
> > > > Based on my experience and evaluation, ACPI-based hotplug is more likely to
> > > > encounter an issue where the guest VM does not respond to an unplug operation.  
> > > 
> > > I'm not sure it's a good idea to delete device when guest still thinks it's there
> > > (you can make guesses on QEMU side if it's in use, how useful those are is questionable).
> > > 
> > > as far as I know, ACPI hotplug has no notion of surprise removal (pls educate me if it's not the case),  
> > 
> > why would it not?
> > 
> > how do you think you can pull a laptop out of a dock?
> > I expect bus check + _STA and config space saying it is gone
> > will do exactly that.
> > 
> > 
> > Here's linux code:
> > static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> > {       
> >         struct acpiphp_slot *slot;
> > 
> >         /* Bail out if the bridge is going away. */
> >         if (bridge->is_going_away)
> >                 return;
> > 
> >         if (bridge->pci_dev)
> >                 pm_runtime_get_sync(&bridge->pci_dev->dev);
> >         
> >         list_for_each_entry(slot, &bridge->slots, node) {
> >                 struct pci_bus *bus = slot->bus;
> >                 struct pci_dev *dev, *tmp;
> > 
> >                 if (slot_no_hotplug(slot)) {
> >                         ; /* do nothing */
> >                 } else if (device_status_valid(get_slot_status(slot))) {
> >                         /* remove stale devices if any */
> >                         list_for_each_entry_safe_reverse(dev, tmp,
> >                                                          &bus->devices, bus_list)
> >                                 if (PCI_SLOT(dev->devfn) == slot->device)
> >                                         trim_stale_devices(dev);
> > 
> >                         /* configure all functions */
> >                         enable_slot(slot, true);
> >                 } else {
> >                         disable_slot(slot);
> >                 }
> >         }
> > 
> >         if (bridge->pci_dev)
> >                 pm_runtime_put(&bridge->pci_dev->dev);
> > }
> > 
> > 
> > so weirdly it wants bus check on a parent bus, otherwise it will
> > not trim devices?  probably a bug, but easy to work around.
> 
> Modern docks would use native pcie surprise removal path.
> 
> As for ACPI, my old laptop, had an unlock button => _LCK
> and that relied on OS processing ACPI events, not so surprise.
> 
> There might have been ACPI/hybrid docks that did surprise removal,
> but then one need to find one and model after that instead of 
> just blanket force removal. (likely out come would a doc device
> support only, not an arbitrary device removal)
> 
> (not the case described in this series, though. hence my request to clarify usecase)
> 
> from what I see in spec there is _RMV method that says that device
> supports surprise removal that can be used for devices that support it.
> However I would hesitate very much to blank apply it to every PCI device.
> (it's not even realistic to ask for proving safe tear down across various
> drivers and OSes/versions)
> 
> Rather than a knee jerk treatment of misconfig consequences,
> I'd rather see patches to prevent misconfig in the 1st place
> (subj to deprecation but doable).
> 
> As for the cases where OS mis-behaves (apcihp thread starvation,...),
> fixing guest to follow hotplug contract is a proper place to do it.
> 
> On QEMU side we have it covered as well. If unplug was not processed,
> mgmt is free to repeat action.


Sorry if I am unclear. I just meant that it looks like we
can support surprise removal with ACPI just by reporting
bus check events on the parent.


>  
> > > so I wouldn't do what you are proposing here at all, it's basically asking for disaster to happen.
> > > And all this is basically for dealing with abused qemu flexibility.
> > > 
> > > Please (re)formulate usecase and make it more clear as what is eludes me
> > > no matter how many times i've read this cover letter.
> > > 
> > > On positive note:
> > > 
> > > What you can try to implement is native PCI-E support for surprise removal.
> > > How hard that would be I don't know. And I would well expect if one deviates from
> > > real hw expectations/configs (such as not 0 slot/partial func removal),
> > > one would quickly stumble upon issues as  that's not what what vendors write/test
> > > drivers for.
> > > 
> > > Even if it's not likely to be used in practice (guest still might not support it),
> > > it may serve as test-bed for guest drivers.
> > >   
> > > > Thank you very much!
> > > > 
> > > > Dongli Zhang
> > > >   
> > 


