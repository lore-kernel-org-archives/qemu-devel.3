Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82F2C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 19:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sifmu-0008L9-VW; Mon, 26 Aug 2024 15:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sifmt-0008FY-Do
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:54:03 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sifmr-0002FN-PP
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:54:03 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB1551F8AE;
 Mon, 26 Aug 2024 19:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724702034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HyhEyYY8UmrP9bOy+Hm1xugaK/bChxs6lv5yF3HDyY=;
 b=jLd8p+wYB4Dq+CVD/uCGY/+zxMFiDCdQE6NbvaeR6xTgwdwZ+WNtT3cvRr3ZrrtplaRg3G
 glX0IrceXdZejeBHsIIRBVgU3vIWVPy+uOIq1VHs8TdKdIVcI/AWUtacqMHVRaFS+vFN+M
 RXFL7hRiRX/Cp4MWKF7foJLDqr6nBQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724702034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HyhEyYY8UmrP9bOy+Hm1xugaK/bChxs6lv5yF3HDyY=;
 b=oWVSol0O2rlswAWHzQOdS58v+fC4GV8iSYhzYjTLnjtKqtlqdTfeOMe8iqro3Q3BGW3L15
 jc/kPOIQuOlVz4DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724702034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HyhEyYY8UmrP9bOy+Hm1xugaK/bChxs6lv5yF3HDyY=;
 b=jLd8p+wYB4Dq+CVD/uCGY/+zxMFiDCdQE6NbvaeR6xTgwdwZ+WNtT3cvRr3ZrrtplaRg3G
 glX0IrceXdZejeBHsIIRBVgU3vIWVPy+uOIq1VHs8TdKdIVcI/AWUtacqMHVRaFS+vFN+M
 RXFL7hRiRX/Cp4MWKF7foJLDqr6nBQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724702034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HyhEyYY8UmrP9bOy+Hm1xugaK/bChxs6lv5yF3HDyY=;
 b=oWVSol0O2rlswAWHzQOdS58v+fC4GV8iSYhzYjTLnjtKqtlqdTfeOMe8iqro3Q3BGW3L15
 jc/kPOIQuOlVz4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 274311398D;
 Mon, 26 Aug 2024 19:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qJy1N1DdzGY5PQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Aug 2024 19:53:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v5 15/18] migration/multifd: Register nocomp ops dynamically
Date: Mon, 26 Aug 2024 16:53:19 -0300
Message-Id: <20240826195322.16532-16-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240826195322.16532-1-farosas@suse.de>
References: <20240826195322.16532-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


