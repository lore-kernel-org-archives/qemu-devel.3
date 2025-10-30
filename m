Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867CBCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOMO-0007o3-DQ; Thu, 30 Oct 2025 04:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOMC-0007XT-GY
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOM4-0007L1-9n
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:06 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TL589G003360;
 Thu, 30 Oct 2025 08:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=m1Lvjc
 JQ8kw5Cp8PMb2KjsWQIqWpK1Tbp7nde1J/i7Y=; b=rJWaFt1K8pp721tZ6x1Jno
 Isl1JlUYba4pGAL+Q1pkBU/1Z1vI6rEFKp1Wce+Jw997FZyBgUBSpDaOA3sPEr6J
 1pRTQEID7SC++7pRxNajuFWRrnOOxpmrPEwOlbMySNdsev+JklizZ54qvtz2CY4S
 lGU+ph4bsYDpuZ/uOH67gv3QWZW67M7QvFNQ4f2q1dkgkAIUDzcvfmymUVFYp6wj
 MQgS69O0x6iARwnxUQYWMcXrhxZQaiT4r5/u24cTaZaUOAMNbelUmD8lgzcLcN2n
 S4i6Q0Yg0euNLTJNWLliy1QqUIevNfgRdbyg+sCsU5StXhB0iRprZHaxN9QXf1PQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8qfuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:49:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U5pKmo018766;
 Thu, 30 Oct 2025 08:49:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xwfq6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:49:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U8npbr33620238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 08:49:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8BCE2004D;
 Thu, 30 Oct 2025 08:49:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06D6F20040;
 Thu, 30 Oct 2025 08:49:51 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Oct 2025 08:49:50 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 03/10] target/ppc/cpu_init: Simplify the setup of the TLBxCFG
 SPR registers
Date: Thu, 30 Oct 2025 14:19:29 +0530
Message-ID: <20251030084936.1132417-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251030084936.1132417-1-harshpb@linux.ibm.com>
References: <20251030084936.1132417-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DYkaa/tW c=1 sm=1 tr=0 ts=690326b4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=qyJKq4Ur0MIh53nubOcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: L9UdgsXBqJF382UHC9MFJvG1RA8-g_55
X-Proofpoint-ORIG-GUID: L9UdgsXBqJF382UHC9MFJvG1RA8-g_55
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX87XxoeiQz9C3
 rpHc1IS7fnx8OIKPXbFQaC8K5jlPYHsq8Ji3I5aczS9vcPt0HYbrH3NH+sgkwVK2GXbe6p4quG6
 ucfA3zrNk5V3vlPnDPIheSOJ2n3tu+m8oE/EslOmOoUP3fja3ycB9FsWw1xFS3r276kDfY+ov/B
 PzxC0KZxxmYGovD/fRlRrVbnkIC4wBuy777wKrvLPA6U/8LeFb093PMuvBh0lK6MrNqDwjIb1r3
 OTk6fLx7NnBstJ5yKseU+v0ggswe1/ULLCyqgvA8jCpOjngYpDfQxyrPmuS5EK6PpQ6MZ7p0oUJ
 E5/uXPeSUF6cb4pLz/6LF8dZZONbEQSOMaEVEhExSxQxt0f39gPfu7kwC1mnU456rwIE5V03/1S
 4oNol9S03nIh8CD00QizwOLFnwo45g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The next commit is going to remove init_proc_e200(), which is one of
the two calling sites of register_BookE206_sprs(). This causes recent
versions of GCC to inline the register_BookE206_sprs() function into
the other only remaining calling site, init_proc_e500(), which in
turn causes some false-positives compiler warnings:

 In file included from ../../devel/qemu/target/ppc/cpu_init.c:46:
 In function ‘register_BookE206_sprs’,
     inlined from ‘init_proc_e500’ at ../../devel/qemu/target/ppc/cpu_init.c:2910:5:
 ../../devel/qemu/target/ppc/cpu_init.c:897:29: error:
  array subscript 3 is outside array bounds of ‘uint32_t[2]’ {aka ‘unsigned int[2]’}
  [-Werror=array-bounds=]
   897 |                      tlbncfg[3]);
       |                      ~~~~~~~^~~
 ../../devel/qemu/target/ppc/spr_common.h:61:39: note: in definition of macro ‘spr_register_kvm_hv’
    61 |                   KVM_ARG(one_reg_id) initial_value)
       |                                       ^~~~~~~~~~~~~
 ../../devel/qemu/target/ppc/spr_common.h:77:5: note: in expansion of macro ‘spr_register_kvm’
    77 |     spr_register_kvm(env, num, name, uea_read, uea_write,                    \
       |     ^~~~~~~~~~~~~~~~
 ../../devel/qemu/target/ppc/cpu_init.c:894:9: note: in expansion of macro ‘spr_register’
   894 |         spr_register(env, SPR_BOOKE_TLB3CFG, "TLB3CFG",
       |         ^~~~~~~~~~~~
 ../../devel/qemu/target/ppc/cpu_init.c: In function ‘init_proc_e500’:
 ../../devel/qemu/target/ppc/cpu_init.c:2809:14: note: at offset 12 into object ‘tlbncfg’ of size 8
  2809 |     uint32_t tlbncfg[2];
       |              ^~~~~~~
 cc1: all warnings being treated as errors

init_proc_e500() only defines "uint32_t tlbncfg[2];", but it is OK since
it also sets "env->nb_ways = 2", so the code that GCC warns about in
register_BookE206_sprs() is never reached. Unfortunately, GCC is not smart
enough to see this, so it emits these warnings.

To fix it, let's simplify the code in register_BookE206_sprs() a little
bit to set up the SPRs in a loop, so we don't reference the tlbncfg[3]
entry directly anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20251024065726.738005-2-thuth@redhat.com
Message-ID: <20251024065726.738005-2-thuth@redhat.com>
---
 target/ppc/cpu_init.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 3aa3aefc13..12c645699e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -850,6 +850,13 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
         SPR_BOOKE_MAS0, SPR_BOOKE_MAS1, SPR_BOOKE_MAS2, SPR_BOOKE_MAS3,
         SPR_BOOKE_MAS4, SPR_BOOKE_MAS5, SPR_BOOKE_MAS6, SPR_BOOKE_MAS7,
     };
+    const char *tlbcfg_names[4] = {
+        "TLB0CFG", "TLB1CFG", "TLB2CFG", "TLB3CFG",
+    };
+    const int tlbcfg_sprn[4] = {
+        SPR_BOOKE_TLB0CFG, SPR_BOOKE_TLB1CFG,
+        SPR_BOOKE_TLB2CFG, SPR_BOOKE_TLB3CFG,
+    };
     int i;
 
     /* TLB assist registers */
@@ -889,34 +896,13 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, SPR_NOACCESS,
                  mmucfg);
-    switch (env->nb_ways) {
-    case 4:
-        spr_register(env, SPR_BOOKE_TLB3CFG, "TLB3CFG",
-                     SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, SPR_NOACCESS,
-                     tlbncfg[3]);
-        /* Fallthru */
-    case 3:
-        spr_register(env, SPR_BOOKE_TLB2CFG, "TLB2CFG",
-                     SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, SPR_NOACCESS,
-                     tlbncfg[2]);
-        /* Fallthru */
-    case 2:
-        spr_register(env, SPR_BOOKE_TLB1CFG, "TLB1CFG",
-                     SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, SPR_NOACCESS,
-                     tlbncfg[1]);
-        /* Fallthru */
-    case 1:
-        spr_register(env, SPR_BOOKE_TLB0CFG, "TLB0CFG",
+
+    assert(env->nb_ways <= ARRAY_SIZE(tlbcfg_names));
+    for (i = 0; i < env->nb_ways; i++) {
+        spr_register(env, tlbcfg_sprn[i], tlbcfg_names[i],
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, SPR_NOACCESS,
-                     tlbncfg[0]);
-        /* Fallthru */
-    case 0:
-    default:
-        break;
+                     tlbncfg[i]);
     }
 #endif
 }
-- 
2.43.5


