Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8412E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbhJ-00060a-4o; Tue, 17 Dec 2024 12:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbhH-0005w6-FC
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:27 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbhF-0007k0-Qu
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:27 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B1D71F394;
 Tue, 17 Dec 2024 17:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDNXLW/mAvAkWBwXGLA5DBpSv9PgVohtxtj+AFcrhgI=;
 b=rCqtg6zrfm+ZS/HnWIwOY6IpXR862cLpMGL3qPxx4dtx6ULhm/HHYxU8vMgkfLG8TXCzKm
 o6pf9ESn6PkboOGnN+ua/BMfObcq0E6XpuqIus54gkCSnCekFWf+RQ9PJCFIRcR8f8vsmr
 Mx9iE8qBMhKXLDZOGEy1MlrKesdV6yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDNXLW/mAvAkWBwXGLA5DBpSv9PgVohtxtj+AFcrhgI=;
 b=+Ryds+Gj4gxSKe72wzVvH+Sx2KfAbhn2M4uRAKyX5KSsvaHtcb2m9DGQ9goBgdDJ9tDOJR
 D87SeUYi+VBm4ZCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDNXLW/mAvAkWBwXGLA5DBpSv9PgVohtxtj+AFcrhgI=;
 b=rCqtg6zrfm+ZS/HnWIwOY6IpXR862cLpMGL3qPxx4dtx6ULhm/HHYxU8vMgkfLG8TXCzKm
 o6pf9ESn6PkboOGnN+ua/BMfObcq0E6XpuqIus54gkCSnCekFWf+RQ9PJCFIRcR8f8vsmr
 Mx9iE8qBMhKXLDZOGEy1MlrKesdV6yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDNXLW/mAvAkWBwXGLA5DBpSv9PgVohtxtj+AFcrhgI=;
 b=+Ryds+Gj4gxSKe72wzVvH+Sx2KfAbhn2M4uRAKyX5KSsvaHtcb2m9DGQ9goBgdDJ9tDOJR
 D87SeUYi+VBm4ZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D93213A3C;
 Tue, 17 Dec 2024 17:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8KCXBKO5YWd1TwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 17:49:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PULL 17/17] tests/qtest/migration: Fix compile errors when
 CONFIG_UADK is set
Date: Tue, 17 Dec 2024 14:48:55 -0300
Message-Id: <20241217174855.24971-18-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241217174855.24971-1-farosas@suse.de>
References: <20241217174855.24971-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Removes accidental inclusion of unrelated functions within CONFIG_UADK
as this causes compile errors like:

error: redefinition of ‘migrate_hook_start_xbzrle’

Fixes: 932f74f3fe6e ("tests/qtest/migration: Split compression tests from migration-test.c")
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241217131046.83844-1-shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/compression-tests.c | 54 -----------------------
 1 file changed, 54 deletions(-)

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 6de87bc47d..d78f1f11f1 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -88,59 +88,6 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
     return migrate_hook_start_precopy_tcp_multifd_common(from, to, "uadk");
 }
 
-static void *
-migrate_hook_start_xbzrle(QTestState *from,
-                          QTestState *to)
-{
-    migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
-
-    migrate_set_capability(from, "xbzrle", true);
-    migrate_set_capability(to, "xbzrle", true);
-
-    return NULL;
-}
-
-static void test_precopy_unix_xbzrle(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = uri,
-        .start_hook = migrate_hook_start_xbzrle,
-        .iterations = 2,
-        /*
-         * XBZRLE needs pages to be modified when doing the 2nd+ round
-         * iteration to have real data pushed to the stream.
-         */
-        .live = true,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void *
-migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
-                                            QTestState *to)
-{
-    /*
-     * Overloading this test to also check that set_parameter does not error.
-     * This is also done in the tests for the other compression methods.
-     */
-    migrate_set_parameter_int(from, "multifd-zlib-level", 2);
-    migrate_set_parameter_int(to, "multifd-zlib-level", 2);
-
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zlib");
-}
-
-static void test_multifd_tcp_zlib(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_zlib,
-    };
-    test_precopy_common(&args);
-}
-
 static void test_multifd_tcp_uadk(void)
 {
     MigrateCommon args = {
@@ -151,7 +98,6 @@ static void test_multifd_tcp_uadk(void)
 }
 #endif /* CONFIG_UADK */
 
-
 static void *
 migrate_hook_start_xbzrle(QTestState *from,
                           QTestState *to)
-- 
2.35.3


