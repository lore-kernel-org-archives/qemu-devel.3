Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D31BE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpF-0003pL-0g; Thu, 12 Dec 2024 10:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpE-0003p6-4V
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:00 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpC-0002yf-CX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:09:59 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 72CD41F394;
 Thu, 12 Dec 2024 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMITvGvnkQ4fUF7q8QeCtQkCpLe7rgnLWFPrq2/x6XA=;
 b=B6Ejzk/5aXrkP9AyiajX+FLWSs+4CrULrDVovh3b7zE5olm6bcb0WSKw1riWW0aH7JxdPw
 HrbWLrg0AelsY819+/UBFaFZAq+FFEY22d5P6pAuGkyH9Ek/zinABUb1b4dLFeSq9tW7K9
 yQV16dVpsGUBWspitYCvAYQWL89a2Io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016196;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMITvGvnkQ4fUF7q8QeCtQkCpLe7rgnLWFPrq2/x6XA=;
 b=a6q84oSfoi1WXqZ5MAMUF5Rt7w4YLxTMY22NxlxUUl3ZF/tFaQwBBYlOcxjmNJANJy0fNC
 /YewTS/ZCmErrHAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMITvGvnkQ4fUF7q8QeCtQkCpLe7rgnLWFPrq2/x6XA=;
 b=B6Ejzk/5aXrkP9AyiajX+FLWSs+4CrULrDVovh3b7zE5olm6bcb0WSKw1riWW0aH7JxdPw
 HrbWLrg0AelsY819+/UBFaFZAq+FFEY22d5P6pAuGkyH9Ek/zinABUb1b4dLFeSq9tW7K9
 yQV16dVpsGUBWspitYCvAYQWL89a2Io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016196;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMITvGvnkQ4fUF7q8QeCtQkCpLe7rgnLWFPrq2/x6XA=;
 b=a6q84oSfoi1WXqZ5MAMUF5Rt7w4YLxTMY22NxlxUUl3ZF/tFaQwBBYlOcxjmNJANJy0fNC
 /YewTS/ZCmErrHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46ACE13508;
 Thu, 12 Dec 2024 15:09:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qGx+A8P8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:09:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/22] tests/qtest: Add qtest_system_reset() utility function
Date: Thu, 12 Dec 2024 12:09:29 -0300
Message-Id: <20241212150949.16806-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid, linaro.org:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

We have several qtest tests which want to reset the QEMU under test
during the course of testing something.  They currently generally
have their own functions to do this, which work by sending a
"system_reset" QMP command.  However, "system_reset" only requests a
reset, and many of the tests which send the QMP command forget the
"and then wait for the QMP RESET event" part which is needed to
ensure that the reset has completed.

Provide a qtest_system_reset() function in libqtest so that
we don't need to reimplement this in multiple different tests.

A few tests (for example device hotplug related tests) want to
perform the reset command and then wait for some other event that is
produced during the reset sequence.  For them we provide
qtest_system_reset_nowait() so they can clearly indicate that they
are deliberately not waiting for the RESET event.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 16 ++++++++++++++++
 tests/qtest/libqtest.h | 25 +++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 817fd7aac5..8de5f1fde3 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -215,6 +215,22 @@ static void qtest_check_status(QTestState *s)
 #endif
 }
 
+void qtest_system_reset_nowait(QTestState *s)
+{
+    /* Request the system reset, but do not wait for it to complete */
+    qtest_qmp_assert_success(s, "{'execute': 'system_reset' }");
+}
+
+void qtest_system_reset(QTestState *s)
+{
+    qtest_system_reset_nowait(s);
+    /*
+     * Wait for the RESET event, which is sent once the system reset
+     * has actually completed.
+     */
+    qtest_qmp_eventwait(s, "RESET");
+}
+
 void qtest_wait_qemu(QTestState *s)
 {
     if (s->qemu_pid != -1) {
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index beb96b18eb..f23d80e9e5 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -88,6 +88,31 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
  */
 QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd);
 
+/**
+ * qtest_system_reset:
+ * @s: #QTestState instance to operate on.
+ *
+ * Send a "system_reset" command to the QEMU under test, and wait for
+ * the reset to complete before returning.
+ */
+void qtest_system_reset(QTestState *s);
+
+/**
+ * qtest_system_reset_nowait:
+ * @s: #QTestState instance to operate on.
+ *
+ * Send a "system_reset" command to the QEMU under test, but do not
+ * wait for the reset to complete before returning. The caller is
+ * responsible for waiting for either the RESET event or some other
+ * event of interest to them before proceeding.
+ *
+ * This function should only be used if you're specifically testing
+ * for some other event; in that case you can't use qtest_system_reset()
+ * because it will read and discard any other QMP events that arrive
+ * before the RESET event.
+ */
+void qtest_system_reset_nowait(QTestState *s);
+
 /**
  * qtest_wait_qemu:
  * @s: #QTestState instance to operate on.
-- 
2.35.3


