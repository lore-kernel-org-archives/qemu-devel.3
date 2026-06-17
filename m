Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD160CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZmw3-0005jR-Md; Wed, 17 Jun 2026 05:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZmw1-0005gR-JV; Wed, 17 Jun 2026 05:51:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZmw0-00042x-3a; Wed, 17 Jun 2026 05:51:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8mNUi4104945; Wed, 17 Jun 2026 09:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3SRQo6
 RJt5klM2Ao63c4+ZofLEOpcRnCy190aKVi1O0=; b=j9DNjEDFZYTsebcI+Me0u1
 4DGJDtv4U+8NuyLCSqWNZiGrGfaxfpu56PgPpbQmrauwCQmf6G+P/nLrMh420IqS
 ZEk30bZ/DNFyDMtVV9/8eVylwHNCyzM0XaSSkrF/4pigdXMaZUCupyAHLpu5kZ3f
 ucuD9nP9rXChK7Ph2Gg9cycZS45zTuSZIkCjCiqB5Ca7dJEp5vjLeGqWwyT7B3E9
 a7JrJjgQZwD7IHN7VglO4Xaxbqj5E2C08uUJsdUEJOWE8xnNXP9vh1GQN2LV5nZo
 xS7XHxjui+AHr/xdI7or/1F7SYHdurJ20SDTKt5CoFhAGzLm70IjrQCDDtkRHf4A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvt9cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:51:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9nfx2026006;
 Wed, 17 Jun 2026 09:51:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvajha5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:51:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H9pQAr33227448
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 09:51:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 337C45804B;
 Wed, 17 Jun 2026 09:51:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 928B458063;
 Wed, 17 Jun 2026 09:51:24 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 09:51:24 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v5 9/9] pnv/phb5: Mask off LSI Source-ID based on number of
 interrupts
Date: Wed, 17 Jun 2026 04:50:58 -0500
Message-ID: <20260617095058.652789-10-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfXwosyrUpyhlzQ
 dKJAqaMMfZSBdwFeZu225SqRSqHVNHjFLA2IvwanCFWWk2UV+pLMWu8v6czicv+FWI2qj3dYQ7J
 0WVjlSnIwXHYZpZNivWsvhYEgOIxuWA=
X-Proofpoint-GUID: 5jn0WmN6PvwzNjY4xZAu8QKX0tTtE3BP
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a326e21 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kUKHeS9f1dJEPYFD:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=ohFWfSm2bDoDx7FHwYQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: 0g7TcikoGpS5h8-T1rleNiLOlukA2pz0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX9Y+der0zTFDR
 nOAkxT9rBsn6EF0wEwmx17mtKiF17+Dif/MBG+ZEzEuJVuZhWJxXf+RzfELhXVzRwwe+igJa2q8
 OVwafWMnWY2OZnliuNRe6EZOHfW0CTmtb7XGMP1zwE5lYT1XnX3ScyLKvf0uHVwRFT7BCgsEteE
 q8+VhwT1t7iRJO9ZMwRx1UwVJOH66EPqmv1qYoz8bYlGVcEq9fL481m9+JWdZCLgYqv4TNgk8aL
 dOl0n11e/+u5OOwz4OML++9UmUUTUUnE8bRaWZJk4O6U8O0haIy1n0qKNCmLx2SoP+HUZ7omZ5Q
 xStu/djxBsla0u1W4L+/KAgrbehpymBvd7wOXEDFd9UZgVExoM3Bu+CkVDyhLAH015hxW3ue98z
 hJUTy8afII8JXGWVjPhkq7Vbe5BLvfKvzb+2iEXK1MW/ipcRkow0d861UcJFPdsu1LTgm7d0H0c
 CmRrd3v0PMbAIACkGDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170092
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

Add a method to reset the value of LSI Source-ID.
Mask off LSI source-id based on number of interrupts in the big/small PHB.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Jishnu Warrier <Jishnu.Warrier@ibm.com>
---
v3: Updates for coding guidelines.
v2: Introduced method pnv_phb4_xsrc_reset().


 hw/pci-host/pnv_phb4.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 91b2064113..08c96aef7d 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -491,6 +491,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
 
     lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
     lsi_base <<= 3;
+    lsi_base &= (xsrc->nr_irqs - 1);
 
     /* TODO: handle reset values of PHB_LSI_SRC_ID */
     if (!lsi_base) {
@@ -1943,6 +1944,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4Class *phb4c)
     /* TODO: Add more RO-masks as regs are implemented in the model */
 }
 
+static void pnv_phb4_xsrc_reset(PnvPHB4 *phb)
+{
+    phb->regs[PHB_LSI_SOURCE_ID >> 3] = PPC_BITMASK(4, 12);
+    pnv_phb4_update_xsrc(phb);
+}
+
 static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
 {
     STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
@@ -1999,10 +2006,11 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
     PnvPHB4 *phb = PNV_PHB4(obj);
 
     pnv_phb4_pbl_core_reset(phb);
+
+    pnv_phb4_xsrc_reset(phb);
     pnv_phb4_err_reg_reset(phb);
     pnv_phb4_pcie_stack_reg_reset(phb);
     pnv_phb4_regb_err_reg_reset(phb);
-    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;
 }
 
 static void pnv_phb4_instance_init(Object *obj)
@@ -2076,8 +2084,6 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    pnv_phb4_update_xsrc(phb);
-
     phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
 
     pnv_phb4_xscom_realize(phb);
-- 
2.52.0


