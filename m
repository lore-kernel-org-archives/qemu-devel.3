Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3D8CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIMI-00007i-BJ; Tue, 05 May 2026 12:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIMD-0008VS-Re
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:10:51 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIMC-0000ur-2h
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:10:49 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE7DE6B768;
 Tue,  5 May 2026 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwwElCK9k5QjFlI9gwF3UliZW/jwsyovdsQXl4dDoH4=;
 b=VouiTrpDBYh4VeQ8kTouULVnu5o0T+BMj6okkBxg4JwYOrWkfmlTxAWzwApOfKVLd7N5Xu
 16/LdvcmYOPfyVjhMsVOhviZMjZtNq8E+hz9JGSqdKvhqG6QWQOvzRbnrln1d7Al4WY5Q5
 RtIRRs6zDFyZYjfXUvSNF1nxw0KuJeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997381;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwwElCK9k5QjFlI9gwF3UliZW/jwsyovdsQXl4dDoH4=;
 b=NY0kqIOoN23b6D2ESE5/f/X6psUEm69kOdnAsqj1i5jPg2qIPf0CfkMAvAxn/+TwYIPvEF
 q5RPJH6ikBgFSgAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwwElCK9k5QjFlI9gwF3UliZW/jwsyovdsQXl4dDoH4=;
 b=nF25N6Gb6UerP3kmxCGfe3ZlVj8STI9RugfyesZC7plG0ApA1vK9MAqIeVwDYulKjj2JR8
 xQbtCIIJs6X0isVgvhUGZ/VoCjhxz/FiIOh/QdU1qPTs8ibOq1QIhTfELO79pwtzuD9ZpE
 mVSP5lIV0+LFGiAko0WyEMGukaTyQR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwwElCK9k5QjFlI9gwF3UliZW/jwsyovdsQXl4dDoH4=;
 b=hEiVQAbmVNJn3TNIe43yZlSowyb1iCLY62mT7d+LOiJPwDWdfa3yT5IIBnmXfpJtarLlMN
 jXw9RZLCoCBf2FBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F317593A3;
 Tue,  5 May 2026 16:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qATuD0MW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 11/15] tests/qtest/migration: Use defer for cpr-tests
Date: Tue,  5 May 2026 13:09:10 -0300
Message-ID: <20260505160915.25558-12-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505160915.25558-1-farosas@suse.de>
References: <20260505160915.25558-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/cpr-tests.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 18217f0460..9091a84213 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -60,7 +60,7 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
     obj = migrate_str_to_channel(cpr_channel);
     qlist_append(channels_list, obj);
 
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
 
@@ -128,11 +128,17 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
     int cpr_sockfd = qtest_socket_server(cpr_path);
     g_assert(cpr_sockfd >= 0);
 
-    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
-                                  "addr.type=fd,addr.str=%d %s",
-                                  cpr_sockfd, opts);
+    if (incoming_defer) {
+        opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
+                                      "addr.type=fd,addr.str=%d %s",
+                                      cpr_sockfd, opts);
+    } else {
+        opts_target = g_strdup_printf("-incoming %s "
+                                      "-incoming cpr,addr.transport=socket,"
+                                      "addr.type=fd,addr.str=%d %s",
+                                      uri, cpr_sockfd, opts);
+    }
 
-    args->listen_uri = incoming_defer ? "defer" : uri;
     args->connect_channels = connect_channels;
 
     args->start.opts_source = opts;
@@ -224,7 +230,7 @@ static void test_cpr_exec(MigrateCommon *args)
     g_autofree char *filename = g_strdup_printf("%s/%s", tmpfs,
                                                 FILE_TEST_FILENAME);
 
-    if (migrate_start(&from, NULL, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, NULL, "defer", &args->start)) {
         return;
     }
 
@@ -274,10 +280,7 @@ static void test_mode_exec(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
-    g_autofree char *listen_uri = g_strdup_printf("defer");
-
     args->connect_uri = uri;
-    args->listen_uri = listen_uri;
     args->start_hook = test_mode_exec_start;
 
     args->start.only_source = true;
-- 
2.51.0


