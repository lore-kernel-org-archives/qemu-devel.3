Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92346C3DA45
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 22:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSkmi-0002xv-T0; Sat, 13 Jul 2024 18:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1sSkma-0002n9-N2; Sat, 13 Jul 2024 17:59:56 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be ([2a02:2c40:0:c0::25:131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1sSkmV-00077V-09; Sat, 13 Jul 2024 17:59:56 -0400
X-KULeuven-Envelope-From: libvirt-e6954efa@volkihar.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 206022006D.AC52C
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be
 (icts-p-ceifnet-smtps.service.icts.svcd
 [IPv6:2a02:2c40:0:51:131:242:ac11:48])
 by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 206022006D;
 Sat, 13 Jul 2024 23:59:39 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from flutterbat.volkihar.be (unknown
 [IPv6:2a02:a03f:8ada:7900:82c7:e67a:7d31:6a56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id F326CD4EDEA16; 
 Sat, 13 Jul 2024 23:59:38 +0200 (CEST)
Received: by flutterbat.volkihar.be (Postfix, from userid 1000)
 id B018671CCB8; Sat, 13 Jul 2024 23:59:38 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Subject: [PATCH v2 0/4] block: allow commit to unmap zero blocks
Date: Sat, 13 Jul 2024 23:56:40 +0200
Message-ID: <20240713215644.742244-1-libvirt-e6954efa@volkihar.be>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:2c40:0:c0::25:131;
 envelope-from=libvirt-e6954efa@volkihar.be;
 helo=icts-p-cavuit-2.kulnet.kuleuven.be
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Changes since v1:
- split up the implementation in three separate commits
- removed accidentally left over includes from testing

Vincent Vanlaer (4):
  block: get type of block allocation in commit_run
  block: refactor commit_run for multiple write types
  block: allow commit to unmap zero blocks
  block: add test non-active commit with zeroed data

 block/commit.c             | 68 +++++++++++++++++++++------
 tests/qemu-iotests/315     | 95 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/315.out | 54 ++++++++++++++++++++++
 3 files changed, 204 insertions(+), 13 deletions(-)
 create mode 100755 tests/qemu-iotests/315
 create mode 100644 tests/qemu-iotests/315.out

-- 
2.44.1


