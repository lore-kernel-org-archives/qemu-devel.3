Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6770CC5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 01:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyJMS-0001J5-8n; Sun, 23 Aug 2026 21:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wyJMO-0001Hn-AB; Sun, 23 Aug 2026 21:20:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wyJMJ-0003VX-FL; Sun, 23 Aug 2026 21:20:21 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67NNGJJp129681; Mon, 24 Aug 2026 01:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=o1MVW
 yxP3jMV2LjBZ5MFVpAxRVDRz0Duhs68xTBpXHQ=; b=J34IT8lY11ReMNdj8nfV8
 twCPp2ctcv+ehSDUl4DjBCA6u8hLI7PU++mpmzahIeZZmguU+qlfBJTF8Kzaq0me
 nxNQnivcq7r3eAX/OORaK34CwLSlZuqcwd5b3Cp+9OqFFZ8+CmU0ZfgBPmat25aa
 KWn/m1Vd7aGwDPcKYAnF0oQJdh0TcZO7mFmSji/18THmvLVNO5lk1BCaeM6fTqL2
 1BHXO1jAu06BSI56mAUlzw/lVtkDSELIz/kUNKfkDnc2BpMrg/COOuh51YNzDsb8
 5pwPX+rTs/OPA25hBf5J0krnTf9aWJDTETmiWNiFLVUZEkqi7vZgQ5N6GLPweb2+
 w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g73n79bqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 01:19:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67O1FUMx013225; Mon, 24 Aug 2026 01:19:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4g84kh6xmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 01:19:57 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67O1JmVv024683;
 Mon, 24 Aug 2026 01:19:57 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4g84kh6xgy-4; Mon, 24 Aug 2026 01:19:57 +0000 (GMT)
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
Subject: [PATCH 3/8] qdev: Support forced device_del in QMP and HMP
Date: Sun, 23 Aug 2026 18:13:33 -0700
Message-ID: <20260824011420.752806-4-dongli.zhang@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDAwOSBTYWx0ZWRfX1V1IPWwVdfcS
 eXs0te3xFWOXdO6BoZvxCXT4GQCSBT5R7F0d4BADl7L3lUHuOr3RTWRzkbth0unfBU5m53HmZI0
 dkfqdGo78ppGi3v5PMed89Nele1DU6zhW2N/4ok48vOY5mDIx2WmQZno8d/cliY8/xKywCLPuGt
 8pGIPioXNu4/XB2iw/zjQPnCS2HHo0MhBZ4V4dxfWN6xVWhUxi8jo6MLKZvsIBw6RR/E0Mnpy7P
 QdHaI2AqIcfM9p0WcgmJvFi81Eq9WUUEYwngL4LUdCQo/hCC8FTAyRys8VxQeaDNGt+k3jkcRm/
 EHNlHNzvsMpocACMEN5tgoZcG6IblPP92/zYXjIoI34yATnASWGDK3hrqqlqMZNd6cILEoC8mRk
 rXG8Re+Fjq1EnAfYiId8nEtfSB1Mdj4u7CJTprtMlC2RUcJnLuqsHh255y4ODTDJun9O7yh+DMR
 YoeP6J8/sUmKpvM49GZxfDeLGTjJf0L0aLRQ59Eo=
X-Proofpoint-ORIG-GUID: 7H4XMNOBu3TKzfSJd7HuTZ9YSddM9Gng
X-Authority-Analysis: v=2.4 cv=Os9/DS/t c=1 sm=1 tr=0 ts=6a8b9c3f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=VK-ukoX-n8eK6wX5QKAA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDAwOSBTYWx0ZWRfX4rgmhFCdIY8n
 y/gjdQdOF3Gaw9tA7jadsiTfFTbwMzSeg/I1l8qb8sSzCVzEhJQQTzTPOEGO8c4SycTXhsyE+Gb
 YGJe5qwQxtOC3ezaxm6/32s5tFE7hopLJW2pmrpbWR5T1f6XZE8c
X-Proofpoint-GUID: 7H4XMNOBu3TKzfSJd7HuTZ9YSddM9Gng
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

Add an optional force argument to the QMP device_del command and expose it
in HMP as "device_del -f".

When force is requested, qdev_unplug() bypasses the pending deletion guard
and asks the selected hotplug controller to complete removal through its
force_unplug callback. Controllers that do not implement the callback
reject the operation.

Forced removal bypasses guest cooperation.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hmp-commands.hx       | 11 ++++++-----
 qapi/qdev.json        | 11 +++++++++--
 system/qdev-monitor.c | 11 +++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 43ff220b5f..022502b20f 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -708,17 +708,18 @@ ERST
 
     {
         .name       = "device_del",
-        .args_type  = "id:s",
-        .params     = "device",
-        .help       = "remove device",
+        .args_type  = "force:-f,id:s",
+        .params     = "[-f] device",
+        .help       = "remove device, use -f to force removal",
         .cmd        = hmp_device_del,
         .command_completion = device_del_completion,
     },
 
 SRST
-``device_del`` *id*
+``device_del`` [*-f*] *id*
   Remove device *id*. *id* may be a short ID
-  or a QOM object path.
+  or a QOM object path.  Use -f to force removal without waiting for
+  guest cooperation.
 ERST
 
     {
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 974cf9c583..cb5b5ad1db 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -90,6 +90,11 @@
 #
 # @id: the device's ID or QOM path
 #
+# @force: if true, remove the device without waiting for guest
+#     cooperation.  The guest may still be using the device.  This can
+#     cause guest-visible errors, I/O failures, or guest crashes.
+#     (since 11.2)
+#
 # Errors:
 #     - If @id is not a valid device, DeviceNotFound
 #
@@ -101,7 +106,9 @@
 #    will automatically complete removal for all devices.  If a
 #    guest-side error in the hot removal process is detected, the
 #    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR`
-#    event is sent.  Some errors cannot be detected.
+#    event is sent.  Some errors cannot be detected.  If @force is
+#    true, guest cooperation is bypassed, but backend cleanup is still
+#    performed through the device's normal unrealize path.
 #
 # Since: 0.14
 #
@@ -117,7 +124,7 @@
 #          "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
 #     <- { "return": {} }
 ##
-{ 'command': 'device_del', 'data': {'id': 'str'} }
+{ 'command': 'device_del', 'data': {'id': 'str', '*force': 'bool'} }
 
 ##
 # @DEVICE_DELETED:
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index fa3cae246b..ca10a25c46 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -956,11 +956,13 @@ void qdev_unplug(DeviceState *dev, bool force, Error **errp)
     error_propagate(errp, local_err);
 }
 
-void qmp_device_del(const char *id, Error **errp)
+void qmp_device_del(const char *id, bool has_force, bool force, Error **errp)
 {
     DeviceState *dev = find_device_state(id, false, errp);
+    bool do_force = has_force && force;
+
     if (dev != NULL) {
-        if (dev->pending_deleted_event &&
+        if (!do_force && dev->pending_deleted_event &&
             (dev->pending_deleted_expires_ms == 0 ||
              dev->pending_deleted_expires_ms > qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL))) {
             error_setg(errp, "Device %s is already in the "
@@ -968,7 +970,7 @@ void qmp_device_del(const char *id, Error **errp)
             return;
         }
 
-        qdev_unplug(dev, false, errp);
+        qdev_unplug(dev, do_force, errp);
     }
 }
 
@@ -1046,9 +1048,10 @@ out:
 void hmp_device_del(Monitor *mon, const QDict *qdict)
 {
     const char *id = qdict_get_str(qdict, "id");
+    bool force = qdict_get_try_bool(qdict, "force", false);
     Error *err = NULL;
 
-    qmp_device_del(id, &err);
+    qmp_device_del(id, true, force, &err);
     hmp_handle_error(mon, err);
 }
 
-- 
2.43.5


