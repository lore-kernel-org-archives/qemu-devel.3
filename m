Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30A3CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 12:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwgYK-00040v-8Y; Thu, 11 Sep 2025 08:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikolai.barybin@virtuozzo.com>)
 id 1uwgYA-0003zE-Sf
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:37:18 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikolai.barybin@virtuozzo.com>)
 id 1uwgY2-0003Lb-6Q
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
 :From; bh=jDL4YwnVTRtqBqLVgffx3WOeptygvc/xP5pGSfFyaRM=; b=HcNzyL6VJIiss3FkDFC
 gL6gD+3oJbbGZtrMcPkx8XSG+LGOAvtmmAgCI7F1mC5KxVspQb0Ou/KtnGq7bQ2IDSas1btrT+EHy
 /xjvsUKz5JIenj9zY6R7AsfA7YZ7jH/2lBBAn5C5mldNZo0hqPF8nvTZkYrGaIZg7eH3gfa7eibbs
 iMUjroxbMC2SppYt80fJYGdk9T6UGlkreZgas9/9tIvjDQLzaA/OD03kwiPUxYK9ZpH1sZcxnYEjz
 DIJRopNw8UoiNUbXQcNcWxdsDrgB0WgLq+0+bB42mB7JQ/1DfG/NiO3S7c0LvD0UYTCulEDdON6/p
 NY8xxojDb5x1PlQ==;
Received: from [130.117.225.5] (helo=dev012.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <nikolai.barybin@virtuozzo.com>) id 1uwg2t-009znU-11;
 Thu, 11 Sep 2025 14:36:54 +0200
From: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nikolai Barybin <nikolai.barybin@virtuozzo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Denis V . Lunev" <den@virtuozzo.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 0/2] dump: enhance win_dump_available to report properly
Date: Thu, 11 Sep 2025 15:36:54 +0300
Message-ID: <20250911123656.413160-1-nikolai.barybin@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
- Split in 2 patches

Nikolai Barybin (2):
  dump: enhance dump_state_prepare fd initialization
  dump: enhance win_dump_available to report properly

 dump/dump.c     | 138 ++++++++++++++++++++++++++++--------------------
 dump/win_dump.c |  23 ++++++--
 dump/win_dump.h |   2 +-
 3 files changed, 101 insertions(+), 62 deletions(-)

-- 
2.43.5


