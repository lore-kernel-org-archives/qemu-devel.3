Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E851CCD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIr-0006Kv-BI; Fri, 29 May 2026 00:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIl-0006DN-9v
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIh-0008EZ-Nv
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DrFXvSxI0Kk2tcLgzbdAEMmlDq12az4sQ49oefYzYU8=;
 b=K6/s4iry/a1eE7nMIJ5ZcC1mUJyvrvJvPRCz4CkNfZ0Ooa5Sbsiexymr+irRXJNyDissBP
 Brxa+lkcDuPP0ic0UPfD7kK5i84rac3bJ8Qex2u7z1P3BMKCanoMQMA7uVq8AcrHuQEZ0j
 FJu2KffogQ5pq0QdaasxRXH8vl0Ut2E=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-3dLEgBFuMHCc__GoWgJqsw-1; Fri, 29 May 2026 00:58:24 -0400
X-MC-Unique: 3dLEgBFuMHCc__GoWgJqsw-1
X-Mimecast-MFC-AGG-ID: 3dLEgBFuMHCc__GoWgJqsw_1780030704
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so3940328eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030704; x=1780635504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrFXvSxI0Kk2tcLgzbdAEMmlDq12az4sQ49oefYzYU8=;
 b=SLDR5X3kdwL3En/EEmfi1uSZodOoD0epJxZ9umaFugtGJ7f7p0ZjrAGKux4VqM9I5I
 CQXHVzFuodIVIZXSYM8CHpJ+3F9nEW5r5A7Lw9recaOkoEpzDdTMbVM4E75jZPgujt0W
 w7+4I4rsLwq/HdfWSGrKj58ddwknNGt302QbVpRXDQrh+D2NtL2HhJPJu5ripNpQQX/V
 ZEYno4OQhmHVDDyBcPvJZ1Bl1Sqfwr8+b5ad4UWpLHze3Frhs+0DmonziP+vZ2naQeQw
 vi2NC87gVDzy+4tY3af9MEU/MImHqBypkNQ9IO9DODw85n1iHhTymQ6N540z9v/HLt9d
 vKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030704; x=1780635504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DrFXvSxI0Kk2tcLgzbdAEMmlDq12az4sQ49oefYzYU8=;
 b=c8hI8CFUIsxTrY3kgEua9sPC7VFeSEZ+8UGGmKr3Olu5kGOoP+2dLtV/fPjRdL0zUD
 eZP6foxEh1QnwAbSwz7O4HM7MGEMePRcAYYZPfg+YJwrjdOG+FwKCmUsmO3bAd/kAQmb
 +MJoewWBibcUUDQ93BHHC+vG0BlrWRDPUUU4objAGUmFI8p06YIOKIZzi/ONCwNtfp3s
 +zMFoXwIl9YmJ8IQr3IeS28PGEv5pE/BhklmyYLDOrSikStOEvXROEa5HNdvF55orhRx
 oM6CslT95q0VFWsfvr1ncgAb7EPlPPLqE5hwMI8PFaEclFWXS64rb0vPN3jS/pz9AAQx
 FEDg==
X-Gm-Message-State: AOJu0Yybfyu4zv0Naou+mBQAkO3Q9A2KM9awCcKZcLVLHMzY08axJhyY
 jBsmb19IzuQew01D94RZvB2a7oHI95fB/itAq8pH6BM9Xper23O9cw40rDQ4byTaFgYlSDLWW8w
 AaqzfrS1lxbfJNu6yN3PIdFl+JkA8Hg6Q2SrsFAs2YsfnEWt/kVxKl+WwlhX78vcoQtMDBrX2VY
 aDI7TXe8TIJWbrClEUx9N2Vywg/N/vOXDSLi3O3kWxqXg=
X-Gm-Gg: Acq92OEhJEYiJWLMu+iSo/eueGXP/fNFnXxcqvIKrL05f6UHfWYIDUlbPTOTf6r1iJA
 pM4Tgr+CnjimoQq6YMqQDmgz6EH8qsHW4/I9/4lYdCVj3pcGHeNm+tvLTXqQkk0oOY6+YGY9waD
 Kw9MfOeDFICcDnqBxfZFS9Hrzdb24Okr6JYo1sG7cmv1rmcYTHVgxXhGQBV2jp4pxNisACAyEs7
 lYOMgMzUvwJRx7CnWsfV98FBzGza4FpjzuHz8mtyRsesJ45RXphdt5iocTnJBPl70GKBgfX8uP5
 dGu2SawM2yPHespm5hcy77wZJAkSbtPIgMgJTV3DH8v53X7T4djVJVLPF1P2CAtGn2c/uqpzHWb
 ygiQBDVYd87AZBBB6d7bFRFlHhCf0NOWB95ue9fVIINo3GPCHoRxVZ3F4N0b16rksNxTTwvwL
X-Received: by 2002:a05:7300:8ca7:b0:2ed:e14:42e9 with SMTP id
 5a478bee46e88-304eb231ec2mr642908eec.34.1780030703617; 
 Thu, 28 May 2026 21:58:23 -0700 (PDT)
X-Received: by 2002:a05:7300:8ca7:b0:2ed:e14:42e9 with SMTP id
 5a478bee46e88-304eb231ec2mr642898eec.34.1780030702909; 
 Thu, 28 May 2026 21:58:22 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.58.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:58:21 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 11/15] net/tap: net_init_tap(): merge fd=,
 fds= and helper= cases into one
Date: Fri, 29 May 2026 12:57:26 +0800
Message-ID: <20260529045730.90322-12-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529045730.90322-1-jasowang@redhat.com>
References: <20260529045730.90322-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now fd= and helper= cases are just a duplication of fds= case with
queues=1. Let's merge them all.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index d5a719150b..c6bf8a7042 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -903,19 +903,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         goto fail;
     }
 
-    if (tap->fd) {
-        vnet_hdr = tap_probe_vnet_hdr(fds[0], errp);
-        if (vnet_hdr < 0) {
-            goto fail;
-        }
-
-        if (!net_init_tap_one(tap, peer, name, NULL,
-                              NULL, NULL,
-                              vhost_fds ? vhost_fds[0] : -1,
-                              vnet_hdr, fds[0], errp)) {
-            goto fail;
-        }
-    } else if (tap->fds) {
+    if (fds) {
         for (i = 0; i < queues; i++) {
             if (i == 0) {
                 vnet_hdr = tap_probe_vnet_hdr(fds[i], errp);
@@ -935,18 +923,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto fail;
             }
         }
-    } else if (tap->helper) {
-        vnet_hdr = tap_probe_vnet_hdr(fds[0], errp);
-        if (vnet_hdr < 0) {
-            goto fail;
-        }
-
-        if (!net_init_tap_one(tap, peer, name, ifname,
-                              NULL, NULL,
-                              vhost_fds ? vhost_fds[0] : -1,
-                              vnet_hdr, fds[0], errp)) {
-            goto fail;
-        }
     } else {
         g_autofree char *script =
             tap_parse_script(tap->script, DEFAULT_NETWORK_SCRIPT);
-- 
2.54.0


