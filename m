Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE8FC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezne-0006DS-I0; Mon, 03 Feb 2025 11:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1teznc-0006D3-Ki
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:59:52 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tezna-0001OG-VB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:59:52 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A29C82115B;
 Mon,  3 Feb 2025 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738601989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwwlVs98Dy6PJeNVxxIIwQOS72rHLpt5ESIJP8J3POc=;
 b=hfThKutLSqxoHwAbf6KvU8wz88p2r3z1FeeiC1TThoWacN1tL2SPHY58nnYnlDMujpzsiV
 9/LQOlhqczClWcCDnHdrejewkPa7w1ebmBqjAOwmm58pPejktYF2Bf4S9K8MEa7zlccsaV
 cyhcoJDU2mJuUpl3TqwhwGipTUmqlf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738601989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwwlVs98Dy6PJeNVxxIIwQOS72rHLpt5ESIJP8J3POc=;
 b=Wt+QyvXlneL3BZdrhKChnWpJm8yUp+NFGWhykuvuNqbY8zQEpz929C+0nqQb9W6vKFsCjm
 8HJVyhcw0TZIZhCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738601989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwwlVs98Dy6PJeNVxxIIwQOS72rHLpt5ESIJP8J3POc=;
 b=hfThKutLSqxoHwAbf6KvU8wz88p2r3z1FeeiC1TThoWacN1tL2SPHY58nnYnlDMujpzsiV
 9/LQOlhqczClWcCDnHdrejewkPa7w1ebmBqjAOwmm58pPejktYF2Bf4S9K8MEa7zlccsaV
 cyhcoJDU2mJuUpl3TqwhwGipTUmqlf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738601989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwwlVs98Dy6PJeNVxxIIwQOS72rHLpt5ESIJP8J3POc=;
 b=Wt+QyvXlneL3BZdrhKChnWpJm8yUp+NFGWhykuvuNqbY8zQEpz929C+0nqQb9W6vKFsCjm
 8HJVyhcw0TZIZhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C15513A78;
 Mon,  3 Feb 2025 16:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uM/pLgP2oGfDdgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 03 Feb 2025 16:59:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 4/6] tests/qtest: Extract qtest_qom_has_concrete_type() helper
Date: Mon,  3 Feb 2025 13:59:36 -0300
Message-Id: <20250203165938.14320-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250203165938.14320-1-farosas@suse.de>
References: <20250203165938.14320-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Extract qtest_qom_has_concrete_type() out of qtest_has_device()
in order to re-use it in the following commit.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250130103728.536-2-philmd@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 89 ++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 38 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 437b24fa2e..f416cf8a59 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1011,6 +1011,56 @@ const char *qtest_get_arch(void)
     return end + 1;
 }
 
+static bool qtest_qom_has_concrete_type(const char *parent_typename,
+                                        const char *child_typename,
+                                        QList **cached_list)
+{
+    QList *list = cached_list ? *cached_list : NULL;
+    const QListEntry *p;
+    QObject *qobj;
+    QString *qstr;
+    QDict *devinfo;
+    int idx;
+
+    if (!list) {
+        QDict *resp;
+        QDict *args;
+        QTestState *qts = qtest_init("-machine none");
+
+        args = qdict_new();
+        qdict_put_bool(args, "abstract", false);
+        qdict_put_str(args, "implements", parent_typename);
+
+        resp = qtest_qmp(qts, "{'execute': 'qom-list-types', 'arguments': %p }",
+                         args);
+        g_assert(qdict_haskey(resp, "return"));
+        list = qdict_get_qlist(resp, "return");
+        qobject_ref(list);
+        qobject_unref(resp);
+
+        qtest_quit(qts);
+
+        if (cached_list) {
+            *cached_list = list;
+        }
+    }
+
+    for (p = qlist_first(list), idx = 0; p; p = qlist_next(p), idx++) {
+        devinfo = qobject_to(QDict, qlist_entry_obj(p));
+        g_assert(devinfo);
+
+        qobj = qdict_get(devinfo, "name");
+        g_assert(qobj);
+        qstr = qobject_to(QString, qobj);
+        g_assert(qstr);
+        if (g_str_equal(qstring_get_str(qstr), child_typename)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 bool qtest_has_accel(const char *accel_name)
 {
     if (g_str_equal(accel_name, "tcg")) {
@@ -1790,45 +1840,8 @@ bool qtest_has_machine(const char *machine)
 bool qtest_has_device(const char *device)
 {
     static QList *list;
-    const QListEntry *p;
-    QObject *qobj;
-    QString *qstr;
-    QDict *devinfo;
-    int idx;
 
-    if (!list) {
-        QDict *resp;
-        QDict *args;
-        QTestState *qts = qtest_init("-machine none");
-
-        args = qdict_new();
-        qdict_put_bool(args, "abstract", false);
-        qdict_put_str(args, "implements", "device");
-
-        resp = qtest_qmp(qts, "{'execute': 'qom-list-types', 'arguments': %p }",
-                         args);
-        g_assert(qdict_haskey(resp, "return"));
-        list = qdict_get_qlist(resp, "return");
-        qobject_ref(list);
-        qobject_unref(resp);
-
-        qtest_quit(qts);
-    }
-
-    for (p = qlist_first(list), idx = 0; p; p = qlist_next(p), idx++) {
-        devinfo = qobject_to(QDict, qlist_entry_obj(p));
-        g_assert(devinfo);
-
-        qobj = qdict_get(devinfo, "name");
-        g_assert(qobj);
-        qstr = qobject_to(QString, qobj);
-        g_assert(qstr);
-        if (g_str_equal(qstring_get_str(qstr), device)) {
-            return true;
-        }
-    }
-
-    return false;
+    return qtest_qom_has_concrete_type("device", device, &list);
 }
 
 /*
-- 
2.35.3


