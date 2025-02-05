Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B6EC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 20:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfmPg-00012h-HU; Wed, 05 Feb 2025 15:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfmPW-000114-8a
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:54:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfmPT-0001My-II
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 15:54:14 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gfo17001110;
 Wed, 5 Feb 2025 20:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2023-11-20; bh=0I49BZfy
 V8uwLMoeaza2jfhxblVeGSu10ra1NaFakT0=; b=Kg7eVeUGFK1vK1JJnIu98U9V
 5HFG87zSNpfBU/agF0e9DXbkPpupmKSUbW4Sc7epdgLx3doYCVPvGmRjKj3HgWiK
 nzAdBArk39R8pk5CPf5Jimjq1MotuNTd+ItZD35qeFM1qCraoZgrEQlWAbaGgHAd
 /KFp93TwpzRtgwO3BZJon2V60Kh5ttOpgUyq4VNQRUPmA+RSPzBV2qg1mo2SRTLM
 SaRgg5cc4LNJaY+T+qW9AutMhwB9Ui8gdaWBiJ/8snhcLID8b3B2FD3w3+CqH0dd
 d8qMkAg61MmEe7TkQxCZTgRq1EgHiXDgXsKcsIMbDrmtstmOdCihcyWn8yzVOw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy87x0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 20:54:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 515K0sgM023587; Wed, 5 Feb 2025 20:54:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8gjuqd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 20:54:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 515Ks2So013844;
 Wed, 5 Feb 2025 20:54:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44j8gjuqcu-1; Wed, 05 Feb 2025 20:54:02 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] migration: use parameters.mode in cpr_state_save
Date: Wed,  5 Feb 2025 12:54:01 -0800
Message-Id: <1738788841-211843-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050159
X-Proofpoint-GUID: gDZsd-KztSCcdtgHK-QNMUCtkdZbJMIy
X-Proofpoint-ORIG-GUID: gDZsd-KztSCcdtgHK-QNMUCtkdZbJMIy
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

qmp_migrate guarantees that cpr_channel is not null for
MIG_MODE_CPR_TRANSFER when cpr_state_save is called:

    qmp_migrate()
        if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
            return;
        }
        cpr_state_save(cpr_channel)

but cpr_state_save checks for mode differently before using channel,
and Coverity cannot infer that they are equivalent in outgoing QEMU,
and warns that channel may be NULL:

    cpr_state_save(channel)
        MigMode mode = migrate_mode();
        if (mode == MIG_MODE_CPR_TRANSFER) {
            f = cpr_transfer_output(channel, errp);

To make Coverity happy, use parameters.mode in cpr_state_save.

Resolves: Coverity CID 1590980
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/cpr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/cpr.c b/migration/cpr.c
index 584b0b9..7f20bd5 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "migration/cpr.h"
+#include "migration/migration.h"
 #include "migration/misc.h"
 #include "migration/options.h"
 #include "migration/qemu-file.h"
@@ -132,7 +133,7 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
 {
     int ret;
     QEMUFile *f;
-    MigMode mode = migrate_mode();
+    MigMode mode = migrate_get_current()->parameters.mode;
 
     trace_cpr_state_save(MigMode_str(mode));
 
-- 
1.8.3.1


