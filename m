Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2D1E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpH-0003r1-Ta; Thu, 12 Dec 2024 10:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpE-0003p5-3V
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:00 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpC-0002yQ-5X
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:09:59 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CCA8221120;
 Thu, 12 Dec 2024 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=019NmC66baTO2HqjUjhKtJ4opYuhreMhHZbeVFqEi90=;
 b=F34fNg2AcZxWGXCMDPoeHLW7Uf5Xpxf+poj7qngZmZkwVVfqZPAQEHD4re/C904N99G5XJ
 nzFZ3AlLZYc+D5RNnZjQfRo5IJeDx21mCDbN0LWcPD8pMP4bf+XkC6BBmWCcPP+E70BcZA
 GvKToOVXBIVhJZTGyVQjgvhYP5JEjXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=019NmC66baTO2HqjUjhKtJ4opYuhreMhHZbeVFqEi90=;
 b=SxbrN5TCqd8mGdXtb8dKVKlsU+GdTOqGVh0elzhEn8wDFClSBZCHDW/DkeIIcCyr+sGdNr
 9i5siQZetaiy8CCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=019NmC66baTO2HqjUjhKtJ4opYuhreMhHZbeVFqEi90=;
 b=F34fNg2AcZxWGXCMDPoeHLW7Uf5Xpxf+poj7qngZmZkwVVfqZPAQEHD4re/C904N99G5XJ
 nzFZ3AlLZYc+D5RNnZjQfRo5IJeDx21mCDbN0LWcPD8pMP4bf+XkC6BBmWCcPP+E70BcZA
 GvKToOVXBIVhJZTGyVQjgvhYP5JEjXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=019NmC66baTO2HqjUjhKtJ4opYuhreMhHZbeVFqEi90=;
 b=SxbrN5TCqd8mGdXtb8dKVKlsU+GdTOqGVh0elzhEn8wDFClSBZCHDW/DkeIIcCyr+sGdNr
 9i5siQZetaiy8CCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D0C113508;
 Thu, 12 Dec 2024 15:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WJ9UGMH8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:09:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Dmitry Frolov <frolov@swemel.ru>
Subject: [PULL 01/22] tests/qtest: add TIMEOUT_MULTIPLIER
Date: Thu, 12 Dec 2024 12:09:28 -0300
Message-Id: <20241212150949.16806-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

From: Dmitry Frolov <frolov@swemel.ru>

Some tests need more time when qemu is built with
"--enable-asan --enable-ubsan"

As was discussed here:
https://patchew.org/QEMU/20241112120100.176492-2-frolov@swemel.ru/

TIMEOUT_MULTIPLIER enviroment variable will be
a useful option, allowing non-invasive timeouts
increasing for a specific build.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
Tested-by: Fabiano Rosas <farosas@suse.de>
[changed from ifndef to ?=]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/mtest2make.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index eb01a05ddb..2ef375fc6f 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -27,7 +27,7 @@ def names(self, base):
 .speed.slow = $(foreach s,$(sort $(filter-out %-thorough, $1)), --suite $s)
 .speed.thorough = $(foreach s,$(sort $1), --suite $s)
 
-TIMEOUT_MULTIPLIER = 1
+TIMEOUT_MULTIPLIER ?= 1
 .mtestargs = --no-rebuild -t $(TIMEOUT_MULTIPLIER)
 ifneq ($(SPEED), quick)
 .mtestargs += --setup $(SPEED)
-- 
2.35.3


