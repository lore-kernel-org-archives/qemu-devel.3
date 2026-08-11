Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7119EC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnkX-0002Ta-0v; Tue, 11 Aug 2026 10:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkV-0002T7-OL; Tue, 11 Aug 2026 10:46:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkU-0003ep-67; Tue, 11 Aug 2026 10:46:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDWRiP537294; Tue, 11 Aug 2026 14:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=qb2wyX466h91vZu55
 RS8pWPoSu4aHfl3xRVEQ4wwJbc=; b=ledHjC30MA/0/4RFdwF3x0cB/qvd/JlCX
 0ftUu7j17Kw7H+o9l84V0T9uomqdCcspvLWISRP02QI8Th6wo+aZodK9kcTfsl0N
 8ZXPxqts9k6k6R2ZjL+9gk5c39w5QMUeEwTB3RTLz9puTZI9X4+okXWwf4P+dzz+
 VkLhiLZRE3MTbAFwxw0di9Q4lsXTJ6fFbLH0V3dlUTY4P1AhtlKpk9sF0auqXTj1
 HnM6xAJT++vKZX7T8WoZ2b7ySOuimuj8nAwl82DShziTYcVuehuMYL2rmi2MXNpP
 9zZbTjwiOgMTGcyHDVh1+X/D139z2ah3dWcaY9kcNTJmwmLkGYjfQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9ng42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEfEgB019843;
 Tue, 11 Aug 2026 14:46:35 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy14jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BEkYA922282918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 14:46:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 674025805E;
 Tue, 11 Aug 2026 14:46:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D183258043;
 Tue, 11 Aug 2026 14:46:33 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.86.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 14:46:33 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v2 2/8] hw/s390x/ipl: Fix incorrect PCI IPL block length
 constant
Date: Tue, 11 Aug 2026 10:46:23 -0400
Message-ID: <20260811144629.866641-3-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260811144629.866641-1-jrossi@linux.ibm.com>
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfXzOvaniGPDIPB
 ZkAnojd1Lg3/jEOMT4cn1mQuze8VAIPXii7DlsQmVTIYlToqR1HVEFmeINy2YI5JMuV/AhvmLEP
 R5tTou7uw/ITXpQqgGYs/Vn3v5hEfLpDmk7a681V3TVr+FeD86h6b8RAURSDnJ3C0qPisTxh+3k
 kEKfhG/LqvJDqXJsy0NVZiiCr2Z+vM1hNzLs5HZMa6ac5PhK3xAkctjNtvREGC7cPpUc42LgXCa
 1242smvpWeSWO85/v1Jf+2a2Y5U54mx9Fx0qAh5+XiYgPj5PdjKZsNBZC106myGLLF+zwBoHqG+
 EakEudjGNMlhdk94ccTlsijbY93Y1nFt3RIFX6dGpDneFPSoHNuy5QImcWsq4F5fTGaI64JTSvC
 UVwq8reL9Bu3u/HMl8tslIt9Ng8dk7SaODDwB7wazUJFdmGR8ImYG+s6o5YpuzjMOXD0eZYtVAC
 MNr7ODITPAkLhjNG4kw==
X-Proofpoint-ORIG-GUID: 5OtjauhSOX4DVytUmAiYe6dIihjwtJxp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX4hgDZRozjnqX
 TPNf06qkOoDPEIqkdQlsOTxlXkDpx72bulrswPt0zGWySSvYJu1VsvvZH/0ZFrxg9qQrlsJ51ld
 oz2qmt2YJYl8Nz9V2mc12ZAyrPY4RsY=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7b35cc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Nzsg8VXm9MNVq0Y9DCkA:9
X-Proofpoint-GUID: 5OtjauhSOX4DVytUmAiYe6dIihjwtJxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

The IplBlockPci struct is 336 bytes in length.

Fix the S390_IPLB_MIN_PCI_LEN to reflect this, and assign a valid blk0_len
while we are at it.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.c | 2 ++
 hw/s390x/ipl.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d5fdc3ea0f..fd6e9100f9 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -526,6 +526,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         switch (devtype) {
         case PCI_DEVTYPE_VIRTIO:
             iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
+            iplb->blk0_len =
+                cpu_to_be32(S390_IPLB_MIN_PCI_LEN - S390_IPLB_HEADER_LEN);
             iplb->pbt = S390_IPL_TYPE_PCI;
             iplb->pci.fid = cpu_to_be32(pbdev->fid);
             break;
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index fac30763df..b4d93054a7 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -107,7 +107,7 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 #define S390_IPLB_MIN_PV_LEN 148
 #define S390_IPLB_MIN_CCW_LEN 200
 #define S390_IPLB_MIN_FCP_LEN 384
-#define S390_IPLB_MIN_PCI_LEN 376
+#define S390_IPLB_MIN_PCI_LEN 336
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
 
 static inline bool iplb_valid_len(IplParameterBlock *iplb)
-- 
2.54.0


