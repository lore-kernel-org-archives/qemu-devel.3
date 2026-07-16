Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F09C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkM5b-0005DU-WE; Thu, 16 Jul 2026 09:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkM5R-0004vD-8W
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkM5N-0004za-22
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784208306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fO5XG110R09Wjc++FkGBZSdG3eU1kTND/sXtT3h2tqw=;
 b=PdeQ9C+L/ik9HiUOGRkFr3B3hNjeZ7S34mCIRLPkPiWdYb16qes/3Rolat+6hsRctYOdd9
 RH6orFW36x4vsUcheyUE2temrJ53uJNc77y/kb1OYHro9KB+zUWVozYDW47sOy+dIqBKsE
 0bx2sigshEjAM0r574eBgprAxK1mdr4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-kntJHUQaMOOb-vF1s6MDsw-1; Thu, 16 Jul 2026 09:25:05 -0400
X-MC-Unique: kntJHUQaMOOb-vF1s6MDsw-1
X-Mimecast-MFC-AGG-ID: kntJHUQaMOOb-vF1s6MDsw_1784208304
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493c526df6bso27990535e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784208304; x=1784813104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fO5XG110R09Wjc++FkGBZSdG3eU1kTND/sXtT3h2tqw=;
 b=CUFGAaWx/xpxr+JiuLz16tUu2oqLGC5+Ov7EoIu+45iJIQsours/juuUm5w0AcUJta
 MLnlhibmp2wU3afFbtoMwNeAy983YwCQ+3F3if9ptaGf7KNJg/DNclnw4yjrBLDhjorK
 e4yyYDXIzBa5uCMrq0fkOzYm+tyRjve2HM1srjBVNKUZMzHNEjl6Z+EuM3VgR4fHkZa8
 JsZsAMTzOmcgcnl7XiRuxFyl84G6XlHVdKayrEWQl48L37+bsFUqastWxdJndHWERrKh
 l8CCjIb9gzOqPjI+vdy7XeZL6TkrpzJQGbck4bxOu3UYWHT0SQgLl/rbsGfLoC8DYMjD
 dWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208304; x=1784813104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fO5XG110R09Wjc++FkGBZSdG3eU1kTND/sXtT3h2tqw=;
 b=plGEx/hVjwj4sqaPbyUm5dhQTkZcgm1Qff6n6462S6xgYbbULyJbOvqLWYpqVcO8PN
 Mp/J6dr8erfTnR61h+SaS14ExyU97sfi+hn4fSIuW/GF6KcUpW8YMBD+fnjzsJfQJs2/
 38Zn0XJtDy6ZAeuc7wX8X7ea1E8G7E7K2MsKOWUvUpHznIorU3y+ujUXU1dRA+Ufh+9V
 IdUgEe79lA3CyWM0q0GoLePMKOvaXydrXCEcHesZ0/+hfCJruOR+nCU0SjhZuanN1SJ4
 Z2MVZrmRm+6OqqTQEUZb0JCRFo/c9u2mzkW2TnO8BTbpeHlAuTJyOczW3UrxZti9Z7k8
 3DHw==
X-Gm-Message-State: AOJu0YxwVX9f2YchTnsNQIbIVuS6HoPYVVWTAEL5MkCapaMYHqB802DI
 /+Z0St9enP0ZPonyHM584m55dueZOuIMQocxOVn8f2TGIFgmhtgpaE21NNxPcPfEJWOe2kh1VLy
 TBGT65EafhfDsoj0Uaa5T+tAv8Rrry3by+Ige+6iT66mUAVR1oFkZQSd76rutlYM0qmw9THBWCY
 BzmsqwjNyAo2UhW71yK/5SUvyF61gAN1tOUOZFsgDKVplU
X-Gm-Gg: AfdE7ckfUoaiH3bpEb9jarrbbz87ZVSV7G1iklG9tmuiF2kdANbDjaWoEIYEwy4SCoe
 0UN63mH7mH6SPlQaHHuuQydaqW2nnh11RRZEsiWjKBFJi1s/Pp1GLo2m+XKeDg6TEmUuMd9nEnt
 ERG8F+/mYC8YrHtDwC+C3kkQv6uwbrOmqD25nSyMTP2yh/z/WErIANSaECDZXhAP2mcnnevtYhH
 MD5Fd/kpVjlyUCe0B6lmK8yL9EEVT/WFayuhOjbFigUa4LAvmYkR9jNaW79lwf+4NONLzxgqynJ
 0XeH/ZtSmUH+vD/jxyhUmvu72VWJpV+asmjivjO/So9+1S28xOd/5dWuVsBYVDNZqUJmBn8fcsz
 WZcQN7BXzjWALSEEPkMJt8Q==
X-Received: by 2002:a05:600c:3e0c:b0:493:f176:dc69 with SMTP id
 5b1f17b1804b1-49542c769a5mr28614555e9.37.1784208304009; 
 Thu, 16 Jul 2026 06:25:04 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0c:b0:493:f176:dc69 with SMTP id
 5b1f17b1804b1-49542c769a5mr28613865e9.37.1784208303513; 
 Thu, 16 Jul 2026 06:25:03 -0700 (PDT)
Received: from fedora (cst-prg-95-48.cust.vodafone.cz. [46.135.95.48])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49543e3afc2sm30347885e9.0.2026.07.16.06.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:25:03 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH 1/3] vhost-user-gpu: Forward RESOURCE_BLOB and CONTEXT_INIT
 flags
Date: Thu, 16 Jul 2026 15:23:57 +0200
Message-ID: <20260716132359.96785-2-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260716132359.96785-1-dbassey@redhat.com>
References: <20260716132359.96785-1-dbassey@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Matej Hrica <mhrica@redhat.com>
Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
 hw/display/vhost-user-gpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 57360898ca0..06549c98e07 100644
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


