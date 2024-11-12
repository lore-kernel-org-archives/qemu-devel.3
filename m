Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453E6D41D5E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 06:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAkXF-0002tq-LT; Tue, 12 Nov 2024 01:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tAkXD-0002tg-6N
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 01:37:55 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tAkXB-000344-9h
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 01:37:54 -0500
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1731393468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9v2033SJfAJcOZ+OYcQFgb3TtfKw5Bm3lnB3t4xYJZg=;
 b=deqJdepG6EgVUMXTGCaxLCpFZ8YVHGcJ8WiJZaoHkzXX3wpnBeyJaQRTRUb4LCWdrab+2R
 36IUwz+Fnz+UrJadc5PtSsIe+KHgMLzt6WfdlNOw4cTcJSY1cdCgBZ6RVzGoe1NyjAaUzB
 fSkJtYzltg4PxNwW0ApgM+E6LaWUxqY=
To: farosas@suse.de,
	lvivier@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] tests/qtest: fix non portable env varibles access
Date: Tue, 12 Nov 2024 09:36:59 +0300
Message-ID: <20241112063703.116386-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
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

"int main(int argc, char **argv, char** envp)" is non-standart
Microsoft`s extention of the C language and it`s not portable.
In my particular case (Debian 13, clang-16) this raises wild-pointer
dereference with ASAN message "heap-use-after-free".

v2: changed confusing commit header

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 tests/qtest/qos-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 114f6bef27..e8ac00f0f7 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -326,7 +326,7 @@ static void walk_path(QOSGraphNode *orig_path, int len)
  *   machine/drivers/test objects
  * - Cleans up everything
  */
-int main(int argc, char **argv, char** envp)
+int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
@@ -336,7 +336,7 @@ int main(int argc, char **argv, char** envp)
 
     if (g_test_verbose()) {
         qos_printf("ENVIRONMENT VARIABLES: {\n");
-        for (char **env = envp; *env != 0; env++) {
+        for (char **env = environ; *env != 0; env++) {
             qos_printf("\t%s\n", *env);
         }
         qos_printf("}\n");
-- 
2.43.0


