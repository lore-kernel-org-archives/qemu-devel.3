Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB47C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6FZ-0006lK-84; Mon, 03 Jun 2024 07:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sE6FX-0006jj-Ip; Mon, 03 Jun 2024 07:53:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sE6FT-00061p-G6; Mon, 03 Jun 2024 07:53:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 453BoiXl015685; Mon, 3 Jun 2024 11:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=U8grBbLnuptcbkJz/FoIWfmUXYQni3ocYzh7OnET6Yw=;
 b=SwKhx9wCW7oeRUj7EFjoKDtFdwC4m/714xZgnp18xvHdY8l/TfVt+wgDHgV2GB78S0pP
 5HK4a+EmUlPiVNV3IAUCmDXo1NzFTYqwk7cDvAqzQ4FN/kXqyKG/NYWqp7DoK4AF72KC
 ndHqfnxmtzO5ipAeumWrzwNhiWnCC0ywT0AgSv+nxpxuT8f1jnOdLXdJ0lyQQvaFTLYi
 hKnbo/dwlLwn0PMJez2OcxARJz31FpU0Xqe3sCVoEYbu+QrwCKaaUKE5mETLvkfbBBJP
 3pOgbSxYVbG5ne419tBrsaLfm1Na4wgEuqhbx+c4QUpJStz1+5xqoo4IpMkSvUjRZoSc jA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhctt02rf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jun 2024 11:53:08 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 453Br8CE018854;
 Mon, 3 Jun 2024 11:53:08 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhctt02rc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jun 2024 11:53:08 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4538ZNAk000815; Mon, 3 Jun 2024 11:53:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygdytqvx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jun 2024 11:53:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 453Br3XQ10748246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jun 2024 11:53:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9B6020043;
 Mon,  3 Jun 2024 11:53:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D9E620040;
 Mon,  3 Jun 2024 11:53:02 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.3.101.175])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jun 2024 11:53:02 +0000 (GMT)
Subject: [PATCH 2/2] target/ppc/cpu_init: Synchronize HASHKEYR with KVM for
 migration
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: cohuck@redhat.com, pbonzini@redhat.com, npiggin@gmail.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: mst@redhat.com, danielhb413@gmail.com, qemu-ppc@nongnu.org
Date: Mon, 03 Jun 2024 11:53:01 +0000
Message-ID: <171741557432.11675.11683958406314165970.stgit@c0c876608f2d>
In-Reply-To: <171741555734.11675.17428208097186191736.stgit@c0c876608f2d>
References: <171741555734.11675.17428208097186191736.stgit@c0c876608f2d>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zN48z9-Ppsmfr3TuSvnHQcpH0LUSpptu
X-Proofpoint-GUID: VjdGXuh1SRVgSi_bFcGDJCwttgbvKVOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=874 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The patch enables HASHKEYR migration by hooking with the
"KVM one reg" ID KVM_REG_PPC_HASHKEYR.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 linux-headers/asm-powerpc/kvm.h |    1 +
 target/ppc/cpu_init.c           |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index fcb947f656..23a0af739c 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -646,6 +646,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_DAWR1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc4)
 #define KVM_REG_PPC_DAWRX1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc5)
 #define KVM_REG_PPC_DEXCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc6)
+#define KVM_REG_PPC_HASHKEYR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc7)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b1422c2eab..cee0a609eb 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5805,10 +5805,10 @@ static void register_power10_hash_sprs(CPUPPCState *env)
         ((uint64_t)g_rand_int(rand) << 32) | (uint64_t)g_rand_int(rand);
     g_rand_free(rand);
 #endif
-    spr_register(env, SPR_HASHKEYR, "HASHKEYR",
+    spr_register_kvm(env, SPR_HASHKEYR, "HASHKEYR",
             SPR_NOACCESS, SPR_NOACCESS,
             &spr_read_generic, &spr_write_generic,
-            hashkeyr_initial_value);
+            KVM_REG_PPC_HASHKEYR, hashkeyr_initial_value);
     spr_register_hv(env, SPR_HASHPKEYR, "HASHPKEYR",
             SPR_NOACCESS, SPR_NOACCESS,
             SPR_NOACCESS, SPR_NOACCESS,



