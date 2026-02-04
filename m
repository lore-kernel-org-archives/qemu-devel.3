Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6C5E83EE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnXnM-0001GF-E5; Wed, 04 Feb 2026 02:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vnXnF-0001FS-Pp; Wed, 04 Feb 2026 02:59:22 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vnXnE-0006et-Bk; Wed, 04 Feb 2026 02:59:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1593:0:640:6beb:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 53AEC8079A;
 Wed, 04 Feb 2026 10:59:18 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:b69::1:1a])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id lwj54n0AFCg0-TTdKlju7; 
 Wed, 04 Feb 2026 10:59:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1770191957;
 bh=UHU9Dy999JbdfZUCbL2Sk0go2qkJy0vkTJ6o0pzdJUw=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Zk07wVo7chUtktDb+YsuOxIbXy1AafhB5CEw9Fnb4fjghFFudth2TpJBwYilZAHEJ
 b7itWisz8Oa51cFMfiIVq5wiINMK92dS6gfHBZghZUqTIYxzDrLj+7C5ZQ9Mrucq7M
 DTdY24nk/jnuiyPiFFlFSPkdHTHuHY0aQIAwI8ZQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Sergei Heifetz <heifetz@yandex-team.com>
Subject: [PATCH 3/4] system/physmem.c: reorder usage and assertion of block
Date: Wed,  4 Feb 2026 12:57:53 +0500
Message-Id: <20260204075754.21078-4-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204075754.21078-1-heifetz@yandex-team.com>
References: <20260204075754.21078-1-heifetz@yandex-team.com>
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
 system/physmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index b0311f4531..4308e02940 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2054,11 +2054,11 @@ static int memory_try_enable_merging(void *addr, size_t len)
  */
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 {
+    assert(block);
+
     const ram_addr_t oldsize = block->used_length;
     const ram_addr_t unaligned_size = newsize;
 
-    assert(block);
-
     newsize = TARGET_PAGE_ALIGN(newsize);
     newsize = REAL_HOST_PAGE_ALIGN(newsize);
 
-- 
2.34.1


