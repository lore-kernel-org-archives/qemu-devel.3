Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082ADCAC58D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqadb-00066q-Vo; Tue, 17 Sep 2024 12:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1sqadT-0005hl-NW
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1sqadS-0003cv-0r
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726588860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTL0T9qjRY4gz3VAtm89351p56EMy1GGu5FJYEwiCa0=;
 b=W6v9lyINLW8kSd5feLhXC9supxSc10Gk7TaEQVQahcRYPQgABmRKV2wGaKJZr3sxJSYuLN
 fHE4pnINYPp1aNWCGdBK8DHzkywQKgHgIPTZI9dysDJBTI1hHGm1biKJhDRMfIainZZeCQ
 Pn39b/plLpxRu8vW7cH195jltZ2DFnM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-SOzMyEbQO0uTOYjFN-E2Rg-1; Tue,
 17 Sep 2024 12:00:56 -0400
X-MC-Unique: SOzMyEbQO0uTOYjFN-E2Rg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C1721955F09
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 16:00:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.82])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FEC630001A4; Tue, 17 Sep 2024 16:00:53 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RESEND v4 1/4] target/i386: Fix conditional CONFIG_SYNDBG
 enablement
Date: Tue, 17 Sep 2024 18:00:48 +0200
Message-ID: <20240917160051.2637594-2-vkuznets@redhat.com>
In-Reply-To: <20240917160051.2637594-1-vkuznets@redhat.com>
References: <20240917160051.2637594-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Putting HYPERV_FEAT_SYNDBG entry under "#ifdef CONFIG_SYNDBG" in
'kvm_hyperv_properties' array is wrong: as HYPERV_FEAT_SYNDBG is not
the highest feature number, the result is an empty (zeroed) entry in
the array (and not a skipped entry!). hyperv_feature_supported() is
designed to check that all CPUID bits are set but for a zeroed
feature in 'kvm_hyperv_properties' it returns 'true' so QEMU considers
HYPERV_FEAT_SYNDBG as always supported, regardless of whether KVM host
actually supports it.

To fix the issue, leave HYPERV_FEAT_SYNDBG's definition in
'kvm_hyperv_properties' array, there's nothing wrong in having it defined
even when 'CONFIG_SYNDBG' is not set. Instead, put "hv-syndbg" CPU property
under '#ifdef CONFIG_SYNDBG' to alter the existing behavior when the flag
is silently skipped in !CONFIG_SYNDBG builds.

Leave an 'assert' sentinel in hyperv_feature_supported() making sure there
are no 'holes' or improperly defined features in 'kvm_hyperv_properties'.

Fixes: d8701185f40c ("hw: hyperv: Initial commit for Synthetic Debugging device")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c     |  2 ++
 target/i386/kvm/kvm.c | 11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c04e..62d4fdfd599a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8291,8 +8291,10 @@ static Property x86_cpu_properties[] = {
                       HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
     DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
                             hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
+#ifdef CONFIG_SYNDBG
     DEFINE_PROP_BIT64("hv-syndbg", X86CPU, hyperv_features,
                       HYPERV_FEAT_SYNDBG, 0),
+#endif
     DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false),
     DEFINE_PROP_BOOL("hv-enforce-cpuid", X86CPU, hyperv_enforce_cpuid, false),
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ada581c5d6ea..4009fcfd6b29 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1035,7 +1035,6 @@ static struct {
              .bits = HV_DEPRECATING_AEOI_RECOMMENDED}
         }
     },
-#ifdef CONFIG_SYNDBG
     [HYPERV_FEAT_SYNDBG] = {
         .desc = "Enable synthetic kernel debugger channel (hv-syndbg)",
         .flags = {
@@ -1044,7 +1043,6 @@ static struct {
         },
         .dependencies = BIT(HYPERV_FEAT_SYNIC) | BIT(HYPERV_FEAT_RELAXED)
     },
-#endif
     [HYPERV_FEAT_MSR_BITMAP] = {
         .desc = "enlightened MSR-Bitmap (hv-emsr-bitmap)",
         .flags = {
@@ -1296,6 +1294,13 @@ static bool hyperv_feature_supported(CPUState *cs, int feature)
     uint32_t func, bits;
     int i, reg;
 
+    /*
+     * kvm_hyperv_properties needs to define at least one CPUID flag which
+     * must be used to detect the feature, it's hard to say whether it is
+     * supported or not otherwise.
+     */
+    assert(kvm_hyperv_properties[feature].flags[0].func);
+
     for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); i++) {
 
         func = kvm_hyperv_properties[feature].flags[i].func;
@@ -3924,13 +3929,11 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                 kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_STATUS,
                                   env->msr_hv_tsc_emulation_status);
             }
-#ifdef CONFIG_SYNDBG
             if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNDBG) &&
                 has_msr_hv_syndbg_options) {
                 kvm_msr_entry_add(cpu, HV_X64_MSR_SYNDBG_OPTIONS,
                                   hyperv_syndbg_query_options());
             }
-#endif
         }
         if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_APIC_ASSIST_PAGE,
-- 
2.46.0


