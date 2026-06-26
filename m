Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5349CDE010
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcz6r-0004fb-UH; Fri, 26 Jun 2026 01:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcz6p-0004fS-W7
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:28:12 -0400
Received: from out-181.mta0.migadu.com ([91.218.175.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcz6o-0005vt-7z
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:28:11 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782451688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nr2zSsNGrXzFQ1+5UlolMhYIxbSmmhdZyOj5h2llqCQ=;
 b=PTHQ4GOIT91Vlgte7sHs30nm3M3j04maj5b3w73e0D75qjj2gDExq4gji6XlMFUEp8ZrJU
 juoY8C+wI7NyWKSraY5++gGZ4IimxiyQE2esmqzBF3s8SAYqP8w8noesua6cDxSJqtbx78
 IsLQXoLLrA6AUL4AEx7ah1Xptdy9EWY=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 4/4] target/loongarch/kvm: fix cpucfg sync error handling
Date: Fri, 26 Jun 2026 13:27:42 +0800
Message-ID: <20260626052742.810726-5-cui.tao@linux.dev>
In-Reply-To: <20260626052742.810726-1-cui.tao@linux.dev>
References: <20260626052742.810726-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.181; envelope-from=cui.tao@linux.dev;
 helo=out-181.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Tao Cui <cuitao@kylinos.cn>

In kvm_loongarch_get_cpucfg() and kvm_loongarch_put_cpucfg(), ret is
overwritten on each iteration, so only the last register's result is
returned and earlier failures are lost. On a failed read, env->cpucfg[i]
is stored from a stale or uninitialized val.

Accumulate errors with ret |=, matching kvm_loongarch_get_csr()/put_csr(),
and only update env->cpucfg[i] on a successful read. Keep the cpucfg2
negotiation check in put_cpucfg() on a separate variable so its early
return does not overwrite the accumulated result.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 target/loongarch/kvm/kvm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index a504cfaaf7..9f1ee41ef6 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -713,8 +713,11 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
     CPULoongArchState *env = cpu_env(cs);
 
     for (i = 0; i < 21; i++) {
-        ret = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
-        env->cpucfg[i] = (uint32_t)val;
+        int r = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
+        ret |= r;
+        if (!r) {
+            env->cpucfg[i] = (uint32_t)val;
+        }
     }
     return ret;
 }
@@ -767,13 +770,13 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
 
     for (i = 0; i < 21; i++) {
 	if (i == 2) {
-            ret = kvm_check_cpucfg2(cs);
-            if (ret) {
-                return ret;
+            int r = kvm_check_cpucfg2(cs);
+            if (r) {
+                return r;
             }
 	}
         val = env->cpucfg[i];
-        ret = kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
+        ret |= kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
     }
     return ret;
 }
-- 
2.43.0


