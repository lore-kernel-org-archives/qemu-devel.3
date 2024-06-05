Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11767C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 15:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEt1y-0005Ap-1l; Wed, 05 Jun 2024 11:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sEt1w-00058D-7m; Wed, 05 Jun 2024 11:58:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sEt1s-0006p5-65; Wed, 05 Jun 2024 11:58:27 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 455Fof9f032079; Wed, 5 Jun 2024 15:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=CVwxRreFDvXecgEAPPFNh+yGctWh3epBSsv5oDyXlfk=;
 b=o2F2m/TCJzdQKYVpLpMPEUGEf7k/IVk+X8dv6KkWdi5D0xwim1QmlVkRaqGmLdIWm8/B
 cBi6dcKIqUE2Nwc6Q453RnQ/G6jLkxm9qzakWB7tUKAINTyPYRkBfuPtpz3LAly2xfZz
 EUYDwhcLg/khougeWAmLcPlmlT8BYTPzAnc8oqk964IzXIXWovF2nSQdSMYXlv2lV+hv
 T9Mne/q2h2Uz6Wzn1rvGm4CA/i5CA9zGSDpXxnfSeK0dnR13mvjsP71MyFFI5oPieg14
 Tks1g1WwsjW9ScutCRxgGMt0vM4pf+MQni8fKsx9OJqZzMVpxTjgYhkiD/bHuDeFOrKN +A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yjth984ge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jun 2024 15:58:22 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 455FwLA8013809;
 Wed, 5 Jun 2024 15:58:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yjth984ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jun 2024 15:58:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 455FmKnY031109; Wed, 5 Jun 2024 15:58:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygeypn274-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jun 2024 15:58:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 455FwEoU22872458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Jun 2024 15:58:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5504720043;
 Wed,  5 Jun 2024 15:58:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B512320040;
 Wed,  5 Jun 2024 15:58:12 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.3.101.175])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Jun 2024 15:58:12 +0000 (GMT)
Subject: [PATCH v2 3/4] target/ppc/cpu_init: Synchronize HASHKEYR with KVM for
 migration
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: cohuck@redhat.com, pbonzini@redhat.com, npiggin@gmail.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: mst@redhat.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 sbhat@linux.ibm.com, harshpb@linux.ibm.com, vaibhav@linux.ibm.com
Date: Wed, 05 Jun 2024 15:58:12 +0000
Message-ID: <171760308953.1127.14625001027546560031.stgit@ad1b393f0e09>
In-Reply-To: <171760304518.1127.12881297254648658843.stgit@ad1b393f0e09>
References: <171760304518.1127.12881297254648658843.stgit@ad1b393f0e09>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bNZhf_IiClzwRLEdOk2DN319dLb1Vvku
X-Proofpoint-ORIG-GUID: SuQrsRYFtLbn50tKa4dcVz7xHeWF-_R_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=864
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406050121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=sbhat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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
 target/ppc/cpu_init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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



