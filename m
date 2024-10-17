Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CB1D374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SD6-0007Aw-Rb; Thu, 17 Oct 2024 11:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SD6-0007An-19
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SD4-000161-AU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:43 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBdwt025043;
 Thu, 17 Oct 2024 15:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=dHqvC9yA3JHZrC5YQ4nbBhN55KnyC1PMPI6TYC5Kff8=; b=
 Ur8Nmb01oGrzhQr3nhkUbtI1S21aBLVIqJE+qjM2T+Y/IwnUnFSgkT4ajTnO4+qE
 sgxAV3MDX+nV4NT4xSSqGrFC1OXOwFckpfjtCGYGIWKXHdsPPpMSxD9UNOrn2HPS
 Gv1od1+eItN8FpHdrSCEF6ZROPcFzPgIMy2ZqvrRgJ6dc/EXbSqwRHSJOwEb4M+n
 byIwkl5FKF0DhH/UB35OYxd/aXfFpxxo6J8V0wa+30ySPkq3jvdD9zVBsPcoN4Dr
 8mdrq31QAHfbn9taWLy5de2Hq5RhyUVSRaP5Bh2bOQKPj3nfnu8qTB0+sNYqUFXJ
 J2q63/rymln20kXvZdshrg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1apg25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HEYYDG027117; Thu, 17 Oct 2024 15:14:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy6f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:34 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgp017147;
 Thu, 17 Oct 2024 15:14:34 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-13; Thu, 17 Oct 2024 15:14:34 +0000
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
Subject: [RFC V1 12/14] qtest: connect in precreate
Date: Thu, 17 Oct 2024 08:14:13 -0700
Message-Id: <1729178055-207271-13-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: W6M4IeVqcy1Rn7hfg9dKg7hqC-nxz0fE
X-Proofpoint-ORIG-GUID: W6M4IeVqcy1Rn7hfg9dKg7hqC-nxz0fE
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Initialize the qtest connection and the chardev it depends on during the
precreate phase.  Handle both forms of syntax:

  -object qtest,id=<id>,chardev=<name>
  -qtest chardev:<name>

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/vl.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index a985ab8..455c693 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1816,6 +1816,19 @@ static void object_option_foreach_add(
     }
 }
 
+static void object_option_foreach(
+    bool (*type_opt_predicate)(const ObjectOption *opt),
+    void (*func)(ObjectOptions *opts))
+{
+    ObjectOption *opt, *next;
+
+    QTAILQ_FOREACH_SAFE(opt, &object_opts, next, next) {
+        if (type_opt_predicate(opt)) {
+            func(opt->opts);
+        }
+    }
+}
+
 static void object_option_add_visitor(Visitor *v)
 {
     ObjectOption *opt = g_new0(ObjectOption, 1);
@@ -2000,6 +2013,18 @@ static int monitor_add_chardev(void *opaque, QemuOpts *opts, Error **errp)
     return ret;
 }
 
+static void qtest_add_chardev(ObjectOptions *opts)
+{
+    g_autoptr(QDict) props = user_creatable_get_props(opts);
+    const char *chardev = qdict_get_str(props, "chardev");
+    chardev_add(chardev);
+}
+
+static bool option_is_qtest(const ObjectOption *opt)
+{
+    return g_str_equal(ObjectType_str(opt->opts->qom_type), "qtest");
+}
+
 static bool option_is_monitor_chardev(void *opaque, QemuOpts *opts)
 {
     return chardev_find(qemu_opts_id(opts));
@@ -2012,15 +2037,27 @@ static bool option_is_not_monitor_chardev(void *opaque, QemuOpts *opts)
 
 static void qemu_create_monitors(void)
 {
+    const char *name;
+
     qemu_opts_foreach(qemu_find_opts("mon"),
                       monitor_add_chardev, NULL, &error_fatal);
 
+    object_option_foreach(option_is_qtest, qtest_add_chardev);
+
+    if (qtest_chrdev && strstart(qtest_chrdev, "chardev:", &name)) {
+        chardev_add(g_strdup(name));
+    }
+
     qemu_opts_filter_foreach(qemu_find_opts("chardev"),
                       option_is_monitor_chardev,
                       chardev_init_func, NULL, &error_fatal);
 
     qemu_opts_foreach(qemu_find_opts("mon"),
                       mon_init_func, NULL, &error_fatal);
+
+    if (qtest_chrdev) {
+        qtest_server_init(qtest_chrdev, qtest_log, &error_fatal);
+    }
 }
 
 static void qemu_create_early_backends(void)
@@ -2098,10 +2135,6 @@ static bool object_create_late(const ObjectOption *opt)
 
 static void qemu_create_late_backends(void)
 {
-    if (qtest_chrdev) {
-        qtest_server_init(qtest_chrdev, qtest_log, &error_fatal);
-    }
-
     net_init_clients();
 
     object_option_foreach_add(object_create_late);
-- 
1.8.3.1


