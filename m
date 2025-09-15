Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2747CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6FI-00015T-2G; Mon, 15 Sep 2025 06:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uy6F7-0000tn-8i; Mon, 15 Sep 2025 06:15:31 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uy6Ez-0007LJ-4J; Mon, 15 Sep 2025 06:15:28 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58FA8uMK006344
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Sep 2025 19:09:02 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TnkAVUPt94jHFzYRxW+Zo8oRA9b9oUhjR9/nHExe2Gw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1757930943; v=1;
 b=Ibq/37dbT9jDjX5vwLTDEVgbhMDdIMJYpTFdfz6bgSts0/f4l+Pj47BdXuI97qE6
 ZQqOfq7mz/cnOrcZEvoEqH14JwaeuZrJSbP47CHiM63/PmkU+7hn8l0s5ZVJJBsN
 sUqMQfXBSH0yES0YALdm4OvxLkSh0yeExYwz9ynOoSRjcO5341mSYL2fLIPFn/bf
 jKhSLOTJMfjkKPSAbCu7rlnWpTb8xA7QeFsulzhsPXgRPSi+bZFOyRBFRoQ5KZhP
 gbR+kiKu9I3Y4OP7rYKloNEa39ssOD46gqjuHJ/fl8k8P0yEmXJxc6cbS8+kYeq1
 cuRwKHq6zRCmGzHmNxk+0g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 15 Sep 2025 19:08:48 +0900
Subject: [PATCH v2 07/15] secondary-vga: Do not delete the subregions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-use-v2-7-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp>
References: <20250915-use-v2-0-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250915-use-v2-0-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp>
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
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
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
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
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

It is no longer necessary.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/vga-pci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index b81f7fd2d0fd..90b4545d3821 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -307,14 +307,6 @@ static void pci_secondary_vga_exit(PCIDevice *dev)
     VGACommonState *s = &d->vga;
 
     graphic_console_close(s->con);
-    memory_region_del_subregion(&d->mmio, &d->mrs[0]);
-    memory_region_del_subregion(&d->mmio, &d->mrs[1]);
-    if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
-        memory_region_del_subregion(&d->mmio, &d->mrs[2]);
-    }
-    if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_EDID)) {
-        memory_region_del_subregion(&d->mmio, &d->mrs[3]);
-    }
 }
 
 static void pci_secondary_vga_init(Object *obj)

-- 
2.51.0


