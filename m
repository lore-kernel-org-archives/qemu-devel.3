Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1F9C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcgN-0004i9-UF; Thu, 27 Aug 2026 12:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzcgE-0004a6-RF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:10:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzcgD-0007vn-5P
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:10:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49b0d8bc2aaso14770735e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787847015; x=1788451815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uz+m+PYTKCS5EAzXIW/GJIgQvknTl5oB//P+gzk9O0A=;
 b=sO0spgSHGmQ2dG0FxFh+QVfXUZpc1vCkh9ac/Z6FFRleePHn11NxLmcZMkZDVhIpg6
 s3lJySpyEgm435mjRqSvTiScfT3XE2/gjBMq5bxkGIlQP+dVqGHqg/M1LsJn/GN7HTKG
 oQ0bK/i8Q3ZQiQIk9DTJDkhnWKVqm2Rgqz7FKp0g/K0sa/c4FtdfDsyhK6O2Kk7sR/u1
 /kZd+IuTBdG5z43cvIemf350tbiZt3DMGpDx42aZw+ZxLabW87LwP1kQRvc8mCHUHQQv
 5sMHO3oO4N0VK22Wc0nmwEtY7WlYI2QL47KLxkNVRtmKaPew/f2uzbBgLJtO+FDBSe96
 jwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787847015; x=1788451815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uz+m+PYTKCS5EAzXIW/GJIgQvknTl5oB//P+gzk9O0A=;
 b=We2cLI+fw7r9z1quTI/3Rg8G8PZwZZJDcClkhbUBLaN5nGDX8widOUOBf0VolnVRzy
 w485JBBMzdZNmPgO3e7/6Nm0+6k08qA9fj1n4BYJaj3cAHUzBNPWGY/yZmpWcmIrmXoX
 VvnN5iM1i52n6YRrjuzp5AZuIg2SpYxrkq6xdE0ohZJXZm1+OM48WlauVqXTaRAE5mr0
 xiakefrMkbQzZAMcS8umfKpbkpe3eURTA1+wtKh53U4N8D6+0i6Cc1dtRgUCL8dVrgQr
 kln5rRWv0VU4agaZKJ27WwxsAKoGYIbEkbwTcZLBKVBqswXOW95xvDcfrHHpUQRq14pa
 qssQ==
X-Gm-Message-State: AFuF++nBCRmfuOjiLyJUeBCySbITd30J61WBO0PW3jq80dG1vGynLAOn
 ebLQ6eOjURbxmM7LsxkNKnIDj/Idcp10PzAFmKDR81+d8YorOi8Ft5NqI2NtkPYX/EsNn/AJ0Rg
 NPzje
X-Gm-Gg: AR+sD129xHvgr3FdzpmysvTK4vDLFp5rHImcujRjgqYZv44Udf7EDIQDN96whT8Q4bh
 eMXRqxeDrKq9ikR4CGR18/itC+VWXYE72rBez5xe7LRQOQ88ZrU3Eukz5Pbw+g9hcZ5NmRqqMMt
 k9QIlAD8fIxkjdymA/V2wvbOU2oO6MUcThoyDQ6uQFJdU8sXTQb2p2iQFjKliUaU+2XmtiBtINf
 gI+cMQYDl98mvLFKMpXbn3W/Os1DNxFKiLT+Lns8Jgta91GbofnCJaFy/OieqUCCIbPes/yXXeJ
 NQp5dU8NgmXmjVMlrjZQGHGJzVrNHUCOb2T7l0ozZsZfGjUTGToE7Y1h2dj1Y7WY7rAJIDrb6Qn
 woFWJd5sd78n/aZSwsHAvHTQcgUM7b0kTMZfvVVcohEZBSGfG8lsI9xmUeWRmovH1k9K8CJpqOX
 BpX6yND5Y29ctrl8EkMD7XQdNU919o15k1vSFjgQFvtYmTqR1+
X-Received: by 2002:a05:600c:4744:b0:499:8b13:3a98 with SMTP id
 5b1f17b1804b1-49b91c2479amr117785e9.4.1787847015288; 
 Thu, 27 Aug 2026 09:10:15 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:e57e:de8:330d:26d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5771a3sm71359465e9.4.2026.08.27.09.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 09:10:14 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 4/5] iotests/nbd-commands: cover NBD_CMD_BLOCK_STATUS with
 a payload
Date: Thu, 27 Aug 2026 18:10:01 +0200
Message-ID: <20260827161002.310688-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827161002.310688-1-den@openvz.org>
References: <20260827161002.310688-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=den@openvz.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

With extended headers a client may name the meta contexts it wants in
a request payload. Our own client never sends one, so the server side
of it, nbd_co_block_status_payload_read(), is not exercised anywhere.

Export two meta contexts and ask libnbd for each of them in turn,
which is only answerable through that path.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/nbd-commands     | 14 ++++++++++++--
 tests/qemu-iotests/tests/nbd-commands.out |  4 ++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
index 3dfe913190..09e811724b 100755
--- a/tests/qemu-iotests/tests/nbd-commands
+++ b/tests/qemu-iotests/tests/nbd-commands
@@ -90,7 +90,7 @@ class TestNbdCommands(iotests.QMPTestCase):
             self.h.shutdown()
             self.h = None
 
-    def block_status(self, count=size):
+    def block_status(self, count=size, wanted=None):
         """Map each meta context in the reply to its list of extents."""
         reply = {}
 
@@ -98,7 +98,10 @@ class TestNbdCommands(iotests.QMPTestCase):
             reply.setdefault(meta, []).extend(zip(entries[0::2],
                                                   entries[1::2]))
 
-        self.h.block_status(count, 0, cb)
+        if wanted is None:
+            self.h.block_status(count, 0, cb)
+        else:
+            self.h.block_status_filter(count, 0, wanted, cb)
         return reply
 
     def top_extents(self):
@@ -148,6 +151,13 @@ class TestNbdCommands(iotests.QMPTestCase):
     def test_commands_extended_headers(self):
         self.check_commands(structured=True, extended=True)
 
+    def test_block_status_payload_filter(self):
+        self.assertEqual(sorted(self.block_status()),
+                         ['base:allocation', 'qemu:allocation-depth'])
+
+        for wanted in (['base:allocation'], ['qemu:allocation-depth']):
+            self.assertEqual(sorted(self.block_status(wanted=wanted)), wanted)
+
     def test_cache_past_end_of_export(self):
         self.assertRaises(nbd.Error, self.h.cache, size + 1, 0)
 
diff --git a/tests/qemu-iotests/tests/nbd-commands.out b/tests/qemu-iotests/tests/nbd-commands.out
index 3f8a935a08..2f7d3902f2 100644
--- a/tests/qemu-iotests/tests/nbd-commands.out
+++ b/tests/qemu-iotests/tests/nbd-commands.out
@@ -1,5 +1,5 @@
-......
+.......
 ----------------------------------------------------------------------
-Ran 6 tests
+Ran 7 tests
 
 OK
-- 
2.53.0


