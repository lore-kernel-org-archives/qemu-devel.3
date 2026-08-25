Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA589C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz04S-0006X4-HM; Tue, 25 Aug 2026 18:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wz04Q-0006Wm-Q5
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:56:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wz04O-0004w7-Ib
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:56:42 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PFtsjb3987883; Tue, 25 Aug 2026 22:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=f/D5z
 oLd8scxkyf15CeOt3e/AMKPkcqJH3KtMw8u0hI=; b=kgfhGP7AmbAOoUkS8yt/0
 FGZKtMbW5Z4ZdVkLdIF0/T8RdAtbTlstpM0D7BJiqVmjcTA3BCeC15Y1oq5kdXfj
 USm3KqottRBTPBUsVl8yzQZ2ME4vil+qXcpwgWdO6Jt6dtXAmMXcrB1+GeqQxNDS
 JUjhu2sRweEhYA4jv5L7L+gT7SERiqDmgywTD+ujDmL0nBpg2jxINsl/pX8wwo9x
 /twcwcvFAp1G5VQ0C0El7/ZWla/2znKXd/EHS7UNLZFDoKu45fRDnk2Fzo4Di2vo
 MFK8pLS6q3Y18pttHSNjdP6bCguwczgT24/x4dQWvNoGTGdQKYohQNdOe2lHEftc
 Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g72by55c7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 22:56:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67PMo8Z4016683; Tue, 25 Aug 2026 22:56:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4g850vdmdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 22:56:35 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67PMuY4F034200;
 Tue, 25 Aug 2026 22:56:35 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4g850vdmdc-2; Tue, 25 Aug 2026 22:56:35 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, peterx@redhat.com, farosas@suse.de,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 joe.jin@oracle.com
Subject: [PATCH 1/2] vfio/migration: Avoid savevm_vfio_handlers for cpr-exec
 and cpr-transfer
Date: Tue, 25 Aug 2026 15:49:40 -0700
Message-ID: <20260825225054.807116-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260825225054.807116-1-dongli.zhang@oracle.com>
References: <20260825225054.807116-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608250195
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE5NSBTYWx0ZWRfX7k59G0Pq5RU+
 B8sEOV0bUWBvM3AYFsWZghlHWGYCRqVWJJcJO7Dv9XsM+7PitH9CBDCebcXivmS+B9QxLpGMHvz
 gNaQy5le32LLg6wADGjV4tQpU3iB1UipkxXAr9d94jhdcz8hTR+vXmVr2ZYPwPITq48me7faUZl
 tRyZS2dp8JCEC5eY3wt3pDZFou/+wr7l1kMhZp672NI7gBp6+zTY5dFwPhZis8AKwtpL79WPLiF
 +1RorCRZzs9q8YNgPfIVfmvd73XpqH1aunSl7KFgIv/hZKuDz1PcG6hwdv7Bqn/XRIcNCjz1ATg
 2+QBdFcJHcDKIsihK68BWCABMR3w/KNHbhNB2JlRXQ3FH6WILellvvQY4oTdfUI1KDw0NTrS+ch
 E6vyj3nOMcaC55VTxylYYXy2qMb0ID51G1diYwwuFjoaEAUHL4B07BjSa4OJiKzNQhIuMUdbdtb
 mEeU+iipk45FCs7HXYg==
X-Proofpoint-GUID: L3WQQL5B0Eu4FTKW9o-n2V8TfgaRkRBL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE5NSBTYWx0ZWRfX9AkWvcE0Awe0
 DSyioWncCkkAze2Y9AMrX99UqlaCznggCtJMbzaBeMg+HYZ+fwE+fXVz61gQtQ6NsdrrQABCwUJ
 R7LLCCACT4bNPKZaWAuPwCRg7itUavpHiVZ6sGbvUOk7dzBBtfsI
X-Authority-Analysis: v=2.4 cv=fqTsol4f c=1 sm=1 tr=0 ts=6a8e1da4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=pylPGa1hoqjualF2eaIA:9
X-Proofpoint-ORIG-GUID: L3WQQL5B0Eu4FTKW9o-n2V8TfgaRkRBL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When the VFIO driver is vfio-pci, vfio_migration_query_flags() returns
-ENOTTY, so savevm_vfio_handlers is not registered or involved.

However, VFIO drivers that support live migration, such as mlx5_vfio_pci,
do support vfio_migration_query_flags(). In that case, savevm_vfio_handlers
is registered and may be used to save and load the VFIO migration stream.
This is expected for VFIO live migration, but not for cpr-exec or
cpr-transfer.

Even after migration converges with
"migrate_set_parameter downtime-limit 1000000", the target still reports
the following error:

failed (load of migration failed: Invalid argument: Failed to load vmstate version_id: 1, ret: -22)

Skip savevm_vfio_handlers for cpr-exec and cpr-transfer.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/vfio/migration.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 73c49d8c24..49aeaad516 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -723,6 +723,13 @@ static bool vfio_is_active_iterate(void *opaque)
     return vfio_device_state_is_precopy(vbasedev);
 }
 
+static bool vfio_is_active(void *opaque)
+{
+    MigMode mode = migrate_mode();
+
+    return mode != MIG_MODE_CPR_EXEC && mode != MIG_MODE_CPR_TRANSFER;
+}
+
 /*
  * Note about migration rate limiting: VFIO migration buffer size is currently
  * limited to 1MB, so there is no need to check if migration rate exceeded (as
@@ -951,6 +958,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .save_cleanup = vfio_save_cleanup,
     .save_query_pending = vfio_state_pending,
     .is_active_iterate = vfio_is_active_iterate,
+    .is_active = vfio_is_active,
     .save_live_iterate = vfio_save_iterate,
     .save_complete = vfio_save_complete_precopy,
     .save_state = vfio_save_state,
-- 
2.43.5


