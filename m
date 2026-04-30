Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A479FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6n-00057h-1n; Thu, 30 Apr 2026 13:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6l-00057J-6R
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6j-0004WF-BQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUhou9NDW1I2GVTlp+/CvyOKb6GcfO17vbT0ko+lZLo=;
 b=CT0xnlglcUfETJVOMo5uBXfVUOj+ePay5hjE78yu++XQo4q6DGQPS3VreL3JFQffkf9zKD
 A7F+xKswXOsXdC9LKO3TUVwhlCdCm+Two7veR7Ep93pyzrHoE95maGF2QoflttRaNbHYLF
 bEKJyWu9U59R1bYuCM2/7qoqF9zYUoA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Wtals9A-Ol25jo8qurN_YQ-1; Thu, 30 Apr 2026 13:23:22 -0400
X-MC-Unique: Wtals9A-Ol25jo8qurN_YQ-1
X-Mimecast-MFC-AGG-ID: Wtals9A-Ol25jo8qurN_YQ_1777569802
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8ee1a909037so225052285a.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569801; x=1778174601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUhou9NDW1I2GVTlp+/CvyOKb6GcfO17vbT0ko+lZLo=;
 b=ELJMswsDa6i2YZdC5LUK4kIwUuoJly5QTbWH+eB2kW/bYMyVH3a0hajR/YsCIyOAD/
 HeEokYQprScW09e6625Y2f7XYmMpGsVFf5linSVvCOTBjDk9CT6VpnKZvsEMxrlCkYgU
 dzDWd2IRNhMALcigCbiY4Lh34ERsOQH4bcu8s2pKHvXbzgVgx3X9A8O5GqwWxzFc0R4h
 l3fNxnO10/G9k/sk9p09bRke0qNsfp+B3C1bHgoaEiXKRN1vS7wtMOTwr+ar5W5t36yl
 abEfsfC/oW/7nIzOy/lzXKWm1EL32OsmdU2YK49E+aPmuFUduroMHY6jLWQNALoy3amR
 1bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569801; x=1778174601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XUhou9NDW1I2GVTlp+/CvyOKb6GcfO17vbT0ko+lZLo=;
 b=A3yK3XmKapS0hwD7el21EcjJlQ080hPvttXZHQT4VNOAlxOsSsTFg6ECYS4blMwv0x
 rLvijoBrxK+yZj+SsE1KtNFrJ3NDqivk7gNnDCWwXYsGTpzb1Ema442/8SWAEljJO2tH
 uCyafZ/8uyWcJntpTJdhT1FnzTMgJtO7sm3p3lVjNfGQgx04qYUryCNOwH8gQu++QPTw
 fJj2TbShARoSCrP3T2kFpU6UUqFLNhzQBHw/kGkPKI8iqoHp9Z68P2RqiMuoY+C5e1iH
 29nCJRxNABcNz380vs4x+yv2hznFttB2REDFPOPNhLBQBHZjnzO8swtxsdvUn+1/IcCE
 ygeA==
X-Gm-Message-State: AOJu0YzwI01p0ZKTFxgk44DKJmli2uMJvoKuTcWh2zWne/S71OxsMx9+
 QBKkcI2MkYEyEvUxRGVldlCQcLKvFGP4kLO67QPPZWpkSGh355QhwEO+jnRG6+WjWZvYVFY/z/x
 E91OkuMi+dI1SHr5fsgk4HMo8/XCihC2YUHefY1D82Kj3ujGimu8aMZafacCicEZeEVkqIMqWpf
 Wc5ykl8XcAqPRBwh4Y0Tm8XqWmZbCp1JqmyultHcZp
X-Gm-Gg: AeBDietHnb/s7NY36P0P6U1iRdftYwUvCwhgDZfIHnNLC/suKegDYZVJ3iOl2bFurKK
 NuZ3oYRTWNUSTCSNz4FsFQB8zxnkkUlD2JEAkCNLIfjha2Y54xQ88Dyidgwwm2M952eidqUAanh
 KmHb+CXA+3n1ApSKN1nXCQ4JOH73eC7B0stqqyRS5//J0Q1nKmua2uZkShmQeOEg5WGxoXKQAN1
 8DiLZ/RNT3A6cnGP/j4zIR2P0TcuNvKMZZc7+k7xrlaPsiYUTUHjb99mE85NovL0nMLME941hfJ
 vuRAYm/M7GqYpNXZsdWvgcArrtQ/e0NN5eT+YGHSc+lvuBIWoDh97GEjBrR6aZZDlFj23Hx4D2g
 EdVdFy0hOPTm3ZyJi8PgSLMicHEUFh/MXN3mbJmtXMu2LfQ4LUzJ3EQPEKuFcHw6AGNd1M4Bb87
 xeseixSjuVG4yAkreqURlEg1X7cASbQPac53A=
X-Received: by 2002:a05:620a:4454:b0:8ea:40cd:1a05 with SMTP id
 af79cd13be357-8faaf62d85fmr459136785a.1.1777569800775; 
 Thu, 30 Apr 2026 10:23:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4454:b0:8ea:40cd:1a05 with SMTP id
 af79cd13be357-8faaf62d85fmr459131585a.1.1777569800045; 
 Thu, 30 Apr 2026 10:23:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb38436e8sm31262885a.26.2026.04.30.10.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jon Kohler <jon@nutanix.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 23/58] target/i386: add new Intel models for MBEC enablement
Date: Thu, 30 Apr 2026 19:21:29 +0200
Message-ID: <20260430172204.1006673-24-pbonzini@redhat.com>
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

Add models to expose Mode Based Execute Control (MBEC) support, which
is a Skylake++ feature.

Note: Future models can use VMX_SECONDARY_EXEC_MODE_BASED_EPT_EXEC to
easily add default support.

New models are:
- Skylake-Server-v6
- Cascadelake-Server-v7
- Icelake-Server-v9
- SapphireRapids-v8
- GraniteRapids-v7
- DiamondRapids-v2
- SierraForest-v6
- ClearwaterForest-v4

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Link: https://lore.kernel.org/r/20260330193428.1663253-4-jon@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 196665d83c7..f4856c61044 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4767,6 +4767,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 }
             },
+            {
+                .version = 6,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -4912,6 +4920,13 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                   { /* end of list */ }
               },
             },
+            { .version = 7,
+              .note = "with MBEC enabled",
+              .props = (PropValue[]) {
+                  { "vmx-mbec", "on" },
+                  { /* end of list */ }
+              },
+            },
             { /* end of list */ }
         }
     },
@@ -5206,6 +5221,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 },
             },
+            {
+                .version = 9,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -5392,6 +5415,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 8,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -5582,6 +5613,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 7,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
@@ -5776,6 +5815,18 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (DiamondRapids)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ },
+                }
+            },
+            { /* end of list */ },
+        },
     },
     {
         .name = "SierraForest",
@@ -5947,6 +5998,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 6,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
@@ -6103,6 +6162,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 4,
+                .note = "with MBEC enabled",
+                .props = (PropValue[]) {
+                    { "vmx-mbec", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.54.0


