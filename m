Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C577E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxT-0004C7-2k; Sat, 27 Dec 2025 04:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxS-000473-B8
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxQ-0007V0-9h
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkizW9CIJa8Y7ebeAJUdAOMzr6q4+NzvoTNqdXU8uVk=;
 b=d3kNY5xODoFakyyKguLG3Syxnee28osV/8MqWrIxDxaIT0rFsXiLyuALRo5vODqAHtdFCE
 BlHSMWWK6tBLQtFYI1Sz8TOlJNL89lvujkepcmf6M77iW692LdSrmprzlv3/g132EI/v37
 ksjrwm203GkQ4PDhxOQj4Op8+YtxB+Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-dI3KJ3q9NVG0rvGeRF7g1Q-1; Sat, 27 Dec 2025 04:51:30 -0500
X-MC-Unique: dI3KJ3q9NVG0rvGeRF7g1Q-1
X-Mimecast-MFC-AGG-ID: dI3KJ3q9NVG0rvGeRF7g1Q_1766829089
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4325ddc5babso2697081f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829088; x=1767433888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkizW9CIJa8Y7ebeAJUdAOMzr6q4+NzvoTNqdXU8uVk=;
 b=WbaVvuZcfCn7tQpKerHlnAObCjBV0xzQmTTXcS8wq0REI9EY1TtgXjvQ0d1XFdhHUr
 metI/bhhZJlB42UhcySC42FQZsqlDBQi5Gs71bq2RGpTmLWfrZ1/kMez5kschhFT61v1
 KbolpJUlopmNGrbX5u4ApgA1XineGPl6mfGF0VeaJSzid2L2b3qv0CyjwNYz0OWEiAOu
 klAfFQJt5T1mmzD5XdDPDy29nxbyT+V/Ljr10tLurUdD2Nfj3usfyoPgZkT+Zyz89+2N
 jQLmRYWDuMYcatue8UURHvbfW5ugj5V/nPUFFa6koDyrJIMsH12HvkMUe5mfkqoTGBbI
 X+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829088; x=1767433888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hkizW9CIJa8Y7ebeAJUdAOMzr6q4+NzvoTNqdXU8uVk=;
 b=bXfRCpHxxNXMu3Q5UpdCVE9F/9yZsMdev0GEALugnGTHLKwjSHytD/z8On8Rr3lQbu
 wZ2JTC2tM7i7012cbXs3AnCtOYgmWNRfu2vCAGN/hmJ602yvDxVqlsYrL9cF3tOryJVH
 B+WPdchvxgHeNOhOFpRDp8PaWlnGrBVQGmj5gnn/IXbiTOS+pbY8+y3o2X4PrCcV5WZe
 Ualyz2O831WpzWLDUz3ouxp2+wj1ypErlM9iQISWqcC6o3wCPYWeC6k5C0B6L81B00fj
 s9mPfoXoMJg/XiTmZR1GUl4EiGEWfsbQTDNH2qmlUNOzAVmbFumWe6O3T9pVLZ3r2cJu
 U6iQ==
X-Gm-Message-State: AOJu0YzduUVLYWPVbfmcb/lad3sTIHfot1nBKBA/cH+5m4ADv2eSTkUv
 GhKF2cGHVJds/HsfOhNcaA4JykCSdxl2cK6a3+9FJcJC4CQt8fkPi115R/aImpmBzhF+1IMvkOM
 MjT4kUWPpfH3hIQe/crqaF1xpkbMTejV1cSW2JupcfJACuxO4xkQOFevFIMhXnQpBwX7bWZIocT
 7KsCmLlxQ/hSoS1MZ//TjzeQOstOsRVruzRhFLpQqc
X-Gm-Gg: AY/fxX7R3iILnOsJR7EfP6LeQ9Xh7vqfhDGZeBZrvNcA3EL8/MNfNbX3Rb8ylddrZ/A
 gtku7EbXb/3uljiRRZD32vL1OP28GI26Ph3RI18V2dY/0aZTFqvZu8Ql0d2k2Cz+HXGr9SWzK4p
 K/CudSArnH/N+Y3lF5MqwfqeVl7ITrdFC4Wr5MSm47f4KvfGNIG42eJWPPbfrb+JiDvDOB13fSd
 0GoLPfbsFzOFPzlFCeJDmB6vlDbZhO9vipm+OrgNxfQ4IpNR1duXZxriotKkIsVeZpAVCW5voGt
 kllKXNrBAUWKa7FIkkPEjA5fv/aie/r/q4VNz5eoVj/ZnqUxZvBO7IGpOZkNYZMkTa1ZTkce+IB
 7JNJNTYBwZw8oLbHtG3HfOM0IH3jfSBxRXNcaA/9lPjtwGeHv0RIFxkFs43p+eX0D4t1UvxpQxd
 GGG7Bv1v4jBMcjpQ4=
X-Received: by 2002:a05:6000:1ac7:b0:432:84f9:9802 with SMTP id
 ffacd0b85a97d-43284f99837mr4743816f8f.49.1766829087958; 
 Sat, 27 Dec 2025 01:51:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDAudvPclDrAayeF22lRCBKqgs/WFCCVLnOyuMv+2UEMvAZ/Cu2TraGkumcrFo94Za4/PUPw==
X-Received: by 2002:a05:6000:1ac7:b0:432:84f9:9802 with SMTP id
 ffacd0b85a97d-43284f99837mr4743788f8f.49.1766829087476; 
 Sat, 27 Dec 2025 01:51:27 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1aee5sm51028869f8f.4.2025.12.27.01.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 142/153] i386/cpu: Allow cache to be shared at thread level
Date: Sat, 27 Dec 2025 10:47:47 +0100
Message-ID: <20251227094759.35658-68-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In CPUID 0x4 leaf, it's possible to make the cache privated at thread
level when there's no HT within the core. In this case, while cache per
thread and cache per core are essentially identical, their topology
information differs in CPUID 0x4.

Diamond Rapids assigns the L1 i/d cache at the thread level. To allow
accurate emulation of DMR cache topology, remove the cache-per-thread
restriction in max_thread_ids_for_cache(), which enables CPUID 0x4 to
support cache per thread topology.

Given that after adding thread-level support, the topology offset
information required by max_thread_ids_for_cache() can be sufficiently
provided by apicid_offset_by_topo_level(), so it's straightforward to
re-implement max_thread_ids_for_cache() based on
apicid_offset_by_topo_level() to reduce redundant duplicate codes.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251215073743.4055227-8-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 65 +++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 44 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f62bd48d4b0..4ed7f4f1c99 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -304,33 +304,30 @@ static void encode_cache_cpuid2(X86CPU *cpu,
                        ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
                        0 /* Invalid value */)
 
+static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
+                                            enum CpuTopologyLevel topo_level)
+{
+    switch (topo_level) {
+    case CPU_TOPOLOGY_LEVEL_THREAD:
+        return 0;
+    case CPU_TOPOLOGY_LEVEL_CORE:
+        return apicid_core_offset(topo_info);
+    case CPU_TOPOLOGY_LEVEL_MODULE:
+        return apicid_module_offset(topo_info);
+    case CPU_TOPOLOGY_LEVEL_DIE:
+        return apicid_die_offset(topo_info);
+    case CPU_TOPOLOGY_LEVEL_SOCKET:
+        return apicid_pkg_offset(topo_info);
+    default:
+        g_assert_not_reached();
+    }
+    return 0;
+}
+
 static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
                                          enum CpuTopologyLevel share_level)
 {
-    uint32_t num_ids = 0;
-
-    switch (share_level) {
-    case CPU_TOPOLOGY_LEVEL_CORE:
-        num_ids = 1 << apicid_core_offset(topo_info);
-        break;
-    case CPU_TOPOLOGY_LEVEL_MODULE:
-        num_ids = 1 << apicid_module_offset(topo_info);
-        break;
-    case CPU_TOPOLOGY_LEVEL_DIE:
-        num_ids = 1 << apicid_die_offset(topo_info);
-        break;
-    case CPU_TOPOLOGY_LEVEL_SOCKET:
-        num_ids = 1 << apicid_pkg_offset(topo_info);
-        break;
-    default:
-        /*
-         * Currently there is no use case for THREAD, so use
-         * assert directly to facilitate debugging.
-         */
-        g_assert_not_reached();
-    }
-
-    return num_ids - 1;
+    return (1 << apicid_offset_by_topo_level(topo_info, share_level)) - 1;
 }
 
 static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
@@ -398,26 +395,6 @@ static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
     return 0;
 }
 
-static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
-                                            enum CpuTopologyLevel topo_level)
-{
-    switch (topo_level) {
-    case CPU_TOPOLOGY_LEVEL_THREAD:
-        return 0;
-    case CPU_TOPOLOGY_LEVEL_CORE:
-        return apicid_core_offset(topo_info);
-    case CPU_TOPOLOGY_LEVEL_MODULE:
-        return apicid_module_offset(topo_info);
-    case CPU_TOPOLOGY_LEVEL_DIE:
-        return apicid_die_offset(topo_info);
-    case CPU_TOPOLOGY_LEVEL_SOCKET:
-        return apicid_pkg_offset(topo_info);
-    default:
-        g_assert_not_reached();
-    }
-    return 0;
-}
-
 static uint32_t cpuid1f_topo_type(enum CpuTopologyLevel topo_level)
 {
     switch (topo_level) {
-- 
2.52.0


