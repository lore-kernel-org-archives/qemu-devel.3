Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FC4E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 03:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTYFp-0005ao-PD; Thu, 02 Jan 2025 22:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1tTYFm-0005Za-VY; Thu, 02 Jan 2025 22:21:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1tTYFi-0001gy-BC; Thu, 02 Jan 2025 22:21:38 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Mvlnj015976;
 Fri, 3 Jan 2025 03:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=q1F8OYaLSp9KDQ66j
 1disqY3LdCXZYXBSU/8GC6tKV4=; b=gAv83XEFS3RMP51D2XPiaNTqb4W+qGUL1
 Pda6uTaTEb4/53j5wLqG5pEdiLZOpNjsb+lunpi6kBhDiTAuemYQdyPXUMlTjcj0
 quzYtYc13va8RS1i9zdYf6ZUCX03zUD9wQx7w3/J/uFmSe3iHWkVJD1COZasbb8f
 nMdNmVtyNorz50qo3lekLAZ6it6xP3vSzgOjZJ6Ap/+tW1QvFxv6907Q+3mPh0LI
 PUKv3sxi6wt0WILSL9InxU2e3zL66wAvDITVmPuFkaWrHTkJVLeyL/veEImdbzKM
 mUXfpVO2XzVTTcrSXuuqueJyq98xVBqNtK6HBdVrbkCz1pH3EwCig==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43wk9bck2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 03:21:31 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5033LVxE012838;
 Fri, 3 Jan 2025 03:21:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43wk9bck2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 03:21:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 502NnjAn014028;
 Fri, 3 Jan 2025 03:21:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tv1ycres-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 03:21:29 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5033LSuc24445526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jan 2025 03:21:28 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4956B58059;
 Fri,  3 Jan 2025 03:21:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20AAA58055;
 Fri,  3 Jan 2025 03:21:28 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jan 2025 03:21:28 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com, dantan@linux.ibm.com
Subject: [PATCH v2 2/2] ppc/pnv: Add new PowerPC Special Purpose Registers
 (RWMR)
Date: Thu,  2 Jan 2025 21:21:12 -0600
Message-Id: <20250103032112.18247-3-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250103032112.18247-1-dantan@linux.vnet.ibm.com>
References: <20250103032112.18247-1-dantan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e-5K3WhmaWFK4Zwnit1gNt8slfC1LRZa
X-Proofpoint-ORIG-GUID: WJNa2Sd7f097pujLlAEMGO_9bfnob1g9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=929
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030023
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

Register RWMR - Region Weighted Mode Register
for privileged access in Power9 and Power10

It controls what the SPURR register produces.

Specs:
 - Power9: https://ibm.ent.box.com/s/tmklq90ze7aj8f4n32er1mu3sy9u8k3k
 - Power10: https://files.openpower.foundation/s/EgCy7C43p2NSRfR

Signed-off-by: dan tan <dantan@linux.ibm.com>
---
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
index 7844e16ea5..356eda7f93 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5773,6 +5773,11 @@ static void register_power9_book4_sprs(CPUPPCState *env)
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_WORT, 0);
+    spr_register_hv(env, SPR_RWMR, "RWMR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_access_nop, &spr_write_generic,
+                 &spr_access_nop, &spr_write_generic,
+                 0x00000000);
 #endif
 }
 
-- 
2.39.5


