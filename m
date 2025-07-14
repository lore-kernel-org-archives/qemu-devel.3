Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2AAC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHCO-0005Do-8r; Mon, 14 Jul 2025 07:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0c-0001WF-9C
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0V-00022R-D8
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hOyq8vxRGWTrMc2U4FZhuFke/jjaHE1X37zP4eIBRDQ=;
 b=F2D+q8scJXOULPuWgEHU26luWF9EHhv7914VL0Yrmq6FBCuuYRw01DjKuAFEiafgYh6JLO
 nzFflNYj47nQkJnfdWE4ejW2XMFQJcqYoCD8xcjCQRDGSc9pK4BD7nQaUnfYP34+BucVTJ
 oBCeK5xRCp6GJCv/IGqe3W3PYWm5ZAg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-px6NXlZoOLWXp9OVyCV1RQ-1; Mon, 14 Jul 2025 07:06:01 -0400
X-MC-Unique: px6NXlZoOLWXp9OVyCV1RQ-1
X-Mimecast-MFC-AGG-ID: px6NXlZoOLWXp9OVyCV1RQ_1752491160
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-453018b4ddeso21341285e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491159; x=1753095959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOyq8vxRGWTrMc2U4FZhuFke/jjaHE1X37zP4eIBRDQ=;
 b=EdyNLnttqWtXK19BnWWB3g3U2lM+7j9UNW9BDONFwZbK+vt+njkR28HFysclD8NfwL
 MSsCdtAnLxOsiqgw7hd04hCUqMB6IuCl39GE3zFU5YaJ3kfP8iwpizBjRv1GaAQQv1F1
 DemJ/Cfq7kWhQ0hD6pBgLYj3tGHKbGS+LRkgZ8e/tS1oZ3nhB4I0ahUQ8Dmkrj0d2Um6
 XE2VV8cvPx4QIHUZB/JQiQnXedPxb3LnkVCj+mA0fy/1crYvm5UI/AXPquro+2wByt74
 9/cT2taAVQltx8Q3uicIn0wnj0tXM7cxwFJXKTI7u1mxFjdfzvTw048Vtz8GFcEAdEKk
 Z6XA==
X-Gm-Message-State: AOJu0Yzi0ipWVeUhTw9Ah2jetMWV94qLwbMziWfk1jvLCp/MghcTASUO
 pUy95NFZz5rhZ6RqTmxc3Cxcfm11xG75Sbgxr1h3ArqAlBSfF54Y8Bao78ZNLO2vA1L/1HpwGjc
 YDBvCPzj8Wa12XHQuWwWLbcJmIN/07GyFUmS7jQO77SsMBaLMX5YAmUt/06Fnwyhotp3GrP+hu0
 1/eDNDLXq7ZArGCLOipX691n+tOFJol0aSYhyieOF/
X-Gm-Gg: ASbGnctFXkGweuYbMLDVhohpKW1hwxB/2t4+TDnKT6wc5MNqc3l1SofHD0K193aEmie
 nss0J9oM1q70Zrgd/hx0uYtdcpTfOt/xzozAtXMIQ2/ShJQVSKo39STLhBHKkfYZfBH0cA7Koa7
 V2VCQjM+qUK6FWhVhPxlk0d8JmVJwQmjcj3a1wIjeeI47XtjsWP5GwO0O6k03SgdEZtDyoucSci
 lVg6F4+6NoPVifw/jvRYjmlXP7Wj+DLdiOoumJDQ3Bn6zWTyOrK4Xf1luScSNCORd38m3ZUlVjl
 9wN+7pGS9xxibdemvVVrQCya7hLMPY9EBnWMhwSvQ7M=
X-Received: by 2002:a05:600c:138d:b0:453:697:6f08 with SMTP id
 5b1f17b1804b1-45565edcb1emr93713475e9.26.1752491158887; 
 Mon, 14 Jul 2025 04:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs+7nFgTyFsmAr6M2C+Wq+plja+UHVi9aZXmfI9hZ/uwk7nMcfanYgZMG6i6tNSTPiv5qhWA==
X-Received: by 2002:a05:600c:138d:b0:453:697:6f08 with SMTP id
 5b1f17b1804b1-45565edcb1emr93713165e9.26.1752491158301; 
 Mon, 14 Jul 2025 04:05:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1741sm12284801f8f.18.2025.07.14.04.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [PULL 42/77] i386/cpu: Add default cache model for Intel CPUs with
 level < 4
Date: Mon, 14 Jul 2025 13:03:31 +0200
Message-ID: <20250714110406.117772-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Old Intel CPUs with CPUID level < 4, use CPUID 0x2 leaf (if available)
to encode cache information.

Introduce a cache model "legacy_intel_cpuid2_cache_info" for the CPUs
with CPUID level < 4, based on legacy_l1d_cache, legacy_l1i_cache,
legacy_l2_cache_cpuid2 and legacy_l3_cache. But for L2 cache, this
cache model completes self_init, sets, partitions, no_invd_sharing and
share_level fields, referring legacy_l2_cache, to avoid someone
increases CPUID level manually and meets assert() error. But the cache
information present in CPUID 0x2 leaf doesn't change.

This new cache model makes it possible to remove legacy_l2_cache_cpuid2
in X86CPUState and help to clarify historical cache inconsistency issue.

Furthermore, apply this legacy cache model to all Intel CPUs with CPUID
level < 4. This includes not only "pentium2" and "pentium3" (which have
0x2 leaf), but also "486" and "pentium" (which only have 0x1 leaf, and
cache model won't be presented, just for simplicity).

A legacy_intel_cpuid2_cache_info cache model doesn't change the cache
information of the above CPUs, because they just depend on 0x2 leaf.

Only when someone adjusts the min-level to >=4 will the cache
information in CPUID leaf 4 differ from before: previously, the L2
cache information in CPUID leaf 0x2 and 0x4 was different, but now with
legacy_intel_cpuid2_cache_info, the information they present will be
consistent. This case almost never happens, emulating a CPUID that is
not supported by the "ancient" hardware is itself meaningless behavior.

Therefore, even though there's the above difference (for really rare
case) and considering these old CPUs ("486", "pentium", "pentium2" and
"pentium3") won't be used for migration, there's no need to add new
versioned CPU models

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4386b60ff6c..3278d5de5a7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -712,6 +712,67 @@ static CPUCacheInfo legacy_l3_cache = {
     .share_level = CPU_TOPOLOGY_LEVEL_DIE,
 };
 
+/*
+ * Only used for the CPU models with CPUID level < 4.
+ * These CPUs (CPUID level < 4) only use CPUID leaf 2 to present
+ * cache information.
+ *
+ * Note: This cache model is just a default one, and is not
+ *       guaranteed to match real hardwares.
+ */
+static const CPUCaches legacy_intel_cpuid2_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 8,
+        .sets = 64,
+        .partitions = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 8,
+        .sets = 64,
+        .partitions = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 2 * MiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 8,
+        .sets = 4096,
+        .partitions = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 16 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .sets = 16384,
+        .partitions = 1,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .complex_indexing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 /* TLB definitions: */
 
 #define L1_DTLB_2M_ASSOC       1
@@ -3045,6 +3106,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             I486_FEATURES,
         .xlevel = 0,
         .model_id = "",
+        .cache_info = &legacy_intel_cpuid2_cache_info,
     },
     {
         .name = "pentium",
@@ -3057,6 +3119,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             PENTIUM_FEATURES,
         .xlevel = 0,
         .model_id = "",
+        .cache_info = &legacy_intel_cpuid2_cache_info,
     },
     {
         .name = "pentium2",
@@ -3069,6 +3132,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             PENTIUM2_FEATURES,
         .xlevel = 0,
         .model_id = "",
+        .cache_info = &legacy_intel_cpuid2_cache_info,
     },
     {
         .name = "pentium3",
@@ -3081,6 +3145,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             PENTIUM3_FEATURES,
         .xlevel = 0,
         .model_id = "",
+        .cache_info = &legacy_intel_cpuid2_cache_info,
     },
     {
         .name = "athlon",
-- 
2.50.0


