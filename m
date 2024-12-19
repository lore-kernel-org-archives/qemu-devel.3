Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0A1E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxn-0004U7-9c; Thu, 19 Dec 2024 03:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxm-0004Tg-FE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxk-00056T-4Z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdTS6Bb8vn16TywEE3D3gC5PFxCWwUIxmBPDQfeiLAs=;
 b=X6RCFEl1wq02NWeEEawlYXSGhYHo20/YdU2oSk7/RMf8vr7w0wg46YAlfhNBVZX/tWJNsI
 dXuNDj1QAmCRqHfaGAqZnJ4N0URVlBMS4Wa/ItPiHOmh3BOS48D6waBZ7SE83J1pFI8ggV
 obWwQ7onYOztX/JJ3tYR7rpXm+wN+ig=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-gEpHzY7PMK6J0qNlv_shJg-1; Thu, 19 Dec 2024 03:32:49 -0500
X-MC-Unique: gEpHzY7PMK6J0qNlv_shJg-1
X-Mimecast-MFC-AGG-ID: gEpHzY7PMK6J0qNlv_shJg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361ac607b6so4588315e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597168; x=1735201968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QdTS6Bb8vn16TywEE3D3gC5PFxCWwUIxmBPDQfeiLAs=;
 b=THVqjkLp0tN1llF3dtPraCpNHokKr6tMnnxgOMXxgXI2Nqm3fjrDS01wd3cfbcg9wR
 MY9f/kJMOjZcEQ8pKoPosMg1CbvTLJtCbTMKQLTz/3k8g81IkxnycWAYESFr1B+6DETZ
 OvFsB9AvYKAEtCDxmdmU870EdhfLOYzaV6AuoGxpc96og6tfuHU9wLCuIU75LEWaU09/
 zzW7HEYmTQrCJp7cfnwm8SDPW96w9JRMQ5c3Mg3WKQlBqH3SozXXlzfCnJJgl2u6cHHh
 NljBlKxb42gLwueHdxUwYHJZ8XbEMm86eTquouwHX3NrN4vDrazPFi92qlikdNrj611A
 Ko6A==
X-Gm-Message-State: AOJu0YyRM17HJZBz3E0CI91/3ZCgEAdxWrQ7tcfJti2KzHSoa/5fRylh
 SCp5MC61FPaGP3tvxZ5D2DJ5FYxtJbm4SS9315Jxin//uiIuPgVorHv3zlylA8ZdsVj2hZ2vfpo
 ncDoos1VePIGOcSQ4878BknadZJO8iTmglzYBWsUKVttOjwu16zsVH2M/zKwR5+8Gg/cgG2P6Uf
 6n1qb1y6qThyLLw1KJAYlsPl1ZtoGBn6W841zu
X-Gm-Gg: ASbGncuWVnFKxDqpp8a3k+F90SSrkokq7J8MOfh0MoZbd/xaH36kD37SriuvSpOrxF/
 C05EfIDKGz7WssnHtys7mdzIYDI+1uvMShdQoXtCYyqEchdgR8rp16g0nu81+xWU7aX6ZxfVBkU
 7qW8dimvk+kxIV73bGC4OSqamNDdbk/l2LUkoB2urtUCI/TfYdOPua8gapLsoZe8AYG/jq9jYEs
 Ht0XOO+VnjLd8xnnKy1xzUHak0d+cWA+NV0eSPk4kc8euMq4V6NzQiLJkgI
X-Received: by 2002:a05:600c:3548:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-436553f5497mr44032315e9.29.1734597167765; 
 Thu, 19 Dec 2024 00:32:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDC75sFFIRDdKT60wIsTi4MwfMpSoyJ3Gg/hCRtZ0o5Q7vGYtJD5B3hv8j8XGnt8OoQebAFQ==
X-Received: by 2002:a05:600c:3548:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-436553f5497mr44032075e9.29.1734597167332; 
 Thu, 19 Dec 2024 00:32:47 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b0153asm45376125e9.14.2024.12.19.00.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/41] hw/xen: Remove empty Property lists
Date: Thu, 19 Dec 2024 09:31:56 +0100
Message-ID: <20241219083228.363430-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

There is no point in registering no properties.
Remove xen_sysdev_class_init entirely, as it did nothing else.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-10-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/xen/xen-legacy-backend.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index e8e1ee4f7d8..118c571b3a7 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -635,15 +635,10 @@ int xen_be_bind_evtchn(struct XenLegacyDevice *xendev)
 }
 
 
-static Property xendev_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void xendev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, xendev_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     /* xen-backend devices can be plugged/unplugged dynamically */
     dc->user_creatable = true;
@@ -674,22 +669,10 @@ static const TypeInfo xensysbus_info = {
     }
 };
 
-static Property xen_sysdev_properties[] = {
-    {/* end of property list */},
-};
-
-static void xen_sysdev_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    device_class_set_props(dc, xen_sysdev_properties);
-}
-
 static const TypeInfo xensysdev_info = {
     .name          = TYPE_XENSYSDEV,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SysBusDevice),
-    .class_init    = xen_sysdev_class_init,
 };
 
 static void xenbe_register_types(void)
-- 
2.47.1


