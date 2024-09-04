Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3C5CD4849
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNm-0005o4-Gw; Wed, 04 Sep 2024 08:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNl-0005gf-24
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:45:09 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNj-0005rN-8Y
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:45:08 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 89FA42191F;
 Wed,  4 Sep 2024 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HyhEyYY8UmrP9bOy+Hm1xugaK/bChxs6lv5yF3HDyY=;
 b=h29JHPy+6707ESlOZXNvs+xQ5SnLW4sL7U3jgY6n1XAO/+Si+f2NWKeZejUSrBlbP8SxGW
 9WgHNXn/CsvyoEFJekmytRLDrOOFPnyi3XGfsbGDkZZL429O5o8D+ZjgZQd0C2Jqdu2/za
 2uXf8d14GpOqB1GpFcuKi0XzsJauCP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HyhEyYY8UmrP9bOy+Hm1xugaK/bChxs6lv5yF3HDyY=;
 b=dWj8of+qQ2ld3UbBLs57gy2fnCm9P2Mnpp4LKGopdz8steUyeVAHZ0P0u1iLdmt5b/WSRG
 c4B/uu184R+RzBAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=h29JHPy+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dWj8of+q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HyhEyYY8UmrP9bOy+Hm1xugaK/bChxs6lv5yF3HDyY=;
 b=h29JHPy+6707ESlOZXNvs+xQ5SnLW4sL7U3jgY6n1XAO/+Si+f2NWKeZejUSrBlbP8SxGW
 9WgHNXn/CsvyoEFJekmytRLDrOOFPnyi3XGfsbGDkZZL429O5o8D+ZjgZQd0C2Jqdu2/za
 2uXf8d14GpOqB1GpFcuKi0XzsJauCP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HyhEyYY8UmrP9bOy+Hm1xugaK/bChxs6lv5yF3HDyY=;
 b=dWj8of+qQ2ld3UbBLs57gy2fnCm9P2Mnpp4LKGopdz8steUyeVAHZ0P0u1iLdmt5b/WSRG
 c4B/uu184R+RzBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C320139D2;
 Wed,  4 Sep 2024 12:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QLLKOE9W2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:45:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 26/34] migration/multifd: Register nocomp ops dynamically
Date: Wed,  4 Sep 2024 09:44:09 -0300
Message-Id: <20240904124417.14565-27-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 89FA42191F
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
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


