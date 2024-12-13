Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B02E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM820-0005fl-41; Fri, 13 Dec 2024 10:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tM81y-0005fU-AT
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:56:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tM81w-0004WA-1A
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734105398;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jpzfpgkG7JO9kR30UAL5w5B/MnB8SJ2z/Cmi9kymqAA=;
 b=L+OMUwM1jVeO2Gk0KG+l6yNOMhmKyGYzt1p3nNgJ6OL5TR/dGfGWW20R20k/gL622y8cr9
 FDKJA+PhFjV43NzETQbRlRLa8C4hiyeBca3hlLhLTvPG+FQuNkIY4+l2TJdq2fbJ4g0KOk
 5j4xL1LAj1RFgC7X4NnWZmfHT3oAjRo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-rVbpo1sbPrOXqkuE8P4dZg-1; Fri,
 13 Dec 2024 10:56:37 -0500
X-MC-Unique: rVbpo1sbPrOXqkuE8P4dZg-1
X-Mimecast-MFC-AGG-ID: rVbpo1sbPrOXqkuE8P4dZg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA28919560AF; Fri, 13 Dec 2024 15:56:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AE541956052; Fri, 13 Dec 2024 15:56:30 +0000 (UTC)
Date: Fri, 13 Dec 2024 15:56:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: tugy@chinatelecom.cn
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] support block encryption/decryption in parallel
Message-ID: <Z1xZK9u8L_ydtnAJ@redhat.com>
References: <cover.1732789721.git.tugy@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732789721.git.tugy@chinatelecom.cn>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 28, 2024 at 06:51:20PM +0800, tugy@chinatelecom.cn wrote:
> From: Guoyi Tu <tugy@chinatelecom.cn>
> 
> Currently, disk I/O encryption and decryption operations are performed sequentially
> in the main thread or IOthread. When the number of I/O requests increases,
> this becomes a performance bottleneck.
> 
> To address this issue, this patch use thread pool to perform I/O encryption
> and decryption in parallel, improving overall efficiency.

We already have support for parallel encryption through use of IO threads
since approximately this commit:

  commit af206c284e4c1b17cdfb0f17e898b288c0fc1751
  Author: Stefan Hajnoczi <stefanha@redhat.com>
  Date:   Mon May 27 11:58:50 2024 -0400

    block/crypto: create ciphers on demand
    
    Ciphers are pre-allocated by qcrypto_block_init_cipher() depending on
    the given number of threads. The -device
    virtio-blk-pci,iothread-vq-mapping= feature allows users to assign
    multiple IOThreads to a virtio-blk device, but the association between
    the virtio-blk device and the block driver happens after the block
    driver is already open.
    
    When the number of threads given to qcrypto_block_init_cipher() is
    smaller than the actual number of threads at runtime, the
    block->n_free_ciphers > 0 assertion in qcrypto_block_pop_cipher() can
    fail.
    
    Get rid of qcrypto_block_init_cipher() n_thread's argument and allocate
    ciphers on demand.


Say we have QEMU pinned to 4 host CPUs, and we've setup 4 IO threads
for the disk, then encryption can max out 4 host CPUs worth of resource.

How is this new proposed way to use a thread pool going to do better
than that in an apples-to-apples comparison ? ie allow same number
of host CPUs for both. The fundamental limit is still the AES performance
of the host CPU(s) that you allow QEMU to execute work on. If the thread
pool is allowed to use 4 host CPUs, it shouldn't be significantly different
from allowing use of 4 host CPUs for I/O threads surely ?

Having multiple different ways to support parallel encryption is not
ideal. If there's something I/O threads can't do optimally right
now, is it practical to make them work better ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


