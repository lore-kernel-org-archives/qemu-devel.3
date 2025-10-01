Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2795BCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zYz-0006BN-Pn; Wed, 01 Oct 2025 12:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v3zYw-0006AE-Gm
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:20:18 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v3zYd-00058R-OC
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1759335599; x=1790871599;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=94I+jqlxrbVaOe3QAwreYEO3XmvTND6U5Z/VxQUiof8=;
 b=USobYb/16c1NWD4mK/rtnm7OgXaUtf7xVg7IcBTehMbRdTtY1stmxpU8
 kFEWsH8VR5BrW8lL53naSP1YGKBiI38o1/ZNf0/GbNdEVBKtt91LazEin
 rNhIA+uq+q3q9sH4IperzBYeM8w99cX/eZbsZqjgpmWPjTzT+xVRJd/oc E=;
X-CSE-ConnectionGUID: BMT9spaQR8SPeeY6JSeirg==
X-CSE-MsgGUID: KcYS9fRuSciPo5mbyHypaQ==
X-IronPort-AV: E=Sophos;i="6.18,307,1751234400"; 
   d="scan'208";a="3123359"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
 by drago1i.eurecom.fr with ESMTP; 01 Oct 2025 18:19:46 +0200
Received: from marco-eurecom-desktop.s3.eurecom.fr (unknown [193.55.114.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtps.eurecom.fr (Postfix) with ESMTPSA id 602822ED4;
 Wed,  1 Oct 2025 18:19:46 +0200 (CEST)
From: Marco Cavenati <Marco.Cavenati@eurecom.fr>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, ppandit@redhat.com,
 berrange@redhat.com, Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PATCH 0/3] migration: Add support for mapped-ram with snapshots
Date: Wed,  1 Oct 2025 18:18:20 +0200
Message-ID: <20251001161823.2032399-1-Marco.Cavenati@eurecom.fr>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hello,

Add support for mapped-ram capability in combination with savevm/loadvm
snapshots.
Explicitly zero out memory pages since they are not guaranteed to be zero
(as they are for migration).
Add the flag and plumbings to QIOChannelBlock to support non-sequential
operations.

Part of this series was already submitted here https://lore.kernel.org/all/20250327141451.163744-3-Marco.Cavenati@eurecom.fr/
Thanks for all the feedbacks and guidance received there.


Marco Cavenati (3):
  migration: add FEATURE_SEEKABLE to QIOChannelBlock
  migration/ram: fix docs of ram_handle_zero
  migration: mapped-ram: handle zero pages

 migration/channel-block.c | 48 +++++++++++++++++++++++++++++++++
 migration/ram.c           | 57 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 2 deletions(-)

-- 
2.48.1


