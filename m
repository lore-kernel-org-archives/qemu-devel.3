Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE111C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHT8-0004CI-3A; Mon, 14 Jul 2025 07:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH13-0001jo-Ov
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH10-00027E-Vj
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DM3g4jGDz+IF2qu9cdV0osBtPT9IUxABMoDQ14HnLM8=;
 b=cWPsDfswXEhG+J6r/L4sgIV2+xWxNQSCjbrznNY3S7YtfoUClzT9CrsznexykUqnLiQFb+
 yaDbfotE0HH33EtFm8iQCIxyycYhFiBE24A8doVfhFjT/asL7rVtjgsh1vk0WXB4NLFDeg
 hiLIPiCSQU3f7mafOGOaYK/622LvF2I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-ypSRTcKxObKdkvdOKEZtQw-1; Mon, 14 Jul 2025 07:06:30 -0400
X-MC-Unique: ypSRTcKxObKdkvdOKEZtQw-1
X-Mimecast-MFC-AGG-ID: ypSRTcKxObKdkvdOKEZtQw_1752491189
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so24021865e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491188; x=1753095988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DM3g4jGDz+IF2qu9cdV0osBtPT9IUxABMoDQ14HnLM8=;
 b=VRTpOSKLmJyOmFZXffxUmn0zhsN0gdTTxp3vISROzCH0MWcG5YLqipXixr0kplWDGz
 JTE4tDWCyW+67peYRaa4n2VKO1gEchOYrcWwDqpHQ1ZS3LGjO1bk1XG4eAVDh8XEbdF8
 xGl1wkxXJsXr+K47u4/xu7QHE1TJjG4i0qcWQKsDPf6bIM3SdVlsMCxayH/ijvt1ckTq
 G8d5u1ZsDD0NtoZ0wEbOxWkTbh1nOdGGXVEblmH37u0hCbkN1dQMgs9sD5LivVct3VlA
 orAW2zKXHZ4QvaOZShmFf8Gx9GyaMhV5S/2fmI8163c8SyH+G0MWOr+uk9Jay4hC+EYT
 Loeg==
X-Gm-Message-State: AOJu0YzgpUgQ0/krzEmRMfg4kXD1hXwPZ9mO8zCCXE49z3ZHl6otBBUr
 9Yl9BTvS26QsLn3LelqY6xeahZxisIgSoSorznPu6bt21scdsRyT9FP3JHHDRCacw2wS8s5N1fN
 ST4oDvspHbzJjGPrwPTVG7F5Rc7B7/GMZDqK6IYfvXyNDXmGh7VwhEBr+0P0WBn5iIDE83wdcan
 R0O7HHnRxl36Y/WCnzDWHnrfK7jjcXSSoCbYlbKdZq
X-Gm-Gg: ASbGncutvy1v/Y5wAPIbs8sUz5WPD9GFjzFK6xS2gFgJ/PdW5ahRw24XRzuqlq4Si7X
 nU3ftiM9BTAvbgzH6rhoEoJEmBch3xQgyaVIEbAzEoaDzhWJ3rmbhXB98YFD/jIBojRNa4maR3e
 omC+TBnccVoEBO2RsLsTRbgOtcPBPpghXEJhpyL5STEZkQKQcKUl7hehN24/GXtsqu4Dy/Py1A5
 dyrSGu0+DK7bLjpx/UKdaXrJ1GxxQbp0TLWsswOLLGusR9iQIhpfUYdk87A0JperNCZjKJk9BDd
 B8YXD/bx4gOR6dh/BhDGu1u1vBLFXIYgN1S1TH48ZDY=
X-Received: by 2002:a5d:5f55:0:b0:3a4:dcfb:3118 with SMTP id
 ffacd0b85a97d-3b5f187599dmr10358520f8f.10.1752491188175; 
 Mon, 14 Jul 2025 04:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXYOQcsuR9pPrQE0ZA1C9s7bm6CtiFo3XQuydkWlqEZQP2WRamsUR4Wnd51C1cqQ72QtRpWA==
X-Received: by 2002:a5d:5f55:0:b0:3a4:dcfb:3118 with SMTP id
 ffacd0b85a97d-3b5f187599dmr10358488f8f.10.1752491187658; 
 Mon, 14 Jul 2025 04:06:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45623f4f838sm184345e9.1.2025.07.14.04.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, EwanHai <ewanhai-oc@zhaoxin.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 54/77] i386/cpu: Select legacy cache model based on vendor in
 CPUID 0x80000005
Date: Mon, 14 Jul 2025 13:03:43 +0200
Message-ID: <20250714110406.117772-55-pbonzini@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

As preparation for merging cache_info_cpuid4 and cache_info_amd in
X86CPUState, set legacy cache model based on vendor in the CPUID
0x80000005 leaf. For AMD CPU, select legacy AMD cache model (in
cache_info_amd) as the default cache model like before, otherwise,
select legacy Intel cache model (in cache_info_cpuid4).

To ensure compatibility is not broken, add an enable_legacy_vendor_cache
flag based on x-vendor-only-v2 to indicate cases where the legacy cache
model should be used regardless of the vendor. For CPUID 0x80000005
leaf, enable_legacy_vendor_cache flag indicates to pick legacy AMD cache
model, which is for compatibility with the behavior of PC machine v10.0
and older.

The following explains how current vendor-based default legacy cache
model ensures correctness without breaking compatibility.

* For the PC machine v6.0 and older, vendor_cpuid_only=false, and
  vendor_cpuid_only_v2=false.

  - If the named CPU model has its own cache model, and doesn't use
    legacy cache model (legacy_cache=false), then cache_info_cpuid4 and
    cache_info_amd are same, so 0x80000005 leaf uses its own cache model
    regardless of the vendor.

  - For max/host/named CPU (without its own cache model), then the flag
    enable_legacy_vendor_cache is true, they will use legacy AMD cache
    model just like their previous behavior.

* For the PC machine v10.0 and older (to v6.1), vendor_cpuid_only=true,
  and vendor_cpuid_only_v2=false.

  - No change, since this leaf doesn't aware vendor_cpuid_only.

* For the PC machine v10.1 and newer, vendor_cpuid_only=true, and
  vendor_cpuid_only_v2=true.

  - If the named CPU model has its own cache model (legacy_cache=false),
    then cache_info_cpuid4 & cache_info_amd both equal to its own cache
    model, so it uses its own cache model in 0x80000005 leaf regardless
    of the vendor. Only Intel CPUs have all-0 leaf due to
    vendor_cpuid_only_2=true, and this is exactly the expected behavior.

  - For max/host/named CPU (without its own cache model), then the flag
    enable_legacy_vendor_cache is false, the legacy cache model is
    selected based on vendor.

    For AMD CPU, it will use legacy AMD cache as expected.

    For Intel CPU, it will use legacy Intel cache but still get all-0
    leaf due to vendor_cpuid_only_2=true as expected.

    (Note) And for Zhaoxin CPU, it will use legacy Intel cache model
    instead of AMD's. This is the difference brought by this change! But
    it's correct since then Zhaoxin could have the consistent cache info
    in CPUID 0x2, 0x4 and 0x80000005 leaves.

    Here, except Zhaoxin, selecting the legacy cache model based on the
    vendor does not change the previous (before the change) behavior.
    And the change for Zhaoxin is also a good improvement.

Therefore, the above analysis proves that, with the help of the flag
enable_legacy_vendor_cache, it is acceptable to select the default
legacy cache model based on the vendor.

For the CPUID 0x80000005 leaf, in X86CPUState, a unified cache_info is
enough. It only needs to be initialized and configured with the
corresponding legacy cache model based on the vendor.

Cc: EwanHai <ewanhai-oc@zhaoxin.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-16-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 565eaf0071c..e98ffb11c31 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7935,8 +7935,36 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = env->cpuid_model[(index - 0x80000002) * 4 + 2];
         *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
         break;
-    case 0x80000005:
+    case 0x80000005: {
         /* cache info (L1 cache/TLB Associativity Field) */
+        const CPUCaches *caches;
+
+        if (env->enable_legacy_vendor_cache) {
+            caches = &legacy_amd_cache_info;
+        } else {
+            /*
+             * FIXME: Temporarily select cache info model here based on
+             * vendor, and merge these 2 cache info models later.
+             *
+             * This condition covers the following cases (with
+             * enable_legacy_vendor_cache=false):
+             *  - When CPU model has its own cache model and doesn't uses legacy
+             *    cache model (legacy_model=off). Then cache_info_amd and
+             *    cache_info_cpuid4 are the same.
+             *
+             *  - For v10.1 and newer machines, when CPU model uses legacy cache
+             *    model. AMD CPUs use cache_info_amd like before and non-AMD
+             *    CPU will use cache_info_cpuid4. But this doesn't matter,
+             *    because for Intel CPU, it will get all-0 leaf, and Zhaoxin CPU
+             *    will get correct cache info. Both are expected.
+             */
+            if (IS_AMD_CPU(env)) {
+                caches = &env->cache_info_amd;
+            } else {
+                caches = &env->cache_info_cpuid4;
+            }
+        }
+
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
@@ -7951,9 +7979,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
         *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
                (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
-        *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
-        *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
+        *ecx = encode_cache_cpuid80000005(caches->l1d_cache);
+        *edx = encode_cache_cpuid80000005(caches->l1i_cache);
         break;
+    }
     case 0x80000006:
         /* cache info (L2 cache/TLB/L3 cache) */
         if (cpu->cache_info_passthrough) {
-- 
2.50.0


