Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37785EE49BD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOip-0002Bm-Sd; Wed, 11 Sep 2024 10:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1soOhb-0006WN-4n
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:21 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1soOhV-0007DV-QV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38E6F1FCF7;
 Wed, 11 Sep 2024 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726066328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qhXKdPo3424MLxOaWKsglDufpHH1G47yl+yPikDUnuk=;
 b=Dsmk+BXgsUaa25g5MrUsQV+G5zhw8KSRKEoy3XxZDaYFrfhnPSI13ZFXqmvyXXnkvUzQ5g
 877WVCe4MbF00KaA8Lep0SE0ch68gDOtsv01W9yFOvJm4ED2yU8gv3SFNChbHIMfXPCtTC
 L2zUImsEl++J5CXfGPRvHkIzpDP+RYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726066328;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qhXKdPo3424MLxOaWKsglDufpHH1G47yl+yPikDUnuk=;
 b=KG/vrOJx91uyDub7vAChkUhE8OjpJm+NCKCf0js5Zm9SEmOGJt2JqqXTl0XXp0qrb//27v
 pocLnNteEyJnEHBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dsmk+BXg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="KG/vrOJx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726066328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qhXKdPo3424MLxOaWKsglDufpHH1G47yl+yPikDUnuk=;
 b=Dsmk+BXgsUaa25g5MrUsQV+G5zhw8KSRKEoy3XxZDaYFrfhnPSI13ZFXqmvyXXnkvUzQ5g
 877WVCe4MbF00KaA8Lep0SE0ch68gDOtsv01W9yFOvJm4ED2yU8gv3SFNChbHIMfXPCtTC
 L2zUImsEl++J5CXfGPRvHkIzpDP+RYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726066328;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qhXKdPo3424MLxOaWKsglDufpHH1G47yl+yPikDUnuk=;
 b=KG/vrOJx91uyDub7vAChkUhE8OjpJm+NCKCf0js5Zm9SEmOGJt2JqqXTl0XXp0qrb//27v
 pocLnNteEyJnEHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 407F7132CB;
 Wed, 11 Sep 2024 14:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CttAApeu4WZ4YQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Sep 2024 14:52:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH] tests/qtest/migration: Move a couple of slow tests under
 g_test_slow
Date: Wed, 11 Sep 2024 11:52:04 -0300
Message-Id: <20240911145204.17692-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38E6F1FCF7
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The xbzrel and vcpu_dirty_limit are the two slowest tests from
migration-test. Move them under g_test_slow() to save about 40s per
run.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d6768d5d71..814ec109a6 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3803,8 +3803,10 @@ int main(int argc, char **argv)
 
     migration_test_add("/migration/precopy/unix/plain",
                        test_precopy_unix_plain);
-    migration_test_add("/migration/precopy/unix/xbzrle",
-                       test_precopy_unix_xbzrle);
+    if (g_test_slow()) {
+        migration_test_add("/migration/precopy/unix/xbzrle",
+                           test_precopy_unix_xbzrle);
+    }
     migration_test_add("/migration/precopy/file",
                        test_precopy_file);
     migration_test_add("/migration/precopy/file/offset",
@@ -3979,7 +3981,7 @@ int main(int argc, char **argv)
     if (g_str_equal(arch, "x86_64") && has_kvm && kvm_dirty_ring_supported()) {
         migration_test_add("/migration/dirty_ring",
                            test_precopy_unix_dirty_ring);
-        if (qtest_has_machine("pc")) {
+        if (qtest_has_machine("pc") && g_test_slow()) {
             migration_test_add("/migration/vcpu_dirty_limit",
                                test_vcpu_dirty_limit);
         }
-- 
2.35.3


