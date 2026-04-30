Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9E4CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6i-00056t-VQ; Thu, 30 Apr 2026 13:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6h-00056E-7t
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6f-0004Vl-Id
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfkdwlFj2YA+Zv6GpIGsjW3a53Cm6pY/xczWrPNM46M=;
 b=C4qR7MrHikzG1G4Zvv7bSS8RyvltuAYXPH+UROLHKGrQ+slY67XEIPXtw0g6NL16EEpopZ
 HxQozrzHdgw2oz2vgQ7n7Dqz++l/3MytjCMO+V5u+vatRZVzmZt1yiYRrdUPp8xU4pXHIu
 +m1wHqI+G7boEW1CGbYuZjXnGO6mMSw=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-Kz5IHlrXNzOR3ERcFZhnFA-1; Thu, 30 Apr 2026 13:23:19 -0400
X-MC-Unique: Kz5IHlrXNzOR3ERcFZhnFA-1
X-Mimecast-MFC-AGG-ID: Kz5IHlrXNzOR3ERcFZhnFA_1777569799
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6059d4c73d5so785560137.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569798; x=1778174598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfkdwlFj2YA+Zv6GpIGsjW3a53Cm6pY/xczWrPNM46M=;
 b=iZoSKlk5sNf1McpzPm3XOTpTWY2QyIvjEzXsOaTnynfKZEkwylAJor1iq/1hetEsWP
 169cfvegVbKctp+SMiai+sxPf9ipalFP0RYtVNN23Ss3jG5MEx82FRpsblMerUDMR7q6
 kjugF3wV3bqTmGxxw+F+f/wIKbeRmh3SGKKbmY+tVI6B0zsKbrtCztPuC744x7vIOYR0
 BkFTBKPlEuSQIknYc1i6P5cLHXTF0yRr0hyAuYII7XsSGA5UjtDQUXWcQZyRsEDlz0lh
 TKGA2HJyb0otHFEqpJ9CGcziGrm2AJThptmn9Xif+8A+QWr1uR8XJKD1PqZC0LDNgcNA
 gnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569798; x=1778174598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sfkdwlFj2YA+Zv6GpIGsjW3a53Cm6pY/xczWrPNM46M=;
 b=dKiikKBzPIOUzrEcH8Pki7FDeXaztvj/Mq7IATk8X+3xvOR6n9Kz4HDd/Tp4eAXw6+
 AlonL6KpBZwjBjK/5+KKr6SIDhyaxM1FhpDjxv9hjR6pl247jPgnB5jpsqtWG/ZKmsOs
 PTxX6pBqGAFt1M7BstnTeNyn6r84KKb3fGXY7vSqS/JQKn2xAWM0pRKZ13gmfw50VNiq
 iX86tdFtKM4GawAqDkASIL5EAPB4vzUjM/AiUAu2FFVGZB2NCcUI1l2dnjc9O9qGkd1N
 lAjU0DaSZ8d6LTgKhkrXXsKR3ASY6I6BHOp15Rxn8K60XbS7t2RhmjUgKzSlaLMnTsH4
 2P9w==
X-Gm-Message-State: AOJu0YwbSYfVeqlWaP7BybVnocce8TeGjh4dwEMP2+IPwI1RUNnqGNlu
 PRxrcjsQt0JDwhGI++KPkO7dBEBbNAF2c855vpaViyuwaZsx1fxIR3ivLZnuMbTODhTZuw3YJzJ
 CkKY4+dlqjGHBM3jmrsWzzaXnnhMBEutqxFDSiORp/jukjLGxwYnX9VU1r10X+b2MBVvVjcUng9
 IluW7A8DUsSrQmDPWehlzQt9EF2uGJZk3DcTtHI/fq
X-Gm-Gg: AeBDiev/uo6YxRggNJmeFUdWZ2D9Zz1/Dt2PvAxTXgudP+uHcX/FtiRqo9T/lDW8UWW
 x1gp1f0NeChA+MEjumtgDefXW0wigMIw71kBaavIhGAC6XK0haUOysKRJfgF1yRXfsjgwyGwbES
 MTVj0DcdWYa+gmEfmC+sudLeM1iRHkCQbIlftRV0QG0KYUVk0H+RN20T/wYs6WSGvQr64CAj+K1
 gUeDl7Bt7BfYL3xdkqpp54KDgmdIkFqyTMfAI0xThSOKH2+n+zuYkcroDW/fo7B7OyAzXXm6SLW
 1tcetJSv8Oc7X8qYMadk9RDlFEMNbnRLz+rLYiVs3QqKCEgEKg2l+f9hkF6LaN/yg5i2lykP7xh
 dtPvVoNQgBNe/0UMLkoHYCVrXAy53+FhAs3eMv/XJ6QrfRxHjH1Zg3Ssygpfv9Pzlhy8IZ4AolU
 hTOmQURdJ/nDP4eWExrZ5FiojXxTJkGPoHxgI=
X-Received: by 2002:a05:6102:4415:b0:61d:8fd9:fb26 with SMTP id
 ada2fe7eead31-62ad1e41270mr2245110137.7.1777569797933; 
 Thu, 30 Apr 2026 10:23:17 -0700 (PDT)
X-Received: by 2002:a05:6102:4415:b0:61d:8fd9:fb26 with SMTP id
 ada2fe7eead31-62ad1e41270mr2245020137.7.1777569797329; 
 Thu, 30 Apr 2026 10:23:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff459caasm22560376d6.36.2026.04.30.10.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jon Kohler <jon@nutanix.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 22/58] target/i386: add new Intel models for MMIO/GDS/RFDS
 mitigation status
Date: Thu, 30 Apr 2026 19:21:28 +0200
Message-ID: <20260430172204.1006673-23-pbonzini@redhat.com>
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

Add new bits to ARCH_CAPABILITIES MSR to enumerate the status of the
MMIO/GDS/RFDS mitigations on Cascade Lake, Ice Lake, Sapphire Rapids,
and Granite Rapids processors.

These have been advertised in Intel microcode updates for a while now,
but require user space to opt in to advertise them to guests.

New models are:
- Cascadelake-Server-v6
- Icelake-Server-v8
- SapphireRapids-v7 (note, already got MMIO fixes on commit [1])
- GraniteRapids-v6

[1] 3baf7ae63505 ("target/i386: Add few security fix bits in
                   ARCH_CAPABILITIES into SapphireRapids CPU model")

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Link: https://lore.kernel.org/r/20260330193428.1663253-3-jon@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b19bdf99792..196665d83c7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4901,6 +4901,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                   { /* end of list */ }
               },
             },
+            { .version = 6,
+              .note = "with MMIO/GDS/RFDS mitigation status",
+              .props = (PropValue[]) {
+                  { "fb-clear", "on" },
+                  { "gds-no", "on" },
+                  { "psdp-no", "on" },
+                  { "rfds-no", "on" },
+                  { "sbdr-ssdp-no", "on" },
+                  { /* end of list */ }
+              },
+            },
             { /* end of list */ }
         }
     },
@@ -5183,6 +5194,18 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 },
             },
+            {
+                .version = 8,
+                .note = "with MMIO/GDS/RFDS mitigation status",
+                .props = (PropValue[]) {
+                    { "fb-clear", "on" },
+                    { "gds-no", "on" },
+                    { "psdp-no", "on" },
+                    { "rfds-no", "on" },
+                    { "sbdr-ssdp-no", "on" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
@@ -5360,6 +5383,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 7,
+                .note = "with GDS and RFDS mitigation status",
+                .props = (PropValue[]) {
+                    { "gds-no", "on" },
+                    { "rfds-no", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -5541,6 +5573,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 6,
+                .note = "with GDS and RFDS mitigation status",
+                .props = (PropValue[]) {
+                    { "gds-no", "on" },
+                    { "rfds-no", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.54.0


