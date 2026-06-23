Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AB4CDB466
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbpT7-00073W-7g; Mon, 22 Jun 2026 20:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wbpT5-00072t-5j
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 20:58:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wbpT3-0000G9-Do
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 20:58:22 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MEJwit1818489; Tue, 23 Jun 2026 00:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=XdyZL
 9InpYfdWUQvoJHCmXG8ywa9eHGT1ACC3mVVO/U=; b=aa2SNSIDcHEvcrvnQxeNL
 3Yq9tBr+xthc2UHLn9rk+DPxy1DZpgI4tfN+lvvDc7F12eApIMSSo+oFptIQUr8F
 ZCcr/JiFKlMaaj94JbS5iZoyOeQ8V+QiGvOGhOI9yEwTg81vyrU70qngna7HEX89
 GEuoTqGqAdYstXz6vXKZ5NCec356ZogouGc/s0lexm9nISHGOW0YI3mjFQ7O53Te
 rTQQozq80avIDmVjZpaMWqxhU0Q9SSd+n24fpvQxwnT+/qEnJ03A+4KnxjT8cKRP
 wwL7ZDmW700BTAIPlxpuAvZY+gKxx/1/TBeAI7Ikk3+S4isAjBycSG0CZoc/RkuP
 g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjfuauav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:58:17 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65N0w85k019632; Tue, 23 Jun 2026 00:58:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhabf3ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:58:16 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65N0wE2h020136;
 Tue, 23 Jun 2026 00:58:16 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4ewhabf3sw-3; Tue, 23 Jun 2026 00:58:16 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mst@redhat.com, sarunkod@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 2/2] amd_iommu: Fully initialize XT interrupt message state
Date: Tue, 23 Jun 2026 00:58:13 +0000
Message-ID: <20260623005813.984238-3-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623005813.984238-1-alejandro.j.jimenez@oracle.com>
References: <20260623005813.984238-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606230005
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwNSBTYWx0ZWRfX9TB7Or9CSNoD
 6d9JExfpF2AW/4cqG687qQZQnMRsHfnA+rGgQgDf4DgDmQItgATii1Plepxot3p6EIzN37RgfR0
 yf+dOdARewyenF+17jGnoMKnkGTOPEd6u49cXGQfCLJhl7rW0c7x
X-Authority-Analysis: v=2.4 cv=FtI1OWrq c=1 sm=1 tr=0 ts=6a39da29 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8
 a=ip2sIQfbet0upOwJyiYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: H73TUC9U6JgLAR9w0s0LzpyNHkWZEH19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwNSBTYWx0ZWRfX4V+SLNlYgfjC
 ApEPmT3O2Ed73tteZN0WhCnvhV561XpTtZrIjiSzrikkDlhLTgOx9Vkpfgdgbm5eUplPtERlkzH
 2Mp1+0H3SSpR305VnU+WE2K1FL9E1NCyEoiCk16KYNrB2r2tNyThqQZkP+5vu66G1qmWGEw3JXU
 FTrT7DXS7e3nGPDf6ynJ2cOXyJYT4yXh4g6rvj+gRtV4pLII++2SOS6rS037MQBaQWejbBZcP1s
 srKgTVdsGgB5fI3KKKOaY+y4BsY4e3yI5lnnqIHvoVmrpPLVr0tUli5HSPhapyfzKBklgKGhnd3
 sDTc2iCbcaCuAu5yC47P/9s2wmLV88l+2JFFALmBOQB4vmL+eIoxy7MZ2jxyLFB6ShOWDHdJz9y
 N8Z0VBfsuQiXgiWujcxw97FXzl+1ypYwonGwi6XGixTqw7sFgrHoXGtTLUf+XErYtmBOBR7C9/Y
 5WtWEBa252mWbd1Rvug==
X-Proofpoint-GUID: H73TUC9U6JgLAR9w0s0LzpyNHkWZEH19
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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

When IOMMU x2APIC interrupts generation (IntCapXTEn) is enabled,
amdvi_build_xt_msi_msg() builds an MSI message using the relevant values in
the XT IOMMU General Interrupt Control Register.

Initialize the local X86IOMMUIrq structure with zero for all fields. This
ensures that X86IOMMUIrq fields not set in the XT register (e.g.
msi_addr_last_bits) are initialized before x86_iommu_irq_to_msi_message()
consumes them.

Remove the redundant 'struct' keyword in X86IOMMUIrq irq declaration.

CID: 1660056
Fixes: cf0210df65aa ("amd_iommu: Generate XT interrupts when xt support is enabled")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 0d273fd33d..9005dc7aab 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -195,7 +195,7 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
 static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
 {
     union mmio_xt_intr xt_reg;
-    struct X86IOMMUIrq irq;
+    X86IOMMUIrq irq = { 0 };
 
     xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
 
-- 
2.47.3


