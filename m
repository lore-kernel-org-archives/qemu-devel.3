Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6BB107BCD6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 18:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w17HH-0007cH-Sh; Fri, 13 Mar 2026 14:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w17Gy-0007bA-VE
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 14:30:12 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w17Gu-0005MI-Qt
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 14:30:07 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 363594D5C0;
 Fri, 13 Mar 2026 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773426603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8aYV04d69RttlCMB/HC3lEliNn1OaKMSDKDMroUX6g=;
 b=U4S0zcjYhi6iec1a2x/JQSzq2KL4Hluihjm3oh7Pi9vYg7RpK6rAMWmWVoHU+R9N9H2phS
 eAsqAkI33b0QjSs/h1xhimPC/w74lI/eCPiNWbme9mLcgejihlVaVOUfCcNEwUdbVQ4h3H
 F5BB6CeIiE/gu6Cff3s0mBxmogpwPag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773426603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8aYV04d69RttlCMB/HC3lEliNn1OaKMSDKDMroUX6g=;
 b=sHrX6LI6etNnZE6DvRmqRsqQu3SKC7HXJsnwpRH02Nb+cWLfzssEfgMMINBsz3yckEP2nE
 MuuGasxQV14RZIDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U4S0zcjY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sHrX6LI6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773426603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8aYV04d69RttlCMB/HC3lEliNn1OaKMSDKDMroUX6g=;
 b=U4S0zcjYhi6iec1a2x/JQSzq2KL4Hluihjm3oh7Pi9vYg7RpK6rAMWmWVoHU+R9N9H2phS
 eAsqAkI33b0QjSs/h1xhimPC/w74lI/eCPiNWbme9mLcgejihlVaVOUfCcNEwUdbVQ4h3H
 F5BB6CeIiE/gu6Cff3s0mBxmogpwPag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773426603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8aYV04d69RttlCMB/HC3lEliNn1OaKMSDKDMroUX6g=;
 b=sHrX6LI6etNnZE6DvRmqRsqQu3SKC7HXJsnwpRH02Nb+cWLfzssEfgMMINBsz3yckEP2nE
 MuuGasxQV14RZIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24FA440678;
 Fri, 13 Mar 2026 18:30:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YMn0NqhXtGn9MwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Mar 2026 18:30:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v1 1/4] tests/qtest: Don't dup machine name in
 qtest_cb_for_every_machine callbacks
Date: Fri, 13 Mar 2026 15:29:53 -0300
Message-ID: <20260313182957.28432-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313182957.28432-1-farosas@suse.de>
References: <20260313182957.28432-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 363594D5C0
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

The qtest_get_machines function caches the list of machines in a
static variable. Dup'ing the machine->name string only serves to leak
that memory when a single test is executed.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/cpu-plug-test.c | 11 +++++------
 tests/qtest/qom-test.c      |  3 +--
 tests/qtest/test-hmp.c      |  3 +--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
index 0aa4ccc5b6..e68f39cf56 100644
--- a/tests/qtest/cpu-plug-test.c
+++ b/tests/qtest/cpu-plug-test.c
@@ -14,7 +14,7 @@
 #include "qobject/qlist.h"
 
 struct PlugTestData {
-    char *machine;
+    const char *machine;
     const char *cpu_model;
     char *device_model;
     unsigned sockets;
@@ -73,7 +73,6 @@ static void test_data_free(gpointer data)
 {
     PlugTestData *pc = data;
 
-    g_free(pc->machine);
     g_free(pc->device_model);
     g_free(pc);
 }
@@ -87,7 +86,7 @@ static void add_pc_test_case(const char *mname)
         return;
     }
     data = g_new(PlugTestData, 1);
-    data->machine = g_strdup(mname);
+    data->machine = mname;
     data->cpu_model = "Haswell"; /* 1.3+ theoretically */
     data->device_model = g_strdup_printf("%s-%s-cpu", data->cpu_model,
                                          qtest_get_arch());
@@ -114,7 +113,7 @@ static void add_pseries_test_case(const char *mname)
         return;
     }
     data = g_new(PlugTestData, 1);
-    data->machine = g_strdup(mname);
+    data->machine = mname;
     data->cpu_model = "power8_v2.0";
     data->device_model = g_strdup("power8_v2.0-spapr-cpu-core");
     data->sockets = 2;
@@ -140,7 +139,7 @@ static void add_s390x_test_case(const char *mname)
     }
 
     data = g_new(PlugTestData, 1);
-    data->machine = g_strdup(mname);
+    data->machine = mname;
     data->cpu_model = "qemu";
     data->device_model = g_strdup("qemu-s390x-cpu");
     data->sockets = 1;
@@ -162,7 +161,7 @@ static void add_loongarch_test_case(const char *mname)
     PlugTestData *data;
 
     data = g_new(PlugTestData, 1);
-    data->machine = g_strdup(mname);
+    data->machine = mname;
     data->cpu_model = "la464";
     data->device_model = g_strdup("la464-loongarch-cpu");
     data->sockets = 1;
diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 2da9918e16..6421f2d9d9 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -216,7 +216,6 @@ static void test_machine(gconstpointer data)
     test_list_get_value(qts);
 
     qtest_quit(qts);
-    g_free((void *)machine);
 }
 
 static void add_machine_test_case(const char *mname)
@@ -224,7 +223,7 @@ static void add_machine_test_case(const char *mname)
     char *path;
 
     path = g_strdup_printf("qom/%s", mname);
-    qtest_add_data_func(path, g_strdup(mname), test_machine);
+    qtest_add_data_func(path, mname, test_machine);
     g_free(path);
 }
 
diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index 1b2e07522f..60f742e83f 100644
--- a/tests/qtest/test-hmp.c
+++ b/tests/qtest/test-hmp.c
@@ -135,7 +135,6 @@ static void test_machine(gconstpointer data)
 
     qtest_quit(qts);
     g_free(args);
-    g_free((void *)data);
 }
 
 static void add_machine_test_case(const char *mname)
@@ -143,7 +142,7 @@ static void add_machine_test_case(const char *mname)
     char *path;
 
     path = g_strdup_printf("hmp/%s", mname);
-    qtest_add_data_func(path, g_strdup(mname), test_machine);
+    qtest_add_data_func(path, mname, test_machine);
     g_free(path);
 }
 
-- 
2.51.0


