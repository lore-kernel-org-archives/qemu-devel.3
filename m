Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6149CD6ACFD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 18:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGMn4-0006a0-Gk; Wed, 27 Nov 2024 13:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGMn0-0006Z7-0c
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:29:27 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGMmx-0001vb-AS
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:29:24 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 25B5D21187;
 Wed, 27 Nov 2024 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732732162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quO3/H7CjTQ2qCjHsWFhzpb47Y9iUGcaxbfKGH7gc0k=;
 b=p8VNAuyadXMxp6ZcF/gT3rXG+CkpsYPA2u+fKPkEYrVI4+fuqzqmdaa9GjzuL7J8IIzC/f
 Boe7v3tjvvJXu3p/UKQaENnZz7/oSZz1VUK1xhnB6cGcQUnMZv4z7g81dxrmWOrm2NRQry
 NS3XJ0s+x8lwhuAJl9I1fH91nHkThNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732732162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quO3/H7CjTQ2qCjHsWFhzpb47Y9iUGcaxbfKGH7gc0k=;
 b=cP4Bw8j244NigfHRfm1sCUh/n6qCzFZqgWnbY45wpGhPCySkd51fLVCJJjEq3kCk8AYFHT
 3oLoJAvswbUaPLBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732732162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quO3/H7CjTQ2qCjHsWFhzpb47Y9iUGcaxbfKGH7gc0k=;
 b=p8VNAuyadXMxp6ZcF/gT3rXG+CkpsYPA2u+fKPkEYrVI4+fuqzqmdaa9GjzuL7J8IIzC/f
 Boe7v3tjvvJXu3p/UKQaENnZz7/oSZz1VUK1xhnB6cGcQUnMZv4z7g81dxrmWOrm2NRQry
 NS3XJ0s+x8lwhuAJl9I1fH91nHkThNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732732162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quO3/H7CjTQ2qCjHsWFhzpb47Y9iUGcaxbfKGH7gc0k=;
 b=cP4Bw8j244NigfHRfm1sCUh/n6qCzFZqgWnbY45wpGhPCySkd51fLVCJJjEq3kCk8AYFHT
 3oLoJAvswbUaPLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 585C813941;
 Wed, 27 Nov 2024 18:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cIjSBwBlR2faYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 27 Nov 2024 18:29:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 08/17] tests/qtest/migration: Move kvm_dirty_ring_supported
 to utils
Date: Wed, 27 Nov 2024 15:28:52 -0300
Message-Id: <20241127182901.529-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241127182901.529-1-farosas@suse.de>
References: <20241127182901.529-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.948];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

Move kvm_dirty_ring_supported() to migration-util.c. Similarly to
ufd_version_check(), this function is used during test definition so
put it in the utils file.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c           | 29 --------------------------
 tests/qtest/migration/migration-util.c | 29 ++++++++++++++++++++++++++
 tests/qtest/migration/migration-util.h |  1 +
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f1c1ca309a..ab7cbb8251 100644
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
@@ -3435,29 +3429,6 @@ static void test_dirty_limit(void)
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
index 2ab22e3fd5..f5f2e4650e 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -49,6 +49,7 @@ static inline bool probe_o_direct_support(const char *tmpfs)
 #endif
 
 bool ufd_version_check(bool *uffd_feature_thread_id);
+bool kvm_dirty_ring_supported(void);
 void migration_test_add(const char *path, void (*fn)(void));
 char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
-- 
2.35.3


