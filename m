Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1937C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu1q-0002oQ-Cp; Fri, 30 May 2025 03:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxd-0003yl-IX
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxb-0007Ei-Tw
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I97BpjBsZhexIEDVYyyunQVZjuxFbCSEhOQVOnGSDMM=;
 b=Y+S/bpNb+aPvv6GQ1WnKMsesZDNZrhQuK73bZrODgLo2+nRj7HCGROHcWW/277ZnRACep0
 BtIyxTINL/w/UShLRmN/QJsIsiRlzYGw80P7yChcB54lcWANyd98s/bWFTBuzVrG+Po+7M
 zwLBYCTtGYk87LJhmlXh+zZ4IRIEjFo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-eayJnBwPOG-IMkSaGcSFrA-1; Fri, 30 May 2025 03:15:21 -0400
X-MC-Unique: eayJnBwPOG-IMkSaGcSFrA-1
X-Mimecast-MFC-AGG-ID: eayJnBwPOG-IMkSaGcSFrA_1748589320
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad8a2dc92ddso124189266b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589319; x=1749194119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I97BpjBsZhexIEDVYyyunQVZjuxFbCSEhOQVOnGSDMM=;
 b=mdJnsLlT196ZmR0SkzuBvvOCDq7hVjaFnFDRrw95Uflbq4GxhNprsTWBdf9mBVNglN
 kvx6GAo5r56hn63pL5XIbYuzC4R680GLivZONHTZNd0+OZ16nTNIpUaKss02W3WUT6QU
 J9Qz8zBS7qruhqfloG7MhTlrS2rTfBUIALkreBIquoLtVTD5m1mBQNZ/GPK9uGZ+YShN
 u3uGr3to2niGvjHmlESIy9PUDFFQmvODxS1niG/Pn/hqy10QK7weXGF5h4X4vBxsp7s3
 098n16HVXqMC5V0dGwJyYmyDiuD7gwsz1ML3GKDVQI0K0Ti7Ny5KNjnvlbR+uVlv2w+d
 yaJg==
X-Gm-Message-State: AOJu0Ywcv30WNiXPWElT5lEDcKA/D1gyxeqr4COSe1gOlp2Zsq3Q/nCF
 dUedgfuDKO4gwrWhTrOmv1c4KcNNMPNIAQv8AMIlhnmLBDbqatugOBvODpmGZtAFeNkDw5v81Zy
 3OPSky19TWmH3uI09XTSirIxCVqiOTOJIyQkkC0bW0EndQQhjYunlmhgzF8etjth+qLc/XZe2j2
 EzeDlZPx70FV+rtkweYA5toeMp+nuWi2l8CkaWrOp6
X-Gm-Gg: ASbGnct5T6kVfSc/Tz40XXJbzGWr+13sBBh/eTK5ldM7JnneGWVO5XQ80qX0e3wBkpR
 bwWrH8Rs0VqfxE979kWue0sBbINxWxxV83ayugtszlKH1CK3snFyMth5GeK9zROx7K5TJH2adhW
 WyhkYbavuoeca412fXyJFGZFJNlxGdD+f2Zy2nyBx62kq/Z8flyp2+gB+HY/aDzg7f9P3XXwTs2
 H2GQ/dzVtIGHN8DqNM/c563F2nNMjKVM7ROQ3N/0t7ZndtMLgKIYqc83q1zn6hKhgxcXMy2ZDU1
 yptRQNfKzFA5oA==
X-Received: by 2002:a17:907:7ba7:b0:ad8:96d2:f3b with SMTP id
 a640c23a62f3a-adb322ab0f4mr205345466b.27.1748589319545; 
 Fri, 30 May 2025 00:15:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH09F5c5lNRGie69php26hZ5x/f9XdC27FLPy5m5ANRsKdBrNORJgzzqiiXDMApSwEHFdjOLw==
X-Received: by 2002:a17:907:7ba7:b0:ad8:96d2:f3b with SMTP id
 a640c23a62f3a-adb322ab0f4mr205342166b.27.1748589319011; 
 Fri, 30 May 2025 00:15:19 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5dd045c8sm275719866b.103.2025.05.30.00.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 58/77] i386/tdx: Add supported CPUID bits related to TD
 Attributes
Date: Fri, 30 May 2025 09:12:28 +0200
Message-ID: <20250530071250.2050910-59-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

For TDX, some CPUID feature bit is configured via TD attributes. They
are not covered by tdx_caps.cpuid (which only contians the directly
configurable CPUID bits), but they are actually supported when the
related attributre bit is supported.

Note, LASS and KeyLocker are not supported by KVM for TDX, nor does
QEMU support it (see TDX_SUPPORTED_TD_ATTRS). They are defined in
tdx_attrs_maps[] for the completeness of the existing TD Attribute
bits that are related with CPUID features.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-47-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |  4 +++
 target/i386/kvm/tdx.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 342e4f2a572..e50c57264dc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -899,6 +899,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_ECX_LA57              (1U << 16)
 /* Read Processor ID */
 #define CPUID_7_0_ECX_RDPID             (1U << 22)
+/* KeyLocker */
+#define CPUID_7_0_ECX_KeyLocker         (1U << 23)
 /* Bus Lock Debug Exception */
 #define CPUID_7_0_ECX_BUS_LOCK_DETECT   (1U << 24)
 /* Cache Line Demote Instruction */
@@ -959,6 +961,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_1_EAX_AVX_VNNI          (1U << 4)
 /* AVX512 BFloat16 Instruction */
 #define CPUID_7_1_EAX_AVX512_BF16       (1U << 5)
+/* Linear address space separation */
+#define CPUID_7_1_EAX_LASS              (1U << 6)
 /* CMPCCXADD Instructions */
 #define CPUID_7_1_EAX_CMPCCXADD         (1U << 7)
 /* Fast Zero REP MOVS */
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 9d92ff1484b..fa161661fa8 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -458,6 +458,34 @@ KvmCpuidInfo tdx_fixed1_bits = {
     },
 };
 
+typedef struct TdxAttrsMap {
+    uint32_t attr_index;
+    uint32_t cpuid_leaf;
+    uint32_t cpuid_subleaf;
+    int cpuid_reg;
+    uint32_t feat_mask;
+} TdxAttrsMap;
+
+static TdxAttrsMap tdx_attrs_maps[] = {
+    {.attr_index = 27,
+     .cpuid_leaf = 7,
+     .cpuid_subleaf = 1,
+     .cpuid_reg = R_EAX,
+     .feat_mask = CPUID_7_1_EAX_LASS,},
+
+    {.attr_index = 30,
+     .cpuid_leaf = 7,
+     .cpuid_subleaf = 0,
+     .cpuid_reg = R_ECX,
+     .feat_mask = CPUID_7_0_ECX_PKS,},
+
+    {.attr_index = 31,
+     .cpuid_leaf = 7,
+     .cpuid_subleaf = 0,
+     .cpuid_reg = R_ECX,
+     .feat_mask = CPUID_7_0_ECX_KeyLocker,},
+};
+
 static struct kvm_cpuid_entry2 *find_in_supported_entry(uint32_t function,
                                                         uint32_t index)
 {
@@ -494,6 +522,37 @@ static void tdx_add_supported_cpuid_by_fixed1_bits(void)
     }
 }
 
+static void tdx_add_supported_cpuid_by_attrs(void)
+{
+    struct kvm_cpuid_entry2 *e;
+    TdxAttrsMap *map;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(tdx_attrs_maps); i++) {
+        map = &tdx_attrs_maps[i];
+        if (!((1ULL << map->attr_index) & tdx_caps->supported_attrs)) {
+            continue;
+        }
+
+        e = find_in_supported_entry(map->cpuid_leaf, map->cpuid_subleaf);
+
+        switch(map->cpuid_reg) {
+        case R_EAX:
+            e->eax |= map->feat_mask;
+            break;
+        case R_EBX:
+            e->ebx |= map->feat_mask;
+            break;
+        case R_ECX:
+            e->ecx |= map->feat_mask;
+            break;
+        case R_EDX:
+            e->edx |= map->feat_mask;
+            break;
+        }
+    }
+}
+
 static void tdx_setup_supported_cpuid(void)
 {
     if (tdx_supported_cpuid) {
@@ -508,6 +567,7 @@ static void tdx_setup_supported_cpuid(void)
     tdx_supported_cpuid->nent = tdx_caps->cpuid.nent;
 
     tdx_add_supported_cpuid_by_fixed1_bits();
+    tdx_add_supported_cpuid_by_attrs();
 }
 
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
-- 
2.49.0


