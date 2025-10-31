Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A2FCCFA05
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 19:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEuP4-00017g-Ue; Fri, 31 Oct 2025 15:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEuP1-00017K-2a
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 15:03:11 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEuOp-0004Xs-8T
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 15:03:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 16A92C015B;
 Fri, 31 Oct 2025 22:02:53 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id m2mTmi0FnuQ0-6ou9Bglx; Fri, 31 Oct 2025 22:02:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761937372;
 bh=aToQozPJO7fyPFG7e9mtPKKMftwtXd+NUmEWhNOSUUM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Ptl8+BaCRttptY1uow6bM4+jAkPCasCGGVmP7/60+291DgQWPoehSenhxpxS52qWo
 UmoBMLA4Wj24mFOnS9aS/fh2fvLo/3HR1AvFdC5+iJkHF4QSrMQpZ/oukXef6TgzjR
 YJCSG1FzNQqkdF52s6RcsyasBRMciXOMTYDEI/jc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v2 2/2] tests/unit: add unit test for qemu_hexdump()
Date: Fri, 31 Oct 2025 22:02:46 +0300
Message-ID: <20251031190246.257153-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251031190246.257153-1-vsementsov@yandex-team.ru>
References: <20251031190246.257153-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Test, that fix in previous commit make sense.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/unit/test-cutils.c | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 227acc5995..24fef16a7f 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -3626,6 +3626,44 @@ static void test_si_prefix(void)
     g_assert_cmpstr(si_prefix(18), ==, "E");
 }
 
+static void test_qemu_hexdump_alignment(void)
+{
+    /*
+     * Test that ASCII part is properly aligned for incomplete lines.
+     * This test catches the bug that was fixed in previous commit
+     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
+     *
+     * We use data that is not aligned to 16 bytes, so last line
+     * is incomplete.
+     */
+    const uint8_t data[] = {
+        /* First line: 16 bytes */
+        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello Wo" */
+        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! Thi" */
+        /* Second line: 5 bytes (incomplete) */
+        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
+    };
+    char *output = NULL;
+    size_t size;
+    FILE *stream = open_memstream(&output, &size);
+
+    g_assert_nonnull(stream);
+
+    qemu_hexdump(stream, "test", data, sizeof(data));
+    fclose(stream);
+
+    g_assert_nonnull(output);
+
+    /* We expect proper alignment of "s is" part on the second line */
+    const char *expected =
+        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 68 69   Hello World! Thi\n"
+        "test: 0010: 73 20 69 73  20                                      s is \n";
+
+    g_assert_cmpstr(output, ==, expected);
+
+    free(output);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -3995,5 +4033,10 @@ int main(int argc, char **argv)
                     test_iec_binary_prefix);
     g_test_add_func("/cutils/si_prefix",
                     test_si_prefix);
+
+    /* qemu_hexdump() test */
+    g_test_add_func("/cutils/qemu_hexdump/alignment",
+                    test_qemu_hexdump_alignment);
+
     return g_test_run();
 }
-- 
2.48.1


