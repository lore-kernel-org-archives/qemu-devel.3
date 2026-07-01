Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CB3C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1tA-0003eB-Su; Wed, 01 Jul 2026 16:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1t7-0003bL-Et; Wed, 01 Jul 2026 16:50:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1t5-0004Mg-6n; Wed, 01 Jul 2026 16:50:29 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661Gmh3a1594131; Wed, 1 Jul 2026 20:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/5VeWfYK0Mfp0id+Y
 YxGwHSgH49IgdJXxZd+a2zOPy8=; b=LHNHZBWMzSZUxiUSHdikMnnRzupyeeOY+
 QkEEW4bAsljicL0ObOtJm7RweEbO6qlbWB8s164bjBpoaz3doht6HadvJ9zhSd28
 8aPpiXaKvXHd9mp/EBUAwD/bBe7rfrfzHzX4FCab1ZXJZGmRz0Qry52I3UxBp//0
 yW/2OJhEDuABL4QbXYB96GrVnIPpQ1reJD50KkAcXqYseYoWBp0PUfuIiMSq8xDk
 FbEPL9th8q5qjBui345oc9cI5exO39HDomFcc4GSxC0q8LHug5n7lWE5r2fqkB7F
 RloCgGWAdayp1LpuGz21rJfFWOtb2jdrUqOJow1NJbm2PY6pY8qgw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg6m98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:50:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661Kndvi006289;
 Wed, 1 Jul 2026 20:50:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhygu5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:50:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661KoLeD61538608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 20:50:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CCA85804E;
 Wed,  1 Jul 2026 20:50:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 643815803F;
 Wed,  1 Jul 2026 20:50:18 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.149.234])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 20:50:18 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v12 18/35] hw/s390x/ipl: Rework s390_ipl_map_iplb_chain for
 certificate storage
Date: Wed,  1 Jul 2026 16:49:04 -0400
Message-ID: <20260701204922.1320349-19-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701204922.1320349-1-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a457d8f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=xj6Z2pgGhtYFzPFpXM4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX1a9vuriILmqS
 iRasp5mAiaVWPwFmt5f9fgrxlSFFIMYRKh80uzWuJhdddod5B9RsO7fJjq5SwrMDmCKhvKXULw8
 qv3p4+R2eetBQUw0XVr9FuQRwEVen0k=
X-Proofpoint-GUID: pSUaGdaAZYYuyefh12FQX6h8WJOddPsD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfXwRiwNEfyZOSy
 0pqUTjq736iUDarhuxYvw+kfKUPfRiP+osUIdUgGoTpOSVO+kn/wg7tUWcaIoqfGdZmPd5d9Tnd
 th65NhnLwotRtP+oheIfNurddHzc2lLTcSy6wwjCpNdnJ4HmmcVdYh7qydARhmALYxJjBHPuqef
 uInXO0l89DjQ3jBCANTwVg9s7JYNKYWUojSJnTHNPj0YTET9xCvtt57Y1nGYqAFYHJnU2Hk+E0n
 fFK0EgVzNQSc/U8J1qvySnkDKOG2XabSIpwA5ZZxh3UvtOynm3GcA6DnAWVGZaAO7NfunJfTLT1
 uMZXjZcnOvmL3jiQpi1T4IaQlq/nxcePUvIZQQ3LtJV4hqVNw5n3/dlKeA2g+6qFlVKmJZQdw0O
 HwzhawD6DMobqB56O0NxchnYzwQ98ahPACe59INTfB5IIBBvQfy2+/TUrDd7gM9j2YyzP8ldXOw
 t5GXhjvPdzqOuAfObXA==
X-Proofpoint-ORIG-GUID: pSUaGdaAZYYuyefh12FQX6h8WJOddPsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010222
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

Rework s390_ipl_map_iplb_chain to always allocate maximum memory for
the IPLB chain, regardless of the number of boot devices. This space
is also used to store certificates during secure boot, providing a
safe location for certificates until the kernel reads them during boot.

Rename next_iplb to ipl_data to better reflect its multiple purposes:
storing both IPLB chains and certificate data.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.c              | 13 ++++++++++---
 include/hw/s390x/ipl/qipl.h |  2 +-
 pc-bios/s390-ccw/iplb.h     |  4 ++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 9cb41511e8..7734b6edc7 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -425,10 +425,9 @@ static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
     return pbdev;
 }
 
-static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
+static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain, uint16_t count)
 {
     S390IPLState *ipl = get_ipl_device();
-    uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
     uint64_t len = sizeof(IplParameterBlock) * count;
     uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
 
@@ -629,8 +628,16 @@ static bool s390_init_all_iplbs(S390IPLState *ipl)
             dev_st = get_boot_device(i);
             s390_build_iplb(dev_st, &iplb_chain[i - 1]);
         }
+    }
 
-        ipl->qipl.next_iplb = cpu_to_be64(s390_ipl_map_iplb_chain(iplb_chain));
+    /*
+     * Allocate maximum space for IPLB chain and/or certificate storage.
+     * Once a valid boot device is found, this space will be used to store
+     * certificates if secure boot is enabled.
+     */
+    if (iplb_num > 1 || s390_has_certificate()) {
+        ipl->qipl.ipl_data = cpu_to_be64(s390_ipl_map_iplb_chain(iplb_chain,
+                                                                 MAX_BOOT_DEVS - 1));
     }
 
     return iplb_num;
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index a2180719b1..2b29dfa8c5 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -61,7 +61,7 @@ struct QemuIplParameters {
     uint32_t boot_menu_timeout;
     uint8_t  reserved3[2];
     uint16_t chain_len;
-    uint64_t next_iplb;
+    uint64_t ipl_data;
 } QEMU_PACKED;
 typedef struct QemuIplParameters QemuIplParameters;
 
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index c92a3d0f0c..c807e7f49b 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -61,11 +61,11 @@ static inline bool load_next_iplb(void)
     }
 
     qipl.index++;
-    next_iplb = (IplParameterBlock *) qipl.next_iplb;
+    next_iplb = (IplParameterBlock *) qipl.ipl_data;
     memcpy(iplb, next_iplb, sizeof(IplParameterBlock));
 
     qipl.chain_len--;
-    qipl.next_iplb = qipl.next_iplb + sizeof(IplParameterBlock);
+    qipl.ipl_data = qipl.ipl_data + sizeof(IplParameterBlock);
 
     return true;
 }
-- 
2.54.0


