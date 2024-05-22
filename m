Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9CDC25B7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9iBj-0000RT-HZ; Wed, 22 May 2024 05:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s9iBi-0000OS-17
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s9iBf-0004ke-Fh
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716369786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1wHqoMjWqmcrD7WUN/4EkY94+5uLPVDFe8nc6nCJ3GA=;
 b=Yk5fi2D846MxJe3jTPNRNA1Lw1kmCYCovhyfoIFCti+W/B1W3MmZDJrUPF07Q0lXyguza+
 56TEk8OukbjuTPdXdf1L4lz/maLZOVs7LWtv0OX7Y9ZELuqYN+BEb5eElvqnbhJmG8SOjH
 3Wn/umxKAWquCaJhL97iWDDfCT4f6jA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-XfwEq2BnM8GHvjQNld6njg-1; Wed, 22 May 2024 05:23:04 -0400
X-MC-Unique: XfwEq2BnM8GHvjQNld6njg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 507378025FC;
 Wed, 22 May 2024 09:23:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 193852026D68;
 Wed, 22 May 2024 09:23:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests/qtest/migration-test: Fix the check for a successful
 run of analyze-migration.py
Date: Wed, 22 May 2024 11:23:01 +0200
Message-ID: <20240522092301.421883-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.45.1


