Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080BEC54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 01:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rml6q-0001kk-JQ; Tue, 19 Mar 2024 21:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bgray@linux.ibm.com>)
 id 1rml6p-0001kN-0H; Tue, 19 Mar 2024 21:51:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bgray@linux.ibm.com>)
 id 1rml6n-0003ZE-6s; Tue, 19 Mar 2024 21:51:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42K1p9gm012471; Wed, 20 Mar 2024 01:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vcoK3/mlZvY8lM81VPsxIqnNO7TxOHeYgE2RXkP4WJQ=;
 b=QmdIt0lHjiaOaXQ9ACdGiCt4WUwylpB7cnVK2J7zcEpDpxwclhEtb8bWghk4w1miYeDK
 fksHYDTpI47isN9qi28/yOTliw+pbpBr1QPyQetr1/yejR/G9fAjYyS1IgH1GYCI6lYe
 lsWieCPKcu+BDD9+icMFreqpc8d8pYBUgTBRTZgzXW2/rx4k9bxEom9S8OKm/SBbzJiz
 yiYM5KolwQIAWgFO2pZ3uwITb05L83viZqHeihiJzANrMkDd5Hw3+H3OOrXwQiFDezPq
 /4v35zQU+8x+i5mdGtjTeRUh79APwWy5AbyobfA86QSKoGNrXiFUgq0Va8ApZd4M4qCj gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyn6t0421-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 01:51:09 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42K1p8u5012317;
 Wed, 20 Mar 2024 01:51:08 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyn6t041m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 01:51:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42JNP3KP019891; Wed, 20 Mar 2024 01:50:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwqykk41j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 01:50:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42K1ogX215925512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2024 01:50:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 303A02004D;
 Wed, 20 Mar 2024 01:50:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB95420040;
 Wed, 20 Mar 2024 01:50:41 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 Mar 2024 01:50:41 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com
 [9.192.254.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A9E6360305;
 Wed, 20 Mar 2024 12:50:38 +1100 (AEDT)
From: Benjamin Gray <bgray@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 1/2] target/ppc: Restore [H]DEXCR to 64-bits
Date: Wed, 20 Mar 2024 12:50:24 +1100
Message-ID: <20240320015025.372056-1-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xYPbEg9nrcuV3gtwgUvagAL8csUSKCzb
X-Proofpoint-ORIG-GUID: uZE3x8pjsLwbc-GdgL9zztrmNDe8JGFH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200012
Received-SPF: pass client-ip=148.163.156.1; envelope-from=bgray@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The DEXCR emulation was recently changed to a 32-bit register, possibly
because it does have a 32-bit read-only view. It is a full 64-bit
SPR though, so use the corresponding 64-bit write functions.

Fixes: c9de140c2171 ("target/ppc: Fix width of some 32-bit SPRs")
Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7e65f08147..22fdea093b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5820,7 +5820,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
 {
     spr_register(env, SPR_DEXCR, "DEXCR",
             SPR_NOACCESS, SPR_NOACCESS,
-            &spr_read_generic, &spr_write_generic32,
+            &spr_read_generic, &spr_write_generic,
             0);
 
     spr_register(env, SPR_UDEXCR, "UDEXCR",
@@ -5831,7 +5831,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HDEXCR, "HDEXCR",
             SPR_NOACCESS, SPR_NOACCESS,
             SPR_NOACCESS, SPR_NOACCESS,
-            &spr_read_generic, &spr_write_generic32,
+            &spr_read_generic, &spr_write_generic,
             0);
 
     spr_register(env, SPR_UHDEXCR, "UHDEXCR",
-- 
2.44.0


