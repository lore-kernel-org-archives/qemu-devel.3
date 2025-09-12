Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40B3CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 18:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux8cM-0002HR-14; Fri, 12 Sep 2025 14:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux8cJ-0002Gr-PR
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 14:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux8cG-0007fQ-D0
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 14:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757702120;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znZhsJ4laQoT+tSC7lxKl5ciNrIyMx1U0a3qnP82zuY=;
 b=S4wzo9BMd9FbSupnYLSun88AGVS5T3apLJczpbufTuvLZTc4SS726fIzkZPc8v+xA1UdGK
 /r0TAYi5CWEzMxGJyLqbjbZbbVvFH/bo6SdGp6RBjRAhZ5aroeN69+NExPSqDHSQxH26L1
 oVfMAgOwrGFntgT1pqP7+XxtWSztQxY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-UC17OQTZPx-C0HsCZ-g5pA-1; Fri,
 12 Sep 2025 14:35:18 -0400
X-MC-Unique: UC17OQTZPx-C0HsCZ-g5pA-1
X-Mimecast-MFC-AGG-ID: UC17OQTZPx-C0HsCZ-g5pA_1757702118
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCD6A19107D8; Fri, 12 Sep 2025 18:35:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9964918004D8; Fri, 12 Sep 2025 18:35:14 +0000 (UTC)
Date: Fri, 12 Sep 2025 19:35:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 hreitz@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: Re: Some iotests are failing with -luks
Message-ID: <aMRn31T1Id5ceFjX@redhat.com>
References: <425ef990-85cb-4c02-bb41-2f88f939d147@redhat.com>
 <aMGijXg9XIpbbn-v@redhat.com>
 <58d82de4-25ac-48f5-ae80-181faf2bf8cf@redhat.com>
 <aMK8-4-xE0R7AnaK@redhat.com> <aMQs8pbZZPio0ikL@redhat.com>
 <aMQz383L7sjWiPV_@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMQz383L7sjWiPV_@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Sep 12, 2025 at 04:53:19PM +0200, Kevin Wolf wrote:
> Am 12.09.2025 um 16:23 hat Daniel P. Berrangé geschrieben:
> > On Thu, Sep 11, 2025 at 02:13:47PM +0200, Kevin Wolf wrote:
> > > Hm, so block_crypto_read_func() isn't prepared to be called in coroutine
> > > context, but block_crypto_co_amend_luks() still calls it from a
> > > coroutine. The indirection of going through QCrypto won't make it easier
> > > to fix this properly.
> > 
> > Historically block_crypto_read_func() didn't care/know whether it
> > was in a coroutine or not. Bisect tells me the regression was caused
> > by
> > 
> >   commit 1f051dcbdf2e4b6f518db731c84e304b2b9d15ce
> >   Author: Kevin Wolf <kwolf@redhat.com>
> >   Date:   Fri Oct 27 17:53:33 2023 +0200
> > 
> >     block: Protect bs->file with graph_lock
> > 
> > which added
> >  
> >     GLOBAL_STATE_CODE();
> >     GRAPH_RDLOCK_GUARD_MAINLOOP();
> > 
> > > It seems to me that while block_crypto_read/write_func are effectively
> > > no_coroutine_fn, qcrypto_block_amend_options() should really take
> > > function pointers that can be called from coroutines. It is called from
> > > both coroutine and non-coroutine code paths, so should the function
> > > pointers be coroutine_mixed_fn or do we want to change the callers?
> > >
> > > Either way, we should add the appropriate coroutine markers to the
> > > QCrypto interfaces to show the intention at least.
> > 
> > I'm unclear why QCrypto needs to know about coroutines at all ?
> > It just wants a function pointer that will send or recv a blob
> > of data. In the case of the block layer these functions end up
> > doing I/O via the block APIs, but QCrypto doesn't care about
> > this impl detail.
> 
> Does a case where it's not in the context of the block layer even exist?

Only the unit tests.

> The only callers of qcrypto_block_amend_options() are in block/crypto.c
> and block/qcow2.c. Apart from a test case, qcrypto_block_open() is the
> same.

Yep

> And even ignoring the block layer, doing synchronous I/O outside of
> coroutines is arguably a bug anyway because that's a blocking operation
> that stops the mainloop from making progress.

More generally, simply opening a LUKS volume can also impose a significant
delay because key validation is intentionally slow in wallclock time. So we
should get a minimum of 1 second delay, but if given an image created on a
significantly faster machine (or a malicious image), the larger 'iterations'
count could make us take way longer to open the image.

I guess that's a potential problem too ?

Amending the keys has the same performance penalty too as that involves
same intentionally slow crypto

> But if we don't want to fix it at the QCrypto level, that makes the
> function pointer implicitly coroutine_mixed_fn and the function needs to
> be rewritten to check qemu_in_coroutine() and probably take the graph
> lock internally before calling bdrv_co_pread() in the coroutine case,
> unless we can prove that all callers already hold it. Unfortunately,
> function pointers still defeat TSA, so this proof will have to be
> manual.

So IIUC the 'open' operation is not in a coroutine, while the
'amend' operation is in a coroutine ?

IIUC the coroutine_mixed_fn is expanding to a no-op. What is the
actual functional fix needed to stop the crash ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


