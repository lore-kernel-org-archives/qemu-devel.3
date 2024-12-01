Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F520D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 16:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHmer-0006FH-Mm; Sun, 01 Dec 2024 11:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmW7-0004dD-Pt
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:09:51 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmW5-0000LD-UM
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:09:51 -0500
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-7fccc26ad01so177048a12.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 08:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733069387; x=1733674187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SByf2eHZKOlxWkzQnWPXy8cVLatcT0KnRddCPhNAor0=;
 b=Kfvx44rxKAqUMsDhsq0umO/hCDa0O5B7Ig9tJwZjbsxhA9nYEg6OoCqsgIhIkOBnQM
 PXx0V6CRiOmPaPuA7TCFD2yzbVF+G9KegtQf8+yXHqBlcKVsGYTG+DA+gsTvN8VUTYKp
 m+h6CY6ptydiUIgFHupz9USfthszrbpgnLrAnjhv7QpHSetfrPnFT27Q5jlRyANJcT64
 Pfanapy88/V6p4pK5AcPlew8t8IBI/B+/A/8Nyut6s+4w8yXuV0ZRGWbva52sfoOPC8E
 1z9dgh2srw9ZcIooQLZy+aACwyNyQO87aIyy9LHO5fE3jzk1+M5x8jcInObymmHXavQC
 11rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069387; x=1733674187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SByf2eHZKOlxWkzQnWPXy8cVLatcT0KnRddCPhNAor0=;
 b=BpQMgnH3Js+KOEIsbF4KKXmcVihBqMgFEo5c6O9DYXTV0MZ/2ImIQKoJd6LdaHm+6E
 A/QawVdSIFguwwkHlxpT0RccKXFlGJFkbOLP4KIXEFP+y9KC/Je+DBtdeAuens0K8vix
 bLGOs9oBxGEbP4tZG7LxwqbCwr/dBlcdX/3mEUZ2eBuhJZYBKqd501b+lJF52K6J376W
 X10lLsRYREIY0TbLSXrh+w2Bdvr9ItfteeoVM3Bshkck95ea4JIRFqh8S27WDwdXMV3i
 YltQyRfK/K8XttYL9xIdJZVJ3hU2BoiLnqLp+gUkHP5gJ9YDd2gX8ucYN0XDxk6zf+rl
 VnzQ==
X-Gm-Message-State: AOJu0Yy3OuJacancPYKI3tbKc24J51VRnmaHTvlCbMr+aZ6uOh3Ppu4f
 Vpz0iZO5qKl8/GNDvCWxLK6WIH670dDLD8Y2N+c2OFXsbvPQUfepwo1KB393bLxa
X-Gm-Gg: ASbGncse3wANvOjk4UtMuuwAL/z4HlGUZqz91gQn+xgSMRiUQv/EUiZvwJ7wRgi+2bo
 6zaNEap/CtCj0LMAdRncAMrtUMIQ31IDjD/fL82im1OqBO+A09XPVqfYJOe5RvDZclnCqC9gjuT
 YgUg0/XVELYUTvDgykJKumjlRV2eDdjEZh1nS6kgDEeB9ekR45hC/DavMogoqftT6V/J//ggi5K
 2kdOqtJwnKlIGkoIRdqDjFVUfBt6GYnSSPOE3k8obdsi0nwtDOIiZ+tJAQ=
X-Google-Smtp-Source: AGHT+IH+OkOr2sr33ycUriIZJKVn7KVkQ0WJHMV29YUUAkRwqPh4c6ctFobS5hmAYVPk1kQf2Tjsmw==
X-Received: by 2002:a05:6a20:4303:b0:1e0:da2f:9dc2 with SMTP id
 adf61e73a8af0-1e0e0c033dbmr33217355637.40.1733069387587; 
 Sun, 01 Dec 2024 08:09:47 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254176f47asm6785783b3a.43.2024.12.01.08.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 08:09:47 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/8] vfio/igd: fix GTT stolen memory size calculation for gen 7
Date: Mon,  2 Dec 2024 00:09:31 +0800
Message-ID: <20241201160938.44355-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201160938.44355-1-tomitamoeko@gmail.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x542.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Dec 2024 11:18:42 -0500
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

Both intel documentation [1][2] and i915 driver shows GGMS represents
GTT stolen memory size in multiple of 1MB, not 2MB starting from gen 8.

[1] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/3rd-gen-core-desktop-vol-2-datasheet.pdf
[2] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 4047f4f071..e40e601026 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -268,7 +268,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
     ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6) {
+    if (gen > 7) {
         ggms = 1 << ggms;
     }
 
@@ -678,7 +678,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     /* Determine the size of stolen memory needed for GTT */
     ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6) {
+    if (gen > 7) {
         ggms_mb = 1 << ggms_mb;
     }
 
-- 
2.45.2


