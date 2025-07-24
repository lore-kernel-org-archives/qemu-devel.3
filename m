Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1516C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 20:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf2r1-0007zB-8d; Thu, 24 Jul 2025 16:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uf2qQ-0006qi-FD
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uf2qN-0007VG-Ik
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753390030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SkFmjOKV9wmISoaig+LYSZLCpB7AMOha+uQ9xbBeUyc=;
 b=PqgFZNq1vFcdH2oUOv3hql7N4WQnkLvFjWcPlD/D/zcp5P+0p1XgkilOTv0AygCRLTEnbz
 I/hNcUPx4jRbp+uTqo8s3WEwUFypZ1yA3epPoX3NL94WLACYlQ/7Qpu4cFxXsnJE3BTEzP
 4OMHn1O9gVDF15IyP2RulyMiZ0MhMwg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-Xj_n1Uv6MpCHAscQTTowqQ-1; Thu,
 24 Jul 2025 16:47:07 -0400
X-MC-Unique: Xj_n1Uv6MpCHAscQTTowqQ-1
X-Mimecast-MFC-AGG-ID: Xj_n1Uv6MpCHAscQTTowqQ_1753390026
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A08B180034A; Thu, 24 Jul 2025 20:47:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.247])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEF4C19560AA; Thu, 24 Jul 2025 20:47:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Brian Song <hibriansong@gmail.com>,
 qemu-block@nongnu.org, Bernd Schubert <bschubert@ddn.com>,
 Kevin Wolf <kwolf@redhat.com>, h0lyalg0rithm@git.sr.ht,
 Fam Zheng <fam@euphon.net>
Subject: [RFC 0/3] aio-posix: enable io_uring SINGLE_ISSUER and TASKRUN flags
Date: Thu, 24 Jul 2025 16:46:59 -0400
Message-ID: <20250724204702.576637-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Do not merge this series. The performance effects are not significant. I am
sharing this mainly to archive the patches and in case someone has ideas on how
to improve this.

Bernd Schubert mentioned io_uring_setup(2) flags that may improve performance:
- IORING_SETUP_SINGLE_ISSUER: optimization when only 1 thread uses an io_uring context
- IORING_SETUP_COOP_TASKRUN: avoids IPIs
- IORING_SETUP_TASKRUN_FLAG: makes COOP_TASKRUN work with userspace CQ ring polling

Suraj Shirvankar already started work on SINGLE_ISSUER in the past:
https://lore.kernel.org/qemu-devel/174293621917.22751.11381319865102029969-0@git.sr.ht/

Where this differs from Suraj's previous work is that I have worked around the
need for the main loop AioContext to be shared by multiple threads (vCPU
threads and the migration thread).

Here are the performance numbers for fio bs=4k in a 4 vCPU guest with 1
IOThread using a virtio-blk disk backed by a local NVMe drive:

                      IOPS               IOPS
Benchmark             SINGLE_ISSUER      SINGLE_ISSUER|COOP_TASKRUN|TASKRUN_FLAG
randread  iodepth=1   54,045 (+1.2%)     54,189 (+1.5%)
randread  iodepth=64  318,135 (+0.1%)    315,632 (-0.68%)
randwrite iodepth=1   141,918 (-0.44%)   143,337 (+0.55%)
randwrite iodepth=64  323,948 (-0.015%)  322,755 (-0.38%)

You can find detailed benchmarking results here including the fio
output, fio command-line, and guest libvirt domain XML:
https://gitlab.com/stefanha/virt-playbooks/-/tree/io_uring-flags/notebook/fio-output
https://gitlab.com/stefanha/virt-playbooks/-/blob/io_uring-flags/files/fio.sh
https://gitlab.com/stefanha/virt-playbooks/-/blob/io_uring-flags/files/test.xml.j2

Stefan Hajnoczi (3):
  iothread: create AioContext in iothread_run()
  aio-posix: enable IORING_SETUP_SINGLE_ISSUER
  aio-posix: enable IORING_SETUP_COOP_TASKRUN |
    IORING_SETUP_TASKRUN_FLAG

 include/system/iothread.h |   1 -
 iothread.c                | 140 +++++++++++++++++++++-----------------
 util/fdmon-io_uring.c     |  26 ++++++-
 3 files changed, 101 insertions(+), 66 deletions(-)

-- 
2.50.1


