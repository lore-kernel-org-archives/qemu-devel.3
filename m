Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C3AD374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SCu-00076j-1V; Thu, 17 Oct 2024 11:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCs-00076A-Ua
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCr-000143-EP
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:30 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBoMx002190;
 Thu, 17 Oct 2024 15:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=xxGxWm2fCMgriPnvrLwmwzchcLAluagUkIOmkVXNLsU=; b=
 DsbkB1MtiEA/H/quXP1T2oYHNgC3AVtvL431UUVyFoJUJPQjme+mEBOOqlL7A/Jf
 9yizcyIqY1AYoCeQCDrJupculp9eLjRVPXDnbJT6G8OQid50ZdUfldg7GhP30mfW
 CZAJ4ntnHYsFS8v/QabC8dZnJeORxPxzkKOeLRdQcuRcrrALKicgnXcGhLck01+/
 UiUGgDku0v64L9OSOak3ZlyJxB5cyUaW1wexXfmpjRrKsNoi2mJPB8HF6heW7Ad5
 59BcbKosvyxnwmj7qmUpKkaK2uWOusK//wcpF3WrFEy2GXYiWD7nB/Za3Tkc8GeR
 uryUiJTleApK2x1g9a9+9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2ptrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HF2N3w027223; Thu, 17 Oct 2024 15:14:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy69m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:26 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgd017147;
 Thu, 17 Oct 2024 15:14:25 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-7; Thu, 17 Oct 2024 15:14:25 +0000
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
Subject: [RFC V1 06/14] vl: precreate phase
Date: Thu, 17 Oct 2024 08:14:07 -0700
Message-Id: <1729178055-207271-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: 0CFsiJWFfy87VHjHHZ1-yOJTxAzY1MQP
X-Proofpoint-ORIG-GUID: 0CFsiJWFfy87VHjHHZ1-yOJTxAzY1MQP
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

Refactor qemu_init into actions performed during the precreate phase,
and actions performed when exiting precreate.  For now, always exit
the precreate phase immediately at init time.  Future patches will add
conditions that cause QEMU to linger in the precreate phase while running
the main loop.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/vl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index d32203c..5f5e810 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -183,6 +183,7 @@ static bool list_data_dirs;
 static const char *qtest_chrdev;
 static const char *qtest_log;
 static AccelState *accel;
+static FILE *vmstate_dump_file;
 
 static int has_defaults = 1;
 static int default_audio = 1;
@@ -2731,6 +2732,8 @@ static bool qemu_machine_creation_done(Error **errp)
     return true;
 }
 
+static void qemu_exit_precreate(void);
+
 void qmp_x_exit_preconfig(Error **errp)
 {
     if (phase_check(PHASE_MACHINE_INITIALIZED)) {
@@ -2795,9 +2798,7 @@ void qemu_init(int argc, char **argv)
     QemuOptsList *olist;
     int optind;
     const char *optarg;
-    MachineClass *machine_class;
     bool userconfig = true;
-    FILE *vmstate_dump_file = NULL;
 
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
@@ -3753,6 +3754,13 @@ void qemu_init(int argc, char **argv)
         }
     }
 
+    qemu_exit_precreate();
+}
+
+static void qemu_exit_precreate(void)
+{
+    MachineClass *machine_class;
+
     suspend_mux_open();
 
     qemu_disable_default_devices();
-- 
1.8.3.1


