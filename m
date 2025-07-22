Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C21C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 13:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueD7I-0008QF-JD; Tue, 22 Jul 2025 09:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ueD7A-0008IJ-En
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 09:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ueD76-000596-Rj
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 09:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753191178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eJ0Ezi4YBKVxyFKknH8ppZf0265MQWGEcay2zpGL9QA=;
 b=AUlnpvIxDsaMR9xct3jI23vMJC0hrWeMyDzZKGBlYUpx6uT8epDZDzWqV9bHLtj/gUD3/c
 JNENJxkUsNflKE575oxFhHtLlghoztP+pA49Y2gaH+tWy0khAsfWragUzxmVyjTheOhoVB
 +p1/Xn7wr38F3qGofObSrLSOHBGrOsc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-vn80zdX8P8-NKqtOZhcYSg-1; Tue,
 22 Jul 2025 09:32:55 -0400
X-MC-Unique: vn80zdX8P8-NKqtOZhcYSg-1
X-Mimecast-MFC-AGG-ID: vn80zdX8P8-NKqtOZhcYSg_1753191174
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0205B1800C31; Tue, 22 Jul 2025 13:32:54 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.16])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6014B19560AB; Tue, 22 Jul 2025 13:32:50 +0000 (UTC)
Date: Tue, 22 Jul 2025 15:32:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bschubert@ddn.com, fam@euphon.net, hreitz@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for
 QEMU FUSE Exports
Message-ID: <aH-S_31c8RNW3coY@redhat.com>
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716183824.216257-2-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 16.07.2025 um 20:38 hat Brian Song geschrieben:
> This work provides an initial implementation of fuse-over-io_uring
> support for QEMU export. According to the fuse-over-io_uring protocol
> specification, the userspace side must create the same number of queues
> as the number of CPUs (nr_cpu), just like the kernel. Currently, each
> queue contains only a single SQE entry, which is used to validate the
> correctness of the fuse-over-io_uring functionality.
> 
> All FUSE read and write operations interact with the kernel via io
> vectors embedded in the SQE entry during submission and CQE fetching.
> The req_header and op_payload members of each entry are included as
> parts of the io vector: req_header carries the FUSE operation header,
> and op_payload carries the data payload, such as file attributes in a
> getattr reply, file content in a read reply, or file content being
> written to the FUSE client in a write operation.
> 
> At present, multi-threading support is still incomplete. In addition,
> handling connection termination and managing the "drained" state of a
> FUSE block export in QEMU remain as pending work.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>
> 
> ---
>  block/export/fuse.c                  | 423 +++++++++++++++++++++++++--
>  docs/tools/qemu-storage-daemon.rst   |  10 +-
>  qapi/block-export.json               |   6 +-
>  storage-daemon/qemu-storage-daemon.c |   1 +
>  util/fdmon-io_uring.c                |   5 +-
>  5 files changed, 420 insertions(+), 25 deletions(-)

You already got a lot of feedback on details. Let me add a more generic
point that should be addressed for a non-RFC submission: You should try
to limit each commit to a single logical change. You'll then send a
patch series instead of just a single patch where each patch works
incrementally towards the final state.

This makes it not only easier to review the changes because there is
less going on in each individual patch, but it will also be helpful if
we ever have to debug a problem and can bisect to a smaller change, or
even just because looking at the commit message in a few years is
likelier to explain why some specific code was written the way it is.

For example, your change to util/fdmon-io_uring.c could be the first
patch, enabling IORING_SETUP_SQE128 is a self-contained logical change.
You can mention in its commit message that it's in preparation for using
IORING_OP_URING_CMD.

Another patch could be refactoring fuse_co_process_request() so that it
works for both /dev/fuse based and io_uring based exports. (I agree with
Stefan that the code should be shared between both.)

And then you could see if adding io_uring support to the FUSE export
itself can be broken down into multiple self-contained changes or if
that part has to stay a single big patch. Maybe you can keep it similar
to how you're actually developing the code: First a patch with a minimal
implementation that processes one request per queue, then another one to
implement parallel I/O, then one for supporting multiple iothreads.


Another thing I wondered is if the large #ifdef'ed section with io_uring
helpers would actually make more sense as a separate source file
block/export/fuse-io_uring.c that can be linked conditionally if
io_uring is available. This would help to minimise the number of #ifdefs
in fuse.c.

Kevin


