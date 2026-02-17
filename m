Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33C0E909CF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNkt-0004Q4-L0; Tue, 17 Feb 2026 11:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNka-0004D2-FZ
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:36 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkX-0003Hb-Br
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:34 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB9CB3E733;
 Tue, 17 Feb 2026 16:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eb9c4CVgvWkRUSSB4xutPyPwhjFtQapblTL73fb57/U=;
 b=EXTvoSiz5QJkfGh+U3CuFdHlyLP5BaW4zgidMP9b9NbC2+4BjGLWjpZ8+p0rYScf0Nf6dl
 fB/0FPQoh0FLVOQulwAk7oFdkaj5hMIXnHz/07xuZa/YM80jema6IWqLbRwUYz0b0H79Y4
 2RjA1hu7+Xa8kOQRxYYYV8mCaDzxMYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344942;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eb9c4CVgvWkRUSSB4xutPyPwhjFtQapblTL73fb57/U=;
 b=jxXo1ded0s3CY698ln9Q78jyETzhEa/MMgsvQqOtm/G7GuMdaNaqffXlYvLAt30mW3vKcn
 9Ko0o1T7I20ExIAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eb9c4CVgvWkRUSSB4xutPyPwhjFtQapblTL73fb57/U=;
 b=EXTvoSiz5QJkfGh+U3CuFdHlyLP5BaW4zgidMP9b9NbC2+4BjGLWjpZ8+p0rYScf0Nf6dl
 fB/0FPQoh0FLVOQulwAk7oFdkaj5hMIXnHz/07xuZa/YM80jema6IWqLbRwUYz0b0H79Y4
 2RjA1hu7+Xa8kOQRxYYYV8mCaDzxMYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344942;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eb9c4CVgvWkRUSSB4xutPyPwhjFtQapblTL73fb57/U=;
 b=jxXo1ded0s3CY698ln9Q78jyETzhEa/MMgsvQqOtm/G7GuMdaNaqffXlYvLAt30mW3vKcn
 9Ko0o1T7I20ExIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83C363EA66;
 Tue, 17 Feb 2026 16:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oOwBEi2UlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 32/32] tests/qtest/migration/tls-tests.c: Don't use tls_psk end
 hook for no_tls tests
Date: Tue, 17 Feb 2026 13:14:43 -0300
Message-ID: <20260217161443.12738-33-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,linaro.org:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
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

From: Peter Maydell <peter.maydell@linaro.org>

If you run the TLS tests under a clang undefined-behaviour sanitizer build
it will fall over like this:

../../tests/unit/crypto-tls-psk-helpers.c:53:12: runtime error: null pointer passed as argument 1, which is declared to never be null
/usr/include/unistd.h:858:48: note: nonnull attribute specified here
    #0 0x62bd810762ee in test_tls_psk_cleanup /home/pm215/qemu/build/clang/../../tests/unit/crypto-tls-psk-helpers.c:53:5
    #1 0x62bd81073f89 in migrate_hook_end_tls_psk /home/pm215/qemu/build/clang/../../tests/qtest/migration/tls-tests.c:101:5
    #2 0x62bd81062ef0 in test_precopy_common /home/pm215/qemu/build/clang/../../tests/qtest/migration/framework.c:947:9

This happens because test_precopy_tcp_no_tls() uses a custom start_hook
that only sets a couple of parameters, but reuses the tsk_psk end_hook.
However, the end_hook runs cleanup that assumes that the data was set
up by migrate_hook_start_tls_psk_common(). In particular, it will
unconditionally call test_tls_psk_cleanup(data->pskfile), and
test_tls_psk_cleanup() will unconditionally unlink() the filename it
is passed, which is undefined behaviour if you pass it a NULL pointer.

Instead of creating a TestMigrateTLSPSKData struct which we never set
any fields in and requiring the migrate_hook_end_tls_psk() hook to
cope with that, don't allocate the struct in the start_hook. Then
there is nothing we need to clean up, and we can set the end_hook
to NULL (which the test framework will interpret as "don't call
any end_hook").

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260212114747.1103466-1-peter.maydell@linaro.org
[no need to copy stable]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/tls-tests.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index bf0bb06a29..4ce7f6c676 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -488,20 +488,18 @@ static void test_precopy_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 
 static void *migrate_hook_start_no_tls(QTestState *from, QTestState *to)
 {
-    struct TestMigrateTLSPSKData *data =
-        g_new0(struct TestMigrateTLSPSKData, 1);
-
     migrate_set_parameter_null(from, "tls-creds");
     migrate_set_parameter_null(to, "tls-creds");
 
-    return data;
+    return NULL;
 }
 
 static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_no_tls;
-    args->end_hook = migrate_hook_end_tls_psk;
+    /* the no_tls start hook requires no cleanup actions */
+    args->end_hook = NULL;
 
     test_precopy_common(args);
 }
-- 
2.51.0


