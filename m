Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CF1CA0FF2
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Aug 2025 16:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uskde-0006FM-2U; Sun, 31 Aug 2025 12:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikolai.barybin@virtuozzo.com>)
 id 1uskdU-0006CJ-8r
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 12:10:34 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikolai.barybin@virtuozzo.com>)
 id 1uskdP-0001h8-OU
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 12:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Content-Type:Message-ID:Date:Subject
 :From; bh=fleGzc8HzlnBsUshuXxpzcFT7AOf+zt6nxFnSID6yb4=; b=QIWmzLO1/X9EBl35iez
 NEQ/vuWva1f/IP3ye/ALk2vUKGxfBueYEkd8rFFoDeA6+9hPr04UdYAQOe+oOM/1PyUZ5DiUMGeFp
 iaa+lyERVIdsH48F4J1ypjAJigOz5okR01k1FA7oJrFttX0w+owO3OSxhsGjtSLcbe1dkwHuugg1R
 8+wFnBOtgs2S7gN/aPA3/SIorqlh+5ngE3ksluizQVmlJnsT+d9TzvkvqmOPGnFmyouqtOE34lnWu
 2gNNCpetRJzLYJ4i/0D2V+9LNv25GpPUYD+9pHhiBJFpRqltTWHWXFpQTXZRhHpr2bDjAfgzB5o9v
 TroraWcRbKVJHBg==;
Received: from [130.117.225.5] (helo=dev012.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <nikolai.barybin@virtuozzo.com>) id 1usk8e-006VhA-1E;
 Sun, 31 Aug 2025 18:10:16 +0200
From: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: Nikolai Barybin <nikolai.barybin@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V . Lunev" <den@virtuozzo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 0/1] dump: enhance win_dump_available to report properly
Date: Sun, 31 Aug 2025 19:10:21 +0300
Message-ID: <20250831161022.452426-1-nikolai.barybin@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=nikolai.barybin@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Changes since last revision:
- Updated dump_state_prepare() to init fd to -1
- Use locally allocated dums structure in qmp_query_dump_guest_memory_capability()

Nikolai Barybin (1):
  dump: enhance win_dump_available to report properly

 dump/dump.c     | 138 ++++++++++++++++++++++++++++--------------------
 dump/win_dump.c |  23 ++++++--
 dump/win_dump.h |   2 +-
 3 files changed, 101 insertions(+), 62 deletions(-)

-- 
2.43.5


