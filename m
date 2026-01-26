Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECC0D19510
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkSYz-0005aD-Py; Mon, 26 Jan 2026 14:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vkSYy-0005Za-1d
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:47:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vkSYw-0007J1-Dx
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769456869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OuMZqPMlSzdsYfs/y/qeBCfCz3qrdlaqWvrmbb5+/yM=;
 b=OJHAYywTGP4eRo+tS9m3E9CeMWvAPXE9+4KdL1Jg7rImFZIbSC+uzn1espalRwd+OQz/Ij
 LyokuppouOXTCn/sWdaPKqDREdwZ5WAtqcvfXYdHoX2oJVFccUPTDYxgfW8oJ/pecRZYwI
 sm1udjrjpNfoYgAasjRH/QLqrtdwf8k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-xmXZeeQzPQmmV6FU92fj7g-1; Mon,
 26 Jan 2026 14:47:46 -0500
X-MC-Unique: xmXZeeQzPQmmV6FU92fj7g-1
X-Mimecast-MFC-AGG-ID: xmXZeeQzPQmmV6FU92fj7g_1769456864
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF97119775AA; Mon, 26 Jan 2026 19:47:43 +0000 (UTC)
Received: from localhost (unknown [10.2.17.0])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9DB7D180066A; Mon, 26 Jan 2026 19:47:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: pkrempa@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Alberto Faria <afaria@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Qing Wang <qinwang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/5] scsi: persistent reservation live migration
Date: Mon, 26 Jan 2026 14:47:30 -0500
Message-ID: <20260126194735.46167-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

v2:
- Add user documentation [Paolo]
- Send PREEMPT on the source if migration fails. This rollback operation
  ensures the source regains access to the LUN even if migration fails after
  the destination issues its own PREEMPT.

Live migration does not work for SCSI Persistent Reservations acquired on
scsi-block devices. This patch series migrates the reservation key and
reservation type so that the destination QEMU can take over the persistent
reservation with the PREEMPT service action upon live migration.

The approach involves snooping PERSISTENT RESERVE OUT replies and tracking the
scsi-block device's current reservation key and reservation type. In most cases
this involves no additional SCSI commands. This approach isn't perfect: if
another machine modifies the reservation on the physical LUN, then QEMU's state
becomes stale. Persistent reservations are inherently cooperative, so this is
acceptable as long as real applications don't run into problems.

I am also working on a test suite called pr-tests that runs sg_persist(8)
commands across multiple machines in order to exercise various scenarios:
https://gitlab.com/stefanha/pr-tests

Stefan Hajnoczi (5):
  scsi: generalize scsi_SG_IO_FROM_DEV() to scsi_SG_IO()
  scsi: add error reporting to scsi_SG_IO()
  scsi: track SCSI reservation state for live migration
  scsi: save/load SCSI reservation state
  docs: add SCSI migrate-pr documentation

 docs/system/device-emulation.rst        |   1 +
 docs/system/devices/scsi/index.rst      |  10 +
 docs/system/devices/scsi/migrate-pr.rst |  54 +++++
 include/hw/scsi/scsi.h                  |  15 +-
 include/scsi/constants.h                |  21 ++
 hw/core/machine.c                       |   4 +-
 hw/scsi/scsi-bus.c                      |   3 +
 hw/scsi/scsi-disk.c                     |  85 ++++++-
 hw/scsi/scsi-generic.c                  | 285 +++++++++++++++++++++++-
 hw/scsi/trace-events                    |   2 +
 10 files changed, 465 insertions(+), 15 deletions(-)
 create mode 100644 docs/system/devices/scsi/index.rst
 create mode 100644 docs/system/devices/scsi/migrate-pr.rst

-- 
2.52.0


