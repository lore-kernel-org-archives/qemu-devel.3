Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EAAC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6FN-0006eX-Cz; Mon, 03 Jun 2024 07:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sE6FL-0006dT-1Z; Mon, 03 Jun 2024 07:53:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sE6FH-0005zx-Qz; Mon, 03 Jun 2024 07:53:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 453Bq8UG032156; Mon, 3 Jun 2024 11:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=nHN8pbGL+7S0tw+IWhkjkpDrxoe96dNyMyHn5qj/6mY=;
 b=bd4/QvxHo+72e0S4CndKCGVctJjH0DLddf5FjPI/T9lzfh0yZqLeO6+DH9gkyxrxfyke
 dhuQb4qZmmVXSx4EvXyIe7FohPmWmBzwFu8X8hEYScWUDMZU5wvYR68bR4aPMTxm9Uod
 F+d7ZpJuOP9+hShnc9f2l4F1gu95g/qDNC6WzEdniLEQ1g6ax01tRnO6s144xWE+uJNC
 gq4sUggeX3AI5PR7FngVlbZa7jHUk/YIW80IdvQwGWxZeuPxdy5mBxPkCbK+0z/THCAV
 rrYmwbW+I3JztLtfJvTq50oixmUncUAYx39Ty+PPwSv9D4UQRizBggILBLKkEuK9J9fy vg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhdb78015-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jun 2024 11:52:55 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 453BqsY4032518;
 Mon, 3 Jun 2024 11:52:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhdb78012-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jun 2024 11:52:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 453A0FxU026628; Mon, 3 Jun 2024 11:52:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygffmqgfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jun 2024 11:52:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 453BqnQ421168470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jun 2024 11:52:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 262432004B;
 Mon,  3 Jun 2024 11:52:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F255120040;
 Mon,  3 Jun 2024 11:52:47 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.3.101.175])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jun 2024 11:52:47 +0000 (GMT)
Subject: [PATCH 1/2] target/ppc/cpu_init: Synchronize DEXCR with KVM for
 migration
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: cohuck@redhat.com, pbonzini@redhat.com, npiggin@gmail.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: mst@redhat.com, danielhb413@gmail.com, qemu-ppc@nongnu.org
Date: Mon, 03 Jun 2024 11:52:47 +0000
Message-ID: <171741556422.11675.17890249605948158450.stgit@c0c876608f2d>
In-Reply-To: <171741555734.11675.17428208097186191736.stgit@c0c876608f2d>
References: <171741555734.11675.17428208097186191736.stgit@c0c876608f2d>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GfIDvydjSrSK7nT8JOnSnb0b3arF4UlA
X-Proofpoint-ORIG-GUID: hufeLzn_pYLqIPyzWkjiq-QEbS9VPX8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=907 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406030099
Received-SPF: pass client-ip=148.163.156.1; envelope-from=sbhat@linux.ibm.com;
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

The patch enables DEXCR migration by hooking with the
"KVM one reg" ID KVM_REG_PPC_DEXCR.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 linux-headers/asm-powerpc/kvm.h |    1 +
 target/ppc/cpu_init.c           |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 1691297a76..fcb947f656 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -645,6 +645,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_SIER3	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc3)
 #define KVM_REG_PPC_DAWR1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc4)
 #define KVM_REG_PPC_DAWRX1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc5)
+#define KVM_REG_PPC_DEXCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc6)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c11a69fd90..b1422c2eab 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5818,9 +5818,9 @@ static void register_power10_hash_sprs(CPUPPCState *env)
 
 static void register_power10_dexcr_sprs(CPUPPCState *env)
 {
-    spr_register(env, SPR_DEXCR, "DEXCR",
+    spr_register_kvm(env, SPR_DEXCR, "DEXCR",
             SPR_NOACCESS, SPR_NOACCESS,
-            &spr_read_generic, &spr_write_generic,
+            &spr_read_generic, &spr_write_generic, KVM_REG_PPC_DEXCR,
             0);
 
     spr_register(env, SPR_UDEXCR, "UDEXCR",



