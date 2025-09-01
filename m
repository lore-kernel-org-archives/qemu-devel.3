Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95DBCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usxqc-0001aJ-WC; Mon, 01 Sep 2025 02:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usxq8-0000hX-Bi; Mon, 01 Sep 2025 02:16:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usxq5-0003Z5-AX; Mon, 01 Sep 2025 02:16:28 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5816ACAW076640
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 1 Sep 2025 15:10:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=mh1rQxxaQRm6volubP/55MFePhXgAS5EUt21ThmJ2tU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1756707025; v=1;
 b=hMHoFeRWDbGazxtjcsfIR+tfqmOYR7EBnchyPhrjiGRZOzf+OKyzR5s2OtcZtogX
 PFuFvrnPPdTeo4HEojkdUPEXe0hKSXQHKzBxEQ7NlZ1IXx15ghzS+y7oUH/Rhrab
 AcKQoRG92oRX21QjGuH5WxRcqybfwMOc46jhITyJC5/Iy4WC5Qgp76OY/rH1NEeO
 q3EV4S0IjYB7PhCMJ+FauowJ0QpiPUfLGObvqv6ZBaZoMtbdwDj1D8BYF0EXzshj
 BwqA7YqZuWBmFx9ZQDGt9aiuG+y09fwwkiogEI43DPdQXv/v9YC9kGRoV2HduDUq
 X+PPf9VrRUC/uaTXw9Lwvg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 01 Sep 2025 15:10:00 +0900
Subject: [PATCH 02/16] vfio/pci: Do not unparent in instance_finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mr-v1-2-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
References: <20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This reflects a recent change of: docs/devel/memory.rst

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/vfio/pci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 07257d0fa049b09fc296ac2279a6fafbdf93d277..2e909c190f86a722e1022fa7c45a96d2dde8d58e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2000,7 +2000,6 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
         vfio_region_finalize(&bar->region);
         if (bar->mr) {
             assert(bar->size);
-            object_unparent(OBJECT(bar->mr));
             g_free(bar->mr);
             bar->mr = NULL;
         }
@@ -2008,9 +2007,6 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
 
     if (vdev->vga) {
         vfio_vga_quirk_finalize(vdev);
-        for (i = 0; i < ARRAY_SIZE(vdev->vga->region); i++) {
-            object_unparent(OBJECT(&vdev->vga->region[i].mem));
-        }
         g_free(vdev->vga);
     }
 }

-- 
2.51.0


