Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D13C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8Iy-0004lo-9X; Wed, 12 Aug 2026 08:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wu8Iw-0004lY-Qz
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wu8Iv-0007Fu-56
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786538612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s5GlkEq8BygSvAKUmzE6jXyNrPWHFI8D44sie+KE5Rk=;
 b=KfdY/aGRh3RUAOQmPYGilFeJFDnh7YGwzs50K8duw83kYYNeZvR+T8XFYQDP96C7MauBgG
 d0E3icE4yD9c5r+73kF+LQDNc9637ez5HwIfTzAN36iQn5wZr8fayVc+snI7rlJX1pbA03
 oUf+1F8+Ja9l3iK8nV8bfxwIO8LzwSE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-FoMZOZiGPS2Avb1CPtaMzQ-1; Wed, 12 Aug 2026 08:43:31 -0400
X-MC-Unique: FoMZOZiGPS2Avb1CPtaMzQ-1
X-Mimecast-MFC-AGG-ID: FoMZOZiGPS2Avb1CPtaMzQ_1786538611
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso90667285a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786538611; x=1787143411; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s5GlkEq8BygSvAKUmzE6jXyNrPWHFI8D44sie+KE5Rk=;
 b=SAzq/D5Sj0VJJNAIv/P5PYGVMFZuGCnjI1Y7Iv9yHJMEFpbfDf23V8eRZmnnhbk2AE
 rT3d89H52Ov8fU4x+Ce678YItOwOV3QVVr/lVo8k+Nca+X0iOg9n3AcnpoKGxTSC1hnz
 u0D0b6h0si0tSRZptUbvr+JQkx8V0Lo+IZmFdfcHZXbQiaJZvpRhNyCrGP7T/TGl4r+z
 mVaJhdqdZMYE2DCWspFVdPnkCakxfAH0Enhz7BYKVrGe7OQDo0LgIyhrrn4SjVkqTYdV
 JhUjaUxXvnSQEytg9V+q0xpX1Yc/7X0XdWnZXpIsDRpQoMDI0pVdnPN7AjqECemNSMDx
 jjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786538611; x=1787143411;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s5GlkEq8BygSvAKUmzE6jXyNrPWHFI8D44sie+KE5Rk=;
 b=NUf2Yxc0Ezw7C8DDJB8vUtZFmWw5ce4Wqav1u+5wX36N/fLfh0gWOtD+gRUaFDEbw7
 lJl+oHMZfpSNhH0O1Lc3LapcncWBi7wojcZQ/+QkIeHcimuMsCVLnJkJNoSdU2YQxs9D
 ZETsMoE4v2qX3xFvpVKC1he+tWSAKwOd3Obtc9Eu68k31n/6X+J5xxNPoFy3x3OjS1fk
 02wVeoD8/bnl3MV3LVhsu8USzStbM4q1mSn+KhTAdKfo0TZILACUTeQJvdZ4w/SgxyQe
 VlwcwZd+o3+kAe4sS2eKUU3LfEcV1bQsCPm6LVv1xaGrGdh97LQgwKoYSKxi1FntkCL8
 Xc1Q==
X-Gm-Message-State: AOJu0Yxej/SVRqGPW+o5ktN6UIELp7WYQno2ygTpHEslusZ8YvZ+YHO8
 H0Gv5Yyo141WxLKaFtD5odkobtZFznqomHiPJY6d6VRwER2V0QW+xrlcPicjiDzESoLc4iRqXlQ
 EkdlrIbifbeha7FiYkkJM3EsJwFCnljdpVYy5HXytTx2Z6s5ePA7c1u0q0AWp9iQQ7s6s452EPy
 7b5UcSY+P6fACJ36ibRAs3vrgnHqO1Qhm+LxXFEw==
X-Gm-Gg: AR+sD10yYYafpkgnsM+JV6MwQ1lQFCraLQEIcXpeioIjmMclD8JWRjfEdopwl1w5gJ5
 umQaiZ+qL1kRjUUny/uSr5WpQVyMACaGlf2CVG9AQ6M6HtR2CQ+5OghTTUr+kNFPwRHxX5HiUGc
 3+H5Xj82CAKjMugkxcf9rACGewoeIYC8628ExfroF7VSxXVRkHFDXyfcw2Alnd89fXgY8n7dam/
 stJVqA/6xbtx4oRTj1WhkVbeoRlL1f0VOZEP6kHZV6IcCe2qH0RFCPSjLFQh5rT4fTTF3urK7Kw
 uJJ9otZaQ+MXra36smeL+x5sCtS7nRuK6AvG8vCab/MDsbMvGCR1+9IGwaE71D7Hg5EbSm2B0b9
 o3LFUPx4H2nToitiHbV2dXa4JpaiSub6AhuDCh1/GNiV3NSTWBkM4nK2h
X-Received: by 2002:a05:620a:3192:b0:936:576e:227b with SMTP id
 af79cd13be357-936b3d24aaemr375529685a.24.1786538610510; 
 Wed, 12 Aug 2026 05:43:30 -0700 (PDT)
X-Received: by 2002:a05:620a:3192:b0:936:576e:227b with SMTP id
 af79cd13be357-936b3d24aaemr375524385a.24.1786538609923; 
 Wed, 12 Aug 2026 05:43:29 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936b5f720eesm118947285a.47.2026.08.12.05.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:43:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Feifan Qian <bea1e@proton.me>
Subject: [PATCH v3] migration: Fix rare hang of migration_channel_read_peek()
Date: Wed, 12 Aug 2026 08:43:27 -0400
Message-ID: <20260812124327.2572363-1-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In an unlikely case, when a migration stream is attached to the destination
QEMU and only send <4 bytes to the channel as magic, it's possible that
migration_channel_read_peek() may spin forever.

Fix it by adding a manual sleep for partial read.

Since the path isn't attached to a coroutine, it means when partial read
happens, there's yet not much we can do but hang the main thread, it will
happen even for len==0 case.  It means monitors can hang due to this,
either partial read or no data arrived (but connection established).

Leave this for later, the hope is this is extremely rare in production.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
Reported-by: Feifan Qian <bea1e@proton.me>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 1e2935f926..266ae8f776 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -296,9 +296,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
 
         if (len == buflen) {
             break;
+        } else if (len == QIO_CHANNEL_ERR_BLOCK) {
+            qio_channel_wait_cond(ioc, G_IO_IN);
+        } else {
+            /*
+             * When partially ready, we can't use qio_channel_wait_cond()
+             * because it will return immediately.  Apply a manual wait.
+             */
+            assert(!qemu_in_coroutine());
+            g_usleep(1000);
         }
-
-        qio_channel_wait_cond(ioc, G_IO_IN);
     }
 
     return 0;
-- 
2.54.0


