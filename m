Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD149C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sesJD-0005FG-Vz; Fri, 16 Aug 2024 04:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jianxian.Wen@verisilicon.com>)
 id 1sesJB-0004wd-IC
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:27:41 -0400
Received: from shasxm06.verisilicon.com ([101.89.135.45]
 helo=shasxm03.verisilicon.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <Jianxian.Wen@verisilicon.com>)
 id 1sesJ8-0004xY-GF
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:27:41 -0400
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=Verisilicon.com; s=default;
 c=simple/simple; t=1723795591; h=from:subject:to:date:message-id;
 bh=L8u3xfXdZg/VI0gNJmr+RntnPvuZAVg5bCED35F+jAQ=;
 b=D2DlmsFo9HBglDxazXcfQUOgnU/bCMt0bR37auckxteWbgRCH2aDNxk1nY29UMxSr7R4XnCOhD/
 nd5O+Iq6tlyCN9eYf1yp2m2ahkrNk04jNW2jiEuFx8LL6nHNpOf2LuivhtbxaAbm00bFSx/7eIFpV
 w2d8OqH7SoMUhq6iyfk=
Received: from SHASXM03.verisilicon.com ([fe80::938:4dda:a2f9:38aa]) by
 SHASXM06.verisilicon.com ([::1]) with mapi id 14.03.0408.000; Fri, 16 Aug
 2024 16:06:30 +0800
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "eduardo@habkost.net" <eduardo@habkost.net>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Lu Gao
 <Lu.Gao@verisilicon.com>
Subject: [PATCH] hmp: display qdev canonical path in 'info qtree'
Thread-Topic: [PATCH] hmp: display qdev canonical path in 'info qtree'
Thread-Index: AdrvszNLLzNpDGTOSbeF9bVsGvwcXQ==
Date: Fri, 16 Aug 2024 08:06:30 +0000
Message-ID: <4C23C17B8E87E74E906A25A3254A03F401F8166AE7@SHASXM03.verisilicon.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.166.182]
MIME-Version: 1.0
Received-SPF: pass client-ip=101.89.135.45;
 envelope-from=Jianxian.Wen@verisilicon.com; helo=shasxm03.verisilicon.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jianxian Wen <Jianxian.Wen@verisilicon.com>
From:  Jianxian Wen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It is difficult to identify a specific instance when there are multiple
instances of the same type in the output of 'info qom-tree'.
However, in 'info qtree', we can find the specific instance using
the DeviceState->id or mmio info. To facilitate locating instances
in the output of the 'info qom-tree', the canonical path is added to
the output of the 'info qtree'.

Signed-off-by: Jianxian Wen <jianxian.wen@verisilicon.com>
Signed-off-by: Lu Gao <lu.gao@verisilicon.com>
---
 system/qdev-monitor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 6af6ef7d66..22a2e2fae8 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -785,6 +785,7 @@ static void qdev_print(Monitor *mon, DeviceState *dev, =
int indent)
     ObjectClass *class;
     NamedGPIOList *ngl;
     NamedClockList *ncl;
+    g_autofree char *qom_path =3D object_get_canonical_path(OBJECT(dev));
=20
     QLIST_FOREACH(ngl, &dev->gpios, node) {
         if (ngl->num_in) {
@@ -809,6 +810,7 @@ static void qdev_print(Monitor *mon, DeviceState *dev, =
int indent)
         class =3D object_class_get_parent(class);
     } while (class !=3D object_class_by_name(TYPE_DEVICE));
     bus_print_dev(dev->parent_bus, mon, dev, indent);
+    qdev_printf("qom-path %s\n", qom_path);
 }
=20
 static void qbus_print(Monitor *mon, BusState *bus, int indent, bool detai=
ls)
--=20
2.17.1


