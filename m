Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E02606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQVN-0005SA-B6; Mon, 23 Nov 2026 04:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xVQVG-0005Q6-4d; Mon, 23 Nov 2026 04:38:26 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xVQVD-0003V1-4a; Mon, 23 Nov 2026 04:38:25 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 112E643172;
 Mon, 23 Nov 2026 10:38:13 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com
Subject: [PATCH v4 0/2] block/mirror: fix assertion failure upon duplicate
 complete for job using 'replaces'
Date: Mon, 23 Nov 2026 10:37:39 +0100
Message-ID: <20261123093808.185781-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1795426692319
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Changes in v4:
* Rebase on current master.
* tearDown: shut down source before target (worked the other way
  around too, since IO was flushed already, but cleaner in this
  order).
* tearDown: also remove nbd socket

Changes in v3:
* In the first test, avoid testing that all requests complete in a
  given time. This is prone to flakiness. Instead, complete the job
  under throttle.

Changes in v2:
* Drop already applied patch, only the tests remain to be added.
* Use throttle limits and issue requests in a way, that actually makes
  throttling take effect.
* Use a second VM instance for the NBD export target rather than
  qemu-storage-daemon, since qtest is needed for stepping the clock.


Fiona Ebner (2):
  iotests/041: add test for mirror with throttled NBD export as target
  iotests/041: add test for duplicate job-complete with throttled target

 tests/qemu-iotests/041     | 179 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |   4 +-
 2 files changed, 181 insertions(+), 2 deletions(-)

-- 
2.47.3



