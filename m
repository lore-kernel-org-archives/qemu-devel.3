Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8297D374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SCw-00077W-SY; Thu, 17 Oct 2024 11:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCu-00076s-PG
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCs-00014G-V1
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBvfB024544;
 Thu, 17 Oct 2024 15:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=bOot6nKltj+7FRW7zF9v26svQIOgEmPKYklqUEF0Ey4=; b=
 aispcUppA+pezU/7Z1+lCPSfM+FHp0DtvFETLS/BsY2nAHFJiTsK9Ffm2EQHT56n
 dQ9WyXy1DiSgqzGfcrylUUMtvnfe4TNnuKCS7oHfd9CNLwTQL962Y5kTg1KR4mrF
 sxgJvufZ3kEThEHSw1+Opar98hNWyKiK1WS7s5sSw/2o+MMjc9QNJ29YGQkH+4G8
 74Vbdr7Ug/K1MPwV0vSDjzCPGZIsupoliPYs4TLp26T0y0I+YKP/2IalAnhwSGrW
 Dre6E/siRk1Z8Nwk2IUIhfiyTG0o7tmpCuzE5Gog1s8EYt9Xb1A58LE/WMyNfmD+
 6wcIXJlxEmg18gAY4+HvRA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcp9ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HEMHPD027120; Thu, 17 Oct 2024 15:14:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy6ag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:27 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgf017147;
 Thu, 17 Oct 2024 15:14:27 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-8; Thu, 17 Oct 2024 15:14:27 +0000
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
Subject: [RFC V1 07/14] monitor: chardev name
Date: Thu, 17 Oct 2024 08:14:08 -0700
Message-Id: <1729178055-207271-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=720
 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170105
X-Proofpoint-GUID: kZ9iAHODw5NBjBnGpKo35M7_3MwhBIbS
X-Proofpoint-ORIG-GUID: kZ9iAHODw5NBjBnGpKo35M7_3MwhBIbS
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

Define an accessor that returns the chardev name in monitor options.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/monitor/monitor.h |  1 +
 monitor/monitor.c         | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index c3740ec..8edfd12 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -23,6 +23,7 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
 int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_init_opts(QemuOpts *opts, Error **errp);
+int monitor_chardev_name(QemuOpts *opts, char **name, Error **errp);
 void monitor_cleanup(void);
 
 int monitor_suspend(Monitor *mon);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index db52a9c..8b356b6 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -777,6 +777,27 @@ int monitor_init_opts(QemuOpts *opts, Error **errp)
     return ret;
 }
 
+int monitor_chardev_name(QemuOpts *opts, char **namep, Error **errp)
+{
+    Visitor *v = opts_visitor_new(opts);
+    MonitorOptions *options;
+
+    visit_type_MonitorOptions(v, NULL, &options, errp);
+    visit_free(v);
+    if (!options) {
+        return -1;
+    }
+
+    if (options->chardev) {
+        *namep = g_strdup(options->chardev);
+    } else {
+        *namep = NULL;
+    }
+
+    qapi_free_MonitorOptions(options);
+    return 0;
+}
+
 QemuOptsList qemu_mon_opts = {
     .name = "mon",
     .implied_opt_name = "chardev",
-- 
1.8.3.1


