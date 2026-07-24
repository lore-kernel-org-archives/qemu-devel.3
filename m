Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3B8C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnGdS-0001K3-MF; Fri, 24 Jul 2026 10:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnGdG-0001Iu-MI
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 10:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnGdC-0005A1-PJ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 10:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784902325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J9J4MHzM57N752ks+CwctURJGdX1Fla09GttYCJG9Xs=;
 b=YKZ2KXlrxZFEgh+uOjxfQnGpOu5eK2KMCgsw557csazTAI7zz5/c7aW1KPrJfVoHpzKay9
 qN7NDmpvZROV5aPKGt81BDqiNDDQEtmiVy6yg+RCcyCYmEknnagth5M1X4WerxJxEduDqv
 pW1AEXQ6/Jse/xXA5rMHrt91Fxd0IGU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-xgSEA0krPV6d4nUpXPMkUg-1; Fri,
 24 Jul 2026 10:12:02 -0400
X-MC-Unique: xgSEA0krPV6d4nUpXPMkUg-1
X-Mimecast-MFC-AGG-ID: xgSEA0krPV6d4nUpXPMkUg_1784902321
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF6191944B01; Fri, 24 Jul 2026 14:12:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EE2A1800986; Fri, 24 Jul 2026 14:11:56 +0000 (UTC)
Date: Fri, 24 Jul 2026 16:11:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 2/3] virtio: do not crash QEMU on migration errors
Message-ID: <amNyqrHGW3yAjl2j@redhat.com>
References: <3777347521a12252e228e4a6243c75250bf76626.1784898250.git.mst@redhat.com>
 <a0afc9ea82d68f3447c9f58d89c9b46fa074d6c3.1784898250.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0afc9ea82d68f3447c9f58d89c9b46fa074d6c3.1784898250.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 24.07.2026 um 15:04 hat Michael S. Tsirkin geschrieben:
> Currently virtio-blk, virtio-serial and virtio-scsi all crash on invalid
> migration streams because qemu_get_virtqueue_element has no way to
> detect and report mapping failures.
> 
> Not nice.
> 
> Let's propagate mapping errors through qemu_get_virtqueue_element and
> fail migration instead.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3888
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/virtio/virtio.h  |  2 +-
>  hw/block/virtio-blk.c       |  4 ++++
>  hw/char/virtio-serial-bus.c |  4 ++++
>  hw/scsi/virtio-scsi.c       |  6 +++++
>  hw/virtio/virtio.c          | 48 +++++++++++++++++++++++++++----------
>  5 files changed, 50 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c99cb19d88..27c5fe3a6b 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -320,7 +320,7 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int num);
>  void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
>                      unsigned int len, unsigned int idx);
>  
> -void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem);
> +bool virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem);
>  void *virtqueue_pop(VirtQueue *vq, size_t sz);
>  unsigned int virtqueue_drop_all(VirtQueue *vq);
>  void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz);
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 6b92066aff..cb6a276a82 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1384,6 +1384,10 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
>          }
>  
>          req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
> +        if (!req) {
> +            error_report("Failed to restore virtio-blk request");
> +            return -EINVAL;
> +        }
>          virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);

Instead of having error_report() calls deep down in device code, could
we just pass an Error **errp VirtioDeviceClass.load/save() and print the
error in virtio_load/save()?

And the next step would then be to change virtio_load/save() to take an
Error **errp and to switch virtio_vmstate_info from .get/.put to
.load/.save that actually allow returning an error.

>          WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index c1973f0248..0f56321cc7 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -763,6 +763,10 @@ static int fetch_active_ports_list(QEMUFile *f,
>  
>              port->elem =
>                  qemu_get_virtqueue_element(vdev, f, sizeof(VirtQueueElement));
> +            if (!port->elem) {
> +                error_report("Failed to restore virtio-serial element");
> +                return -EINVAL;
> +            }
>  
>              /*
>               *  Port was throttled on source machine.  Let's
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 53c3c88460..8675afc6e1 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -18,6 +18,7 @@
>  #include "standard-headers/linux/virtio_ids.h"
>  #include "hw/virtio/virtio-scsi.h"
>  #include "migration/qemu-file-types.h"
> +#include "migration/qemu-file.h"
>  #include "qemu/defer-call.h"
>  #include "qemu/error-report.h"
>  #include "qemu/iov.h"
> @@ -273,6 +274,11 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
>      assert(n < vs->conf.num_queues);
>      req = qemu_get_virtqueue_element(vdev, f,
>                                       sizeof(VirtIOSCSIReq) + vs->cdb_size);
> +    if (!req) {
> +        error_report("Failed to restore virtio-scsi request");
> +        qemu_file_set_error(f, -EINVAL);

Is this to break the loop in get_scsi_requests() instead of silently
ignoring the error? Wouldn't it be better to actually use the return
value from this function there (and to pass errors up instead of always
returning 0)?

> +        return NULL;
> +    }
>      virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
>  
>      if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,

More context:

    if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
                              sizeof(VirtIOSCSICmdResp) + vs->sense_size) < 0) {
        error_report("invalid SCSI request migration data");
        exit(1);
    }

I think if you want to avoid crashes, you'll also want to avoid exit(1)
calls? Though maybe that's a separate patch because it's unrelated to
qemu_get_virtqueue_element().

Kevin


