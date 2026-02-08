Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF58EF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 10:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vp1eJ-0004Lo-6O; Sun, 08 Feb 2026 05:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vp1e9-0004JE-CV; Sun, 08 Feb 2026 05:04:05 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vp1e5-0001oJ-V4; Sun, 08 Feb 2026 05:04:05 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 545AC8084D;
 Sun, 08 Feb 2026 13:03:57 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:d25::1:35])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id t3Njcn1A4eA0-zke9jLxO; 
 Sun, 08 Feb 2026 13:03:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1770545037;
 bh=O7UmaUaZH2MwuV93uGlmz+EHInB8iHY0nDVJhhkIj6A=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dys8MQGqlhK8tzz9rTe09bO6KKzUdSSDY/BD3wOu1vG3PfnBdG4KHP8BKXEfbI5Z9
 QBCdSPcEsHYHvGkfOIfGWRLJaBM53wERWl/jFyqHOP/mF931df11W13v4c7ofwJf2J
 HZZEPnPX5Wm5eP+9jtOv7yiNurJ6Jvca5AmooDXU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH 2/4] dump/dump.c: reorder usage and assertion of block
Date: Sun,  8 Feb 2026 15:03:52 +0500
Message-Id: <20260208100354.116102-3-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208100354.116102-1-heifetz@yandex-team.com>
References: <20260208100354.116102-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
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

Reorder the code so the assertion of block occurs before it is
used in the subsequent lines.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 dump/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dump/dump.c b/dump/dump.c
index f7a99a7af2..80ed6c8d21 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1288,6 +1288,7 @@ static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnptr,
     /* block == NULL means the start of the iteration */
     if (!block) {
         block = QTAILQ_FIRST(&s->guest_phys_blocks.head);
+        assert(block);
         *blockptr = block;
         addr = block->target_start;
         *pfnptr = dump_paddr_to_pfn(s, addr);
@@ -1295,7 +1296,6 @@ static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnptr,
         *pfnptr += 1;
         addr = dump_pfn_to_paddr(s, *pfnptr);
     }
-    assert(block != NULL);
 
     while (1) {
         if (addr >= block->target_start && addr < block->target_end) {
-- 
2.34.1


