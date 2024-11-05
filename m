Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D596D31778
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8NzR-0004rk-EL; Tue, 05 Nov 2024 13:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8NzP-0004pu-7h
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:15 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8NzN-0004uz-I4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5EED221D3A;
 Tue,  5 Nov 2024 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI6oC7MY3GyCX4YLArnLjHfH9QMj8sx2gIkx5b3xbis=;
 b=Huf5y/xmOnkK25QbjroZ5uiAoiXphVliW3Ql31xGZiArpktQslLnQmCpCe+47DbdBdq+ou
 y+XRwbRmUS0dm1dJzLdYWxvSOkUnSg6GdBYEkhDPFbdMEiAMWKDCWb59r06D7hzOo2g/dT
 53wHqx2Nw+EZCVQprnIHMAspRKIt22k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI6oC7MY3GyCX4YLArnLjHfH9QMj8sx2gIkx5b3xbis=;
 b=iTJWVixZ1zFbqubns7k8qeSXo6kNNjCG7Vt0zYS3H+zazmG/BLTuc/UdcBjkeu2S7Oj1sh
 rt8aG/FQ9Nw6m1CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Huf5y/xm";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iTJWVixZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI6oC7MY3GyCX4YLArnLjHfH9QMj8sx2gIkx5b3xbis=;
 b=Huf5y/xmOnkK25QbjroZ5uiAoiXphVliW3Ql31xGZiArpktQslLnQmCpCe+47DbdBdq+ou
 y+XRwbRmUS0dm1dJzLdYWxvSOkUnSg6GdBYEkhDPFbdMEiAMWKDCWb59r06D7hzOo2g/dT
 53wHqx2Nw+EZCVQprnIHMAspRKIt22k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI6oC7MY3GyCX4YLArnLjHfH9QMj8sx2gIkx5b3xbis=;
 b=iTJWVixZ1zFbqubns7k8qeSXo6kNNjCG7Vt0zYS3H+zazmG/BLTuc/UdcBjkeu2S7Oj1sh
 rt8aG/FQ9Nw6m1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49CD31394A;
 Tue,  5 Nov 2024 18:09:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6EOEBEZfKmeCZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 18:09:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 09/22] tests/qtest/migration: Move kvm_dirty_ring_supported to
 utils
Date: Tue,  5 Nov 2024 15:08:24 -0300
Message-Id: <20241105180837.5990-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241105180837.5990-1-farosas@suse.de>
References: <20241105180837.5990-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5EED221D3A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL6tyf6sue6knz55rs3us8rsc3)];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
 tests/qtest/migration/migration-util.h |  2 ++
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 825544ba5e..30b833e082 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -31,12 +31,6 @@
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
@@ -3425,29 +3419,6 @@ static void test_dirty_limit(void)
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
index 169b4884e6..858a6c9830 100644
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
@@ -325,3 +331,26 @@ bool ufd_version_check(bool *uffd_feature_thread_id)
     return true;
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
index f4a1f4750e..ef94a6be02 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -78,6 +78,8 @@ static inline bool ufd_version_check(bool *uffd_feature_thread_id)
 }
 #endif
 
+bool kvm_dirty_ring_supported(void);
+
 void migration_test_add(const char *path, void (*fn)(void));
 char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
-- 
2.35.3


