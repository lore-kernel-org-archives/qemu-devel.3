Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D6FCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yqz-00052t-Qh; Wed, 01 Oct 2025 11:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqu-0004iq-OI
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqc-0006Ph-7f
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMw4m005657;
 Wed, 1 Oct 2025 15:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=2bWnxhTfby+JfYwTzPOe6ikvJvlzOf50/3Bo9FgmuXY=; b=
 XNc3XlZxn5mEyiLQJ/CyJl/R+Aee3efGkg+whIr6/Cs/IihI6RjMoqOBPU0J5rdu
 kCRJcxkMjj6EdTLGpeXsw7GJKwTt8LnlB0mK66QxaqSzALoRGMncy+S/x0FXg0pA
 d7vlUe9ykFjdt0tFESpxVqJ/HITn4wRuzUkGfHvZeBxBT+sQZCs1xnfRxmHHxEkA
 WL1xuq3kQnqxMStWZXRYp8HL69q8+4bGLubzO0ktEFLDFp8ZXFaGRM0Ov4bl/RQ5
 FluZvest1qoQroJBNviwOBuMgPIj/tROd6EWc8ELrnu50l2HWEIYNq3mYzArTSDT
 tlLk4EJbNUqODpa6Jlqo9Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmcq1ppt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591ElDI0023369; Wed, 1 Oct 2025 15:34:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:14 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCqg014790;
 Wed, 1 Oct 2025 15:34:13 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-3; Wed, 01 Oct 2025 15:34:13 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 02/19] migration: add cpr_walk_fd
Date: Wed,  1 Oct 2025 08:33:54 -0700
Message-Id: <1759332851-370353-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NiBTYWx0ZWRfX3vl/GXaMlupu
 9dncWQwvqLojkkIRC3+FmE9FQjBKdZuXQiqPHXAAdkfAqrfcU4wiAqBxAXW7aAZ7YcuHWktm1ql
 YcV7ujqnRCc+Vtq8JN5yXk+opW0iLIESdiZ5VYfERN8PD9Hbm5Wb4cdFRCIBmU6jmQSF4ab9oiP
 W/NUPJ9xFJgiys4NmeyImQypuHKtT2mG6llqINu61Zf2rahLPme6+l3+EIeuL6EeFyNFrFJVxlV
 LES+57WpalV5UEb1Os9heQgcKUB68eExoyIaqahh+bFGVArUGukX0BZzNYvso1w76RDjkrb9NRi
 GRD8ODILY3pCFE4RYvC1F4sJlQKCFifgLjfMs2bO7+7ddqmpTdEBKe9QssM8vMCrGi6YBYpYx30
 aC8SJKh5KDYza1Jux0FjUeVMMOyRBQ==
X-Proofpoint-ORIG-GUID: XKV2XlbcnsBPD8f7HnmU1-0svwqYKdEb
X-Authority-Analysis: v=2.4 cv=c7amgB9l c=1 sm=1 tr=0 ts=68dd49f7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=XbKixnoXw7dXUEClIQQA:9
X-Proofpoint-GUID: XKV2XlbcnsBPD8f7HnmU1-0svwqYKdEb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a helper to walk all CPR fd's and run a callback for each.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpr.h |  3 +++
 migration/cpr.c         | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 3fc19a7..2b074d7 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -34,6 +34,9 @@ void cpr_resave_fd(const char *name, int id, int fd);
 int cpr_open_fd(const char *path, int flags, const char *name, int id,
                 Error **errp);
 
+typedef bool (*cpr_walk_fd_cb)(int fd);
+bool cpr_walk_fd(cpr_walk_fd_cb cb);
+
 MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
 bool cpr_is_incoming(void);
diff --git a/migration/cpr.c b/migration/cpr.c
index 42ad0b0..d3e370e 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -121,6 +121,19 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
     return fd;
 }
 
+bool cpr_walk_fd(cpr_walk_fd_cb cb)
+{
+    CprFd *elem;
+
+    QLIST_FOREACH(elem, &cpr_state.fds, next) {
+        g_assert(elem->fd >= 0);
+        if (!cb(elem->fd)) {
+            return false;
+        }
+    }
+    return true;
+}
+
 /*************************************************************************/
 static const VMStateDescription vmstate_cpr_state = {
     .name = CPR_STATE,
-- 
1.8.3.1


