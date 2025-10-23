Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F41DCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuJk-00057J-2A; Thu, 23 Oct 2025 08:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuG2-0001E6-T0
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuFx-0006Ps-Dy
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:30 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3oDNV013813;
 Thu, 23 Oct 2025 12:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iwOILT
 QPyUIhzJQ2xujjtNAW0LS1GXXW1cS88ypZ9r0=; b=M+MZro1GpS7i6R1pkm05z/
 fUn2BQbmFI6S/1381F7uodJwwjnEqvG+Qzlf62kv/kxMUoBjEBzJUxQNyN0RU5Yi
 JMhZ92CceeAVkJHfaFDqYTIUXmdlNI0UT/Wz3czN/1lFtGYjl3sRRv6XjzZuWZIr
 Z0hMCTupF0wuXLKFlwRG5EXPj/JXhhqCVJ+9LbjBC+4eotwhIoM4ibTEL9VSvHnq
 TDm9guXxr9W1K8MQY59qPpB2BcTA1brlpJQ+HGQWKmHq5fFsCGnW2lnB48jEtzUF
 I6AfpqPx1v4xPUM2pYAyynK2UXiDQf6PpUWZoLaIVpYMZRZuVvIYrzSbsH35Eghg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cgnxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NA8XTN024303;
 Thu, 23 Oct 2025 12:17:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk5hvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCH9Tt8126822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 806382004B;
 Thu, 23 Oct 2025 12:17:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D88820040;
 Thu, 23 Oct 2025 12:17:08 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:08 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 06/32] target/ppc/kvm: Remove kvmppc_get_host_serial() as unused
Date: Thu, 23 Oct 2025 17:46:25 +0530
Message-ID: <20251023121653.3686015-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: te1JCdPcRWKJJgYACtYU0N1YUCtcSLjf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX4MhprJ2zZw+/
 5GmP0bPIbJKIAQIRWZkPBD64NX24QPgJ1pEybKtANFguUP++9kFHPB6p4jjUoRWjlvXzWs9yJfT
 UWssrWKqvsVH5TxSnIWOXxyT/NQbNXlA/BfDKb8aPWZ68Jfij+DTB41j7Nrwdf/gQG5agSXe/gM
 av0dYd8+vIvq69kD3PgzZoVoKOd4LDUySY+jHbcCi2sLVCHRaoEfKpu6tsRMbycwCc0rgZdJpr3
 xCSek4kGe0EbRwYrbbBcmpBm15iDy7rD7uiAcItNbBtk1GVsxBwQ/QKcyeMtlwL0QQCaHWcuizl
 fkJ8LDFGkMk/3KjccPo3udTP+HB1dFYyd5TtLcGNLLhopaSYUaxfLroaQ0eZkigAY+42rgj1x3u
 LislKkfeIJi5iz8QssD1S9hDpNCkbg==
X-Proofpoint-GUID: te1JCdPcRWKJJgYACtYU0N1YUCtcSLjf
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fa1cd3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=aeNWSmdylBY4NdqMzywA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251021084346.73671-7-philmd@linaro.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/kvm_ppc.h | 6 ------
 target/ppc/kvm.c     | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index a1d9ce9f9a..f24cc4de3c 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -22,7 +22,6 @@
 uint32_t kvmppc_get_tbfreq(void);
 uint64_t kvmppc_get_clockfreq(void);
 bool kvmppc_get_host_model(char **buf);
-bool kvmppc_get_host_serial(char **buf);
 int kvmppc_get_hasidle(CPUPPCState *env);
 int kvmppc_get_hypercall(CPUPPCState *env, uint8_t *buf, int buf_len);
 int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level);
@@ -134,11 +133,6 @@ static inline bool kvmppc_get_host_model(char **buf)
     return false;
 }
 
-static inline bool kvmppc_get_host_serial(char **buf)
-{
-    return false;
-}
-
 static inline uint64_t kvmppc_get_clockfreq(void)
 {
     return 0;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index cd60893a17..cb61e99f9d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1864,12 +1864,6 @@ uint32_t kvmppc_get_tbfreq(void)
     return cached_tbfreq;
 }
 
-bool kvmppc_get_host_serial(char **value)
-{
-    return g_file_get_contents("/proc/device-tree/system-id", value, NULL,
-                               NULL);
-}
-
 bool kvmppc_get_host_model(char **value)
 {
     return g_file_get_contents("/proc/device-tree/model", value, NULL, NULL);
-- 
2.43.5


