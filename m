Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C624EE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 20:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVGXu-0005w1-5t; Tue, 07 Jan 2025 15:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1tVGXn-0005uw-FI; Tue, 07 Jan 2025 15:51:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1tVGXl-0000aA-6w; Tue, 07 Jan 2025 15:51:19 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507IpZur022625;
 Tue, 7 Jan 2025 20:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NaR7NoeV6ZuroyjyW
 /KCPG6E3ci0miCygCEWBWIN15A=; b=OgpJ55VIQPh4JHWRRI+kcxGYVWpRef2hV
 5ps6fj/nffwtEzZ7nyIELjsxd5hWVRheupTxYiRbUSQAQi5DbuCOPn+JISj/CIXN
 au+NfHps4ZP7kXbYbyvCCu7Xp+YFipyHsuY8IswubdgdXSZw1aUd1X0ELN66obgM
 eL4yAyB0/Vx2FmCJy4yphszvCpcYWydMdBbkGLhLvpvBEeZoSN9HdM2MurIKxBTP
 uUDkyLvU7EPPmcU9hB2h8xyaCnxaU2q0CuPfI35C9GogQ0Ii4Ky9Ouz1a8zU5uou
 d32zlTGXgO/IqeAzmur5nD9yFFfSPFpyQnyRbgyLjLPeEp2C9gYbw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440vrcch8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 20:51:14 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 507KpEo7011155;
 Tue, 7 Jan 2025 20:51:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440vrcch8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 20:51:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507KGdQM013698;
 Tue, 7 Jan 2025 20:51:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yganvd1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 20:51:12 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 507KpB8P18875054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2025 20:51:11 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CA2458068;
 Tue,  7 Jan 2025 20:51:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 351E258066;
 Tue,  7 Jan 2025 20:51:11 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jan 2025 20:51:11 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com, dantan@linux.ibm.com
Subject: [PATCH v3 2/2] ppc/pnv: Add new PowerPC Special Purpose Registers
 (RWMR)
Date: Tue,  7 Jan 2025 14:51:02 -0600
Message-Id: <20250107205102.20242-3-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107205102.20242-1-dantan@linux.vnet.ibm.com>
References: <20250107205102.20242-1-dantan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mLNVfZpXBfDLTH4IDyKKRwnjhlboK14W
X-Proofpoint-ORIG-GUID: dOD671BAi7AetJzQK86Xj3ssyxLsz7vN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=947 spamscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070167
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: dan tan <dantan@linux.ibm.com>

Register RWMR - Region Weighted Mode Register
for privileged access in Power9 and Power10

It controls what the SPURR register produces.

Specs:
 - Power9: https://ibm.ent.box.com/s/tmklq90ze7aj8f4n32er1mu3sy9u8k3k
 - Power10: https://files.openpower.foundation/s/EgCy7C43p2NSRfR

Signed-off-by: dan tan <dantan@linux.ibm.com>
---
Ver 3 summary:
    - change the register to generic read/write from nop/write

Ver 2 summary:
    - corrected the previous definition as ITV1
    - spec reference:
        https://ibm.ent.box.com/s/tmklq90ze7aj8f4n32er1mu3sy9u8k3k (Power9)
    - it appears that part of the previous upstream submission SPRs
      (SPR_POWER_MMCR3, SPR_POWER_SIER2, SPR_POWER_SIER3) are
      already in the current master. Therefore, removed those
      from this request.
---
 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6d074e67dc..fefc741672 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2099,6 +2099,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_440_INV3          (0x373)
 #define SPR_440_ITV0          (0x374)
 #define SPR_440_ITV1          (0x375)
+#define SPR_RWMR              (0x375)
 #define SPR_440_ITV2          (0x376)
 #define SPR_440_ITV3          (0x377)
 #define SPR_440_CCR1          (0x378)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7844e16ea5..fd7e001ade 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5773,6 +5773,11 @@ static void register_power9_book4_sprs(CPUPPCState *env)
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_WORT, 0);
+    spr_register_hv(env, SPR_RWMR, "RWMR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
 #endif
 }
 
-- 
2.39.5


