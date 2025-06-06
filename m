Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAACC5B559
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTSg-0002tI-4w; Fri, 06 Jun 2025 05:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uNTSb-0002sq-5g
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uNTSZ-0002HC-DV
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749202437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9S20tswEVQlLdL1OHhMMFsyjybDIBMg7P1Dk3Znt4u8=;
 b=OgvzDmsZG4b7W5jGY9wYNCC5Z66qx1mFa9TDg2qTI3VsB84FtV8hVBER/rn1g5mqf+KsCx
 3hMu/Hv/KlG8jRjU/3Rvpg28CXshLi2mdt7LRMauvH7qdGbfiXBYX2lkNVuR5DghcJuoWj
 mPxqnta/EIJ+cVirmWSY+YrOHg6AtrU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-0Q0wP8_FNRu52FvTqKbNlA-1; Fri,
 06 Jun 2025 05:33:54 -0400
X-MC-Unique: 0Q0wP8_FNRu52FvTqKbNlA-1
X-Mimecast-MFC-AGG-ID: 0Q0wP8_FNRu52FvTqKbNlA_1749202433
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F100195608C; Fri,  6 Jun 2025 09:33:53 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.207])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE43330001BD; Fri,  6 Jun 2025 09:33:50 +0000 (UTC)
Date: Fri, 6 Jun 2025 11:33:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: avoid cost of -ftrivial-auto-var-init in hot path
Message-ID: <aEK1_Gh_-JRpihMs@redhat.com>
References: <20250604191843.399309-1-stefanha@redhat.com>
 <aEHn5XHU0-N67gWs@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEHn5XHU0-N67gWs@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 05.06.2025 um 20:54 hat Daniel P. Berrangé geschrieben:
> On Wed, Jun 04, 2025 at 03:18:43PM -0400, Stefan Hajnoczi wrote:
> > Since commit 7ff9ff039380 ("meson: mitigate against use of uninitialize
> > stack for exploits") the -ftrivial-auto-var-init=zero compiler option is
> > used to zero local variables. While this reduces security risks
> > associated with uninitialized stack data, it introduced a measurable
> > bottleneck in the virtqueue_split_pop() and virtqueue_packed_pop()
> > functions.
> > 
> > These virtqueue functions are in the hot path. They are called for each
> > element (request) that is popped from a VIRTIO device's virtqueue. Using
> > __attribute__((uninitialized)) on large stack variables in these
> > functions improves fio randread bs=4k iodepth=64 performance from 304k
> > to 332k IOPS (+9%).
> > 
> > This issue was found using perf-top(1). virtqueue_split_pop() was one of
> > the top CPU consumers and the "annotate" feature showed that the memory
> > zeroing instructions at the beginning of the functions were hot.
> 
> I'm concerned we have other issues lurking, so I built qemu
> with -Wframe-larger-than=8192 and looked at every source
> file location it reported. I've not done performance testing
> but I've found a decent number of locations that look like
> they are in the I/O path, so likely hot paths. It seems I
> was too naive when introducing -ftrivial-auto-var-init=zero
> wrt possible perf hits.
> 
> The results are as follow, and show some areas we should
> likely proactively marked with "QEMU_UNINITIALIZED' even
> without checking perf results:
> 
> 
> ../block/linux-aio.c:342:1: warning: the frame size of 8208 bytes is larger than 8192 bytes [-Wframe-larger-than=]
> 
>   - ioq_submit - struct iocb *iocbs[MAX_EVENTS];

This is certainly a hot path. We should probably try and measure it.

> ../hw/virtio/vhost-user.c:886:1: warning: the frame size of 21760 bytes is larger than 8192 bytes [-Wframe-larger-than=]
> 
>   - Several arrays of VHOST_USER_MAX_RAM_SLOTS (512)
>     Unclear if vhost_user_add_remove_regions is a hot path

Pretty sure it's not, you don't reconfigure your memory all the time.
(If you did, vhost-user performance would be destroyed anyway.)

> ../hw/virtio/virtio.c:1827:1: warning: the frame size of 24784 bytes is larger than 8192 bytes [-Wframe-larger-than=]
> ../hw/virtio/virtio.c:1827:1: warning: the frame size of 24800 bytes is larger than 8192 bytes [-Wframe-larger-than=]
> ../hw/virtio/virtio.c:1977:1: warning: the frame size of 24816 bytes is larger than 8192 bytes [-Wframe-larger-than=]
> 
>   - Several arrays of VIRTQUEUE_MAX_SIZE (1k)
>     Hot path - Stefan's patch fixes
> 
> 
> ../hw/virtio/virtio.c:2156:1: warning: the frame size of 49184 bytes is larger than 8192 bytes [-Wframe-larger-than=]
> ../hw/virtio/virtio.c:2193:1: warning: the frame size of 49184 bytes is larger than 8192 bytes [-Wframe-larger-than=]
> 
>   - Struct VirtQueueElementOld containing several arrays of VIRTQUEUE_MAX_SIZE (1k)
>     Unclear if qemu_{put,get}_virtqueue_element are a hot path

These are for (de)serialising state for migration, not a hot path.

Kevin


