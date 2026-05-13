Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F51CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 09:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN5o4-0000YA-DP; Wed, 13 May 2026 05:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN5nz-0000Xc-0e
 for qemu-devel@nongnu.org; Wed, 13 May 2026 05:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN5nt-0007Fx-57
 for qemu-devel@nongnu.org; Wed, 13 May 2026 05:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778664175;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type; bh=n51xYA9hDj9aZQYKWQbCGAxsaB3VHUvMOt8zjEcDYcw=;
 b=Ha4NNdRCWm/S8ZWih5kC4p+Ase2gUl396nI9ATiPaypap2CcsZ8ul4c2WchlAhcQ0xphBH
 2XiEP4b/+jsl1zM8bpVk2UJWpVYsDMlwUetcWFO4+Di9dj4U1W/gPw6i1+D95LpDUzCMXu
 bfGy9M1J+JvLtraI/GgzUI7x1dH0XfY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-ZeaG033rNFmnJzrOVVfGxQ-1; Wed,
 13 May 2026 05:22:53 -0400
X-MC-Unique: ZeaG033rNFmnJzrOVVfGxQ-1
X-Mimecast-MFC-AGG-ID: ZeaG033rNFmnJzrOVVfGxQ_1778664172
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8472218005BB; Wed, 13 May 2026 09:22:52 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F54118004A3; Wed, 13 May 2026 09:22:50 +0000 (UTC)
Date: Wed, 13 May 2026 10:22:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org
Subject: Limit USB 1.0 (UHCI/OCHI) and 2.0 (EHCI) to non-virt use cases
Message-ID: <agRC56rkfb4z6zSO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QEMU has implemented four generic USB controllers

 * UHCI - USB 1.0 only
 * OHCI - USB 1.0 only
 * EHCI - USB 2.0 only (must have UHCI companions for 1.0 compat)
 * XHCI - All of USB 3.0, 2.0, 1.0 in one controller

We have two variants of XHCI, the generic one (hcd-xhci.c) and the
NEC one (hcd-xhci-nec.c)

Historically for security reports we have considered all of them in
scope of virtualization, since initially with KVM the XHCI impl was
not present in QEMU & thus KVM guests used UHCI/EHCI with USB tablet
for a period of time

All of the USB subsystem is currently orphaned, so we have no dedicated
maintainer available to deal with bug reports (volunteers welcome to
step up here...)


While the need for USB is reduced given the availability of virtio-input,
not all guests have drivers out of the box, so at least USB tablet is
still interesting for KVM use cases with some modern OS.

It is also not that unusual for people to need USB host device assignment
with KVM virt to make various pieces of specialized hardware (security
tokens, smart cards, custom dongles, etc) available directly to guests.

IOW, we can't entirely exclude USB from virtualization use cases IMHO.


In terms of virtualization, XHCI is the only impl that is sensible to
use. UHCI/OHCI/EHCI all impose an unreasonable CPU load on any guest
usage of USB.  XHCI should be supported by any guest OS  approx the
last 15 years, which should be sufficient for virtualization use cases
with OS that are not EOL by their vendor.


Thus to reduce our maint burden around security bug handling, it is
proposed henceforth to classify UHCI, OHCI and EHCI under the non-
virtualization use case and thus be excluded from security bug triage
processes. No CVEs would be assigned, bugs would be reported publically
in gitlab:

  https://www.qemu.org/docs/master/system/security.html#non-virtualization-use-case


The XHCI controller (specifically the hcd-xhci.c variant) would remain
as our only option for the virtualization use case, with security process
applied to bugs & eligible for CVE assignment:

  https://www.qemu.org/docs/master/system/security.html#virtualization-use-case


The other NEC XHCI variant (hcd-xhci-nec.c) would also be treated as
non-virtualization use case, since it needlessly duplicates hcd-xhci.c
impl and thus is only interesting for emulation of this specific HW
variant.


NB, there are no functional limitations / restrictions from this policy,
it is largely just a semantic exercise. From a management application
POV, however, it would strongly suggest that guests be configured with
XHCI as the default choice if the user asks for USB, and in turn also
imply that '-usb' not be used since that is UHCI/OHCI typically. CC'ing
libvirt, though it is really a matter for virt-install/virt-manager/
openstack/kubevirt etc above libvirt to pick their defaults for USB
controllers.


None the less XHCI would still be in search of a maintainer to step
forward and handle ongoing development and maint work.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


