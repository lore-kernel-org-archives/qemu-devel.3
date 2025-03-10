Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDEBC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 14:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treC8-0008Ri-5R; Mon, 10 Mar 2025 10:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1treC4-0008Pn-EG
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1treBy-000121-Cg
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741617196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5anBbwAaGrcyqVtJeSu1BcKSHNjBc/oGfaYy74AYfXA=;
 b=iYvGsSxZSeJakJVyXgNJn2UHUSN0+3bqh2Z/yi52vuHH0EJDsyXiXTbkHTYE4wGeiZ2Lsh
 dkzsnesmaGSJNGzJuAStKZgEhO5D70H5UxPHkjVBm68XDF80krgfcgToqAK4P/Upi+dSxF
 xW3RlTmVJtQY740j5oaNog7WlGMgpTU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-kddB4c9PN2GDt6huS8CQhg-1; Mon,
 10 Mar 2025 10:33:11 -0400
X-MC-Unique: kddB4c9PN2GDt6huS8CQhg-1
X-Mimecast-MFC-AGG-ID: kddB4c9PN2GDt6huS8CQhg_1741617189
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7579D180025E; Mon, 10 Mar 2025 14:33:09 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.222])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B3171956096; Mon, 10 Mar 2025 14:33:04 +0000 (UTC)
Date: Mon, 10 Mar 2025 15:33:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, pkrempa@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 11/12] virtio-scsi: add iothread-vq-mapping parameter
Message-ID: <Z874HlqTKgI5aiBW@redhat.com>
References: <20250213180043.713434-1-stefanha@redhat.com>
 <20250213180043.713434-12-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213180043.713434-12-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Allow virtio-scsi virtqueues to be assigned to different IOThreads. This
> makes it possible to take advantage of host multi-queue block layer
> scalability by assigning virtqueues that have affinity with vCPUs to
> different IOThreads that have affinity with host CPUs. The same feature
> was introduced for virtio-blk in the past:
> https://developers.redhat.com/articles/2024/09/05/scaling-virtio-blk-disk-io-iothread-virtqueue-mapping
> 
> Here are fio randread 4k iodepth=64 results from a 4 vCPU guest with an
> Intel P4800X SSD:
> iothreads IOPS
> ------------------------------
> 1         189576
> 2         312698
> 4         346744
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

As Peter already noted, the interface is a bit confusing in that it
considers the control and event queue just normal queues like any other
and you need to specify a mapping for them, too (even though you
probably don't care about them).

I wonder if it wouldn't be better to use the iothread-vq-mapping
property only for command queues and to have separate properties for the
event and control queue. I think this would be less surprising to users.

It would also allow you to use the round robin allocation for command
queues while using a different setting for the special queues - in
particular, the event queue is currently no_poll, which disables polling
for the whole AioContext, so you probably want to have it just anywhere
else, but not in the iothreads you use for command queues. This should
probably also be the default.

Kevin


