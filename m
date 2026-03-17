Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC383F3380B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2PRs-0005bQ-7V; Tue, 17 Mar 2026 04:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w2PRn-0005b5-UT
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w2PRk-0005Ni-Q4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773734793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z4U99hlQUgfbaLsEk4Tlb2mniZhJ236YrLd0kHtjiRY=;
 b=VyoluNJLKjl1zd19T/HZupfGntyBU4V/AagESimy7s2vHYFrsq/CZvvJ8APWQ5znYUMClp
 xQEAEhcJCvEXPwLMeyHLkCtvV6sHPISj/4hBASBw9I1ena5vFxEPm98cl/v1kSyUHBVuKI
 ScaVjJix+qZOSnfzNDIJSsdCuPgjJ5k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-ib1YRWjtPdKFxMwHx-kIew-1; Tue,
 17 Mar 2026 04:06:29 -0400
X-MC-Unique: ib1YRWjtPdKFxMwHx-kIew-1
X-Mimecast-MFC-AGG-ID: ib1YRWjtPdKFxMwHx-kIew_1773734789
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65FBC1955DB6; Tue, 17 Mar 2026 08:06:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.37])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D97A19560AB; Tue, 17 Mar 2026 08:06:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] hw/display/cg3: Fix crash when introspecting cgthree from the
 CLI
Date: Tue, 17 Mar 2026 09:06:23 +0100
Message-ID: <20260317080623.438230-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when introspecting the cgthree device from the
command line interface:

 $ ./qemu-system-sparc -device cgthree,help
 Segmentation fault (core dumped)

This happens because the memory_region_init_rom() function internally
calls qemu_ram_alloc_internal() that needs the current_machine pointer
to be set up - which is not the case here since the machine has not
been created yet.

There does not seem to be a compelling reason for initializing the
memory regions from the instance_init function, so let's simply move
the code into the realize() function instead to fix this issue.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/cg3.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 61bdb0552e9..0a413fbb7ec 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -277,10 +277,13 @@ static const GraphicHwOps cg3_ops = {
     .gfx_update = cg3_update_display,
 };
 
-static void cg3_initfn(Object *obj)
+static void cg3_realizefn(DeviceState *dev, Error **errp)
 {
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    CG3State *s = CG3(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Object *obj = OBJECT(dev);
+    CG3State *s = CG3(dev);
+    int ret;
+    char *fcode_filename;
 
     memory_region_init_rom(&s->rom, obj, "cg3.prom", FCODE_MAX_ROM_SIZE,
                            &error_fatal);
@@ -289,14 +292,6 @@ static void cg3_initfn(Object *obj)
     memory_region_init_io(&s->reg, obj, &cg3_reg_ops, s, "cg3.reg",
                           CG3_REG_SIZE);
     sysbus_init_mmio(sbd, &s->reg);
-}
-
-static void cg3_realizefn(DeviceState *dev, Error **errp)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    CG3State *s = CG3(dev);
-    int ret;
-    char *fcode_filename;
 
     /* FCode ROM */
     fcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, CG3_ROM_FILE);
@@ -381,7 +376,6 @@ static const TypeInfo cg3_info = {
     .name          = TYPE_CG3,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(CG3State),
-    .instance_init = cg3_initfn,
     .class_init    = cg3_class_init,
 };
 
-- 
2.53.0


