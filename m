Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A1DC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbWT-0004jH-5X; Fri, 23 Feb 2024 14:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawI-0005ns-Fy
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawG-0005HI-Ge
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708715425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWnvkcpd64dmJIVKz8lboK1m9g0wbAxCnQNFypzKJRE=;
 b=PaT9srlu3cPNG/9JCAAUtbW9HyICIKU83NVuyKkcXIcyE4xZWJKXqgziQ/AeBU0TKoq27i
 yuHGKfv4RSwcicZQxEKjeyqYWd205Murla7ZLulzUdGD7q1pJQpDYzXxhuNy2ioDFi7yCm
 YFXRGOaRs2QjOCph5lRRvA2EhGtAeJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-AaD5nQ2JOUKvzLGCW6cT-A-1; Fri, 23 Feb 2024 14:10:21 -0500
X-MC-Unique: AaD5nQ2JOUKvzLGCW6cT-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B8EE106D021;
 Fri, 23 Feb 2024 19:10:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F163E8CED;
 Fri, 23 Feb 2024 19:10:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 11/11] target/i386: do not filter processor tracing features
 except on KVM
Date: Fri, 23 Feb 2024 20:10:03 +0100
Message-ID: <20240223191003.6268-12-thuth@redhat.com>
In-Reply-To: <20240223191003.6268-1-thuth@redhat.com>
References: <20240223191003.6268-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

The processor tracing features in cpu_x86_cpuid() are hardcoded to a set
that should be safe on all processor that support PT virtualization.
But as an additional check, x86_cpu_filter_features() also checks
that the accelerator supports that safe subset, and if not it marks
CPUID_7_0_EBX_INTEL_PT as unavailable.

This check fails on accelerators other than KVM, but it is actually
unnecessary to do it because KVM is the only accelerator that uses the
safe subset.  Everything else just provides nonzero values for CPUID
leaf 0x14 (TCG/HVF because processor tracing is not supported; qtest
because nothing is able to read CPUID anyway).  Restricting the check
to KVM fixes a warning with the qtest accelerator:

    $ qemu-system-x86_64 -display none -cpu max,mmx=off -accel qtest
    qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.07H:EBX.intel-pt [bit 25]

The warning also happens in the test-x86-cpuid-compat qtest.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2096
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240221162910.101327-1-pbonzini@redhat.com>
Fixes: d047402436 ("target/i386: Call accel-agnostic x86_cpu_get_supported_cpuid()")
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/cpu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bca776e1fe..7f90823676 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6412,6 +6412,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         }
 
+        /*
+         * If these are changed, they should stay in sync with
+         * x86_cpu_filter_features().
+         */
         if (count == 0) {
             *eax = INTEL_PT_MAX_SUBLEAF;
             *ebx = INTEL_PT_MINIMAL_EBX;
@@ -7156,7 +7160,12 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
-    if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) {
+    /*
+     * Check that KVM actually allows the processor tracing features that
+     * are advertised by cpu_x86_cpuid().  Keep these two in sync.
+     */
+    if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
+        kvm_enabled()) {
         uint32_t eax_0, ebx_0, ecx_0, edx_0_unused;
         uint32_t eax_1, ebx_1, ecx_1_unused, edx_1_unused;
 
-- 
2.43.2


