Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18591D637AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJKR-0006Mu-0Z; Wed, 13 Nov 2024 14:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKO-0006M5-Cn
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:00 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKM-00039y-PN
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 70B0921111;
 Wed, 13 Nov 2024 19:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgzxzJW2k0ItqUufPNFe8H+no2797FJ0300sgh6S9Tg=;
 b=sSESzutUrzgYb3APdfSUIDe5tkQH3ohAGLGP7rcGFM1SCDGauaunzylIMghwRBJM/ZR1U3
 02M/qHiNQFVMYG0oO18o6mifwKLyepxg9IChj+N5qijghm/czKnFHyJP8vypqrOOYBf1+B
 R/FmGsi3u+OylnvZBtcQZ52kUshFSic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527216;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgzxzJW2k0ItqUufPNFe8H+no2797FJ0300sgh6S9Tg=;
 b=Y2npxEfie8/LQYwVZgyvCvmhCbgzCDa6FluWNA9YUmlLPDM/wGOXX45orZiGev0s3rcONl
 RH3HGgk/i3wWgSBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sSESzutU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y2npxEfi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgzxzJW2k0ItqUufPNFe8H+no2797FJ0300sgh6S9Tg=;
 b=sSESzutUrzgYb3APdfSUIDe5tkQH3ohAGLGP7rcGFM1SCDGauaunzylIMghwRBJM/ZR1U3
 02M/qHiNQFVMYG0oO18o6mifwKLyepxg9IChj+N5qijghm/czKnFHyJP8vypqrOOYBf1+B
 R/FmGsi3u+OylnvZBtcQZ52kUshFSic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527216;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgzxzJW2k0ItqUufPNFe8H+no2797FJ0300sgh6S9Tg=;
 b=Y2npxEfie8/LQYwVZgyvCvmhCbgzCDa6FluWNA9YUmlLPDM/wGOXX45orZiGev0s3rcONl
 RH3HGgk/i3wWgSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51F5613301;
 Wed, 13 Nov 2024 19:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OLxGBi4CNWfLcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 19:46:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 09/22] tests/qtest/migration: Move kvm_dirty_ring_supported
 to utils
Date: Wed, 13 Nov 2024 16:46:17 -0300
Message-Id: <20241113194630.3385-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241113194630.3385-1-farosas@suse.de>
References: <20241113194630.3385-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 70B0921111
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RL6tyf6sue6knz55rs3us8rsc3)];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Move kvm_dirty_ring_supported() to migration-util.c. Similarly to
ufd_version_check(), this function is used during test definition so
put it in the utils file.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c           | 29 --------------------------
 tests/qtest/migration/migration-util.c | 29 ++++++++++++++++++++++++++
 tests/qtest/migration/migration-util.h |  1 +
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 40e11e2af0..01ef0014bd 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -32,12 +32,6 @@
 # endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-/* For dirty ring test; so far only x86_64 is supported */
-#if defined(__linux__) && defined(HOST_X86_64)
-#include "linux/kvm.h"
-#include <sys/ioctl.h>
-#endif
-
 unsigned start_address;
 unsigned end_address;
 static bool uffd_feature_thread_id;
@@ -3430,29 +3424,6 @@ static void test_dirty_limit(void)
     migrate_end(from, to, true);
 }
 
-static bool kvm_dirty_ring_supported(void)
-{
-#if defined(__linux__) && defined(HOST_X86_64)
-    int ret, kvm_fd = open("/dev/kvm", O_RDONLY);
-
-    if (kvm_fd < 0) {
-        return false;
-    }
-
-    ret = ioctl(kvm_fd, KVM_CHECK_EXTENSION, KVM_CAP_DIRTY_LOG_RING);
-    close(kvm_fd);
-
-    /* We test with 4096 slots */
-    if (ret < 4096) {
-        return false;
-    }
-
-    return true;
-#else
-    return false;
-#endif
-}
-
 int main(int argc, char **argv)
 {
     bool has_kvm, has_tcg;
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 2ff8870fd5..525bf1eed4 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -28,6 +28,12 @@
 #include "qemu/userfaultfd.h"
 #endif
 
+/* For dirty ring test; so far only x86_64 is supported */
+#if defined(__linux__) && defined(HOST_X86_64)
+#include "linux/kvm.h"
+#include <sys/ioctl.h>
+#endif
+
 
 static char *SocketAddress_to_str(SocketAddress *addr)
 {
@@ -331,3 +337,26 @@ bool ufd_version_check(bool *uffd_feature_thread_id)
     return false;
 }
 #endif
+
+bool kvm_dirty_ring_supported(void)
+{
+#if defined(__linux__) && defined(HOST_X86_64)
+    int ret, kvm_fd = open("/dev/kvm", O_RDONLY);
+
+    if (kvm_fd < 0) {
+        return false;
+    }
+
+    ret = ioctl(kvm_fd, KVM_CHECK_EXTENSION, KVM_CAP_DIRTY_LOG_RING);
+    close(kvm_fd);
+
+    /* We test with 4096 slots */
+    if (ret < 4096) {
+        return false;
+    }
+
+    return true;
+#else
+    return false;
+#endif
+}
diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
index e6bfd25244..9127702e70 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -52,6 +52,7 @@ static inline bool probe_o_direct_support(const char *tmpfs)
 #endif
 
 bool ufd_version_check(bool *uffd_feature_thread_id);
+bool kvm_dirty_ring_supported(void);
 void migration_test_add(const char *path, void (*fn)(void));
 char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
-- 
2.35.3


