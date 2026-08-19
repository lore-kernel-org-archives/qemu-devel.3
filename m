Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F25DC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhKv-0003iI-T8; Wed, 19 Aug 2026 10:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwhKr-0003gk-ES
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:32:09 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwhKp-0003IK-PW
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:32:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 071FF84B99;
 Wed, 19 Aug 2026 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787149922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/A0nU/P7Yc24bwJ8lp9JwwJwRJ3s8sFbEn1jDR2sPXQ=;
 b=T/5dCxP0QXokfhlXcZW7bZeHZCchdnUaNdRmra57G2Q4+mPf5IyPrlG95iHqJpFH/T5vXs
 uTI9upj2eVXddmprcvcXGpchtT1F8w/3uKorhXKlCMhSYt5P2tW2k66q6yAtosStSpDYkw
 +NkYkTIMrQxIlK5S96MCwkcW24rFWbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787149922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/A0nU/P7Yc24bwJ8lp9JwwJwRJ3s8sFbEn1jDR2sPXQ=;
 b=kQoR03ZUes0IXgdCjVeC4xmp3G2mtndqr//hqK6rzIdKJGkfnCb0dNwxPq1CERdWcS82Z7
 1A8B/wEwnYop1sDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787149918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/A0nU/P7Yc24bwJ8lp9JwwJwRJ3s8sFbEn1jDR2sPXQ=;
 b=z+q8F+qx70PgcfAcRwWCR1g5zWhdXHqC7ddRfFSfQIxt4GWFSElqjz7BKIQ8rppYnhF2zm
 zbF74xuYtSva+UF2FKZbYzlWoIUb106+zJiEtFLFioyRrfmRdiS8ZtGWQzy145BrkQCW/j
 LHhtFQFYSMoyqBzWsDbdei84K9IlaGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787149918;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/A0nU/P7Yc24bwJ8lp9JwwJwRJ3s8sFbEn1jDR2sPXQ=;
 b=VKMyCc+TsG1D1UR0reYu5azsenlk+LalY+UT3KmwRqDZLUrnnKJg9rTWF3IIjyZUhSef+C
 vNlBKuP5dwDCEJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41976364F;
 Wed, 19 Aug 2026 14:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cN8UBV2+hWqxCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Aug 2026 14:31:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Rohitashv Kumar <roohiit@amazon.de>
Subject: [PULL 2/4] tests/qtest/device-plug-test: skip pc tests when 'pc'
 machine is unavailable
Date: Wed, 19 Aug 2026 11:31:50 -0300
Message-ID: <20260819143152.1541266-3-farosas@suse.de>
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

From: Rohitashv Kumar <roohiit@amazon.de>

test_pci_unplug_request() and test_pci_unplug_json_request() use
"-machine pc" on i386/x86_64. When QEMU is built without the i440fx/pc
machine, these fail with "unsupported machine type 'pc'".

Skip the x86 case when 'pc' is not available. Non-x86 architectures use
the default machine and are unaffected, and x86 unplug coverage is still
provided by the q35 variant (test_q35_pci_unplug_request), which already
guards on qtest_has_machine("q35").

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/device-plug-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
index 2707ee59f63..650956fa114 100644
--- a/tests/qtest/device-plug-test.c
+++ b/tests/qtest/device-plug-test.c
@@ -65,6 +65,10 @@ static void test_pci_unplug_request(void)
     }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        if (!qtest_has_machine("pc")) {
+            g_test_skip("Machine 'pc' is not available");
+            return;
+        }
         machine_addition = "-machine pc";
     }
 
@@ -107,6 +111,10 @@ static void test_pci_unplug_json_request(void)
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


