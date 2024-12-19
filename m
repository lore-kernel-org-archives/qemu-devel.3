Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C155CE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBy0-0004YW-3K; Thu, 19 Dec 2024 03:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxx-0004Y5-RW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxw-000585-A1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lszIW+6n3q7LxjSiG56S8Pvl926aYIlcMEY05VSrnOQ=;
 b=Eq/YHqKfjdVC7kBB5+ivQHdVXIoYOiJ0hhUs1ePrbs2fJx42kW8rtc9JalAmzxK2/hfhLU
 4vKeOSnmZoDxWKaNh/YCIAnyWuhuLaG0qvLZcoGj2qAQsg19imU4Y63+64Knx2MyRhIlbR
 TmtWfW8vjkUKAcRiVIbhzhLffYq8/Vk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-tc8wQJvvNe6K0nXTpI19YQ-1; Thu, 19 Dec 2024 03:33:01 -0500
X-MC-Unique: tc8wQJvvNe6K0nXTpI19YQ-1
X-Mimecast-MFC-AGG-ID: tc8wQJvvNe6K0nXTpI19YQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43610eba55bso4157925e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597180; x=1735201980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lszIW+6n3q7LxjSiG56S8Pvl926aYIlcMEY05VSrnOQ=;
 b=Aj6w1tisUt0eL4Za8s2qBlAlHSaLkSwRs0vBhBf1ptdzHaujhJM6SbswpEUmqYI70B
 T71sOx/LOvjZiaeRD8TDmMakbRKmEQt9W0nNhHLspODbDLiSOF77sgxjxBtn+VwoE0bP
 x4i1Hb+Dijt/qUliDl1LiUcsj20SiuVoyxYbRIfw7BpvF+WmlAR3wxe5oOXrlKl4MQaz
 vh8zDc+tonrVPyCvJE82xGGzCNxn5Cdofb7qEiMeJ+bAXFOGg0KYK1UmoWMeT2p/TrsW
 EMs8u1eS4NUEOc35LkAKUYjziw31sYu9S0Ng2lZ68OBHdEv8IDWl/MWguLK64fAuLk43
 tyuA==
X-Gm-Message-State: AOJu0YwIy+J/pXa2EjPcRzNVsZoElP2Ir0A53MTW21EST3PPrymRzyNl
 u83aPiyMkJyglSw79re9ckPivBsS9Zqd0lu7m8pBhHurry1JvwyhbozKDE4gk9L3OW3kWWPqviL
 6mx9iAIzuEw0tdGEgz0XV4+c7fHt87fk5Jn7nLS5KOckyT5znmEdcgFSGkgY6q8ZyC3fuejhT/D
 Da/M72CJzK1VIThwZiGbGzlcBWYbleJYHBIXQq
X-Gm-Gg: ASbGnct36GuLhAPa2lBRnTOLAsva6w482uxgYh+huyIGLmDtrspJk25hR8ehVnH5nUs
 UjQH2e284rSoFAw+8iFS8AeRD+y1nSOyWV/47ka9sBDmIlVdZq6P3LsgU6wBTy1UmbycnGlrtc/
 fU2ALFScsXVzABHLn9bek3w7wNmOu1d0a2D8ov9nLX9e3RMh48LtoRf1FWmPbZ6EPy6puy4LuB3
 Ytugt92uuILDMKtTO8/hPL8EFiQumbNlcMzrntKcflwl63I0p6O4XJfM7hI
X-Received: by 2002:a05:600c:35cb:b0:436:18e5:6917 with SMTP id
 5b1f17b1804b1-436550ae455mr63097015e9.0.1734597180116; 
 Thu, 19 Dec 2024 00:33:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsRG1DbeOh9+AUSz+1fbD9kFpxeX2SDBruG+NR7c1YUJIvmIwJzvu2T9LyjwhiUeF83SXlrw==
X-Received: by 2002:a05:600c:35cb:b0:436:18e5:6917 with SMTP id
 5b1f17b1804b1-436550ae455mr63096555e9.0.1734597179574; 
 Thu, 19 Dec 2024 00:32:59 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661289a18sm11005085e9.37.2024.12.19.00.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/41] hw/scsi/megasas: Use device_class_set_props_n
Date: Thu, 19 Dec 2024 09:32:02 +0100
Message-ID: <20241219083228.363430-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Richard Henderson <richard.henderson@linaro.org>

We must remove DEFINE_PROP_END_OF_LIST so the count is correct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-16-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 8323cd18e3a..7f012c218b4 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2459,7 +2459,6 @@ static const Property megasas_properties_gen1[] = {
     DEFINE_PROP_ON_OFF_AUTO("msix", MegasasState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT("use_jbod", MegasasState, flags,
                     MEGASAS_FLAG_USE_JBOD, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const Property megasas_properties_gen2[] = {
@@ -2473,7 +2472,6 @@ static const Property megasas_properties_gen2[] = {
     DEFINE_PROP_ON_OFF_AUTO("msix", MegasasState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT("use_jbod", MegasasState, flags,
                     MEGASAS_FLAG_USE_JBOD, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 typedef struct MegasasInfo {
@@ -2488,6 +2486,7 @@ typedef struct MegasasInfo {
     int osts;
     const VMStateDescription *vmsd;
     const Property *props;
+    size_t props_count;
     InterfaceInfo *interfaces;
 } MegasasInfo;
 
@@ -2504,6 +2503,7 @@ static struct MegasasInfo megasas_devices[] = {
         .osts = MFI_1078_RM | 1,
         .vmsd = &vmstate_megasas_gen1,
         .props = megasas_properties_gen1,
+        .props_count = ARRAY_SIZE(megasas_properties_gen1),
         .interfaces = (InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
@@ -2520,6 +2520,7 @@ static struct MegasasInfo megasas_devices[] = {
         .osts = MFI_GEN2_RM,
         .vmsd = &vmstate_megasas_gen2,
         .props = megasas_properties_gen2,
+        .props_count = ARRAY_SIZE(megasas_properties_gen2),
         .interfaces = (InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { }
@@ -2546,7 +2547,7 @@ static void megasas_class_init(ObjectClass *oc, void *data)
     e->osts = info->osts;
     e->product_name = info->product_name;
     e->product_version = info->product_version;
-    device_class_set_props(dc, info->props);
+    device_class_set_props_n(dc, info->props, info->props_count);
     device_class_set_legacy_reset(dc, megasas_scsi_reset);
     dc->vmsd = info->vmsd;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-- 
2.47.1


