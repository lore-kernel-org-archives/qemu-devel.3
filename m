Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBF1CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZmm-0005oQ-Hh; Tue, 29 Sep 2026 11:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBZmi-0005l7-EA; Tue, 29 Sep 2026 11:30:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBZmg-0007x4-Sy; Tue, 29 Sep 2026 11:30:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5qCw2783868; Tue, 29 Sep 2026 15:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=kGVW12x7jrfiW0Z8E
 diUPMMHPoT5WefuYpzw71twZjY=; b=Yb6R7NvHB9afLjWjGrVr5hvlZCL59+acH
 DsVjnMXsyBg5pEzTcwUStjNCm1J4DBiBEbhqx/XMcdpxKhAByUSKItn+76DKM2yA
 j4L1mGIPM4iBL0JhhTVhpScNFKOl9sua5Vf3q75n/DTPto4kBo2ttUg5qeWtBqY4
 rueRgkZgoh9mVVRVpkeMavjsf9LJFH2pGXUyT4OuMucuX2D6CC+QamH//3Apq1n+
 21okqgL5fgrI31lafLBWMH1LCLYz4f8+44Kod4GJgpDfMTcrnPARhWI+b1yYLvFm
 rOTk01D9QAAGVq6dHKPdJOmUfUdha5iIm5OrLpT3pu3y/J07cJxCg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe76s1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:30:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TF4Vuu1647414; Tue, 29 Sep 2026 15:30:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2ya30y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:30:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TFUGdT33948390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 15:30:17 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E516A58043;
 Tue, 29 Sep 2026 15:30:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 286A958055;
 Tue, 29 Sep 2026 15:30:16 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.92.210]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 15:30:16 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH v2 3/3] s390x/pci: Reject apertures beyond IOAT capacity in
 translation mode
Date: Tue, 29 Sep 2026 11:30:12 -0400
Message-ID: <20260929153012.774530-4-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929153012.774530-1-mjrosato@linux.ibm.com>
References: <20260929153012.774530-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abbd98a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=xSIT066dgqKBegNCQIUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX4nuwCLIelXx9
 iZpeMmHzmy0LzPkO7SdUQIPKFl/MAwYTFsXwlqM91QJX4RSd6ISoIFwHCmmgwsZwOeW81ZcJNCi
 7jTXxbxt1hIOA7LYKtJBa/SaP17CfmE=
X-Proofpoint-ORIG-GUID: zayWjr5cS35Bw2CiQ9k2UNkfxjwv4lLz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX+mbJcxxhGDkQ
 /2at3oyQJmbmp3pYS0ZtPMzq5pe6kRW0Dwt95w3jOXx+dh8XSrkH1xMRf2bw/Il6AJKxtzZxXUK
 g/k0fyKDtI/yE38LPcIqD02p6Lq6uslKhyOnURfXo0t5SAhlYqXTPJMBVa8CMUA3OzGWD8lWTM6
 y75JRkT21NNGt1ROZZ1B4Yp0ddkaAcliOdsrY0K7/PrM1ucG0J8szZXj/SHxDLQnjYLrYkztmzG
 M0D8+PzNVtwR6Czxu1aNgB5bmjRUQTDllsNZ9xj+79r2MJSC2FiY+4UF07luDgyuMb7+7mK22WH
 Prd7aDXEumQRrF6eoPcthXDkeX/VXFWqI3YgtoXUZp+IpffQT/E0t5r1ejuXK0VadrtCWwh1Gmm
 3ve7Sz4LFmernNlRZuYLs1n0suAG3L4wpcB398QIsprK58PDrjFMMsR7I+5Txef8Hn/6B4d6P32
 v+AbxD8njMErdZ61VNg==
X-Proofpoint-GUID: zayWjr5cS35Bw2CiQ9k2UNkfxjwv4lLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290060
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

In order to support direct mapping (which is only bound by the aperture
size of the underlying host EDMA reported via vfio) QEMU reports the
host-provided EDMA to the guest.  However, when using translation mode
QEMU only supports up to 4 TiB currently (the size of a single RT
table).

Reject attempts by a guest to register a translation aperture that
would exceed what QEMU can support by giving an operand exception on
the MPCIFC instruction that requested the large aperture.  This
restriction can be removed in the future if/when support for additional
IOAT regions is added.

Cc: qemu-stable@nongnu.org
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c        | 15 +++++++++++++++
 include/hw/s390x/s390-pci-bus.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 73417edade..09026360d4 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1054,6 +1054,21 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
         return -EINVAL;
     }
 
+    /*
+     * We report an EDMA that may exceed what QEMU can handle in support
+     * of direct-mapping.  If the guest attempts to register an IOAT that
+     * is too large, reject it with an informative message.  Only direct
+     * mapping can be used for guests of this size until support is added
+     * to QEMU for additional IOAT regions.
+     */
+    if (t && pal >= ZPCI_TABLE_SIZE_RT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ioat pal 0x%"PRIx64" exceeds max translatable address\n",
+                      pal);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
+        return -EINVAL;
+    }
+
     iommu->pba = pba;
     iommu->pal = pal;
     iommu->g_iota = g_iota;
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 9228523ce8..f182bab246 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -140,6 +140,7 @@ enum ZpciIoatDtype {
 #define ZPCI_PT_BITS            8
 #define ZPCI_ST_SHIFT           (ZPCI_PT_BITS + TARGET_PAGE_BITS)
 #define ZPCI_RT_SHIFT           (ZPCI_ST_SHIFT + ZPCI_TABLE_BITS)
+#define ZPCI_TABLE_SIZE_RT      (1ULL << (ZPCI_RT_SHIFT + ZPCI_TABLE_BITS))
 
 #define ZPCI_RTE_FLAG_MASK      0x3fffULL
 #define ZPCI_RTE_ADDR_MASK      (~ZPCI_RTE_FLAG_MASK)
-- 
2.55.0


