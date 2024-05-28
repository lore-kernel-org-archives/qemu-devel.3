Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4E1C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 07:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqux-0007IW-HW; Tue, 28 May 2024 03:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBqun-0007AM-Ap; Tue, 28 May 2024 03:06:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBquc-0004ka-BJ; Tue, 28 May 2024 03:06:26 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S6BADk030347; Tue, 28 May 2024 07:05:36 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DWWk?=
 =?UTF-8?Q?r5QaidKCEFgxjx5wqTYRjZAmhwMM4pw9hv/yycM0=3D;_b=3DjXikdxpekGFs7f?=
 =?UTF-8?Q?78z/aWA9moqPdvSgpwhQBAN2jLP66JeH7YauxzO7MSID9PGe5MBSBA_yJdmXhdu?=
 =?UTF-8?Q?ydkhnEcqgdNQq3CT+JRMlobHd7KuUZdY/AWx6XeonE3p0cdKotycmEIqLri4_Hc?=
 =?UTF-8?Q?o5Wh1f/mk2jLUtZsnLNinL+Sh3cUfGy3skojEdC0gaOHqkf6BWpGyCyDPKmv9Sk?=
 =?UTF-8?Q?h4n_mQfa9tZKgLPrXTHaGiS/9GLSll65Zijyby/9R/O++II+B24ptQp3R5iC5Qm?=
 =?UTF-8?Q?to7lWtD/u_jSgmlWLSjic+7otImYCHrQgIsG7endIAMKkCHVcC5IqrelfpDrere?=
 =?UTF-8?Q?zI08YKAL+Eodjbp_lg=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd8yyr8qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:05:35 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S75Z7i023464;
 Tue, 28 May 2024 07:05:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd8yyr8qb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:05:35 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S5MatB011106; Tue, 28 May 2024 07:05:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ybtq05n5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:05:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44S75S6A29360796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 07:05:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BC512004D;
 Tue, 28 May 2024 07:05:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5962B2004B;
 Tue, 28 May 2024 07:05:26 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2024 07:05:26 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 04/11] target/ppc: Fix regression due to Power10 and
 Power11 having same PCR
Date: Tue, 28 May 2024 12:35:08 +0530
Message-ID: <20240528070515.117160-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528070515.117160-1-adityag@linux.ibm.com>
References: <20240528070515.117160-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: efOyM60DwXSXV5wN-wGaG3ACmcKWexbm
X-Proofpoint-ORIG-GUID: 73la1HzJBVrAu_U0Q5e1ciHBJbaZH0ov
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Power11 has the same PCR (Processor Compatibility Register) value, as
Power10.

Due to this, QEMU considers Power11 as a valid compat-mode for Power10,
ie. earlier it was possible to run QEMU with '-M pseries,max-compat-mode=power11 --cpu power10'

Same PCR also introduced a regression where `-M pseries --cpu power10`
boots as Power11 (ie. logical PVR is of Power11, even though PVR is Power10).
The regression was due to 'do_client_architecture_support' checking for
valid compat modes and finding Power11 to be a valid compat mode for
Power10 (it happens even without passing 'max-compat-mode' explicitly).

Fix compat-mode issue and regression, by ensuring a future Power
processor (with a higher logical_pvr value, eg. P11) cannot be valid
compat-mode for an older Power processor (eg. P10)

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

---
Multiple alternative approaches were tried to fix this:

1. New PCR for Power11: No
2. 'Hacky fix': chose (n-1) entry in compat table in case of Power10.
  Commit: https://github.com/adi-g15-ibm/qemu/commit/c79bd667791883d4fb5e643979ae9c86a97bdf66
  Pros: Doesn't require adding a new field
  Cons: Hacky fix, will need change if Power12 comes with same PCR as
  Power10 (unlikely)
3. Setting current Processor's .logical_pvr as the max_compat to be checked
during CAS (Client Architecture Support).
  Commit: https://github.com/adi-g15-ibm/qemu/commit/30e430be71c6f3296017177298e54532570c2c87
  This causes CAS to not consider Power11 if cpu is Power10
---

---
 target/ppc/compat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 12dd8ae290ca..168a3c06316f 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -139,6 +139,10 @@ static bool pcc_compat(PowerPCCPUClass *pcc, uint32_t compat_pvr,
         /* Outside specified range */
         return false;
     }
+    if (compat->pvr > pcc->logical_pvr) {
+        /* Older CPU cannot support a newer processor's compat mode */
+        return false;
+    }
     if (!(pcc->pcr_supported & compat->pcr_level)) {
         /* Not supported by this CPU */
         return false;
-- 
2.45.1


