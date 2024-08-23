Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37303C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 17:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shYGO-0000oO-1P; Fri, 23 Aug 2024 13:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYGF-0000GJ-2x
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:43 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYGD-00005L-ED
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:42 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9943E226EE;
 Fri, 23 Aug 2024 17:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+tFdzfZOAzXZYeedkli/LNmddQj1yZ8YqYyU3/I8Q0=;
 b=0WY+8PAf0luwb/BzGxtpc+kmfdJqQjeSSjS83wi9lxIf+ZArZS3ojDVFZpxH/cz66EdBHs
 k7WMAOh4+j7t3F7G6wkyKTfowzSB/EB1R73nH48wnxXo+oZy2sL2PxfKEfUsfpZwJoqFJY
 GGCGMqG3z0pZauSVUcvH3ZYvrcTGWnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+tFdzfZOAzXZYeedkli/LNmddQj1yZ8YqYyU3/I8Q0=;
 b=S2hQ+T9MiOQ1YUQ2GFOdisjLn3BG+JJKKCBo4JfXiZ8NV5UfgWfblVImZuALX/X3r6QpBi
 FW5f60H0zRxuM3Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0WY+8PAf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S2hQ+T9M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+tFdzfZOAzXZYeedkli/LNmddQj1yZ8YqYyU3/I8Q0=;
 b=0WY+8PAf0luwb/BzGxtpc+kmfdJqQjeSSjS83wi9lxIf+ZArZS3ojDVFZpxH/cz66EdBHs
 k7WMAOh4+j7t3F7G6wkyKTfowzSB/EB1R73nH48wnxXo+oZy2sL2PxfKEfUsfpZwJoqFJY
 GGCGMqG3z0pZauSVUcvH3ZYvrcTGWnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+tFdzfZOAzXZYeedkli/LNmddQj1yZ8YqYyU3/I8Q0=;
 b=S2hQ+T9MiOQ1YUQ2GFOdisjLn3BG+JJKKCBo4JfXiZ8NV5UfgWfblVImZuALX/X3r6QpBi
 FW5f60H0zRxuM3Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 707191333E;
 Fri, 23 Aug 2024 17:39:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2NXBDVrJyGb2LwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Aug 2024 17:39:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 15/16] migration/multifd: Register nocomp ops dynamically
Date: Fri, 23 Aug 2024 14:39:10 -0300
Message-Id: <20240823173911.6712-16-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240823173911.6712-1-farosas@suse.de>
References: <20240823173911.6712-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9943E226EE
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Prior to moving the ram code into multifd-nocomp.c, change the code to
register the nocomp ops dynamically so we don't need to have the ops
structure defined in multifd.c.

While here, move the ops struct initialization to the end of the file
to make the next diff cleaner.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 9f40bb2f16..e100836cbe 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -287,22 +287,12 @@ static int multifd_nocomp_recv(MultiFDRecvParams *p, Error **errp)
     return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
 }
 
-static MultiFDMethods multifd_nocomp_ops = {
-    .send_setup = multifd_nocomp_send_setup,
-    .send_cleanup = multifd_nocomp_send_cleanup,
-    .send_prepare = multifd_nocomp_send_prepare,
-    .recv_setup = multifd_nocomp_recv_setup,
-    .recv_cleanup = multifd_nocomp_recv_cleanup,
-    .recv = multifd_nocomp_recv
-};
-
-static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {
-    [MULTIFD_COMPRESSION_NONE] = &multifd_nocomp_ops,
-};
+static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {};
 
 void multifd_register_ops(int method, MultiFDMethods *ops)
 {
-    assert(0 < method && method < MULTIFD_COMPRESSION__MAX);
+    assert(0 <= method && method < MULTIFD_COMPRESSION__MAX);
+    assert(!multifd_ops[method]);
     multifd_ops[method] = ops;
 }
 
@@ -1701,3 +1691,19 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
 
     return true;
 }
+
+static MultiFDMethods multifd_nocomp_ops = {
+    .send_setup = multifd_nocomp_send_setup,
+    .send_cleanup = multifd_nocomp_send_cleanup,
+    .send_prepare = multifd_nocomp_send_prepare,
+    .recv_setup = multifd_nocomp_recv_setup,
+    .recv_cleanup = multifd_nocomp_recv_cleanup,
+    .recv = multifd_nocomp_recv
+};
+
+static void multifd_nocomp_register(void)
+{
+    multifd_register_ops(MULTIFD_COMPRESSION_NONE, &multifd_nocomp_ops);
+}
+
+migration_init(multifd_nocomp_register);
-- 
2.35.3


