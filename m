Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4015FE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7b4-000378-PI; Tue, 24 Dec 2024 11:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7b1-00033k-MN
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7ay-0003AU-Od
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:23 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOEfeYc020806;
 Tue, 24 Dec 2024 16:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=zzq99bu7RB6yiOZczf9GDnLg40ovrR+DcNDG7ch1gps=; b=
 L2Q/5mqGclfINoJg+SszvojXv1Oh1nJgIS6DDn3A4ZfEdYS0oCDP473JKDtljttz
 9mDVPQTnNqyqYJkhnYQz3+6Rr3CT9e8MX2iSgG7FnOSb6Fb03uaWBPGbMswvrmq0
 5A6LSpOaOD/SCqT1SDVabHkgDXqYNLcNN8/CQ6sMFA+FWUBB23YQBlTLlBScQg16
 QbR7gPKodxsuWS5bJ8kEpZKvORb2c4cocgkPkMvdLEjkmY0CNmtBQ5qwJHhkah50
 SkX0FAvuQcLilU3QGyNUcLQH8jjHrvHFJ1uym7LhuT04eAXcmymLhRrNJTQF/ZcX
 IRDoWt8d8WiDCN9QAmUsaw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq7c4f0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BOFK8J2022620; Tue, 24 Dec 2024 16:17:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43nm484gkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BOGH9XY021973;
 Tue, 24 Dec 2024 16:17:15 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 43nm484ggj-10; Tue, 24 Dec 2024 16:17:15 +0000
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
Subject: [PATCH V5 09/23] hostmem-shm: preserve for cpr
Date: Tue, 24 Dec 2024 08:16:54 -0800
Message-Id: <1735057028-308595-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412240141
X-Proofpoint-GUID: jqT08U0RbAYQZvx_nQ10wN36jwJ07E3P
X-Proofpoint-ORIG-GUID: jqT08U0RbAYQZvx_nQ10wN36jwJ07E3P
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

Preserve memory-backend-shm memory objects during cpr-transfer.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 backends/hostmem-shm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index fabee41..f67ad27 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "system/hostmem.h"
 #include "qapi/error.h"
+#include "migration/cpr.h"
 
 #define TYPE_MEMORY_BACKEND_SHM "memory-backend-shm"
 
@@ -25,9 +26,9 @@ struct HostMemoryBackendShm {
 static bool
 shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
-    g_autofree char *backend_name = NULL;
+    g_autofree char *backend_name = host_memory_backend_get_name(backend);
     uint32_t ram_flags;
-    int fd;
+    int fd = cpr_find_fd(backend_name, 0);
 
     if (!backend->size) {
         error_setg(errp, "can't create shm backend with size 0");
@@ -39,13 +40,18 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return false;
     }
 
+    if (fd >= 0) {
+        goto have_fd;
+    }
+
     fd = qemu_shm_alloc(backend->size, errp);
     if (fd < 0) {
         return false;
     }
+    cpr_save_fd(backend_name, 0, fd);
 
+have_fd:
     /* Let's do the same as memory-backend-ram,share=on would do. */
-    backend_name = host_memory_backend_get_name(backend);
     ram_flags = RAM_SHARED;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
 
-- 
1.8.3.1


