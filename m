Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2DACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44nL-0001l7-32; Wed, 01 Oct 2025 17:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44nF-0001g5-MH
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:55:27 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44mu-0006CE-QH
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:55:25 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EDCA31F80C;
 Wed,  1 Oct 2025 21:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPefJHj9j/Jkanjmc0vWB0OX5c1YmnxsH86r79nzKUk=;
 b=WS61wS+3xiaD5d03lQPngP3m6Wqh9acRmQhjglsKcLPViGOS18MlafYHeGvsoxnCuF4l/J
 W2007x775A3t7mPv8bRNYLFbCBcxy3KNjTWP86lgA7elXRcb5DZ94lFtgRKu5lg6XalbVx
 Tn0NmeQLZjrOsGGFUf8EJg8t+PIKPu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPefJHj9j/Jkanjmc0vWB0OX5c1YmnxsH86r79nzKUk=;
 b=23ercZ2AQ2R/oha4RFANv/JwuoPGjws/TTvB5uSy/Q/X5B6rfTq8tWoHyGD05VVMOF/cXc
 wdW9uGihjriHB3Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPefJHj9j/Jkanjmc0vWB0OX5c1YmnxsH86r79nzKUk=;
 b=TZyvUR9iz+PXNoBMgcPmWiQRz087oLLOpCef1KFGCWWk3OW7cNLhhfgdMjAyLUzjTlROYq
 dN42+PJvea8Zl/KMNvN13U9Z2Gg0JjVYcMtPE5xQOmrT+k4XffTHkIDH8FD/k8Tr5WHCgK
 Wbu5x+55XpZNxJIEqD5FDGhEfYyGPFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPefJHj9j/Jkanjmc0vWB0OX5c1YmnxsH86r79nzKUk=;
 b=sAgqMlt5fUUcJ6KcX0u7YfhNjujJs8aACPXvGUJS38bjYZyM6Jpg+Zq1ofXSXyRICICr97
 3OU+vZVu2rKpjhDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4DB413ADB;
 Wed,  1 Oct 2025 21:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uA06Gbqi3WhrJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 21:52:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/13] tests/qtest: Add missing checks for the availability of
 machines
Date: Wed,  1 Oct 2025 18:52:42 -0300
Message-Id: <20251001215254.2863-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251001215254.2863-1-farosas@suse.de>
References: <20251001215254.2863-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When QEMU has been compiled with "--without-default-devices", the
machines might not be available in the binary. Let's properly check
for the machines before running the tests to avoid that they are
failing in this case.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250930090444.234431-1-thuth@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/bios-tables-test.c | 2 +-
 tests/qtest/cpu-plug-test.c    | 2 +-
 tests/qtest/riscv-csr-test.c   | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 4fa8ac5096..6b892ef23e 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2864,7 +2864,7 @@ int main(int argc, char *argv[])
                            test_acpi_riscv64_virt_tcg_acpi_spcr);
         }
     } else if (strcmp(arch, "loongarch64") == 0) {
-        if (has_tcg) {
+        if (has_tcg && qtest_has_machine("virt")) {
             qtest_add_func("acpi/virt", test_acpi_loongarch64_virt);
             qtest_add_func("acpi/virt/topology",
                            test_acpi_loongarch64_virt_topology);
diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
index 44d704680b..0aa4ccc5b6 100644
--- a/tests/qtest/cpu-plug-test.c
+++ b/tests/qtest/cpu-plug-test.c
@@ -190,7 +190,7 @@ int main(int argc, char **argv)
         qtest_cb_for_every_machine(add_pseries_test_case, g_test_quick());
     } else if (g_str_equal(arch, "s390x")) {
         qtest_cb_for_every_machine(add_s390x_test_case, g_test_quick());
-    } else if (g_str_equal(arch, "loongarch64")) {
+    } else if (g_str_equal(arch, "loongarch64") && qtest_has_machine("virt")) {
         add_loongarch_test_case("virt");
     }
 
diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
index ff5c29e6c6..bb1b0ffed3 100644
--- a/tests/qtest/riscv-csr-test.c
+++ b/tests/qtest/riscv-csr-test.c
@@ -50,7 +50,9 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
-    qtest_add_func("/cpu/csr", run_test_csr);
+    if (qtest_has_machine("virt")) {
+        qtest_add_func("/cpu/csr", run_test_csr);
+    }
 
     return g_test_run();
 }
-- 
2.35.3


