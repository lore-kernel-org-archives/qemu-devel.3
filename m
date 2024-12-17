Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F72E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 21:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNf1F-0007oo-3G; Tue, 17 Dec 2024 16:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNf1B-0007oZ-I5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:22:14 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNf17-00038b-Fj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:22:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B9C921158;
 Tue, 17 Dec 2024 21:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734470525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dM9ds9TSRiG2F28y/QlI7ars7QcNscdI6p6B7V2aXAE=;
 b=RXLpydTUkUZK7Bwtt8YMJ4biHeguCdeIkrOSgj2GXqP5PELYCmQmYefb94aYr3C6L11T49
 3C0lyEI+E5eVWb0ditidSrIKfuwyYE+Bu5QyuYzj3Bxz6iA0gU/dH8JqUnZEL/ZTtxkPuX
 ryukBRj95v4vscZbblzNBIPCO59PdXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734470525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dM9ds9TSRiG2F28y/QlI7ars7QcNscdI6p6B7V2aXAE=;
 b=n6Xu3VtpxkYLb0oqTaPnEu9gSr1Uo5jYIMnk7EHoNlqrdvovqb9jRGIu2oSmHjWlj/wmDx
 nRcwCR9fNWrC40Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RXLpydTU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n6Xu3Vtp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734470525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dM9ds9TSRiG2F28y/QlI7ars7QcNscdI6p6B7V2aXAE=;
 b=RXLpydTUkUZK7Bwtt8YMJ4biHeguCdeIkrOSgj2GXqP5PELYCmQmYefb94aYr3C6L11T49
 3C0lyEI+E5eVWb0ditidSrIKfuwyYE+Bu5QyuYzj3Bxz6iA0gU/dH8JqUnZEL/ZTtxkPuX
 ryukBRj95v4vscZbblzNBIPCO59PdXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734470525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dM9ds9TSRiG2F28y/QlI7ars7QcNscdI6p6B7V2aXAE=;
 b=n6Xu3VtpxkYLb0oqTaPnEu9gSr1Uo5jYIMnk7EHoNlqrdvovqb9jRGIu2oSmHjWlj/wmDx
 nRcwCR9fNWrC40Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3121B132EA;
 Tue, 17 Dec 2024 21:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q0xYOXvrYWeeCgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 21:22:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH] tests/qtest/migration: Restore include for postcopy
Date: Tue, 17 Dec 2024 18:22:01 -0300
Message-Id: <20241217212201.23376-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2B9C921158
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Commit 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to
utils") moved the ufd_version_check() function to another file but
failed to bring along the <sys/syscall> include, which is necessary to
pull in <asm/unistd.h> for __NR_userfaultd.

Restore the missing include.

While here, remove the ifdef __linux__ that's redundant and fix a
couple of typos.

Fixes: 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to utils")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/migration-util.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 525bf1eed4..d18841e357 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -22,8 +22,12 @@
 #include "migration/bootfile.h"
 #include "migration/migration-util.h"
 
-/* for uffd_version_check() */
-#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
+#if defined(__linux__)
+#include <sys/syscall.h>
+#endif
+
+/* for ufd_version_check() */
+#if defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
 #include <sys/eventfd.h>
 #include "qemu/userfaultfd.h"
 #endif
@@ -297,7 +301,7 @@ bool probe_o_direct_support(const char *tmpfs)
 }
 #endif
 
-#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
+#if defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
 bool ufd_version_check(bool *uffd_feature_thread_id)
 {
     struct uffdio_api api_struct;
@@ -333,7 +337,7 @@ bool ufd_version_check(bool *uffd_feature_thread_id)
 #else
 bool ufd_version_check(bool *uffd_feature_thread_id)
 {
-    g_test_message("Skipping test: Userfault not available (builtdtime)");
+    g_test_message("Skipping test: Userfault not available (buildtime)");
     return false;
 }
 #endif
-- 
2.35.3


