Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DA8C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1OnV-0004m6-Lu; Tue, 01 Sep 2026 09:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1OnR-0004h0-OU
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1OnO-0006qf-0F
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788270301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fTtHrz1ZOvF8OXqosUvZDp0LO7c88jUZIChV6ftdiSk=;
 b=fg+Gzzay6OgMtzp5UtdIZ9PBxqkG7uZ1UpfvZjB8W+Wy8fsH1dfZwfRRc+uYSo/ETeOt8Z
 Gx6yEjnKW/nHxNqqSS65V5l8/FASgXDe12DMPnusR9NxML3P6eOMi+EgDNWAWsI6u3WRJV
 VAnUa4altDDssP3CWZc72h5fkm0TNhQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-imCeH3FaMr-Q7xAKJPav5g-1; Tue, 01 Sept 2026 09:44:59 -0400
X-MC-Unique: imCeH3FaMr-Q7xAKJPav5g-1
X-Mimecast-MFC-AGG-ID: imCeH3FaMr-Q7xAKJPav5g_1788270298
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c213d5fb55aso485514966b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788270298; x=1788875098; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fTtHrz1ZOvF8OXqosUvZDp0LO7c88jUZIChV6ftdiSk=;
 b=NWfVJ0M/x3ff0OnoTyfNByeV7wd2ZCjcTzHFXck6bXYnIS6pvN4cXkfoZGb/DvzXj7
 2TV1KrOFD9eQp/TY7CzCCUG0SDInMP1ZXf6CKUjny6EjxC/jUbUrXCz8J8/2D6omSacu
 AFneXWZQUlsqxEw3bhy8roL3Uw3fTEp3wrcBnTEuXCulbasFtpHl5+4SvFNpKRqHsm70
 IXpmJb2SkBBM3nZOHOM28WpguNchk25kq8bFbegmtgaDzUtSvuF+b/zCy9l0MgLtlyKn
 gx7rE6y/k4e8tRL8wMZzqu1CHwX1aC6aCVxh79qdm6WdplZF+SYmBbQoXdQ2OxBwcTnN
 tNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788270298; x=1788875098;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fTtHrz1ZOvF8OXqosUvZDp0LO7c88jUZIChV6ftdiSk=;
 b=aF8gs/m7o0MmCJnv/Fj1xJk6c5a+e5be8Rf6GwNx3t5vcM5/ZggPmQEbUgfKal5IpF
 s+L8bsnFMStLQjizb0yywpHcIKcvt0TFmZG2Z1sIEz1mhCJJbXqfoSq/6hBTwne5Hkn3
 0LKH6gAj15kG4BQLqBk0ivhToyA/stdBS9SO7SrktP7I/rTG5ziXKSdNVGAwBczH3jbi
 9fYB219mRwGstcj5YNy2GWE/kP2WdFkQIomQKdCb58WRMXZwBjTDY1Psaey6xo1cnUig
 cXQxk7P5ijBd+RPIr1E9M+gPmje04V8sNDMYkrSxhs2cG7ecs6obK+SwKKQ51KAj5iVq
 DBuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFwTZJTMCdFr+F9mNk106jVEoZ8dZZY6loRW8ZoHSYFA/EQ0t35BLvyD6diKd4xVJe4HD5af+qeQxe@nongnu.org
X-Gm-Message-State: AFuF++mYZ41lJtOqSAUd2CZCjYPLu5LubTuYmaDmYcDJRFzObWo63lT+
 s4TOsIGT8RgA2j4LUkoA4ytERQ59HJndwPpXdlYRbcpFY7ZRDwnSOTDgw5BmmIxNfZrEFX2xM5g
 jlR5nJ1e2jdJAwRV9mXnftE2oePqJHzQjFZ4MsbPWm7L1+P6xm2iRo3pq
X-Gm-Gg: AR+sD125idycxxsRytO8y4yGQ4rydMxPrZtIwDPF17VPceWgEOrlkCAbOhHxTwlJQGC
 u243g5tP6V/B3sDG4Z2swr1a8XGBlwJI4WOW9wNlyWHw7Li6+kLcpspTm5xtb4dHpPY+iXL6DwB
 U89sNTw7Xy0Eti0AUAoGu6flK+Y/sg0iHIBoYyY3EZ5YHmw3S5DJKJYCGjP8oR1MIqmDXiUL3g/
 MauTYn2wrum/4MdBwRint7EslVh11uAiwZXYV89/ZOnZKvDSIl/vA1yx6Hgw3OFw/f5cXx/uEEr
 nvHfCjXZZoDxaUypqdSh4qAhEnN+Aik0gzgdYAZIxPei2O1b7tmLYzZa4VPWtLcowtdr1ND6v9O
 dAwbaaNFf5Y1r3xY7TJMjIj8=
X-Received: by 2002:a17:907:3ccc:b0:c25:2cbe:edeb with SMTP id
 a640c23a62f3a-c255741a624mr2360394866b.21.1788270297689; 
 Tue, 01 Sep 2026 06:44:57 -0700 (PDT)
X-Received: by 2002:a17:907:3ccc:b0:c25:2cbe:edeb with SMTP id
 a640c23a62f3a-c255741a624mr2360387566b.21.1788270297000; 
 Tue, 01 Sep 2026 06:44:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f1b2049sm611249566b.36.2026.09.01.06.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:44:56 -0700 (PDT)
Date: Tue, 1 Sep 2026 09:44:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Paziyski <danielpaziyski@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-stable@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 "open list:nvme" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/3] pcie_sriov: register user created virtual function
 before realizing it
Message-ID: <20260901094419-mutt-send-email-mst@kernel.org>
References: <20260805124519.30054-1-danielpaziyski@gmail.com>
 <20260805124519.30054-4-danielpaziyski@gmail.com>
 <20260901071543-mutt-send-email-mst@kernel.org>
 <CANukVxvZMPp_1ZkZzmrE1pSAryW7DWpBOOWV5=QUmnQf3LH48Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANukVxvZMPp_1ZkZzmrE1pSAryW7DWpBOOWV5=QUmnQf3LH48Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 01, 2026 at 03:24:08PM +0200, Daniel Paziyski wrote:
> On Tue, 1 Sept 2026 at 13:19, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Aug 05, 2026 at 02:45:18PM +0200, Daniel Paziyski wrote:
> >> There are two ways of creating virtual functions: by using the sriov-pf device
> >> parameter (this way, creating a user created VF and binding it to a PF), or
> >> by using a device specific parameter, where the device manually creates a given
> >> amount of VFs.
> >>
> >> When a PCI device is realized, the device specific realize function is called
> >> first, and then the pcie_sriov_register_device function is called, which checks
> >> whether the device that has been created is a user created VF, and if it is the
> >> case and the device allows this kind of VFs, it inserts it into a hashmap, with
> >> the key being the ID of the PF, and the items being arrays of VFs.
> >>
> >> User created VFs are instantiated independently, and later, when the PF calls
> >> pcie_sriov_pf_init_from_user_created_vfs, it discovers its VFs from the hashmap
> >> mentioned previously, and sets up in their PCIDevice.ex.sriov_pf structure
> >> the pointer to the PF. This means that, during realization, VFs have no access
> >> to the PF.
> >>
> >> Device created VFs are instantiated during or after PF realization using the
> >> pcie_sriov_pf_init function, which sets up for the VFs the pointer to the PF
> >> before their realization, so when they're realized, they can access the PF
> >> with no issues.
> >>
> >> The problem here is that pcie_sriov_register_device is called after the
> >> realization, and not before. This means that when a user created VF is created
> >> for a device which does not support user created VFs, but supports device
> >> created VFs, the realize function will notice that a VF is being created, and
> >> may try to access the PF, causing a null pointer dereference fault.
> >>
> >> Fix this by placing the user created VF check and registering before the
> >> realization. This way, incorrectly created user created VFs will be noticed,
> >> and device creation will be aborted.
> >>
> >> Additionally, remove from the pcie_sriov_register_device function the top
> >> check. It seems that this check is done to error out if the PF failed for some
> >> reason to initialize its list of user created VFs. However, in such situations,
> >> the pcie_sriov_pf_init_from_user_created_vfs function will error during
> >> realization, and it will be caught before the check is done at all. Moreover,
> >> since now pcie_sriov_register_device is called before realization, the check
> >> will always fail for PFs with user created VFs, because the list will be
> >> populated during realization.
> >>
> >> The rest of the function though, correctly errors out if a user created VF
> >> is created for an unsupported device type, if a VF is created for a non-PCIe
> >> device, or if the PF is already instantiated, with now the advantage being
> >> that the check is done before the VF instantiation.
> >>
> >> When instantiating a user created VF for a NVME controller:
> >>
> >> Command line:
> >>
> >>     qemu-system-x86_64 -device nvme-subsys,id=subsys0 \
> >>     -device nvme,id=vctrl0,sriov-pf=ctrl0,subsys=subsys0 \
> >>     -device nvme,id=ctrl0,subsys=subsys0,serial=s
> >>
> >> ASAN splat:
> >>
> >> ../hw/nvme/ctrl.c:9613:28: runtime error: member access within null pointer of type 'struct NvmeCtrl'
> >> AddressSanitizer:DEADLYSIGNAL
> >> =================================================================
> >> ==91050==ERROR: AddressSanitizer: SEGV on unknown address 0x000000001cf0 (pc 0x7f79a8573dcd bp 0x7ffd622c1bc0 sp 0x7ffd622c1b68 T0)
> >> ==91050==The signal is caused by a READ memory access.
> >>     #0 0x7f79a8573dcd  (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
> >>     #1 0x5644c6c0266e in nvme_realize ../hw/nvme/ctrl.c:9613
> >>     #2 0x5644c6c67213 in pci_qdev_realize ../hw/pci/pci.c:2316
> >>     #3 0x5644c7a2cfc1 in device_set_realized ../hw/core/qdev.c:514
> >>     #4 0x5644c7a4f767 in property_set_bool ../qom/object.c:2484
> >>     #5 0x5644c7a48d0b in object_property_set ../qom/object.c:1548
> >>     #6 0x5644c7a568a5 in object_property_set_qobject ../qom/qom-qobject.c:28
> >>     #7 0x5644c7a49385 in object_property_set_bool ../qom/object.c:1618
> >>     #8 0x5644c7a2aeb0 in qdev_realize ../hw/core/qdev.c:277
> >>     #9 0x5644c735f29f in qdev_device_add_from_qdict ../system/qdev-monitor.c:740
> >>     #10 0x5644c735f3ab in qdev_device_add ../system/qdev-monitor.c:758
> >>     #11 0x5644c72b1901 in device_init_func ../system/vl.c:1217
> >>     #12 0x5644c829d4a3 in qemu_opts_foreach ../util/qemu-option.c:1148
> >>     #13 0x5644c72bc33e in qemu_create_cli_devices ../system/vl.c:2762
> >>     #14 0x5644c72bcaa1 in qmp_x_exit_preconfig ../system/vl.c:2822
> >>     #15 0x5644c72c3241 in qemu_init ../system/vl.c:3862
> >>     #16 0x5644c801abf8 in main ../system/main.c:71
> >>     #17 0x7f79a8427780  (/usr/lib/libc.so.6+0x27780) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
> >>     #18 0x7f79a84278b8 in __libc_start_main (/usr/lib/libc.so.6+0x278b8) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
> >>     #19 0x5644c5f0a1f4 in _start (BuildId: 8483f952216d9e345c3744300d0aefa38feb50d7)
> >>
> >> ==91050==Register values:
> >> rax = 0x00007e49988640f0  rbx = 0x00007e49988640f0  rcx = 0x00000fc9b3104828  rdx = 0x0000000000000058
> >> rdi = 0x00007e49988640f0  rsi = 0x0000000000001cf0  rbp = 0x00007ffd622c1bc0  rsp = 0x00007ffd622c1b68
> >>  r8 = 0x00000fc9b3104829   r9 = 0x00000fc9b3104828  r10 = 0x00000fc9b310481e  r11 = 0x00000fc9b310481e
> >> r12 = 0x0000000000001cf0  r13 = 0x00000f6f32e78578  r14 = 0x00000000ffffffff  r15 = 0x00007ffd622c1c10
> >> AddressSanitizer can not provide additional info.
> >> SUMMARY: AddressSanitizer: SEGV (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
> >> ==91050==ABORTING
> >>
> >> Cc: qemu-stable@nongnu.org
> >> Fixes: 19e55471d4e8 ("pcie_sriov: Allow user to create SR-IOV device")
> >> Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
> >> ---
> >>  hw/pci/pci.c        | 11 ++++++-----
> >>  hw/pci/pcie_sriov.c |  6 ------
> >>  2 files changed, 6 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index d3191609e2..a5b4482bb6 100644
> >> --- a/hw/pci/pci.c
> >> +++ b/hw/pci/pci.c
> >> @@ -2312,20 +2312,21 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> >>      if (pci_dev == NULL)
> >>          return;
> >>
> >> +    if (!pcie_sriov_register_device(pci_dev, errp)) {
> >> +        do_pci_unregister_device(pci_dev);
> >
> >
> > This skips acpi-index rollback which pci_qdev_unrealize currently does.
> > Needs generic PCI cleanup.
> 
> I see. pci_qdev_unrealize unregisters the device's acpi-index after calling
> do_pci_unregister_device. What do you think if I moved the snippet for
> unregistering the acpi-index to a new function, and then call it in
> do_pci_unregister_device?
> 
> Moreover, this would fix the fact that in do_pci_register_device and outside of
> it the acpi-index is not released in case of failure, since this new function
> could then be called if necessary, if do_pci_unregister_device is not called.
> 
> Additionally, while I'm at it, why don't I move pcie_sriov_unregister_device to
> do_pci_unregister_device? This way, I avoid calling it explicitly in
> pci_qdev_realize, which is necessary now because user created VFs are registered
> before realization.
> 
> Regards,
> Daniel

Hard to say like that pls send a patch.

> >
> >
> >> +        return;
> >> +    }
> >> +
> >>      if (pc->realize) {
> >>          pc->realize(pci_dev, &local_err);
> >>          if (local_err) {
> >>              error_propagate(errp, local_err);
> >> +            pcie_sriov_unregister_device(pci_dev);
> >>              do_pci_unregister_device(pci_dev);
> >>              return;
> >>          }
> >>      }
> >>
> >> -    if (!pcie_sriov_register_device(pci_dev, errp)) {
> >> -        pci_qdev_unrealize(DEVICE(pci_dev));
> >> -        return;
> >> -    }
> >> -
> >>      /*
> >>       * A PCIe Downstream Port that do not have ARI Forwarding enabled must
> >>       * associate only Device 0 with the device attached to the bus
> >> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> >> index c41ac95bee..69930c7b8c 100644
> >> --- a/hw/pci/pcie_sriov.c
> >> +++ b/hw/pci/pcie_sriov.c
> >> @@ -357,12 +357,6 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
> >>
> >>  bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
> >>  {
> >> -    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
> >> -        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
> >> -        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
> >> -        return false;
> >> -    }
> >> -
> >>      if (dev->sriov_pf) {
> >>          PCIDevice *pci_pf;
> >>          GPtrArray *pf;
> >> --
> >> 2.55.0
> >


