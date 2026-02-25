Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4844AEFD206
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvA1m-0000El-KJ; Wed, 25 Feb 2026 03:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvA1l-0000EV-9F
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvA1i-0001lf-RQ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772007224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/t2I799/70AhlKBrt/hGps/fWqMbWFG19ZcoJumsjWY=;
 b=VgFzprWebuT8VrCivzBNKTcCjVxa31TyXMWIhwjvQM9JQ5MnSKXADrMW/FgzKfFPDiqXv/
 GbEzbLewmCXC7IKGn/4dp6gGDaLm6gaA4Ks07rMG1XA/hX9RH01S+2h5bLbOm/wAtBIOJx
 ax9lwUzyAf3At8wxzYJMPYwVAFc1+F8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-hU0C0xfbO4KIGPb_w8vs9g-1; Wed,
 25 Feb 2026 03:13:42 -0500
X-MC-Unique: hU0C0xfbO4KIGPb_w8vs9g-1
X-Mimecast-MFC-AGG-ID: hU0C0xfbO4KIGPb_w8vs9g_1772007221
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6ECA1956095; Wed, 25 Feb 2026 08:13:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58DDA3003D88; Wed, 25 Feb 2026 08:13:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 0/4] aio-posix: enable io_uring SINGLE_ISSUER, TASKRUN,
 and NO_SQARRAY flags
Date: Wed, 25 Feb 2026 16:13:32 +0800
Message-ID: <20260225081336.1639325-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These patches enable Linux io_uring flags that can improve performance.

Bernd Schubert mentioned io_uring_setup(2) flags that may improve performance:
- IORING_SETUP_SINGLE_ISSUER: optimization when only 1 thread uses an io_uring context
- IORING_SETUP_COOP_TASKRUN: avoids IPIs
- IORING_SETUP_TASKRUN_FLAG: makes COOP_TASKRUN work with userspace CQ ring polling

Jens Axboe recently confirmed that SINGLE_ISSUER makes sense.

Suraj Shirvankar already started work on SINGLE_ISSUER in the past:
https://lore.kernel.org/qemu-devel/174293621917.22751.11381319865102029969-0@git.sr.ht/

Where this differs from Suraj's previous work is that I have worked around the
need for the main loop AioContext to be shared by multiple threads (vCPU
threads and the migration thread).

Here are the performance numbers for fio bs=4k in a 4 vCPU guest with 1
IOThread using a virtio-blk disk backed by a local NVMe drive:

                      IOPS               IOPS              IOPS
Benchmark             SINGLE_ISSUER      +TASKRUN          +NO_SQARRAY
randread  iodepth=1   99108 (+0.33%)     100816 (+2.1%)    104411 (+5.7%)
randread  iodepth=64  276314 (+0.12%)    275939 (-0.012%)  275899 (-0.026%)
randwrite iodepth=1   99997 (-0.11%)     102866 (+2.8%)    105588 (+5.5%)
randwrite iodepth=64  272205 (-0.2%)     271973 (-0.29%)   273257 (+0.18%)

You can find detailed benchmarking results here including the fio
output, fio command-line, and guest libvirt domain XML:
https://gitlab.com/stefanha/virt-playbooks/-/tree/io_uring-flags/notebook/fio-output
https://gitlab.com/stefanha/virt-playbooks/-/blob/io_uring-flags/files/fio.sh
https://gitlab.com/stefanha/virt-playbooks/-/blob/io_uring-flags/files/test.xml.j2

Stefan Hajnoczi (4):
  iothread: create AioContext in iothread_run()
  aio-posix: enable IORING_SETUP_SINGLE_ISSUER
  aio-posix: enable IORING_SETUP_COOP_TASKRUN |
    IORING_SETUP_TASKRUN_FLAG
  aio-posix: enable IORING_SETUP_NO_SQARRAY

 include/system/iothread.h |   1 -
 iothread.c                | 140 +++++++++++++++++++++-----------------
 util/fdmon-io_uring.c     |  38 ++++++++++-
 3 files changed, 113 insertions(+), 66 deletions(-)

-- 
2.53.0


