Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705AEC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 01:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyJMS-0001K1-Ok; Sun, 23 Aug 2026 21:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wyJMO-0001Hm-8m; Sun, 23 Aug 2026 21:20:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wyJMG-0003To-Q7; Sun, 23 Aug 2026 21:20:21 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67NKeTTk080588; Mon, 24 Aug 2026 01:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=rUdN0
 aeKDSMQqE11yR1hJ7bU2ydRSC3JxdFwpQzV/nk=; b=NCFIEJvt2ZBHnB8T0AxWy
 ZOXACdKzmXfuTtW7FEFMm2K/ZuyzrInrJZtGHsH7ihoGH993WKuow1razVzq4Wr4
 GdZMQTv2ZU8JMNoYeLOzc2HCz1aTyKLjGSFmJtmYYWpLXxSOO7JfYRAbGlVIBNAo
 0+HgW2Yf6X/lVDZLclcGl+JazsEtnaPCAkhTcS7/iVtjnA/5HAqh/c1AcS3Y7lko
 +PKjIk3G3d6qbxEHZZuMzIbznhEIPfyIFDHUSmTAgk0RJvRKuN4qWwp2Ago+JpDl
 H7Jsta9rkcevTSxQaqoC3UYr1LTLI14RrQ7uqm798paKocIlh1TfjjKFeCcZVx/7
 w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g72p9sd8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 01:19:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67O1FUex013276; Mon, 24 Aug 2026 01:19:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4g84kh6xkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 01:19:54 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67O1JmVt024683;
 Mon, 24 Aug 2026 01:19:54 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4g84kh6xgy-3; Mon, 24 Aug 2026 01:19:54 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@mailo.com, aurelien@aurel32.net, mjrosato@linux.ibm.com,
 alifm@linux.ibm.com, farman@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, clg@redhat.com, akrowiak@linux.ibm.com,
 jjherne@linux.ibm.com, sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, joe.jin@oracle.com
Subject: [PATCH 2/8] qdev: hotplug: Add force_unplug handler callback
Date: Sun, 23 Aug 2026 18:13:32 -0700
Message-ID: <20260824011420.752806-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260824011420.752806-1-dongli.zhang@oracle.com>
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_01,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608240009
X-Proofpoint-ORIG-GUID: G6ZUnmDnatOdqyyPUSBLTMwgv6ngryTY
X-Authority-Analysis: v=2.4 cv=EqfiaycA c=1 sm=1 tr=0 ts=6a8b9c3c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=R0-9NCqHhopK7IinchQA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: G6ZUnmDnatOdqyyPUSBLTMwgv6ngryTY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDAwOSBTYWx0ZWRfXxWgLRDFowCsU
 5e+mNH+Ar5z8qIYae8wTu+DgxKud9tTIHDzx9xOtBiNas0QiqJSgvtZzng1XokCXEUwPevvItpS
 K15PQn51jTzyad8GpI1IKHED71M/ZeFSv+jrrATnaDM2jPU9u1Ah54zHBhbApL7cEwKjuyvBn6E
 K2ZZUaVNyfYte5gyB6dUGYpG+CoHNBn071ncpSUkZFtQCduuiObJwyUrhizr6a7PTB0XyR/DL3H
 nS/diGOxLEDmdx7RJ9h3VBnI3bQAneooxjI1SXLFgR8O8SdHCP5fVu69LyrSls07OCp4bihD5gy
 QEzQjCyPwAynUB1TSuLXGsLCrx5wRKrUI9CR3Px39+5h3sy3KrVed6E7ECr2DCSv9CWzvAi8j9g
 0/cK1B07edIJHRDcz7b3/Lg2wqo9h930FRrCNKUt7Uusf3x3+iFb6R45W/chExfJdnUk57y1yjR
 tfOhubkfOiUMtv+GNcp6gCZ4CWxKtQtxiP2IoMBU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDAwOSBTYWx0ZWRfXwd+CFlCS9IfR
 8VEsTphbiUSSvdZcRBkpKBOm9QlsVre4/GuUwmpUFQGlHeoPCXtj7lqH35E6Ca9CP+cRvz4DASN
 0F1r2h/E3xz7o8pAfFRkpEnKv5rnZihU+DSLydPiOvnYvvHfZZZJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a HotplugHandlerClass force_unplug callback and a wrapper used by the
generic qdev unplug path.

When qdev_unplug() is called with force=true, delegate to the hotplug
controller if it implements force_unplug. Controllers without the callback
return a normal error. This makes forced removal available only for
controllers that explicitly implement the operation.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/core/hotplug.c         | 11 +++++++++++
 include/hw/core/hotplug.h | 12 ++++++++++++
 system/qdev-monitor.c     | 10 +++++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
index 68aabad8ae..0e44d98cf7 100644
--- a/hw/core/hotplug.c
+++ b/hw/core/hotplug.c
@@ -57,6 +57,17 @@ void hotplug_handler_unplug(HotplugHandler *plug_handler,
     }
 }
 
+void hotplug_handler_force_unplug(HotplugHandler *plug_handler,
+                                  DeviceState *plugged_dev,
+                                  Error **errp)
+{
+    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+
+    if (hdc->force_unplug) {
+        hdc->force_unplug(plug_handler, plugged_dev, errp);
+    }
+}
+
 static const TypeInfo hotplug_handler_info = {
     .name          = TYPE_HOTPLUG_HANDLER,
     .parent        = TYPE_INTERFACE,
diff --git a/include/hw/core/hotplug.h b/include/hw/core/hotplug.h
index a9840ed485..300ac4fa8f 100644
--- a/include/hw/core/hotplug.h
+++ b/include/hw/core/hotplug.h
@@ -48,6 +48,8 @@ typedef void (*hotplug_fn)(HotplugHandler *plug_handler,
  * @unplug: unplug callback.
  *          Used for device removal with devices that implement
  *          asynchronous and synchronous (surprise) removal.
+ * @force_unplug: force unplug callback.
+ *                Used to complete enforced removal without guest cooperation.
  * @is_hotpluggable_bus: called to check if bus/its parent allow hotplug on bus
  */
 struct HotplugHandlerClass {
@@ -59,6 +61,7 @@ struct HotplugHandlerClass {
     hotplug_fn plug;
     hotplug_fn unplug_request;
     hotplug_fn unplug;
+    hotplug_fn force_unplug;
     bool (*is_hotpluggable_bus)(HotplugHandler *plug_handler, BusState *bus);
 };
 
@@ -96,4 +99,13 @@ void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
 void hotplug_handler_unplug(HotplugHandler *plug_handler,
                             DeviceState *plugged_dev,
                             Error **errp);
+
+/**
+ * hotplug_handler_force_unplug:
+ *
+ * Calls #HotplugHandlerClass.force_unplug callback of @plug_handler.
+ */
+void hotplug_handler_force_unplug(HotplugHandler *plug_handler,
+                                  DeviceState *plugged_dev,
+                                  Error **errp);
 #endif
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 3606a347a0..fa3cae246b 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -937,7 +937,15 @@ void qdev_unplug(DeviceState *dev, bool force, Error **errp)
     /* If device supports async unplug just request it to be done,
      * otherwise just remove it synchronously */
     hdc = HOTPLUG_HANDLER_GET_CLASS(hotplug_ctrl);
-    if (hdc->unplug_request) {
+
+    if (force) {
+        if (!hdc->force_unplug) {
+            error_setg(&local_err, "Device '%s' does not support forced unplug",
+                       dev->id ? dev->id : object_get_typename(OBJECT(dev)));
+        } else {
+            hotplug_handler_force_unplug(hotplug_ctrl, dev, &local_err);
+        }
+    } else if (hdc->unplug_request) {
         hotplug_handler_unplug_request(hotplug_ctrl, dev, &local_err);
     } else {
         hotplug_handler_unplug(hotplug_ctrl, dev, &local_err);
-- 
2.43.5


