Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D28CAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 12:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwgYX-00049l-Bd; Thu, 11 Sep 2025 08:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikolai.barybin@virtuozzo.com>)
 id 1uwgYF-00042S-BR
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:37:24 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikolai.barybin@virtuozzo.com>)
 id 1uwgY2-0003Ld-6R
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
 :From; bh=VMrzAOVoxGmOJ9Ov4Dc6WuTDHNAHSRK4xVAkb+787ek=; b=NYufPtr4WZjT1br67w5
 aGHy5Hyy+Yei2JEJnb/RnLrkSNdPXC3Qt5HRdlwuRIxHgSIjmGNzsimqZ+6hVM/Y6e3P/YPcwUl0s
 aeu3eE1rOCPmu+yNDc+0xjEeRE9aPT6rtX1wOH7tt+n76G2Y4zkskuHUIZ5FgFUvnL4LFCirVGp8f
 3PxlgAxpddlQzqh7tfuxiQij46fe+K8ZpsN4/fp1N2d6kbvNrHN+33MtdkTxiYE7cvBI8pyCItGfp
 EHJP51+RVB4tgo62tEFk2AQuWO/dWYmneAhG1JpOetC8dJiV8DJPyEHlAJECNDbpbRkQOaqYvKuS7
 OEQjfXknHmVg0qw==;
Received: from [130.117.225.5] (helo=dev012.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <nikolai.barybin@virtuozzo.com>) id 1uwg2t-009znU-1D;
 Thu, 11 Sep 2025 14:36:54 +0200
From: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nikolai Barybin <nikolai.barybin@virtuozzo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Denis V . Lunev" <den@virtuozzo.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 1/2] dump: enhance dump_state_prepare fd initialization
Date: Thu, 11 Sep 2025 15:36:55 +0300
Message-ID: <20250911123656.413160-2-nikolai.barybin@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250911123656.413160-1-nikolai.barybin@virtuozzo.com>
References: <20250911123656.413160-1-nikolai.barybin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Initializing descriptor with zero is unsafe: during cleanup we risk to
unconditional close of fd == 0 in case dump state wasn't fully
initialized. Thus, let's init fd with -1 value and check its value
before closing it.

Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 dump/dump.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 15bbcc0c61..b2f7ea7abd 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -103,7 +103,10 @@ static int dump_cleanup(DumpState *s)
 
     guest_phys_blocks_free(&s->guest_phys_blocks);
     memory_mapping_list_free(&s->list);
-    close(s->fd);
+    if (s->fd != -1) {
+        close(s->fd);
+    }
+    s->fd = -1;
     g_free(s->guest_note);
     g_clear_pointer(&s->string_table_buf, g_array_unref);
     s->guest_note = NULL;
@@ -1708,8 +1711,8 @@ static DumpState dump_state_global = { .status = DUMP_STATUS_NONE };
 
 static void dump_state_prepare(DumpState *s)
 {
-    /* zero the struct, setting status to active */
-    *s = (DumpState) { .status = DUMP_STATUS_ACTIVE };
+    /* zero the struct, setting status to active and fd to -1 */
+    *s = (DumpState) { .fd = -1, .status = DUMP_STATUS_ACTIVE };
 }
 
 bool qemu_system_dump_in_progress(void)
-- 
2.43.5


