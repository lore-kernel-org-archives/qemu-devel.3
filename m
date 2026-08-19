Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF0AC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhKv-0003iF-Pj; Wed, 19 Aug 2026 10:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwhKs-0003h7-BO
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:32:12 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwhKq-0003JK-KL
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:32:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2CC903EA4;
 Wed, 19 Aug 2026 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787149923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ly7UAqOYXvW24/xTtAu8cZg0rCpiUgjtaQRMOzhomvs=;
 b=c87HiQNTxm2cHJe4yG369fCVkaazOw9Cmnrf7w5kjBYe44mH2N4r6HWYa/LDCLrdImYyY6
 MXxUALUkZH45tBOUryfsOKfdQSHnUl7QoQrUVCAcmsGW0gQUBwXHqw1VXFAoJRfAhqrn1z
 5Ce7hxlSIZRCnCchCxxjd0pkH552T+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787149923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ly7UAqOYXvW24/xTtAu8cZg0rCpiUgjtaQRMOzhomvs=;
 b=B3IJIB2MLrCSLenGeuSYPxZLzcHeIFqyFVxFuT4NkzJiwZa9jxZg9TRVO5RY4+ut0pbREQ
 6R/HQecdino0hqBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787149919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ly7UAqOYXvW24/xTtAu8cZg0rCpiUgjtaQRMOzhomvs=;
 b=HUUVG9L837hADOxaNlx7J3GWb8PrgCeYeiRmK60rR/A4Np/XnnhHEwY6lmAwYCshTrwM3K
 V0sINev1JuEKM24D+AWI9TVC4SLDNoJiKWsk6A/3Qn6claNL4n/+sUIWHKkMf5pcdr1Zr3
 KO/EzBIQljRhJa1Sm/9vTtDjne1yTtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787149919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ly7UAqOYXvW24/xTtAu8cZg0rCpiUgjtaQRMOzhomvs=;
 b=yRM12a3ojpBKNJpwGd48Gx9d+4p3SWmkuZ9fz6T88NUFXjXmjiPOxkfde2Bdw5QJQ+ujke
 ej0GXsKuT2BQyuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D256367A;
 Wed, 19 Aug 2026 14:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KFLFC16+hWqxCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Aug 2026 14:31:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Rohitashv Kumar <roohiit@amazon.de>
Subject: [PULL 3/4] tests/qtest/drive_del-test: skip pc tests when 'pc'
 machine is unavailable
Date: Wed, 19 Aug 2026 11:31:51 -0300
Message-ID: <20260819143152.1541266-4-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

From: Rohitashv Kumar <roohiit@amazon.de>

test_cli_device_del(), test_device_add_and_del(),
test_drive_add_device_add_and_del() and
test_blockdev_add_device_add_and_del() use "-machine pc" on i386/x86_64.
When QEMU is built without the i440fx/pc machine, these fail with
"unsupported machine type 'pc'".

Skip the x86 case when 'pc' is not available. Non-x86 architectures use
the default machine and are unaffected, and the corresponding _q35
variants already cover x86 under qtest_has_machine("q35").

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/drive_del-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 30d9451ddda..4c32da594a4 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -258,6 +258,10 @@ static void test_cli_device_del(void)
     }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        if (!qtest_has_machine("pc")) {
+            g_test_skip("Machine 'pc' is not available");
+            return;
+        }
         machine_addition = "-machine pc";
     }
 
@@ -332,6 +336,10 @@ static void test_device_add_and_del(void)
     }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        if (!qtest_has_machine("pc")) {
+            g_test_skip("Machine 'pc' is not available");
+            return;
+        }
         machine_addition = "-machine pc";
     }
 
@@ -403,6 +411,10 @@ static void test_drive_add_device_add_and_del(void)
     }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        if (!qtest_has_machine("pc")) {
+            g_test_skip("Machine 'pc' is not available");
+            return;
+        }
         machine_addition = "-machine pc";
     }
 
@@ -456,6 +468,10 @@ static void test_blockdev_add_device_add_and_del(void)
     }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        if (!qtest_has_machine("pc")) {
+            g_test_skip("Machine 'pc' is not available");
+            return;
+        }
         machine_addition = "-machine pc";
     }
 
-- 
2.53.0


