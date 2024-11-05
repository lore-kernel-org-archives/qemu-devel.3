Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3721FD3177B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8NzO-0004ob-KD; Tue, 05 Nov 2024 13:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8NzM-0004kS-QK
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:12 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8NzK-0004uY-W0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:12 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C942121DB4;
 Tue,  5 Nov 2024 18:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MY8mRzZ4T3kElvDSWfHPIiJXuXry8bB1PVOWqmz3gro=;
 b=PhgW8pjjRe4lytHQvueRUYso+3o1qiCOl7TvskAz/u5/tOuCvtv8XsZnd5sv52RBxH00k1
 6u/0G+VRDrbQVHUF0/sQQdgd/Wy9JNewalJO5QcB2tHSWX+wu7iI+ITTvOfQyIoMkRknmW
 vtmpmBXJ1xb6ekjNFLZ50xaqPIRV6Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MY8mRzZ4T3kElvDSWfHPIiJXuXry8bB1PVOWqmz3gro=;
 b=uSWOgFCf8s6HBact7X+vUEaRbb6JhrpE4HvMbKlrJgVbJ+h+VxWPXUxi2U9tMnCuWjLo5m
 uVXIkAFFk0v94KBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MY8mRzZ4T3kElvDSWfHPIiJXuXry8bB1PVOWqmz3gro=;
 b=PhgW8pjjRe4lytHQvueRUYso+3o1qiCOl7TvskAz/u5/tOuCvtv8XsZnd5sv52RBxH00k1
 6u/0G+VRDrbQVHUF0/sQQdgd/Wy9JNewalJO5QcB2tHSWX+wu7iI+ITTvOfQyIoMkRknmW
 vtmpmBXJ1xb6ekjNFLZ50xaqPIRV6Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MY8mRzZ4T3kElvDSWfHPIiJXuXry8bB1PVOWqmz3gro=;
 b=uSWOgFCf8s6HBact7X+vUEaRbb6JhrpE4HvMbKlrJgVbJ+h+VxWPXUxi2U9tMnCuWjLo5m
 uVXIkAFFk0v94KBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB63B1394A;
 Tue,  5 Nov 2024 18:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sEI4IENfKmeCZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 18:09:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 08/22] tests/qtest/migration: Move ufd_version_check to utils
Date: Tue,  5 Nov 2024 15:08:23 -0300
Message-Id: <20241105180837.5990-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241105180837.5990-1-farosas@suse.de>
References: <20241105180837.5990-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
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

Move ufd_version_check() to migration-util.c file. This is a helper
function that is used during tests definition so it should be
available outside of migration-test.c

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c           | 47 ++------------------------
 tests/qtest/migration/migration-util.c | 42 +++++++++++++++++++++++
 tests/qtest/migration/migration-util.h | 11 ++++++
 3 files changed, 55 insertions(+), 45 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 308a50a988..825544ba5e 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -34,6 +34,7 @@
 /* For dirty ring test; so far only x86_64 is supported */
 #if defined(__linux__) && defined(HOST_X86_64)
 #include "linux/kvm.h"
+#include <sys/ioctl.h>
 #endif
 
 unsigned start_address;
@@ -87,50 +88,6 @@ typedef enum PostcopyRecoveryFailStage {
 #include <sys/vfs.h>
 #endif
 
-#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
-#include <sys/eventfd.h>
-#include <sys/ioctl.h>
-#include "qemu/userfaultfd.h"
-
-static bool ufd_version_check(void)
-{
-    struct uffdio_api api_struct;
-    uint64_t ioctl_mask;
-
-    int ufd = uffd_open(O_CLOEXEC);
-
-    if (ufd == -1) {
-        g_test_message("Skipping test: userfaultfd not available");
-        return false;
-    }
-
-    api_struct.api = UFFD_API;
-    api_struct.features = 0;
-    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
-        g_test_message("Skipping test: UFFDIO_API failed");
-        return false;
-    }
-    uffd_feature_thread_id = api_struct.features & UFFD_FEATURE_THREAD_ID;
-
-    ioctl_mask = (1ULL << _UFFDIO_REGISTER |
-                  1ULL << _UFFDIO_UNREGISTER);
-    if ((api_struct.ioctls & ioctl_mask) != ioctl_mask) {
-        g_test_message("Skipping test: Missing userfault feature");
-        return false;
-    }
-
-    return true;
-}
-
-#else
-static bool ufd_version_check(void)
-{
-    g_test_message("Skipping test: Userfault not available (builtdtime)");
-    return false;
-}
-
-#endif
-
 static char *tmpfs;
 static char *bootpath;
 
@@ -3522,7 +3479,7 @@ int main(int argc, char **argv)
         return 0;
     }
 
-    has_uffd = ufd_version_check();
+    has_uffd = ufd_version_check(&uffd_feature_thread_id);
     arch = qtest_get_arch();
     is_x86 = !strcmp(arch, "i386") || !strcmp(arch, "x86_64");
 
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 8a974ded22..169b4884e6 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -22,6 +22,13 @@
 #include "migration/bootfile.h"
 #include "migration/migration-util.h"
 
+/* for uffd_version_check() */
+#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
+#include <sys/eventfd.h>
+#include "qemu/userfaultfd.h"
+#endif
+
+
 static char *SocketAddress_to_str(SocketAddress *addr)
 {
     switch (addr->type) {
@@ -283,3 +290,38 @@ bool probe_o_direct_support(const char *tmpfs)
     return true;
 }
 #endif
+
+#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
+bool ufd_version_check(bool *uffd_feature_thread_id)
+{
+    struct uffdio_api api_struct;
+    uint64_t ioctl_mask;
+
+    int ufd = uffd_open(O_CLOEXEC);
+
+    if (ufd == -1) {
+        g_test_message("Skipping test: userfaultfd not available");
+        return false;
+    }
+
+    api_struct.api = UFFD_API;
+    api_struct.features = 0;
+    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
+        g_test_message("Skipping test: UFFDIO_API failed");
+        return false;
+    }
+
+    if (uffd_feature_thread_id) {
+        *uffd_feature_thread_id = api_struct.features & UFFD_FEATURE_THREAD_ID;
+    }
+
+    ioctl_mask = (1ULL << _UFFDIO_REGISTER |
+                  1ULL << _UFFDIO_UNREGISTER);
+    if ((api_struct.ioctls & ioctl_mask) != ioctl_mask) {
+        g_test_message("Skipping test: Missing userfault feature");
+        return false;
+    }
+
+    return true;
+}
+#endif
diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
index d75c5db5f3..f4a1f4750e 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -67,6 +67,17 @@ static inline bool probe_o_direct_support(const char *tmpfs)
     return false;
 }
 #endif
+
+#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
+bool ufd_version_check(bool *uffd_feature_thread_id);
+#else
+static inline bool ufd_version_check(bool *uffd_feature_thread_id)
+{
+    g_test_message("Skipping test: Userfault not available (builtdtime)");
+    return false;
+}
+#endif
+
 void migration_test_add(const char *path, void (*fn)(void));
 char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
-- 
2.35.3


