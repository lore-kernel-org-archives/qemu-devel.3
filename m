Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D57CE7A9D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 21:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smJdm-00052i-7V; Thu, 05 Sep 2024 17:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1smJdj-0004yr-Q0
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 17:03:39 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1smJdi-0007JE-8B
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 17:03:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 356AA1F839;
 Thu,  5 Sep 2024 21:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725570216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdFtZ5F+CiHSePywqi0wvVw9JBYR0I/q11G8bwd7b5M=;
 b=sXTBdobNebcvCQo6H76j234zo5QyHIkl6NA2wA0J85SDymNSLz5VnTVKqAlkolDEpoqz2V
 1CEcwZeIrzqTd41wbddOvvquAWLBKSZ4D+a33ZZDBLijTjma/NG/3dWv5uCr+Zx0Hw9bHl
 eAbMgXqOtUk8wlvXB4X1IN2WzEh/UeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725570216;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdFtZ5F+CiHSePywqi0wvVw9JBYR0I/q11G8bwd7b5M=;
 b=c09G6VF+ZKssPyIeFLsV+vKac2IbGf8l1NGrX5wzuVE5olx2CHJ7ajs4kAH+oSINRJudny
 6KnYREbyeAmYWSAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725570216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdFtZ5F+CiHSePywqi0wvVw9JBYR0I/q11G8bwd7b5M=;
 b=sXTBdobNebcvCQo6H76j234zo5QyHIkl6NA2wA0J85SDymNSLz5VnTVKqAlkolDEpoqz2V
 1CEcwZeIrzqTd41wbddOvvquAWLBKSZ4D+a33ZZDBLijTjma/NG/3dWv5uCr+Zx0Hw9bHl
 eAbMgXqOtUk8wlvXB4X1IN2WzEh/UeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725570216;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdFtZ5F+CiHSePywqi0wvVw9JBYR0I/q11G8bwd7b5M=;
 b=c09G6VF+ZKssPyIeFLsV+vKac2IbGf8l1NGrX5wzuVE5olx2CHJ7ajs4kAH+oSINRJudny
 6KnYREbyeAmYWSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9276139D2;
 Thu,  5 Sep 2024 21:03:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SAzRG6Uc2mYcBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 05 Sep 2024 21:03:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 1/2] tests/qtest: Mute QEMU stderr
Date: Thu,  5 Sep 2024 18:03:27 -0300
Message-Id: <20240905210328.25393-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240905210328.25393-1-farosas@suse.de>
References: <20240905210328.25393-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,gmail.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Make QEMU stderr conditional on the QTEST_LOG variable.

For the /x86/cpuid/parsing-plus-minus test, which traps the stderr, to
continue working set the QTEST_LOG variable from inside the
subprocess.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c              | 6 ++++--
 tests/qtest/test-x86-cpuid-compat.c | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 1326e34291..347664cea6 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -476,11 +476,13 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
                          "-display none "
                          "-audio none "
                          "%s"
-                         " -accel qtest",
+                         " -accel qtest"
+                         " 2> %s",
                          socket_path,
                          getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
                          qmp_socket_path,
-                         extra_args ?: "");
+                         extra_args ?: "",
+                         getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL);
 
     qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
     qtest_client_set_tx_handler(s, qtest_client_socket_send);
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index b9e7e5ef7b..641d1f8740 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -204,6 +204,9 @@ static void test_plus_minus_subprocess(void)
         return;
     }
 
+    const char *log = g_getenv("QTEST_LOG");
+    g_setenv("QTEST_LOG", "1", true);
+
     /* Rules:
      * 1)"-foo" overrides "+foo"
      * 2) "[+-]foo" overrides "foo=..."
@@ -227,6 +230,9 @@ static void test_plus_minus_subprocess(void)
     g_assert_true(qom_get_bool(path, "sse4-2"));
     g_assert_true(qom_get_bool(path, "sse4.2"));
 
+    if (log) {
+        g_setenv("QTEST_LOG", log, true);
+    }
     qtest_end();
     g_free(path);
 }
-- 
2.35.3


