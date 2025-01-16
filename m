Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C4FC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 12:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYP8K-0007Uk-Rg; Thu, 16 Jan 2025 07:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYP8K-0007UX-2X
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:38:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYP8I-0002lq-E5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737031077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ZNXDp4+kPrgkLq825wuI/WjNyEnM5nsSMbMF5oFOgw=;
 b=E8WJgm7UQMiLhrzTm9v6oiMvrAVTKjCmbU2+2ZZdY6YnxZRWpCjR/6KYfFTGGCmu9/0uzd
 lXWV35RZFB0Tid1pilGrCUzZWi/y76vMq7EQiwAif0P8zJTwq1AVoPS4JsInDTGRYQk82e
 u32h5Epx9odRXv7kHQgx7M84r2U+4B4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-tkEJ8q9SOSGXHwRb6MNcwg-1; Thu,
 16 Jan 2025 07:37:55 -0500
X-MC-Unique: tkEJ8q9SOSGXHwRb6MNcwg-1
X-Mimecast-MFC-AGG-ID: tkEJ8q9SOSGXHwRb6MNcwg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C460319560AF; Thu, 16 Jan 2025 12:37:52 +0000 (UTC)
Received: from redhat.com (unknown [10.39.196.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5662C3003E7F; Thu, 16 Jan 2025 12:37:47 +0000 (UTC)
Date: Thu, 16 Jan 2025 13:37:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: tugy@chinatelecom.cn, eblake@redhat.com, armbru@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] support block encryption/decryption in parallel
Message-ID: <Z4j9mGpbbXyjKbmI@redhat.com>
References: <cover.1732789721.git.tugy@chinatelecom.cn>
 <Z1xZK9u8L_ydtnAJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1xZK9u8L_ydtnAJ@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 13.12.2024 um 16:56 hat Daniel P. Berrangé geschrieben:
> On Thu, Nov 28, 2024 at 06:51:20PM +0800, tugy@chinatelecom.cn wrote:
> > From: Guoyi Tu <tugy@chinatelecom.cn>
> > 
> > Currently, disk I/O encryption and decryption operations are performed sequentially
> > in the main thread or IOthread. When the number of I/O requests increases,
> > this becomes a performance bottleneck.
> > 
> > To address this issue, this patch use thread pool to perform I/O encryption
> > and decryption in parallel, improving overall efficiency.
> 
> We already have support for parallel encryption through use of IO threads
> since approximately this commit:
> 
>   commit af206c284e4c1b17cdfb0f17e898b288c0fc1751
>   Author: Stefan Hajnoczi <stefanha@redhat.com>
>   Date:   Mon May 27 11:58:50 2024 -0400
> 
>     block/crypto: create ciphers on demand
>     
>     Ciphers are pre-allocated by qcrypto_block_init_cipher() depending on
>     the given number of threads. The -device
>     virtio-blk-pci,iothread-vq-mapping= feature allows users to assign
>     multiple IOThreads to a virtio-blk device, but the association between
>     the virtio-blk device and the block driver happens after the block
>     driver is already open.
>     
>     When the number of threads given to qcrypto_block_init_cipher() is
>     smaller than the actual number of threads at runtime, the
>     block->n_free_ciphers > 0 assertion in qcrypto_block_pop_cipher() can
>     fail.
>     
>     Get rid of qcrypto_block_init_cipher() n_thread's argument and allocate
>     ciphers on demand.
> 
> 
> Say we have QEMU pinned to 4 host CPUs, and we've setup 4 IO threads
> for the disk, then encryption can max out 4 host CPUs worth of resource.

This is a lot of "if"s. Even just that it requires explicit
configuration and doesn't work out of the box would be a strong point
for me why having something that works by default (like a thread pool)
is worth it.

You're assuming that it's even possible to setup 4 iothreads which share
the load evenly. That's not a given at all. The only device that can
even make use of more than one iothread is virtio-blk. (And if we're
looking at all devices that exist in QEMU, most devices can't even make
use of a single iothread!) But if you do have a virtio-blk device, then
that setup means one iothread per queue. In a Linux guest, if all I/O
comes from a single CPU, then it will use the same queue and we'll have
three idle iothreads and one that is overloaded.

So in order to achieve a similar effect with iothreads, you must be
using virtio-blk, you must explicitly configure four iothreads and four
mappings of virtqueues to iothreads, and you must run a workload in the
guest that performs I/O from four different threads running on different
CPUs.

There are certainly good use cases for iothreads, but with this number
of preconditions, I don't think we can assume that they make it
unnecessary to parallelise things in other ways, too.

> How is this new proposed way to use a thread pool going to do better
> than that in an apples-to-apples comparison ? ie allow same number
> of host CPUs for both. The fundamental limit is still the AES performance
> of the host CPU(s) that you allow QEMU to execute work on. If the thread
> pool is allowed to use 4 host CPUs, it shouldn't be significantly different
> from allowing use of 4 host CPUs for I/O threads surely ?
> 
> Having multiple different ways to support parallel encryption is not
> ideal. If there's something I/O threads can't do optimally right
> now, is it practical to make them work better ?

The limitations inside the guest obviously can't be changed by QEMU.

We could in theory add iothread support to more devices, though if they
don't have a concept of multiple queues that could be processed by
different threads, it's pretty pointless (apart from working around
limitations in the backends like you're suggesting here).

And of course, the most interesting one would be solving the
out-of-the-box aspect. This is far from trivial, because the optimal
configuration really depends on your workload, and nothing on the host
can know automatically what will eventually run in the guest. So it will
be tough finding defaults that improve this case without also hurting
other cases.

Kevin


