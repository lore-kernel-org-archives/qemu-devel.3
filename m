Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5A8CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZX2-0002gO-4v; Tue, 29 Sep 2026 11:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xBZX0-0002fc-FK
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xBZWw-0006EB-Iz
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790694844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7cldX4EVxV3GpvnzCzvUVc55EDunrs5E5dLdqJvytZY=;
 b=WUqc0vzOj3jkYsyO7sUfNrcN0NpNdv/UUqdrEAs1v/DNYt85nK8Ry8mqgov/PKICACnwUc
 cWe3raf+2nGYjTL2vDiOt+EEcfWmW+5EjyGPcq9RvC1pZVVTv5BbTqPQ2MTFnmpWO1iKwZ
 Xk1FYuSWmGpyLhENWhfzE77OZtunSm4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-zvs1w32VNZq2wbvpyqE49g-1; Tue,
 29 Sep 2026 11:14:03 -0400
X-MC-Unique: zvs1w32VNZq2wbvpyqE49g-1
X-Mimecast-MFC-AGG-ID: zvs1w32VNZq2wbvpyqE49g_1790694842
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 211D9196F779; Tue, 29 Sep 2026 15:14:01 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.225])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4478F195604D; Tue, 29 Sep 2026 15:13:58 +0000 (UTC)
Date: Tue, 29 Sep 2026 17:13:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Christian Quante <christian@quante.one>
Cc: John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/block/fdc: account for read and write requests
Message-ID: <arvVtJO_MNvVSuUW@redhat.com>
References: <20260824114216.231916-1-christian@quante.one>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824114216.231916-1-christian@quante.one>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Am 24.08.2026 um 13:41 hat Christian Quante geschrieben:
> hw/block/fdc.c never calls block_acct_*, so a floppy drive stays at
> zero in query-blockstats and "info blockstats" while IDE, ATAPI, SCSI,
> virtio-blk, NVMe and xen-block all report their traffic. That is the
> only interface through which QEMU reports drive activity, so a
> front-end that shows per-drive activity LEDs -- the way 86Box does --
> can light up every bus except the floppy.
> 
> The accounting is already set up for the drive: floppy_drive_realize()
> reaches block_acct_setup() through blkconf_apply_backend_options(), and
> -device floppy carries account-invalid, account-failed and
> stats-intervals through DEFINE_BLOCK_PROPERTIES. The properties can be
> set today, they just have nothing to act on.
> 
> Wrap the five blk_pread()/blk_pwrite() calls in two helpers that
> account for the transfer. The cookie lives on the stack: floppy I/O is
> synchronous throughout, so it never outlives the call and there is no
> device state to migrate, unlike IDE where the cookie sits in the device
> because the transfer is asynchronous -- scsi-disk, nvme, ahci and
> xen-block all keep it in their request state for the same reason.
> 
> Measured with a boot sector that reads 18 sectors from A: and 16 from
> C: and writes two back to each. The disk backend reports rd_ops=16
> rd_bytes=8192 wr_ops=2 wr_bytes=1024 either way, so the guest did the
> same work in both runs; the floppy went from rd_ops=0 wr_ops=0 to
> rd_ops=19 rd_bytes=9728 wr_ops=2 wr_bytes=1024 -- 19 reads being the
> boot sector the BIOS pulls in plus the 18 the guest asks for.
> 
> Signed-off-by: Christian Quante <christian@quante.one>

Thanks, applied to the block branch.

Would you mind adding some assertions that we counted correctly to
some existing I/O in fdc-test as a followup?

Kevin


