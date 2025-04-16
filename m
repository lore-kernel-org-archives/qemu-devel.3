Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD399C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 07:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4x2O-0007Uv-7e; Wed, 16 Apr 2025 03:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u4x2J-0007S2-Hb; Wed, 16 Apr 2025 03:18:21 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u4x2D-0001of-Oi; Wed, 16 Apr 2025 03:18:18 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a02:a03f:eafe:6901:38ac:f342:2515:2d3c])
 by apollo.dupie.be (Postfix) with ESMTPSA id 1051A1520D20;
 Wed, 16 Apr 2025 09:18:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1744787883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c5hrA3YjGEmNzSP+OFwrztwkaZbFWrtGm3Wx7E8+RFc=;
 b=TxUWS6/Hsc8zrar4q4ckpov6pWN2ZYgdTUYSkn1Q53dXqDKyHuiEz9NlqSyzjufL/pXf2A
 RikV47A4wQhfejXtferyg97letvpFP3wweyLU7NoOGwyIy76YfNoZLbciHRDeOIZZYT0c5
 WoUw9rA6OFAim7u3QNn40Qft6dlK7wxHfzjWrxnJKzdVtiWAxl9mGrsYDvCoLPW7YNFDYY
 SOTgZawGzQGowALo+JbMYO9zHpkSJenRPkvuGzRB5igpYsuTxJBGxnYl4afSWp2YPB1hsz
 PZUe48lMnMxfK/SpKqbb3k20utMaNGS0AyRXhelqIgz8XLh/vrW2gVYO9x8H+A==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH 0/3] Add a for_commit option to qemu-img measure
Date: Wed, 16 Apr 2025 09:16:51 +0200
Message-ID: <20250416071654.978264-1-jean-louis@dupond.be>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This fixed bug #2369 [1]

This patch is a new implementation for a previous (non-merged) patch to make measure useful to calculate
the new size of the target image after commit.
It is very useful to have this kind of calculation if you do qcow2 on block storage (like iSCSi).
This because you need to be able to size the target volume big enough to handle the committed image.

Instead of modifying the existing measure logic, a new logic was added that really looks into the allocated
clusters and use the (local) next_cluster_index to calculate the target image size.
It also takes into account discards from the top into base to lower the index when a cluster is freed.

New test was added to verify the code.

When testing the new code on the impacted images in bug #2369 [1], this gives the following results:

Start:
<filesize>  <image>
 6174015488 top
13421772800 base

calculate with discard-no-unref=on:
required -> 13624475648
Commited image size: 13610385408

When calculating with discard-no-unref=off:
required -> 13520404480
Commited image size: 13504806912

Let me know if I made some mistakes :)

[1]: https://gitlab.com/qemu-project/qemu/-/issues/2369

Jean-Louis Dupond (3):
  block: add for_commit option to measure
  qcow2: make measure for_commit aware
  iotests/290: add test case for for_commit measure

 block/qcow2.c                    | 137 +++++++++++++++++++++++++++++--
 include/block/block_int-common.h |   4 +
 qapi/block-core.json             |  28 +++++++
 qemu-img.c                       |  40 +++++++--
 tests/qemu-iotests/290           |  45 ++++++++++
 tests/qemu-iotests/290.out       |  61 ++++++++++++++
 6 files changed, 304 insertions(+), 11 deletions(-)

-- 
2.49.0


