Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E84C3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 14:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1nrX-00045r-HS; Mon, 07 Apr 2025 10:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u1nrV-00045R-3A
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 10:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u1nrT-00035U-6j
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 10:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744037645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lEOcZacHnNQ89sYmDkvJKZF7vzDjss6LlsJpaAG0ZWs=;
 b=MAv1LyHPX/NofpZBkGFxusI0ISXuU9MEntkK9FcqCKR2E/Inr9fh4R/0ykSk/JRCgTqLLG
 642G9YHGZZgEtbzBrh1q3AoStT/45b+8ODpEjQMfNxZwfBlsj6om/lSZHUg0IlEQQTLrP9
 zw+zHSL0HW5rQPQz2t2IOD0cRe2+Rnw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-_czdHv5XPr6J0p2PFrTenA-1; Mon,
 07 Apr 2025 10:54:04 -0400
X-MC-Unique: _czdHv5XPr6J0p2PFrTenA-1
X-Mimecast-MFC-AGG-ID: _czdHv5XPr6J0p2PFrTenA_1744037642
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 285ED195608B; Mon,  7 Apr 2025 14:54:02 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B91CC19541A6; Mon,  7 Apr 2025 14:54:00 +0000 (UTC)
Date: Mon, 7 Apr 2025 09:53:58 -0500
From: Eric Blake <eblake@redhat.com>
To: prashant patil <pmgpatil@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Query on the dirty bitmap
Message-ID: <6s2grkptds54jewlroehfvfpk4aci5ks7lkm4h4tfnvayxzi4l@2tilhng3srix>
References: <CAFvsdYns1yO6Wsm8VKP_khbTPm09Kf5KDmBpeMSrjboyccK4Aw@mail.gmail.com>
 <d2276vugq6wureu6zzrwci5sdtg3b6gllqskjv7hfvuulsmhyn@anl3d5htudty>
 <CAFvsdYk0J7ybdu+dL+w70Po1bGypLopBkixPp-ZzmTA8MdTr0w@mail.gmail.com>
 <pf24mn3twfrc2kfaszovdyj5rhh6d4r4ixawh2dyx5dbi5no3j@ryk4lzslrnye>
 <CAFvsdYmJFDuQzk6Byu+f4HcTO1EStin3vEMC+twh8P3T2ve6qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFvsdYmJFDuQzk6Byu+f4HcTO1EStin3vEMC+twh8P3T2ve6qA@mail.gmail.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 07, 2025 at 02:46:17PM +0530, prashant patil wrote:
> Thanks Eric.

[top-posting makes conversations harder to follow, so on this list we
typically reply inline]

> I have a few questions about the bitmap content shown by 'qemu-img map'.
> From below sample bitmap data:
> 1. Why only some of the extents have start and offset values? And why are
> they the same values?
> 2. What does the start value indicate? Is it logical offset or physical
> offset of data into qcow2?

Normally (when there is no x-dirty-bitmap in play), 'start' denotes
the logical offset being reported on (you'd expect a map to list every
logical offset; so the start of entry N+1 should be the sum of start +
length of entry N), while 'offset' is where that extent begins in the
underlying file.  For a raw source, offset and start will be
identical; for other sources, like qcow2, start is obviously logical,
while offset is physical.  Entries without 'offset' are places where
the logical contents are compressed, synthesized, or otherwise have no
1:1 correspondence to an offset in the physical file.  'present'
indicates whether the data is synthesized or not; 'offset' is going to
be absent if 'present' is false; although it can also be absent even
when 'present' is true such as in the case of compression.

When it comes to exposing a qcow2 file over NBD, you generally want to
have:

qemu-nbd using '-f qcow2' => raw view => qemu-img using '-f raw'

to expose only the logical contents over the wire.  It is also
possible to flip the responsibility:

qemu-nbd using '-f raw' => qcow2 view => qemu-img using '-f qcow2'

to expose the bare-metal qcow2 contents over the wire, but that gets
less testing, in part because if you make the image writable, it tends
to cause problems if the client writing to the qcow2 layer needs to
allocate (since NBD does not have a resize command).  Having the
server open the file as qcow2 and only serving raw contents means the
server can resize transparently.  What's more, block status commands
over NBD only work when the server is aware of the qcow2 nature of the
file it is serving (if you expose qcow2 bits over the wire, the server
treats the entire file as allocated, and there is is no dirty bitmap
context for the client to read over NBD).

Therefore, 'start' and 'offset' are going to be identical if you are
using qemu-img map to read bitmaps from a server, since bitmaps can
only be read when the wire has the raw view (not the qcow2 view).

But when you add x-dirty-bitmap into the mix, you are asking qemu to
DISREGARD the normal rules of backing file information and instead
report on dirty bitmap information as if it were backing file info.
This means that anywhere the dirty bitmap response differs from a
normal backing file response, the output of qemu-img is reporting
garbage data (for example, the 'present' bit is now bogus, which
explains why the rows where qemu-img claims 'present' is false omit an
'offset').  Only 'start', 'length', and 'data' matter when using
x-dirty-bitmap, with 'data=false' meaning the section was reported
dirty, and 'data=true' meaning the section was reported unchanged.

And if that is confusing, well yeah. Which is why I recommend using
libnbd's nbdinfo --map, where the output is more obvious.

> 
> root@be-proxmox1:/# qemu-img map --output=json --image-opts
> "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:bitmap1"
>   [{ "start": 0, "length": 196608, "depth": 0, "present": true, "zero":
> false, "data": true, "compressed": false, "offset": 0},

The extent starting at logical offset 0 and lasting 196608 bytes is
unchanged.

> { "start": 196608, "length": 65536, "depth": 0, "present": false, "zero":
> false, "data": false, "compressed": false},

The extent starting at 196608 and lasting 65536 bytes is dirty
(altered since the point in time when the bitmap was created).

> > > qemu-img
> > > map with x-dirty-bitmap image-opts.
> >
> > Here, this works, but feels like a hack, because it is relying on the
> > x-dirty-bitmap feature of qemu.  The libnbd project ships with an
> > application 'nbdinfo --map' that can read the same information as
> > 'qemu-img map' but with a much nicer layout.  It's not going to
> > necessarily be faster, but because it is a fully-supported feature of
> > libnbd rather than a hack in qemu, it may prove more stable in the
> > long run, and certainly easier to understand.


For a worked example:

# Create an image, dirty two different offsets, with a bitmap created in between
$ qemu-img create -f qcow2 foo.qcow2 3M
Formatting 'foo.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=3145728 lazy_refcounts=off refcount_bits=16
$ qemu-io -f qcow2 foo.qcow2 -c 'w 1M 512'
wrote 512/512 bytes at offset 1048576
512 bytes, 1 ops; 00.01 sec (42.906 KiB/sec and 85.8112 ops/sec)
$ qemu-img bitmap -f qcow2 foo.qcow2 --add b1
$ qemu-io -f qcow2 foo.qcow2 -c 'w 2M 512'
wrote 512/512 bytes at offset 2097152
512 bytes, 1 ops; 00.00 sec (107.735 KiB/sec and 215.4704 ops/sec)

# Now, expose the raw bytes of the image over NBD, and inspect with nbdinfo

$ qemu-nbd -f qcow2 foo.qcow2 -A -Bb1 -t
$ nbdinfo --map=qemu:dirty-bitmap:b1 nbd://localhost
         0     2097152    0  clean
   2097152       65536    1  dirty
   2162688      983040    0  clean
$ nbdinfo --map nbd://localhost
         0     1048576    3  hole,zero
   1048576        4096    0  data
   1052672       61440    2  zero
   1114112      983040    3  hole,zero
   2097152        4096    0  data
   2101248       61440    2  zero
   2162688      983040    3  hole,zero

Comparing those to qemu-img map --output=json should be instructive.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


