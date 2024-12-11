Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09CFE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZi-0006ne-3v; Wed, 11 Dec 2024 11:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZe-0006Sm-GB
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZc-0000VZ-DN
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AKGN8P0xKhBw5wMP9OuFuNHXzgVRM0o+GLlWIKcB6dY=;
 b=OnWrdSRY1HadeBNEz9EModaKYoIaI/C6t9LteXaLUVkxE2OFyLx2v2gIKteckA7xPoDj4G
 K3P/K0yiaMcIDgRpysNP8s+pa5kONMKtvOQ1S0sKHaqYZbVT9YH6FPISAbF/1vZJHGBbuW
 vp8PVQJmLBeSG8o9t3+pKieNzk7r9AE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-P9zUwrZ9Nim2rMQFzzEb3Q-1; Wed, 11 Dec 2024 11:28:26 -0500
X-MC-Unique: P9zUwrZ9Nim2rMQFzzEb3Q-1
X-Mimecast-MFC-AGG-ID: P9zUwrZ9Nim2rMQFzzEb3Q
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434fe2b605eso19157105e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934504; x=1734539304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKGN8P0xKhBw5wMP9OuFuNHXzgVRM0o+GLlWIKcB6dY=;
 b=A6g2gLKag1w+3rWHoB112g7AdZk6VcXGDckBQNuDjGMPJCBGAPjMUA2fJwmFL1y4X4
 9lmrfuTnxiVggmM0xtIn9cD2cxHDuK2cqPAGBlUqFJBLelK5udm7K57jgj/hHY3RwBl0
 8aQd+wo6dA7VKjr8Z/34fM6IQVVDadfK8vKI8q78sdwKTjRDDEX+EgZzcu+CWOcmq7pN
 wGM5BUQsiWetLqMd+d+yqHPJgMRTG2N2lPLZtKkReXNTPqGmcrMUBOZu7dyJoKx6AhFi
 iz5Mkt1bRrdfvw8ziP5rId2jXpy5J+oHAsW1yrjfGk7tv2RB3lsbfKTfxIme5nlHNiaf
 qDaQ==
X-Gm-Message-State: AOJu0Yz5s7fkWCKSKonmrHDSJ4uBSr/3WSXNSidBn71QPjOXmLAO3JF7
 BNxu0hvkMAaQd6Yy5AyywAYxtFKGZQ44G5OHsu2FSeH4HhD5uG1Y52YT99JFc7SHNedYdmWQU5c
 mF09625jPpVG5TUF8FGnLGNN9S8kpyh4Voqkuvpj/QbMxsNLWb4gHHqKT0NiMyx5dlE3OtN7CK/
 9itoxn806KHr4ge2518ux9npxWOTyQyJFTJJ6L
X-Gm-Gg: ASbGncsz/4YSHhGc7f2AB3NUDaNyWFKoTf/nkgwn+8uQJRyoM8poGkZ/QYwjzSeeFgT
 35ljyG0P7JSQ1qC/GiPmsJXMenjR2k89o62nJCfR6xpBSjuTtNB/5pFMAJDows5mx0QHrb2B8Mu
 cuKDpkEYXEkqPzBl+3dOS9AJw6We4ICltejcNPbMkTNNIgAoiZFd1nAwEyGB+R3zC2ANIvHZb/V
 K4+EbNmYxXZyCjWshVfZH6+E5FrDremeaPLzQbQy4UYqMr/crDhzIp4
X-Received: by 2002:a05:600c:3b09:b0:434:f270:a4f0 with SMTP id
 5b1f17b1804b1-4361c3efb35mr25852715e9.21.1733934504041; 
 Wed, 11 Dec 2024 08:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUSxvfoEJgwGuv46l93KDkV4GhoUDw3tLQs9G1k+kppYAoU5CP1zeypmAvQD6/5k88W2+oBQ==
X-Received: by 2002:a05:600c:3b09:b0:434:f270:a4f0 with SMTP id
 5b1f17b1804b1-4361c3efb35mr25852515e9.21.1733934503558; 
 Wed, 11 Dec 2024 08:28:23 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f981880csm109473675e9.44.2024.12.11.08.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 26/49] hw/usb: Replace type_register() with
 type_register_static()
Date: Wed, 11 Dec 2024 17:26:56 +0100
Message-ID: <20241211162720.320070-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
Link: https://lore.kernel.org/r/20241029085934.2799066-9-zhao1.liu@intel.com
---
 hw/usb/hcd-ehci-pci.c | 2 +-
 hw/usb/hcd-uhci.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index c94fc9f6c58..dd06451e234 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -228,7 +228,7 @@ static void ehci_pci_register_types(void)
     for (i = 0; i < ARRAY_SIZE(ehci_pci_info); i++) {
         ehci_type_info.name = ehci_pci_info[i].name;
         ehci_type_info.class_data = ehci_pci_info + i;
-        type_register(&ehci_type_info);
+        type_register_static(&ehci_type_info);
     }
 }
 
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 3d0339af7b9..65c1f93cc9f 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1362,7 +1362,7 @@ static void uhci_register_types(void)
     for (i = 0; i < ARRAY_SIZE(uhci_info); i++) {
         uhci_type_info.name = uhci_info[i].name;
         uhci_type_info.class_data = uhci_info + i;
-        type_register(&uhci_type_info);
+        type_register_static(&uhci_type_info);
     }
 }
 
-- 
2.47.1


