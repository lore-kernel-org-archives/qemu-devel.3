Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240C7C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 14:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treLy-0007aD-Cd; Mon, 10 Mar 2025 10:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1treLv-0007Zs-FE
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1treLt-0002aZ-SR
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741617812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9xpYdSQihRH0xQKvIi9AG6NxQN2+U004GdmDUlZeqck=;
 b=AAoDDUuseojbV5eBLBHb3rVBIBXVHroCCiGOmpZNRtpXHpjNfqO/+DOr5dgkKC+TNbdDHf
 bpBlOiabZ3MWZq89RqCOFcIEaQ3wH05S9ALKttSObYjFIzUJ3rntHPu8j4dcHuHuuWFXi9
 ZCLq5bqzk7xiQ8BTIT+gWSLkg9Ynyc8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-W9DqMk0tPla-oVfGJIWrEw-1; Mon,
 10 Mar 2025 10:43:29 -0400
X-MC-Unique: W9DqMk0tPla-oVfGJIWrEw-1
X-Mimecast-MFC-AGG-ID: W9DqMk0tPla-oVfGJIWrEw_1741617808
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 671D119560B0; Mon, 10 Mar 2025 14:43:28 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.222])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D0051828A8C; Mon, 10 Mar 2025 14:43:24 +0000 (UTC)
Date: Mon, 10 Mar 2025 15:43:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, pkrempa@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 12/12] virtio-scsi: handle ctrl virtqueue in main loop
Message-ID: <Z876iZY4URLY9Kbu@redhat.com>
References: <20250213180043.713434-1-stefanha@redhat.com>
 <20250213180043.713434-13-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213180043.713434-13-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 13.02.2025 um 19:00 hat Stefan Hajnoczi geschrieben:
> Previously the ctrl virtqueue was handled in the AioContext where SCSI
> requests are processed. When IOThread Virtqueue Mapping was added things
> become more complicated because SCSI requests could run in other
> AioContexts.
> 
> Simplify by handling the ctrl virtqueue in the main loop where reset
> operations can be performed. Note that BHs are still used canceling SCSI
> requests in their AioContexts but at least the mean loop activity
> doesn't need BHs anymore.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
> index 6bb368c8a5..2d37fa6712 100644
> --- a/hw/scsi/virtio-scsi-dataplane.c
> +++ b/hw/scsi/virtio-scsi-dataplane.c
> @@ -73,6 +73,12 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
>              s->vq_aio_context[i] = ctx;
>          }
>      }
> +
> +    /*
> +     * Always handle the ctrl virtqueue in the main loop thread where device
> +     * resets can be performed.
> +     */
> +    s->vq_aio_context[0] = qemu_get_aio_context();
>  }

Hmm... So now it's mandatory to provide a mapping for the control queue
if you're using iothread virtqueue mappings, but it's always ignored?

Looks like another reason why we should change the interface to have
separate properties for the command queues and the event queue (and no
property for the control queue if we want it to be fixed).

In fact, maybe just tie the event queue to the main loop, too?

Kevin


