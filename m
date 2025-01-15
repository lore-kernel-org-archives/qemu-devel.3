Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DDAC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8da-0007Hm-6p; Wed, 15 Jan 2025 14:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dV-0007F9-KY
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dT-0005ca-LV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:05 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHtkxw001706;
 Wed, 15 Jan 2025 19:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=zzq99bu7RB6yiOZczf9GDnLg40ovrR+DcNDG7ch1gps=; b=
 Fp81si44xk1tZDlUOx/qHtYqWxtCrttWs+2dWe2HzUVSj/xDzAeQJEQkO/eHrgRO
 rrnVfIXheq35pBAS233Vh8mwoUkjgrJd6qqGz3sTn3nqys6sKsj4dTEjT79bHpcf
 mZ0CA+GqBYpEeZ6glUGbskLiIN6+lVX/s+c4uk6CJmIVM2fCXAFoKGI5gPoUH1Tc
 9/gZ/Hj34GAExdLC6tbxemQjdplm3gP0dNqXPycdtk1cvTHj3m8ipIX1/Ev/vH7Z
 i4c8GsfHSZDNNuL6W6tZgIRDJs2DCVrsde+wTYeS1wFSjPM+R9T4LewUdemkUfIh
 8CTPvK43ChGw/5i2MfHmmg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y8q2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:01:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50FHIAGw034861; Wed, 15 Jan 2025 19:00:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f39ur43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:00:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50FJ0peD016497;
 Wed, 15 Jan 2025 19:00:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 443f39uqwr-11; Wed, 15 Jan 2025 19:00:58 +0000
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
Subject: [PATCH V7 10/24] hostmem-shm: preserve for cpr
Date: Wed, 15 Jan 2025 11:00:36 -0800
Message-Id: <1736967650-129648-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150138
X-Proofpoint-ORIG-GUID: dzmljTU6tyRgBZT2BoZETQDenbPyTUnL
X-Proofpoint-GUID: dzmljTU6tyRgBZT2BoZETQDenbPyTUnL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.793,
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


