Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C2DC4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkixo-0004Zn-Gs; Fri, 17 Jul 2026 09:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkiwt-0004GV-Q7
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkiws-0001Yt-1e
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784296192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4s1N6E1ijreaKGc1qpNnCMTcrq6TD6MWW0x4mk/QYbs=;
 b=ZQ2GH7iKxuxmpVlp5Pu88pyH3JrSIUtgMq6F0GIEZ3AnFWIlaPNXaIMVPjdGTcZsCVLqv9
 sDVO6AvuZTswFeeFX92F52N8rRCzebtumhdgxpd35kIQ0nXabH8m3vOTcCzRibFm4UKV1J
 wibLmq1V98kBs6/TRAT5fsWqZ0dYS3M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-eDhVVv3aP42x7Z20YC70Gw-1; Fri, 17 Jul 2026 09:49:51 -0400
X-MC-Unique: eDhVVv3aP42x7Z20YC70Gw-1
X-Mimecast-MFC-AGG-ID: eDhVVv3aP42x7Z20YC70Gw_1784296190
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493e94719e7so52444055e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784296190; x=1784900990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4s1N6E1ijreaKGc1qpNnCMTcrq6TD6MWW0x4mk/QYbs=;
 b=X7nSxTqbGEwlQNDJGNupFBudjzauepbP+EbGMCM/YzvDGchoF6e/E3lIPlyAqcXy9V
 ZdjmQh6Y0CbbuAXU8oLtF+C3X52MWfBAjxKGnyrPLr7RRmFx2f88dHAKIEhm3fBEMa8r
 OtqQyu01c5XDiZnBDZVjBEZmVdPKE/z7KIbBRLz9SsLckcdkTYeYzl+bLPioGrNjyAJM
 MFElPDenjC2QzFP9SIzosJmFhyGNttZAzujfYTaDm8eA7otC5yOcQtCuqUD5ATvryayB
 hLDgP7PO2HFs45JFQ97CJwGB7GX5PAn2RV3+ha0FI+ncP+E4q02hT++9OMG6zB82Fwr6
 lh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296190; x=1784900990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4s1N6E1ijreaKGc1qpNnCMTcrq6TD6MWW0x4mk/QYbs=;
 b=H1bPdBROaqIHBKNf+/pUIz8bx+Jflo0/7Q39jF5IShwggUHrWmf0CXtmk+s1AyFqtm
 N9JUSmrSwsbbAtCg7rFYiNmsqp3E9SWlJi1Vt94ZWS6pNbUsyX+xuHaTiP2Q1COtzK6k
 6XdNH7IWCFFHspqIuVRWd8q6FupfOw8zqyFUIUZ2+2W0OhBzGhZvopeJlG3ggaeronIH
 8f8AB/plZL+27mvriaSM947B7WeBXOrD+D8AS28uBw8bF2SHMgH1PfTmyjE4FK/HRqt3
 pwIIk2qQGWRzr0ZESjVvxCJE+gE0FwIqKwJY7loDqa5xucN9Km9OpPP/NfvrQIB4y1Be
 Ztsw==
X-Gm-Message-State: AOJu0Ywf5PpLwbuvIEUP+FKwKKaCzSDc44adkcS1loDOLkqaY8HtbCFY
 2Vs5M1ZpZDJX/6/km3RVD3Z/NVYUjS/GsvXBURz9YF62HAUOGtiGZc3QlV62hZl9u9TGZy/w66U
 By5Ran+KihlhjqjghJQLRfwQn0UhAToT1IBVDEx7Fa0UyzDZy4uhaqTTPH4zP1050ZM9tsN1YBy
 wWJZ7YpTpzmsYwK3xFN/4KqMh60bTQzdl2vcaj37E9tVy+
X-Gm-Gg: AfdE7ckOYfhcjycGlsOgaOISZklLcwCDCqxjfX85FLtTDCrioQ32jOoeXBvgEs8F90j
 pcQj0qZR0sKytt1VYM3ZQtFmsnMkVjIb87cqxO6jTxD0b9BhJrT42cUxsY1ZAiMOPiXQSrk4Ikh
 dT5y7nbG+zypy1n1LyzJDi/UaraS/YfB2DAaNis6a0dLuoILo+omQRu+heS0UOk2lL0PbNJy6Na
 uaVpzZvgEOhySJw2oVfWGePJy3OuroW4dAw0P/jUyN87NDInB2sdAw+K7frQLQVLx788BU8O0mt
 mdrJ7mdskOXqNftio9LM4XP3nrUc0R5bYj6o99JW2qKvTn+weqjwTQNPnWUKEFEP38q/TLqQrwX
 9ds6uUS8DuUmN1UZ5AEzS86SyFOfbZqRTzt76j/iF+LvG3La3ac44CwLAvVlEBhov+/BJ1uAqlJ
 N0rbxEAi6MGA==
X-Received: by 2002:a05:600c:55c9:b0:493:bd2f:c5fc with SMTP id
 5b1f17b1804b1-4954a3e4926mr25258345e9.15.1784296189865; 
 Fri, 17 Jul 2026 06:49:49 -0700 (PDT)
X-Received: by 2002:a05:600c:55c9:b0:493:bd2f:c5fc with SMTP id
 5b1f17b1804b1-4954a3e4926mr25257585e9.15.1784296189193; 
 Fri, 17 Jul 2026 06:49:49 -0700 (PDT)
Received: from fedora (cst-prg-27-253.cust.vodafone.cz. [46.135.27.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954ba2abd0sm30049525e9.15.2026.07.17.06.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 06:49:48 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v4 3/3] vhost-user-gpu: Forward RESOURCE_BLOB and CONTEXT_INIT
 flags
Date: Fri, 17 Jul 2026 15:49:20 +0200
Message-ID: <20260717134920.265128-4-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717134920.265128-1-dbassey@redhat.com>
References: <20260717134920.265128-1-dbassey@redhat.com>
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


