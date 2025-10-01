Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D7CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44pS-0003Tq-0o; Wed, 01 Oct 2025 17:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44p4-0003An-UR
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:57:18 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44or-0006Xb-MG
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:57:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C4C533780;
 Wed,  1 Oct 2025 21:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBUgBsHlAjSTQbgPJ88NeqduDJuLMr/VK3RDkjTxJ0s=;
 b=c/9nT7L2iTZndN+3IVFNAT8ABVDehWssCED9RWQKlNn/saBV9hFGCc+BssAWSF1oUcgzhl
 disQJgj0/Z76AGAYY1xTHsP3Oo6FjIL+bef73DignGh4SS3QlvdopCBAR9tkLKefATl8ZO
 drBDYQz4ADEPabyOj1JxR4OKNutd8wQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBUgBsHlAjSTQbgPJ88NeqduDJuLMr/VK3RDkjTxJ0s=;
 b=xPoi4MnH0EmuLDsQ10Mg7p6JES5PnZsrLGUAOv24ZI7WsnKJ0iwXeTKwer9dn3wnUPfmMb
 mBW2gd6f7j0lgcCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="c/9nT7L2";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xPoi4MnH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBUgBsHlAjSTQbgPJ88NeqduDJuLMr/VK3RDkjTxJ0s=;
 b=c/9nT7L2iTZndN+3IVFNAT8ABVDehWssCED9RWQKlNn/saBV9hFGCc+BssAWSF1oUcgzhl
 disQJgj0/Z76AGAYY1xTHsP3Oo6FjIL+bef73DignGh4SS3QlvdopCBAR9tkLKefATl8ZO
 drBDYQz4ADEPabyOj1JxR4OKNutd8wQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBUgBsHlAjSTQbgPJ88NeqduDJuLMr/VK3RDkjTxJ0s=;
 b=xPoi4MnH0EmuLDsQ10Mg7p6JES5PnZsrLGUAOv24ZI7WsnKJ0iwXeTKwer9dn3wnUPfmMb
 mBW2gd6f7j0lgcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A2C713A3F;
 Wed,  1 Oct 2025 21:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GOBFA8ei3WhrJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 21:53:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 08/13] tests/qtest: qtest_init_after_exec
Date: Wed,  1 Oct 2025 18:52:49 -0300
Message-Id: <20251001215254.2863-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251001215254.2863-1-farosas@suse.de>
References: <20251001215254.2863-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 8C4C533780
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Define a function to create a QTestState object representing the state
of QEMU after old QEMU exec's new QEMU.  This is needed for testing
the cpr-exec migration mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/1759332851-370353-14-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 19 +++++++++++++++++++
 tests/qtest/libqtest.h |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index d97144e1d5..933d085869 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -615,6 +615,25 @@ QTestState *qtest_init_ext(const char *var, const char *extra_args,
     return s;
 }
 
+static QTestState *qtest_attach_qemu(const char *qemu_bin,
+                                     const char *extra_args,
+                                     void *opaque)
+{
+    int pid = *(int *)opaque;
+    return qtest_create_test_state(pid);
+}
+
+QTestState *qtest_init_after_exec(QTestState *qts)
+{
+    void *opaque = (void *)&qts->qemu_pid;
+    QTestState *s;
+
+    s = qtest_init_internal(NULL, NULL, true, qtest_attach_qemu, opaque);
+    qts->qemu_pid = -1;
+    qtest_qmp_handshake(s, NULL);
+    return s;
+}
+
 QTestState *qtest_init(const char *extra_args)
 {
     return qtest_init_ext(NULL, extra_args, NULL, true);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 7f8dd0a912..9c118c89ca 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -56,6 +56,14 @@ QTestState *qtest_vinitf(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
  */
 const char *qtest_qemu_binary(const char *var);
 
+/**
+ * qtest_init_after_exec:
+ * @qts: the previous QEMU state
+ *
+ * Return a test state representing new QEMU after @qts exec's it.
+ */
+QTestState *qtest_init_after_exec(QTestState *qts);
+
 /**
  * qtest_qemu_args:
  * @extra_args: Other arguments to pass to QEMU.
-- 
2.35.3


