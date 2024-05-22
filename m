Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127D2C25B7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9uKT-0005ha-OU; Wed, 22 May 2024 18:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKR-0005f5-AQ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:59 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKP-0003nW-Jl
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:59 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B2D31F8B9;
 Wed, 22 May 2024 22:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WApCF/NTJsf9MfUlgVC1dp1gFBpa3wLsEpbFdAbSGFA=;
 b=uEOs6bssx1b1AjwW62Q4ZDr5aEz3U4OUJVmnDTukx+FkBVRjHjNf34kOiHovSfkjeobH0n
 waNroZTeo4mOi/hLATzP+UkVKERzSJFtfjthBhSmzaLEs2VlaLJ3G2DFrBAh+qSZBQrlsN
 KkKNHXvYv233oFqxklqFVmp11Bv9G9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WApCF/NTJsf9MfUlgVC1dp1gFBpa3wLsEpbFdAbSGFA=;
 b=LYsIEsSIbC4cu5QbPWG82PIlSfGG6x9BJE42nnV7swb6TIfeh/zCVdzK40Mn8iTcFa111M
 R8ReHoXFOI0VP3Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WApCF/NTJsf9MfUlgVC1dp1gFBpa3wLsEpbFdAbSGFA=;
 b=uEOs6bssx1b1AjwW62Q4ZDr5aEz3U4OUJVmnDTukx+FkBVRjHjNf34kOiHovSfkjeobH0n
 waNroZTeo4mOi/hLATzP+UkVKERzSJFtfjthBhSmzaLEs2VlaLJ3G2DFrBAh+qSZBQrlsN
 KkKNHXvYv233oFqxklqFVmp11Bv9G9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WApCF/NTJsf9MfUlgVC1dp1gFBpa3wLsEpbFdAbSGFA=;
 b=LYsIEsSIbC4cu5QbPWG82PIlSfGG6x9BJE42nnV7swb6TIfeh/zCVdzK40Mn8iTcFa111M
 R8ReHoXFOI0VP3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F129713A6B;
 Wed, 22 May 2024 22:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4IaELcZvTmaABAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 22:20:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 9/9] tests/qtest/migration-test: Fix the check for a successful
 run of analyze-migration.py
Date: Wed, 22 May 2024 19:20:34 -0300
Message-Id: <20240522222034.4001-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240522222034.4001-1-farosas@suse.de>
References: <20240522222034.4001-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

If analyze-migration.py cannot be run or crashes, the error is currently
ignored since the code only checks for nonzero values in case the child
exited properly. For example, if you run the test with a non-existing
Python interpreter, it still succeeds:

 $ PYTHON=wrongpython QTEST_QEMU_BINARY=./qemu-system-x86_64 tests/qtest/migration-test
 ...
 # Running /x86_64/migration/analyze-script
 # Using machine type: pc-q35-9.1
 # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-417639.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-417639.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-9.1, -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-XPLUN2/src_serial -drive if=none,id=d0,file=/tmp/migration-test-XPLUN2/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1   -uuid 11111111-1111-1111-1111-111111111111  -accel qtest
 # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-417639.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-417639.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-9.1, -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-XPLUN2/dest_serial -incoming tcp:127.0.0.1:0 -drive if=none,id=d0,file=/tmp/migration-test-XPLUN2/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1     -accel qtest
 **
 ERROR:../../devel/qemu/tests/qtest/migration-test.c:1603:test_analyze_script: code should not be reached
 migration-test: ../../devel/qemu/tests/qtest/libqtest.c:240: qtest_wait_qemu: Assertion `pid == s->qemu_pid' failed.
 migration-test: ../../devel/qemu/tests/qtest/libqtest.c:240: qtest_wait_qemu: Assertion `pid == s->qemu_pid' failed.
 ok 2 /x86_64/migration/analyze-script
 ...

Let's better fail the test in case the child did not exit properly, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5b4eca2b20..b7e3406471 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1604,7 +1604,7 @@ static void test_analyze_script(void)
     }
 
     g_assert(waitpid(pid, &wstatus, 0) == pid);
-    if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != 0) {
+    if (!WIFEXITED(wstatus) || WEXITSTATUS(wstatus) != 0) {
         g_test_message("Failed to analyze the migration stream");
         g_test_fail();
     }
-- 
2.35.3


