Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903DECD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6f-00054K-Oy; Thu, 30 Apr 2026 13:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6e-00052I-Hm
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6c-0004VA-Al
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYW3tZjd2YtBr3/DviKXJBILscYsWNHcgFO3TAJr2lk=;
 b=fwP/3YVkQRHnRlR6uWAHSlzkvvwdGj6GT3HFyFCHlBtod1xrPXSQ5mx1ZP+fH2QixTAyr2
 NLDn3vj9VTtNlekj+8ZibQKxjYMdi7otgnlEMLK1t1JtaCScsnO/Z/vLBvkdc2J58A3DLp
 10nNQiZleZonQHhHByLmjntoSLPMDik=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-Oz-2hl-7P2Sj_-BSEuKekQ-1; Thu, 30 Apr 2026 13:23:16 -0400
X-MC-Unique: Oz-2hl-7P2Sj_-BSEuKekQ-1
X-Mimecast-MFC-AGG-ID: Oz-2hl-7P2Sj_-BSEuKekQ_1777569796
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8d654ade33aso486834185a.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569795; x=1778174595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYW3tZjd2YtBr3/DviKXJBILscYsWNHcgFO3TAJr2lk=;
 b=c/lTUCfDt9+VWslZPXJDXKGTtiYOAwFCVMWQiZr1fOiBjxh/NQpFP8V6blIRkghPEw
 /oQmXo5jsC8QM1Pw7BosvdvHwxT5uE5+C5Lee0mlnQ9ICqhQl1iCc/Lf1rKPnO7qT5/D
 Hu+NjHLNxwo7AeeLGmJxLEUK+g7PVyOA+7WH4aJgXOe9nyB0u9YkYLq5b53EU5fxnmXL
 P8pUBdpiiASUDzZzMdX4LaxJLijHrjGIk6JMqxEwNI45XllqvLxVEFzKdt2Sw1PwNLY7
 UFeBGJUjQBds7B/7Vnm8pojVsPHjjoVJHEYHskqdPKK/gKn7yNoiomeUQ+uwaglecRXa
 JUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569795; x=1778174595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oYW3tZjd2YtBr3/DviKXJBILscYsWNHcgFO3TAJr2lk=;
 b=Zc5WISSW1hSBJ+D9XCLe+3xH+cXcVYDrBEUHovcK2NY5UPymaRJdca0BVJJPij/QOw
 noNGIfUHgZWIKL9qreVIRqPP+X2eRG3QSO4dEHFyyX+Ef/yobjmmQ3QdK00K4t+Vs343
 yJ/P59+ysJqorttscCxK7S94KVKreU91uGZfjXte1JkjTZKGj4sOC1jBLP5hSH1rtjau
 2wE/aO/5FshQg4YCQr36EsQQG25n69y2QDVCwNQUhHnj3gnPMcvy7icZRucu5Vw2E+Uk
 Ko+w/2WFnh0kbCFHs1qmND5T594gHHqY/kzXgEGG4fliHGf7rgx4UWd3QZwEMeMftofq
 GO2A==
X-Gm-Message-State: AOJu0YwBOXWuvg92duLOEruD2PN1pqO89sh8JfYiSEadS7Tzu+W4Kwx3
 mYuvN+Gd0HJtbrZAUMbtVHJXUhh/NqAfu9gyEyVtV6koSZd1nm62zUlr61t4cE+s78vT7/vQ/ph
 HnHKxPlaPTsUiZlT2WxL/I7JOC+yUQlnSBCGizTvW2CZKbpwilDtN9xbO6zEeHHD4s+shEjqRFF
 dZ7nxNkHBTV+uG4ERG0IQZIXwk86URM6gcq6D3a+YV
X-Gm-Gg: AeBDietHhMd5qbvB+xqO8Bokt+SbHLiV2H3hYARfnfxX1mdRBFJkI38o7de6Kk81iLK
 7+TWmxy4SaQPBjWf/E5sV+EA1l4AVEk1MUt0AptarZe7s6Ogdmtp9Z7FxD/icPKCnMVkOk1jWIy
 kZ98VsuYENuhu13znqo0vR7bX1Xjs0SVApqCxqLcwSM3PZuErJy2j142w4LuPY8YPAn4yi0nFTU
 /75oOzX8MmOa42FW4ou5q28KVh9ZMW8CL0Lv02ru4PiWe6nE+V/LVswjL0JWn1q8VnXL3coC53n
 ALNB9UIbzAgvIo4Kg1K1Jc5qUxciOq0yinX+KlSh4TU2wBFQWrAEB2QPL/cFNAKkqKyOH4iV6/F
 gluga1lKZL0vozaltkIKMtB0ApWIR3l3skbGHDzvUlcNzVORRcwgog1BcZcPJOsH6vAkhJK/viQ
 M+GDtqclZhjBXnXiHu7E6iGKYnoMX8jVu49yU=
X-Received: by 2002:a05:620a:4149:b0:8ef:2118:aec5 with SMTP id
 af79cd13be357-8fabad178bdmr453941085a.20.1777569795103; 
 Thu, 30 Apr 2026 10:23:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4149:b0:8ef:2118:aec5 with SMTP id
 af79cd13be357-8fabad178bdmr453930985a.20.1777569794249; 
 Thu, 30 Apr 2026 10:23:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb3d33744sm21814685a.34.2026.04.30.10.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jon Kohler <jon@nutanix.com>, Babu Moger <babu.moger@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>
Subject: [PULL 21/58] target/i386: add new AMD EPYC models for GMET enablement
Date: Thu, 30 Apr 2026 19:21:27 +0200
Message-ID: <20260430172204.1006673-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Jon Kohler <jon@nutanix.com>

Add models to expose Guest Mode Execute Trap (GMET) support,
and add CPUID_SVM_GMET header definition so that future EPYC
models can easily add default support.

New models are:
AMD EPYC-Milan-v4
AMD EPYC-Genoa-v3
AMD EPYC-Turin-v2

Cc: Babu Moger <babu.moger@amd.com>
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Link: https://lore.kernel.org/r/20260330193428.1663253-2-jon@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  1 +
 target/i386/cpu.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0b539155c40..6401028e70d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -879,6 +879,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_SVM_AVIC            (1U << 13)
 #define CPUID_SVM_V_VMSAVE_VMLOAD (1U << 15)
 #define CPUID_SVM_VGIF            (1U << 16)
+#define CPUID_SVM_GMET            (1U << 17)
 #define CPUID_SVM_VNMI            (1U << 25)
 #define CPUID_SVM_SVME_ADDR_CHK   (1U << 28)
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9d126600c05..b19bdf99792 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6836,6 +6836,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_milan_v3_cache_info
             },
+            {
+                .version = 4,
+                .props = (PropValue[]) {
+                    { "gmet", "on" },
+                    { "model-id",
+                      "AMD EPYC-Milan-v4 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_milan_v3_cache_info
+            },
             { /* end of list */ }
         }
     },
@@ -6933,6 +6943,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_genoa_v2_cache_info
             },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "gmet", "on" },
+                    { "model-id",
+                      "AMD EPYC-Genoa-v3 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_genoa_v2_cache_info
+            },
             { /* end of list */ }
         }
     },
@@ -7163,6 +7183,20 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000022,
         .model_id = "AMD EPYC-Turin Processor",
         .cache_info = &epyc_turin_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "gmet", "on" },
+                    { "model-id",
+                      "AMD EPYC-Turin-v2 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_turin_cache_info
+            },
+            { /* end of list */ }
+        }
     },
 };
 
-- 
2.54.0


