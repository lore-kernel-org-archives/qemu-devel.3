Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6D5CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI5yJ-00075o-Qz; Wed, 29 Apr 2026 10:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wI5yF-00074U-3r
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:33:01 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wI5yD-0007rM-90
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:32:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F0F76A89D;
 Wed, 29 Apr 2026 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777473170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6N0bLYt9BpqiOZWkw8Z9wpMUn0oIDsVhLfgEXDLVns=;
 b=dy2QqOH5ZP4zHTHoSnsvvC2aJSgPt4z9qp3+r0csLjX66f4qBW+CcVIP2/tXFgbucrGTfn
 8XyHN1TO63FNaVkGThihwUchiTIAzv9m3XTFdvjC5JwyV782RyFQdxqfTs2HdJzJdGG6Js
 J36QbEL00bvyuNcOBwdgbUPdA5tCb6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777473170;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6N0bLYt9BpqiOZWkw8Z9wpMUn0oIDsVhLfgEXDLVns=;
 b=SpLRpWaE9ax6IET1ZW0H9OpZVAh5OUze3hvtl/qnZgfzuCUCk4obc4CpeYD9vw/jmBKrc/
 OW3mm82fhbpA7hBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gSecMXOX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="f6/L2yDb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777473166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6N0bLYt9BpqiOZWkw8Z9wpMUn0oIDsVhLfgEXDLVns=;
 b=gSecMXOXUh22jcWGJO3Xjob0RWd6chl3TP4pxx1ndbzoX887GPumIgmXQZ72pWh5qRUObV
 /Q1Ssg/9X1qsjvhO8F9BPgdwskH0em6wVU7sIv3cvvld3kFstyAsFUBFPanxbkZNlgcOEN
 /vP34SZl+y5hb44b7x0Dee2dRX4UUWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777473166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6N0bLYt9BpqiOZWkw8Z9wpMUn0oIDsVhLfgEXDLVns=;
 b=f6/L2yDb2LG+lSnc9TeHInGts77n++EUanRq4ZfKmhfIL+W/np3DzRb9BBBtv3SE0ZLG2K
 q2QHBMG40a84FaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C621593B5;
 Wed, 29 Apr 2026 14:32:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SDMKB4oW8mksagAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Apr 2026 14:32:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/3] tests/qtest: Make qtest_get_arch() cleverer
Date: Wed, 29 Apr 2026 11:32:31 -0300
Message-ID: <20260429143235.25115-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429143235.25115-1-farosas@suse.de>
References: <20260429143235.25115-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1F0F76A89D
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The qtest_get_arch() function tries to determine the architecture
under test by extracting it from the binary name as provided in
QTEST_QEMU_BINARY.  The current logic finds the last '-' in the
string and assumes everything beyond it is the architecture name.
Although we also look for the substring "-system-", the only effect
this check has is that we will exit with an error if it is not
present.

Because the logic at the moment is very simplistic, although
it is possible to provide more complex commands than a bare
QEMU binary path, such as:
  QTEST_QEMU_BINARY='rr record ./qemu-system-x86_64'
it is not possible to provide extra arguments to QEMU, such as:
  QTEST_QEMU_BINARY='./qemu-system-x86_64 -d trace:foo'

Because the "-system-" check and the "find the architecture" check
are not the same, the latter example will pass the "we found
-system-" check and not notice that the "architecture name" it has
found starts further on in the string; so rather than printing an
error it will return "d trace:foo" to the test.

Improve the "find the architecture name" logic to look for the
rightmost occurrence of the substring "-system-" in
QTEST_QEMU_BINARY, and take the architecture name as starting there
and continuing until the first whitespace character or the end of the
string.

Because we now need to potentially modify the environment variable
string to terminate the architecture name if it is not the last part
of the string, we make a copy of it which we cache in a static
variable.  This lets us avoid having to modify all the callers to get
them to take ownership of the returned string.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260427150007.1185559-1-peter.maydell@linaro.org
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 051faf31e1..116a8a3258 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1015,22 +1015,39 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
 
 const char *qtest_get_arch(void)
 {
-    const char *qemu = qtest_qemu_binary(NULL);
-    const char *end = strrchr(qemu, '-');
+    /*
+     * We find and cache the architecture name once, because we need to
+     * allocate memory to hold it. This memory will stay around for
+     * the lifetime of this test process.
+     */
+    static const char *arch;
 
-    if (!end) {
-        fprintf(stderr, "Can't determine architecture from binary name.\n");
-        exit(1);
-    }
+    if (!arch) {
+        /*
+         * Find the rightmost occurrence of "-system-"; the architecture
+         * name runs from there to the next whitespace.
+         */
+        const char *qemu = qtest_qemu_binary(NULL);
+        const char *sysstr = g_strrstr(qemu, "-system-");
+
+        if (sysstr) {
+            g_auto(GStrv) tokens = g_strsplit_set(sysstr + strlen("-system-"),
+                                                  " \t", 2);
+            if (tokens && tokens[0]) {
+                arch = g_steal_pointer(&tokens[0]);
+            }
+        }
 
-    if (!strstr(qemu, "-system-")) {
-        fprintf(stderr, "QTEST_QEMU_BINARY must end with *-system-<arch> "
-                "where 'arch' is the target\narchitecture (x86_64, aarch64, "
-                "etc).\n");
-        exit(1);
+        if (!arch) {
+            fprintf(stderr, "Can't determine architecture from binary name.\n"
+                    "QTEST_QEMU_BINARY must include *-system-<arch> where "
+                    "'arch' is the target architecture "
+                    "(x86_64, aarch64, etc).\n");
+            exit(1);
+        }
     }
 
-    return end + 1;
+    return arch;
 }
 
 static bool qtest_qom_has_concrete_type(const char *parent_typename,
-- 
2.51.0


