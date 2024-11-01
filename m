Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A7EE6B278
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6s15-0004TN-NC; Fri, 01 Nov 2024 09:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s13-0004Mb-Gc
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s11-0002J4-KG
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:41 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1Dfgww029215;
 Fri, 1 Nov 2024 13:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=VkW1dq6TTWsU3T6/rVxk+iWHYtUQ3SfxCOyN+XDGssQ=; b=
 TGlmHrtIuFduxpSLATU+OHV+HdxoM/RlEwP5DZPv0uIl7s8KT7Nbtw3wovTZj1aJ
 Et4zecmALwh6HuzTpL6O5oLRKUFJA42T7nd8S6daUKU32NpUr739s1a/wuZwFZbx
 BUCZqO0uui/qjYLLKKmhUhO58tiCjRjKnXDPWogYP1NJ5Mv2SR20Lky/4ekUe14l
 ynekpTELoz7+5NMW1F9Tn7NOjzFM8FgbfL8QFiaIgpgMTM8k3ZjREWgiWjPKDFNM
 d2CsPVXbOW2AR9T8/4flc6zKESxy3d7VvBqeKJOotZzqg3FRTpSoPVKHSuo4BRxH
 4CyqBGamhSAEDIOsQum3Fw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxv9x0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A1CXiVD009960; Fri, 1 Nov 2024 13:48:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42hn91ptkx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1DhuOI006031;
 Fri, 1 Nov 2024 13:48:32 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 42hn91pt43-10; Fri, 01 Nov 2024 13:48:32 +0000
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
Subject: [PATCH V3 09/16] migration: cpr-uri option
Date: Fri,  1 Nov 2024 06:47:48 -0700
Message-Id: <1730468875-249970-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010100
X-Proofpoint-GUID: -c8mQU8Le5lkvJM4CYNvECXLl-8o7HUD
X-Proofpoint-ORIG-GUID: -c8mQU8Le5lkvJM4CYNvECXLl-8o7HUD
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Acked-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpr.h |  3 +++
 migration/cpr.c         | 12 ++++++++++++
 qemu-options.hx         |  8 ++++++++
 system/vl.c             |  4 ++++
 4 files changed, 27 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index ae318da..c9c291f 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -15,6 +15,9 @@ void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);
 
+void cpr_set_cpr_uri(const char *uri);
+const char *cpr_get_cpr_uri(void);
+
 int cpr_state_save(Error **errp);
 int cpr_state_load(Error **errp);
 void cpr_state_close(void);
diff --git a/migration/cpr.c b/migration/cpr.c
index be1dc92..b72d1f4 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -116,6 +116,18 @@ QIOChannel *cpr_state_ioc(void)
     return qemu_file_get_ioc(cpr_state_file);
 }
 
+static char *cpr_uri;
+
+void cpr_set_cpr_uri(const char *uri)
+{
+    cpr_uri = g_strdup(uri);
+}
+
+const char *cpr_get_cpr_uri(void)
+{
+    return cpr_uri;
+}
+
 int cpr_state_save(Error **errp)
 {
     int ret;
diff --git a/qemu-options.hx b/qemu-options.hx
index fdd6bf2..89bbc9f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4922,6 +4922,14 @@ SRST
 
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
index df26264..5d08fade 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -77,6 +77,7 @@
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
+#include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
 #include "sysemu/tpm.h"
@@ -3479,6 +3480,9 @@ void qemu_init(int argc, char **argv)
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


