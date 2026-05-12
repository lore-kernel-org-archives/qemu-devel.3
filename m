Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5440CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuPg-0006lg-1R; Tue, 12 May 2026 17:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMuPK-0004wR-MZ
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:12:50 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMuPI-0004uG-R6
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:12:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B9F2623A6;
 Tue, 12 May 2026 21:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778620351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IKrPDUpYODAuw0gabCm8QF0LBdb03WYxgmC4T/73BE=;
 b=ODYGb2hE8H2K5c0GWFKlYN7tPHyo1BOfa16wWCMF/dMxIBeRbCMHTfDHrcwMWWqxzhq9Y3
 tf7Gt7mPS7gh1uwBX5eDcIF4FEp7FWgKTmta+vkdM/dduY+/79FEGF2k3n34zzsgx6qLMy
 J4U73lanU7Qpetx6nOyUS7FJRS6WsAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778620351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IKrPDUpYODAuw0gabCm8QF0LBdb03WYxgmC4T/73BE=;
 b=+SG/X6JL4W34V62W9x4O123zBv2I+zINhBOajUwz/dAUVam6kbDlajWePpqYAb2/6Zhjy6
 bJ0gH8MaUMTLcZDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ODYGb2hE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="+SG/X6JL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778620351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IKrPDUpYODAuw0gabCm8QF0LBdb03WYxgmC4T/73BE=;
 b=ODYGb2hE8H2K5c0GWFKlYN7tPHyo1BOfa16wWCMF/dMxIBeRbCMHTfDHrcwMWWqxzhq9Y3
 tf7Gt7mPS7gh1uwBX5eDcIF4FEp7FWgKTmta+vkdM/dduY+/79FEGF2k3n34zzsgx6qLMy
 J4U73lanU7Qpetx6nOyUS7FJRS6WsAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778620351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IKrPDUpYODAuw0gabCm8QF0LBdb03WYxgmC4T/73BE=;
 b=+SG/X6JL4W34V62W9x4O123zBv2I+zINhBOajUwz/dAUVam6kbDlajWePpqYAb2/6Zhjy6
 bJ0gH8MaUMTLcZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99396593A9;
 Tue, 12 May 2026 21:12:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CBt8Gr6XA2r+IAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 May 2026 21:12:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 3/4] docs/devel/qtest: Mention environment variables usage
Date: Tue, 12 May 2026 18:12:20 -0300
Message-ID: <20260512211221.3173-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512211221.3173-1-farosas@suse.de>
References: <20260512211221.3173-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,linaro.org:email,qualcomm.com:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[linaro.org:email,qualcomm.com:email,suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 8B9F2623A6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Document the QTEST_ environment variables. Only include the ones used
by QTest itself, don't document test-specific variables as they are
more prone to change.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260429003130.15164-4-farosas@suse.de
[picked rst-formatted version from Peter Maydell]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/testing/qtest.rst | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/docs/devel/testing/qtest.rst b/docs/devel/testing/qtest.rst
index 73ef7702b7..f96db05c2a 100644
--- a/docs/devel/testing/qtest.rst
+++ b/docs/devel/testing/qtest.rst
@@ -91,3 +91,47 @@ libqtest API reference
 ----------------------
 
 .. kernel-doc:: tests/qtest/libqtest.h
+
+
+QTest valid environment variables
+---------------------------------
+
+A few environment variables are used to point QTest at artifacts to be
+used in the tests, mostly QEMU binaries or to control the behavior of
+the tests. Environment variables are set automatically by the build
+system, but it can be useful to alter them when running tests
+manually. The following are the environment variables recognized by
+QTest, not including test-specific ones:
+
+``QTEST_QEMU_BINARY``
+    The QEMU binary itself (generally a ``qemu-system-<arch>`` binary).
+
+``QTEST_QEMU_ARGS``
+    Extra arguments for the QEMU command line.
+
+``QTEST_QEMU_IMG``
+    The ``qemu-img`` binary.
+
+``QTEST_QEMU_STORAGE_DAEMON_BINARY``
+    The ``qemu-storage-daemon`` binary.
+
+``QTEST_STOP``
+    Instruct QTest to stop the QEMU process with SIGSTOP before continuing
+    execution.
+
+``QTEST_LOG``
+    Comma-separated list of log domains to allow verbose logging.
+    The currently-defined log domains are:
+
+    ``qmp``
+        controls verbose output of QMP command invocations.
+
+    ``qtest``
+        controls verbose output of QTest operations.
+
+    ``test``
+        controls verbose output of tests.
+
+    A dash ``-`` used in front of a log domain name has the effect
+    of enabling verbose logging for all other domains while
+    keeping it disabled for the specified domain.
-- 
2.51.0


