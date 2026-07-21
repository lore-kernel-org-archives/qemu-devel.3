Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAA5C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5gc-0000pi-1h; Tue, 21 Jul 2026 04:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm5gZ-0000he-9D; Tue, 21 Jul 2026 04:18:43 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm5gU-0001Zm-Lu; Tue, 21 Jul 2026 04:18:42 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66L8GsBq050170
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Jul 2026 17:17:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ayV5U0AkguNWQXEJrrEujyrrGzP6cg1PsUJnuJHlcfs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784621854; v=1;
 b=i4WuNMf3paC5wVXYUgo+Mxz+vbOpwTYZYwn2GVWfHV16yDSWouTy0ss3ISLC6Nbp
 Tfo0JC197tqzDhLlQ2w+IG5bIsWTPJn7pqYNNJQIrfb11IHPFy3hsK/MMlu4jYok
 N/vRRyvtROBLOI1RFIXqfTqEAEDzk6nMAMEXoIBW367YkNlgxwe89a/YY0PAYJQc
 PXRrItVDAQwuYOi6nwv+4CQnilPz0LLWQ+DQAn1MT7hPqgXiVb8rcWnpvjNO6CIA
 O8GejFeLs60QuN5SDI6etsUiZ/8/hNnrtueZufWuT7+Dm40LuMT2hSDCekKXkwxe
 Wxj0XNkWmbaxdg+HNdNbcQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 21 Jul 2026 17:16:57 +0900
Subject: [PATCH for-11.2 v3 07/15] hw/nvram: Use qdev_is_realized()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-qdev-v3-7-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=GhEbcxfFd0c90bqsnl8dfQymBOUb4OlEMTs1trflWMU=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1a8tqjxVJEJVZeaxH7kCdw8yssq99T7qfwJP1uxxhfrw
 v4dn7euo5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCLP6hn+8O+6vWil1U0dxwWL
 bCZuY57NtKgnTGHjiYr/GrcOl71uuM/IsCxN1mvTv4cW2crsiXNjyvO/bzotuEqp4fqUQzXuU0r
 O8AAA
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
 hw/nvram/xlnx-bbram.c | 2 +-
 hw/nvram/xlnx-efuse.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index edfb592a5ec9..e336874bdef4 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -468,7 +468,7 @@ static void bbram_prop_set_drive(Object *obj, Visitor *v, const char *name,
     qdev_prop_drive.set(obj, v, name, opaque, errp);
 
     /* Fill initial data if backend is attached after realized */
-    if (dev->realized) {
+    if (qdev_is_realized(dev)) {
         bbram_bdrv_read(XLNX_BBRAM(obj), errp);
     }
 }
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 1a9650ba128d..03c9fbc0d076 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -233,7 +233,7 @@ static void efuse_prop_set_drive(Object *obj, Visitor *v, const char *name,
     qdev_prop_drive.set(obj, v, name, opaque, errp);
 
     /* Fill initial data if backend is attached after realized */
-    if (dev->realized) {
+    if (qdev_is_realized(dev)) {
         efuse_bdrv_read(XLNX_EFUSE(obj), errp);
     }
 }

-- 
2.55.0


