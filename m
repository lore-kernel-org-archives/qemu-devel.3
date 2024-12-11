Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1658E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZY-0005Zq-IL; Wed, 11 Dec 2024 11:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZP-0004D9-Mv
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZN-0000Qu-Ts
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U53bRzTunzKKb0GQrA7zkMI5MCQHR4iyv2n5IEYAQ8U=;
 b=KvbBQkpfcJNYHjl9Fgs4GaOZ/voTHfsWmVeq7oTRwMVzomHw6yVBXW+TYZP4o/LGKEBpj2
 8w3sqXvKPiQcT/QqM9WdmW8zlea3JL8SZL5n/qqO7eVmZTaqQWQnXhCzsxeJJu2WEW2qIO
 wS0k2+5eUfDOgdeIuzbBh2byOqn86uU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-4GLVIrnUPOGVMh0x2jpF2g-1; Wed, 11 Dec 2024 11:28:11 -0500
X-MC-Unique: 4GLVIrnUPOGVMh0x2jpF2g-1
X-Mimecast-MFC-AGG-ID: 4GLVIrnUPOGVMh0x2jpF2g
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5d3d6d924c1so5811827a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934490; x=1734539290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U53bRzTunzKKb0GQrA7zkMI5MCQHR4iyv2n5IEYAQ8U=;
 b=h1j/kIRbJb7ZXOGdUKhFibyeUiv7mBb0w3rSDMAlb7VRsfpl0FuMSUOcdBZ5SGgRIl
 1/cQXYUDCh/XH5xQxHjg46GNCfHdnMFttLbhajnSdCtUmhFU1Hv0pEjWUQeBSTGj31eO
 c6hNYH06Pba70KGaizVtUkRwNJh0TDGDYEVsiG6rFTgxxqJA0DGOZv577mXSeJncUiJ6
 vlQpA3GxJNosGDN6Wa5YnziQyzt4cEBnBfxnr/VP65JW3Yts8Q9tucvHLyxanzqLF6eA
 wQQF0uz9qKIMy2jhxWoZR4GaFfMlyCz/0ujBsd2BzYWX6O1Sn0F9bVHEM37SlFSNTMav
 xlAQ==
X-Gm-Message-State: AOJu0YxoTmWkNu1iiOTCX7Ap5R1rEydnd6zJXuQm3u5PNo4dlD7ouN7g
 Oi3Js8UNrouBSUBfqtAYfnL07t42hXLHg8TN5YbMQjeZpXyev7xOZCTXrRj5k6nRNleZf+J6ijX
 sgPCR20lJfSl6Bs1vV5mYn6WHbsFvTya/zGwKxj6jmx1If08/0/EdnJYYJgzUEV7BO1u8q1cXmX
 8DNPPswJwbiHymQGaC4yM2hXdQvk/xrFN9FhUj
X-Gm-Gg: ASbGncvPKdpqqNts8hdXnKkUK85oHqH5Q+6NdU2onEggocjWM6uFQQrTIxqAefvw3Ju
 Yun7nwT0x8DvA4NmBHPK8ZjgOEM1bvO0y1JZ3/SNktlfzph9rJxY2jM2OSMG4koaAzljc4UvoL8
 F0Zj/09eZf7aUBVgFCdI6JMXMdYDBj+Oqvwm6P9INOams04AFlEN4ozU6rPWJIGiYlxtz9nCRVI
 AhHkDrq0Gn+fUDDi4NOCPQVrLldX+bmoSBjNBCHvcM4uTCY/HzC09TO
X-Received: by 2002:a05:6402:348b:b0:5d1:2440:9b05 with SMTP id
 4fb4d7f45d1cf-5d43316e59fmr3937133a12.28.1733934490041; 
 Wed, 11 Dec 2024 08:28:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbDS98Odgfq44TgA7/FFlWXLa9928Q9PM0QDMwSD0nOM+fL4YHTH8H0uB04014eCD3gdXT1g==
X-Received: by 2002:a05:6402:348b:b0:5d1:2440:9b05 with SMTP id
 4fb4d7f45d1cf-5d43316e59fmr3937103a12.28.1733934489588; 
 Wed, 11 Dec 2024 08:28:09 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3f3cf8c6esm5314127a12.85.2024.12.11.08.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 19/49] arm: Replace type_register() with type_register_static()
Date: Wed, 11 Dec 2024 17:26:49 +0100
Message-ID: <20241211162720.320070-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-2-zhao1.liu@intel.com
---
 hw/arm/armsse.c    | 2 +-
 hw/arm/smmuv3.c    | 4 ++--
 target/arm/cpu.c   | 2 +-
 target/arm/cpu64.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 255346a595a..58ed504b2bc 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1731,7 +1731,7 @@ static void armsse_register_types(void)
             .class_init = armsse_class_init,
             .class_data = (void *)&armsse_variants[i],
         };
-        type_register(&ti);
+        type_register_static(&ti);
     }
 }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4c49b5a885f..6e847e8773d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2065,8 +2065,8 @@ static const TypeInfo smmuv3_iommu_memory_region_info = {
 
 static void smmuv3_register_types(void)
 {
-    type_register(&smmuv3_type_info);
-    type_register(&smmuv3_iommu_memory_region_info);
+    type_register_static(&smmuv3_type_info);
+    type_register_static(&smmuv3_iommu_memory_region_info);
 }
 
 type_init(smmuv3_register_types)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6938161b954..17519b5e468 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2755,7 +2755,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
-    type_register(&type_info);
+    type_register_static(&type_info);
     g_free((void *)type_info.name);
 }
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 458d1cee012..c1cac912a08 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -841,7 +841,7 @@ void aarch64_cpu_register(const ARMCPUInfo *info)
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
-    type_register(&type_info);
+    type_register_static(&type_info);
     g_free((void *)type_info.name);
 }
 
-- 
2.47.1


