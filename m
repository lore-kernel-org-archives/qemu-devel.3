Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B15109022E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3E1e-0003af-Be; Thu, 19 Mar 2026 10:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3E1R-0003ZQ-EM
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 10:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3E1O-0003gH-Qv
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 10:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773929205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zYx6xX+RJ4Vkxi2DBkoR2SC15BdSwrIjqXs4fdFlqw=;
 b=fnL3pqIfkuZF7NjAQFTbnLAnBQUPGNSyN2vM1wauv3o0QtHNiRLnfWml0ZjC57qkAw3wS3
 UR+wC3hRqcGmfrHwm49B9yADNzXHNeHz8sfx4a/OMIlRIm2eitoqHrqC5ShcEj9AoUQ7QY
 JsQ6SAw4yw6Dc3wLbrUYjIUT9ybqKzQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-AvvLZTfXNES9h6WQv92KlQ-1; Thu, 19 Mar 2026 10:06:44 -0400
X-MC-Unique: AvvLZTfXNES9h6WQv92KlQ-1
X-Mimecast-MFC-AGG-ID: AvvLZTfXNES9h6WQv92KlQ_1773929203
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89c5976a8eeso101668456d6.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773929203; x=1774534003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zYx6xX+RJ4Vkxi2DBkoR2SC15BdSwrIjqXs4fdFlqw=;
 b=B/TXAhMmNorxvn1+T1v6Yolfc23umotC8Mefky21Tf4DuYSijxBS1GxE6hklp10jRq
 jBue42qj3ZLuuYIGU6HQilzqq/WEgibjUUW5RxNDauRmc3ROdpp4x85tyND1kyELfz6g
 1uut8NZYkTF2/JMgS0mFYf40lb5psdeU4s3muyWvDxHeMUdlpaxg3f0c2JJqpqWV4SnH
 ahNNP6QsvMPSBMyE3k95gqDfE+G2OEemnfmBqZzwVeHb2zYCHd6YaEOn3k5MfPL/+TEh
 gyjSlwZLJw0lJ7jRFjTnV5///LCY5lN2ezwkW3hPK8OyLS6EZH0rtzRR5k02YrktGt5Y
 U/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773929203; x=1774534003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5zYx6xX+RJ4Vkxi2DBkoR2SC15BdSwrIjqXs4fdFlqw=;
 b=VCH01It86SIBtoPju8R6A0tp0yZx7bY3LfZ0kz099/5ga5k5mgfveqIFQi6q2N4i90
 iFs32ILfVFTgcy99Z6sFj+BQNRVgxgWeviWAS3U0ZnTewCxWOBkMXwDyX4uk9lnPoOGG
 orRJdIOqMGO1RhdEd2bfjbos1/MvTmcPTs4Deq3owvE0NAGPS+6FzMdKdA8nd19okXme
 0xkU/nnY4dwTvsRM/0uiP0zibDgHCbAED18Y9b74RSdT4MYRutS9UN0+7r/Oyowc3nEc
 ClA5lPDT1cWXKU37Vk9zAj3LgJvy/kaYNaw+6/NYZsUHtSskLfIk9/IZ+sf4Pl2X3wf0
 tJtw==
X-Gm-Message-State: AOJu0Yzbjux7uxYKOicmPDasD6gC6b+6POWak1/jAxMpwY9Z0xd2xgdU
 6SoeiTfBYY1BXPBUxCUb1NIeRud8YboO93GG6mfum9iB4SPfGQufPCAPf4KWJ8OrnPqp/V4AmON
 y+5bbWXf9HevdkzQRUclRUO+1+fzo19b8agHRtkeOqben3iN9i/aQ7cMf/NFApUHsRBv/cPvyBS
 ADpRKVMf3ZuOqfG8DCbQR6Qg+tazs+fMYbF67+Sg==
X-Gm-Gg: ATEYQzwaePTStS/722xE8csHtR+EUM8XIuwr3I7/aeLqQet1QnR4NTGQ+3nz57Lp7cG
 gURKpyW3yfqb9hcFFEUdVTKFRWz6pFg3j05opXv19cuseZsy/qm7L5sW8pxeswYeNVNWOmKcZC8
 HlmME96Sg0CvCtRfRoipmmWPuTjApbvNsc8iEJbpI6RrnG6utTtEV399weaFzvA31ctb/7A2X49
 mC8cCfeeS4U/K1nvuSMwxYkn/TfYmgTN8tE7h6j7JcQmisrYViI3qsWlJHC31hwR69gfJjvnHNF
 C4r0QeK3utd9++wuXPj5Y18vQOypzSlPttH4pIIpQOxojyhocs/34loCEac0G3DjMbpTmm67xoY
 CyaoHKwwPC0E=
X-Received: by 2002:a05:6214:5b88:b0:89c:56bf:9638 with SMTP id
 6a1803df08f44-89c6b47f130mr118979956d6.7.1773929202782; 
 Thu, 19 Mar 2026 07:06:42 -0700 (PDT)
X-Received: by 2002:a05:6214:5b88:b0:89c:56bf:9638 with SMTP id
 6a1803df08f44-89c6b47f130mr118979186d6.7.1773929202274; 
 Thu, 19 Mar 2026 07:06:42 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ce294sm44932506d6.30.2026.03.19.07.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 07:06:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 2/2] hw/display/tcx: Init memory regions in realize
Date: Thu, 19 Mar 2026 10:06:36 -0400
Message-ID: <20260319140636.74007-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319140636.74007-1-peterx@redhat.com>
References: <20260319140636.74007-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Thomas reported test failure:

  $ export QTEST_QEMU_BINARY=./qemu-system-sparc
  $ tests/qtest/device-introspect-test -m thorough
  ...
  # Testing device 'sun-tcx'
  RAMBlock "tcx.prom" already registered, abort!
  Broken pipe
  ../../devel/qemu/tests/qtest/libqtest.c:210: kill_qemu() detected QEMU
  death from signal 6 (Aborted) (core dumped)
  Aborted (core dumped)

Issue is the qom introspect test will create yet another sun-tcx device
causing double register of the memory region.

Fix it by removing the init method and move memory region creation in
realize.

Reported-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/3b87e6d9-a027-4dcd-a995-857e16c8b2e6@redhat.com
Fixes: 653c4fa5b0 hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Link: https://lore.kernel.org/r/20260316130651.5C8735968DE@zero.eik.bme.hu
[peterx: amend commit message, fix tag, add link]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/display/tcx.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index c8a4ac21ca..ea92a48400 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -751,10 +751,15 @@ static const GraphicHwOps tcx24_ops = {
     .gfx_update = tcx24_update_display,
 };
 
-static void tcx_initfn(Object *obj)
+static void tcx_realize(DeviceState *dev, Error **errp)
 {
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    TCXState *s = TCX(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    TCXState *s = TCX(dev);
+    Object *obj = OBJECT(dev);
+    ram_addr_t vram_offset = 0;
+    int size, ret;
+    uint8_t *vram_base;
+    char *fcode_filename;
 
     memory_region_init_rom(&s->rom, obj, "tcx.prom", FCODE_MAX_ROM_SIZE,
                            &error_fatal);
@@ -804,16 +809,6 @@ static void tcx_initfn(Object *obj)
     memory_region_init_io(&s->alt, obj, &tcx_dummy_ops, s, "tcx.alt",
                           TCX_ALT_NREGS);
     sysbus_init_mmio(sbd, &s->alt);
-}
-
-static void tcx_realizefn(DeviceState *dev, Error **errp)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    TCXState *s = TCX(dev);
-    ram_addr_t vram_offset = 0;
-    int size, ret;
-    uint8_t *vram_base;
-    char *fcode_filename;
 
     memory_region_init_ram(&s->vram_mem, OBJECT(s), "tcx.vram",
                            s->vram_size * (1 + 4 + 4), &error_fatal);
@@ -887,7 +882,7 @@ static void tcx_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->realize = tcx_realizefn;
+    dc->realize = tcx_realize;
     device_class_set_legacy_reset(dc, tcx_reset);
     dc->vmsd = &vmstate_tcx;
     device_class_set_props(dc, tcx_properties);
@@ -897,7 +892,6 @@ static const TypeInfo tcx_info = {
     .name          = TYPE_TCX,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(TCXState),
-    .instance_init = tcx_initfn,
     .class_init    = tcx_class_init,
 };
 
-- 
2.50.1


