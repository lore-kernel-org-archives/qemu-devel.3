Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E45CED624
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 11:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLKGO-0004GI-F4; Tue, 18 Nov 2025 06:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vLKGM-0004FW-Ax
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 06:52:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vLKGI-0000RZ-Qp
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 06:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763466761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s5fv3dUZKjQiYXMfdkaNYBm2pMHDgivpCnRn7HgCay0=;
 b=F6+qvM96c7x8H90Nc8vOzm8Ss3sEIYJJJvfrzn9TcCnq6exu6b7u5AXO2YLxPKqAx+CL4P
 iZOUlXyTCE1vT030qkfMQSiPoS8RTkXzZdbdALUeP7vhe0zh6RLGuHvOfkdTAADewHko3Z
 vemgMNp2PUiapTHfxl20k9FsZRLA34I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-6qXPkewGOjiV-AZMO2HF8g-1; Tue,
 18 Nov 2025 06:52:37 -0500
X-MC-Unique: 6qXPkewGOjiV-AZMO2HF8g-1
X-Mimecast-MFC-AGG-ID: 6qXPkewGOjiV-AZMO2HF8g_1763466756
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5FD9180034D; Tue, 18 Nov 2025 11:52:35 +0000 (UTC)
Received: from localhost (dhcp-192-224.str.redhat.com [10.33.192.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B43273003754; Tue, 18 Nov 2025 11:52:34 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2] hw/s390x: Fix a possible crash with passed-through
 virtio devices
In-Reply-To: <20251118093945.35062-1-thuth@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251118093945.35062-1-thuth@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 18 Nov 2025 12:52:32 +0100
Message-ID: <87ms4jr20v.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 18 2025, Thomas Huth <thuth@redhat.com> wrote:

> From: Thomas Huth <thuth@redhat.com>
>
> Consider the following nested setup: An L1 host uses some virtio device
> (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
> device through to the L3 guest. Since the L3 guest sees a virtio device,
> it might send virtio notifications to the QEMU in L2 for that device.
> But since the QEMU in L2 defined this device as vfio-ccw, the function
> handle_virtio_ccw_notify() cannot handle this and crashes: It calls
> virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDevice,
> but since "sch" belongs to a vfio-ccw device, that driver_data rather
> points to a CcwDevice instead. So as soon as QEMU tries to use some
> VirtioCcwDevice specific data from that device, we've lost.
>
> We must not take virtio notifications for such devices. Thus fix the
> issue by adding a check to the handle_virtio_ccw_notify() handler to
> refuse all devices that are not our own virtio devices.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Now with the required #include statement
>
>  hw/s390x/s390-hypercall.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
> index ac1b08b2cd5..38f1c6132e0 100644
> --- a/hw/s390x/s390-hypercall.c
> +++ b/hw/s390x/s390-hypercall.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "cpu.h"
>  #include "hw/s390x/s390-virtio-ccw.h"
>  #include "hw/s390x/s390-hypercall.h"
> @@ -42,6 +43,18 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
>      if (!sch || !css_subch_visible(sch)) {
>          return -EINVAL;
>      }
> +    if (sch->id.cu_type != VIRTIO_CCW_CU_TYPE) {
> +        /*
> +         * This might happen in nested setups: If the L1 host defined the
> +         * L2 guest with a virtio device (e.g. virtio-keyboard), and the
> +         * L2 guest passes this device through to the L3 guest, the L3 guest
> +         * might send virtio notifications to the QEMU in L2 for that device.
> +         * But since the QEMU in L2 defined this device as vfio-ccw, it's not
> +         * a VirtIODevice that we can handle here!
> +         */
> +        warn_report_once("Got virtio notification for unsupported device!");

Maybe also print which device ended up here?

> +        return -EINVAL;
> +    }
>  
>      vdev = virtio_ccw_get_vdev(sch);
>      if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, vq_idx)) {


