Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FCBCAC5B6
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LqS-00072n-EY; Wed, 24 Sep 2025 05:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpN-0005py-Av
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpI-00054S-5S
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+LXSYu1vPoTI2M5Dk2GrlTJk3l5n1j7O+7TuG4JzCk=;
 b=So404Bu8HyRWOWaTM4AfR29wHe3rZD9RhXiBAdT1rT+32c8HRIupa34BKpNLiaM7Kc+VlN
 YlqN8wh2zynk/6NR9KsoiG+I432uBmSEmHWtjjNH74b+RnAUv95Wz1DmCEoS6VoktXsHsL
 TIiLYnrVhSNKjEXUX1RUUVrS5DfcKgY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-tZNW-OJpPwao-feVLyTeWQ-1; Wed, 24 Sep 2025 05:30:07 -0400
X-MC-Unique: tZNW-OJpPwao-feVLyTeWQ-1
X-Mimecast-MFC-AGG-ID: tZNW-OJpPwao-feVLyTeWQ_1758706206
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b335ec149a8so34534966b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706205; x=1759311005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+LXSYu1vPoTI2M5Dk2GrlTJk3l5n1j7O+7TuG4JzCk=;
 b=JhAoiFcyA40DXaz8JsePegybxmqcxqqAtarRSWz6cCno/m7gc8QpWLWpHu3OxZjdwf
 YuMKi403a8nYSELSzCW7NHbcxTMxH3ESCPibjopskhP58ZaMRH+mBLd6tOahk/MyyohN
 uJSGinBtK5rJaJl3qKu6Gsnn7djLMkzSajPBecwvheOp73dTywdN6ON0XtgaB54UsY8t
 dl+F534naprK+kthW3So2YdqZ9flgn8m5J4lzH0B4H+XwZlmFi+rYHrMhzuESSIwMOtr
 pYJjO4TYDwkC90wt79qbpU/l2CBW8XT+KZHeBRI033Rkoyx6Fd734y14/+3myHMg+FlE
 /q4A==
X-Gm-Message-State: AOJu0YzlC6Drb1LAbesIo5VNLogyChuc3PPGoSQdsLdCGxKfJXiEQiP0
 M/ud+9MZ4VDkvG308HNlo01ArzzGzdDEh/vS7VvAdNn+mI0gERoVp+yo1m1XfrHA0RFsOlYyFHj
 80SjCHoMUQ01Qr3wtCSuSVRNIK8YT2i46Ex9rQr5n4SRP+r0ql4o7cPPsaAw3rPawCD3nUBSUfA
 P4SbonkgbMOzAsv+2XlX5RCCXrPBwEtz1USTgL/ybM
X-Gm-Gg: ASbGncuTY8qfwLZ5hAI/m2T7xHfpQuG6qReJn5rAF+nxyHgxOVfPjY8ikw1/giqhdBT
 A6bbZV2WSI+dbRa7x9tBtru9TIQT+IptpclvhtGf8WncFbMTru7cYMZD5zviMP2uFlrWne2QS0q
 3/52Ly3mwZGoAjRyXsyGPBrapkeb0bbIF8827KhOT6D1ublYbBXxk+lliyIpx27x9FrmbQfT0Dc
 fTfEZ8otZSqKrTPA32lwHXkbWnSgOYha0eWNJ6gxoLAeJV2Y+XpViLx9/LVpk0aNAnFfQOxKa04
 GD5rwIyl0s2wi1iGKq08Abi3g6IlbFkns7eAAk5Jtj544p3MTyCB2Sdgdc+95d6S/Ozt1GqBDv/
 TQlTEVzY4NNLhmtAcsb8MXRv1QrkPqKodsvXbRcWDM7jeeg==
X-Received: by 2002:a17:907:7e88:b0:b2c:fa41:c1cb with SMTP id
 a640c23a62f3a-b302ac2b4f4mr597049966b.31.1758706204977; 
 Wed, 24 Sep 2025 02:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw7yBCZpQ53lyypzzXWv658CtjB+C2D8W+j4togBI1SVOu5bWjyvlytsaYT0c3vkDdhFOaBQ==
X-Received: by 2002:a17:907:7e88:b0:b2c:fa41:c1cb with SMTP id
 a640c23a62f3a-b302ac2b4f4mr597042566b.31.1758706203688; 
 Wed, 24 Sep 2025 02:30:03 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b33411470b8sm72632866b.98.2025.09.24.02.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:30:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 25/29] vfio: Do not unparent in instance_finalize()
Date: Wed, 24 Sep 2025 11:28:45 +0200
Message-ID: <20250924092850.42047-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Children are automatically unparented so manually unparenting is
unnecessary.

Worse, automatic unparenting happens before the instance_finalize()
callback of the parent gets called, so object_unparent() calls in
the callback will refer to objects that are already unparented, which
is semantically incorrect.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250924-use-v4-6-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/pci-quirks.c | 9 +--------
 hw/vfio/region.c     | 3 ---
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index c97606dbf19..b5da6afbf5b 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1159,15 +1159,12 @@ void vfio_vga_quirk_exit(VFIOPCIDevice *vdev)
 
 void vfio_vga_quirk_finalize(VFIOPCIDevice *vdev)
 {
-    int i, j;
+    int i;
 
     for (i = 0; i < ARRAY_SIZE(vdev->vga->region); i++) {
         while (!QLIST_EMPTY(&vdev->vga->region[i].quirks)) {
             VFIOQuirk *quirk = QLIST_FIRST(&vdev->vga->region[i].quirks);
             QLIST_REMOVE(quirk, next);
-            for (j = 0; j < quirk->nr_mem; j++) {
-                object_unparent(OBJECT(&quirk->mem[j]));
-            }
             g_free(quirk->mem);
             g_free(quirk->data);
             g_free(quirk);
@@ -1207,14 +1204,10 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
 void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr)
 {
     VFIOBAR *bar = &vdev->bars[nr];
-    int i;
 
     while (!QLIST_EMPTY(&bar->quirks)) {
         VFIOQuirk *quirk = QLIST_FIRST(&bar->quirks);
         QLIST_REMOVE(quirk, next);
-        for (i = 0; i < quirk->nr_mem; i++) {
-            object_unparent(OBJECT(&quirk->mem[i]));
-        }
         g_free(quirk->mem);
         g_free(quirk->data);
         g_free(quirk);
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index d04c57db630..b165ab0b937 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -365,12 +365,9 @@ void vfio_region_finalize(VFIORegion *region)
     for (i = 0; i < region->nr_mmaps; i++) {
         if (region->mmaps[i].mmap) {
             munmap(region->mmaps[i].mmap, region->mmaps[i].size);
-            object_unparent(OBJECT(&region->mmaps[i].mem));
         }
     }
 
-    object_unparent(OBJECT(region->mem));
-
     g_free(region->mem);
     g_free(region->mmaps);
 
-- 
2.51.0


