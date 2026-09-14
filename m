Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E756EC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x651m-0008Ve-9C; Mon, 14 Sep 2026 07:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x651P-0008TT-IK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:38:53 -0400
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x651K-0000no-VH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1789385913; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=WkyuMTSbGlEV93Svm6wlWfW9DWPAeHxv4B0O9qlKeCo=;
 b=AnaveKa2CPQb0Amt01omnLl/AYjBFfi/3tzR6NSnGQJw3L1kHTazAMNopznVZoAVEPPv85
 NNxKR4L2X9/stb9cJcFEYHJOGMCAVDzY3HexNz4XHWDQ+6HNGLfajmy4Qn7G/zlzuvousd
 3PXoAVd9VFGRhKJlekTvly08bTT8Y/I6QunRx4ZFuSyQS7421E6a3G/T4pBi+kyVyotDJi
 UET0R1G4qbjxuwbXsOB6Pyg59FjuBc9bc+KqwjlYc61/7DEwLNweiN2IPfiEvAsbehYCUx
 Ox+c7ALQ+eQIAtHQszBl9k+xZsk1kDwnWN7ObjF6Puy2cfAsep16aVGrF6uxbQ==
Cc: <zhao1.liu@intel.com>, <richard.henderson@linaro.org>, 
 <pbonzini@redhat.com>, <mst@redhat.com>, <peterx@redhat.com>, 
 <isyanfei.xu@gmail.com>, <liyuxuan.darfux@bytedance.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>, <qemu-stable@nongnu.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26aa7dcb7+d4a219+nongnu.org+yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>
Subject: [PATCH] target/i386: Migrate error code only with an exception
X-Mailer: git-send-email 2.20.1
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Date: Mon, 14 Sep 2026 19:38:17 +0800
Message-Id: <20260914113817.2212058-1-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=209.127.230.112;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-112.ptr.blmpb.com
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

An exception that carries an error code must retain it across migration.
Otherwise the destination reinjects it with error_code 0, which can make
the guest panic. Do not suppress this required state for old machine
types; an incompatible destination should abort migration instead.

The chance of stopping a vCPU while an exception is pending or injected
is extremely low, so the cpu/error_code subsection should rarely be
needed.

It is currently emitted much more often because KVM does not clear
has_error_code and error_code after completing exception injection.
Require a valid exception_nr before sending the subsection. This filters
stale KVM state while preserving the error code for a real exception.

Fixes: 1b80f1009d ("target/i386: add compat for migrating error code")
Cc: qemu-stable@nongnu.org
Reported-by: Yuxuan Li <liyuxuan.darfux@bytedance.com>
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 hw/i386/pc.c          | 1 -
 target/i386/cpu.c     | 1 -
 target/i386/cpu.h     | 1 -
 target/i386/machine.c | 2 +-
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e9e4fc262b..1cfe1a50f7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -85,7 +85,6 @@ const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
 
 GlobalProperty pc_compat_10_1[] = {
     { "mch", "extended-tseg-mbytes", "16" },
-    { TYPE_X86_CPU, "x-migrate-error-code", "false" },
 };
 const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e5ffb10d15..6f295d5325 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10819,7 +10819,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
     DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
                      true),
-    DEFINE_PROP_BOOL("x-migrate-error-code", X86CPU, migrate_error_code, true),
     /*
      * lecacy_cache defaults to true unless the CPU model provides its
      * own cache information (see x86_cpu_load_def()).
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 641f3ee5c2..2fdc610539 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2379,7 +2379,6 @@ struct ArchCPU {
     bool expose_tcg;
     bool migratable;
     bool migrate_smi_count;
-    bool migrate_error_code;
     uint32_t apic_id;
 
     /* Enables publishing of TSC increment and Local APIC bus frequencies to
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 8d69d7e25e..b5c6b127c9 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -466,7 +466,7 @@ static bool cpu_errcode_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
 
-    return cpu->env.has_error_code != 0 && cpu->migrate_error_code;
+    return cpu->env.exception_nr != -1 && cpu->env.has_error_code != 0;
 }
 
 static const VMStateDescription vmstate_error_code = {
-- 
2.20.1

