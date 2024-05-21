Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8C7C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9MoC-0003Uz-E2; Tue, 21 May 2024 06:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1s9MoA-0003UQ-Ps; Tue, 21 May 2024 06:33:26 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1s9Mo7-0003mL-9u; Tue, 21 May 2024 06:33:26 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1716287596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2FZJI5bC5rYHRJ4t3NDgfgJ4GTBSWWKL8FOPQ6OP+gk=;
 b=UEfiqfCFwHLRVkYIb1QxVKX7KrUOvsJEnE+dC5IKkbqoa4JxwUFDz9RJR4cpeetxtUl1sH
 E+blZZco684yuQhE12MMByzQ9lCTkFPHPsyHpDP6YMxkM0/pgq4e0rJ+OYZNL5S0sNdkya
 d2i3bHKn44bnbkl6Z+uIiJp0NdLeQyg=
To: alxndr@bu.edu
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, sdl.qemu@linuxtesting.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] tests/qtest/fuzz: fix memleak in qos_fuzz.c
Date: Tue, 21 May 2024 13:31:08 +0300
Message-ID: <20240521103106.119021-3-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
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

Found with fuzzing for qemu-8.2, but also relevant for master

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 tests/qtest/fuzz/qos_fuzz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index b71e945c5f..d3839bf999 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -180,6 +180,7 @@ static void walk_path(QOSGraphNode *orig_path, int len)
 
         fuzz_path_vec = path_vec;
     } else {
+        g_string_free(cmd_line, true);
         g_free(path_vec);
     }
 
-- 
2.43.0


