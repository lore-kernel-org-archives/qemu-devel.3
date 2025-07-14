Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC2CC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHOa-0000lK-Fj; Mon, 14 Jul 2025 07:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0f-0001Zn-3i
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0c-00024F-W3
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oi8bDZgPdz2Od/uSi533f6cPYkkNmFxsGsLpcHgWdeo=;
 b=RKabXpDySgzK4c9OiAAxEcFAX8/5Sg7xDL8t1gB/g08IwK31HjwBw9SLn5nePia9AH+0cC
 4Dn1akU6XHlIXKBOcsXWUXinuGWsPTjskJYEjmMTVDXlYBbL39G7lLX5BWjwNRaZQJ6T2u
 HMiW+rzaNecIod6cZvQHMs06QPQkD50=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-hwatsK3oOb6S1jMAqvHF7A-1; Mon, 14 Jul 2025 07:06:09 -0400
X-MC-Unique: hwatsK3oOb6S1jMAqvHF7A-1
X-Mimecast-MFC-AGG-ID: hwatsK3oOb6S1jMAqvHF7A_1752491168
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4561bc2f477so5157985e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491167; x=1753095967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oi8bDZgPdz2Od/uSi533f6cPYkkNmFxsGsLpcHgWdeo=;
 b=n6fNDeFO6KReXkKhywQi9hH89NMt7A57nho7cMqYJgyHR7JwavYYKKOPaxTPnTissi
 JDy0bKcH/BzMuXO4hBRGOIl6RRo1qCG6dM0hehKagDdBgFdE1u9GJXuREg99drkiyakF
 XjbJmSNKvlPUUO92/olTGiQpMGkeamdu1SYyVZpabU2G9HXcGdmHU6Rt/E0/Ebmzjpyu
 btGywUQEN/TMEBGFpLEdLRpQtGutE36ddf/bOrHY5aUUfo3LsoQIA14tcLqEbwb00tY9
 r9FQlakGBf74xBQquDJ9FCljjNLBCIgxC5koOZPMw4+OP9pSA08Y5tpAHNcgTF0R/xvk
 GNxQ==
X-Gm-Message-State: AOJu0Yz3H+hjEAgYLaXFdyVyHXo3OE1HTn2+0gH7P+nZ1tXE8vpBxkrQ
 2U/td2vRvv+uDIsF2D0i7E8GSSovLP9YWJ8B/4Q5LAMS4zCKrkpwqbFDTMO5F1B+tItw/Zc3mUf
 oTlxQMxubwKAwLp121SO19S57jUhie7imXR6oX5wBQZjEtnH/s0QEnPvdZdCoL960zNQxNmiv8P
 aM3Z3uZE+jlQZvRadrMZkwVdcm5E2UrFE0K86CqCGt
X-Gm-Gg: ASbGncs3pKULf3xOX4mbIbziL0eKSlcB9qSmo5bIF0MwnQLYXj6phPLwDIWq7H0wajB
 Fa1iXGq63V7P3Qj66jef8wKdnmF/R2cWrB+pWYqtVFEmkFK7+MIDGIUVXU+ZC7LKv7mWPi5GvcV
 8dgBd97Js1w66VsfDGH7EbRb/mFNbb53xSeaIRLbtZaAJTKXu8GKizhdeTjkv3+ERHvMgz16NBA
 V/+ul1zXWRkEoaw0SiLAIG5FdamRSjVQ7h+Od4TNNlPlAUCr4HrGWNkV/FbKbQsjf2YloMXMH7P
 CXPBGT5j0hgfOoUaQVrLMb9Ez6EW0vc2CpmzT5J2h2U=
X-Received: by 2002:a05:600c:3595:b0:450:d3b9:4b96 with SMTP id
 5b1f17b1804b1-454ec16919emr127146305e9.13.1752491166794; 
 Mon, 14 Jul 2025 04:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4hWWRCIhYwp5qsZwNEkB88L2TJPp0XNC/cs+jyDqM1HHUm9IcT8wTpSwYRYADh9Im/hOKAg==
X-Received: by 2002:a05:600c:3595:b0:450:d3b9:4b96 with SMTP id
 5b1f17b1804b1-454ec16919emr127145955e9.13.1752491166272; 
 Mon, 14 Jul 2025 04:06:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561b176f87sm27426185e9.35.2025.07.14.04.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 45/77] i386/cpu: Drop CPUID 0x2 specific cache info in
 X86CPUState
Date: Mon, 14 Jul 2025 13:03:34 +0200
Message-ID: <20250714110406.117772-46-pbonzini@redhat.com>
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

With the pre-defined cache model legacy_intel_cpuid2_cache_info,
for X86CPUState there's no need to cache special cache information
for CPUID 0x2 leaf.

Drop the cache_info_cpuid2 field of X86CPUState and use the
legacy_intel_cpuid2_cache_info directly.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  3 ++-
 target/i386/cpu.c | 31 +++++++++++--------------------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a3ebd3e08ce..d3f7c53e301 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2077,7 +2077,8 @@ typedef struct CPUArchState {
      * on each CPUID leaf will be different, because we keep compatibility
      * with old QEMU versions.
      */
-    CPUCaches cache_info_cpuid2, cache_info_cpuid4, cache_info_amd;
+    CPUCaches cache_info_cpuid4, cache_info_amd;
+    bool enable_legacy_cpuid2_cache;
 
     /* MTRRs */
     uint64_t mtrr_fixed[11];
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 812e85b952f..ac22548f47d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -246,19 +246,27 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache, bool *unmacthed)
     return CACHE_DESCRIPTOR_UNAVAILABLE;
 }
 
+static const CPUCaches legacy_intel_cpuid2_cache_info;
+
 /* Encode cache info for CPUID[2] */
 static void encode_cache_cpuid2(X86CPU *cpu,
                                 uint32_t *eax, uint32_t *ebx,
                                 uint32_t *ecx, uint32_t *edx)
 {
     CPUX86State *env = &cpu->env;
-    CPUCaches *caches = &env->cache_info_cpuid2;
+    const CPUCaches *caches;
     int l1d, l1i, l2, l3;
     bool unmatched = false;
 
     *eax = 1; /* Number of CPUID[EAX=2] calls required */
     *ebx = *ecx = *edx = 0;
 
+    if (env->enable_legacy_cpuid2_cache) {
+        caches = &legacy_intel_cpuid2_cache_info;
+    } else {
+        caches = &env->cache_info_cpuid4;
+    }
+
     l1d = cpuid2_cache_descriptor(caches->l1d_cache, &unmatched);
     l1i = cpuid2_cache_descriptor(caches->l1i_cache, &unmatched);
     l2 = cpuid2_cache_descriptor(caches->l2_cache, &unmatched);
@@ -707,17 +715,6 @@ static CPUCacheInfo legacy_l2_cache = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
-static CPUCacheInfo legacy_l2_cache_cpuid2 = {
-    .type = UNIFIED_CACHE,
-    .level = 2,
-    .size = 2 * MiB,
-    .line_size = 64,
-    .associativity = 8,
-    .share_level = CPU_TOPOLOGY_LEVEL_INVALID,
-};
-
-
 /*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l2_cache_amd = {
     .type = UNIFIED_CACHE,
@@ -8955,18 +8952,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
                        "CPU model '%s' doesn't support legacy-cache=off", name);
             return;
         }
-        env->cache_info_cpuid2 = env->cache_info_cpuid4 = env->cache_info_amd =
-            *cache_info;
+        env->cache_info_cpuid4 = env->cache_info_amd = *cache_info;
     } else {
         /* Build legacy cache information */
-        env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
-        env->cache_info_cpuid2.l1i_cache = &legacy_l1i_cache;
         if (!cpu->consistent_cache) {
-            env->cache_info_cpuid2.l2_cache = &legacy_l2_cache_cpuid2;
-        } else {
-            env->cache_info_cpuid2.l2_cache = &legacy_l2_cache;
+            env->enable_legacy_cpuid2_cache = true;
         }
-        env->cache_info_cpuid2.l3_cache = &legacy_l3_cache;
 
         env->cache_info_cpuid4.l1d_cache = &legacy_l1d_cache;
         env->cache_info_cpuid4.l1i_cache = &legacy_l1i_cache;
-- 
2.50.0


