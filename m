Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E7F105A584
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0drE-0003rt-Av; Thu, 12 Mar 2026 07:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dr0-0003lR-S6
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqt-0000Qc-67
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkW2dPyvciirUsDcqFbuxfFBef+xd1Q9oGk4wtKZV8w=;
 b=KyvnUd6oEVaUSEld6HmmorVGDmZV5QVyDdOhOZUZLW3LPb+uPVRY2Px8IaY/XQL8izGODl
 dhASJ0lAkI8lGLT3UmvZ2jjV0ZKGKRuVb0ox/K85QymwSqK/qw4Ugr76y00VwpSR3iCxCb
 kcq7EMFBO3/ILca4B10Qqj0R8wCwCzs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-0GkkFKAlOU6aZb-Vd-AbYw-1; Thu, 12 Mar 2026 07:05:12 -0400
X-MC-Unique: 0GkkFKAlOU6aZb-Vd-AbYw-1
X-Mimecast-MFC-AGG-ID: 0GkkFKAlOU6aZb-Vd-AbYw_1773313511
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439c794edd9so836670f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313510; x=1773918310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkW2dPyvciirUsDcqFbuxfFBef+xd1Q9oGk4wtKZV8w=;
 b=qCIUNULSwUb6wp97KiqZKKlNTLBB1DfNdsbgPrJ6acw8InNhFPPggMBTj7tX0EgK5J
 /ZK8+eK/j9FittTAt9DgyPilJ18ZPwAa62z6pQsA2oaZ/4kagM5LxixiVbJ8tgHpL4ih
 cxnLd2HMW1chytUbKLmfQlmBrRXh6s8BTykNFCfUSqxRJDVgyS/Gs1xjSAAyVq7uonH/
 tB5hCtaF4asbIkOqD/kjZDtFU64mW7466UcvxgavUZ6XrUL/6gli8Bt6aqoVm0k85LMQ
 Y81RH5WL/9bzacg5FogUfGzsy3WktUL/PvExcqPFl/X5PIMaQHfqi40MH08JhXg4R84Z
 DhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313510; x=1773918310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RkW2dPyvciirUsDcqFbuxfFBef+xd1Q9oGk4wtKZV8w=;
 b=YsfD2JLgQE8kVtqG8zZDUYC5viJ9fMfi3v3siwLxjNvC94BgdQ5S+nTVPxY+RgLddy
 k+dMHFrcu/4S4ndtWuWsAcDHZVnNCPHnhOVd52Q5m+eNIo74i/mc6b6OwhIt/ZTdJGY+
 2MbP20tZ4OzisPpLKKScjIwahOLe5Co9vM17XjxyiKAeYoNWg3kRNF95pLoGLiWJ7CHQ
 bipPX5rJO36vfqa9vXwShLKbWe180olYkaAomNBtBC5SVdeOnl9iV9Gwaju0oIz8/uWM
 lNFqmH7zH4wlV0aV0/cugcnxmr/aDoKzVD1LTRqzfRK3NBmXO6Srn3SPKK/PSIbd6bCN
 vSPA==
X-Gm-Message-State: AOJu0Yz1EAau4vISbAb0XOmNkP1rSoAv0fBpfDZQ5HJSWN/36VVlJQMh
 jYYXOWDoxr8LQfbxe0pdrx2PRGMSwY6H7y5EXbPaBPwT9vc5ic7LMiVKDgC/gsR51uM+TqHtT9+
 fJC7eUQUrWpuBZkShyI3hLTtiuoA4Pv5zl5blxebUP9KKQ0srs4xUuOZsvJFRK/6mR+qbzqv+Zk
 mV7QoHnF+9C+Qtbn81oiWtTv6zhSRMMTEObXhVkCY2
X-Gm-Gg: ATEYQzyBuG2DF1lAN6tBMgoe+EbbqBzzLtIbSn9oBbMg2Kcl/q45wbhyW4xfFoTYtKg
 0T3wEMP3jlVKKUjQ5fQf7D/6Y5WRUnzA5fKf9Bd9EE8lYV3zIwtku4hQEcumH71hJShVMN4n+bm
 RGtzJnSe/50w6hbxMIT5Sf4a3OFE5brK6L5kOwegsvhp+dFiKYJdcaAsQc2QEL13u1qPxrEzCUa
 KRPW/aEKgIOxVK6wxZ4u5bLpKLH7t3m7iFn+iBIhDCisAbs8zZfd0lbWzJJF+m5SuOjBphH9+Ji
 TtG6a7AymX1aZc/rhEKQ/HN1HlcftEvUm+ub8GifCsXBx1KFdau+cK2O6KucIzEq620uo3U9NIG
 cQopD6o1JSHRWPtIvmOrD+ElUglx+WXfpkrLzEaImhSU4tKpvF7F+YJ0rzm/fPoXJd9pzC6c+de
 oIj9f7yG9byoR0Z2ZmJCqdUi9Qm0w=
X-Received: by 2002:a5d:5849:0:b0:439:be82:1fd9 with SMTP id
 ffacd0b85a97d-439f81bc52bmr11356914f8f.12.1773313510106; 
 Thu, 12 Mar 2026 04:05:10 -0700 (PDT)
X-Received: by 2002:a5d:5849:0:b0:439:be82:1fd9 with SMTP id
 ffacd0b85a97d-439f81bc52bmr11356835f8f.12.1773313509516; 
 Thu, 12 Mar 2026 04:05:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20b544sm7784107f8f.20.2026.03.12.04.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:05:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Zhijun Zeng <zhijun.zeng@intel.com>,
 Chao Peng <chao.p.peng@intel.com>
Subject: [PULL 06/14] i386/cpu: Enable CPUID 0x1f & cache model for
 ClearwaterForest
Date: Thu, 12 Mar 2026 12:04:38 +0100
Message-ID: <20260312110451.685161-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

ClearwaterForest has CPUID 0x1f by default, so force enabling this leaf
for it (ClearwaterForect-v3).

And add the cache model to ClearwaterForest (v3) to better emulate its
environment.

The cache model is based on ClearwaterForest-AP (Advanced Performance):

      --- cache 0 ---
      cache type                         = data cache (1)
      cache level                        = 0x1 (1)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x0 (0)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x8 (8)
      number of sets                     = 0x40 (64)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 64
      (size synth)                       = 32768 (32 KB)
      --- cache 1 ---
      cache type                         = instruction cache (2)
      cache level                        = 0x1 (1)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x0 (0)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x8 (8)
      number of sets                     = 0x80 (128)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 128
      (size synth)                       = 65536 (64 KB)
      --- cache 2 ---
      cache type                         = unified cache (3)
      cache level                        = 0x2 (2)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x7 (7)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x10 (16)
      number of sets                     = 0x1000 (4096)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 4096
      (size synth)                       = 4194304 (4 MB)
      --- cache 3 ---
      cache type                         = unified cache (3)
      cache level                        = 0x3 (3)
      self-initializing cache level      = true
      fully associative cache            = false
      maximum IDs for CPUs sharing cache = 0x3ff (1023)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0x10 (16)
      number of sets                     = 0x84000 (540672)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = true
      number of sets (s)                 = 540672
      (size synth)                       = 553648128 (528 MB)
      --- cache 4 ---
      cache type                         = no more caches (0)

Suggested-by: Zhijun Zeng <zhijun.zeng@intel.com>
Suggested-by: Chao Peng <chao.p.peng@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260310140819.1563084-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cd44a624201..1debc0c61fc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3318,6 +3318,97 @@ static const CPUCaches xeon_srf_cache_info = {
     },
 };
 
+static const CPUCaches xeon_cwf_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        /* CPUID 0x4.0x0.EAX */
+        .type = DATA_CACHE,
+        .level = 1,
+        .self_init = true,
+
+        /* CPUID 0x4.0x0.EBX */
+        .line_size = 64,
+        .partitions = 1,
+        .associativity = 8,
+
+        /* CPUID 0x4.0x0.ECX */
+        .sets = 64,
+
+        /* CPUID 0x4.0x0.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        .size = 32 * KiB,
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
+        .associativity = 8,
+
+        /* CPUID 0x4.0x1.ECX */
+        .sets = 128,
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
+        .sets = 4096,
+
+        /* CPUID 0x4.0x2.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        .size = 4 * MiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_MODULE,
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
+        .sets = 540672,
+
+        /* CPUID 0x4.0x3.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = true,
+
+        .size = 528 * MiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_SOCKET,
+    },
+};
+
 static const CPUCaches yongfeng_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         /* CPUID 0x4.0x0.EAX */
@@ -5963,9 +6054,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
-                .note = "with its-no",
+                .note = "with its-no, cwf-ap cache model and 0x1f leaf",
+                .cache_info = &xeon_cwf_cache_info,
                 .props = (PropValue[]) {
                     { "its-no", "on" },
+                    { "x-force-cpuid-0x1f", "on" },
                     { /* end of list */ },
                 }
             },
-- 
2.53.0


