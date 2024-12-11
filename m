Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98CFE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZn-0007gu-B3; Wed, 11 Dec 2024 11:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZk-0007Cw-8L
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZi-0000Ye-En
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WrsJM87R06FYnwZjzIbMSBqBQmSHO+IxGseQvEJVyVw=;
 b=C0PBu4B6++SK30nKE1t9BEJxqaVSXgrTwJZJAEHebUYA+1cdWcE0xFpeqiqoLp05h3lfCn
 vs8o6/6GvsOwZbQ7JGikndvhtnW97l5n9J2L4iYMidr7AyLKtYT2g8os4eUO+TJMT2yABv
 sQWi7WVcb8KuX2+hwcS2RQmU3BdIWOM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-7lPIx1_GMQ6Rt5kQYvQrQg-1; Wed, 11 Dec 2024 11:28:30 -0500
X-MC-Unique: 7lPIx1_GMQ6Rt5kQYvQrQg-1
X-Mimecast-MFC-AGG-ID: 7lPIx1_GMQ6Rt5kQYvQrQg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361efc9d1fso7265465e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934509; x=1734539309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WrsJM87R06FYnwZjzIbMSBqBQmSHO+IxGseQvEJVyVw=;
 b=vqx1A/FQbz5/0Yw40PFO+ycOsdNnpa276qbJ5QucEKCQgUQ1gTImaVjzf17Zv6nDJ8
 L3GJW8yl8fhqVDyrOtcEVMMcQ7+MHMOceocOuXlpq3LRz1+YyU580ec0z8FJ+QjGoczK
 95uLxGm0Cs9M9+lvkQInbcfMPajOv7sIGZF8+kH7iY0L9gJvbiulhXatlvl2Qb/oAkNP
 LtjY9+rSP8Zu2/gbHXzX90/4i2B8lk1lFCF/9l+JMoMcX3tsz5vgtomXFfIT9B4CA7RA
 L0vjp3FpBNhs986aIPaTQjEp24giNnfG6l8qNxNF6hP+ovliSvt8FhgPCr4R+xOzPczg
 XLlw==
X-Gm-Message-State: AOJu0Yy+yN3tq7m7cn1E9S+cSUXuqhzwSQcBV/mRgUJFcCSqS+kh06zG
 z/a49Scwyo9o2KYlkmovEcSApOF1HAMhJ/bU8VJo78pJqZ1SqvMI0DRnVBgjHqWjIa/JoZH00zR
 XHF/D2IC3q/JOA7CV8EzOPqatThRmAcaOl3m+a98OScLq54PXE1W014gIvDqrOT07z6zWKFuk9x
 a+XvbcZ0H9ZePhXZ5pxnhAKgczGWLY14VJBbGc
X-Gm-Gg: ASbGncvK9re+UdC1MxTFfJlKDbTtm6EROjTrpzfcdm6g2akrhPoHZ7XOc9i3qWFCHeG
 nFd9UVDJbAeaMpbONPmUD7cGJFQ14xuelW6Bcu2wyG8Fe9M5MUNtBoX5IZFmlTw0XkIDU+PGvFt
 oA0F1sW44NpZSKOFiXz6fXS/ZuI1Fe8UV/m3EwXpHYoDl7mT9sMK9f9nvJRWvk+7AUs6FPfmtLb
 uqoR5kXB0xzbgI3wqIwIEWVu4XQYSHILR32oRyYklf3JjTt0xAog2Uq
X-Received: by 2002:a05:600c:468b:b0:434:fd15:3ac9 with SMTP id
 5b1f17b1804b1-4361c3e3aacmr23834785e9.22.1733934507502; 
 Wed, 11 Dec 2024 08:28:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhPFTwdeba7jDc9vZLxIlDGfiUx7pVjXqtyQxGyTljL3q6+8WaUCOz3XKXnm555ya5GD8PFQ==
X-Received: by 2002:a05:600c:468b:b0:434:fd15:3ac9 with SMTP id
 5b1f17b1804b1-4361c3e3aacmr23834165e9.22.1733934505598; 
 Wed, 11 Dec 2024 08:28:25 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251dc77sm1589469f8f.100.2024.12.11.08.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 27/49] hw/virtio: Replace type_register() with
 type_register_static()
Date: Wed, 11 Dec 2024 17:26:57 +0100
Message-ID: <20241211162720.320070-28-pbonzini@redhat.com>
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
Link: https://lore.kernel.org/r/20241029085934.2799066-10-zhao1.liu@intel.com
---
 hw/virtio/virtio-pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5a394821da9..5c6c2019cef 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2511,9 +2511,9 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         base_type_info.class_data = (void *)t;
     }
 
-    type_register(&base_type_info);
+    type_register_static(&base_type_info);
     if (generic_type_info.name) {
-        type_register(&generic_type_info);
+        type_register_static(&generic_type_info);
     }
 
     if (t->non_transitional_name) {
@@ -2527,7 +2527,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
                 { }
             },
         };
-        type_register(&non_transitional_type_info);
+        type_register_static(&non_transitional_type_info);
     }
 
     if (t->transitional_name) {
@@ -2544,7 +2544,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
                 { }
             },
         };
-        type_register(&transitional_type_info);
+        type_register_static(&transitional_type_info);
     }
     g_free(base_name);
 }
-- 
2.47.1


