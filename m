Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F70C54FC6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2024 14:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sklWH-0002Lo-KO; Sun, 01 Sep 2024 10:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1sklWE-0002Dk-I2; Sun, 01 Sep 2024 10:25:30 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be ([134.58.240.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1sklWB-0003XL-NJ; Sun, 01 Sep 2024 10:25:30 -0400
X-KULeuven-Envelope-From: libvirt-e6954efa@volkihar.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: BDF4B20056.AF1A7
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be
 (icts-p-ceifnet-smtps.service.icts.svcd
 [IPv6:2a02:2c40:0:51:130:242:ac11:10])
 by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id BDF4B20056;
 Sun,  1 Sep 2024 16:25:21 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from flutterbat.volkihar.be (236.58-240-81.adsl-dyn.isp.belgacom.be
 [81.240.58.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 993DDD4F7A27F; 
 Sun,  1 Sep 2024 16:25:21 +0200 (CEST)
Received: by flutterbat.volkihar.be (Postfix, from userid 1000)
 id 5156C16DCFA; Sun, 01 Sep 2024 16:25:21 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Subject: [PATCH v3 0/5] block: allow commit to unmap zero blocks
Date: Sun,  1 Sep 2024 16:24:00 +0200
Message-ID: <20240901142405.3183874-1-libvirt-e6954efa@volkihar.be>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.58.240.131;
 envelope-from=libvirt-e6954efa@volkihar.be;
 helo=icts-p-cavuit-2.kulnet.kuleuven.be
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch series adds support for zero blocks in non-active commits.
The first three patches in the series contains the actual changes to the
commit code, the last patch adds a test for the new functionality.

---

Changes since v2:
- moved main loop of commit_run to a separate function and refactored
  the error handling.
- call blk_co_pwrite_zero even if the size of the zero region does not
  align with the sectors of the base image. This removes the need for
  the CommitMethod enum

Changes since v1:
- split up the implementation in three separate commits
- removed accidentally left over includes from testing

Vincent Vanlaer (5):
  block: get type of block allocation in commit_run
  block: move commit_run loop to separate function
  block: refactor error handling of commit_iteration
  block: allow commit to unmap zero blocks
  block: add test non-active commit with zeroed data

 block/commit.c             | 108 +++++++++++++++++++++++++------------
 tests/qemu-iotests/315     |  95 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/315.out |  54 +++++++++++++++++++
 3 files changed, 223 insertions(+), 34 deletions(-)
 create mode 100755 tests/qemu-iotests/315
 create mode 100644 tests/qemu-iotests/315.out

-- 
2.44.1


