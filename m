Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01C6C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHEw-0000Xv-Th; Mon, 14 Jul 2025 07:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1H-0001r0-Mc
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1D-00029p-U3
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IeYVflmQIXuUpiQZZ5dzz4ZXkBFzZ9p/wIY3g9/xKnE=;
 b=d66Q0z6DhUza/SWQnnV6vZajHR8TAueZSCKSfeGGWZrxSDH8ZUR00f/my4c7xAIJhFtS8o
 FndBhJD77EM+IQ9eZf5u054FZvEembfnfS61UUOlUwLQzrpAnk8Dpb/mjssujX38y48DjT
 PyxMXJTTeZKZ8ymyk7sysYcbtEuY9Kk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-vnG5rIWPNe6-3mnEbyKjpQ-1; Mon, 14 Jul 2025 07:06:44 -0400
X-MC-Unique: vnG5rIWPNe6-3mnEbyKjpQ-1
X-Mimecast-MFC-AGG-ID: vnG5rIWPNe6-3mnEbyKjpQ_1752491203
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45597cc95d5so15274055e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491202; x=1753096002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeYVflmQIXuUpiQZZ5dzz4ZXkBFzZ9p/wIY3g9/xKnE=;
 b=kG89hDzIrM23TsEYMZLMQHFxsXGNDJQntHJ/kHXDrOauYjVSYPnLyQuSnGVkjYzlpu
 lNuHhjUVln9fNodw6/bvBHHpLB/FfjqOEw3ecDso8gUvlFf7wpV7gfp2qcKNH1c0LX9f
 gIvDCw31DE2XFHs7/CvI1HAxcGKJzWPwj98TvdMvaVg70vs4A4eVJkw2JKEHfuIDqRpT
 xv/R4AfL2BF3oE9fMuY3GUazem45Gwb9Mymn6j5da+r710zYpuqalMmq1oO/F+i1oAcE
 fhH+SG168g4uh6eK7Gcc8zyLH5tzRInO90SiFxsczTw2y/Fu96C0y1Omqnyg9/cIkbx/
 5f1w==
X-Gm-Message-State: AOJu0YykPBpwjNLsDHvrSdH/0DgSJoOsZg+eZehDDyKq8FstH4BKdnfN
 9Aj8+73r0jBNgadIFzUqywBms4NcgG8wzIkk5IGyq10CMx5D4Y4NE1f0OFs3OfiQeY/X5RSUnhY
 3ca5s86pqCPPImHHQhlHTQyJn4Wr0/xYf1ulilM8/SV/UEVq8JBxYp/bK/HVA0iyXg/QkBM3AQ8
 kLKCg03k/n9rlr5Ass/1p1ywrc4/umdrDHgqN3wr4J
X-Gm-Gg: ASbGncsrunQ9tsXhGhRoLlXFFGmUD9fylX9OvJ9agJafRVpPCo9kx2Ssb0jC6zTyxep
 Ybs4C2KlNSvQ/WoWhbT45DnQrQ63jf9RU6LafWCiQbCngNFZIuW85XoT7t5N02fzSwR3VsaouDu
 9XIGt3KHpob6SmGHKVC6OXHUSvrmZBeQ6/qNqLKcmFmPxCvA4x7FxC1szbpdvSzVssZuutIgFRw
 R4g63sv60IRFBBoYQa2thrOqhuFsHg2+/rniPMv/OV6RJvmij1WC15DOzT5jUsiUkDQDcr2t9gm
 CaV3rXx6ZaRZKthuB5PaVF6JgPNu8CEQIMaavJjqCUU=
X-Received: by 2002:a05:600c:4eca:b0:456:1abd:fcfc with SMTP id
 5b1f17b1804b1-4561abdff33mr25859685e9.25.1752491201747; 
 Mon, 14 Jul 2025 04:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Bwakdv5CcDFJq+10DU82ym/EXEdtr+XNdEpbDjiUmr1YiNkZ1m9ly+DUZbQ99Sb1BwayVQ==
X-Received: by 2002:a05:600c:4eca:b0:456:1abd:fcfc with SMTP id
 5b1f17b1804b1-4561abdff33mr25859345e9.25.1752491201274; 
 Mon, 14 Jul 2025 04:06:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd180fsm11950860f8f.2.2025.07.14.04.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Tao Su <tao1.su@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 59/77] i386/cpu: Introduce cache model for GraniteRapids
Date: Mon, 14 Jul 2025 13:03:48 +0200
Message-ID: <20250714110406.117772-60-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add the cache model to GraniteRapids (v3) to better emulate its
environment.

The cache model is based on GraniteRapids-SP (Scalable Performance):

      --- cache 0 ---
      cache type                         = data cache (1)
      cache level                        = 0x1 (1)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x1 (1)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0xc (12)
      number of sets                     = 0x40 (64)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 64
      (size synth)                       = 49152 (48 KB)
      --- cache 1 ---
      cache type                         = instruction cache (2)
      cache level                        = 0x1 (1)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x1 (1)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x10 (16)
      number of sets                     = 0x40 (64)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 64
      (size synth)                       = 65536 (64 KB)
      --- cache 2 ---
      cache type                         = unified cache (3)
      cache level                        = 0x2 (2)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x1 (1)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x10 (16)
      number of sets                     = 0x800 (2048)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 2048
      (size synth)                       = 2097152 (2 MB)
      --- cache 3 ---
      cache type                         = unified cache (3)
      cache level                        = 0x3 (3)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0xff (255)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x10 (16)
      number of sets                     = 0x48000 (294912)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = true
      number of sets (s)                 = 294912
      (size synth)                       = 301989888 (288 MB)
      --- cache 4 ---
      cache type                         = no more caches (0)

Suggested-by: Tejus GK <tejus.gk@nutanix.com>
Suggested-by: Jason Zeng <jason.zeng@intel.com>
Suggested-by: "Daniel P . Berrangé" <berrange@redhat.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Tao Su <tao1.su@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711104603.1634832-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3c28e9588af..d1fc74eb0e3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2883,6 +2883,97 @@ static const CPUCaches epyc_turin_cache_info = {
     }
 };
 
+static const CPUCaches xeon_gnr_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x0.EAX */
+        .type = DATA_CACHE,
+        .level = 1,
+        .self_init = true,
+
+        /* CPUID 0x4.0x0.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 12,
+
+        /* CPUID 0x4.0x0.ECX */
+        .sets = 64,
+
+        /* CPUID 0x4.0x0.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        .size = 48 * KiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x1.EAX */
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .self_init = true,
+
+        /* CPUID 0x4.0x1.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 16,
+
+        /* CPUID 0x4.0x1.ECX */
+        .sets = 64,
+
+        /* CPUID 0x4.0x1.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        .size = 64 * KiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x2.EAX */
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .self_init = true,
+
+        /* CPUID 0x4.0x2.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 16,
+
+        /* CPUID 0x4.0x2.ECX */
+        .sets = 2048,
+
+        /* CPUID 0x4.0x2.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        .size = 2 * MiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x3.EAX */
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .self_init = true,
+
+        /* CPUID 0x4.0x3.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 16,
+
+        /* CPUID 0x4.0x3.ECX */
+        .sets = 294912,
+
+        /* CPUID 0x4.0x3.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = true,
+
+        .size = 288 * MiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_SOCKET,
+    },
+};
+
 static const CPUCaches xeon_srf_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         /* CPUID 0x4.0x0.EAX */
@@ -4951,6 +5042,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 }
             },
+            {
+                .version = 3,
+                .note = "with gnr-sp cache model",
+                .cache_info = &xeon_gnr_cache_info,
+            },
             { /* end of list */ },
         },
     },
-- 
2.50.0


