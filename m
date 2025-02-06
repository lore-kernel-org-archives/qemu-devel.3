Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AEEC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 08:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfx9f-0000gB-O1; Thu, 06 Feb 2025 03:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tfx9d-0000f8-Me
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 03:22:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tfx9b-0001RZ-I4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 03:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738830150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hSOjLuiAqpLnr8aX/VaXpIcTXR3Yg6HvNHNQMKBovI=;
 b=XOXodYDCXQ/EajgsYgJkkAr+o0wst+O8b0qbQeTJmne5zEJgSPd6ELSabMy94HuO6KDUhY
 C3iDRH2qGrgeKbIQM4DaMHD9SsdZcf9FI5x7c6LuU2xM5vMveeZ0FtnjvHwSeU62AxYHfH
 RDnXYyX5sMLvBc/sqA5mAnuI2P/PYU0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-6jGghw-EPa6f1dli9skKIQ-1; Thu,
 06 Feb 2025 03:22:26 -0500
X-MC-Unique: 6jGghw-EPa6f1dli9skKIQ-1
X-Mimecast-MFC-AGG-ID: 6jGghw-EPa6f1dli9skKIQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23454180087F
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2025 08:22:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.57])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51BBC19560A3; Thu,  6 Feb 2025 08:22:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A24131800396; Thu, 06 Feb 2025 09:22:21 +0100 (CET)
Date: Thu, 6 Feb 2025 09:22:21 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 8/9] vfio: Check compatibility of CPU and IOMMU
 address space width
Message-ID: <l6mgyhwaexnvndcigvwxen2hidq5hlxlf7ed6fgvr3gs77n5mp@ezwgvkthdley>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-9-clg@redhat.com>
 <20250130115800.60b7cbe6.alex.williamson@redhat.com>
 <9cfaf81e-d8cc-4ec0-9c56-956b716891e7@redhat.com>
 <24w7fzx5rf2zdnowtjmuvwuirydryc366xumjf3isgzrhei2ty@ymyjyzdbggr2>
 <20250131151829.6461eeb0.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250131151829.6461eeb0.alex.williamson@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

  Hi,

> > Is there some simple way to figure what the iommu width is (inside the
> > guest)?
> 
> If the guest firmware is exposing a DMAR table (VT-d), there's a host
> address width field in that table.  Otherwise there are capability
> registers on the DRHD units that could be queried.  AMD-Vi seems to
> have similar information in the IVinfo table linked from the IVRS
> table.  Maybe an iterative solution is ok, starting with the most
> common IOMMU types and assuming others are 64-bits wide until proven
> otherwise.

Hmm.  The guest firmware simply exposes the tables it gets from qemu
(without parsing it).  Also the acpi tables are loaded after the
firmware created the address space layout, because qemu adjusts them
according to the programming done by the firmware (set pci bus ranges
according to bridge windows etc).

So checking ACPI tables for that information doesn't look very
attractive.  The firmware would have to load the tables twice (once
early to parse DMAR, once late for the final tables).

Going for the capability registers might be possible.  Can the hardware
be probed for safely?  Has AMD capability registers too?

Third option would be using another channel to communicate the
information from qemu to firmware, where using 'guest-phys-bits' would
be one candidate.

> Right, as Cédric notes that's sort of what happens here, but my concern
> was that the we're kind of incorrectly linking the cpu address width to
> the platform address width, which isn't specifically the requirement.

There is a separate 'guest-phys-bits' property for that reason.  The
phys-bits of the CPU are not changed.

take care,
  Gerd


