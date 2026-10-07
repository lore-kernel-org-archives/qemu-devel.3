Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8C9CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENYY-0002gP-KA; Wed, 07 Oct 2026 05:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEKjZ-0001oH-Vz
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:02:51 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEKjR-0001Rv-KQ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:02:33 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69761tqM048409
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 7 Oct 2026 15:02:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2HUno62HsZaaCcmIrBgQRoldQXNh1TnWD02j631o4yM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1791352921; v=1;
 b=EN1l7ZWCoRLGF3c9qF4fBOYZbil7ixKdlv5Z+fgxLx06QF9ET/Wi9hUXyXyg5+Co
 o8UQaWZZRYtpeO60Gd3+sNllC9aOBLB4fSOtqBK8dsY9jZ4jHhQa4A8Zg4A3c3pa
 /XGcO+PCXbtVVUYkruDg4SJO1Y3zHo/9f/Q+yr57kGC8ak6jTd/lm2GLgw9BUP/K
 IWpJnHgrm8F0bIM/GOdT+dI/sjQMlrwXDUJ9sJLya/onO4hOnpCSKI+Wzd94orch
 Ek0xG6WFJ32Qj4dug63M5IJ2h1r34DVYBnA65HL77ZbvTDYVP8f3SievQMArsS47
 juSfEktmkPT+0mgkGo9Dqw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 07 Oct 2026 15:01:49 +0900
Subject: [PATCH 1/2] contrib/plugins/bbv.c: Reject invalid intervals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-bbv-v1-1-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
References: <20261007-bbv-v1-0-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261007-bbv-v1-0-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=jHFs87XFImrn8wvBb3y27oUMigJjUsGayPlhwXLyz0E=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bRB4FcD84aaHWpPbCu+7ghjK14vuyMhyxJCn/vrXrCq
 e17sy+ho5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCJVygx/hZ7qb1zppmFl8/Bz
 ZsnyGNmAWVY3ZqjMOOWnlyBaVrVoJyPDmTdsugZNsxgk/t+cqRd1rLLu0pwVy9Nv3+3WzjuvOP8
 0BwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

g_ascii_strtoull() accepts a leading minus sign, and returns the
negation of the parsed number. It also accepts zero. Reject those
non-positive values since their semantics is unclear.

Also reject interval values with trailing non-digit characters, such as
interval=8a.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 contrib/plugins/bbv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
index 0e6ec673d972..e5caf5d9543b 100644
--- a/contrib/plugins/bbv.c
+++ b/contrib/plugins/bbv.c
@@ -26,7 +26,7 @@ static GHashTable *bbs;
 static GRWLock bbs_lock;
 static char *filename;
 static struct qemu_plugin_scoreboard *vcpus;
-static uint64_t interval = 100000000;
+static int64_t interval = 100000000;
 
 static void plugin_exit(void *p)
 {
@@ -138,7 +138,16 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
         if (g_strcmp0(tokens[0], "interval") == 0) {
-            interval = g_ascii_strtoull(tokens[1], NULL, 10);
+            char *endptr;
+            interval = g_ascii_strtoll(tokens[1], &endptr, 10);
+            if (*endptr) {
+                fprintf(stderr, "malformed integer: %s\n", opt);
+                return -1;
+            }
+            if (interval <= 0) {
+                fprintf(stderr, "unexpected non-positive value: %s\n", opt);
+                return -1;
+            }
         } else if (g_strcmp0(tokens[0], "outfile") == 0) {
             filename = tokens[1];
             tokens[1] = NULL;

-- 
2.55.0


