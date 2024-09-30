Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780FACDD1D5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 19:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMGh-0007YY-Uj; Mon, 30 Sep 2024 15:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGg-0007S7-92
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGe-00022e-IN
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:14 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UIuZLu012955;
 Mon, 30 Sep 2024 19:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=8vZzoDeG4Kcr9FpFs4fJZKz1RExKfJTK3zERs/AOiqE=; b=
 IHuIs4wyZKeV/klLV1yKDc/N9sHrXcwzqdOi+6sEYbTLQYs0mIMyURsKC4POW5Ij
 HaPU1kW7tv9pO3xrDf3eUhLc8nBgsqhET1hx3mXhzhFuKMWqLhnE1tHY4n0rCtsg
 Uf9/Zc4CkX9hbW7VBEhNV8EE8kG6LQentWrI0Y0HX8JB9mBhHXRWmMBqp7taaA2G
 ezGIwe1LlW9tKGpYqIoiNR4PtoRJL5EW9fLpmBaunXnyyIB6q5TrOq43YOcUn5/k
 BwnwR8nanbPGJb5a0M5RhphZy1YBOuOgbbgOhTAwdtsdP5zR9wFHJusARDnb7HjP
 5nQgct9lIt4NY/hNYCgKiQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9mgc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:41:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48UIWjRa012524; Mon, 30 Sep 2024 19:41:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41x8868u2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:41:07 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48UJepV6028204;
 Mon, 30 Sep 2024 19:41:06 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 41x8868thj-12; Mon, 30 Sep 2024 19:41:06 +0000
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
Subject: [PATCH V2 11/13] migration: cpr-uri option
Date: Mon, 30 Sep 2024 12:40:42 -0700
Message-Id: <1727725244-105198-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_19,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300142
X-Proofpoint-ORIG-GUID: 9Bh9KE7V43fcwDj3GhVKaUAMn6xqu10A
X-Proofpoint-GUID: 9Bh9KE7V43fcwDj3GhVKaUAMn6xqu10A
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
index 51c19ed..e886c98 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -25,6 +25,7 @@ int cpr_find_fd(const char *name, int id);
 int cpr_walk_fd(cpr_walk_fd_cb cb);
 void cpr_resave_fd(const char *name, int id, int fd);
 
+void cpr_set_cpr_uri(const char *uri);
 int cpr_state_save(Error **errp);
 int cpr_state_load(Error **errp);
 void cpr_state_close(void);
diff --git a/migration/cpr.c b/migration/cpr.c
index 7514c4e..86f66c1 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -163,6 +163,13 @@ QIOChannel *cpr_state_ioc(void)
     return qemu_file_get_ioc(cpr_state_file);
 }
 
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
index 90ab943..2c88229 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4963,6 +4963,14 @@ SRST
 
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
index 565d932..1ac6b0b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3490,6 +3490,9 @@ void qemu_init(int argc, char **argv)
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


