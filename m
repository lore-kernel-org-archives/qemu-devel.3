Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABB8D374A8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SCq-000754-1Q; Thu, 17 Oct 2024 11:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCo-00074h-SF
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCm-000138-S2
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:26 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBnMM002180;
 Thu, 17 Oct 2024 15:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=frxO7ahMl8qvacRYWDcpnTuF9WMCVFPghqcWZg2FsOI=; b=
 IYOeCMu2xiW8rehMUNSZAE6MnlPjgDJHYtaE7cXkE4a77RrPMZYTVxaTKFbx4BKZ
 ITZM/NOj+xRQR334t4LZjllEUMu94zFcqK+XXE6ynNQCiZk1UOhMWj7eWrKTHcZ5
 tMVmc66RiIRJK9mteLbAzZbsct3AQ9B8xG15L+hEGr+XcJdf+DQ78decg+LHaWGs
 Fgbj+PupBLby4NKj710eO0y373DD/sqEt9xePM+vYfwjlzo9XpRjerRWEnwLbVLt
 ghOqc1tjg1sozHkIR0tvHxBE9LQidEskHC1oS8G/PqCVvm+cJjUR7d9TQ9ujjASW
 KcwBM+75MuRKB/jfPtrv6g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2ptrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HEoVhH027387; Thu, 17 Oct 2024 15:14:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy648-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:19 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgT017147;
 Thu, 17 Oct 2024 15:14:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-2; Thu, 17 Oct 2024 15:14:18 +0000
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
Subject: [RFC V1 01/14] accel: encapsulate search state
Date: Thu, 17 Oct 2024 08:14:02 -0700
Message-Id: <1729178055-207271-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: Ojdqa_dkZ128-5jHenRnV6AMNRS9KGr_
X-Proofpoint-ORIG-GUID: Ojdqa_dkZ128-5jHenRnV6AMNRS9KGr_
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

Save the state of the search for a working machine accelerator in
the new structure AccelSearch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/vl.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 7439916..8b345dd 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2304,9 +2304,14 @@ static int accelerator_set_property(void *opaque,
     return object_parse_property_opt(opaque, name, value, "accel", errp);
 }
 
+typedef struct {
+    AccelState *accel;
+    bool init_failed;
+} AccelSearch;
+
 static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
 {
-    bool *p_init_failed = opaque;
+    AccelSearch *acs = opaque;
     const char *acc = qemu_opt_get(opts, "accel");
     AccelClass *ac = accel_find(acc);
     AccelState *accel;
@@ -2340,16 +2345,17 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
         goto bad;
     }
 
+    acs->accel = accel;
     return 1;
 
 bad:
-    *p_init_failed = true;
+    acs->init_failed = true;
     return 0;
 }
 
 static void configure_accelerators(const char *progname)
 {
-    bool init_failed = false;
+    AccelSearch acs = {0};
 
     qemu_opts_foreach(qemu_find_opts("icount"),
                       do_configure_icount, NULL, &error_fatal);
@@ -2389,7 +2395,7 @@ static void configure_accelerators(const char *progname)
             if (accel_find(*tmp)) {
                 qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp, true);
             } else {
-                init_failed = true;
+                acs.init_failed = true;
                 error_report("invalid accelerator %s", *tmp);
             }
         }
@@ -2402,15 +2408,15 @@ static void configure_accelerators(const char *progname)
     }
 
     if (!qemu_opts_foreach(qemu_find_opts("accel"),
-                           do_configure_accelerator, &init_failed, &error_fatal)) {
-        if (!init_failed) {
+                           do_configure_accelerator, &acs, &error_fatal)) {
+        if (!acs.init_failed) {
             error_report("no accelerator found");
         }
         exit(1);
     }
 
-    if (init_failed && !qtest_chrdev) {
-        error_report("falling back to %s", current_accel_name());
+    if (acs.init_failed && !qtest_chrdev) {
+        error_report("falling back to %s", ACCEL_GET_CLASS(acs.accel)->name);
     }
 
     if (icount_enabled() && !tcg_enabled()) {
-- 
1.8.3.1


