Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCD4CDE013
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3dV-0006hN-Fj; Fri, 26 Jun 2026 06:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dP-0006fS-PT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dL-00056r-Nn
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13JInuR6vvT0uFXBtxBuI63SjRg5X86Fy21E7KX97Ic=;
 b=b4ys5Xre7lt1krkEZoME/VXsqxbWkp1q8oAWfK6wanZX4XWsgcSk41776XJtnWWcsUOL7z
 tBcFMO3kM6Q9ryoJEQCZVt92mum3tknt+gS88HHdCRjwnIhmRYP1dL91LT4S4bQB2oZjQu
 d9AmIRiphCtvrjfLkgPm8KHsQ9d25q0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-QJXxaww7MnOEmNPkqA50Aw-1; Fri, 26 Jun 2026 06:17:59 -0400
X-MC-Unique: QJXxaww7MnOEmNPkqA50Aw-1
X-Mimecast-MFC-AGG-ID: QJXxaww7MnOEmNPkqA50Aw_1782469078
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490aadb1386so11095305e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469078; x=1783073878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13JInuR6vvT0uFXBtxBuI63SjRg5X86Fy21E7KX97Ic=;
 b=TSM5GbB8ca/ikDVYE3Wy/lxIIT/EE0ZEmy/EAUIF5Uc/Hadjeygk5g7MVeCSxpusUB
 t66uqqJsah/H0j3AmwpMePvYR3RU1hcOHhZVE6qi4ialGz5a0yXdJttk2kaVAJCBTFDu
 3ahOVfJ4vgBpyynDF9bzChcfJFkykFSfM1ODsIngn/cMbRMPvc+A6Kv6JTi1lfuRViT4
 gMyryLTmjcBPrgzub6l1ptF46/43KAUBRc9SA6lLYfisAfnXlPU638LXjPrOuSnAZM3h
 ydgfdUavmoKYbpDt5WhLxV6lcrh1nuKYishkcIuPZ8PXDkZM5J2D8nBtI5p2iZUnwE+0
 X2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469078; x=1783073878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=13JInuR6vvT0uFXBtxBuI63SjRg5X86Fy21E7KX97Ic=;
 b=kghd7ecWcJ7WpAvynS6xMidUb/pTt+1ZPOL4IZRl6Kwh9ID+EYgYl3C5gviuc+9hPv
 ZjvvYyJgXeEl3kMlfGaZb10/NMCao24aWnWtP/r9pYO/SUdKzT77unlNdI1FYQVFwSjg
 3Qvuh85/x8PdOgS972JQTXThBOo7ca2QKw4o7K2NCY8T33p/S0L2XS56L6cb0Gu+Jy9h
 0Wb4caPzimuY1rNgdtYFrsY0WylZZU+i2fRl60Ba8sByIVALOPNcKZnz0i5SDYBC9sSU
 HI3jw/+WoyiqbeBTJOf90GzU3+39i0KUamvEy0K9aPl0jE3bWkPasA+eO1brdYue2cC+
 wQsQ==
X-Gm-Message-State: AOJu0Ywd0QkFo/OL40WuyBKGVsvlOT/1v6TtbnO+YLLamCkVIG/Sbcaw
 3Y2x0Hu0OCtG4DSVcVpQ0gms/GAHis4fhyyB+mu1l6+p+5mbadYtsUa6FwDDlAqjmWO1FLK2nhy
 9A0VvfZdhmZnpPZLrtFxkALJX9803FVkFrkyhhRg2M3TDMwk3LO/AnGINvVbYGJc7Vct+w8eFOi
 mt+q64O9tznzFKhFj2O6QoVE6Bf6eXoc7c0qRA3QL3
X-Gm-Gg: AfdE7clv1AQvdZk/LODUS4YlhhrqdBzBuqgRkUu+03oxveUam33J2XT3E9GFdn4QMBd
 BnxGjSjbJd1Pd99FfWlaTYSkw9N1rEWOvhUKkMWqTAb3sYaAPucHxrngk3yLJ5C6o06KMxhj4gr
 Orglwwa/ugCwk+F63o56ELyzVQYC1IR2SI5uecOiqqBYfaIV53a8Jo0kHyeD1YLt+D4KFbwEiXI
 5EsyXtiP8R3qWdaIQcF+Ogdj4VUTbbmOyKoDMvwndtYCjFZTIOK00Z5nPK9Hvx3GOvnC1Wq1/4R
 I1BHuwUVFc+0IP/tUSL73eqtOBNypuFuhR9amoRD0r3FcncAAWbdaPahPGqcFdjeyeW7EW40lIi
 PK3fVYOBvBh5mQ3Yp6ZtXkJbITr5XsF88BbU11B2FNsA2JxWBsJoqSWLEL8cod6iKXKeX/HP2ym
 QkUPXI5AOgG+41PBYg
X-Received: by 2002:a05:600c:638e:b0:490:7df7:9190 with SMTP id
 5b1f17b1804b1-492663ea3d3mr71783945e9.8.1782469078110; 
 Fri, 26 Jun 2026 03:17:58 -0700 (PDT)
X-Received: by 2002:a05:600c:638e:b0:490:7df7:9190 with SMTP id
 5b1f17b1804b1-492663ea3d3mr71783335e9.8.1782469077561; 
 Fri, 26 Jun 2026 03:17:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492690988e0sm71791375e9.14.2026.06.26.03.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:17:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 03/45] target/i386/mshv: fix various cpuid traversal bugs
Date: Fri, 26 Jun 2026 12:17:06 +0200
Message-ID: <20260626101748.1728079-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

- Hardcoded max_leaf was not accurate. We query leaf 0x0 and 0x80000000 to
  get the actual max leaves

- On all 0 zeroes on leaf 0x0d, we register 0-63 subleaves with zeros
  indicating XSAVE is disabled

- Subleaf 0 was hardcoded, so the Hypervisor returned defaults for other
  subleaves

- Subleaf 0 was hardcoded, so we were passing 0 instead of actual subleaf
  when adding entries. We now pass the correct subleaf value to
  add_cpuid_entry()

- Leaves 0x04,0x07,0d,0f,10 weren't marked as subleaf-specific

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260416121116.527927-4-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 88 +++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 27 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 38994ed6cfd..bfcccd19916 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -465,14 +465,17 @@ static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
     CPUX86State *env = &x86_cpu->env;
     uint32_t eax, ebx, ecx, edx;
     uint32_t leaf, subleaf;
-    size_t max_leaf = 0x1F;
-    size_t max_subleaf = 0x20;
-
-    uint32_t leaves_with_subleaves[] = {0x4, 0x7, 0xD, 0xF, 0x10};
+    uint32_t max_basic_leaf, max_extended_leaf;
+    uint32_t max_subleaf = 0x20;
+    uint32_t leaves_with_subleaves[] = {0x04, 0x07, 0x0d, 0x0f, 0x10};
     int n_subleaf_leaves = ARRAY_SIZE(leaves_with_subleaves);
 
-    /* Regular leaves without subleaves */
-    for (leaf = 0; leaf <= max_leaf; leaf++) {
+    /* Get maximum basic and and extended CPUID leaves */
+    cpu_x86_cpuid(env, 0, 0, &max_basic_leaf, &ebx, &ecx, &edx);
+    cpu_x86_cpuid(env, 0x80000000, 0, &max_extended_leaf, &ebx, &ecx, &edx);
+
+    /* Collect basic leaves (0x0 to max_basic_leaf) */
+    for (leaf = 0; leaf <= max_basic_leaf; leaf++) {
         bool has_subleaves = false;
         for (int i = 0; i < n_subleaf_leaves; i++) {
             if (leaf == leaves_with_subleaves[i]) {
@@ -483,27 +486,40 @@ static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
 
         if (!has_subleaves) {
             cpu_x86_cpuid(env, leaf, 0, &eax, &ebx, &ecx, &edx);
-            if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
-                /* all zeroes indicates no more leaves */
-                continue;
-            }
-
             add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
             continue;
         }
 
+        /*
+         * Valid XSAVE components can exist at a higher index se we need to set
+         * all subleaves for leaf 0x0d, even if we encounter an empty one.
+         */
+        if (leaf == 0x0d) {
+            for (subleaf = 0; subleaf <= 63; subleaf++) {
+                cpu_x86_cpuid(env, leaf, subleaf, &eax, &ebx, &ecx, &edx);
+                add_cpuid_entry(cpuid_entries, leaf, subleaf,
+                                eax, ebx, ecx, edx);
+            }
+            continue;
+        }
+
         subleaf = 0;
         while (subleaf < max_subleaf) {
             cpu_x86_cpuid(env, leaf, subleaf, &eax, &ebx, &ecx, &edx);
 
             if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
-                /* all zeroes indicates no more leaves */
                 break;
             }
-            add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
+            add_cpuid_entry(cpuid_entries, leaf, subleaf, eax, ebx, ecx, edx);
             subleaf++;
         }
     }
+
+    /* Collect extended leaves (0x80000000 to max_extended_leaf) */
+    for (leaf = 0x80000000; leaf <= max_extended_leaf; leaf++) {
+        cpu_x86_cpuid(env, leaf, 0, &eax, &ebx, &ecx, &edx);
+        add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
+    }
 }
 
 static int register_intercept_result_cpuid_entry(const CPUState *cpu,
@@ -576,22 +592,40 @@ static int register_intercept_result_cpuid(const CPUState *cpu,
         subleaf_specific = 0;
         always_override = 1;
 
-        /* Intel */
-        /* 0xb - Extended Topology Enumeration Leaf */
-        /* 0x1f - V2 Extended Topology Enumeration Leaf */
-        /* AMD */
-        /* 0x8000_001e - Processor Topology Information */
-        /* 0x8000_0026 - Extended CPU Topology */
-        if (entry->function == 0xb
-            || entry->function == 0x1f
-            || entry->function == 0x8000001e
-            || entry->function == 0x80000026) {
+        /*
+         * Intel
+         * 0xb - Extended Topology Enumeration Leaf
+         * 0x1f - V2 Extended Topology Enumeration Leaf
+         * AMD
+         * 0x8000_001e - Processor Topology Information
+         * 0x8000_0026 - Extended CPU Topology
+         */
+        if (entry->function == 0xb ||
+            entry->function == 0x1f ||
+            entry->function == 0x8000001e ||
+            entry->function == 0x80000026) {
             subleaf_specific = 1;
             always_override = 1;
-        } else if (entry->function == 0x00000001
-            || entry->function == 0x80000000
-            || entry->function == 0x80000001
-            || entry->function == 0x80000008) {
+        /*
+         * Feature enumeration leaves (subleaf-specific)
+         * 0x04: Deterministic Cache Parameters
+         * 0x07: Structured Extended Feature Flags
+         * 0x0D: Processor Extended State Enumeration
+         * 0x0F: Platform QoS Monitoring
+         * 0x10: Platform QoS Enforcement
+         */
+        } else if (entry->function == 0x04 ||
+                   entry->function == 0x07 ||
+                   entry->function == 0x0d ||
+                   entry->function == 0x0f ||
+                   entry->function == 0x10) {
+            subleaf_specific = 1;
+            always_override = 1;
+        /* Basic feature leaves (no subleaves) */
+        } else if (entry->function == 0x00000001 ||
+                   entry->function == 0x80000000 ||
+                   entry->function == 0x80000001 ||
+                   entry->function == 0x80000008) {
             subleaf_specific = 0;
             always_override = 1;
         }
-- 
2.54.0


