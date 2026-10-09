Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E52FCA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFL1-0000az-0g; Fri, 09 Oct 2026 14:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKr-0000YK-05; Fri, 09 Oct 2026 14:28:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKp-0001gf-1i; Fri, 09 Oct 2026 14:28:48 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Ha4ZH3714694; Fri, 9 Oct 2026 18:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pL2hA9L+liZfL864u
 t4GIWMcI/zNawbAGRU46zM/+Js=; b=W6Dcshjost+iaAyIkjObESdeiL0URXDoE
 YBj5bxK3tFx8LoszZEShkmVJ+rb7129vaO8Jd8Un/omTUcraH5NP7YdgtS+sCD5/
 y6c34NZMIO/pi9co5hfIwXGMNgtA4dlsdoMSO+ccyw+FZXUDtMNc20C6x8v2AKns
 jlIioInPxy+kV+4k5Ombs886tb3ihiDxaq9jcZdEJa8lPZ511HDqSTKeQWZUceyx
 gZpQeuVeImdwYvnuiab6WtegwSxICCmzbSHOgAJ9lszn2tXWUXXZkhGmlZiXy6ju
 edku8BG2AEV+B4/OzQyGF7yc6KCeX2k+L+G0Un6o53TgA3Jzf720w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74ter889-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8JEj1162579; Fri, 9 Oct 2026 18:28:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6v76t5fp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699IShdm17171184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:28:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EBC05805D;
 Fri,  9 Oct 2026 18:28:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57EDA58054;
 Fri,  9 Oct 2026 18:28:42 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:42 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 13/19] s390x/pci: Add a comment explaining S390PCIIOMMU purpose
Date: Fri,  9 Oct 2026 14:28:19 -0400
Message-ID: <20261009182825.148054-14-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nrc-YUDXN-M80N26nGE3bt0j-o6QfeyL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX2b54VQhGE1bB
 dsRetbeZ6XEUCg9d/SPc1Nu4OIjlVsqJiq97WiMACidF4AdZR0pyKABp/kUwjyV6Xcb/XFJemPG
 sRdah7I/vobu5Vq7Ku10Xjp2E7PuTpcwF5W3DzVmRT0yUxdEQCu0/sObkO/MKSbdBMUfzRTrDnR
 DUkFPz5BRvCp/X5TwJX+CwQTTivm2LwYWsqbXxPqLXyMlh27+xYX3TRQMd1vRZwx+NfX8fA2Xe9
 EI0thORPoWCFwiHgkt4xSGn11OahNaVx/XA/nXcSHVAk01OGFwc7ALG/WERg1tyM3fXSOJZtFbg
 Hcu8jr9BMhatJm9H5swAUVL5FXZ+1R9ML7sYGkPlJRqLhp8cyGtGy7IWi/jtCg9INne76pxsqyW
 UZCZcB6BZ815QMqoihl52Iffa6+wIDOmbsa61DD+yMt/gF9NopLaoR269OelzDLhY+ATDviyPZo
 Ps35Iov4jEN5IAC+Y5w==
X-Proofpoint-GUID: Nrc-YUDXN-M80N26nGE3bt0j-o6QfeyL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX+7vE1ZeQX8ru
 xy9pMMPnVVBnbHV/qRYZqVTTRc0CJs7qdr6IXEYFbLCTvRTiQrxpWcBIRDq1Y5SsW81ON1tiUEH
 sO7ZzdaEIs2N7kHtDL2Q2mhFP5jPJvs=
X-Authority-Analysis: v=2.4 cv=Nf1zRGD4 c=1 sm=1 tr=0 ts=6ac9325d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZRniq8bwHbVzLMTk7X8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

Now that S390PCIIOMMU had been reduced to only the IOMMU container
information needed by the PCI layer for the associated slot, add a
comment explaining the purpose of the structure.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261006001643.420929-14-kshk@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 include/hw/s390x/s390-pci-bus.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index c7fa7b9514..5c2d07e38e 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -272,6 +272,14 @@ typedef struct S390PCIDMACount {
     QTAILQ_ENTRY(S390PCIDMACount) link;
 } S390PCIDMACount;
 
+/*
+ * This structure holds the AddressSpace for a PCI device slot. It must be
+ * allocated before PCIDevice registration completes, specifically to satisfy
+ * the get_address_space IOMMU callback invoked by do_pci_register_device().
+ * The root MemoryRegion is otherwise empty; DMA translations only become
+ * functional once the guest configures the device, at which point
+ * s390_pci_iommu_enable() registers the zPCI translation subregions beneath it.
+ */
 struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
-- 
2.56.0


