Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE6FFD4F09
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w00ZM-0008Fl-M4; Tue, 10 Mar 2026 13:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1w00ZG-00082E-0J
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:08:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1w00ZC-0002CM-Np
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:08:25 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A9DY2c094073; Tue, 10 Mar 2026 17:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=iFpSK
 INe6OWo+I6GSanaKOcn2So+bSbYaeDc+PnJmY4=; b=oa5Ciq31bs6w7Fy3FYJOt
 YtCBKedUW5xGu3eDCSngAiHoF2lhmKj4M6lMDgEA8o2OFZ3KxxGMbBI8XtkOFOSb
 GToG6uNiKpUVjYrWivzSEt1vse5/JoModP9fIa8Hl7OPzEFEfvStpOFgCW0w2yKq
 2wN0OeQdtOcAZt1QvrfcjMB/duy/pjd0lZue5mNL9CESnk4sNRLyNkNn+6EdibQr
 6umzKA6Pt3uwFyb+zDfrawSFuZgYY8ERYihb90CNAERfhP6znWgB1g7nHzKP8Voe
 iM6zc7SuJO85X3YziHK2pKtyb3Gs8kfORVniDZnzLFcKxwZuQDLTUGlqJZ6cxKkS
 A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmdkk99k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 17:08:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62AGVhW5014795; Tue, 10 Mar 2026 17:08:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4crafengw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 17:08:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62AH6kiK015679;
 Tue, 10 Mar 2026 17:08:18 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4crafenguc-2; Tue, 10 Mar 2026 17:08:18 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, kraxel@redhat.com,
 joe.jin@oracle.com
Subject: [PATCH v2 1/2] system/runstate: add runstate transition notifier
Date: Tue, 10 Mar 2026 10:06:16 -0700
Message-ID: <20260310170712.46336-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260310170712.46336-1-dongli.zhang@oracle.com>
References: <20260310170712.46336-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100148
X-Authority-Analysis: v=2.4 cv=MuBfKmae c=1 sm=1 tr=0 ts=69b05003 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=21ba6zvX9GSnDcFK0kkA:9 cc=ntf
 awl=host:12273
X-Proofpoint-ORIG-GUID: 2YwVAM8LCJ8Kg2jH35zZHjWEDJY1T3IH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE0OCBTYWx0ZWRfX/n9u1+zgKMYn
 zzzUoY9QoZ/E01SXVXlEPBmwT2uMwM4BSkfFBFOpwV8W2PnrCHCnHNBIRkSmug+gZ21lZZfvWrk
 LJFqRiXMSC8r6AA51LhtLhX55f11CBfZROkFXOu5DS3fRoCO/NMPr8L8QONK0U0FfjqLBfqHmkX
 gP6gS/iSaq73oqBzuB0AlnJmHGek0k6y5r7fBa2i8Kue4FZekrHmH7mVuv91F6gtLm2ZFKN4Ilc
 oPX5yYr/foRVYWHyoCyKqsAUJ4KTQXQmB3iL+0pNeDcwIS64Yqii2NkjH3RF19+GN3ICOiUAXMO
 Bnil7pyp+v3lvf2DLhBweY35pKQndhE3SHWTjBIywwVuNNzN5IlLl7Oe6mup7iqdNhu0VcsOO8W
 9jtv03C+dWe+ilKqHZmmljEqCF8RGS1TwhwpOC0E0InbPXW4wg8uO8fx0r8jeU34Hf9yOvr4FHt
 tLQ6JwCdaUIrER/yNRlq8oAevLMgcp8IrslRmqXU=
X-Proofpoint-GUID: 2YwVAM8LCJ8Kg2jH35zZHjWEDJY1T3IH
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce the notifier list that fires whenever runstate_set() changes the
runstate. Any components can register to observe the old and new runstate
values before the switch completes.

For instance, an upcoming change will use this hook to refresh the fw_cfg
'bootorder' and 'bios-geometry' entries when the instance leaves
RUN_STATE_PRELAUNCH for RUN_STATE_RUNING.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/system/runstate.h |  8 ++++++++
 system/runstate.c         | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index 929379adae..de812ec320 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -11,6 +11,14 @@ bool runstate_is_running(void);
 bool runstate_needs_reset(void);
 void runstate_replay_enable(void);
 
+typedef struct VMRunStateTransition {
+    RunState old_state;
+    RunState new_state;
+} VMRunStateTransition;
+
+void qemu_add_runstate_transition_notifier(Notifier *notifier);
+void qemu_remove_runstate_transition_notifier(Notifier *notifier);
+
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
 typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState state);
 
diff --git a/system/runstate.c b/system/runstate.c
index eca722b43c..01b76463d7 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -65,6 +65,8 @@
 
 static NotifierList exit_notifiers =
     NOTIFIER_LIST_INITIALIZER(exit_notifiers);
+static NotifierList runstate_transition_notifiers =
+    NOTIFIER_LIST_INITIALIZER(runstate_transition_notifiers);
 
 static RunState current_run_state = RUN_STATE_PRELAUNCH;
 
@@ -226,6 +228,17 @@ static void runstate_init(void)
     qemu_mutex_init(&vmstop_lock);
 }
 
+static void runstate_transition_notify(RunState old_state,
+                                       RunState new_state)
+{
+    VMRunStateTransition transition = {
+        .old_state = old_state,
+        .new_state = new_state,
+    };
+
+    notifier_list_notify(&runstate_transition_notifiers, &transition);
+}
+
 /* This function will abort() on invalid state transitions */
 void runstate_set(RunState new_state)
 {
@@ -245,6 +258,8 @@ void runstate_set(RunState new_state)
         abort();
     }
 
+    runstate_transition_notify(current_run_state, new_state);
+
     current_run_state = new_state;
 }
 
@@ -403,6 +418,16 @@ int vm_state_notify(bool running, RunState state)
     return ret;
 }
 
+void qemu_add_runstate_transition_notifier(Notifier *notifier)
+{
+    notifier_list_add(&runstate_transition_notifiers, notifier);
+}
+
+void qemu_remove_runstate_transition_notifier(Notifier *notifier)
+{
+    notifier_remove(notifier);
+}
+
 static ShutdownCause reset_requested;
 static ShutdownCause shutdown_requested;
 static int shutdown_exit_code = EXIT_SUCCESS;
-- 
2.39.3


