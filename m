Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D71C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNZP-0007Ya-IX; Tue, 18 Aug 2026 13:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wwNZN-0007Vh-Ic; Tue, 18 Aug 2026 13:25:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wwNZL-00037D-SS; Tue, 18 Aug 2026 13:25:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE3bWL505269; Tue, 18 Aug 2026 17:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5f3Wdy9B9Dzi6NSEF
 LaG+qhWLl/BGAcf0nN/W8k+vFw=; b=VIn4EnFIZIOCO7B8Ev+KRCM1ej0g37Zkb
 1ZLfSKmZsNOuLk7AeuPJpd6x/9K11Js2BCFojdGgvDGNJ1qyGUXhGWImBtpTiasU
 NXrwrBqV8BOpp3Nw7IyjKpBUhx18tBfX7E+oV+SL5DRllmPlN8YxU0ikzuzihxfC
 /eaU9yAp/RcBXkgDASUgzmMGn8bwH52GFAwwmMijOYNC86XZjlfc4HBbeaizyNwn
 vz2XnjHSE5ZoOUbS2dYSU9iCLU0i3a2P1Mjg1ucCbKPhEPcIuHF6yI8MabwrBwLH
 0zYuznSQ+/UhMkzuPVDzx7j1JSeSuq7TxiN33W5J+UaE52Jl02+ew==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4ssyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:25:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IHDmal008864;
 Tue, 18 Aug 2026 17:25:42 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq4ma4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:25:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IHPfwX51904808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 17:25:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF0315805B;
 Tue, 18 Aug 2026 17:25:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19D3058058;
 Tue, 18 Aug 2026 17:25:41 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.170])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 17:25:41 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v7 13/15] s390x/pci: Add a comment explaining S390PCIIOMMU
 purpose
Date: Tue, 18 Aug 2026 12:25:19 -0500
Message-Id: <20260818172521.223460-14-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818172521.223460-1-kshk@linux.ibm.com>
References: <20260818172521.223460-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gATwKjjem42mxASPZoRnhBTLEvUQDwNt
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a849597 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=c3lGbpyPv1M8-G6Y41EA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX5KvsZBJeyE5n
 /skt67zD75T287BZc3M556ZDAjMtJgFuIHxQWP8LJNu9CquPcXNZzVMnKjjH4tJAYuRyxN3Z0JL
 uzqZduOHg9llWluZXjmGxe8JOP9/MwY=
X-Proofpoint-ORIG-GUID: gATwKjjem42mxASPZoRnhBTLEvUQDwNt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfXxEWWUeIwtCES
 7iZdycu2OTyO1/Qk4F6t8sEfclMW+bEtr577fvzzrEzRH7P4vl7fYwDKTc/rytKmCNsbmKqhTzv
 UyHK/yVA2xFLzdawQY2Hn6lP21nqOA5tuxLUYBDMhMcW0FhGKf5iwA9j710QBYUIH5EWBUgWpBg
 FfEIUxoh9+yWq0IO37zzNBa6O10YPoqzH6dU7hpDn4zab9y+lhzA13Scm7JGbKSTF9O9XzKjQhG
 /ovoIltNUC3Ih6zf4UzcovpxAUA6TZnNFYBh1kkTkAe5z+LgTFSDmoerkRsKzf7bXLrl3ilkrgo
 +leAUOwfGhgCSfCTRGM2XL2O568ArVaOAb43MNMfGWqV0lVDGa2etN2VR9t8kUlUKV+ltQdWsk9
 tDWRfkUWIzRDJofXNImQ2V+4kW87lVKiNMO7dRwbPj4yROKO4Z2sU0dfIyJHmc7+VtiTIcIWIR8
 f8q/TyNkH6Gmy4VA0zA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Because S390PCIIOMMU has just been cleaned up of fields it didn't have to
carry, add a comment explaining why it exists in the first place and
discouraging adding more fields to it in the future.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 include/hw/s390x/s390-pci-bus.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index e3cbee2695..17ecf3e0da 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -271,6 +271,17 @@ typedef struct S390PCIDMACount {
     QTAILQ_ENTRY(S390PCIDMACount) link;
 } S390PCIDMACount;
 
+/*
+ * This structure holds the PCI device AddressSpace that QEMU needs to link
+ * into its internal structures before the zPCI and PCI devices are fully
+ * initialized. QEMU wants to have this "root" AddressSpace before the PCI
+ * device is plugged in. It's only actually used for I/O while the PCI
+ * device is plugged in and configured by the guest, at which time it has
+ * additional memory subregions from zPCI device, that can do real work.
+ * In other words, S390PCIIOMMU holds fields that logically belong to
+ * S390PCIBusDevice but need to exist before S390PCIBusDevice exists.
+ * Therefore, no other kind of fields should be placed in S390PCIIOMMU.
+ */
 struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
-- 
2.34.1


