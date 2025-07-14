Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA3CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHEh-0008Kj-UV; Mon, 14 Jul 2025 07:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1P-0001uN-2P
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1H-0002B4-C1
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbO1ToDtiUiii5SeqRxswGcPOFB4IlcJ2O71e0W8uxg=;
 b=HwQRXB40VbTzhCJr/X7pSCd2CR54vUjI3jC5JqfhJfK43Xvx5FaIWEfZKl1Wn9kY3AhWLT
 TkFKUFx+7vrcHz44CRheIlvoSGtFNw5hPoWX0SxyOu+jI+BtDnUFcJW6eAaex6dNYv3CGk
 xoKzhc7/4RqP/AWxjNFVdD9nUfduLII=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-QNkXd3K9OJubumF0v90_uA-1; Mon, 14 Jul 2025 07:06:48 -0400
X-MC-Unique: QNkXd3K9OJubumF0v90_uA-1
X-Mimecast-MFC-AGG-ID: QNkXd3K9OJubumF0v90_uA_1752491206
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4560f28b2b1so4928995e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491205; x=1753096005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbO1ToDtiUiii5SeqRxswGcPOFB4IlcJ2O71e0W8uxg=;
 b=NZWGpz/dVdfRiS3jJG7rJICYY0Tc95VbpoieW5guz9zT/hRJ30VcaW6vPkUp7q9hvd
 Jxf0DxizsZmUUWfRSyDgkvOw9Z4X2F5hczP65g3ixZFKQu2ZhKi/RAfL4/teoa2b/pA1
 dppl3d4XLqLjld8UH0XQF2y38ZK9JW98oGrTI+iVH3f1IN5oAFckKshnecrMfIYfpsZb
 KT5406eyIt9jIZY1Bd9Nfm2D82xMJE5JPAorgjkpjZtpo6tBGfn8h7FwAhiNQR5e2zdG
 +zbhb6POtMfA4FECRZIBIxlGz8FD5o3FcOVz20R6ce9YpjA84ZhamXJPW9EKls3dGZka
 4qCQ==
X-Gm-Message-State: AOJu0YxKIwiwt8VLVDCub3Cc08JDxQbAWZylR5bt9VAwkx8atneVbCux
 +guQc+i5Mjvqt6ts2CwBj3HhmWGhIHfLnDiE6COGfegs5OdPeXgYRpzUglzWjQKKXC3wdhumfD0
 w1hphxIV6PU7xlV6PRa0XtuUMSGuYd7R5URsQtsIU5IiPZKmZVmxNtLHQVHBj8/wcWthBwdfR+f
 hd7oRKxVJL9YkPn3OXBRpCIKHZBbFhJJg7I7aYetrn
X-Gm-Gg: ASbGncsB4RXvzbC7fhCvRA1qhkUANIlANFQD6CeHryHPpV1bRrbh5yMwRho5eXvns7B
 BO9DpiMJWjwtEF1SYB9vMeYpwSYZPLSCEChx9LFd3ly47pRx4XsEWaPSCq6bW88+j1SuKGMYDrD
 cBfqL9w4aHhNl6+GLqAlnqF0vZCDDEplpU7QtTd4pakJe4eL6EiPDwiOYWCzcCU8tMBpAsjxqSw
 ofmHHpBkpxhpjmII6YZDWq90m3D498Ogn6b0SJfkOCrBbbVl+08ne1Fe/W7nEK5LE1qIZkox51B
 oQjJqvu4EU1hGTZSh62xNhIEKxOQ00CWmJt/HaDTGmk=
X-Received: by 2002:a05:600c:34c5:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-45565edc8f4mr99213105e9.23.1752491204644; 
 Mon, 14 Jul 2025 04:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7D91aUOhqY11/funSDOFl9sVYjqIpeRmDlEvZG0s41X6toPTEeJMFBX8tx5aADgtwipU96Q==
X-Received: by 2002:a05:600c:34c5:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-45565edc8f4mr99212695e9.23.1752491204097; 
 Mon, 14 Jul 2025 04:06:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e2747fsm11855976f8f.100.2025.07.14.04.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Tao Su <tao1.su@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 60/77] i386/cpu: Introduce cache model for SapphireRapids
Date: Mon, 14 Jul 2025 13:03:49 +0200
Message-ID: <20250714110406.117772-61-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Add the cache model to SapphireRapids (v4) to better emulate its
environment.

The cache model is based on SapphireRapids-SP (Scalable Performance):

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
      ways of associativity              = 0x8 (8)
      number of sets                     = 0x40 (64)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = false
      number of sets (s)                 = 64
      (size synth)                       = 32768 (32 KB)
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
      maximum IDs for CPUs sharing cache = 0x7f (127)
      maximum IDs for cores in pkg       = 0x3f (63)
      system coherency line size         = 0x40 (64)
      physical line partitions           = 0x1 (1)
      ways of associativity              = 0xf (15)
      number of sets                     = 0x10000 (65536)
      WBINVD/INVD acts on lower caches   = false
      inclusive to lower caches          = false
      complex cache indexing             = true
      number of sets (s)                 = 65536
      (size synth)                       = 62914560 (60 MB)
      --- cache 4 ---
      cache type                         = no more caches (0)

Suggested-by: Tejus GK <tejus.gk@nutanix.com>
Suggested-by: Jason Zeng <jason.zeng@intel.com>
Suggested-by: "Daniel P . Berrangé" <berrange@redhat.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Tao Su <tao1.su@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711104603.1634832-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d1fc74eb0e3..b3b29f69666 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2883,6 +2883,97 @@ static const CPUCaches epyc_turin_cache_info = {
     }
 };
 
+static const CPUCaches xeon_spr_cache_info = {
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
+        .associativity = 8,
+
+        /* CPUID 0x4.0x1.ECX */
+        .sets = 64,
+
+        /* CPUID 0x4.0x1.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = false,
+
+        .size = 32 * KiB,
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
+        .associativity = 15,
+
+        /* CPUID 0x4.0x3.ECX */
+        .sets = 65536,
+
+        /* CPUID 0x4.0x3.EDX */
+        .no_invd_sharing = false,
+        .inclusive = false,
+        .complex_indexing = true,
+
+        .size = 60 * MiB,
+        .share_level = CPU_TOPOLOGY_LEVEL_SOCKET,
+    },
+};
+
 static const CPUCaches xeon_gnr_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         /* CPUID 0x4.0x0.EAX */
@@ -4889,6 +4980,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 }
             },
+            {
+                .version = 4,
+                .note = "with spr-sp cache model",
+                .cache_info = &xeon_spr_cache_info,
+            },
             { /* end of list */ }
         }
     },
-- 
2.50.0


