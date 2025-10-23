Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8777ACCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuHv-0002uS-9l; Thu, 23 Oct 2025 08:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuG1-000196-Rd
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuFw-0006PM-Vq
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAHXGs009814;
 Thu, 23 Oct 2025 12:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GxcLpK
 pr/QtQZF/cMnjmsCw52HTcPqMgbEWgV3CIK5k=; b=OQTstcUzNrbcdVV3mGG9Xz
 3uGcXjF1L+r0s5baNeH9GKodPc0yXwLFLL5VdUXDqgkRxQw65ncxQ7CdapVUxcQf
 cMYp9cay9GgeVqzxO27fir3G2TTyBiv45WvzvePo88LN47xotJ5gI0W43OQMFle1
 1L3L/xracV+6FrZ6gezLrf2GpwvX+3iKlL0weuvWsAa9KlvkWf6tqFoJxwDUIthi
 bMpXDWC9CHdbpLcXVtXXPvu/d8E/TPP/u7WEH0indqIccfaBjHRnma5a2AxgPWXr
 msI47EMaXLfNWvtfhBp5JKN3caAmnOB8vPngzROCUrcWP8I2zmdCEASL8KO6y2MQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hrgf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9J2EG014676;
 Thu, 23 Oct 2025 12:17:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sdtt2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHAfp52167026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B70EA20043;
 Thu, 23 Oct 2025 12:17:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D241020040;
 Thu, 23 Oct 2025 12:17:09 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:09 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 07/32] target/ppc/kvm: Remove kvmppc_get_host_model() as unused
Date: Thu, 23 Oct 2025 17:46:26 +0530
Message-ID: <20251023121653.3686015-8-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXz/pJjkGWJzGO
 xCPaXOfhdxQgbzg6jlb9cVoZvoyLEPnQA/EvYOf1bRS1xKUn8nWbauaX993ZmVhl5bfAMTnVMBx
 wpJQqKlcoAXVEfgeM4xE4tROFe2jr4bBO8BDMTsS8y9F53N9EZj/IVKV+zPzRu7nrxtOu15wJTi
 koN6S3SGKTDZZUoASTknTq1EtRK9eAgnPGtmURP4SvNAxd5+opA55yESRs03WuHLaXpDIy7A0XH
 HR9ohv/rkgqB5mSzZhU8k4NIyDiw7SXPQ+nJJxe3CkqKJg+9zhaV56E88Dto4XdMuW2Hh72W4iP
 jgjn3B1HjVmSvQ5bVC5eUeZyYqJTJ+bq342/+XXwqGdgzFiRvlVNg+5Bqy56dTxyg2cBWHT+UGd
 5e3cUlvzdhjz324Gt2Y3+IsQowvu4Q==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fa1cd2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=aeNWSmdylBY4NdqMzywA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: 14v2eE3ZV2-EJljiZIxZMeDfohd05Fy-
X-Proofpoint-ORIG-GUID: 14v2eE3ZV2-EJljiZIxZMeDfohd05Fy-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
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
Link: https://lore.kernel.org/qemu-devel/20251021084346.73671-8-philmd@linaro.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/kvm_ppc.h | 6 ------
 target/ppc/kvm.c     | 5 -----
 2 files changed, 11 deletions(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index f24cc4de3c..742881231e 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -21,7 +21,6 @@
 
 uint32_t kvmppc_get_tbfreq(void);
 uint64_t kvmppc_get_clockfreq(void);
-bool kvmppc_get_host_model(char **buf);
 int kvmppc_get_hasidle(CPUPPCState *env);
 int kvmppc_get_hypercall(CPUPPCState *env, uint8_t *buf, int buf_len);
 int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level);
@@ -128,11 +127,6 @@ static inline uint32_t kvmppc_get_tbfreq(void)
     return 0;
 }
 
-static inline bool kvmppc_get_host_model(char **buf)
-{
-    return false;
-}
-
 static inline uint64_t kvmppc_get_clockfreq(void)
 {
     return 0;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index cb61e99f9d..43124bf1c7 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1864,11 +1864,6 @@ uint32_t kvmppc_get_tbfreq(void)
     return cached_tbfreq;
 }
 
-bool kvmppc_get_host_model(char **value)
-{
-    return g_file_get_contents("/proc/device-tree/model", value, NULL, NULL);
-}
-
 /* Try to find a device tree node for a CPU with clock-frequency property */
 static int kvmppc_find_cpu_dt(char *buf, int buf_len)
 {
-- 
2.43.5


