Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31ADFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 00:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHsqW-0001gu-58; Tue, 28 Apr 2026 20:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHsqG-0001gG-AV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 20:31:54 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHsqE-0004TG-GL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 20:31:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DAB785BD3F;
 Wed, 29 Apr 2026 00:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777422707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yrUkbZNWew6IlzmI2K/hGv+XpOXNKvdqUV5wLhXxTc=;
 b=fGxTxLB+qTT4zTCiYGIdFCAnJp5A1r2U5NzFhEq2eCgyjeiUAM8aGSxnceNX4olHrTqtWh
 064v+1/p8OxWahnQ0ianCmp/7Xk18bVKDLEhOf2JRtE/x8RYt4JabXEpJKcDAGOz3MtQSM
 fYtpiGlVD/mwJK0JMHoK5xuVj1HR1lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777422707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yrUkbZNWew6IlzmI2K/hGv+XpOXNKvdqUV5wLhXxTc=;
 b=l1HxIocIQ6tsK866Y8T98imotCeRVfZ2yzywhik6aimdcE40W6UPDscEpPL+7vxyagDYfW
 ociaM475IWX7UODA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777422706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yrUkbZNWew6IlzmI2K/hGv+XpOXNKvdqUV5wLhXxTc=;
 b=es0ZIBSiysrMijkYeSd4zRSRfcPGp/xe2Qac53ZEF16PUO7zXUSGrfu+j/2beGDfJSU7SQ
 eeB9gscXAutL+P4owquk5u+VupWVqmBzTM5u4TVahVDxTbch9/GGCaAyDeXEgtQEV/1Q05
 GHWvdLx1ikHhpEDFDTiekdG91eV047c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777422706;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yrUkbZNWew6IlzmI2K/hGv+XpOXNKvdqUV5wLhXxTc=;
 b=LbuULDtd5PpmtCzP5gXUPTw93VB4aSdkJvpAFqfF391UmDVfX3R3YFrSsEr/xwkwcFnKO+
 nJ1mUgLnoZHraVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F1F2593B0;
 Wed, 29 Apr 2026 00:31:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wBCAE3FR8WnseQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Apr 2026 00:31:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v1 3/3] docs/devel/qtest: Mention environment variables usage
Date: Tue, 28 Apr 2026 21:31:30 -0300
Message-ID: <20260429003130.15164-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429003130.15164-1-farosas@suse.de>
References: <20260429003130.15164-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/testing/qtest.rst | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/docs/devel/testing/qtest.rst b/docs/devel/testing/qtest.rst
index 73ef7702b7..0aac0f0aaf 100644
--- a/docs/devel/testing/qtest.rst
+++ b/docs/devel/testing/qtest.rst
@@ -91,3 +91,36 @@ libqtest API reference
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
+QTEST_QEMU_BINARY - The QEMU binary itself
+
+QTEST_QEMU_ARGS - Extra arguments for the QEMU command line
+
+QTEST_QEMU_IMG - The qemu-img binary
+
+QTEST_QEMU_STORAGE_DAEMON_BINARY - The qemu-storage-daemon binary
+
+QTEST_STOP - Instruct QTest to stop the QEMU process with SIGSTOP before continuing execution.
+
+QTEST_LOG - Comma-separated list of log domains to allow verbose logging. Basic log domains include:
+
+	    qmp - controls verbose output of QMP command invocations.
+
+	    qtest - controls verbose ouput of qtest operations.
+
+	    test - controls verbose output of tests.
+
+	    A dash '-' used in front of a log domain has the effect of
+	    enabling verbose logging for all other domains while
+	    keeping it disabled for the specified domain.
-- 
2.51.0


