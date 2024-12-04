Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F25E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvaE-00038J-SA; Wed, 04 Dec 2024 15:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIvaB-00037y-BE
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIva9-0007HN-Dw
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733342562;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MqS9h5s+zp5zuL1NTqg0gGxPzUgvRpsF12tDpRldwDU=;
 b=C6gWAzywrofLGRmdl86GDR67hiV5Cv8s7Xe51dOKZ5Ieu0LJoTXF77rhd6+exxTV9xOqIG
 gYqqY4F3jyAoHehu5340MlExbx2WFBaDN6Lj63Kj96SztzJJ9lt70gu6L+RkWnobTlSwA6
 YsIs56JxOxlfeQFateZTMfgw70WmcNQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-hYjsmpZVOJuhyE0JbLVSiw-1; Wed,
 04 Dec 2024 15:02:38 -0500
X-MC-Unique: hYjsmpZVOJuhyE0JbLVSiw-1
X-Mimecast-MFC-AGG-ID: hYjsmpZVOJuhyE0JbLVSiw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8989B195FCDD; Wed,  4 Dec 2024 20:02:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0220E3000197; Wed,  4 Dec 2024 20:02:34 +0000 (UTC)
Date: Wed, 4 Dec 2024 20:02:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] migration: Kick postcopy threads on cancel
Message-ID: <Z1C1V25wydbBlsMb@redhat.com>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-3-farosas@suse.de> <Z1Ch8HpiKMoqILDM@x1n>
 <87r06ni84z.fsf@suse.de> <Z1Cv4JM8IbYeiDpR@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1Cv4JM8IbYeiDpR@x1n>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Dec 04, 2024 at 02:39:12PM -0500, Peter Xu wrote:
> On Wed, Dec 04, 2024 at 04:02:36PM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Mon, Dec 02, 2024 at 07:01:33PM -0300, Fabiano Rosas wrote:
> > >> Make sure postcopy threads are released when migrate_cancel is
> > >> issued. Kick the postcopy_pause semaphore and have the fault thread
> > >> read 'fault_thread_quit' when joining.
> > >> 
> > >> While here fix the comment mentioning userfault_event_fd.
> > >> 
> > >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > >
> > > I remember when working on postcopy, I thought about failing migrate-cancel
> > > for postcopy in general, rejecting such request.  And when working on the
> > > recover feature, there's no concern on having it being cancelled, because
> > > the user really shouldn't do that..
> > >
> > > The problem is migrate-cancel means crashing the VM on both sides when QEMU
> > > already goes into postcopy stage.
> > 
> > Well, that's the sillyness of having a cancel command, you can never
> > know what "cancel" means. The "documentation" says: "Cancel the current
> > executing migration process", it doesn't mention anything about the
> > consequences of such action.
> 
> We definitely need cancel.  It was always used in precopy, and people use
> it a lot!

Not a fair benchmark though.

People use cancel alot because 'precopy' cannot complete in a
predictable amount of time, any time guesstime can suddenly
get much worse if the guest dirties memory differently. So
people give up and cancel it after waiting ridiculously long
and never being sure if it is nearing the finish.

Once a migrate has been switched to 'postcopy' phase, however,
we have what should be a highly predictable completion time,
directly related to the amount of untransferred pages. That
time should not get worse. The amount of time spent in the
'postcopy' phase will depend on how long you let the migrate
run in 'precopy' before flipping to 'postcopy'

IOW, I think there's a reasonable case to be made that NOT
having the ability to cancel while in 'postcopy' phase would
be mostly acceptable. You give up the ability to cancel for
a while, in exchange for a clearly determined completion
time. 

> > > If the user wants to crash the VM anyway, an easier way to do is killing on
> > > both sides.
> > 
> > I don't think this is fair. We expose a "cancel" command, we better do
> > some cancelling or instead reject the command appropriately, not expect
> > the user to "know better".
> 
> That's exactly why we should fail it with a proper error message, IMHO.
> Because the user may not really understand the impact of postcopy.

Yep, I think users/apps expect "cancel" to be safe. So if it can't be
safe at certain times, we should reject it in those time windows.

> > > If the user wished to cancel, we should tell them "postcopy cannot be
> > > cancelled, until complete".  That's probably the major reason why people
> > > think postcopy is dangerous to use..
> > 
> > We could certainly add that restriction, I don't see a problem with
> > it. That said, what is the actual use case for migrate_cancel? And how
> > does that compare with yank? I feel like we've been kind of relying on
> > nobody using those commands really.
> 
> We had "cancel" first, then "yank".  I didn't remember who merged yank,
> especially for migration, and why it was ever needed.

yank is for the case where the network connections are completely stuck,
causing QEMU to potentially get stalled in I/O operations until a TCP
timeout is reached. yank force unwedges any stuck I/O by aggresively
closing the connections. It is most useful in the non-migration use
cases though.

> Migration users should have stick with "cancel" rather than "yank" - qmp
> "yank" would "FAIL" the migration instead of showing CANCELLED, definitely
> should avoid.  I am not aware of anybody that uses "yank" for migration at
> all.
> 
> So yeah, both commands are slightly duplicated, and if we want to throw
> one, it needs to be yank, not cancel.  I'm fine keeping both..

I would say the difference is like a graceful shutdown vs pulling the
power plug in a bare metal machine

'cancel' is intended to be graceful. It should leave you with a functional
QEMU (or refuse to run if unsafe).

'yank' is intended to be forceful, letting you get out of bad situations
that would otherwise require you to kill the entire QEMU process, but
still with possible associated risk data loss to the QEMU backends.

They have overlap, but are none the less different.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


