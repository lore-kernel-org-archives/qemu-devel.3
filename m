Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECFDCAC590
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 00:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqi9G-0008U2-9V; Tue, 17 Sep 2024 20:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqi9E-0008T4-W9
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 20:02:21 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqi9D-0006Nk-8Z
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 20:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=7PXY9LaACWi1khJh2Sr7LKiTgvtybRcQTaTGtu2blv0=; b=HXblDzGGASsZPFms
 FGNs0uO28T6rfNTwLYC7DfiBJAn5WakZM+ilG5s5BGPdQ1vjp/tmLVXgr59vOo0J4gARi6nkOCz2w
 u+jBTYPj8PKvk3sVel1DpRvPu91hq/HIjVQ7wLQNAjrT0Cc5Fio5o+WDxGKvsO99Q4IVZrRtIpmMa
 c3hHjkDA45OGcvU1SDvej+lC6dbAxFiPI2TGYXmBuKN6eDLA2Qw+cANJbwa/zz/FcwUZ3ttNltgrw
 fOD7GdbSIDe5VqgBrm0aHxhj2Krp0mBsgESmmCoPh6+bDbsKAe2nk8d6aAzvyidlZnjTEHDiyMALJ
 tAmaMiPiX9sQVyRpAA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqi99-006Dj5-1z;
 Wed, 18 Sep 2024 00:02:15 +0000
From: dave@treblig.org
To: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 0/3] Migration deadcode removal
Date: Wed, 18 Sep 2024 01:02:04 +0100
Message-ID: <20240918000207.182683-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

Hi,
  This is a set of deadcode removal around migration
found by looking for unused symbols.

  Note this does remove the old zero-blocks
capability, but it's been meaningless anyway since block
migration went.

Dave

Dr. David Alan Gilbert (3):
  migration: Remove migrate_cap_set
  migration: Remove unused zero-blocks capability
  migration: Remove unused socket_send_channel_create_sync

 migration/options.c | 28 ----------------------------
 migration/options.h |  2 --
 migration/socket.c  | 18 ------------------
 migration/socket.h  |  1 -
 qapi/migration.json | 10 +---------
 5 files changed, 1 insertion(+), 58 deletions(-)

-- 
2.46.0


