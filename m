Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D9AC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 21:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpD3J-0008TU-Ox; Mon, 03 Mar 2025 16:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpD3I-0008Sl-4t
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:10:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpD3F-0008Js-Fi
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:10:15 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523Jfh01024361;
 Mon, 3 Mar 2025 21:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=tmuIQKf+LVR9RSQKG+1LL6QxmOnH2kHU/hydALtZnBs=; b=
 aR7i1aAEJDKsKs2dSmylqS+knqQDFdbKP8s6cpVFtElnt+qtPvFkqjh1R0R58R8Z
 8ikp7qR9rHdA6OHDVCrfZ1wOJMYkx1+6o5AykZ234y4uS2wsb48YogIHQ9zwEJkw
 uQdxhnIhmBAk/SSJgqbE4vofYYeHdeTB1OaP/wdb4llceikTlGQhXrnn2Uzyr290
 OgA/7b7LZTbGUIeq55aLr9Bc6nxVe1RgYXjFsY9y8TCusIqmMRBsVKIvQX296i3B
 rKH4olbxS4f/D/cYhmUEf9hAMa9yOGbK+s2xnuBZ+h3e6eFaWKO7praUjS6XtXrh
 mhFodbxiFr7en27RTXcjOg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u81un6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 21:10:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 523JtIA6003167; Mon, 3 Mar 2025 21:10:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 453rp82q0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 21:10:06 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 523LA4Ie022708;
 Mon, 3 Mar 2025 21:10:05 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 453rp82pwh-2; Mon, 03 Mar 2025 21:10:05 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 1/6] qom: qom_resolve_path
Date: Mon,  3 Mar 2025 13:09:57 -0800
Message-Id: <1741036202-265696-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_10,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030163
X-Proofpoint-GUID: _lIchtoz_8ETXjmwG9RPp0EzLHHMmwvk
X-Proofpoint-ORIG-GUID: _lIchtoz_8ETXjmwG9RPp0EzLHHMmwvk
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
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

Factor out a helper to resolve the user's path and print error messages.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 qom/qom-qmp-cmds.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index e866547..293755f 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -28,15 +28,11 @@
 #include "qom/object_interfaces.h"
 #include "qom/qom-qobject.h"
 
-ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
+static Object *qom_resolve_path(const char *path, Error **errp)
 {
-    Object *obj;
     bool ambiguous = false;
-    ObjectPropertyInfoList *props = NULL;
-    ObjectProperty *prop;
-    ObjectPropertyIterator iter;
+    Object *obj = object_resolve_path(path, &ambiguous);
 
-    obj = object_resolve_path(path, &ambiguous);
     if (obj == NULL) {
         if (ambiguous) {
             error_setg(errp, "Path '%s' is ambiguous", path);
@@ -44,6 +40,19 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
             error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                       "Device '%s' not found", path);
         }
+    }
+    return obj;
+}
+
+ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
+{
+    Object *obj;
+    ObjectPropertyInfoList *props = NULL;
+    ObjectProperty *prop;
+    ObjectPropertyIterator iter;
+
+    obj = qom_resolve_path(path, errp);
+    if (obj == NULL) {
         return NULL;
     }
 
-- 
1.8.3.1


