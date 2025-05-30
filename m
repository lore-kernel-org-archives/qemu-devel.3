Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A45C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu1D-0001zu-82; Fri, 30 May 2025 03:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtyJ-0005Lu-9D
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtyH-0007IN-4z
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPHHwWFMg9KR06NH/phG5RTEPKnr+d5BDSxP/nyMYWM=;
 b=bJon4fxgHmvxelX40Cg9bNc0O6YJa/vo1GtOKNPkaJ6r/bd+F69bleGgjYTs2axry1onmK
 pYVa2Mtai/HB+geSdpfjQ1XYBhYjmehSIyhe9hYQXTzhcjEzLhPM8R6IzQh1KZhO7xdzh3
 LfemUlULe9VDr4j2RciBypSl9+3v0h4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-aSoNcbc1MX-HeD7r9-bV4g-1; Fri, 30 May 2025 03:16:02 -0400
X-MC-Unique: aSoNcbc1MX-HeD7r9-bV4g-1
X-Mimecast-MFC-AGG-ID: aSoNcbc1MX-HeD7r9-bV4g_1748589362
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-601f3f35b88so1671306a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589361; x=1749194161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPHHwWFMg9KR06NH/phG5RTEPKnr+d5BDSxP/nyMYWM=;
 b=avPe4TVdF3+4rXjsSDGdrxUiaHrsX9KuvTJ+TAwMIlSTDm1uKMFUHUjusCvgviJ36c
 81/biU9RidTz8GOZ1dHJXMdcLMJirSFbTx404KwJ+B3HOpoePKesU2eLm4RGA37zojHe
 B8hCSdffoI35mqvrK1Dqml/9uL8qu6csXiMQH80ddI2ojYgx8SbeFgR/zTJt76ErP8eG
 nnuUXe23byl+3JDWhRrxGMxjX1Vimu+IwYyvKqUr3CA5gMfIr98uIfVsbCShKLoMGQRO
 pkLlznwSd2B/T2XseJLPphgZiF+oHCyzXL0bjT3Eifz6ocWXz5WbwZ0U2YhfN0Isswyi
 vdOA==
X-Gm-Message-State: AOJu0YxWaHEZsZ97w7Ok2cXCQqxhE+CJR1E7npd1rs+hT2ljhGQ3n4h7
 5SjuHG1PBw/kLwyDDcQ0LoUbE/nWFSAbDSwWMjHvx5zGgT9VpNOd80rQM0u7nw5uZTZiCSOo0hB
 vgtbyz/csjWod5xRkdM/KVVtAh0sxbyYqQw2FPPvn5DGowhHlSxpkmTttfLNIbHlEFo+qdrTval
 mtV/bQIgCV3ka9MI6rX8WQL9GgwPhnwEsjCZciFODA
X-Gm-Gg: ASbGnctWoLGycgv4kadpRYer1+F8R8KjDixaSIq9jh/44X9vfXVz9dlXzrKgRy8qUP2
 ERuJBJsNMSNhElGG4ULiUF4Vh4nL0lpP6qy14TryHnea27eEETfXVx5Ta5HX2zoxeAuWRQm9vrx
 7IvItGllHhXKlscmfemT+6leP0qTk0ukqLGbnqNnFB0T3+R4vAcqokcnlTjyyABpvNDuZh2hJR9
 b+wLu+0JEL/bt25P77ImfJ+EFNqlfdyTe5RhFBdwuWcXzteHKUwGOStl0COSJyt8AN2zCODDeV3
 FLWxL8X4f1ulrQ==
X-Received: by 2002:a05:6402:270f:b0:5f7:f55a:e5c8 with SMTP id
 4fb4d7f45d1cf-6056e15de23mr1704469a12.21.1748589360727; 
 Fri, 30 May 2025 00:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBG9ym8+uDeRuCNm7Itfxp+njPDY9fPtaKPXX9nhEFMF0tAXYxkwVyBU8mRnsucE38umMvqQ==
X-Received: by 2002:a05:6402:270f:b0:5f7:f55a:e5c8 with SMTP id
 4fb4d7f45d1cf-6056e15de23mr1704445a12.21.1748589360250; 
 Fri, 30 May 2025 00:16:00 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c5c222sm1189289a12.27.2025.05.30.00.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Babu Moger <babu.moger@amd.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 75/77] target/i386: Update EPYC-Genoa for Cache property,
 perfmon-v2, RAS and SVM feature bits
Date: Fri, 30 May 2025 09:12:45 +0200
Message-ID: <20250530071250.2050910-76-pbonzini@redhat.com>
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

From: Babu Moger <babu.moger@amd.com>

Found that some of the cache properties are not set correctly for EPYC models.
l1d_cache.no_invd_sharing should not be true.
l1i_cache.no_invd_sharing should not be true.

L2.self_init should be true.
L2.inclusive should be true.

L3.inclusive should not be true.
L3.no_invd_sharing should be true.

Fix these cache properties.

Also add the missing RAS and SVM features bits on AMD EPYC-Genoa model.
The SVM feature bits are used in nested guests.

perfmon-v2     : Allow guests to make use of the PerfMonV2 features.
succor         : Software uncorrectable error containment and recovery capability.
overflow-recov : MCA overflow recovery support.
lbrv           : LBR virtualization
tsc-scale      : MSR based TSC rate control
vmcb-clean     : VMCB clean bits
flushbyasid    : Flush by ASID
pause-filter   : Pause intercept filter
pfthreshold    : PAUSE filter threshold
v-vmsave-vmload: Virtualized VMLOAD and VMSAVE
vgif           : Virtualized GIF
fs-gs-base-ns  : WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing

The feature details are available in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/afe3f05d4116124fd5795f28fc23d7b396140313.1746734284.git.babu.moger@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d1b9077788..a656b3c664e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2643,6 +2643,59 @@ static const CPUCaches epyc_genoa_cache_info = {
     },
 };
 
+static const CPUCaches epyc_genoa_v2_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 1 * MiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 2048,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 32 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 32768,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .no_invd_sharing = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
 /* The following VMX features are not supported by KVM and are left out in the
  * CPU definitions:
  *
@@ -5744,6 +5797,31 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000022,
         .model_id = "AMD EPYC-Genoa Processor",
         .cache_info = &epyc_genoa_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "overflow-recov", "on" },
+                    { "succor", "on" },
+                    { "lbrv", "on" },
+                    { "tsc-scale", "on" },
+                    { "vmcb-clean", "on" },
+                    { "flushbyasid", "on" },
+                    { "pause-filter", "on" },
+                    { "pfthreshold", "on" },
+                    { "v-vmsave-vmload", "on" },
+                    { "vgif", "on" },
+                    { "fs-gs-base-ns", "on" },
+                    { "perfmon-v2", "on" },
+                    { "model-id",
+                      "AMD EPYC-Genoa-v2 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_genoa_v2_cache_info
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "YongFeng",
-- 
2.49.0


