Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141E4CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN94-0006hX-Lj; Wed, 07 Oct 2026 04:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEI67-0001RO-A7
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEI5r-0001F6-22
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791342733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WW8g2nBbFktHDBbDuyRMokYgOWOXE7YL5nguzrGq128=;
 b=OzrH9jQ6n0oLqSSOqA6SxuPnHj/POIkY9iN18tshbu68Ap3Q6a3PoclpErWO76rs7ndQJ0
 BDBylfwuxjiO4BJl0q/Gi5X9wIse8gn+dN9yioVuhgZUkEbXyxs7FARqKq/Vy9EUKPNTy5
 e9jzztoV0aAuSJirBDmJimwdMxM2Rd4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-Kq7jhnNKOwOqMyDEPOyGHQ-1; Tue,
 06 Oct 2026 06:30:32 -0400
X-MC-Unique: Kq7jhnNKOwOqMyDEPOyGHQ-1
X-Mimecast-MFC-AGG-ID: Kq7jhnNKOwOqMyDEPOyGHQ_1791282631
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62CC6193E884; Tue,  6 Oct 2026 10:30:31 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58A901956042; Tue,  6 Oct 2026 10:30:28 +0000 (UTC)
Date: Tue, 6 Oct 2026 12:30:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v4 5/5] qcow2: repair a dirty image when it becomes
 writable
Message-ID: <asTNwqM03qYY8eUb@redhat.com>
References: <20260824133729.1141990-1-den@openvz.org>
 <20260824133729.1141990-6-den@openvz.org>
 <87ld9umth3.fsf@pond.sub.org>
 <f0b0023d-385c-4a47-8672-f06e01ea3211@virtuozzo.com>
 <8733w0j45n.fsf@pond.sub.org>
 <0880ebd0-d548-496a-9832-eb4e58c46594@virtuozzo.com>
 <87fqzzgc13.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fqzzgc13.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 27.08.2026 um 11:15 hat Markus Armbruster geschrieben:
> "Denis V. Lunev" <den@virtuozzo.com> writes:
> 
> > On 8/26/26 17:24, Markus Armbruster wrote:
> >> "Denis V. Lunev" <den@virtuozzo.com> writes:
> >>
> >>> On 8/25/26 11:37, Markus Armbruster wrote:
> >>>> "Denis V. Lunev" <den@openvz.org> writes:
> >>>>
> >>>>> From: Denis V. Lunev <den@openvz.org>
> >>>>>
> >>>>> A dirty image must be repaired before anything allocates a cluster in
> >>>>> it. qcow2_do_open() does that, but only for a node that is writable
> >>>>> from the start. A node opened read-only skips it, and nothing revisits
> >>>>> the question once that node becomes writable, which block-commit does
> >>>>> routinely: commit_active_start() and commit_start() reopen the base
> >>>>> read-write for the duration of the job.
> >>>>>
> >>>>> With lazy refcounts the on-disk refcount block then still accounts for
> >>>>> the metadata clusters only, so the allocator restarts at the front of
> >>>>> the image and hands out clusters that L2 entries point at. Two guest
> >>>>> offsets end up sharing one host cluster. Nothing fails, the corrupt bit
> >>>>> stays clear, and a clean close clears the dirty bit, so no later open
> >>>>> repairs the image either. The bit also stays set for the whole writable
> >>>>> session, so a node which is merely writable says nothing.
> >>>>>
> >>>>> Refusing the reopen instead is simpler and keeps it atomic, but it
> >>>>> leaves nowhere to go: the base belongs to a chain the VM has open, so
> >>>>> the qemu-img check -r such an error would ask for cannot take the write
> >>>>> lock it needs. The repair does the trick in most cases anyway.
> >>>>>
> >>>>> Do the repair in qcow2_reopen_commit_post(), the earliest point where
> >>>>> the node is writable. An inactive node is skipped: bdrv_activate() calls
> >>>>> qcow2_do_open() again through qcow2_co_invalidate_cache().
> >>>>>
> >>>>> commit_post cannot reject the reopen, so a failed repair takes the
> >>>>> driver away from the node instead, which is what stops writes from
> >>>>> aliasing live clusters. qcow2_signal_corruption() does that as well,
> >>>>> but it also sends BLOCK_IMAGE_CORRUPTED and sets the corrupt bit,
> >>>>> which qcow2_do_open() honours by refusing every later read-write open.
> >>>>> The image is dirty and unrepaired, not corrupt, and qemu-img check -r
> >>>>> still fixes it, so neither belongs here. Return the error and skip
> >>>>> the bitmaps.
> >>>>>
> >>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
> >>>>> Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >>>>> CC: Kevin Wolf <kwolf@redhat.com>
> >>>>> CC: Hanna Reitz <hreitz@redhat.com>
> >>>>> CC: Eric Blake <eblake@redhat.com>
> >>>>> CC: Markus Armbruster <armbru@redhat.com>
> >>>>> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >>>>> Cc: qemu-stable@nongnu.org
> >>>> [...]
> >>>>
> >>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >>>>> index 199efc1e00..940249a5e5 100644
> >>>>> --- a/qapi/block-core.json
> >>>>> +++ b/qapi/block-core.json
> >>>>> @@ -1852,6 +1852,9 @@
> >>>>   ##
> >>>>   # @change-backing-file:
> >>>>   #
> >>>>   # Change the backing file in the image file metadata.  This does not
> >>>>   # cause QEMU to reopen the image file to reparse the backing filename
> >>>>   # (it may, however, perform a reopen to change permissions from r/o ->
> >>>>>  # r/w -> r/o, if needed).  The new backing file string is written into
> >>>>>  # the image file metadata, and the QEMU internal strings are updated.
> >>>>>  #
> >>>>> +# A dirty qcow2 image is repaired during that reopen, which blocks
> >>>>> +# other requests and can fail the command.
> >>>>
> >>>> Pardon my ignorance: what makes a qcow2 image dirty?
> >>> usual obvious reasons are SIGKILL to qemu process (f.e. from OOM)
> >>> or node crash.
> >>
> >> So, you have to do some cleaning work before you can use it again, just
> >> like a dirty filesystem.  Correct?
> > Correct. QEMU allows right now to open dirty images in read-only
> > mode and it is OK to be used until we switch to RW. In this
> > case real write to metadata corrupts image.
> 
> Feels... adventurous?

Not really. This one is fairly harmless.

The dirty flag is generally set in the context of lazy refcounts, i.e.
the image will have refcounts that are inconsistent with the mappings.
The user explicitly asked for this and the mapping is authoritative in
this case. Repairing simply means updating the refcounts to match the
mapping again so that the next cluster allocation can work correctly.

If the image is accessed read-only, you obviously can't repair the image
because that would mean writing to the refcount blocks, but also you
really don't care about refcounts at all when you're only reading from
the image. Refcounts are only important for cluster allocation.

There is another flag QCOW2_INCOMPAT_CORRUPT that actually is a bit
adventurous to open even read-only because it means that something is
seriously wrong with the image. We still allow it, and I think the
reasoning for that was that it can be the difference between "all data
lost" and "okay, some parts of the image are broken, but we can at least
copy out those gigabytes of data that are still accessible".

Kevin


