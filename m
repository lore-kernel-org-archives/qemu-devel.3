Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDD3CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcz6m-0004ex-IA; Fri, 26 Jun 2026 01:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcz6l-0004ep-6X
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:28:07 -0400
Received: from out-179.mta0.migadu.com ([2001:41d0:1004:224b::b3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcz6j-0005ub-Oi
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:28:06 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782451684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TxTZUdCW6q4WC90uZ3+/hnAWbIGD9ch+ubW2pdJ3x0c=;
 b=Fe6RATKTV8hyGoveRiyE8al9eBuYGKG0V1GLu6P0ftyKEO7cLM3TdmEEv/aHYwGNIvF9la
 /Tx1MdMn7tiyADe9xhrXIFFsfsN/Nm4PqSHOId+2CJ2vGU+N+yOOwqGaMZjG15AQnTlWH4
 sxN9W94XL1u3jFhuFqieFW/xdExP4ns=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 3/4] target/loongarch/kvm: remove redundant cpucfg failure
 traces
Date: Fri, 26 Jun 2026 13:27:41 +0800
Message-ID: <20260626052742.810726-4-cui.tao@linux.dev>
In-Reply-To: <20260626052742.810726-1-cui.tao@linux.dev>
References: <20260626052742.810726-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b3;
 envelope-from=cui.tao@linux.dev; helo=out-179.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

kvm_get_one_reg() and kvm_set_one_reg() already trace on failure, so the
trace_kvm_failed_get_cpucfg()/trace_kvm_failed_put_cpucfg() calls in
kvm_loongarch_get_cpucfg() and kvm_loongarch_put_cpucfg() duplicate that.
Remove the calls and the now-unused trace events.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 target/loongarch/kvm/kvm.c    | 6 ------
 target/loongarch/trace-events | 2 --
 2 files changed, 8 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 4bb5be6864..a504cfaaf7 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -714,9 +714,6 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
 
     for (i = 0; i < 21; i++) {
         ret = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
-        if (ret < 0) {
-            trace_kvm_failed_get_cpucfg(strerror(errno));
-        }
         env->cpucfg[i] = (uint32_t)val;
     }
     return ret;
@@ -777,9 +774,6 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
 	}
         val = env->cpucfg[i];
         ret = kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
-        if (ret < 0) {
-            trace_kvm_failed_put_cpucfg(strerror(errno));
-        }
     }
     return ret;
 }
diff --git a/target/loongarch/trace-events b/target/loongarch/trace-events
index dea11edc0f..829d8e0f53 100644
--- a/target/loongarch/trace-events
+++ b/target/loongarch/trace-events
@@ -9,7 +9,5 @@ kvm_failed_get_mpstate(const char *msg) "Failed to get mp_state from KVM: %s"
 kvm_failed_put_mpstate(const char *msg) "Failed to put mp_state into KVM: %s"
 kvm_failed_get_counter(const char *msg) "Failed to get counter from KVM: %s"
 kvm_failed_put_counter(const char *msg) "Failed to put counter into KVM: %s"
-kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
-kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"
 kvm_arch_handle_exit(int num) "kvm arch handle exit, the reason number: %d"
 kvm_set_intr(int irq, int level) "kvm set interrupt, irq num: %d, level: %d"
-- 
2.43.0


