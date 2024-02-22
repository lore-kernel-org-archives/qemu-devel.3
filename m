Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37A1C47DD9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 21:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdGvi-0000td-Dg; Thu, 22 Feb 2024 16:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdGvF-0000mh-6F
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 16:48:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdGvC-0005Po-4r
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 16:48:04 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MIRPlB001370; Thu, 22 Feb 2024 21:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=LQ9BKDqKz9A1siUplL40xH0xVuGzpE8cGQF2aiXOues=;
 b=o2bLlr9TRWJ1N4pyaflvd7OPszae7zNBF8DK8gvykI/x2dYMSTqApuy9JEDpWBY1baN+
 F4JuquewYrXgQUrsxrt8GmbYAy34uios8P6qRptJjniOqOPM8Up5AfTGPggJUxuFpC78
 cbwlZz9dnCdnzUyWHpd2Fq4hncLjp5StxCwvsCxF/vAo9jGT36lSrXIjbsTN42LrsYw1
 a9UsHwJ+LXLCPY+/atXpqteWwF63xViT+mJ05IQk5S4yFpdtvvk28gomI/f1NVKDWUjA
 PCJZMzUvF8WQ2Q7nrrt6DC/AWo5TF2+crDJDTUPtGpFn91oRNgs2jnczpxA3UxEbwcTo HQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud6105-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 21:47:57 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MKq8Hs022235; Thu, 22 Feb 2024 21:47:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8bft6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 21:47:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MLlqUD037274;
 Thu, 22 Feb 2024 21:47:56 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8bft40-4; Thu, 22 Feb 2024 21:47:56 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 3/5] util: strv_from_strList
Date: Thu, 22 Feb 2024 13:47:48 -0800
Message-Id: <1708638470-114846-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708638470-114846-1-git-send-email-steven.sistare@oracle.com>
References: <1708638470-114846-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220169
X-Proofpoint-GUID: h9Dp4syZAY47e-eFWztGFpBaySE3_VLz
X-Proofpoint-ORIG-GUID: h9Dp4syZAY47e-eFWztGFpBaySE3_VLz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/strList.h |  6 ++++++
 util/strList.c         | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/qemu/strList.h b/include/qemu/strList.h
index 0f26116..c1eb1dd 100644
--- a/include/qemu/strList.h
+++ b/include/qemu/strList.h
@@ -21,4 +21,10 @@
  */
 strList *str_split(const char *str, const char *delim);
 
+/*
+ * Produce and return a NULL-terminated array of strings from @list.
+ * The result is g_malloc'd and all strings are g_strdup'd.
+ */
+char **strv_from_strList(const strList *list);
+
 #endif
diff --git a/util/strList.c b/util/strList.c
index 7588c7c..6da6762 100644
--- a/util/strList.c
+++ b/util/strList.c
@@ -22,3 +22,17 @@ strList *str_split(const char *str, const char *delim)
 
     return res;
 }
+
+char **strv_from_strList(const strList *list)
+{
+    const strList *tail;
+    int i = 0;
+    char **argv = g_new(char *, QAPI_LIST_LENGTH(list) + 1);
+
+    for (tail = list; tail != NULL; tail = tail->next) {
+        argv[i++] = g_strdup(tail->value);
+    }
+    argv[i] = NULL;
+
+    return argv;
+}
-- 
1.8.3.1


