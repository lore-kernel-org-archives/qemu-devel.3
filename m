Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346ADC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 12:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYlsr-0003L9-9V; Fri, 17 Jan 2025 07:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYlso-0003KL-WC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:55:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYlsl-000232-VD
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737118525;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kCZM1+v0cAHLOMZ0CFAkltAxy2z1C2PAFejW0SsBxw=;
 b=C8GB99Mj5r0rHLkNehn8xtf8+wQH2YABW2lxdN5OvJbwnw/FB+mAgWzleexJQ2AZ3qM1eO
 uUVqzalptIQ+1pS5d7RmwqXR5sfyHL9CgPp84byN/UKPBVjd5XZ+Ne7wMpMNNRaDkk4RUK
 WwebmePGibB6YeRMeW9zEsg5w4p/ROw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-lUHh2QVBOESWEgsfQ8ILLg-1; Fri,
 17 Jan 2025 07:55:24 -0500
X-MC-Unique: lUHh2QVBOESWEgsfQ8ILLg-1
X-Mimecast-MFC-AGG-ID: lUHh2QVBOESWEgsfQ8ILLg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D235C19560B3; Fri, 17 Jan 2025 12:55:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1FBA19560BF; Fri, 17 Jan 2025 12:55:18 +0000 (UTC)
Date: Fri, 17 Jan 2025 12:55:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: tugy@chinatelecom.cn, eblake@redhat.com, armbru@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] support block encryption/decryption in parallel
Message-ID: <Z4pTMyvOTefCep87@redhat.com>
References: <cover.1732789721.git.tugy@chinatelecom.cn>
 <Z1xZK9u8L_ydtnAJ@redhat.com> <Z4j9mGpbbXyjKbmI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4j9mGpbbXyjKbmI@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 16, 2025 at 01:37:44PM +0100, Kevin Wolf wrote:
> Am 13.12.2024 um 16:56 hat Daniel P. Berrangé geschrieben:
> > On Thu, Nov 28, 2024 at 06:51:20PM +0800, tugy@chinatelecom.cn wrote:
> > > From: Guoyi Tu <tugy@chinatelecom.cn>
> > > 
> > > Currently, disk I/O encryption and decryption operations are performed sequentially
> > > in the main thread or IOthread. When the number of I/O requests increases,
> > > this becomes a performance bottleneck.
> > > 
> > > To address this issue, this patch use thread pool to perform I/O encryption
> > > and decryption in parallel, improving overall efficiency.
> > 
> > We already have support for parallel encryption through use of IO threads
> > since approximately this commit:
> > 
> >   commit af206c284e4c1b17cdfb0f17e898b288c0fc1751
> >   Author: Stefan Hajnoczi <stefanha@redhat.com>
> >   Date:   Mon May 27 11:58:50 2024 -0400
> > 
> >     block/crypto: create ciphers on demand
> >     
> >     Ciphers are pre-allocated by qcrypto_block_init_cipher() depending on
> >     the given number of threads. The -device
> >     virtio-blk-pci,iothread-vq-mapping= feature allows users to assign
> >     multiple IOThreads to a virtio-blk device, but the association between
> >     the virtio-blk device and the block driver happens after the block
> >     driver is already open.
> >     
> >     When the number of threads given to qcrypto_block_init_cipher() is
> >     smaller than the actual number of threads at runtime, the
> >     block->n_free_ciphers > 0 assertion in qcrypto_block_pop_cipher() can
> >     fail.
> >     
> >     Get rid of qcrypto_block_init_cipher() n_thread's argument and allocate
> >     ciphers on demand.
> > 
> > 
> > Say we have QEMU pinned to 4 host CPUs, and we've setup 4 IO threads
> > for the disk, then encryption can max out 4 host CPUs worth of resource.
> 
> This is a lot of "if"s. Even just that it requires explicit
> configuration and doesn't work out of the box would be a strong point
> for me why having something that works by default (like a thread pool)
> is worth it.
> 
> You're assuming that it's even possible to setup 4 iothreads which share
> the load evenly. That's not a given at all. The only device that can
> even make use of more than one iothread is virtio-blk. (And if we're
> looking at all devices that exist in QEMU, most devices can't even make
> use of a single iothread!) But if you do have a virtio-blk device, then
> that setup means one iothread per queue. In a Linux guest, if all I/O
> comes from a single CPU, then it will use the same queue and we'll have
> three idle iothreads and one that is overloaded.
> 
> So in order to achieve a similar effect with iothreads, you must be
> using virtio-blk, you must explicitly configure four iothreads and four
> mappings of virtqueues to iothreads, and you must run a workload in the
> guest that performs I/O from four different threads running on different
> CPUs.
> 
> There are certainly good use cases for iothreads, but with this number
> of preconditions, I don't think we can assume that they make it
> unnecessary to parallelise things in other ways, too.

Ok thanks for the background, that all makes sense as a justification.
Lets capture a summary of this in the commit message.

> > How is this new proposed way to use a thread pool going to do better
> > than that in an apples-to-apples comparison ? ie allow same number
> > of host CPUs for both. The fundamental limit is still the AES performance
> > of the host CPU(s) that you allow QEMU to execute work on. If the thread
> > pool is allowed to use 4 host CPUs, it shouldn't be significantly different
> > from allowing use of 4 host CPUs for I/O threads surely ?
> > 
> > Having multiple different ways to support parallel encryption is not
> > ideal. If there's something I/O threads can't do optimally right
> > now, is it practical to make them work better ?
> 
> The limitations inside the guest obviously can't be changed by QEMU.
> 
> We could in theory add iothread support to more devices, though if they
> don't have a concept of multiple queues that could be processed by
> different threads, it's pretty pointless (apart from working around
> limitations in the backends like you're suggesting here).
> 
> And of course, the most interesting one would be solving the
> out-of-the-box aspect. This is far from trivial, because the optimal
> configuration really depends on your workload, and nothing on the host
> can know automatically what will eventually run in the guest. So it will
> be tough finding defaults that improve this case without also hurting
> other cases.

Yes, understood, I was missing the impact of the guest usage model.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


