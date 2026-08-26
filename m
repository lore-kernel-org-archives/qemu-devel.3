Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8F7C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzFUs-0004nm-Gb; Wed, 26 Aug 2026 11:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wzFUp-0004iG-Ue
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 11:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wzFUk-0001jp-QR
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 11:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787757892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iCEBqb1Q6lZ7HIRD7IoqIXVMCqF175NNgwLvBlKANw=;
 b=fZTXY2xwKt0KJK8kyZD5ujaUV8cStRQIuFoWEiHIid1nkJKfup2aoCNUVX0zt47Yqi6JTm
 ZgDd8gpsVndWXNnnKyRd5TyJBqUl74ul6Co3Pr8FfY9J7F6ubtSpJJbEeB6yH6Wq+EXV/V
 nh01Vd/Y43ipLf82ni1ggLln8e736YU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-r43-PyzsMj6otcQ9QmLtfA-1; Wed,
 26 Aug 2026 11:24:44 -0400
X-MC-Unique: r43-PyzsMj6otcQ9QmLtfA-1
X-Mimecast-MFC-AGG-ID: r43-PyzsMj6otcQ9QmLtfA_1787757883
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ECC6187CCC1; Wed, 26 Aug 2026 15:24:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01AA618005B9; Wed, 26 Aug 2026 15:24:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6D1DD21E6920; Wed, 26 Aug 2026 17:24:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>,  qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  Andrey Drobyshev
 <andrey.drobyshev@virtuozzo.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Eric Blake <eblake@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v4 5/5] qcow2: repair a dirty image when it becomes
 writable
In-Reply-To: <f0b0023d-385c-4a47-8672-f06e01ea3211@virtuozzo.com> (Denis
 V. Lunev's message of "Wed, 26 Aug 2026 15:49:56 +0200")
References: <20260824133729.1141990-1-den@openvz.org>
 <20260824133729.1141990-6-den@openvz.org>
 <87ld9umth3.fsf@pond.sub.org>
 <f0b0023d-385c-4a47-8672-f06e01ea3211@virtuozzo.com>
Date: Wed, 26 Aug 2026 17:24:36 +0200
Message-ID: <8733w0j45n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"Denis V. Lunev" <den@virtuozzo.com> writes:

> On 8/25/26 11:37, Markus Armbruster wrote:
>> "Denis V. Lunev" <den@openvz.org> writes:
>>
>>> From: Denis V. Lunev <den@openvz.org>
>>>
>>> A dirty image must be repaired before anything allocates a cluster in
>>> it. qcow2_do_open() does that, but only for a node that is writable
>>> from the start. A node opened read-only skips it, and nothing revisits
>>> the question once that node becomes writable, which block-commit does
>>> routinely: commit_active_start() and commit_start() reopen the base
>>> read-write for the duration of the job.
>>>
>>> With lazy refcounts the on-disk refcount block then still accounts for
>>> the metadata clusters only, so the allocator restarts at the front of
>>> the image and hands out clusters that L2 entries point at. Two guest
>>> offsets end up sharing one host cluster. Nothing fails, the corrupt bit
>>> stays clear, and a clean close clears the dirty bit, so no later open
>>> repairs the image either. The bit also stays set for the whole writable
>>> session, so a node which is merely writable says nothing.
>>>
>>> Refusing the reopen instead is simpler and keeps it atomic, but it
>>> leaves nowhere to go: the base belongs to a chain the VM has open, so
>>> the qemu-img check -r such an error would ask for cannot take the write
>>> lock it needs. The repair does the trick in most cases anyway.
>>>
>>> Do the repair in qcow2_reopen_commit_post(), the earliest point where
>>> the node is writable. An inactive node is skipped: bdrv_activate() calls
>>> qcow2_do_open() again through qcow2_co_invalidate_cache().
>>>
>>> commit_post cannot reject the reopen, so a failed repair takes the
>>> driver away from the node instead, which is what stops writes from
>>> aliasing live clusters. qcow2_signal_corruption() does that as well,
>>> but it also sends BLOCK_IMAGE_CORRUPTED and sets the corrupt bit,
>>> which qcow2_do_open() honours by refusing every later read-write open.
>>> The image is dirty and unrepaired, not corrupt, and qemu-img check -r
>>> still fixes it, so neither belongs here. Return the error and skip
>>> the bitmaps.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Hanna Reitz <hreitz@redhat.com>
>>> CC: Eric Blake <eblake@redhat.com>
>>> CC: Markus Armbruster <armbru@redhat.com>
>>> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> Cc: qemu-stable@nongnu.org
>> [...]
>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 199efc1e00..940249a5e5 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -1852,6 +1852,9 @@
>>   ##
>>   # @change-backing-file:
>>   #
>>   # Change the backing file in the image file metadata.  This does not
>>   # cause QEMU to reopen the image file to reparse the backing filename
>>   # (it may, however, perform a reopen to change permissions from r/o ->
>>>  # r/w -> r/o, if needed).  The new backing file string is written into
>>>  # the image file metadata, and the QEMU internal strings are updated.
>>>  #
>>> +# A dirty qcow2 image is repaired during that reopen, which blocks
>>> +# other requests and can fail the command.
>>
>> Pardon my ignorance: what makes a qcow2 image dirty?
> usual obvious reasons are SIGKILL to qemu process (f.e. from OOM)
> or node crash.

So, you have to do some cleaning work before you can use it again, just
like a dirty filesystem.  Correct?

Back to change-backing-file.  It operates on an open image.  Cleaning
happens when that image is read-only and dirty.  Possible because you
can open dirty images read-only, and that doesn't clean them.  Correct?

>> Can you give me an idea of what other requests could be blocked?
> Before the patch reopen was smooth - we have just opened the
> file again. After this patch in a very unlikely corner case
> potentially lengthy procedure has been added - full image
> consistency check. Guest IO is stuck until the check will be
> completed.
>
> The case is unfortunately real for production.
>
>> Double-checking: "that reopen" is the one to change permissions,
>> i.e. the parenthesis above.  Correct?
> yes
>
>>> +#
>>>  # @image-node-name: The name of the block driver state node of the
>>>  #     image to modify.  The "device" argument is used to verify
>>>  #     "image-node-name" is in the chain described by "device".
>>> @@ -1891,6 +1894,9 @@
>>   ##
>>   # @block-commit:
>>   #
>>   # Live commit of data from overlay image nodes into backing nodes -
>>   # i.e., writes data between 'top' and 'base' into 'base'.
>>   #
>>   # If top =3D=3D base, that is an error.  If top has no overlays on top=
 of
>>   # it, or if it is in use by a writer, the job will not be completed by
>>   # itself.  The user needs to complete the job with the `job-complete`
>>   # command after getting the ready event.  (Since 2.0)
>>   #
>>   # If the base image is smaller than top, then the base image will be
>>   # resized to be the same size as top.  If top is smaller than the base
>>   # image, the base will not be truncated.  If you want the base image
>>>  # size to match the size of the smaller top, you can safely truncate
>>>  # it yourself once the commit operation successfully completes.
>>>  #
>>> +# The base is opened read-write.  A dirty qcow2 base is repaired

Reopend, I presume?

>>> +# first, which blocks other requests and can fail the command.
>>> +#
>>>  # @job-id: identifier for the newly-created block job.  If omitted,
>>>  #     the device name will be used.  (Since 2.7)
>>>  #

Like change-backing-file, block-commit operates on open images.  It
copies down into a base image.  If the base image is read-only, it is
reopened, and cleaning happens when it's dirty.  Correct?

Can it happen in any other way?

>>> @@ -2902,6 +2908,9 @@
>>   ##
>>   # @block-stream:
>>   #
>>   # Copy data from a backing file into a block device.
>>
>> [...]

Whereas block-commit copies down into a base image, block-stream copies
up from a base image.  If the image copied to is read-only, it is
reopened, and cleaning happens when it's dirty.  Correct?

Can it happen in any other way?

>>>  # On successful completion the image file is updated to drop the
>>>  # backing file and the `BLOCK_JOB_COMPLETED` event is emitted.
>>>  #
>>> +# The top image is opened read-write.  A dirty qcow2 image is repaired
>>> +# first, which blocks other requests and can fail the command.
>>> +#
>>>  # In case @device is a filter node, `block-stream` modifies the first
>>>  # non-filter overlay node below it to point to the new backing node
>>>  # instead of modifying @device itself.
>>> @@ -4989,6 +4998,16 @@
>>   ##
>>   # @blockdev-reopen:
>>   #
>>   # Reopens one or more block devices using the given set of options.
>>   # Any option not specified will be reset to its default value
>>   # regardless of its previous status.  If an option cannot be changed
>>   # or a particular driver does not support reopening then the command
>>   # will return an error.  All devices in the list are reopened in one
>>>  # transaction, so if one of them fails then the whole transaction is
>>>  # cancelled.

blockdev-reopen also operates on open images.  Cleaning happens when
reopening a dirty read-only image read/write.  Correct?

Can it happen in any other way?

>>>  #
>>> +# An error is also returned when a device cannot be used once it has
>>> +# been reopened.  Such a reopen is not undone, so an error does not
>>> +# always mean that nothing has changed.
>>
>> Could that be a problem?
> Error reply as itself is not a problem. The situation as a whole
> is a real pain in the ass.
>
> The problem is that such images exists in production and there
> is not way to handle this without downtime.
>
> Under this patch we are trying to fix things hard and this is
> correct thing to do - on RW image we are doing exactly the
> same thing. If automation is unable to fix - the guest denies
> starting.
>
> Here we report an error and render guest as unusable. This
> case is expected to be extremely rare but technically possible.
>
> This is a problem.

I'll come back to this as soon as I understand when exactly cleaning may
happen.

>>> +#                                        A node the driver gave up on
>>> +# serves nothing at all: it keeps its image open, makes
>>> +# `query-named-block-nodes` fail for as long as it is in the graph,
>>> +# and `blockdev-del` removes it only once nothing refers to it.
>>> +#
>>> +# Reopening a dirty qcow2 image read-write repairs it first, which
>>> +# blocks other requests and can fail the command.
>>> +#
>>>  # The command receives a list of block devices to reopen.  For each
>>>  # one of them, the top-level @node-name option (from
>>>  # `BlockdevOptions`) must be specified and is used to select the block
>>
>> These documentation updates suggest the patch affects commands
>> change-backing-file, block-commit, block-stream, and blockdev-reopen.
>> Is that correct?
>>
>> Would it make sense to list them in the commit message?
> That is simple thing. Will add :-)
>
> Thank you,
> =C2=A0 =C2=A0 Den

Thanks!


