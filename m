Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2FEC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh4SG-0007Ss-6F; Tue, 07 Jul 2026 07:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh4SE-0007RU-2c
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh4SB-0000zS-O6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783425546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qrC+lzQzR/+m2DAw9XY2/brsL3SihjepOMjfKVBtkv0=;
 b=GIoGCE/F+XP7429nQQLlE6mFYZL2xsnuZH5yvgCT9YUU5n0U3+47rGT0+tYB4qHsm9TUDq
 gBuIxSQyfHEYRNCF2ltSU9XDiTy7CwtBaBWK6vs6VQrfdapX3Cj0tp03ahVlcrTkeQA9lZ
 XSNLFttl336D08bOLsuAl1JvGH+KMjI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-pIVgnFLYNmC_CO4eNdHP8w-1; Tue,
 07 Jul 2026 07:59:05 -0400
X-MC-Unique: pIVgnFLYNmC_CO4eNdHP8w-1
X-Mimecast-MFC-AGG-ID: pIVgnFLYNmC_CO4eNdHP8w_1783425543
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A48C91954AED; Tue,  7 Jul 2026 11:59:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF8B71955F76; Tue,  7 Jul 2026 11:59:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mjrosato@linux.ibm.com
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com, jdaley@linux.ibm.com,
 jjherne@linux.ibm.com, farman@linux.ibm.com, nrb@linux.ibm.com
Subject: Re: [PATCH v2 0/6] s390x: Fix intermittent errors with IPL from PCI
 devices on s390x
In-Reply-To: <20260630141917.673995-1-jrossi@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260630141917.673995-1-jrossi@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 07 Jul 2026 13:59:00 +0200
Message-ID: <878q7nj9iz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jun 30 2026, jrossi@linux.ibm.com wrote:

> From: Jared Rossi <jrossi@linux.ibm.com>
>
> When booting from a PCI device on s390x there may be intermittent failures
> caused by mismatched byte swaps.  Refactor the byte swapping to ensure that
> it is properly synchronized.
>
> Correct how the queue notification offset is calculated so that it may be
> used for multi-queue configurations in the future.
>
> Handle some switch cases that were not caught for PCI devices.
>
> Changes v1 -> v2:
>     - Split addition of missing break into its own patch
>     - Add PCI case to generic is_viritio_supported() wapper
>     - Switch the order of patches formerly 3 and 4
>     - Use virtio_is_supported() instead of checking cutype when writing IPLB
>         location to cover both CCW and PCI virtio devices
>
> Jared Rossi (3):
>   pc-bios/s390-ccw/virtio.c: Fix missing break for PCI notifications
>   pc-bios/s390-ccw: Verify virtio support when booting from virtio PCI
>     device on s390x
>   pc-bios/s390-ccw: write IPLB location for non-net virtio devices
>
> Zhuoying Cai (3):
>   pc-bios/s390-ccw: Refactor byte swapping
>   pc-bios/s390-ccw: Add per-queue notification offset for multi-queue
>     virtio configurations
>   s390x: Enable boot menu for virtio pci device
>
>  hw/s390x/ipl.c                |  1 +
>  pc-bios/s390-ccw/main.c       |  5 ++-
>  pc-bios/s390-ccw/virtio-pci.c | 57 ++++++++++++++++++++++++++---------
>  pc-bios/s390-ccw/virtio-pci.h |  5 ++-
>  pc-bios/s390-ccw/virtio.c     | 29 ++++++++++--------
>  pc-bios/s390-ccw/virtio.h     |  2 ++
>  6 files changed, 69 insertions(+), 30 deletions(-)
>

Thanks, applied.


