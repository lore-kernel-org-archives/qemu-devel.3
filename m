Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F3FC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0TH-0007WX-8N; Sun, 30 Jun 2024 15:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0TB-0007Uz-CS
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:44:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0T9-0006PH-6J
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:44:16 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJQ35x023391;
 Sun, 30 Jun 2024 19:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=9Y7ApIw+kdZCxeBA8qrFl0dOmwypQLJ9kWdBmcX/gU4=; b=
 Mlf5lsu8sWM0161zNqzzVL6DoxjjFwmhcY4Dppnov79QUJytoCUsAnPEDpaJjiAs
 I/MQH4hfNC4S38V6T1v9pRHjCRKHYtYa2QiQvcrB7RVyfsVDvcSIEwZec7J2LpFP
 4JWPcZ2OUfRMfzaU2MAEnohP/+pIz/jMTn7qphQ9kRc3VbgrIpWQTVO0rRSIShOz
 tR0kySS+ADkfDsVcxSYPGkKX67eqUlKxluBhyFUJDkobzIyiqyYPl0bgKAh1+5zu
 Lzycqd3+tHbyOX5MCS7qAuJhKk5CFxT9MdZgS0IhJGnTh6E0rxMZH6pu2rE3r3Kl
 YT2NZEdhsBIJiK7fPKhEWQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028pchg4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:44:12 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UGm6if022878; Sun, 30 Jun 2024 19:44:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4028q5gg51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:44:11 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJg4fA039161;
 Sun, 30 Jun 2024 19:44:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 4028q5gg4e-6; Sun, 30 Jun 2024 19:44:11 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 5/6] migration: cpr-uri option
Date: Sun, 30 Jun 2024 12:44:07 -0700
Message-Id: <1719776648-435073-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406300157
X-Proofpoint-GUID: JKJu6hpwTwyMDLs0z6qGVqga0ibtNx_7
X-Proofpoint-ORIG-GUID: JKJu6hpwTwyMDLs0z6qGVqga0ibtNx_7
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Define the cpr-uri QEMU command-line option to specify the URI from
which CPR vmstate is loaded for cpr-transfer mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h | 1 +
 migration/cpr.c         | 7 +++++++
 qemu-options.hx         | 8 ++++++++
 system/vl.c             | 3 +++
 4 files changed, 19 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 9aae94c..bc62493 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -22,6 +22,7 @@ int cpr_find_fd(const char *name, int id);
 int cpr_walk_fd(cpr_walk_fd_cb cb);
 void cpr_resave_fd(const char *name, int id, int fd);
 
+void cpr_set_cpr_uri(const char *uri);
 int cpr_state_save(Error **errp);
 int cpr_state_load(Error **errp);
 
diff --git a/migration/cpr.c b/migration/cpr.c
index f756c15..50c130c 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -157,6 +157,13 @@ static const VMStateDescription vmstate_cpr_state = {
 };
 /*************************************************************************/
 
+static char *cpr_uri;
+
+void cpr_set_cpr_uri(const char *uri)
+{
+    cpr_uri = g_strdup(uri);
+}
+
 int cpr_state_save(Error **errp)
 {
     int ret;
diff --git a/qemu-options.hx b/qemu-options.hx
index 595b693..a6b5253 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4776,6 +4776,14 @@ SRST
 
 ERST
 
+DEF("cpr-uri", HAS_ARG, QEMU_OPTION_cpr_uri, \
+    "-cpr-uri unix:socketpath\n",
+    QEMU_ARCH_ALL)
+SRST
+``-cpr-uri unix:socketpath``
+    URI for incoming CPR state, for the cpr-transfer migration mode.
+ERST
+
 DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
     "-incoming tcp:[host]:port[,to=maxport][,ipv4=on|off][,ipv6=on|off]\n" \
     "-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]\n" \
diff --git a/system/vl.c b/system/vl.c
index 6521ee3..32015ac 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3483,6 +3483,9 @@ void qemu_init(int argc, char **argv)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_cpr_uri:
+                cpr_set_cpr_uri(optarg);
+                break;
             case QEMU_OPTION_incoming:
                 if (!incoming) {
                     runstate_set(RUN_STATE_INMIGRATE);
-- 
1.8.3.1


