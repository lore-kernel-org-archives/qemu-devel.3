Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2F3CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 20:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v435x-0004KJ-JA; Wed, 01 Oct 2025 16:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v435t-0004GH-9J; Wed, 01 Oct 2025 16:06:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v4351-0001kb-PF; Wed, 01 Oct 2025 16:06:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ef1cO018505;
 Wed, 1 Oct 2025 20:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ssM6neF9LMgCpyJ/3jFzDaB4TZACQQxhHUgrNJguq
 rQ=; b=Xng/84gY7qWtvmUFPuI4sx1UNsFbv4eRwsEVY7Efv7+w+f0oupD+HekyM
 iPwbkmeDGdKqSb8Rar04IGFUBfLAgRGjOaSL+fTvd+aGyMuTsrsJaXQ1Ga8Bwvfe
 9p/9/xhvHCuZw1u3gyMi1hs/JbVxhyK4uFhbXlsiaQG3XrPvwpIhRAQ8lu8QhUxf
 7EKhq3dPB2/StmUcEMOFWstAdCkBWIxhtKCrvr7TzNQrzqU1OX+FG9rhgu0Khxju
 GUfgOdFoiAXMY13APHvILiQc6rA4uQbgH46LVK+R3wrwoQwGlM9ETvfnpM2cAade
 n5ubx1D6q6PbnY6iarzuEjHeGlvSw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhs112-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 20:05:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591H3MHL001585;
 Wed, 1 Oct 2025 20:05:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evfjafsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 20:05:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 591K5Df410748546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Oct 2025 20:05:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15D3E58056;
 Wed,  1 Oct 2025 20:05:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FFB15805D;
 Wed,  1 Oct 2025 20:05:12 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.10.212]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Oct 2025 20:05:12 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH] s390x/pci: set kvm_msi_via_irqfd_allowed
Date: Wed,  1 Oct 2025 16:05:11 -0400
Message-ID: <20251001200511.325815-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68dd897b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=Jj0JhfygQ-wBaRgng2EA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfXwRFwmB2cMUwc
 y3nl1EfsuBUCiSzThZacXVOnS01nkk2rJqXhllt66PLrkwfEghKAGuWEBibXCNZPcouCQ9zzvnl
 6+sz91RONaokYYxh8yM5YBm61h+gReRx5hZc3yXFFkvTzDqznsQZggweMkWw7TxcyR9GYPgHvwq
 rE2VWsRy21e506PU0GG/8Cep5UMxPyfnyWK4OaXQgQoimvOs4yzV64Olwu/nvXmBHHDTx9Kqs+3
 JqYUFJ2zUtNpFlfTMDU6xx4sExNPspk0IHgU8f/3nn0OhF8Vgt+ZRb0dpWS5CyuAuN5q2Hj6ivA
 4AezOjoh4bMihYIR9v1Bhg6AUhZ/VPskg0ewJ5dXmoNcCm1hyEjWe/d1TvHsqLgOfEe/LD48T1J
 Wf4+9y5yJ9uMY8rn52DRlvReXKoufA==
X-Proofpoint-GUID: 4Tj8TSeYbEwiyqHXoA5GIKuUVj6duwpJ
X-Proofpoint-ORIG-GUID: 4Tj8TSeYbEwiyqHXoA5GIKuUVj6duwpJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Allow irqfd to be used for virtio-pci on s390x if the kernel supports
it.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e8e41c8a9a..88852acf45 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -900,6 +900,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     s390_pci_init_default_group();
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, errp);
+    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
 }
 
 static void s390_pcihost_unrealize(DeviceState *dev)
-- 
2.51.0


