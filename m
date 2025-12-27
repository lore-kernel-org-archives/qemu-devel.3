Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD04E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuo-0002dB-Th; Sat, 27 Dec 2025 04:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQum-0002Tv-0G
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuj-0006vX-Rp
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvCNkrkwm5oju3Qltr+xjIhdiJ/CblJ6mMW0QdxQLnc=;
 b=Lm2YdwtwGSAVkX9GLaiyVzNor8zOmbHo//1IX2useh8bMbuCabdL209Syqpp4s4C3NGlJh
 Fg5a8x1Kr++cfCjnfL3CGjy6fPxOnPT263cVf7wAh3Tn/nAUvCuv3cpZLnIGq1JfCTiPn+
 fmXYiXPjYUyEweuonRbyXMxQaSfB8w4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-8LQ_bHqDP1uUBHqQ5CGS2A-1; Sat, 27 Dec 2025 04:48:42 -0500
X-MC-Unique: 8LQ_bHqDP1uUBHqQ5CGS2A-1
X-Mimecast-MFC-AGG-ID: 8LQ_bHqDP1uUBHqQ5CGS2A_1766828921
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47a97b785bdso55687765e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828920; x=1767433720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvCNkrkwm5oju3Qltr+xjIhdiJ/CblJ6mMW0QdxQLnc=;
 b=lG6Cr/GcA1P17KM0mJk6W2EpDG0vWI6VfdXNn3zogzCeGxZmt5Qy1JX8dfItZq1Wvy
 hLyKG5GXPi4oHG4fl5WipUrWQrGtTeqKi7HyDM6ZTvBMFquW9pipKMhf8jjDMKzhpvs2
 ih9rXKO6Y7+DqA9/HQwzRfFVJDkhcbU6DpQR9IucuAl0uiBXLPm0Q0Koa4EjWu7rpgv0
 oaErwPW5X0+sXYwvspBdJWfs2CEby5rz1cqNKuiOfr3dv7FL6f8aM+AHQjE6jeeSksIX
 Qnw9Xg7MtJ8T7aNcPtQ+jTh1OCU0sseEJkP0uqOiGMIgWhc2jadbRvlnhBcOQ1ampgu3
 /xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828920; x=1767433720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HvCNkrkwm5oju3Qltr+xjIhdiJ/CblJ6mMW0QdxQLnc=;
 b=vAedPtntfRmXs1POp44lQ2EE72Q7i4q0cz/MByuKoA2piG0k3lg5BFw7A9eTfJ9Nn6
 9KprMWlDju6vx+TCfLUEcpJmLmis+b99Pdp7iVDaRuejiyOusRp178xjvYDtxgcNcREB
 9fAfpdJB23mHYbFB3Pm9yuNiNTibE/1532xmee4HWlAYZ6ab/RO43cvLtBUa8XWXQPt8
 FwLkovicWmZBdBlMFxyeLsXOD+JFbq6qwVxYvmuE/NAvRv01G9R24rnHtLUifGyr7DtR
 19I2XD1qGuvzl1QMjNLCVl3cxCw7N440HN6ILWQktT0/Q4h3JiSBQ9jEoPrcIiJ59LFD
 SSDw==
X-Gm-Message-State: AOJu0YzXjAc3zDG5ekz6GNevUsX4bfuHTGjPZzMvajMWKF/4is6z6WSk
 BAokcx/UAKjagrGA52VF6WsmcCxL9ISkQ3x1efmMKZ7WZ390Qa9eZCg1rUidp0Uha0OrxipX1z7
 YFb5maSBP4b5nsnADMA8Umk4pYT/D28graYUAh/VCDH7yYr/jNtl4ylGVuu3wTO8rM3GydqpchU
 sSamhVa27UbrIaIAv1b1A/qL7uDSkisUNgLAbk0O80
X-Gm-Gg: AY/fxX57AIgj5D0x4MGZ3hsj4y7mtRXM7b+QO8lvCOdQ/MBvzQkJCHRJ8RhVzbcTHhr
 2UC0DdB8Q/J5JiJ7NlXgTVkCAfmIi2eSyOUxH92XVJ/8WgQW+Ti7UsF5vPFS7m0tOfLSGSCX51o
 DWjuZKUROcfoAyeQ372xd7C5ZP8CavRKrf0xDpdLH8MDIIE1vtC+6um2WeOoOKYMByJcwVe0Z6H
 RA7qSbXKnuYNgZZTyPsa32wp3rgdIGlaMFlF2RuBzClo6ixpvZBRvjiajhuCQB5wsmXUbHp7fhE
 ApgYXYm33IafkMqvCtDY8emnzTPUszKa2bQn0LOcixZGonRsxaTyM6qut2iNeQE7zGnt20dREZb
 g72YjCyZUhWpelrkRdfQ3RwcOaVMQLVM4Mcs3q17OJhVYQp5LHrOKhi/tfe3HMeVLaIXKUCDFtb
 lOyqSRbLFlujYmCyU=
X-Received: by 2002:a05:600c:1d0b:b0:477:b0b9:312a with SMTP id
 5b1f17b1804b1-47d195498a2mr244369575e9.7.1766828920639; 
 Sat, 27 Dec 2025 01:48:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiy9XXrlexPv0yEZDohqAIwqWya6Hzo3VP8GdFEI5r0AyZCjKAk3AvMsBP6ZK2+Sc391nn5w==
X-Received: by 2002:a05:600c:1d0b:b0:477:b0b9:312a with SMTP id
 5b1f17b1804b1-47d195498a2mr244369455e9.7.1766828920267; 
 Sat, 27 Dec 2025 01:48:40 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830f3sm48756233f8f.22.2025.12.27.01.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 092/153] i386/cpu: Enable cet-ss & cet-ibt for supported CPU
 models
Date: Sat, 27 Dec 2025 10:46:57 +0100
Message-ID: <20251227094759.35658-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add new versioned CPU models for Sapphire Rapids, Sierra Forest, Granite
Rapids and Clearwater Forest, to enable shadow stack and indirect branch
tracking.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-21-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4e0c5cf9997..a9f38f4020f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5166,6 +5166,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 5,
+                .note = "with cet-ss and cet-ibt",
+                .props = (PropValue[]) {
+                    { "cet-ss", "on" },
+                    { "cet-ibt", "on" },
+                    { "vmx-exit-save-cet", "on" },
+                    { "vmx-entry-load-cet", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -5328,6 +5339,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 4,
+                .note = "with cet-ss and cet-ibt",
+                .props = (PropValue[]) {
+                    { "cet-ss", "on" },
+                    { "cet-ibt", "on" },
+                    { "vmx-exit-save-cet", "on" },
+                    { "vmx-entry-load-cet", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
@@ -5482,6 +5504,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 4,
+                .note = "with cet-ss and cet-ibt",
+                .props = (PropValue[]) {
+                    { "cet-ss", "on" },
+                    { "cet-ibt", "on" },
+                    { "vmx-exit-save-cet", "on" },
+                    { "vmx-entry-load-cet", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
@@ -5617,6 +5650,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (ClearwaterForest)",
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
+            {
+                .version = 2,
+                .note = "with cet-ss and cet-ibt",
+                .props = (PropValue[]) {
+                    { "cet-ss", "on" },
+                    { "cet-ibt", "on" },
+                    { "vmx-exit-save-cet", "on" },
+                    { "vmx-entry-load-cet", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.52.0


