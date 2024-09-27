Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62E7CDD1D2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 18:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suFsf-0006FF-0O; Fri, 27 Sep 2024 14:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFsa-0006DP-H1; Fri, 27 Sep 2024 14:39:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFsY-00023x-NN; Fri, 27 Sep 2024 14:39:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RHMXPK018140;
 Fri, 27 Sep 2024 18:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :reply-to:mime-version:content-transfer-encoding; s=
 corp-2023-11-20; bh=6hrdkryTBjvcg1y4G5EzM9NS5I2Qxgtz76wtet5ugaM=; b=
 cd5SicN9SA0tZwPzP3t+OUOpok16l+0B3dvaqIfRSpnDg9pioxt3QMfDA7b+r/0j
 71T/++5298dZgdUbfBsh6os742pCD6l+aCv9kASUNkqjAIapkzfvJqt00QWC8mdn
 M0uprt6bwhMBBYd27OWEqtsLmnN2PfPiRpFq7uc4gmNc0Pn3opUI7MqDkk5VZLc+
 5hY2TZpme7T7MNQkIQIxR6UCqd47XWXsNbK/6jkipwbE8gSPeAop1HC6JcmQ+Gin
 qc/HHPqkV8tA6muZPWQe3D81LGKKJIrrKmbReAx3hYg1cRK0Ks80u35CFlKgGkf3
 FKkI2byJW3INGpNWJeDKBg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx3dxkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:39:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48RHD0xR032835; Fri, 27 Sep 2024 18:39:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41smkm8fk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:39:27 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48RIdIoV009004;
 Fri, 27 Sep 2024 18:39:27 GMT
Received: from localhost.localdomain (dhcp-10-175-14-34.vpn.oracle.com
 [10.175.14.34])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 41smkm8ff6-2; Fri, 27 Sep 2024 18:39:26 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
Cc: dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eblake@redhat.com, armbru@redhat.com,
 annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC V2 PATCH 01/11] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
Date: Fri, 27 Sep 2024 14:38:56 -0400
Message-ID: <20240927183906.1248-2-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240927183906.1248-1-annie.li@oracle.com>
References: <20240927183906.1248-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409270135
X-Proofpoint-ORIG-GUID: 8b9tLGVeq0zGq9hhQeVcPywBDasH9BZt
X-Proofpoint-GUID: 8b9tLGVeq0zGq9hhQeVcPywBDasH9BZt
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: miguel.luis@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Followng hmp/qmp commands are implemented for pressing virtual
sleep button,

hmp: system_sleep
qmp: { "execute": "system_sleep" }

These commands put the guest into suspend or other power states
depending on the power settings inside the guest.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hmp-commands.hx            | 14 ++++++++++++++
 hw/core/machine-hmp-cmds.c |  5 +++++
 hw/core/machine-qmp-cmds.c |  9 +++++++++
 include/monitor/hmp.h      |  1 +
 qapi/machine.json          | 18 ++++++++++++++++++
 qapi/pragma.json           |  1 +
 6 files changed, 48 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 06746f0afc..4c149f403f 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -639,6 +639,20 @@ SRST
   whether profiling is on or off.
 ERST
 
+    {
+        .name       = "system_sleep",
+        .args_type  = "",
+        .params     = "",
+        .help       = "send ACPI sleep event",
+        .cmd = hmp_system_sleep,
+    },
+
+SRST
+``system_sleep``
+  Push the virtual sleep button; if supported the system will enter
+  an ACPI sleep state.
+ERST
+
     {
         .name       = "system_reset",
         .args_type  = "",
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 8701f00cc7..3ee529d8d5 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -189,6 +189,11 @@ void hmp_system_reset(Monitor *mon, const QDict *qdict)
     qmp_system_reset(NULL);
 }
 
+void hmp_system_sleep(Monitor *mon, const QDict *qdict)
+{
+    qmp_system_sleep(NULL);
+}
+
 void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
 {
     qmp_system_powerdown(NULL);
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 130217da8f..770f8189ba 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -276,6 +276,15 @@ void qmp_system_reset(Error **errp)
     qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
 }
 
+void qmp_system_sleep(Error **errp)
+{
+    if (!qemu_wakeup_suspend_enabled()) {
+        error_setg(errp,
+                   "suspend from running is not supported by this guest");
+        return;
+    }
+}
+
 void qmp_system_powerdown(Error **errp)
 {
     qemu_system_powerdown_request();
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index ae116d9804..e543eec109 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -43,6 +43,7 @@ void hmp_quit(Monitor *mon, const QDict *qdict);
 void hmp_stop(Monitor *mon, const QDict *qdict);
 void hmp_sync_profile(Monitor *mon, const QDict *qdict);
 void hmp_system_reset(Monitor *mon, const QDict *qdict);
+void hmp_system_sleep(Monitor *mon, const QDict *qdict);
 void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
 void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
 void hmp_announce_self(Monitor *mon, const QDict *qdict);
diff --git a/qapi/machine.json b/qapi/machine.json
index d4317435e7..b32d231aa9 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -362,6 +362,24 @@
 ##
 { 'command': 'system_reset' }
 
+##
+# @system_sleep:
+#
+# Requests that a guest perform a ACPI sleep transition by pushing a virtual
+# sleep button.
+#
+# .. note:: A guest may or may not respond to this command. This command
+#        returning does not indicate that a guest has accepted the request
+#        or that it has gone to sleep.
+#
+# .. qmp-example::
+#
+# -> { "execute": "system_sleep" }
+# <- { "return": {} }
+#
+##
+{ 'command': 'system_sleep' }
+
 ##
 # @system_powerdown:
 #
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 59fbe74b8c..e2c5dcb829 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -23,6 +23,7 @@
         'set_password',
         'system_powerdown',
         'system_reset',
+        'system_sleep',
         'system_wakeup' ],
     # Commands allowed to return a non-dictionary
     'command-returns-exceptions': [
-- 
2.43.5


