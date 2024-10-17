Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325CDD374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SD1-00078q-5q; Thu, 17 Oct 2024 11:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCz-00078Z-Ry
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCy-00015S-8o
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:37 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBnqq019214;
 Thu, 17 Oct 2024 15:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=nVLfvU6z6TFVUuJXM+XTPs9gEglgTTsCo0vqv9CyJeE=; b=
 Qf4cEnW3AcNWkGZYF0+v7uWDeWOz8hDOlEwADSxDLBh1c71/anCxioNKdb86hVgI
 absQCmV8xcwEN+ggGJ9KIsusEXbF6JE8RfFinpTUFYKhVr8X0MbOl5eBqlfLNwin
 cq/lGhDEmbHVK2C+K8phj6wgpXPCG8PV5CdbU1aHemHyERMnMBbxL0437Qi9R6/z
 CFVzr7W3+DgqNFFXsMMpoJzFF8ZN701vE3B2ZnWlMbClrJUyySgxPdORpq/VDLAQ
 w2qvzm1tsuDGmK7fpR08lZ7FtWBoaBHJhqqOuY0RequAEGi82uNeXgbfq1i/tosZ
 fHVMbGVLD0QWMnWjCpQI7Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cq32v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:33 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HElkJQ027278; Thu, 17 Oct 2024 15:14:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy6du-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:33 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgn017147;
 Thu, 17 Oct 2024 15:14:32 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-12; Thu, 17 Oct 2024 15:14:32 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 11/14] monitor: connect in precreate
Date: Thu, 17 Oct 2024 08:14:12 -0700
Message-Id: <1729178055-207271-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170105
X-Proofpoint-ORIG-GUID: axZp5SQDVKM2MrM2ZumBzW2L4RUO4cKJ
X-Proofpoint-GUID: axZp5SQDVKM2MrM2ZumBzW2L4RUO4cKJ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Complete monitor connections as early as possible, prior to
qemu_create_early_backends, so the user can issue commands during the
precreate phase.

Make a list of the chardev's referenced by all monitors.  Create the
chardevs, then create the monitors.  Exclude monitor chardevs and
monitors from the later creation phases.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/vl.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 3c592b9..a985ab8 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1939,6 +1939,11 @@ static bool object_create_early(const ObjectOption *opt)
         return false;
     }
 
+    /* Reason: already created. */
+    if (g_str_equal(type, "mon")) {
+        return false;
+    }
+
     return true;
 }
 
@@ -1956,6 +1961,68 @@ static void qemu_apply_machine_options(QDict *qdict)
     }
 }
 
+typedef struct NamedElement {
+    char *name;
+    QTAILQ_ENTRY(NamedElement) next;
+} NamedElement;
+
+static QTAILQ_HEAD(, NamedElement) monitor_chardevs =
+    QTAILQ_HEAD_INITIALIZER(monitor_chardevs);
+
+static void chardev_add(const char *name)
+{
+    NamedElement *elem = g_new0(NamedElement, 1);
+
+    elem->name = g_strdup(name);
+    QTAILQ_INSERT_TAIL(&monitor_chardevs, elem, next);
+}
+
+static bool chardev_find(const char *name)
+{
+    NamedElement *elem;
+
+    QTAILQ_FOREACH(elem, &monitor_chardevs, next) {
+        if (g_str_equal(elem->name, name)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static int monitor_add_chardev(void *opaque, QemuOpts *opts, Error **errp)
+{
+    g_autofree char *chardev = NULL;
+    int ret = monitor_chardev_name(opts, &chardev, errp);
+
+    if (!ret && chardev) {
+        chardev_add(chardev);
+    }
+    return ret;
+}
+
+static bool option_is_monitor_chardev(void *opaque, QemuOpts *opts)
+{
+    return chardev_find(qemu_opts_id(opts));
+}
+
+static bool option_is_not_monitor_chardev(void *opaque, QemuOpts *opts)
+{
+    return !chardev_find(qemu_opts_id(opts));
+}
+
+static void qemu_create_monitors(void)
+{
+    qemu_opts_foreach(qemu_find_opts("mon"),
+                      monitor_add_chardev, NULL, &error_fatal);
+
+    qemu_opts_filter_foreach(qemu_find_opts("chardev"),
+                      option_is_monitor_chardev,
+                      chardev_init_func, NULL, &error_fatal);
+
+    qemu_opts_foreach(qemu_find_opts("mon"),
+                      mon_init_func, NULL, &error_fatal);
+}
+
 static void qemu_create_early_backends(void)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
@@ -1994,7 +2061,8 @@ static void qemu_create_early_backends(void)
     /* spice must initialize before chardevs (for spicevmc and spiceport) */
     qemu_spice.init();
 
-    qemu_opts_foreach(qemu_find_opts("chardev"),
+    qemu_opts_filter_foreach(qemu_find_opts("chardev"),
+                      option_is_not_monitor_chardev,
                       chardev_init_func, NULL, &error_fatal);
 
 #ifdef CONFIG_VIRTFS
@@ -2020,6 +2088,11 @@ static void qemu_create_early_backends(void)
  */
 static bool object_create_late(const ObjectOption *opt)
 {
+    /* Reason: already created. */
+    if (g_str_equal(ObjectType_str(opt->opts->qom_type), "mon")) {
+        return false;
+    }
+
     return !object_create_early(opt) && !object_create_pre_sandbox(opt);
 }
 
@@ -2045,9 +2118,6 @@ static void qemu_create_late_backends(void)
         exit(1);
     }
 
-    qemu_opts_foreach(qemu_find_opts("mon"),
-                      mon_init_func, NULL, &error_fatal);
-
     if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
         exit(1);
     if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
@@ -3730,6 +3800,9 @@ void qemu_init(int argc, char **argv)
 
     accel = configure_accelerators(argv[0]);
 
+    os_setup_signal_handling();
+    qemu_create_monitors();
+
     /*
      * QOM objects created after this point see all global and
      * compat properties.
-- 
1.8.3.1


