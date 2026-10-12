Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F41CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPuD-0005kj-LS; Mon, 12 Oct 2026 19:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu4-0005gs-VY
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:58:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu3-0006He-Ar
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:58:00 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMfsFC3711556; Mon, 12 Oct 2026 23:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=HTpmy
 4Za/uk3yOF6I99gRPk/DOqGiadLde8Qg8kOmPs=; b=DZFehU4GHkJ1wxtWbYMuq
 rZiD+LdxhUMAW3eOzkifLuKYM1aF1ZQRsWzPEfhIFs0Luph2zgJD0sAyeuvJ234h
 QLD3BI1Fd/xJkyv1PNnnE0wYz5IlsVjHkxJizA7rZCN5hLWbb5vb2IAskSeye6/H
 zscVPUsrPHaFrLZtNdhppkUBi0DFqDco7MXT71VWVi7k0Qq8XKPFLhl8e6wnazwG
 G5fhROmPxeO7JCO6rRdh218YioreDLsBAs4tKBSHIvWQS5ZyqX6SesRt9GotDMIf
 7cf26jTDOkBGF5ObXSxMyqo0mdB4OaIpbVfcgrALOvSf5wOZxbrUP8mKJ5TDbO0+
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dbkk695-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpfeJ015139; Mon, 12 Oct 2026 23:57:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:53 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHj025328;
 Mon, 12 Oct 2026 23:57:53 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-20; Mon, 12 Oct 2026 23:57:53 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 19/21] monitor/qmp: close LUO session when resuming source QEMU
Date: Mon, 12 Oct 2026 23:56:15 +0000
Message-ID: <20261012235727.398133-20-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261012235727.398133-1-dongli.zhang@oracle.com>
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120095
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6acd7403 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=q5NCwYa1t9B0Pme7qj8A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-GUID: nnJ84_ANNxDC6uf6od7cntryyrY-3d9I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX890eYamr5KxR
 FQOLhyvQuIt3NNOIBFUY/ebtwfGJa7KoR/9f7kT3h0G3ZJLng+CCKjNiu7T3DJ/eelrQCdUA5vz
 XYG9ZyMzVvQErjw1oH2fnLz9B/UiZSXwi2OyJzzKaqyW4q+u+0+TGBfy3lz6qalJlE4yEpiHohO
 HD706IO/3r9gDBH/Swu4MlQC6eI5ro9oWEyeMGvQxpqi3gE8Z7LPfH+ltLSsAtejh8V6M/s/d5J
 /3PbdpOeKX0NvmBLEXwHeoylJjBV8nHdBupnqCaUD2b607yu2gCQXMVjAZRAfcJU0yazwP0YIck
 49gwChY9TFEVeeqZ4fc5sqN2lZbv29EBMIsEsYt8oVZUh5OGoQA11G/kh/OwV0qNHZJMJvcQsi5
 3QycDmj7BzNg8fSJ12ZG1Ykx+i7mER6sjG9qwQpSFlUOLI6Lb79PH3o/5avNgtj/8wc7F6X3jVG
 +tm55+c6SKKv69EMMwn0lxWkIOQUCZfvrTEq7jDM=
X-Proofpoint-ORIG-GUID: nnJ84_ANNxDC6uf6od7cntryyrY-3d9I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfXwV2XE95wmLZQ
 9F4gxry47mxOvyqtZG20tFhco20pYLwGicZKZvOIVmP67xu5OOyFNMIsZQoOsz94iaLUG7RnYho
 ApVR7utaViV3YgYlQdJm19+zSEtVJjzQiOxeo6eygx/YdyPioxDE
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

After a successful cpr-luo migration, the source QEMU remains paused and
keeps the LUO session open for the upcoming kexec. If the user instead
resumes the source QEMU with the cont command, close the LUO session
before restarting the VM.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 monitor/qmp-cmds.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 7525a88e04..fc66618c47 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -32,6 +32,7 @@
 #include "qapi/type-helpers.h"
 #include "hw/mem/memory-device.h"
 #include "hw/intc/intc.h"
+#include "migration/cpr.h"
 #include "migration/misc.h"
 
 NameInfo *qmp_query_name(Error **errp)
@@ -113,6 +114,12 @@ void qmp_cont(Error **errp)
             error_propagate(errp, local_err);
             return;
         }
+        /*
+         * If the user resumes the source QEMU after a completed cpr-luo
+         * migration, close the LUO session fd. This is a nop for other
+         * migration modes or regular operation.
+         */
+        cpr_luo_abort();
         vm_start();
     }
 }
-- 
2.43.5


