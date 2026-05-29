Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA06CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIU-0005r1-4Y; Fri, 29 May 2026 00:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIS-0005nF-Gv
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIQ-00087g-Qy
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TeaCWgxz26pIuZ3T1/Jo3a4lmDTksPW+9uKpcpmoWbE=;
 b=LMze9WUHoCf/AJ6pSrLeqVAqv7V0pdTD3XmQbiMHkFqkvc6G3sg0zOZGvDDiXk17BAVylF
 MtLUHX+hfkjPwZDkm8sO2/svfGjhUkZOYlECmfMeHy29MO+cAhXSAX/McwDT+3NSXPtSFd
 ZRsiHSBYoIbpQOsBGxARge5uQkm+bl4=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-deR2WmYfPoOyoOFVxfyeLQ-1; Fri, 29 May 2026 00:58:08 -0400
X-MC-Unique: deR2WmYfPoOyoOFVxfyeLQ-1
X-Mimecast-MFC-AGG-ID: deR2WmYfPoOyoOFVxfyeLQ_1780030687
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-135916eefa0so1633787c88.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030687; x=1780635487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TeaCWgxz26pIuZ3T1/Jo3a4lmDTksPW+9uKpcpmoWbE=;
 b=tyr/gkmGwI/eciWVyKW2IR18l1vIySOl+MQafivMUw952U3xrNyAO0Kk+/FAZkdpAI
 8YUvKwupxHZ8gTy0xVqvLbYckZgFUPSDFEj4qY2K9kHm7p7NfKKcUXMAIV35EsjMlVND
 g1ljpSoR6RRuKX0+lMoLhXhye5gGbBXhVJtWpfpdyu7PrOIDMXBzQDfeZF2zX3d/W+KN
 Z5VoTdzMbYaBIVR19OHWLMZA/0BJM2ymenFRXAZBj8HpuEtYcxzmMYt2G5wfyetmI8/W
 QfcnkkS4ixkt3Qrp7Yb+zgUOpMqEb6QxzsrBYUbW2T4xm5zTqFohgLvQgCZRf26H7AYS
 gdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030687; x=1780635487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TeaCWgxz26pIuZ3T1/Jo3a4lmDTksPW+9uKpcpmoWbE=;
 b=rM1a44XXt5Tfaf/f+j82Pa4GaVdXDHRj3JOF/srI10qdzytSEkiSFgjY+fYY3WnsOH
 SGbh0hPdPA9LTinE9JhDUgrL7Gc7jtbh/vFxvdSiHATkeYrXFp2Uvx1phUwTuRcytHLs
 YJnCtKyb59uYRxblPbzerzUrp13EeZzJCLUPcgp2PzkWUwriYfzjQZUv0cGiI0TG19Ih
 FxoW9SvsQXT2k80sdsYV72h5S7HgoaW/ZeetzHnV9Nuevc6rrnHgy6Els5zjZqg8kyJD
 E8oFK+8SZQKwc9SAu0FaJGhdI90P3qPD5Sx52ngCjZ1YL8TgYi8BY/lSS/J5IL/d033A
 b6ow==
X-Gm-Message-State: AOJu0YyU7DzV5gXktaSuOCxLTbZZi4V9AjXJREp+ymJvP2aKSjeIODxq
 IShv2pKtgp0qE3SFXFvo6U0G0RT04G5CbjlE9zyqkRFNVxV59jy8MePwlsQKYMVog4FLeTd0iFk
 OAV5EWCiW9BAsuHipG6dQ/FMAKDTX7nIUABSmlX+Y7eJ18rOX20CtjZkrq0GLMyYKc4HTl91vzE
 bs7uiH9nwDOwxDwaVRNgjrDf/Z+wUIzV//CUhbkRLHuOE=
X-Gm-Gg: Acq92OFSBAyKpFx1a6gWC4uZU5CHPASia/7FpiGM/VPPKMj+UTZhcAL9s8GqhQunpyh
 Fie/N6HsYNGy9gfJdB4++5gScEHiB6YrRfe0+gDFCWfAbfEjCcAdhF05FPUwCNpm2pEr4E/1sqC
 zLS6zp01G6NMqjjYUgx0Qy8cEw5JLFG4VOJ9PWO0+zLULmQj7QjdKT+vHfegzWbolfvQIQzj4sW
 byYeetqTor2ZdnA+Y9lylIgLhdB47/4w2RZ5ZFo//eqAojHkQrM7eOrrv8+Pax63cy/fpTxnDdu
 KROYlQUnkgEu+xMIKGa9fiWH6EjMtpPGzhPigOseQVUbrN9CjO/4usq28Efic3FG3gNB0DKybna
 SUBWQIZehceeOnvPDIJVYOYpIgu4fk+wiOv5kFJqJZhAnWjmNI8y7sky6PsDleTDhxU2EFret
X-Received: by 2002:a05:7022:6b86:b0:136:6d82:18ce with SMTP id
 a92af1059eb24-137af649b32mr541513c88.23.1780030686855; 
 Thu, 28 May 2026 21:58:06 -0700 (PDT)
X-Received: by 2002:a05:7022:6b86:b0:136:6d82:18ce with SMTP id
 a92af1059eb24-137af649b32mr541495c88.23.1780030686238; 
 Thu, 28 May 2026 21:58:06 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.58.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:58:05 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 07/15] net/tap: net_init_tap_one(): drop model parameter
Date: Fri, 29 May 2026 12:57:22 +0800
Message-ID: <20260529045730.90322-8-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529045730.90322-1-jasowang@redhat.com>
References: <20260529045730.90322-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

It could be simply derived from tap parameter. And this change
simplifies further refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2c5f8e73fe..db3fe380a4 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -704,12 +704,13 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
 #define MAX_TAP_QUEUES 1024
 
 static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
-                             const char *model, const char *name,
+                             const char *name,
                              const char *ifname, const char *script,
                              const char *downscript, int vhostfd,
                              int vnet_hdr, int fd, Error **errp)
 {
-    TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
+    TAPState *s = net_tap_fd_init(peer, tap->helper ? "bridge" : "tap",
+                                  name, fd, vnet_hdr);
     bool sndbuf_required = tap->has_sndbuf;
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
@@ -883,7 +884,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             goto fail;
         }
 
-        if (!net_init_tap_one(tap, peer, "tap", name, NULL,
+        if (!net_init_tap_one(tap, peer, name, NULL,
                               NULL, NULL,
                               vhostfd, vnet_hdr, fd, errp)) {
             goto fail;
@@ -934,7 +935,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto fail;
             }
 
-            if (!net_init_tap_one(tap, peer, "tap", name, ifname,
+            if (!net_init_tap_one(tap, peer, name, ifname,
                                   NULL, NULL,
                                   vhostfd,
                                   vnet_hdr, fd, errp)) {
@@ -957,7 +958,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             goto fail;
         }
 
-        if (!net_init_tap_one(tap, peer, "bridge", name, ifname,
+        if (!net_init_tap_one(tap, peer, name, ifname,
                               NULL, NULL, vhostfd,
                               vnet_hdr, fd, errp)) {
             goto fail;
@@ -988,7 +989,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 }
             }
 
-            if (!net_init_tap_one(tap, peer, "tap", name, ifname,
+            if (!net_init_tap_one(tap, peer, name, ifname,
                                   i >= 1 ? NULL : script,
                                   i >= 1 ? NULL : downscript,
                                   vhostfd, vnet_hdr, fd, errp)) {
-- 
2.54.0


