Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8690F9EDF9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFgYJ-0002ZG-2w; Wed, 22 Apr 2026 19:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFgYH-0002Z7-JI
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 19:00:13 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFgYF-0007AK-HV
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 19:00:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D352C5BD03;
 Wed, 22 Apr 2026 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776898808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JzmxQQC5GVa6X+kkOjQwY5WdWP21XiDXgTtvxUVgEso=;
 b=tcaWw+MUyN7lHQ9LPn05KdPfIoPc4hq7PNxJz0JhFejc+isWsVlDz98UR0JvbiolgJbhG5
 oMGsbRlbj54pXaaBJ4vxQuqCZNOrNIaXSgT2v9YR/r6hq7uz0Z7t/qymiZJh+pr6CsDkcG
 eqIenp6oIj/eJj4wdwkvWLVsAQaI6TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776898808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JzmxQQC5GVa6X+kkOjQwY5WdWP21XiDXgTtvxUVgEso=;
 b=owvkYzTHjrB2hHdtt7zaSRd1Kbo8+2tRSvmBxcB0S0aIpAhSovlLkWIbAY17OZzVshKp69
 n9X8SDF8jyY0lZAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tcaWw+MU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=owvkYzTH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776898808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JzmxQQC5GVa6X+kkOjQwY5WdWP21XiDXgTtvxUVgEso=;
 b=tcaWw+MUyN7lHQ9LPn05KdPfIoPc4hq7PNxJz0JhFejc+isWsVlDz98UR0JvbiolgJbhG5
 oMGsbRlbj54pXaaBJ4vxQuqCZNOrNIaXSgT2v9YR/r6hq7uz0Z7t/qymiZJh+pr6CsDkcG
 eqIenp6oIj/eJj4wdwkvWLVsAQaI6TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776898808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JzmxQQC5GVa6X+kkOjQwY5WdWP21XiDXgTtvxUVgEso=;
 b=owvkYzTHjrB2hHdtt7zaSRd1Kbo8+2tRSvmBxcB0S0aIpAhSovlLkWIbAY17OZzVshKp69
 n9X8SDF8jyY0lZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E11C5593AF;
 Wed, 22 Apr 2026 23:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gIHjK/dS6WmXUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 Apr 2026 23:00:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v1] tests/functional: Make socat wait longer in migration exec
 test
Date: Wed, 22 Apr 2026 20:00:01 -0300
Message-ID: <20260422230001.3168-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: D352C5BD03
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The migration_with_exec test is failing sporadically for all
architectures due to a race when the destination socat process takes
too long to start listening while the source process is already
issuing connect().

The race is inherent because the exec: migration spawns the
to-be-exec'ed command asynchronously and returns from the
migrate-incoming command. The localhost-only testcase is not
representative of the majority of migrations. In a real scenario
between two different hosts that race wouldn't happen.

Fix the testcase by configuring the source socat command to wait
indefinitely while trying to connect.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/functional/migration.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 144f091ba8..3b7674af3b 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -85,5 +85,5 @@ def migration_with_exec(self):
         with Ports() as ports:
             free_port = self._get_free_port(ports)
             dst_uri = 'exec:socat TCP-LISTEN:%u -' % free_port
-            src_uri = 'exec:socat - TCP:localhost:%u' % free_port
+            src_uri = 'exec:socat - TCP:localhost:%u,forever' % free_port
             self.migrate(dst_uri, src_uri)
-- 
2.51.0


