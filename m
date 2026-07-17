Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2FAC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkf3X-00083q-2G; Fri, 17 Jul 2026 05:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkf3V-00080h-DJ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkf3U-0002tL-0z
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784281227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4s1N6E1ijreaKGc1qpNnCMTcrq6TD6MWW0x4mk/QYbs=;
 b=b/03hEn+Ucp4rqwJtYsZcxrvVGXJ3ZHgXKwrKhCC05Z33BEtix1dme6HuJt36k7JS/ixkB
 Y2oNUxM7SIhJN/CErCidGUXZLtDxaJdxsQCU/2KPIw0L4YRWa+iR6vawXZSGeogcTTCl6M
 0a2OepsozZkjqOy5E6W+tB23taCWcBQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-XqgqX2n-NmWH16sGwxyZUA-1; Fri, 17 Jul 2026 05:40:25 -0400
X-MC-Unique: XqgqX2n-NmWH16sGwxyZUA-1
X-Mimecast-MFC-AGG-ID: XqgqX2n-NmWH16sGwxyZUA_1784281224
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4954c2d4081so1602385e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784281224; x=1784886024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4s1N6E1ijreaKGc1qpNnCMTcrq6TD6MWW0x4mk/QYbs=;
 b=fvJNBbcDC9oez3ZrF2wXIfQl+HNuvLxUmW9W4aDOPDgIcjL9FZJ2gJZPNhwQxemNEI
 sNhuL/kddrO/NU4FQiIcJbQjJ7oSX5vmCeGmQj79ws1DjVMLVP/CTY883j4dyqA5itah
 swJMzl6VvienAdMdIfHmbWFbzj5IAGprA9+jMglpzmuDdpVDeiHI+6b+at8DDcoI0T73
 KC1hYA55wDyspC8yz3fshF+lzuWJMrv7qXrpjcVkul+o3ND6xEhwneu7IOZgEAOfE5ki
 Dho5qmB1eLHBtmd8AuTKjCWKjuQcURkBNI3uX4va7yvsC2WED+lbr59SmU2xZCQCBGSW
 J5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784281224; x=1784886024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4s1N6E1ijreaKGc1qpNnCMTcrq6TD6MWW0x4mk/QYbs=;
 b=GyU6JloqPOiS604evpI9n0P/LMeHITsGC1zdsqzAvuOpR1E+ONb9ZQJgn2ZlAiKee1
 NYaUaPDNJ4HRJwSwgyUmGj6wOukdlwzaNeCbtWVJUWdcrERFxwAto8GJ9Rr+voqZhPYn
 jn5OvlCvApcY/p3xCOZbhoFmpNkuL9sdl9nPVK4OM3bQPHWk68NxYRWeuK1N9Oddeqba
 C6MAWftBtnULgtwValzbwCeiNhtVrl39QfiFzw6AFWCxDrC7Fv+Bok1VoYNo7qz8RGB/
 jHDeO/iTZjUpPidnqd01QqTbzRYjwrTQC4DW+R8j+Qbqy/z+/UhVKMyNhEgEBhhzLeGq
 Nyjw==
X-Gm-Message-State: AOJu0YxUcL1e8+Q9pab94SDDpSrE1dwEoXqYcrv9JZVR2EWzBLblBMsA
 hw/uIyLtG560QVHu5zQZMSs7MU9hCJAGHTEBWTs10lpn+FnjLTBcWAdULopszrqYJlUW5+v4Avx
 RKSPfx2FVJBOHXvYumC0c3ePhDPxMftxKZtTGnjBOAwYWB1xjiZGfBZ/C+EhaBPQFNTGZtjNACh
 O/Y2ni0d4osU7zNBf6Fwc0liLUFWVxwx3rh5wYkaU5EeTF
X-Gm-Gg: AfdE7cl7EHD1JkEJMv0sH6XWwA0SkoN2RE2JLWlXnMXnTimhUGRJTYzsJhPgOSscMXN
 UhT07INVY/ZyNl13Z6Sm98eZPrDEzNqvWuPeJ7xsq2a0KpcWjJiT5JAQ3YRmgIz/gKB7ka1uph7
 AyPaR0F7j2mb/ufaWUz6wvSTQn0y/yK4nJYffBM41MmlacrniFTN0Aw3Hx0YL2zS+nzhPl1pkFV
 KYBN9Wy1oT0OBaybU48MFNaNFQPWogZmr93yEMf55NI8Ut6BR4Aht5v+UrW15MS1oEmRmlk1qDw
 3GOoRkIvhKasPM+SoOzOg4Kbw+Ybn89s2P17YC6NKNvdOaICGSgXTk4gcOrrqPMC8Ww+IEoYFfm
 OL18ufrfjM9dCgoHNZHA5wA==
X-Received: by 2002:a05:600c:4691:b0:493:c47f:3c55 with SMTP id
 5b1f17b1804b1-4954a3e20a6mr21494665e9.5.1784281224054; 
 Fri, 17 Jul 2026 02:40:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4691:b0:493:c47f:3c55 with SMTP id
 5b1f17b1804b1-4954a3e20a6mr21493955e9.5.1784281223499; 
 Fri, 17 Jul 2026 02:40:23 -0700 (PDT)
Received: from fedora (cst-prg-95-48.cust.vodafone.cz. [46.135.95.48])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a35830sm38356565e9.3.2026.07.17.02.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 02:40:22 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v2 2/3] vhost-user-gpu: Forward RESOURCE_BLOB and CONTEXT_INIT
 flags
Date: Fri, 17 Jul 2026 11:39:24 +0200
Message-ID: <20260717093925.214023-3-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717093925.214023-1-dbassey@redhat.com>
References: <20260717093925.214023-1-dbassey@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Matej Hrica <mhrica@redhat.com>

Forward VIRTIO_GPU_F_RESOURCE_BLOB and VIRTIO_GPU_F_CONTEXT_INIT
received from a vhost backend to expose it to the guest.

Use vhost_dev_has_feature() to query the backend features, matching
the existing pattern for RESOURCE_UUID.

This allows the guest to negotiate blob resource support and context
initialization when the backend (e.g., vhost-device-gpu with Venus)
advertises these capabilities.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Matej Hrica <mhrica@redhat.com>
Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
 hw/display/vhost-user-gpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index dbba80c7783..4022a3026ca 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -643,6 +643,12 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
     if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_RESOURCE_UUID)) {
         g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
     }
+    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_RESOURCE_BLOB)) {
+        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_BLOB_ENABLED;
+    }
+    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_CONTEXT_INIT)) {
+        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
+    }
 
     if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
         return;
-- 
2.52.0


