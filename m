Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D60ACA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbaC-0005aN-HR; Thu, 14 Aug 2025 13:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba9-0005Uy-4q
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba0-0002pG-OQ
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:40 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECgDhC028780;
 Thu, 14 Aug 2025 17:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=TEFoIPikc0HL819wjayDhp6+RMMXJYnYxFwcfyldD6M=; b=
 Uym8Gmkd+p+VfYa50V0tHRF6jvwGBIQKwMMwsu55DIf+n5/DHcwOxTuHJlNpikCb
 swSxMKIoAPRYYIOCekeEekO1PRNyOavX14UXqGVRe70dIEhAB1SDHHZVYTakuoKH
 uFM0QRI28n2iK/Kh2NN7OSXKx6hTFRZui3NwSzfwRFH5UekP3HsabJQDNE8fFo5z
 oShJwEh+UKZ1u8gYnySVFbwWeUChpTPqbt2omAzD5llU1qFsKmBBP2J3rqAHpTRm
 vKZJ0Lhn8Xo2oxE1Gy0vcRQLDtwBnz8UknlvTllKAUJtUTDJwEUCZwvKFy10K8xZ
 1NzFYV7q3qXCHroVoUyEbw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48guchayy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57EGloDs009881; Thu, 14 Aug 2025 17:17:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvskbryr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57EHGwuA038225;
 Thu, 14 Aug 2025 17:17:27 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 48dvskbrx5-3; Thu, 14 Aug 2025 17:17:27 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 2/9] migration: add cpr_walk_fd
Date: Thu, 14 Aug 2025 10:17:16 -0700
Message-Id: <1755191843-283480-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508140147
X-Authority-Analysis: v=2.4 cv=Eo/SrTcA c=1 sm=1 tr=0 ts=689e1a29 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=QEhf6t8kAlL4CJLHOQYA:9 cc=ntf
 awl=host:12069
X-Proofpoint-ORIG-GUID: WqILoSJiVpnsdwItSFkMli_snv3Plrnc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDE0OCBTYWx0ZWRfX6ohaAYeXwf3H
 y3V8cea34Q1i98qZ1/ZsEeNiiQvH4poyy8k59MTy9pU32UTl/zhKJ3DQy7wwOVvzPGUs/91Hq70
 zOFEQddR8oj3ZqGWLwo8+1pRxW42MgbSF6OMuxQN3F2KaglqwN0dXgVwbNksn8vVxSyu17v6VeP
 TeljaTy7D+TFC3fCUm1ON8SS6WyPfD1jondiKWp+Y16u0lqH2OAHfCYWz4ED2SeLWMw+flMlFO6
 woC0kJlgrIe4Kpiqk5lmJN9HLoNMCZphFZSh33y32fiOdreY9oMIV9AjhuNPioxSqFdyurheASf
 9h/8CYCn3kWATD5GiYTYxNnfiJNh5FuUyqxyj9N0KMC3yBxtGzhDv+VNTnkv2HAiIFFigyf+xug
 H47abFgLR4vEA6zYG/RsqPfduEu4SJpRPMW1zDaIvKYmdyheDdePn9ajqcGCRN850l9AR0iP
X-Proofpoint-GUID: WqILoSJiVpnsdwItSFkMli_snv3Plrnc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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
---
 include/migration/cpr.h |  3 +++
 migration/cpr.c         | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index baff57f..f4fc5ca 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -35,6 +35,9 @@ void cpr_resave_fd(const char *name, int id, int fd);
 int cpr_open_fd(const char *path, int flags, const char *name, int id,
                 Error **errp);
 
+typedef bool (*cpr_walk_fd_cb)(int fd);
+bool cpr_walk_fd(cpr_walk_fd_cb cb);
+
 MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
 bool cpr_is_incoming(void);
diff --git a/migration/cpr.c b/migration/cpr.c
index 6d01b8c..021bd6a 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -134,6 +134,19 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
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


