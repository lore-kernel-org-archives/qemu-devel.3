Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1F3C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ExC-0003gU-3e; Mon, 14 Sep 2026 18:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <owen.giles@hpe.com>)
 id 1x6Dm4-0005xR-NR
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:59:38 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <owen.giles@hpe.com>)
 id 1x6Dm2-0007YE-Ju
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:59:36 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJefXR3342521; Mon, 14 Sep 2026 20:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pps0720; bh=SdNovYxwBbFJBPp0qj2C7KWxr7hkBBTfdm9dP
 mWq2yc=; b=Foa9D008dTXm7/PeSRkmSrpDBPMBjeYvn8Iit2CCV1tovrl0LTzD0
 icHSriAJsUb6JGsfNLmA3O95Mm4WYlD1F0yhGlUG1FKnLSGWSmnJrK36TQIRZutF
 +uWhhQVoDLzx7epKeWEkV6AL76OOHTwatKvUIqoCRg8Hp60mrg+vrH0AXiR2JpQQ
 30m8BtMIN+dDVhPjObgyQ44emhngJAjS+5uX8sKorMg/7yyaNY7Yjj6J1nxAp4Es
 vm2URLVeScpXy3UAL09AllMzUluVruWBH/TAngUaGaYWB93FU7ZVDcf0K2+1bBh3
 JcIPTe/iI1YOhRW4A9HPqGTkATfNlJT0Q==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4gpkm148jw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 20:59:29 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id B8975806B30;
 Mon, 14 Sep 2026 20:59:28 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id D13468084FF;
 Mon, 14 Sep 2026 20:59:27 +0000 (UTC)
From: Owen Giles <owen.giles@hpe.com>
To: elena.ufimtseva@oracle.com, jag.raman@oracle.com
Cc: qemu-devel@nongnu.org, Owen Giles <owen.giles@hpe.com>
Subject: [PATCH] hw/remote/vfio-user: Reset VFU region flags for each BAR
Date: Mon, 14 Sep 2026 15:57:47 -0500
Message-Id: <20260914205747.1540492-1-owen.giles@hpe.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI5OSBTYWx0ZWRfX06qCvQhyR7w0
 gHl4tnV1JhoWPv83Tjjl6Md6MBhyZE3HYcqsWZaCDCmEZtQOPr6RV8ZY2W5PA2fngJVdahP8I0v
 KzfWVk4WxF5TpkkXEapNSumIgXeF/tY=
X-Authority-Analysis: v=2.4 cv=Kc5HIgYD c=1 sm=1 tr=0 ts=6aa86031 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=RtSn8ETxjE2H05FtM2s8:22 a=MvuuwTCpAAAA:8 a=6yHLYObcNuKKdcwZnVQA:9
X-Proofpoint-GUID: e4anmEVJGgsc-FbyqA9lPapZUybJj7OR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI5OSBTYWx0ZWRfXwgJ139tzLQw6
 sdfOMMwoKv3F103P2awox1WuWWmoK58QLlbVjIAb/gBSF499tojgKSNPtTnkjEzHvKLU52YodXQ
 /g11LJqqIlXmVyCUo7lbPxI5+ahXwq483IV+xRT8Ng+j1IiUPDv6tNGT+rT4g2fEA+MVMgBgKsD
 b/aREpW1fi/uUqJsOy7lwNYEW3tuJRU7cw9q0SrvgRWdaOi17bFMleRYehCldbmNYqRQgqeXqMf
 ihzn3X941r+7NzSAU7y3+iYC3NaMuMwOlMMla3eDRcjuDnyh4uleuBqG05vEgbSVdi5U1o2VtCp
 gF4yNo9QwOJNFphne6PlqdRTuyxaZv8I0z57y9U9iA1SEQILjgJpqQnhGjNInLTjIDr1vjYLr4g
 5P9EhriNqjjSGwH+PBDnt/bBouD82rGqHw1ojJ+74Xb55Z0svR//3fz1h48Yz9yGau4fXZ4t1fC
 +aqDmew/qglfHA1p3LA==
X-Proofpoint-ORIG-GUID: e4anmEVJGgsc-FbyqA9lPapZUybJj7OR
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140299
Received-SPF: pass client-ip=148.163.147.86; envelope-from=owen.giles@hpe.com;
 helo=mx0a-002e3701.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 14 Sep 2026 18:15:06 -0400
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

flags is only initialized once before the BAR setup loop, so if a lower
BAR's io_region is read only, every subsequent BAR will have its
flags set as read only despite not being read only. By setting flags to
RW in every iteration, each region is properly assessed and assigned
the proper flag.

Fixes: 3123f93d6b85 ("vfio-user: handle PCI BAR accesses")
Signed-off-by: Owen Giles <owen.giles@hpe.com>
---

Notes:
    The ROM case of the read-only check is okay, as the ROM will always be the
    last in the loop, but the other check is what can result in unintended
    consequences.

 hw/remote/vfio-user-obj.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index a0498d218fa..67687c841a6 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -519,14 +519,15 @@ static vfu_region_access_cb_t *vfu_object_bar_handlers[PCI_NUM_REGIONS] = {
  */
 static void vfu_object_register_bars(vfu_ctx_t *vfu_ctx, PCIDevice *pdev)
 {
-    int flags = VFU_REGION_FLAG_RW;
-    int i;
+    int flags, i;
 
     for (i = 0; i < PCI_NUM_REGIONS; i++) {
         if (!pdev->io_regions[i].size) {
             continue;
         }
 
+        flags = VFU_REGION_FLAG_RW;
+
         if ((i == VFU_PCI_DEV_ROM_REGION_IDX) ||
             pdev->io_regions[i].memory->readonly) {
             flags &= ~VFU_REGION_FLAG_WRITE;
-- 
2.34.1


