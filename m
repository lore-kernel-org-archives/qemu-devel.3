Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D8AD116E7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 04:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4ByS-0000xd-7G; Fri, 25 Oct 2024 00:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ido.plat1@ibm.com>) id 1t4AOG-0002OK-R7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 22:49:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ido.plat1@ibm.com>) id 1t4AOE-0002OW-Ny
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 22:49:28 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OFNLU6025293;
 Fri, 25 Oct 2024 02:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vnqVwuNsBe4LxO/Kb0ZmDrMphJln7OOfnj+uEsar1
 00=; b=GBGymRceU/EaPHHZN6jjS1MGD0+9gPBecpNEBQel22wRFlp4WMB0QXEq9
 TGKov34UFA1cXmzRpfpEvGvY0F0B1F0AiHlCKXqjMtrK/c5EpTu6guURTowa1Fue
 fDn49v2Vsb5FYFrtjFRsXYKxQhLSlSt1Dy5ShQb6zSUTMGC/CjRdyBdIpfKheFxW
 dAFiF7fEivutt+LKXQ2MCSdHMQjJdBxV320wn64t+zJTm3qhq80JemhBHA9pa5Hy
 K1+CJ4NSny/FSkygdz4BzPw7QPnOfaVKrmbkziMUXgYlpvu3HZubm0Dt86LXwaIw
 440xRuA+NIgUXxgx1DNlcPvdQl4Gw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaf3qqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 02:49:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49P204dM008816;
 Fri, 25 Oct 2024 02:49:21 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkauk3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 02:49:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49P2nHAh51708402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 02:49:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF5B258059;
 Fri, 25 Oct 2024 02:49:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A10058043;
 Fri, 25 Oct 2024 02:49:15 +0000 (GMT)
Received: from IBM-PW03YD1E.ibm.com (unknown [9.36.26.105])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Oct 2024 02:49:14 +0000 (GMT)
From: Ido Plat <ido.plat1@ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Ido Plat <ido.plat1@ibm.com>
Subject: [PATCH 1/1] target/arm: Fix arithmetic underflow in SETM instruction
Date: Fri, 25 Oct 2024 13:48:38 +1100
Message-ID: <20241025024909.799989-1-ido.plat1@ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sRZ9VexKfE3700iJV51-l9UJEBcb1GfJ
X-Proofpoint-ORIG-GUID: sRZ9VexKfE3700iJV51-l9UJEBcb1GfJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=332
 priorityscore=1501 suspectscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250018
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ido.plat1@ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Oct 2024 00:30:54 -0400
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

Pass the stage size to step function callback,
otherwise do_setm would hang when size is larger then page size because stage size would underflow.
This fix changes do_setm to be more inline with do_setp.

Fixes: 0e92818887dee ("target/arm: Implement the SET* instructions")
Signed-off-by: Ido Plat <ido.plat1@ibm.com>
---
 target/arm/tcg/helper-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 56b431faf5..8f42a28d07 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1348,7 +1348,7 @@ static void do_setm(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
     /* Do the actual memset: we leave the last partial page to SETE */
     stagesetsize = setsize & TARGET_PAGE_MASK;
     while (stagesetsize > 0) {
-        step = stepfn(env, toaddr, setsize, data, memidx, &mtedesc, ra);
+        step = stepfn(env, toaddr, stagesetsize, data, memidx, &mtedesc, ra);
         toaddr += step;
         setsize -= step;
         stagesetsize -= step;
-- 
2.43.0


