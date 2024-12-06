Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C862AE7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXSO-0007Us-Ny; Fri, 06 Dec 2024 07:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRR-000602-Hi; Fri, 06 Dec 2024 07:28:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRO-00043c-H8; Fri, 06 Dec 2024 07:28:16 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67RE8T028543;
 Fri, 6 Dec 2024 12:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=LDk3a8x0tAUQQax9W
 +WmNBPtEtPtLNR+iKuPMqIruWw=; b=rmCRqSmm4qWzv3/aoBK3j+F3HmR9SS80r
 8nTMmvK1oEMFt7YDOhW5pu/xyHc3ObQ4gUrgDgbTEsKiP3mBpebq360S7jeDhKQB
 GkXVnstNwGv/WZ5e8fE2r45avKMCRs0kFrqnR9ho933Bw5BVUKJZGiSO++KS03d7
 u9vx1r8pQ/Rrn2xNbpth2ZBTF9DEWVY1VPrbcruGnMYY9kyjgTxe8O4IkX9A9y85
 atkVbDxLvdI/Kz8qBvrphdTRWpmLf/1p/aiZ1TSxeyCTHWtJyQHZFYtYdlNA2aZ0
 tawk9zskR20S1iBRIPQp+R+elidwdFZwscpq+X0t7SDmybn8BR9wA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ax661x22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6AX10n023015;
 Fri, 6 Dec 2024 12:28:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438e1ndjds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B6CS5mq34800178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2024 12:28:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4145820043;
 Fri,  6 Dec 2024 12:28:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C092120040;
 Fri,  6 Dec 2024 12:28:04 +0000 (GMT)
Received: from vela.ibmuc.com (unknown [9.171.26.200])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Dec 2024 12:28:04 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 borntraeger@linux.ibm.com, Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH v2 13/15] s390x/cpumodel: correct PLO feature wording
Date: Fri,  6 Dec 2024 13:27:49 +0100
Message-ID: <20241206122751.189721-14-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206122751.189721-1-brueckner@linux.ibm.com>
References: <20241206122751.189721-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bjxFA_kEKjojF3ngRGHENyjj_nnlCo5A
X-Proofpoint-GUID: bjxFA_kEKjojF3ngRGHENyjj_nnlCo5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 mlxlogscore=841 malwarescore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412060085
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The PLO functions 0, 4, 8, 12, 16, and 20 use 32-bit registers
values.  The plo-*gr variants use 64-bit instead and, thus, correct
the wording.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/cpu_features_def.h.inc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 09a80844a7..fe7e1bd19c 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -158,27 +158,27 @@ DEF_FEAT(AP, "ap", MISC, 0, "AP instructions installed")
 /* Features exposed via the PLO instruction. */
 DEF_FEAT(PLO_CL, "plo-cl", PLO, 0, "PLO Compare and load (32 bit in general registers)")
 DEF_FEAT(PLO_CLG, "plo-clg", PLO, 1, "PLO Compare and load (64 bit in parameter list)")
-DEF_FEAT(PLO_CLGR, "plo-clgr", PLO, 2, "PLO Compare and load (32 bit in general registers)")
+DEF_FEAT(PLO_CLGR, "plo-clgr", PLO, 2, "PLO Compare and load (64 bit in general registers)")
 DEF_FEAT(PLO_CLX, "plo-clx", PLO, 3, "PLO Compare and load (128 bit in parameter list)")
 DEF_FEAT(PLO_CS, "plo-cs", PLO, 4, "PLO Compare and swap (32 bit in general registers)")
 DEF_FEAT(PLO_CSG, "plo-csg", PLO, 5, "PLO Compare and swap (64 bit in parameter list)")
-DEF_FEAT(PLO_CSGR, "plo-csgr", PLO, 6, "PLO Compare and swap (32 bit in general registers)")
+DEF_FEAT(PLO_CSGR, "plo-csgr", PLO, 6, "PLO Compare and swap (64 bit in general registers)")
 DEF_FEAT(PLO_CSX, "plo-csx", PLO, 7, "PLO Compare and swap (128 bit in parameter list)")
 DEF_FEAT(PLO_DCS, "plo-dcs", PLO, 8, "PLO Double compare and swap (32 bit in general registers)")
 DEF_FEAT(PLO_DCSG, "plo-dcsg", PLO, 9, "PLO Double compare and swap (64 bit in parameter list)")
-DEF_FEAT(PLO_DCSGR, "plo-dcsgr", PLO, 10, "PLO Double compare and swap (32 bit in general registers)")
+DEF_FEAT(PLO_DCSGR, "plo-dcsgr", PLO, 10, "PLO Double compare and swap (64 bit in general registers)")
 DEF_FEAT(PLO_DCSX, "plo-dcsx", PLO, 11, "PLO Double compare and swap (128 bit in parameter list)")
 DEF_FEAT(PLO_CSST, "plo-csst", PLO, 12, "PLO Compare and swap and store (32 bit in general registers)")
 DEF_FEAT(PLO_CSSTG, "plo-csstg", PLO, 13, "PLO Compare and swap and store (64 bit in parameter list)")
-DEF_FEAT(PLO_CSSTGR, "plo-csstgr", PLO, 14, "PLO Compare and swap and store (32 bit in general registers)")
+DEF_FEAT(PLO_CSSTGR, "plo-csstgr", PLO, 14, "PLO Compare and swap and store (64 bit in general registers)")
 DEF_FEAT(PLO_CSSTX, "plo-csstx", PLO, 15, "PLO Compare and swap and store (128 bit in parameter list)")
 DEF_FEAT(PLO_CSDST, "plo-csdst", PLO, 16, "PLO Compare and swap and double store (32 bit in general registers)")
 DEF_FEAT(PLO_CSDSTG, "plo-csdstg", PLO, 17, "PLO Compare and swap and double store (64 bit in parameter list)")
-DEF_FEAT(PLO_CSDSTGR, "plo-csdstgr", PLO, 18, "PLO Compare and swap and double store (32 bit in general registers)")
+DEF_FEAT(PLO_CSDSTGR, "plo-csdstgr", PLO, 18, "PLO Compare and swap and double store (64 bit in general registers)")
 DEF_FEAT(PLO_CSDSTX, "plo-csdstx", PLO, 19, "PLO Compare and swap and double store (128 bit in parameter list)")
 DEF_FEAT(PLO_CSTST, "plo-cstst", PLO, 20, "PLO Compare and swap and triple store (32 bit in general registers)")
 DEF_FEAT(PLO_CSTSTG, "plo-cststg", PLO, 21, "PLO Compare and swap and triple store (64 bit in parameter list)")
-DEF_FEAT(PLO_CSTSTGR, "plo-cststgr", PLO, 22, "PLO Compare and swap and triple store (32 bit in general registers)")
+DEF_FEAT(PLO_CSTSTGR, "plo-cststgr", PLO, 22, "PLO Compare and swap and triple store (64 bit in general registers)")
 DEF_FEAT(PLO_CSTSTX, "plo-cststx", PLO, 23, "PLO Compare and swap and triple store (128 bit in parameter list)")
 
 /* Features exposed via the PTFF instruction. */
-- 
2.43.5


