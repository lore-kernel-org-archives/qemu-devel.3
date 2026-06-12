Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F97CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 05:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXutL-00037e-Ti; Fri, 12 Jun 2026 01:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wXutG-00037V-3R
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 01:57:15 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wXutE-00006t-5v
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 01:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1781243805;
 bh=oepmFzdkGxwzQwIbtp1zCNSDrIqQZG5Jbas+qzcdf9E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EtgpgmbN7DqRY5VXE9nKYLRMDyQgNeTHxpY7sVawv4ei4rb9mZvbvqPFacCXx4d2d
 TfnvWdWTDBeFqOGainhYn45QhLwmaDZZOm9/RDXT7p2XblkrNwZ4L9tTvniNqztMOC
 ByqRHKbfCYLwpkvB70SeFxsETMKWyO7jFrGAcWHZErRsPnxVXG2/mxMqm7q8ReyNPy
 5HbRJS9ZDu0UQt1egSi7t+qxcH8Z/ihGgJfSEfVoPMFgqEKywEAoznRaXbAmXA1sto
 DPu+XiMUak+CVZRUkzHdqzboCfTCPT3ifJEurAoixtwcy14xA1gi7rXLkzznBPnuSL
 kRDdcHSqfvw/Q==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 9610A2FF559;
 Fri, 12 Jun 2026 05:56:45 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id CDBC237C945;
 Fri, 12 Jun 2026 13:56:44 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH 1/1] plugins: use int64_t for the syscall filter return value
Date: Fri, 12 Jun 2026 13:56:42 +0800
Message-Id: <20260612055642.589337-2-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612055642.589337-1-functioner@sjtu.edu.cn>
References: <20260612055642.589337-1-functioner@sjtu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
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

The syscall return value passed back through the syscall filter
callback is semantically signed: negative values encode errno codes.
Declaring the sysret pointer as uint64_t * is therefore misleading and
forces callers to launder the value through an unsigned temporary.

Change the sysret pointer to int64_t * across the public plugin API
typedef (qemu_plugin_vcpu_syscall_filter_cb_t), the internal
qemu_plugin_vcpu_syscall_filter() prototypes and stub, its
implementation in plugins/core.c, the linux-user caller, and the
in-tree example plugins.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 include/plugins/qemu-plugin.h | 2 +-
 include/qemu/plugin.h         | 4 ++--
 linux-user/syscall.c          | 2 +-
 plugins/core.c                | 2 +-
 tests/tcg/plugins/setpc.c     | 2 +-
 tests/tcg/plugins/syscall.c   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 4eb1d2cd85..8eb10b1f48 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -870,7 +870,7 @@ typedef bool
                                         int64_t num, uint64_t a1, uint64_t a2,
                                         uint64_t a3, uint64_t a4, uint64_t a5,
                                         uint64_t a6, uint64_t a7, uint64_t a8,
-                                        uint64_t *sysret);
+                                        int64_t *sysret);
 
 /**
  * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callback
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index ddd77bd82c..1ce4b281c1 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -174,7 +174,7 @@ bool
 qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
                                 uint64_t a2, uint64_t a3, uint64_t a4,
                                 uint64_t a5, uint64_t a6, uint64_t a7,
-                                uint64_t a8, uint64_t *sysret);
+                                uint64_t a8, int64_t *sysret);
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              uint64_t value_low,
@@ -290,7 +290,7 @@ static inline bool
 qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
                                 uint64_t a2, uint64_t a3, uint64_t a4,
                                 uint64_t a5, uint64_t a6, uint64_t a7,
-                                uint64_t a8, uint64_t *sysret)
+                                uint64_t a8, int64_t *sysret)
 {
     return false;
 }
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f4b74ad350..63c0a5f8f3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -14378,7 +14378,7 @@ static bool send_through_syscall_filters(CPUState *cpu, int num,
                                          abi_long arg7, abi_long arg8,
                                          abi_long *sysret)
 {
-    uint64_t sysret64 = 0;
+    int64_t sysret64 = 0;
     bool filtered = qemu_plugin_vcpu_syscall_filter(cpu, num, arg1, arg2,
                                                     arg3, arg4, arg5, arg6,
                                                     arg7, arg8, &sysret64);
diff --git a/plugins/core.c b/plugins/core.c
index 2324bbffa3..58f293462a 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -596,7 +596,7 @@ bool
 qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
                                 uint64_t a2, uint64_t a3, uint64_t a4,
                                 uint64_t a5, uint64_t a6, uint64_t a7,
-                                uint64_t a8, uint64_t *sysret)
+                                uint64_t a8, int64_t *sysret)
 {
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER;
diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
index 8f2d025e24..23862eaaf0 100644
--- a/tests/tcg/plugins/setpc.c
+++ b/tests/tcg/plugins/setpc.c
@@ -27,7 +27,7 @@ static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
-                                uint64_t *sysret)
+                                int64_t *sysret)
 {
     if (num == MAGIC_SYSCALL) {
         if (a1 == SETPC) {
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 5658f83087..76d52b98aa 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -174,7 +174,7 @@ static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
-                                uint64_t *sysret)
+                                int64_t *sysret)
 {
     /* Special syscall to test the filter functionality. */
     if (num == 4096 && a1 == 0x66CCFF) {
-- 
2.34.1


