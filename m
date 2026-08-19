Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3117C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhKw-0003il-GV; Wed, 19 Aug 2026 10:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwhKu-0003hI-9f
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:32:12 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwhKs-0003KV-Fx
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:32:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 402A084BA3;
 Wed, 19 Aug 2026 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787149924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H80qvGXCvNWhn31tHxLxkNway/KVCqWkaPtSTxj3eqk=;
 b=Hz4WoT2xM8GYjs2Zhs68NdDm/WGWRlaHIt/cRWUOKn30D2fThmR4qUrw2lCKq4x7S/SfPN
 Bj0uJYjyMLhPWRChlPqMoenMptZ0DIFovcUGDPWCAIAG21rBiz/Kyvu+V9jNz+3+NAPc1G
 RgXCJ+nInNWutwZZpgE8LL4GYGlBMqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787149924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H80qvGXCvNWhn31tHxLxkNway/KVCqWkaPtSTxj3eqk=;
 b=C0XBSBiLyxKyt04SGb6WzolJbhuD3iR4GpuUkvLAEEryRdrYHf9bMCkl1RTiil4mtGmyoh
 Idj85EYFMOq3kQBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787149920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H80qvGXCvNWhn31tHxLxkNway/KVCqWkaPtSTxj3eqk=;
 b=OuiDaWwqkgyqAKWNuj4LgGedR3c5wtmOR1HJD+LdznyKo5XaS6mwbD7IED55/Bh7IiWPtt
 nOv0daaoGWtgk9M/lV24SQHPJTZIsFy7WqHpumlHF8+soGImlQ+Nzg+A+DmtU2oa7gbGzd
 hNkSizQXHqoUyxYXcrOtJw47wChAYJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787149920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H80qvGXCvNWhn31tHxLxkNway/KVCqWkaPtSTxj3eqk=;
 b=0AGTNrWPw3HOVyWI9lGvEUh+cEmiZx05WIZcmUm205ASvs/eEA4Xng4wKJlo4HjYeXB8kJ
 F4HOGa856VF4ikCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 775D6367B;
 Wed, 19 Aug 2026 14:31:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gBMtEl++hWqxCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Aug 2026 14:31:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Rohitashv Kumar <roohiit@amazon.de>
Subject: [PULL 4/4] tests/qtest/pxe-test: skip per-row cases whose machine is
 unavailable
Date: Wed, 19 Aug 2026 11:31:52 -0300
Message-ID: <20260819143152.1541266-5-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819143152.1541266-1-farosas@suse.de>
References: <20260819143152.1541266-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

From: Rohitashv Kumar <roohiit@amazon.de>

The x86 test table mixes 'pc' and 'q35' rows. When QEMU is built without
the i440fx/pc machine, the 'pc' rows fail with "unsupported machine type".

Add a per-row qtest_has_machine() check in test_batch(), mirroring the
existing per-row qtest_has_device() guard, so rows for an unavailable
machine are skipped while the others (e.g. q35) still run.

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/pxe-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index a3f900fbea3..e85dec5a4e1 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -108,6 +108,10 @@ static void test_batch(const testdef_t *tests, bool ipv6)
         const testdef_t *test = &tests[i];
         char *testname;
 
+        if (!qtest_has_machine(test->machine)) {
+            continue;
+        }
+
         if (!qtest_has_device(test->model)) {
             continue;
         }
-- 
2.53.0


