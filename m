Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7014EC5B549
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 01:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGcR-0007G7-K5; Mon, 02 Jun 2025 21:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcQ-00079b-Dy
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:39:10 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcO-0001aF-IM
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:39:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB6BF218E0;
 Tue,  3 Jun 2025 01:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lrSuRRehGrtYStPZqJ9prQPWAOWCGp846AmysDb8II=;
 b=yjk5GCl3Rq7DIAYqW/BOjLZWs96h1qs3aoQ5Psyw4hofbbDnhtQK8hSRqx25X4GCQCqphm
 z/pM/PAQTR2nliE76ZgKBZqxI+GeQuESeV3Y4NT7r0iGEZWrk243P0j1+TP/B2UJ3mZDMb
 zbf7VBEVROb9hJL2akpQ4lk+jPGhU8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lrSuRRehGrtYStPZqJ9prQPWAOWCGp846AmysDb8II=;
 b=8fhAUTTr7/+5GPu3eg6y88AQj5vBAiqQ1ip05pBvF0FyXO8Mp37SzdWfph1FlVnEyYCYP1
 XXq4PaOulg2aZcDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lrSuRRehGrtYStPZqJ9prQPWAOWCGp846AmysDb8II=;
 b=yjk5GCl3Rq7DIAYqW/BOjLZWs96h1qs3aoQ5Psyw4hofbbDnhtQK8hSRqx25X4GCQCqphm
 z/pM/PAQTR2nliE76ZgKBZqxI+GeQuESeV3Y4NT7r0iGEZWrk243P0j1+TP/B2UJ3mZDMb
 zbf7VBEVROb9hJL2akpQ4lk+jPGhU8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lrSuRRehGrtYStPZqJ9prQPWAOWCGp846AmysDb8II=;
 b=8fhAUTTr7/+5GPu3eg6y88AQj5vBAiqQ1ip05pBvF0FyXO8Mp37SzdWfph1FlVnEyYCYP1
 XXq4PaOulg2aZcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A53213700;
 Tue,  3 Jun 2025 01:38:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AMLjNi1SPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 20/21] libqtest: Add a function to check whether a QMP command
 supports a feature
Date: Mon,  2 Jun 2025 22:38:09 -0300
Message-Id: <20250603013810.4772-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.h | 12 ++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 94526b7f9c..7ee4831841 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -34,6 +34,9 @@
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "qapi/qapi-visit-introspect.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
@@ -2091,3 +2094,42 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
 
     return ret && !err;
 }
+
+bool qtest_qmp_cmd_has_feature(QTestState *qts, const char *cmd,
+                               const char *feature)
+{
+    QDict *resp;
+    Visitor *qiv;
+    SchemaInfoList *tail;
+    SchemaInfo *si;
+    strList *str;
+
+    resp = qtest_qmp(qts, "{ 'execute': 'query-qmp-schema' }");
+
+    qiv = qobject_input_visitor_new(qdict_get(resp, "return"));
+    visit_type_SchemaInfoList(qiv, NULL, &tail, &error_abort);
+    visit_free(qiv);
+    qobject_unref(resp);
+
+    for (; tail; tail = tail->next) {
+        si = tail->value;
+
+        if (si->meta_type != SCHEMA_META_TYPE_COMMAND) {
+            continue;
+        }
+
+        if (g_str_equal(si->name, cmd)) {
+            break;
+        }
+    }
+
+    if (tail && si->has_features) {
+        for (str = si->features; str; str = str->next) {
+            if (g_str_equal(str->value, feature)) {
+                return true;
+            }
+        }
+    }
+
+    return false;
+}
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index b3f2e7fbef..c609316223 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -1153,4 +1153,16 @@ bool have_qemu_img(void);
  */
 bool mkimg(const char *file, const char *fmt, unsigned size_mb);
 
+/**
+ * qtest_qmp_cmd_has_feature:
+ * @qts: QTestState instance
+ * @cmd: The QMP command being introspected
+ * @feature: Name of the feature to be checked
+ *
+ * Returns: true if the QMP command @cmd supports @feature, false otherwise.
+ */
+bool qtest_qmp_cmd_has_feature(QTestState *qts, const char *cmd,
+                               const char *feature);
+
+
 #endif
-- 
2.35.3


