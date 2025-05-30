Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D484C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu0j-000177-Cf; Fri, 30 May 2025 03:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtyD-0005EP-Pl
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtyB-0007Hu-Qb
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KInY1GN++8jfGN+Yfdp4bwpwskt5gNS1m8VkUK4P5Rk=;
 b=PikipljNGIvuNARd5J7ft7wkSDHgB2eBJx6+tZ8fzkfOIy4V+QoNSfzV3caC9w46iIDS+I
 XjNo7HZUVuBdO8FTSnYSRWn9I1WdhWfdqk8vXfpi/8/Nx3yNVcR4EWdQ7YeCnyAaTyLz7A
 fbfOHf5jO02PhLcGdAsk+MXk35nitKo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-fNu_8shEMSGfv5SSOZI7UA-1; Fri, 30 May 2025 03:15:57 -0400
X-MC-Unique: fNu_8shEMSGfv5SSOZI7UA-1
X-Mimecast-MFC-AGG-ID: fNu_8shEMSGfv5SSOZI7UA_1748589357
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-adb32dbf60bso62663766b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589356; x=1749194156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KInY1GN++8jfGN+Yfdp4bwpwskt5gNS1m8VkUK4P5Rk=;
 b=gr+MKFP4StM0paD953pf4tGBiRIomDxsuCC99Ks0EeWU5BXzBgfsYBLb9ezzcX38D4
 DVjo39IPCvQfv+wYG6fHH23J/n5nCJPM3suF3YREuIqwfi0NtVbc7b6TtD+f7/UlLHWz
 Tiwzk6ggwnYEOm4m7Z06ocFcBc2K1D+PtL36fCxAh2+0Ra88a2Cl4jUu5FdE3kzxJ24t
 IojnOC/sHkTbvytBiOuxyQ62tnwBoTdbfhztdQXwKdGgfTP+RsbfA6XF068LhuhZQUqF
 TWTTSjEHRMKtTpTk9D8jp7Pzf/x5O/avJHPhIYv2hpawCHpOG5nl1W8Z2z5h9AbQPKD1
 GsjA==
X-Gm-Message-State: AOJu0Yyn2OBA00+OMd1u9Y0LY/AHS+cmTD9OcLEYPhE7OyfqxG5WkiC6
 44DStnopXbNV+r0cd8t8UGdtPl76HDZ5iSPLyeiHqChH0Q66T94j2Jxc4uSGqXspIF3wJpGkkGq
 74TJCHnQtpjQAmOeFS3R1qdNK+kSUw6NSg8vn3rfhCEEKP4Fo6quwr/gWss/7Vyi3lfAQvslGAS
 NWomIALt2G1v8eRJ065B4N/tGajO6gkN5HIDv6pfBz
X-Gm-Gg: ASbGncuCDkFReCv2d3OoBj6IASkQO653icSWsu0VQHEdIMYEkJdtPPlk3PGoyiBUY4i
 P7tJCWwndEQJHj0p1PBJULv6ccWyiwSizHfaOfxcoJl9mqhikD0U1dbCAdBCIP8LZ2YrIiVRg2p
 TTql3MUz7EA+YzPKi0RTrLXtUJi+ucskN7siB3xvh7+HamgW+FMSaE3oDNhrx7BLLbqULPHaxNB
 E4EGFpnoWNQF8kQsT5/vS1z1zGOW0jsD9UKJOFEA2yuaMPFv7BYQE37sFSnkCejrVdveyuypT0t
 jgrOxBtEwEoT/qimJ1BJKHns
X-Received: by 2002:a17:907:3d8f:b0:ad5:5293:f236 with SMTP id
 a640c23a62f3a-adb32248cdamr219522666b.3.1748589355682; 
 Fri, 30 May 2025 00:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsZoDKgtzUm8C7Tfse6/LL2p0AjLUyK/LbuqassuBfr8GMu4IO7xtN0DDu9Rqp1OeueY/o0Q==
X-Received: by 2002:a17:907:3d8f:b0:ad5:5293:f236 with SMTP id
 a640c23a62f3a-adb32248cdamr219518866b.3.1748589355180; 
 Fri, 30 May 2025 00:15:55 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82d446sm273588366b.38.2025.05.30.00.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Babu Moger <babu.moger@amd.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 73/77] target/i386: Update EPYC-Milan CPU model for Cache
 property, RAS, SVM feature bits
Date: Fri, 30 May 2025 09:12:43 +0200
Message-ID: <20250530071250.2050910-74-pbonzini@redhat.com>
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

Also add the missing RAS and SVM features bits on AMD EPYC-Milan model.
The SVM feature bits are used in nested guests.

succor          : Software uncorrectable error containment and recovery capability.
overflow-recov  : MCA overflow recovery support.
lbrv            : LBR virtualization
tsc-scale       : MSR based TSC rate control
vmcb-clean      : VMCB clean bits
flushbyasid     : Flush by ASID
pause-filter    : Pause intercept filter
pfthreshold     : PAUSE filter threshold
v-vmsave-vmload : Virtualized VMLOAD and VMSAVE
vgif            : Virtualized GIF

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/c619c0e09a9d5d496819ed48d69181d65f416891.1746734284.git.babu.moger@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5b5324a35cb..d01a808e3a3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2535,6 +2535,60 @@ static const CPUCaches epyc_milan_v2_cache_info = {
     },
 };
 
+static const CPUCaches epyc_milan_v3_cache_info = {
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
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 1024,
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
+
 static const CPUCaches epyc_genoa_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
@@ -5597,6 +5651,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_milan_v2_cache_info
             },
+            {
+                .version = 3,
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
+                    { "model-id",
+                      "AMD EPYC-Milan-v3 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_milan_v3_cache_info
+            },
             { /* end of list */ }
         }
     },
-- 
2.49.0


