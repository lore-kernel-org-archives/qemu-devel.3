Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D289CCAC587
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqadY-0005rZ-BC; Tue, 17 Sep 2024 12:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1sqadT-0005hY-6k
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1sqadR-0003ck-GP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726588859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6oaHFMscju37xAWma+lL2FhqJUsDnyK+WIoJhjUBv8c=;
 b=W2x44Ch5B1bBw6lfi+tZHyXwfllB6kByZHKNVum+tgTlVc+kgRnwpK9VugNiGc9NhsWL4n
 dqDbGxT2Iv/oqyN1Q/GsrZ+ouoXdV3tJU+bC5TJqgfyzG7NISyNeWmceygvpgQJYmMYn+O
 6PDmlMm97YGBych+ETXHzRXvyG/MmZs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-X3kyOCHIOv-Ef2n6Eiivpw-1; Tue,
 17 Sep 2024 12:00:58 -0400
X-MC-Unique: X3kyOCHIOv-Ef2n6Eiivpw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 117C51955D62
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 16:00:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.82])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D81FA30001A1; Tue, 17 Sep 2024 16:00:55 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RESEND v4 2/4] target/i386: Exclude 'hv-syndbg' from
 'hv-passthrough'
Date: Tue, 17 Sep 2024 18:00:49 +0200
Message-ID: <20240917160051.2637594-3-vkuznets@redhat.com>
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

Windows with Hyper-V role enabled doesn't boot with 'hv-passthrough' when
no debugger is configured, this significantly limits the usefulness of the
feature as there's no support for subtracting Hyper-V features from CPU
flags at this moment (e.g. "-cpu host,hv-passthrough,-hv-syndbg" does not
work). While this is also theoretically fixable, 'hv-syndbg' is likely
very special and unneeded in the default set. Genuine Hyper-V doesn't seem
to enable it either.

Introduce 'skip_passthrough' flag to 'kvm_hyperv_properties' and use it as
one-off to skip 'hv-syndbg' when enabling features in 'hv-passthrough'
mode. Note, "-cpu host,hv-passthrough,hv-syndbg" can still be used if
needed.

As both 'hv-passthrough' and 'hv-syndbg' are debug features, the change
should not have any effect on production environments.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 docs/system/i386/hyperv.rst | 13 +++++++++----
 target/i386/kvm/kvm.c       |  7 +++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index 2505dc4c86e0..009947e39141 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -262,14 +262,19 @@ Supplementary features
 ``hv-passthrough``
   In some cases (e.g. during development) it may make sense to use QEMU in
   'pass-through' mode and give Windows guests all enlightenments currently
-  supported by KVM. This pass-through mode is enabled by "hv-passthrough" CPU
-  flag.
+  supported by KVM.
 
   Note: ``hv-passthrough`` flag only enables enlightenments which are known to QEMU
   (have corresponding 'hv-' flag) and copies ``hv-spinlocks`` and ``hv-vendor-id``
   values from KVM to QEMU. ``hv-passthrough`` overrides all other 'hv-' settings on
-  the command line. Also, enabling this flag effectively prevents migration as the
-  list of enabled enlightenments may differ between target and destination hosts.
+  the command line.
+
+  Note: ``hv-passthrough`` does not enable ``hv-syndbg`` which can prevent certain
+  Windows guests from booting when used without proper configuration. If needed,
+  ``hv-syndbg`` can be enabled additionally.
+
+  Note: ``hv-passthrough`` effectively prevents migration as the list of enabled
+  enlightenments may differ between target and destination hosts.
 
 ``hv-enforce-cpuid``
   By default, KVM allows the guest to use all currently supported Hyper-V
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4009fcfd6b29..cf0449968f66 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -913,6 +913,7 @@ static struct {
         uint32_t bits;
     } flags[2];
     uint64_t dependencies;
+    bool skip_passthrough;
 } kvm_hyperv_properties[] = {
     [HYPERV_FEAT_RELAXED] = {
         .desc = "relaxed timing (hv-relaxed)",
@@ -1041,7 +1042,8 @@ static struct {
             {.func = HV_CPUID_FEATURES, .reg = R_EDX,
              .bits = HV_FEATURE_DEBUG_MSRS_AVAILABLE}
         },
-        .dependencies = BIT(HYPERV_FEAT_SYNIC) | BIT(HYPERV_FEAT_RELAXED)
+        .dependencies = BIT(HYPERV_FEAT_SYNIC) | BIT(HYPERV_FEAT_RELAXED),
+        .skip_passthrough = true,
     },
     [HYPERV_FEAT_MSR_BITMAP] = {
         .desc = "enlightened MSR-Bitmap (hv-emsr-bitmap)",
@@ -1450,7 +1452,8 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp)
          * hv_build_cpuid_leaf() uses this info to build guest CPUIDs.
          */
         for (feat = 0; feat < ARRAY_SIZE(kvm_hyperv_properties); feat++) {
-            if (hyperv_feature_supported(cs, feat)) {
+            if (hyperv_feature_supported(cs, feat) &&
+                !kvm_hyperv_properties[feat].skip_passthrough) {
                 cpu->hyperv_features |= BIT(feat);
             }
         }
-- 
2.46.0


