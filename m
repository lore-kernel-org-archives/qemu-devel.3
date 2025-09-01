Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A23BCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usxmA-00019b-5h; Mon, 01 Sep 2025 02:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usxlb-0000mb-OR; Mon, 01 Sep 2025 02:11:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usxlU-0002Yt-I8; Mon, 01 Sep 2025 02:11:47 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5816ACAb076640
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 1 Sep 2025 15:10:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Ku5gTVgI2eFOcSa5Fx00WOVlDLfLzBXwYcYASIz2wj0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1756707027; v=1;
 b=Z6Bcu1P7d+ZrM03RcSjRgid/vQE1l/yJ7pBdCfGJDAaRxt+87XZzhaaSDk0y9iJF
 RD7lAX1xp3J5sbjc5oxIyTdb3OYXgf4mXkVHbdeSSo4a8FEZVizdoyJm/Qnubi4N
 DLqt3fqsRIKakUdNZjn1mZ0EWFn9FxipBHeEEJKmaYiVKFTQavZnLZKcR9pekSEi
 mFjIV5S+cv/FJDO+d2eDoujDLpmXQuLZWCA/lBrbZMcH2xAs5SyxTFEJx8N9l4LR
 Y/nmt/SkdBcvYijb7eKMMD4twZsqoRTTSJjI0lupCODfkjiCcQl2Q2PHGWgBWas9
 pxvtpIF42WR+92kikHEQOg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 01 Sep 2025 15:10:05 +0900
Subject: [PATCH 07/16] cmd646: Do not delete the subregions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mr-v1-7-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
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

It is no longer necessary.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/ide/cmd646.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 2a59516a9ddbc0a7d40400f521b9cef07006b76a..ea4d501c5e40b0f7f5fcd5c025c113d97d89f5b7 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -302,17 +302,6 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
     }
 }
 
-static void pci_cmd646_ide_exitfn(PCIDevice *dev)
-{
-    PCIIDEState *d = PCI_IDE(dev);
-    unsigned i;
-
-    for (i = 0; i < 2; ++i) {
-        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].extra_io);
-        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].addr_ioport);
-    }
-}
-
 static const Property cmd646_ide_properties[] = {
     DEFINE_PROP_UINT32("secondary", PCIIDEState, secondary, 0),
 };
@@ -325,7 +314,6 @@ static void cmd646_ide_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, cmd646_reset);
     dc->vmsd = &vmstate_ide_pci;
     k->realize = pci_cmd646_ide_realize;
-    k->exit = pci_cmd646_ide_exitfn;
     k->vendor_id = PCI_VENDOR_ID_CMD;
     k->device_id = PCI_DEVICE_ID_CMD_646;
     k->revision = 0x07;

-- 
2.51.0


