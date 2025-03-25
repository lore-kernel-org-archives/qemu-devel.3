Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AA2C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 12:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx3iG-0005na-6s; Tue, 25 Mar 2025 08:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tx3iB-0005mr-W8
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 08:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tx3iA-0006GA-7G
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 08:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742906932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nIpTs37xBGdc5mfU36q2Optwtu0+Cl1Y7RxPG6aby3E=;
 b=b+a8WlwgAxOpBMDDSadUXOJd2ASeAo47mxt7CUepORuaMeduuopO60t9JnjfTqo2b/qhR5
 rsKst9N9H6NjW7L9lmFmKgBoK1Vs2W+1qq+x3y46Qbscqw19/lAVZPP84XIh/DZJeWu1yS
 eI85UhMu2ii+6dri38L0ikj5ActoFys=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-kuFRcnocMBiZaclKwu9LFw-1; Tue,
 25 Mar 2025 08:48:49 -0400
X-MC-Unique: kuFRcnocMBiZaclKwu9LFw-1
X-Mimecast-MFC-AGG-ID: kuFRcnocMBiZaclKwu9LFw_1742906928
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A028B1903081; Tue, 25 Mar 2025 12:48:41 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.47])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0A48180A803; Tue, 25 Mar 2025 12:48:37 +0000 (UTC)
Date: Tue, 25 Mar 2025 13:48:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 stefanha@redhat.com
Subject: Re: [PATCH 2/2] scsi-disk: Add native FUA support
Message-ID: <Z-KmIyWX8hxRNe2u@redhat.com>
References: <20250304155232.1325581-1-afaria@redhat.com>
 <20250304155232.1325581-3-afaria@redhat.com>
 <Z8l56U16vyT7cnvi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8l56U16vyT7cnvi@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 06.03.2025 um 11:33 hat Kevin Wolf geschrieben:
> Am 04.03.2025 um 16:52 hat Alberto Faria geschrieben:
> > Avoid emulating FUA when the driver supports it natively. This should
> > provide better performance than a full flush after the write.
> > 
> > Signed-off-by: Alberto Faria <afaria@redhat.com>
> 
> Did you try out if you can see performance improvements in practice?
> It's always nice to have numbers in the commit message for patches that
> promise performance improvements.

I was curious enough to see how this and the recent series by Stefan
(virtio-scsi multiqueue) and myself (FUA on the backend + polling
improvements) play out with virtio-scsi, so I just ran some fio
benchmarks with sync=1 myself to compare:

iops bs=4k cache=none           |    virtio-scsi    |     virtio-blk    |
O_SYNC workload                 |   qd 1  |  qd 16  |   qd 1  |  qd 16  |
--------------------------------+---------+---------+---------+---------+
master                          |   21296 |  109747 |   25762 |  130576 |
+ virtio-scsi multiqueue        |   28798 |  121170 |       - |       - |
+ FUA in scsi-disk              |   51893 |  204199 |       - |       - |
--------------------------------+---------+---------+---------+---------+
Total change                    | +143.7% |  +86.1% |       - |       - |

(No new numbers for virtio-blk because virtio-scsi patches obviously
don't change anything about it. Also no numbers for FUA in file-posix
because it's unused with cache=none.)

iops bs=4k cache=directsync     |    virtio-scsi    |     virtio-blk    |
O_SYNC workload                 |   qd 1  |  qd 16  |   qd 1  |  qd 16  |
--------------------------------+---------+---------+---------+---------+
master                          |   32223 |  109748 |   45583 |  258416 |
+ FUA in file-posix + polling   |   32148 |  198665 |   58601 |  320190 |
+ virtio-scsi multiqueue        |   51739 |  225031 |       - |       - |
+ FUA in scsi-disk              |   56061 |  227535 |       - |       - |
--------------------------------+---------+---------+---------+---------+
Total change                    |  +74.0% | +107.3% |  +28.6% |  +23.9% |

Of course, the huge improvements on the virtio-scsi side only show how
bad it was before. In most numbers it is still behind virtio-blk even
after all three patch series (apart from cache=none where the
availability of FUA on the device side makes a big difference, and I
expect that virtio-blk will improve similarly once we implement it
there).

Also note that when testing the virtio-scsi multiqueue patches, this
was still a single iothread, i.e. I wasn't even making use of the new
feature per se. I assume much of this comes from enabling polling
because the series moved the event queue handling to the main loop,
which prevented polling for virtio-scsi before. The series also got rid
of an extra coroutine per request for the blk_is_available() call in
virtio_scsi_ctx_check(), which might play a role, too.

Anyway, I like these numbers for FUA in scsi-disk. It makes write back
cache modes almost catch up to write through with O_SYNC workloads. We
should definitely get this merged and do the same for virtio-blk.

Kevin


