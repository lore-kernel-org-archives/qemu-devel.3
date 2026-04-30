Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52EDCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 06:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIKf8-0002yP-9H; Thu, 30 Apr 2026 02:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wIKez-0002vi-CN; Thu, 30 Apr 2026 02:14:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wIKew-0006GL-Gs; Thu, 30 Apr 2026 02:14:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TFUqqp1317126; Thu, 30 Apr 2026 06:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=I1hsOJZQR2XGOk7WI
 H8LLfPojJ5cB30a2SQsOUbn0oU=; b=E9kEm3Q7SEJCEDJ1Wlqdl6QdDNWO4uaY8
 OdS//P6q2nEKbTXWL+2rNtMTFwtjfyxggppL61EeYYtI5UWMBvRcBcdmlfD5CQJK
 y2N1VvtgbRpleh71LtuxOubno0WH2urEoTofS6n3Ua31cCS6A/UxqC0C8jI6X+Qq
 4wNeepwqEkPJZEnHVirPuOR/sjAqODKCZvvg7MElfPfm6T6PSuZt5Pn3Ne0Kc9VU
 3qrGHTsIAMIdSgDK57WksIevioO576aK8EXTOeY0Y2FwS1OMMycwUGq+4jtrq2Di
 vTbkyaS87mxJO339Q+z2BxfbND+IiqdwCqcixLcbcFON55yXfqc+A==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jvq79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 06:14:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U6CYqc028392;
 Thu, 30 Apr 2026 06:14:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw1rn5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 06:14:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63U6Du6D30605936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 06:13:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5294120043;
 Thu, 30 Apr 2026 06:13:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEECC20040;
 Thu, 30 Apr 2026 06:13:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.70])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 06:13:53 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/ppc/spapr: Do not fallback to raw mode when KVM
 rejects compat
Date: Thu, 30 Apr 2026 11:43:32 +0530
Message-ID: <20260430061333.37905-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260430061333.37905-1-amachhiw@linux.ibm.com>
References: <20260430061333.37905-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfX6VCigxYIKKr0
 b/8YiwUEaMyKVkRjAs4p7vcXuyXokQ64IcFPMhrNOabc3SlybJntLquRAQrlcWlUT/fmJQNrRUn
 rczP/whc6ixPACFovwVR/acpuhX9LjL00O5rZWA/BnA22+L/ke4tsok765c0oL7Kxyq9l7YW+Zk
 xhGMGqOz489Hihl1mR96GGysE5dWwRXes/9YSe462JnydwGJOFJItlsYxVqHXA145IqiWfTtEfe
 MP/OJ+Ti/NkqqXhO9bgzXh63+Fo2/fngyPHG9InXz+iN257dXKtPREifB+a8LSk7AnaI7H4hvqp
 7j2o6OJls3dKPKMHJ2p5dYUmob2nFVBySjTf1X7xnczhDDNZX9lxj1YRbiSK6dDUd5aQfEAkGxd
 hPRbFqIYh1nc9NJAJCxmzwEAMXLwzn3g89zmUJPZjn86okorga66/2gqCbteeDuX/jGVhxR2a7v
 w15vJTXHu5DZXvgDPrA==
X-Proofpoint-GUID: uyRCmT0r1xCx0KyvyebRTrbDtt7UnBtE
X-Proofpoint-ORIG-GUID: ZDy38hcoxYTltlot8ycqj1HW3oiC3TMj
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f2f329 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=i5GS84888sUNcPDMq4UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300055
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

During H_CLIENT_ARCHITECTURE_SUPPORT, QEMU attempts to set the requested
CPU compatibility mode via ppc_set_compat_all(). If this fails, the
existing code may fall back to raw mode when supported by the guest.

The current logic treats all failures uniformly and tried to fall back
to raw mode whenever possible. As a result, errors from KVM (e.g.
kvmppc_set_compat() returning -EINVAL) are silently masked, making
debugging difficult and allowing the guest to proceed with an
unsupported or incompatible configuration.

When running with KVM, such failures indicate that the requested
compatibility level is not supported by the host. Do not fallback in
this case; instead, report the error and fail the CAS negotiation.

This makes the failure visible to the user and ensures that invalid
compatibility requests are rejected early rather than being hidden by
fallback behavior. For example, the following error is now reported:

  qemu-system-ppc64: Unable to set CPU compatibility mode in KVM: Invalid argument

Fixes: cc7b35b169e9 ("spapr: fallback to raw mode if best compat mode cannot be set during CAS")
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 hw/ppc/spapr_hcall.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 032805a8d0db..de2ea6f5e579 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1204,6 +1204,15 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
         Error *local_err = NULL;
 
         if (ppc_set_compat_all(cas_pvr, &local_err) < 0) {
+            /*
+             * If KVM rejected the compat mode, do not fallback. This indicates
+             * the host cannot support the requested level.
+             */
+            if (kvm_enabled()) {
+                error_report_err(local_err);
+                return H_HARDWARE;
+            }
+
             /* We fail to set compat mode (likely because running with KVM PR),
              * but maybe we can fallback to raw mode if the guest supports it.
              */
-- 
2.50.1 (Apple Git-155)


