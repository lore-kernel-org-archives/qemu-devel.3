Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB311C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 16:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3GsU-0001HP-F5; Fri, 11 Apr 2025 12:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u3GsQ-0001D7-NV
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 12:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u3GsN-00084F-4h
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 12:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744387506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Tui7YI+mrvCSVs6hvXmRZzVcJkIJCyfuiu2GpEAEXw=;
 b=JcdmcT/UU5FLk9ACchrvsnz/VSBWcQj7hOyaOKPLHol8s9bWL/pVQnCKihqWA5JZ/kzV+h
 zwLsA2KJEHVr9Af6ytlvPCCL3OibqorKGOanFYM5i5SLsluO9PGqnRuKq28PbWIGOP+wav
 1JMaagYmnuhmMIJO5NO/utEZEIqhhpA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-sk6X4igJPkWI29TN_Qu1vQ-1; Fri,
 11 Apr 2025 12:05:02 -0400
X-MC-Unique: sk6X4igJPkWI29TN_Qu1vQ-1
X-Mimecast-MFC-AGG-ID: sk6X4igJPkWI29TN_Qu1vQ_1744387501
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3149D180AF4D; Fri, 11 Apr 2025 16:05:01 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 422DE19560AD; Fri, 11 Apr 2025 16:04:59 +0000 (UTC)
Date: Fri, 11 Apr 2025 11:04:56 -0500
From: Eric Blake <eblake@redhat.com>
To: prashant patil <pmgpatil@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Query on the dirty bitmap
Message-ID: <xrn5m6e27eys2fkzv5gzmsdrzhal57dwssjphtlzusfwnpg5zl@vmslhdgep35r>
References: <CAFvsdYns1yO6Wsm8VKP_khbTPm09Kf5KDmBpeMSrjboyccK4Aw@mail.gmail.com>
 <d2276vugq6wureu6zzrwci5sdtg3b6gllqskjv7hfvuulsmhyn@anl3d5htudty>
 <CAFvsdYk0J7ybdu+dL+w70Po1bGypLopBkixPp-ZzmTA8MdTr0w@mail.gmail.com>
 <pf24mn3twfrc2kfaszovdyj5rhh6d4r4ixawh2dyx5dbi5no3j@ryk4lzslrnye>
 <CAFvsdYmJFDuQzk6Byu+f4HcTO1EStin3vEMC+twh8P3T2ve6qA@mail.gmail.com>
 <6s2grkptds54jewlroehfvfpk4aci5ks7lkm4h4tfnvayxzi4l@2tilhng3srix>
 <CAFvsdYkhcMgNJfQwdSZ_23qwoqUwbSF8uhBYDQa6d=CiXbcLmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFvsdYkhcMgNJfQwdSZ_23qwoqUwbSF8uhBYDQa6d=CiXbcLmw@mail.gmail.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
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

On Tue, Apr 08, 2025 at 04:30:38PM +0530, prashant patil wrote:
>  Thank you, Eric, for the thorough information—truly appreciate it.
> 
> Just to confirm what I understood, when we are reading a bitmap with
> 'x-dirty-bitmap' (for powered on vm of course), the 'start' is always a
> logical offset no matter whether the record has 'offset' value or not. Is
> this correct?

Whether you are querying dirty bitmaps (x-dirty-bitmap on command
line) or normal allocation (omitted), yes, the 'start' lists the
logical offset of each extent listed, where the extents correspond to
the offsets that a read over the same connection would access.

> 
> Also, I came across a case wherein we get the entire disk as allocated for
> a raw format disk which is present on lvm or lvm-thin storage (the disk has
> just a few MB data added, and the vm is in running state). Here is an
> example of 1Gb data. Is this expected behaviour?
> [{ "start": 0, "length": 1073741824, "depth": 0, "present": true, "zero":
> false, "data": true, "compressed": false, "offset": 0}]

For raw images, the ability to report holes depends on how well
lseek(SEEK_DATA) works; this is filesystem dependent (for example, for
the longest time, tmpfs had O(n) rather than O(1) performance for a
single call, making an lseek() map of the extents of the entire file
an untenable O(n^2) effort, so we purposefully avoid lseek when it is
not known to be efficient).  I would LOVE it if the kernel supported
lseek(SEEK_DATA) on block devices - in fact, here's a patch series
that Stefan started where we debated what that might look like,
although it never gained any traction at the time:
https://lore.kernel.org/lkml/20240328203910.2370087-1-stefanha@redhat.com/

It may be also possible for qemu to use ioctls to probe block device
extents when lseek() doesn't directly work, but patches would have to
be submitted, and that won't scale as well as having the kernel report
the information up front to all interested users, rather than patching
each client to learn the right ioctls to work around the kernel's lack
of a unified interface.

So in the short term, yes, it is reasonable to expect that qemu is not
able to report where the sparse regions of an lvm block device are.
Note that something reported as full data is always accurate, even if
inefficient.

One other side note - a few months back, I was working on a potential
project to write a CSI driver that used lvm devices, and was working
on what it would take for that CSI driver to expose the
'GetMetadataAllocated' and 'GetMetadataDelta' gRPC calls.  lvm code
did not, at the time, provide any convenient way to list which
portions of a thin volume were directly allocated or which were dirty
in relation to a prior snapshot.  There might be some hacks you can do
with device-mapper code to get at that, or newer versions of lvm code
might add something along those lines; but that was another place
where I would have loved to have a kernel interface for letting
seek(SEEK_DATA) expose where the allocations live.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


