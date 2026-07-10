Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4BFC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiCPy-0000nO-Pl; Fri, 10 Jul 2026 10:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wiCPq-0000h2-LK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:41:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wiCPl-0005Vq-Q3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:41:20 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ADIGZB1713152; Fri, 10 Jul 2026 14:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5sUN3aY1SEIaIMqzM
 /v+nyCI8fuHCvxkw6Kn4YZhYdc=; b=MFIz0Ur0SydITEZnHAA5j+iEYmBK2H1An
 FK8X+6RgVm2l2xa9F384qB7PTjGKQ08s/EFkqHMtdGv4GhGNXCOMqLUcj//Gkag9
 h2/2MvCJaBZPMJTQT283EkHoF62JMRRK1emgltfsa41qE1s4LPftXAeJyhqYbFic
 LIZQUVuoT23eXlX/vs8RbORz26Ajdpyr6oTbn1MROB2Of9mARrCFpYEN94MO506Z
 FqQ7eNhoYaypBlxc6ES8ZjKrdNm1xW4yLSeWbe8kNFcYEZ8M2tiaoa4XMnaTlHkH
 HYiLsWEkRFdtUUD6oP46SayFOqdk4LfVd+igTte9YebaxeFRDtwCg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur6yx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 14:41:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AEJwTn023925;
 Fri, 10 Jul 2026 14:41:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkjf0c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 14:41:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66AEfCs49044642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 14:41:12 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 286BD5805C;
 Fri, 10 Jul 2026 14:41:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A79CF5805A;
 Fri, 10 Jul 2026 14:41:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jul 2026 14:41:11 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Mohammadfaiz Bawa <mbawa@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 2/3] hw/tpm: gate PPI support on tpm-tis-device behind a
 device property
Date: Fri, 10 Jul 2026 10:41:07 -0400
Message-ID: <20260710144108.621828-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710144108.621828-1-stefanb@linux.ibm.com>
References: <20260710144108.621828-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE0MiBTYWx0ZWRfX7rb1cB3DLshg
 WQ5PXrYS18JlvzOC2y1Mc9DcCj3GXWP/aMnN7IiKw2BJPepS6rSfUXcKO6OBWStaUrRf29NE3T4
 96WWYOf9zuNVCCyWInw/b3XwXI/gr6Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE0MiBTYWx0ZWRfX09qJGfYJ2vQl
 dr/qUJELWTByOI29tfQVN4hB2qh+u2phx6PyAAvokVgotwU5IJ8LFPg8MhcJZ4wlkgnYD+edodz
 R6YjxZPJ8sdU6CNyis6WKcxW8X/t5aMZ8yQf0LbdsB9Rc2oXVKAti35h9n0R8g/zQmkBIKjdBIW
 mFAXjYAn7PG84JrTfkwCVuquGz+0xaYlXqwj/eOAnU142eoEWBTwSvolb8cslA/zljliEESeqbs
 z6Mny0XI7DK2xkrcnpXl1C0MGb1aeVIZ3jEHDUBFTUiDZvUepMWa/qTIQXY/pzH0WQdnt8t31AY
 59ORqGoM2/UTNTQQaum3qX/M9GlNBjDAfwMEUNjyJ26yRo8q0iUqLeJEbPro2ycj8bpsKxLn0LG
 1KCDwuypRHoO61Ux/XW0YJvUDI8w+tQQjiBoc/xQgop+yjuR0qb9QImdDdsRljYlwux+eayv4AL
 uKq0g4TiqqVw05gLGiA==
X-Proofpoint-GUID: rGhlN8FMs48yqR8SX0_HQcMWqLFCQxlQ
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a51048a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=QC3pr3st6DBKPxuHkVwA:9
X-Proofpoint-ORIG-GUID: rGhlN8FMs48yqR8SX0_HQcMWqLFCQxlQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100142
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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

From: Mohammadfaiz Bawa <mbawa@redhat.com>

Add a "ppi" boolean property (default: true) to tpm-tis-device.
When ppi=off the RAMBlock is never registered and the migration
stream omits "tpm-ppi", restoring backward compatibility.

Move sysbus_init_mmio() calls from instance_init to realizefn so
the memory regions are initialized before being registered.  When
ppi=off, the PPI MMIO region is simply not exposed.

Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM64 virt")
Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260619093140.832136-3-mbawa@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis.h        |  1 +
 hw/tpm/tpm_tis_sysbus.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 1531620bf9..6ac9804050 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -76,6 +76,7 @@ typedef struct TPMState {
     size_t be_buffer_size;
 
     TPMPPI ppi;
+    bool ppi_enabled;
 } TPMState;
 
 extern const VMStateDescription vmstate_locty;
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 16bb17874b..a7b0002d82 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -94,6 +94,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
 static const Property tpm_tis_sysbus_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
+    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true),
 };
 
 static void tpm_tis_sysbus_initfn(Object *obj)
@@ -101,9 +102,7 @@ static void tpm_tis_sysbus_initfn(Object *obj)
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
     TPMState *s = &sbdev->state;
 
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ppi.ram);
 }
 
 static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
@@ -122,14 +121,19 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    s->ppi.buf = qemu_memalign(host_page_size,
-                               ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
     memory_region_init_io(&s->mmio, OBJECT(dev), &tpm_tis_memory_ops,
                           s, "tpm-tis-mmio",
                           TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
-    memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
-                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
-    vmstate_register_ram(&s->ppi.ram, dev);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+
+    if (s->ppi_enabled) {
+        s->ppi.buf = qemu_memalign(host_page_size,
+                                   ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
+        memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
+                                          TPM_PPI_ADDR_SIZE, s->ppi.buf);
+        sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->ppi.ram);
+        vmstate_register_ram(&s->ppi.ram, dev);
+    }
 }
 
 static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
-- 
2.55.0


