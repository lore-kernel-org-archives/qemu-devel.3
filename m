Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D105C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgee2-0004Om-Ro; Mon, 06 Jul 2026 04:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedf-0004IX-Vo
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedd-0007nI-Pv
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665MIfSa2198707; Mon, 6 Jul 2026 08:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=F+xHqS
 JgmpNbfFBoxOJrnRFWjV/BZfFh4cVhMR9k5zg=; b=BBeMcMej132wXyzU8x6BPj
 sVxiP/89AT94EKSxjOUTTfwEvZkxMtX4gA/c4Hlk3AMwyQG9eEcUvZUcsnCGqPjj
 Oe/7v810CoA6sVGjxEWjhMGZFUntmLmSZZGPUdLH3RADtH3/81CdR62EeTGyUkgf
 hZyTgTm+ypFk+xtyOFxXrchhfuLPM9/LAuRRpc4IqC2pBHo7YcJ52gwinJGp4uY8
 CNRG9xsIwgGCM2nkqFZrAkSqp5+SbNY7O8RnaBHplXn8Z4vZk+53I6YBto87S3xJ
 7ap5lsTxiz480EWbZMZW+obptdhYxRR+9A7Ww6zgE+3+Dkpb6I4YdHJPUOnNf0Mw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4ge0c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:25:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668JiGi024478;
 Mon, 6 Jul 2026 08:25:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4mns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:25:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6668P6ja43057468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 08:25:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 661642004D;
 Mon,  6 Jul 2026 08:25:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 605CD20043;
 Mon,  6 Jul 2026 08:25:05 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.1.190])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 08:25:05 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>
Subject: [PULL 6/8] ppc/pnv: Remove Power8E and Power8NVL pnv chips
Date: Mon,  6 Jul 2026 13:54:49 +0530
Message-ID: <20260706082451.59299-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706082451.59299-1-harshpb@linux.ibm.com>
References: <20260706082451.59299-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xV1g1rzL48o5j7a5VMzC3NmjpauQcuCR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX2TNyhDjMVENM
 sxPxFuc7erp/zuUV22Zj20nk+jsILPqL1/33jt0j0wLr5QogCIpmXi3bxOxVQoftZub1MRVgYRn
 eGYo0HMH730fGj2A2QfQQB20v2OZ+lHY42RVsnj+dXy/r+gqk+9DLMiFWoDIVWQ6RilxwKcBab1
 fJcEeTHO6aVrrHC0Zt31nax3R6ZW2/TTa+cQAt5peKCnibwo4NUenW2h933XUB42UqHjTTNbDzi
 ZxpYWW03I9Pg5EKVW56tph1Lgp5zP5++9slYBd/WtuGwyvSubUnK/HuI9Lwcp44dwMd56+OSnG0
 L1DaOfUOwxfD0BZPkWY6hCXKjRcDsbkDwJ8GioKMzFl8vuQlI9wKOhL6qLrP8sI1yCoPyv6IERF
 iRKwJbyq/Zv7haXeWgO123W0a0YBEw+etOmjgDw0SpBnxZ9oeEboS/o1x8Tna6XfoyuDUSt8TCB
 gjzhcF8vyJ3aOJeXGpw==
X-Proofpoint-ORIG-GUID: xV1g1rzL48o5j7a5VMzC3NmjpauQcuCR
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b6667 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=VZAblS4EJK4kQvDgE7QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX/HyCMuxUeost
 sbkQxzZzq2O13asUhwv2mlbkkKyG3f5IomxLRWiV5MlU02f13wI5WpK3s73oITNAT4znrTg3g/N
 DZQwLytqH5ka2ApBjGFSs9d+rXCH024=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

From: Aditya Gupta <adityag@linux.ibm.com>

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

Accordingly, remove usage of 8E and 8NVL chips from powernv, as it's old
and unmaintained now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260703085955.2318600-7-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 docs/system/ppc/powernv.rst |  2 +-
 include/hw/ppc/pnv.h        |  8 -----
 tests/qtest/pnv-xscom.h     |  9 ------
 hw/ppc/pnv.c                | 62 -------------------------------------
 hw/ppc/pnv_core.c           |  2 --
 5 files changed, 1 insertion(+), 82 deletions(-)

diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
index 5154794cc8..1de696b588 100644
--- a/docs/system/ppc/powernv.rst
+++ b/docs/system/ppc/powernv.rst
@@ -15,7 +15,7 @@ beyond the scope of what QEMU addresses today.
 Supported devices
 -----------------
 
- * Multi processor support for POWER8, POWER8NVL, POWER9, Power10 and Power11.
+ * Multi processor support for POWER8, POWER9, Power10 and Power11.
  * XSCOM, serial communication sideband bus to configure chiplets.
  * Simple LPC Controller.
  * Processor Service Interface (PSI) Controller.
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index f8234fb3cd..60e902d9c5 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -39,18 +39,10 @@ typedef struct Pnv10Chip Pnv11Chip;
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
 #define PNV_CHIP_TYPE_NAME(cpu_model) cpu_model PNV_CHIP_TYPE_SUFFIX
 
-#define TYPE_PNV_CHIP_POWER8E PNV_CHIP_TYPE_NAME("power8e_v2.1")
-DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER8E,
-                         TYPE_PNV_CHIP_POWER8E)
-
 #define TYPE_PNV_CHIP_POWER8 PNV_CHIP_TYPE_NAME("power8_v2.0")
 DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER8,
                          TYPE_PNV_CHIP_POWER8)
 
-#define TYPE_PNV_CHIP_POWER8NVL PNV_CHIP_TYPE_NAME("power8nvl_v1.0")
-DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER8NVL,
-                         TYPE_PNV_CHIP_POWER8NVL)
-
 #define TYPE_PNV_CHIP_POWER9 PNV_CHIP_TYPE_NAME("power9_v2.2")
 DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER9,
                          TYPE_PNV_CHIP_POWER9)
diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
index 8e882dac9d..c4c42c6946 100644
--- a/tests/qtest/pnv-xscom.h
+++ b/tests/qtest/pnv-xscom.h
@@ -12,9 +12,7 @@
 #define SMT                     4 /* some tests will break if less than 4 */
 
 typedef enum PnvChipType {
-    PNV_CHIP_POWER8E,     /* AKA Murano (default) */
     PNV_CHIP_POWER8,      /* AKA Venice */
-    PNV_CHIP_POWER8NVL,   /* AKA Naples */
     PNV_CHIP_POWER9,      /* AKA Nimbus */
     PNV_CHIP_POWER10,
     PNV_CHIP_POWER11,
@@ -37,13 +35,6 @@ static const PnvChip pnv_chips[] = {
         .cfam_id    = 0x220ea04980000000ull,
         .first_core = 0x1,
         .num_i2c    = 0,
-    }, {
-        .chip_type  = PNV_CHIP_POWER8NVL,
-        .cpu_model  = "POWER8NVL",
-        .xscom_base = 0x0003fc0000000000ull,
-        .cfam_id    = 0x120d304980000000ull,
-        .first_core = 0x1,
-        .num_i2c    = 0,
     },
     {
         .chip_type  = PNV_CHIP_POWER9,
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index afb6019b10..c0cb45dbfb 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -869,16 +869,6 @@ static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
     return pnv_lpc_isa_create(&chip8->lpc, true, errp);
 }
 
-static ISABus *pnv_chip_power8nvl_isa_create(PnvChip *chip, Error **errp)
-{
-    Pnv8Chip *chip8 = PNV8_CHIP(chip);
-    qemu_irq irq = qdev_get_gpio_in(DEVICE(&chip8->psi), PSIHB_IRQ_LPC_I2C);
-
-    qdev_connect_gpio_out_named(DEVICE(&chip8->lpc), "LPCHC", 0, irq);
-
-    return pnv_lpc_isa_create(&chip8->lpc, false, errp);
-}
-
 static ISABus *pnv_chip_power9_isa_create(PnvChip *chip, Error **errp)
 {
     Pnv9Chip *chip9 = PNV9_CHIP(chip);
@@ -1646,7 +1636,6 @@ static void *pnv_chip_power11_intc_get(PnvChip *chip)
  *  EX14
  * <EX15 reserved>
  */
-#define POWER8E_CORE_MASK  (0x7070ull)
 #define POWER8_CORE_MASK   (0x7e7eull)
 
 /*
@@ -1827,30 +1816,6 @@ static uint32_t pnv_chip_power8_xscom_pcba(PnvChip *chip, uint64_t addr)
     return ((addr >> 4) & ~0xfull) | ((addr >> 3) & 0xf);
 }
 
-static void pnv_chip_power8e_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PnvChipClass *k = PNV_CHIP_CLASS(klass);
-
-    k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
-    k->cores_mask = POWER8E_CORE_MASK;
-    k->num_phbs = 3;
-    k->get_pir_tir = pnv_get_pir_tir_p8;
-    k->intc_create = pnv_chip_power8_intc_create;
-    k->intc_reset = pnv_chip_power8_intc_reset;
-    k->intc_destroy = pnv_chip_power8_intc_destroy;
-    k->intc_print_info = pnv_chip_power8_intc_print_info;
-    k->isa_create = pnv_chip_power8_isa_create;
-    k->dt_populate = pnv_chip_power8_dt_populate;
-    k->pic_print_info = pnv_chip_power8_pic_print_info;
-    k->xscom_core_base = pnv_chip_power8_xscom_core_base;
-    k->xscom_pcba = pnv_chip_power8_xscom_pcba;
-    dc->desc = "PowerNV Chip POWER8E";
-
-    device_class_set_parent_realize(dc, pnv_chip_power8_realize,
-                                    &k->parent_realize);
-}
-
 static void pnv_chip_power8_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1875,30 +1840,6 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, const void *data)
                                     &k->parent_realize);
 }
 
-static void pnv_chip_power8nvl_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PnvChipClass *k = PNV_CHIP_CLASS(klass);
-
-    k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
-    k->cores_mask = POWER8_CORE_MASK;
-    k->num_phbs = 4;
-    k->get_pir_tir = pnv_get_pir_tir_p8;
-    k->intc_create = pnv_chip_power8_intc_create;
-    k->intc_reset = pnv_chip_power8_intc_reset;
-    k->intc_destroy = pnv_chip_power8_intc_destroy;
-    k->intc_print_info = pnv_chip_power8_intc_print_info;
-    k->isa_create = pnv_chip_power8nvl_isa_create;
-    k->dt_populate = pnv_chip_power8_dt_populate;
-    k->pic_print_info = pnv_chip_power8_pic_print_info;
-    k->xscom_core_base = pnv_chip_power8_xscom_core_base;
-    k->xscom_pcba = pnv_chip_power8_xscom_pcba;
-    dc->desc = "PowerNV Chip POWER8NVL";
-
-    device_class_set_parent_realize(dc, pnv_chip_power8_realize,
-                                    &k->parent_realize);
-}
-
 static void pnv_chip_power9_instance_init(Object *obj)
 {
     PnvChip *chip = PNV_CHIP(obj);
@@ -3785,9 +3726,6 @@ static const TypeInfo types[] = {
         .instance_size = sizeof(Pnv8Chip),
     },
     DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_init),
-    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_class_init),
-    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
-                          pnv_chip_power8nvl_class_init),
 };
 
 DEFINE_TYPES(types)
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8939515c2c..61dc8211e3 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -515,9 +515,7 @@ static const TypeInfo pnv_core_infos[] = {
         .class_init = pnv_core_class_init,
         .abstract       = true,
     },
-    DEFINE_PNV_CORE_TYPE(power8, "power8e_v2.1"),
     DEFINE_PNV_CORE_TYPE(power8, "power8_v2.0"),
-    DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
     DEFINE_PNV_CORE_TYPE(power9, "power9_v2.2"),
     DEFINE_PNV_CORE_TYPE(power10, "power10_v2.0"),
     DEFINE_PNV_CORE_TYPE(power11, "power11_v2.0"),
-- 
2.52.0


