Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F05EEA84B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdZL-0002WZ-QI; Thu, 12 Feb 2026 15:45:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYr-0001k4-9n; Thu, 12 Feb 2026 15:45:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYp-0008L2-SY; Thu, 12 Feb 2026 15:45:17 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CIjAhp091358; Thu, 12 Feb 2026 20:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Z/LGfoa/+fbijnXTm
 CMKnmUCHItASK3S1hFibsQYlRc=; b=e0+5EP1i4U2kCvgYO8uP4Op1CzmxSAOv4
 Ek2YZWZ0MIDu+Ma8sUyuGxavxq1yEhxt9eTYekZnUEbDwX+AfRZEKNEejrp5PHU/
 l+qEb3CdbsJzezYuQ+XqFTLfRO9iDEn3alUQhYf7nGy/QKfroJmFR/aEzYmcgsnc
 KijrmzCu7K4/Ed1Umn0PwaoHN8360FkF2lmq0JlielDfnQO8HfAHa5JFTOD/D58M
 HzXo0mM3QI+6VEuY03VzSz/1Yu1AN1LCk+GopmPLD+Ph0Z4rE6DG/FPVfPlJ1WXA
 PmuNur8vLNaWAY953xd+0lrAA9xOUwvYrA6TBeXOo1shPl2Tla0uQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ur4et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CGZQij008397;
 Thu, 12 Feb 2026 20:44:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3ym7we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKilPO20382382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:44:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E84058055;
 Thu, 12 Feb 2026 20:44:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 781A558054;
 Thu, 12 Feb 2026 20:44:45 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:44:45 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 27/30] hw/s390x/ipl: Handle secure boot without specifying
 a boot device
Date: Thu, 12 Feb 2026 15:43:48 -0500
Message-ID: <20260212204352.1044699-28-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698e3bc2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=98YBU2wH__9RKlX8yukA:9
X-Proofpoint-ORIG-GUID: oXwb4hg2wGj4C_JSnsuR81YMMfVACBZO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfX9W+2qPmJdoDw
 4hF05Da9RZBeynapHO2JVJsSb2as9lxOTsu2FuyQ7z8cJxzW8sHe4bm9hOP9iP1+4cya12+2RfS
 h4Ay1waDxP0OhZs+CCB1H8+if02hjvQ0KNA0fpvk9yy2SQu9Y3/LMiMRWoaUL4IpnQKgYaLO9HI
 3nmn7Huro8XE1YtZTFG1KOyQn+Grnntkv2ZpN1TmwvGl69ZvrGUA9s2n22tkMm2EhD7CajATgia
 TxPxxXlWX4tRDhOWhpYcmCJvIOUz7746Taf8LaJIaHResqJWIEIIlJPTXkTmPj8UFjUyaqjT64b
 WXvi3E3ahUcIa1Zvg6DVn3JXyJviH0p2ObXdsbtiI2H3Ah2y9nHGVw7EsEAZ88buMJN6pHHdf5J
 oD4fPGEuC5u8sxesSbPUiSu9Ymm7tMlQ1hLGkfVVmZ10pRWYnbY1/g/2JMSVUkKXxxlTUKJP3ON
 hxi7kAhy1azr8dmCyTA==
X-Proofpoint-GUID: oXwb4hg2wGj4C_JSnsuR81YMMfVACBZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

If secure boot in audit mode or True Secure IPL mode is enabled without
specifying a boot device, the boot process will terminate with an error.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index e46e655ef1..00ddfcf858 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -799,6 +799,16 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
         cpu->env.psw.addr = ipl->bios_start_addr;
         if (!ipl->iplb_valid) {
             ipl->iplb_valid = s390_init_all_iplbs(ipl);
+
+            /*
+             * Secure IPL without specifying a boot device.
+             * IPLB is not generated if no boot device is defined.
+             */
+            if ((s390_has_certificate() || s390_secure_boot_enabled()) &&
+                !ipl->iplb_valid) {
+                error_report("No boot device defined for Secure IPL");
+                exit(1);
+            }
         } else {
             ipl->qipl.chain_len = 0;
         }
-- 
2.52.0


