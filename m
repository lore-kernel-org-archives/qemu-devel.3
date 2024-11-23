Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5F5D75E59
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 17:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEtt9-0007b7-At; Sat, 23 Nov 2024 12:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1tEtt6-0007ak-T3
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 12:25:40 -0500
Received: from mail-m16.yeah.net ([1.95.21.14])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1tEtt3-0004w5-MX
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 12:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=uKwHW
 jShufMHBcTZLFomKSK7fPKKewu7QEVWXclnG/M=; b=a3EuX9mgNYXAxxNdnMFoK
 FJ4vjTG5ujq+9d8PeSyXwaCA9qkI+t7p/tPI0DBf4XuWqE8eCroPDUr1pg03Hq+X
 XFolujHlrHmDsVUlxJmGInDLzSLaftmw0GY3Q9zbJzn0dqyFN/ygo3lySH3C96tE
 Uzr++EirKsIKXEyrloBRGw=
Received: from ulan.. (unknown [])
 by gzsmtp2 (Coremail) with SMTP id Ms8vCgDX3zD8D0JnTuE_Aw--.3002S3;
 Sun, 24 Nov 2024 01:25:18 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: bmeng.cn@gmail.com, liwei1518@gmail.com, peter.maydell@linaro.org,
 palmer@dabbelt.com, alistair.francis@wdc.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Chao Liu <chao.liu@yeah.net>
Subject: [RFC PATCH v1 1/1] riscv: Add helper_print() for printing
 intermediate results of IR
Date: Sun, 24 Nov 2024 01:23:38 +0800
Message-ID: <b516765922b56fcfd5a16ceaf46428dbdfe0e41f.1732376265.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732376265.git.chao.liu@yeah.net>
References: <cover.1732376265.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ms8vCgDX3zD8D0JnTuE_Aw--.3002S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF48KF1rZw1xuw1UKr4xXrb_yoW5GFW7pa
 17CF45tFWUArZ7Ja1Sya4jkw15JrZ7Gw1YvFs2yFWxAa13G3ykXa1DKrnIgF1UWFy5W3Wj
 9F1q9w15Cr47XFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jKmhwUUUUU=
X-Originating-IP: [39.144.154.56]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiCRqgKGdBs2rIGgAAs2
Received-SPF: pass client-ip=1.95.21.14; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Chao Liu <chao.liu@yeah.net>
---
 target/riscv/helper.h    | 13 ++++++++++++
 target/riscv/op_helper.c | 46 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 451261ce5a..667da16988 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1281,3 +1281,16 @@ DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
 DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
+
+DEF_HELPER_1(print1, void, ptr)
+DEF_HELPER_2(print2, void, ptr, tl)
+DEF_HELPER_3(print3, void, ptr, tl, tl)
+DEF_HELPER_4(print4, void, ptr, tl, tl, tl)
+DEF_HELPER_5(print5, void, ptr, tl, tl, tl, tl)
+DEF_HELPER_6(print6, void, ptr, tl, tl, tl, tl, tl)
+DEF_HELPER_7(print7, void, ptr, tl, tl, tl, tl, tl, tl)
+
+#define gen_helper_print(num, fmt, ...) do { \
+    assert(num >= 1 && num <= 7); \
+    gen_helper_print##num(tcg_constant_ptr((uintptr_t)fmt), __VA_ARGS__); \
+} while(0)
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index eddedacf4b..f45e1b9a50 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -564,3 +564,49 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong addr)
 }
 
 #endif /* !CONFIG_USER_ONLY */
+
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wformat-security"
+
+void helper_print1(void *fmt)
+{
+    printf((const char *)fmt);
+}
+
+void helper_print2(void *fmt, target_ulong arg2)
+{
+   printf((const char *)fmt, arg2);
+}
+
+void helper_print3(void *fmt, target_ulong arg2, target_ulong arg3)
+{
+     printf((const char *)fmt, arg2, arg3);
+}
+
+void helper_print4(void *fmt, target_ulong arg2, target_ulong arg3,
+                   target_ulong arg4)
+{
+    printf((const char *)fmt, arg2, arg3, arg4);
+}
+
+void helper_print5(void *fmt, target_ulong arg2, target_ulong arg3,
+                   target_ulong arg4, target_ulong arg5)
+{
+    printf((const char *)fmt, arg2, arg3, arg4, arg5);
+}
+
+void helper_print6(void *fmt, target_ulong arg2, target_ulong arg3,
+                   target_ulong arg4, target_ulong arg5, target_ulong arg6)
+{
+    printf((const char *)fmt, arg2, arg3, arg4, arg5, arg6);
+}
+
+void helper_print7(void *fmt, target_ulong arg2, target_ulong arg3,
+                   target_ulong arg4, target_ulong arg5, target_ulong arg6,
+                   target_ulong arg7)
+{
+    printf((const char *)fmt, arg2, arg3, arg4, arg5, arg6, arg7);
+}
+
+#pragma GCC diagnostic pop
+
-- 
2.40.1


