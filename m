Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A34DD41C3B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 14:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vThZP-0003Qd-Pk; Thu, 11 Dec 2025 09:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vThZK-0003Pq-8w
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:22:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vThZH-0005So-NI
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765462973;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wqktzObMh7Trno6bkc5Ju13tDlw1yNDsZDVDD4PbEgs=;
 b=Mt0wpzr7XNbVk+l4+pZ/DtCmHZLiZZQIj8QKj/msXQgNw6aANxQl76IfLa18fhZiMCNzMp
 vWZPID/GKOUWJKodLOas3FNLD1LZyxM1hU5wfFfy/OzjiYQybH+Hzq72nYhHy5j06yrOMM
 Ox0Ck47Yz+D21tE+JAje4R8onKEd85g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-eey7AafDOymWag0nITNDsg-1; Thu,
 11 Dec 2025 09:22:51 -0500
X-MC-Unique: eey7AafDOymWag0nITNDsg-1
X-Mimecast-MFC-AGG-ID: eey7AafDOymWag0nITNDsg_1765462971
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BC29195605A; Thu, 11 Dec 2025 14:22:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 894901800352; Thu, 11 Dec 2025 14:22:46 +0000 (UTC)
Date: Thu, 11 Dec 2025 14:22:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Aaron Lo <aaronlo0929@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] virtio-balloon: only create statsq when
 VIRTIO_BALLOON_F_STATS_VQ exists
Message-ID: <aTrTsbhiyKjspttD@redhat.com>
References: <20251211-balloon-check-stats-feature-v1-1-ae8951957b80@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251211-balloon-check-stats-feature-v1-1-ae8951957b80@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Dec 11, 2025 at 03:05:49AM -0600, Aaron Lo wrote:
> The VirtIO specification (section 5.5.2) states that the stats queue
> is only present if the VIRTIO_BALLOON_F_STATS_VQ feature is
> negotiated. QEMU currently creates the statsq unconditionally.
> 
> This patch guards statsq creation so it occurs only when the
> feature bit is enabled.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3188
> 
> Signed-off-by: Aaron Lo <aaronlo0929@gmail.com>
> ---
>  hw/virtio/virtio-balloon.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 02cdd807d7..f5d4d5f60c 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -892,7 +892,10 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>  
>      s->ivq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>      s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
> -    s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
> +
> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_STATS_VQ)) {
> +        s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
> +    }

This seems like a change that is liable to break live migration
state compatibility, as IIUC the queues are encoded in the state ?

>  
>      if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>          s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
> @@ -932,7 +935,9 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
>  
>      virtio_delete_queue(s->ivq);
>      virtio_delete_queue(s->dvq);
> -    virtio_delete_queue(s->svq);
> +    if (s->svq) {
> +        virtio_delete_queue(s->svq);
> +    }
>      if (s->free_page_vq) {
>          virtio_delete_queue(s->free_page_vq);
>      }
> 
> ---
> base-commit: 9c23f2a7b0b45277693a14074b1aaa827eecdb92
> change-id: 20251211-balloon-check-stats-feature-7ea658e038ce
> 
> Best regards,
> -- 
> Aaron Lo <aaronlo0929@gmail.com>
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


