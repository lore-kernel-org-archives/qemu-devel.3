Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FB0C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5hC-0001SX-EE; Tue, 21 Jul 2026 04:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm5h9-0001FW-7R; Tue, 21 Jul 2026 04:19:19 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm5h5-0001Zc-OZ; Tue, 21 Jul 2026 04:19:18 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66L8GsBo050170
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Jul 2026 17:17:33 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=KCkvLBJ8aCkGl3UnV8nuvJrHcJ4tFIcRZ/oODyRyGkA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784621853; v=1;
 b=DlhQ9n3r2fBtwhHK5SVRatUR7zcz1i0OyPi1SyVWtAj0C1kzFUjc3HBBuCZPXzD1
 BvtbK/nucm1L6ocrvMFwnZ2P3dzmirG/90z4OtUQUt7qewnmnjRgRPWaEUChK96u
 vwp2siMoDR7xfrSVJAEi9WJoa1FKj3pEbxlK0+/NDjTyqVC7O0cdlzqMM7u3Mw/o
 Ha1I+pEFJWidTZQ7wvTxQuFGjYjPJd4xcLI05cZZsEbmVx6TmOiEsd8TpE49ttNc
 mDqWSjzKqrx+UqUdr1aUCNTElJdmmB35QP2M0gQMq0HeptxBIqGtznH5vKSlYv5Q
 bfFRhGCCrV+C6VCXUBhXQg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 21 Jul 2026 17:16:55 +0900
Subject: [PATCH for-11.2 v3 05/15] hw/mem/memory-device: Use qdev_is_realized()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-qdev-v3-5-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=80CkMV8WZ5hqRVetX6Z0kr6XzMUsXkxBMrdyWT951R8=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1a8tsj9sIPxynKSfizrnWb/dpO6wSFw20C3aj3PNs+lT
 Q8+tS3qKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmEikN8N/D6kf1SeMv/yIZdob
 Wlpbpav7v9N/2Z9QI033pdMktx37wPDPRO6JcIVPuUrsKi7D/f92W/eIWGpb2Yle/RhtwHg6V5s
 bAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

DeviceState fields should be accessed through qdev helpers rather than
directly. Use qdev_is_realized() instead of reading
DeviceState::realized directly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/mem/memory-device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 9cf82b84cf44..24bebfb6b31e 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -59,7 +59,7 @@ static int memory_device_build_list(Object *obj, void *opaque)
 
     if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
         DeviceState *dev = DEVICE(obj);
-        if (dev->realized) { /* only realized memory devices matter */
+        if (qdev_is_realized(dev)) {
             *list = g_slist_insert_sorted(*list, dev, memory_device_addr_sort);
         }
     }
@@ -326,7 +326,7 @@ static int memory_device_plugged_size(Object *obj, void *opaque)
         const MemoryDeviceState *md = MEMORY_DEVICE(obj);
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
 
-        if (dev->realized && !memory_device_is_empty(md)) {
+        if (qdev_is_realized(dev) && !memory_device_is_empty(md)) {
             *size += mdc->get_plugged_size(md, &error_abort);
         }
     }

-- 
2.55.0


