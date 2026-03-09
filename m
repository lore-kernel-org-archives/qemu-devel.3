Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA78FCA189
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPD-0004hS-V4; Mon, 09 Mar 2026 16:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP2-0004eQ-3d
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhOy-0007hE-Cw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=judGREE7htOIbKSf0eAF2a0JvA1FKRJEdWDv/QQf948=;
 b=L7DCnXD2SFrzwBeiXdT6aXX01JkTpMQgO9ffzm2ncuUcbeTovhSUEMjeuNZEPeKveChXFe
 ioAjeD/hhFMUsO6vI2ews0lM7XXFubtLJEJazQsXDKR0Il5uzD5nLQTo+ifDSmD7JO1CMF
 HzXlO1IbSuRcs+RRlReb/+we2gZDgu4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-ANAZO8sENiySqMKll8kp0A-1; Mon, 09 Mar 2026 16:40:21 -0400
X-MC-Unique: ANAZO8sENiySqMKll8kp0A-1
X-Mimecast-MFC-AGG-ID: ANAZO8sENiySqMKll8kp0A_1773088820
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd81be6f05so1021151885a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088820; x=1773693620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=judGREE7htOIbKSf0eAF2a0JvA1FKRJEdWDv/QQf948=;
 b=eBq0ntl2phPpX0w47kfcJHarKQT8+H3IBEMMI87OcI6GTlMnhOtE+BT9zwCXT8Ez9M
 J1+mDoZyUSTRvUGhGFv3zvs1fEmSEg/9O6ZQOlsp/FM2EtYdD3YJAxGS6iCXZk71MgZT
 X5/nMeCGEM5yzI1Z7xeRyk0j9WT72TktA4ML8gkY2J0JkDVUz7z+F1ABV9OwKKkd4otG
 guYVYjdpvP09I08RE5y+q3KdGTI/KzznvLvyelVf7e4tMeraeDHoYLFvJYZGCnHZ2EiL
 uDqOSjPXVfgIylbZh/CVkmZ79MroMdEP85cuS0s4qCOqftCNUQbFHFIShEoL1nlt8qyT
 TqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088820; x=1773693620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=judGREE7htOIbKSf0eAF2a0JvA1FKRJEdWDv/QQf948=;
 b=S7HuN5dOkeGDGaweThC7JDcDgbz9WwHbpU/5CdDyGC/gXj4Vl/6LeKn4HZp9NzQzk7
 6oywqKfXp0aTc2t9OObxTAi079L050CClUhL5tK0GW5X+6Kmcrnrs4gmD0Qpf3UVyHh5
 lTcA5wEtIp47r9LBxkV/4ZXP+3kbugC2jZAQchL2hXE/xHPb08L7DCuzpqYF+S56xcsn
 0mOZzA8iJgkiI0I/1FUtQAhawFNnQ9Yj8lqb8Dgw6fwBoYIpEf6XCfO9MZMKJC+qjX5q
 Risp+MEyltGIvZjOKcOkK25Bsr0xHBHMNQv2y+kKMSMfcFSi36PMRigb39mOtn2DaCuC
 eH+Q==
X-Gm-Message-State: AOJu0Yx3/oVQH3NUOTjMOxTIIfgORG65RkjQ/o8q3ky0WSWO2Mk/4D9q
 wsfwEft/kwPm+ROcXptOR5UYTvORD5+F45rSdsYSZUTPTUcNwEn16/6ACWWZ03+VILSX4Xxc6mX
 mb9rzL1wCwzInPM2Hm2tMEK6CSfjWZQNBl4Nd8RVyLpHsf1GszFY+APaDCAMDUZLrFkNaznkEac
 YOcJ6GnVJCF/uELsVIpmfx59CTEjy52BndasZRCA==
X-Gm-Gg: ATEYQzzhUr98gCxenLd0qG9BrMC9iQQEjC3VXuCk4Y4pVGtUBFz5Nu7l3Tp5jht5gOq
 +nsOSzLW2V4UGpJdFukmXKeHcqh1hOrC3Vdl5YBQKRR57N7HwLHXJsrW34MPcwtFkYkkpMcugrl
 7Fu78OJ2r3qOZnwiujgQYJPSsXQf/CruBHhHi+ojJ01Oi+eBIYJwClJSJ/nKvLI33/NpiB3Zgx/
 2DUd2k6jHAEcjE0poUj/mdeIzjUeaki1lyr3cQ37qeW1eL3/LJqEzMrfOQrsqNM0nHzUrbmiHS2
 kDaQhFdjPnLqSxmChRq0nLzXwNCcK9Tx0cMuyqXxQYfbbNcuUQqhyZGt0wAXWmEf+8vCXWRpcpP
 RRjF/rljm1AJvgqWYJI8pdA1A3uohVqy3SwIVN4ZjsdVSFW1XdOYx6exRorBBP6+6b+O1zAeskR
 /TUnT5nA==
X-Received: by 2002:a05:620a:bc1:b0:8c7:1119:2994 with SMTP id
 af79cd13be357-8cd6d4d51f6mr1573346085a.64.1773088819914; 
 Mon, 09 Mar 2026 13:40:19 -0700 (PDT)
X-Received: by 2002:a05:620a:bc1:b0:8c7:1119:2994 with SMTP id
 af79cd13be357-8cd6d4d51f6mr1573342085a.64.1773088819361; 
 Mon, 09 Mar 2026 13:40:19 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:18 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 03/18] sun4m, sun4u,
 tcx: Do not use memory_region_init_ram_nomigrate()
Date: Mon,  9 Mar 2026 16:39:52 -0400
Message-ID: <20260309204007.1709441-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Peter Xu <peterx@redhat.com>
From:  Peter Xu via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: BALATON Zoltan <balaton@eik.bme.hu>

Convert to use memory_region_init_{ram,rom} instead. This breaks
migration but these machines have no migration compatibility guarantee
and this removes most remaining usages of this nomigrate variant.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/1d0f04534af14598f5c6b8c6922e3f10d8bb18cf.1772924151.git.balaton@eik.bme.hu
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/display/tcx.c   |  3 +--
 hw/sparc/sun4m.c   | 19 +++++--------------
 hw/sparc64/sun4u.c | 10 +++-------
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 16114b9bb8..c8a4ac21ca 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -815,9 +815,8 @@ static void tcx_realizefn(DeviceState *dev, Error **errp)
     uint8_t *vram_base;
     char *fcode_filename;
 
-    memory_region_init_ram_nomigrate(&s->vram_mem, OBJECT(s), "tcx.vram",
+    memory_region_init_ram(&s->vram_mem, OBJECT(s), "tcx.vram",
                            s->vram_size * (1 + 4 + 4), &error_fatal);
-    vmstate_register_ram_global(&s->vram_mem);
     memory_region_set_log(&s->vram_mem, true, DIRTY_MEMORY_VGA);
     vram_base = memory_region_get_ram_ptr(&s->vram_mem);
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index a17bdb3692..47853e3f76 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -587,13 +587,10 @@ static void idreg_realize(DeviceState *ds, Error **errp)
     IDRegState *s = MACIO_ID_REGISTER(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
 
-    if (!memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.idreg",
-                                          sizeof(idreg_data), errp)) {
+    if (!memory_region_init_rom(&s->mem, OBJECT(ds), "sun4m.idreg",
+                                sizeof(idreg_data), errp)) {
         return;
     }
-
-    vmstate_register_ram_global(&s->mem);
-    memory_region_set_readonly(&s->mem, true);
     sysbus_init_mmio(dev, &s->mem);
 }
 
@@ -638,12 +635,9 @@ static void afx_realize(DeviceState *ds, Error **errp)
     AFXState *s = TCX_AFX(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
 
-    if (!memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.afx",
-                                          4, errp)) {
+    if (!memory_region_init_ram(&s->mem, OBJECT(ds), "sun4m.afx", 4, errp)) {
         return;
     }
-
-    vmstate_register_ram_global(&s->mem);
     sysbus_init_mmio(dev, &s->mem);
 }
 
@@ -719,13 +713,10 @@ static void prom_realize(DeviceState *ds, Error **errp)
     PROMState *s = OPENPROM(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
 
-    if (!memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4m.prom",
-                                          PROM_SIZE_MAX, errp)) {
+    if (!memory_region_init_rom(&s->prom, OBJECT(ds), "sun4m.prom",
+                                PROM_SIZE_MAX, errp)) {
         return;
     }
-
-    vmstate_register_ram_global(&s->prom);
-    memory_region_set_readonly(&s->prom, true);
     sysbus_init_mmio(dev, &s->prom);
 }
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index b8bda1eb81..2e41785b78 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -455,13 +455,10 @@ static void prom_realize(DeviceState *ds, Error **errp)
     PROMState *s = OPENPROM(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
 
-    if (!memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4u.prom",
-                                          PROM_SIZE_MAX, errp)) {
+    if (!memory_region_init_rom(&s->prom, OBJECT(ds), "sun4u.prom",
+                                PROM_SIZE_MAX, errp)) {
         return;
     }
-
-    vmstate_register_ram_global(&s->prom);
-    memory_region_set_readonly(&s->prom, true);
     sysbus_init_mmio(dev, &s->prom);
 }
 
@@ -498,9 +495,8 @@ static void ram_realize(DeviceState *dev, Error **errp)
     RamDevice *d = SUN4U_RAM(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    memory_region_init_ram_nomigrate(&d->ram, OBJECT(d), "sun4u.ram", d->size,
+    memory_region_init_ram(&d->ram, OBJECT(d), "sun4u.ram", d->size,
                            &error_fatal);
-    vmstate_register_ram_global(&d->ram);
     sysbus_init_mmio(sbd, &d->ram);
 }
 
-- 
2.50.1


