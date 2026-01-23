Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5ACD74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjInM-000750-Aa; Fri, 23 Jan 2026 10:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjInE-0006zT-PT
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:49 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjInD-0002xD-8c
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:48 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9698A4369D;
 Fri, 23 Jan 2026 15:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96323C19421;
 Fri, 23 Jan 2026 15:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769180978;
 bh=nJH+oIWdTGUsif757j8ogUbsj4cBfw0Vn03rJ5LhvTw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rTLrzOPIobqoyAdg3Oc/BA0hVob15CZjqzn2BjACs04ZzkQGFULM0F6t9CO6jvvcy
 +Vx3hELa7B3U9fH/XSLomzkljKz/g59YSNRkWzqZt4qdIXdgq388P0e/NUC5iDJDcd
 N9tfbw2O6FtcTX0254Yc9uaYQ/HoBAua14O82Xc73QzSVtCKYd3wH9Nl30Kud7gVTa
 m318HUcnFAMfWUP923QGw5mTWAACDP/nXUiZsXd/zB1JOjLGemTuRneUYtyQEAERDd
 7i4OWkkvWc2GgEnA23pGfuxlszti+9k/Vv0BKPJo7u2Q/9P14nQW+BchBk3dP7XINp
 VURe137KzMEOw==
From: deller@kernel.org
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 2/3] linux-user: val3 parameter of futex() syscall needs
 endianess swapping
Date: Fri, 23 Jan 2026 16:07:59 +0100
Message-ID: <20260123150921.17891-3-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123150921.17891-1-deller@kernel.org>
References: <20260123150921.17891-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

The FUTEX_WAIT_BITSET and FUTEX_WAKE_BITSET operations use a val3
parameter for comparism. Even if this 32-bit parameter is in most cases
0xffffffff, ensure that we do a required endianess swapping if host and
guest endianess differ.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c0a9a86529..7cb9de97e9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8106,7 +8106,10 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
 #endif
     switch (base_op) {
     case FUTEX_WAIT:
+        val = tswap32(val);
+        break;
     case FUTEX_WAIT_BITSET:
+        val3 = tswap32(val3);
         val = tswap32(val);
         break;
     case FUTEX_WAIT_REQUEUE_PI:
@@ -8116,8 +8119,11 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
     case FUTEX_LOCK_PI:
     case FUTEX_LOCK_PI2:
         break;
-    case FUTEX_WAKE:
     case FUTEX_WAKE_BITSET:
+        val3 = tswap32(val3);
+        timeout = 0;
+        break;
+    case FUTEX_WAKE:
     case FUTEX_TRYLOCK_PI:
     case FUTEX_UNLOCK_PI:
         timeout = 0;
-- 
2.52.0


