Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C070E7718F
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRniE-0007LW-CF; Sun, 29 Dec 2024 02:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhl-0006j9-8r
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:21 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhh-0002Ba-8B
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:16 -0500
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-aa69077b93fso1197371366b.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457231; x=1736062031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gFWsx6elcziOUVCYZBguRZxlSU/L1G/iY9+fG5LR1KA=;
 b=YPxvYOs53zsY9KbZAt6onc49+ucIZjROPJQWXyHozGN1cPl6VzkeJxn8oPUQpStTPQ
 hKIwTJoC4IUaAbo8qt1lG/GN9Wc8d+bNRR04Iu0xfchT7quu9ggYn+9Qr0vmTvQEe4/w
 gEK87gyaLuWntbuY0dcjE8QdczA/x+e811O2y832H6i5mzccOlqnLCPQ3Y+ywDnbAJ1/
 48BQ+swgJZwGU3sZVQpMNsHW82RP/4M9hCR0ab05fl4ddxlVlxlBv1NR9h0we8KhAB1K
 L1AsD7jiokGubwc0Iw1oVwUl6iNZPFFNdtMXseKW6LM6wyux/0ejaJMO79uQlX40gPFL
 9NDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7iHYHpRovObybX22DbSMpqa8DwnuvsHi/YtvuXolTT4HhLedBPQp3OTGMLbQfCaIex/VFB4OXVwz+@nongnu.org
X-Gm-Message-State: AOJu0YyA0g3+cKNDZkOno7rB664RFptuDZgsSgrvKwJKpWakUzT8tZqu
 I39qdeRWnjiUdMLj9MRohYs9y+4Rj5HFZJHpYMCjLMGI7q9rpfDf
X-Gm-Gg: ASbGncuDwQF2rPs7VWCLNTZbyKXMLAHPNU1HihxqAlHfvO5+FKQ8YwOaSpDw165tayf
 4tQnzVtlCIhJzwGDcq+m19/8nGFlVYTVaoO7SVeAUEUBlCRbowC/QzaYNfYYys2ifo3AGOwniwh
 qlIt8b6V4vZE7r0P1m3xDWNbJKRnRmDTloFudgtYMdQZDSUwERamcDal9TM2yFjeHGd2qZ+b2pE
 MX941MOxjCuUjZoGkeW+hxSMnh65wIf4itgTdj6vsdupZgUMv/8PZnOcGSXGO8kGoTP+TmqrmsH
 /9I=
X-Google-Smtp-Source: AGHT+IFuPE+U/rLxKNq1p8a/FgcCF2/nOJSJWy/xF/6Ebr/oA++QBz7YpoNPAiI//mI2v88X4nVFeQ==
X-Received: by 2002:a17:906:4fce:b0:aab:73c5:836 with SMTP id
 a640c23a62f3a-aac334c3d70mr3317532166b.32.1735457230692; 
 Sat, 28 Dec 2024 23:27:10 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:09 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 19/35] next-cube: convert next-pc device to use Resettable
 interface
Date: Sun, 29 Dec 2024 08:25:10 +0100
Message-ID: <20241229072526.166555-20-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.51; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f51.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241222130012.1013374-18-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 0cf4470ce8..091e05465e 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1009,9 +1009,9 @@ static const MemoryRegionOps next_dummy_en_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void next_pc_reset(DeviceState *dev)
+static void next_pc_reset_hold(Object *obj, ResetType type)
 {
-    NeXTPC *s = NEXT_PC(dev);
+    NeXTPC *s = NEXT_PC(obj);
 
     /* Set internal registers to initial values */
     /*     0x0000XX00 << vital bits */
@@ -1140,12 +1140,13 @@ static const VMStateDescription next_pc_vmstate = {
 static void next_pc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "NeXT Peripheral Controller";
     dc->realize = next_pc_realize;
-    device_class_set_legacy_reset(dc, next_pc_reset);
     device_class_set_props(dc, next_pc_properties);
     dc->vmsd = &next_pc_vmstate;
+    rc->phases.hold = next_pc_reset_hold;
 }
 
 static const TypeInfo next_pc_info = {
-- 
2.47.1


