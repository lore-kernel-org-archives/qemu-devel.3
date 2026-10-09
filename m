Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D30FCA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF9WG-0001qk-Ad; Fri, 09 Oct 2026 08:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xF9WF-0001qa-1Z
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xF9WD-0004GQ-J3
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791548168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TgQGJQjoymALL3FlcbtW3uZTm+e1krOx3xnShKHw5YA=;
 b=hTv4X0gvvp599VkteUYoO4bdkIx+3CDCskec1VbJm7EQEUFJn2+mJ1m3zragrzd0OBbwBF
 SjKyG1hzIP9+FhXn7u0knyhO8W2kOrdbLFr4KAJ27RZQsLt+HLM161jYbjwuKH67TCEl8f
 XETM8QsLJhQqXhY8E/nYBNe35eztUQw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-z_ejP-m9O-2nTKuvvuKAJw-1; Fri, 9 Oct 2026 12:15:57 +0000
X-MC-Unique: z_ejP-m9O-2nTKuvvuKAJw-1
X-Mimecast-MFC-AGG-ID: z_ejP-m9O-2nTKuvvuKAJw_1791548156
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a01d1fb07bso64579035e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791548156; x=1792152956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TgQGJQjoymALL3FlcbtW3uZTm+e1krOx3xnShKHw5YA=;
 b=Yxr3dUy8T9mgCi5oSOpT+ajUc7B1vyxLtO/fJzbio5eLXzVhCeoWrUwZRTNJy6t+Cr
 JYSBe6XhKuTABvjsS6ugGKiGzaKuTOh1um8hMViftuM8uXUOKOF09QXHhMgI2MIDpa7p
 Rv6r6JTaTeFXSWRazj6KO/ZCxtdbwJkJNBjVlHulOXxqMDBq2cUDN6GMtZYpnEl1GF7i
 F8RslVLcjK/1tMd1pw6p9TdQArT2fABPrdXVn/fImOcht1O1wZPgEUneILR6vG2OUn/g
 jnWZffWaGyNeq+CnEOV3jwz8oGnAxD51uPpgg3l6Pt64QfbUQgf4twGIaaNc1IrNLFgu
 T4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791548156; x=1792152956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TgQGJQjoymALL3FlcbtW3uZTm+e1krOx3xnShKHw5YA=;
 b=c7PfxDIqg8oHXKxEvf29dPnhqjK0Tit0/4qG8B+4V911zxzeMdHmD//WKnAZrypsDv
 Q1C871/k9Cw62P/oBgWQXgGpxYdRqYE8jlPS8P6Y1nNG9Fzwl/rNeozrN+ofuXmFgnhL
 cNqGyjKoTLdqKWeA4IpXYddq/o9u1ceXe9w5llSzQth2i2Bu76cysO9CGRglIIHgnwLy
 Nyiy/GZItgHpR5i34l2PgdrjAM4QQW4BQ32rAkgmPwE/dezKv0Xh1InRWVaSO3Oq9qV9
 cv2zG2GQlnN3xMvLIsL1s0rHFv67L2/m1SXSUQYZ31T0ptQ/Xe536JyQ6Fndf0AbYxse
 S4Wg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+OhGTjoB8nKvo6ud264FvO4X1s1SpCCtWRxxcT5F+kVXg4wtSkFRuzfsNWHpqdk7wN11zWRmvU4oU@nongnu.org
X-Gm-Message-State: AFuF++lvMWosEqX/AXh80QWeK68q9sH8IDRWRvf8rgEgk+XKMViYbDxY
 UEbxghao8tot17x8mFOSURd/g80RL2GdUyC57WiRgiBJiar1O7qX5qDGxc3MBCzfdq9R8Cc2WC/
 wor1kJIjCKUKrQQkCYVSxhhz+fe5OVpUBfz0kx321gnw7RfHG3mw/jciJ
X-Gm-Gg: AYBFou27KeRHjgo6J0GV902F06CEcxtA9tjRHPYdJknF/f1SBRxS3TPSUbFzJfWg0VT
 77vnfXxcAotyx9t2NC9Vqc/qrjv40ffxi5QNG+Ve1Vw0AHLthwkb6dD18zXrMzQdkdDzNWclAgC
 6xrncqIuNsplCO4qG9EkFOuRlzMt2byxx4pKhrf91ue5WEzZjF+5AhF+6JO8QsbB3BtML3ILE4h
 mOgD1Wcy7UnKkQDMo+55WpUYq6cCxDvnWngTfsI92sP7S0AHdNVB/nZq++GRgdTZs0JeKaOLjkW
 p6pp+Ypm/0EeDelz+RJ6UIpHvM+a2ghlfxBUFzcuLZYn1MEBZeY/rglp07gaTUjCt1BEM+Cv8Q=
 =
X-Received: by 2002:a05:600c:5489:b0:4a0:1c94:7042 with SMTP id
 5b1f17b1804b1-4a18e4a5244mr33306585e9.8.1791548155882; 
 Fri, 09 Oct 2026 05:15:55 -0700 (PDT)
X-Received: by 2002:a05:600c:5489:b0:4a0:1c94:7042 with SMTP id
 5b1f17b1804b1-4a18e4a5244mr33306275e9.8.1791548155506; 
 Fri, 09 Oct 2026 05:15:55 -0700 (PDT)
Received: from x1.redhat.com ([151.41.232.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e4018sm3687140f8f.11.2026.10.09.05.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 05:15:53 -0700 (PDT)
From: Gustavo Romero <gromero@redhat.com>
To: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/virt: Use TAG_GRANULE when creating tag memory
Date: Fri,  9 Oct 2026 14:15:45 +0200
Message-ID: <20261009121545.241772-1-gromero@redhat.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use TAG_GRANULE definition when creating the memory region where the
FEAT_MTE tags are stored.

Signed-off-by: Gustavo Romero <gromero@redhat.com>
---
 hw/arm/virt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9d192515d8..0d56197dac 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2308,8 +2308,10 @@ static void create_tag_ram(MemoryRegion *tag_sysmem,
 {
     MemoryRegion *tagram = g_new(MemoryRegion, 1);
 
-    memory_region_init_ram(tagram, NULL, name, size / 32, &error_fatal);
-    memory_region_add_subregion(tag_sysmem, base / 32, tagram);
+    /* We store 2 granules in 1 byte. */
+    memory_region_init_ram(tagram, NULL, name, size / (2 * TAG_GRANULE),
+                           &error_fatal);
+    memory_region_add_subregion(tag_sysmem, base / (2 * TAG_GRANULE), tagram);
 }
 
 static void create_secure_ram(VirtMachineState *vms,
-- 
2.47.3


