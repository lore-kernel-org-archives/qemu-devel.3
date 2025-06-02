Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79008C5B559
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 17:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM90N-0001Qx-48; Mon, 02 Jun 2025 13:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uM90J-0001QE-UP
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 13:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uM90I-0006XV-AT
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 13:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748885477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4s+1vLMDpzQMZ21vGlIURmxS0rqSAmxa1isajGTlVw=;
 b=WnFWD61xTICcr5W3WOnt8thd0QBofZw3Y+Tybm6Oe8F68+B6/1tTdgBWdxoOF9CBG3xhl+
 NSwqYomTVcnccGdFjsLyVrIifvcRdUaUsyo69qRnnW1FUhTqKqYHhjBYFUw8/pyEivR0mu
 E1kyDDN0UD+gToOOOdw7yHBYYBFwVK8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-LOYTd8MqMyWtMY-kFQcQwg-1; Mon,
 02 Jun 2025 13:31:12 -0400
X-MC-Unique: LOYTd8MqMyWtMY-kFQcQwg-1
X-Mimecast-MFC-AGG-ID: LOYTd8MqMyWtMY-kFQcQwg_1748885471
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4CAF1956078; Mon,  2 Jun 2025 17:31:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.56])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 715B81800371; Mon,  2 Jun 2025 17:31:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 1/2] i386/tdx: Fix build on 32-bit host
Date: Mon,  2 Jun 2025 19:31:00 +0200
Message-ID: <20250602173101.1052983-2-clg@redhat.com>
In-Reply-To: <20250602173101.1052983-1-clg@redhat.com>
References: <20250602173101.1052983-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Use PRI formats where required and fix pointer cast.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 target/i386/kvm/tdx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 0a21ae555c5c..820ca3614e27 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -284,7 +284,7 @@ static void tdx_post_init_vcpus(void)
 
     hob = tdx_get_hob_entry(tdx_guest);
     CPU_FOREACH(cpu) {
-        tdx_vcpu_ioctl(cpu, KVM_TDX_INIT_VCPU, 0, (void *)hob->address,
+        tdx_vcpu_ioctl(cpu, KVM_TDX_INIT_VCPU, 0, (void *)(uintptr_t)hob->address,
                        &error_fatal);
     }
 }
@@ -339,7 +339,7 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
         uint32_t flags;
 
         region = (struct kvm_tdx_init_mem_region) {
-            .source_addr = (uint64_t)entry->mem_ptr,
+            .source_addr = (uintptr_t)entry->mem_ptr,
             .gpa = entry->address,
             .nr_pages = entry->size >> 12,
         };
@@ -893,16 +893,16 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
 static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
 {
     if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
-        error_setg(errp, "Invalid attributes 0x%lx for TDX VM "
-                   "(KVM supported: 0x%llx)", tdx->attributes,
-                   tdx_caps->supported_attrs);
+        error_setg(errp, "Invalid attributes 0x%"PRIx64" for TDX VM "
+                   "(KVM supported: 0x%"PRIx64")", tdx->attributes,
+                   (uint64_t)tdx_caps->supported_attrs);
         return -1;
     }
 
     if (tdx->attributes & ~TDX_SUPPORTED_TD_ATTRS) {
         error_setg(errp, "Some QEMU unsupported TD attribute bits being "
-                    "requested: 0x%lx (QEMU supported: 0x%llx)",
-                    tdx->attributes, TDX_SUPPORTED_TD_ATTRS);
+                    "requested: 0x%"PRIx64" (QEMU supported: 0x%"PRIx64")",
+                    tdx->attributes, (uint64_t)TDX_SUPPORTED_TD_ATTRS);
         return -1;
     }
 
@@ -931,8 +931,8 @@ static int setup_td_xfam(X86CPU *x86cpu, Error **errp)
            env->features[FEAT_XSAVE_XSS_HI];
 
     if (xfam & ~tdx_caps->supported_xfam) {
-        error_setg(errp, "Invalid XFAM 0x%lx for TDX VM (supported: 0x%llx))",
-                   xfam, tdx_caps->supported_xfam);
+        error_setg(errp, "Invalid XFAM 0x%"PRIx64" for TDX VM (supported: 0x%"PRIx64"))",
+                   xfam, (uint64_t)tdx_caps->supported_xfam);
         return -1;
     }
 
@@ -999,14 +999,14 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
 
     if (env->tsc_khz && (env->tsc_khz < TDX_MIN_TSC_FREQUENCY_KHZ ||
                          env->tsc_khz > TDX_MAX_TSC_FREQUENCY_KHZ)) {
-        error_setg(errp, "Invalid TSC %ld KHz, must specify cpu_frequency "
+        error_setg(errp, "Invalid TSC %"PRId64" KHz, must specify cpu_frequency "
                          "between [%d, %d] kHz", env->tsc_khz,
                          TDX_MIN_TSC_FREQUENCY_KHZ, TDX_MAX_TSC_FREQUENCY_KHZ);
        return -EINVAL;
     }
 
     if (env->tsc_khz % (25 * 1000)) {
-        error_setg(errp, "Invalid TSC %ld KHz, it must be multiple of 25MHz",
+        error_setg(errp, "Invalid TSC %"PRId64" KHz, it must be multiple of 25MHz",
                    env->tsc_khz);
         return -EINVAL;
     }
@@ -1014,7 +1014,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     /* it's safe even env->tsc_khz is 0. KVM uses host's tsc_khz in this case */
     r = kvm_vm_ioctl(kvm_state, KVM_SET_TSC_KHZ, env->tsc_khz);
     if (r < 0) {
-        error_setg_errno(errp, -r, "Unable to set TSC frequency to %ld kHz",
+        error_setg_errno(errp, -r, "Unable to set TSC frequency to %"PRId64" kHz",
                          env->tsc_khz);
         return r;
     }
@@ -1139,7 +1139,7 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
     uint64_t gpa = -1ull;
 
     if (error_code & 0xffff) {
-        error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%lx",
+        error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%"PRIx64,
                      error_code);
         return -1;
     }
-- 
2.49.0


