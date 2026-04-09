Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4007BEA3C23
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmww-0007P6-8w; Thu, 09 Apr 2026 06:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wAmwn-0007FA-9A
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wAmwj-0006Y2-OZ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775731750;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3x31sPYFGovHrBN4EFAaaFCFYdPWzfdaBZtVag+fQqg=;
 b=PGWJF1zFRw25SRpe1rR28BBfudAjE+z3Cbxhqh/mmPqy9ClMg9o9UoRXTiK7JVEWArZ2qG
 uFvP08fhnIlEaYemyodJ4jLDQ+rZoOaxOPWvh5lln/Cw3gFHy/sT5adCyrJw2O3b+oNBoU
 wkGHyHogUq1Ep/aTmMu9vsMWqfYv52Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-dPFG4SeIMbm88SyB1XkT7w-1; Thu,
 09 Apr 2026 06:49:06 -0400
X-MC-Unique: dPFG4SeIMbm88SyB1XkT7w-1
X-Mimecast-MFC-AGG-ID: dPFG4SeIMbm88SyB1XkT7w_1775731746
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A794E1800345; Thu,  9 Apr 2026 10:49:05 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 439A71800B7F; Thu,  9 Apr 2026 10:49:04 +0000 (UTC)
Date: Thu, 9 Apr 2026 11:49:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Jihe Wang <wangjihe.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 1/1] virtio-scsi: pass the same cdb_size to
 virtio_scsi_pop_req and virtio_scsi_handle_cmd_req_prepare
Message-ID: <adeEHeacVSfEKp-V@redhat.com>
References: <20260409103310.1884968-1-pbonzini@redhat.com>
 <20260409103310.1884968-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260409103310.1884968-2-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Apr 09, 2026 at 12:33:09PM +0200, Paolo Bonzini wrote:
> Ensure that there is no allocation/usage mismatch when requests
> are processed in virtio_scsi_handle_cmd_vq.  To do this,
> retrieve the value once and pass it to both functions.
> 
> For other calls to virtio_scsi_pop_req the extra size
> can be 0, because control and event requests fit
> entirely in VirtIOSCSIReq.
> 
> Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
> Tested-by: Jihe Wang <wangjihe.mail@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)

This issue is tagged CVE-2026-5763   - if possible can we get that
in the commit message before merging.

> 
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 774968d8c70..6c737680119 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -227,16 +227,16 @@ static int virtio_scsi_parse_req(VirtIOSCSIReq *req,
>      return 0;
>  }
>  
> -static VirtIOSCSIReq *virtio_scsi_pop_req(VirtIOSCSI *s, VirtQueue *vq, QemuMutex *vq_lock)
> +static VirtIOSCSIReq *virtio_scsi_pop_req(VirtIOSCSI *s, VirtQueue *vq, size_t extra_req_size,
> +                                          QemuMutex *vq_lock)
>  {
> -    VirtIOSCSICommon *vs = (VirtIOSCSICommon *)s;
>      VirtIOSCSIReq *req;
>  
>      if (vq_lock) {
>          qemu_mutex_lock(vq_lock);
>      }
>  
> -    req = virtqueue_pop(vq, sizeof(VirtIOSCSIReq) + vs->cdb_size);
> +    req = virtqueue_pop(vq, sizeof(VirtIOSCSIReq) + extra_req_size);
>  
>      if (vq_lock) {
>          qemu_mutex_unlock(vq_lock);
> @@ -682,7 +682,7 @@ static void virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq)
>  {
>      VirtIOSCSIReq *req;
>  
> -    while ((req = virtio_scsi_pop_req(s, vq, &s->ctrl_lock))) {
> +    while ((req = virtio_scsi_pop_req(s, vq, 0, &s->ctrl_lock))) {
>          virtio_scsi_handle_ctrl_req(s, req);
>      }
>  }
> @@ -850,13 +850,14 @@ static void virtio_scsi_fail_cmd_req(VirtIOSCSIReq *req)
>      virtio_scsi_complete_cmd_req(req);
>  }
>  
> -static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
> +static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req,
> +                                              size_t cdb_size)
>  {
>      VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
>      SCSIDevice *d;
>      int rc;
>  
> -    rc = virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
> +    rc = virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + cdb_size,
>                                 sizeof(VirtIOSCSICmdResp) + vs->sense_size);
>      if (rc < 0) {
>          if (rc == -ENOTSUP) {
> @@ -878,7 +879,7 @@ static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
>      }
>      req->sreq = scsi_req_new(d, req->req.cmd.tag,
>                               virtio_scsi_get_lun(req->req.cmd.lun),
> -                             req->req.cmd.cdb, vs->cdb_size, req);
> +                             req->req.cmd.cdb, cdb_size, req);
>  
>      if (req->sreq->cmd.mode != SCSI_XFER_NONE
>          && (req->sreq->cmd.mode != req->mode ||
> @@ -913,12 +914,15 @@ static void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
>      QTAILQ_HEAD(, VirtIOSCSIReq) reqs = QTAILQ_HEAD_INITIALIZER(reqs);
>  
>      do {
> +        VirtIOSCSICommon *vs = (VirtIOSCSICommon *)s;
> +        size_t cdb_size = qatomic_read(&vs->cdb_size);
> +
>          if (suppress_notifications) {
>              virtio_queue_set_notification(vq, 0);
>          }
>  
> -        while ((req = virtio_scsi_pop_req(s, vq, NULL))) {
> -            ret = virtio_scsi_handle_cmd_req_prepare(s, req);
> +        while ((req = virtio_scsi_pop_req(s, vq, cdb_size, NULL))) {
> +            ret = virtio_scsi_handle_cmd_req_prepare(s, req, cdb_size);
>              if (!ret) {
>                  QTAILQ_INSERT_TAIL(&reqs, req, next);
>              } else if (ret == -EINVAL) {
> @@ -989,7 +993,7 @@ static void virtio_scsi_set_config(VirtIODevice *vdev,
>      }
>  
>      vs->sense_size = virtio_ldl_p(vdev, &scsiconf->sense_size);
> -    vs->cdb_size = virtio_ldl_p(vdev, &scsiconf->cdb_size);
> +    qatomic_set(&vs->cdb_size, virtio_ldl_p(vdev, &scsiconf->cdb_size));
>  }
>  
>  static uint64_t virtio_scsi_get_features(VirtIODevice *vdev,
> @@ -1050,7 +1054,7 @@ static void virtio_scsi_push_event(VirtIOSCSI *s,
>          return;
>      }
>  
> -    req = virtio_scsi_pop_req(s, vs->event_vq, &s->event_lock);
> +    req = virtio_scsi_pop_req(s, vs->event_vq, 0, &s->event_lock);
>      WITH_QEMU_LOCK_GUARD(&s->event_lock) {
>          if (!req) {
>              s->events_dropped = true;
> -- 
> 2.53.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


