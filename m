Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FE2CCF9E3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 00:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHsqK-0001gk-29; Tue, 28 Apr 2026 20:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHsqC-0001fN-DT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 20:31:48 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHsqA-0004Si-Mb
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 20:31:47 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 762346A7E9;
 Wed, 29 Apr 2026 00:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777422702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9gouYEKwWFP1bAVcWqsYjN2Sv82EgkGQIZ9ufUtORk=;
 b=gvjJIPlTLmVuczXF7nGVgQ5z5I0KIzOvZJNa3HlAZwf7odGlx7SzvXK1pLmG/UiwTWW3/s
 zNb3FAds89EpPyzcgCo9Wp3rDTpucvWzyi0zI1eQlNzRJombHXAJJ8Q0lP3l9e+eUC1pzk
 KG8xw6on8KN1/5xVAJt/lTrs5+TRRfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777422702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9gouYEKwWFP1bAVcWqsYjN2Sv82EgkGQIZ9ufUtORk=;
 b=HNgyET4cvxjm2zTMlm5uRAEGtOyXgsE+K03+rmPiyeqgDhfrUXVuGcDDotAMCGE4/Akh7T
 d5iAOy+o4LZsz7Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777422702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9gouYEKwWFP1bAVcWqsYjN2Sv82EgkGQIZ9ufUtORk=;
 b=gvjJIPlTLmVuczXF7nGVgQ5z5I0KIzOvZJNa3HlAZwf7odGlx7SzvXK1pLmG/UiwTWW3/s
 zNb3FAds89EpPyzcgCo9Wp3rDTpucvWzyi0zI1eQlNzRJombHXAJJ8Q0lP3l9e+eUC1pzk
 KG8xw6on8KN1/5xVAJt/lTrs5+TRRfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777422702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9gouYEKwWFP1bAVcWqsYjN2Sv82EgkGQIZ9ufUtORk=;
 b=HNgyET4cvxjm2zTMlm5uRAEGtOyXgsE+K03+rmPiyeqgDhfrUXVuGcDDotAMCGE4/Akh7T
 d5iAOy+o4LZsz7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78C7A593B0;
 Wed, 29 Apr 2026 00:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +CDpEW1R8WnseQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Apr 2026 00:31:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 1/3] tests/qtest/libqtest: Replace QTEST_TRACE with
 QTEST_QEMU_ARGS
Date: Tue, 28 Apr 2026 21:31:28 -0300
Message-ID: <20260429003130.15164-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429003130.15164-1-farosas@suse.de>
References: <20260429003130.15164-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
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

The QTEST_TRACE environment variable allows for any QEMU command line
option to be passed if used like so:

export QTEST_TRACE="-trace tracepoint -more -opts -here"

Formalize that usage by accepting a new QTEST_QEMU_ARGS
variable. Since the QTEST_TRACE now becomes redundant, remove its
usage.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 051faf31e1..a580d75179 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -454,11 +454,9 @@ gchar *qtest_qemu_args(const char *extra_args)
 {
     g_autofree gchar *socket_path = qtest_socket_path("sock");
     g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
-    const char *trace = g_getenv("QTEST_TRACE");
-    g_autofree char *tracearg = trace ? g_strdup_printf("-trace %s ", trace) :
-                                        g_strdup("");
+    const char *args_from_env = g_getenv("QTEST_QEMU_ARGS");
+
     gchar *args = g_strdup_printf(
-                      "%s"
                       "-qtest unix:%s "
                       "-qtest-log %s "
                       "-chardev socket,path=%s,id=char0 "
@@ -466,16 +464,17 @@ gchar *qtest_qemu_args(const char *extra_args)
                       "-display none "
                       "-audio none "
                       "%s"
+                      "%s "
                       "%s"
                       " -accel qtest",
 
-                      tracearg,
                       socket_path,
                       getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
                       qmp_socket_path,
                       can_exit_with_parent() ?
                       "-run-with exit-with-parent=on " : "",
-                      extra_args ?: "");
+                      extra_args ?: "",
+                      args_from_env ?: "");
 
     return args;
 }
-- 
2.51.0


