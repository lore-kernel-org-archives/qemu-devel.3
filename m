Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4928CC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdpoY-0002kh-H5; Tue, 13 Aug 2024 07:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpoW-0002jf-GF; Tue, 13 Aug 2024 07:35:44 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpoU-0002UW-Et; Tue, 13 Aug 2024 07:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1723548937; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=/d1sDtis43VunngbSIzdip5vT8h3Xv64FIWtRrW2dj4=;
 b=adF6NbmFAd4RNUAsFGYPTUyORpZGuO6AwAVYouMz2H1eGmGv2j7mkTSEPrEuwU8ec5D7aIKilomObp3SF/CgEv57XfZcx5JLOhw9yWBaPHWxqM2FVmdGbKMG3ryX6UFbWC2m9znsxVEdXGiRyAKD72Wxap5C2GuGGG2j7+lhQxE=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WCoya3q_1723548935) by smtp.aliyun-inc.com;
 Tue, 13 Aug 2024 19:35:36 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 01/15] util: Add RISC-V vector extension probe in cpuinfo
Date: Tue, 13 Aug 2024 19:34:22 +0800
Message-Id: <20240813113436.831-2-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Add support for probing RISC-V vector extension availability in
the backend. This information will be used when deciding whether
to use vector instructions in code generation.

While the compiler doesn't support RISCV_HWPROBE_EXT_ZVE64X,
we use RISCV_HWPROBE_IMA_V instead.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 host/include/riscv/host/cpuinfo.h |  1 +
 util/cpuinfo-riscv.c              | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv/host/cpuinfo.h
index 2b00660e36..bf6ae51f72 100644
--- a/host/include/riscv/host/cpuinfo.h
+++ b/host/include/riscv/host/cpuinfo.h
@@ -10,6 +10,7 @@
 #define CPUINFO_ZBA             (1u << 1)
 #define CPUINFO_ZBB             (1u << 2)
 #define CPUINFO_ZICOND          (1u << 3)
+#define CPUINFO_ZVE64X          (1u << 4)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
index 497ce12680..551821edef 100644
--- a/util/cpuinfo-riscv.c
+++ b/util/cpuinfo-riscv.c
@@ -33,7 +33,7 @@ static void sigill_handler(int signo, siginfo_t *si, void *data)
 /* Called both as constructor and (possibly) via other constructors. */
 unsigned __attribute__((constructor)) cpuinfo_init(void)
 {
-    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND;
+    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND | CPUINFO_ZVE64X;
     unsigned info = cpuinfo;
 
     if (info) {
@@ -49,6 +49,9 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 #endif
 #if defined(__riscv_arch_test) && defined(__riscv_zicond)
     info |= CPUINFO_ZICOND;
+#endif
+#if defined(__riscv_arch_test) && defined(__riscv_zve64x)
+    info |= CPUINFO_ZVE64X;
 #endif
     left &= ~info;
 
@@ -64,7 +67,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
             && pair.key >= 0) {
             info |= pair.value & RISCV_HWPROBE_EXT_ZBA ? CPUINFO_ZBA : 0;
             info |= pair.value & RISCV_HWPROBE_EXT_ZBB ? CPUINFO_ZBB : 0;
-            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB);
+            info |= pair.value & RISCV_HWPROBE_IMA_V ? CPUINFO_ZVE64X : 0;
+            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZVE64X);
 #ifdef RISCV_HWPROBE_EXT_ZICOND
             info |= pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZICOND : 0;
             left &= ~CPUINFO_ZICOND;
@@ -108,6 +112,18 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
             left &= ~CPUINFO_ZICOND;
         }
 
+        if (left & CPUINFO_ZVE64X) {
+            /* Probe for Vector: vsetivli t0,1,e64,m1,ta,ma */
+            unsigned vl;
+            got_sigill = 0;
+
+            asm volatile(
+                "vsetivli %0, 1, e64, m1, ta, ma\n\t"
+                : "=r"(vl) : : "vl"
+            );
+            info |= (got_sigill || vl != 1) ? 0 : CPUINFO_ZVE64X;
+        }
+
         sigaction(SIGILL, &sa_old, NULL);
         assert(left == 0);
     }
-- 
2.43.0


