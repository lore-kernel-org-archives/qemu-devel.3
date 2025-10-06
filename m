Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB4DCCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 15:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5nRF-0003i2-9j; Mon, 06 Oct 2025 11:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1v5nR6-0003V2-Gq; Mon, 06 Oct 2025 11:47:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1v5nR0-00009o-4M; Mon, 06 Oct 2025 11:47:38 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5967EuH6028845;
 Mon, 6 Oct 2025 15:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=KWmRelQ5jVX+WLEkCQTwTWhYIwKyRg
 jJ8unZaUHfxxU=; b=rW4uRTdir1LjxGlBkwsBitXJtmUr0ujOvihzWZ3eWRCxqp
 IwZnE3aDa5Z2SGT+fZXrTEOJaV3QOeIg9sJVcR/CF4IE6auzgYjOC5HrpZetSZ2G
 saVOqUQv3Fjs8MF2CPlveHnIVTl8uULuqOp96qR8J2ZrNUx5LE1+4MyrVwQyGIAm
 eG18fmuTr+KOgS1RMuu+FyfrCout46r+4fPF3piXVEX1UpmUzCLuXEgba5JMF+xL
 NHrTgVfJT6xnAzttjDpCfav0YArs3XLhdFHN92u4wUeCG3issPL4XG/ohxthr1mQ
 aKpfZKqzlf3BRAiTVUmV0wtJMj0BLz1AwfVTnV8g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju93a642-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:47:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 596FdCwM020022;
 Mon, 6 Oct 2025 15:47:23 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju93a63t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:47:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 596DVabS013198;
 Mon, 6 Oct 2025 15:47:22 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kg4jem7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:47:22 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 596FlMO727919008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Oct 2025 15:47:22 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08AD55805D;
 Mon,  6 Oct 2025 15:47:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 808D658043;
 Mon,  6 Oct 2025 15:47:21 +0000 (GMT)
Received: from [9.10.80.187] (unknown [9.10.80.187])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Oct 2025 15:47:21 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------aN5YO8s20MrW7FvVrrb0Rm0v"
Message-ID: <6b3127a8-7fe6-4eb5-9c77-0b0138fb2505@linux.ibm.com>
Date: Mon, 6 Oct 2025 10:47:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/8] ppc/pnv: Add PHB5 PCIe Host bridge to Power11
To: Aditya Gupta <adityag@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250925173049.891406-1-adityag@linux.ibm.com>
 <20250925173049.891406-6-adityag@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250925173049.891406-6-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2W1GHKyJcrRxUIGsqS9w_yPFYMJQk1l1
X-Proofpoint-ORIG-GUID: U_CzNUWymH3KWGPNdMzr-Ehz7W35eQ9a
X-Authority-Analysis: v=2.4 cv=Fec6BZ+6 c=1 sm=1 tr=0 ts=68e3e48c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=8bPpF4Ety_ZlZ_NTxqEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=460_-ORYMF3lY5BZaOYA:9 a=kJdcwFna9yGQXH3G:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX8eA/xqzkRgYq
 7XOVGWx/ETGrFm9bEzzviaa1td3KXmEceskQVBxvnd9DZcZFNsVpWBpO+fXzG/vUmZzgA0Wh2CL
 Bwg6BSKdgUXWYhHmFK60s5dqomvDm08CBOmjMdKrB4Mb+yZ8NryevtKURhipDYu09E6LN9Jl8w9
 lwKtQue1//DwT7JYcm3TKNTlJ6WotbIsh0RotD4MR8NI10Hx1/amfXxo6HgPaZxKWOVEAtf2tJ+
 sgPqsJxpi6M4bEXitjHo3GVvrCgg5PxDfiGZODdVuQJKCcy/ivUzAMS6ELiT+56mxMelqrhWWOM
 dy28RpivFQiBs+QX8T28b5LcKTVFfitrFLgH12N0TE38ggcb9QQgAF4l+UERJhYRqyOB9CzFt1t
 c3O6qivVhjngeRFQqA6QKRi8IZ7ClQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is a multi-part message in MIME format.
--------------aN5YO8s20MrW7FvVrrb0Rm0v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/25/2025 12:30 PM, Aditya Gupta wrote:
> Power11 also uses PHB5, same as Power10.
>
> Add Power11 PHBs with similar code as the corresponding Power10 implementation.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

> Reviewed-by: Cédric Le Goater<clg@redhat.com>
> Signed-off-by: Aditya Gupta<adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 8097d3c09a2f..2b4df6076c4c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -978,6 +978,8 @@ static void pnv_chip_power11_pic_print_info(PnvChip *chip, GString *buf)
>   
>       pnv_xive2_pic_print_info(&chip11->xive, buf);
>       pnv_psi_pic_print_info(&chip11->psi, buf);
> +    object_child_foreach_recursive(OBJECT(chip),
> +                         pnv_chip_power9_pic_print_info_child, buf);
>   }
>   
>   /* Always give the first 1GB to chip 0 else we won't boot */
> @@ -2473,6 +2475,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>   
>   static void pnv_chip_power11_instance_init(Object *obj)
>   {
> +    PnvChip *chip = PNV_CHIP(obj);
>       Pnv11Chip *chip11 = PNV11_CHIP(obj);
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
>       int i;
> @@ -2495,6 +2498,13 @@ static void pnv_chip_power11_instance_init(Object *obj)
>       object_initialize_child(obj, "n1-chiplet", &chip11->n1_chiplet,
>                               TYPE_PNV_N1_CHIPLET);
>   
> +    chip->num_pecs = pcc->num_pecs;
> +
> +    for (i = 0; i < chip->num_pecs; i++) {
> +        object_initialize_child(obj, "pec[*]", &chip11->pecs[i],
> +                                TYPE_PNV_PHB5_PEC);
> +    }
> +
>       for (i = 0; i < pcc->i2c_num_engines; i++) {
>           object_initialize_child(obj, "i2c[*]", &chip11->i2c[i], TYPE_PNV_I2C);
>       }
> @@ -2527,6 +2537,38 @@ static void pnv_chip_power11_quad_realize(Pnv11Chip *chip11, Error **errp)
>       }
>   }
>   
> +static void pnv_chip_power11_phb_realize(PnvChip *chip, Error **errp)
> +{
> +    Pnv11Chip *chip11 = PNV11_CHIP(chip);
> +    int i;
> +
> +    for (i = 0; i < chip->num_pecs; i++) {
> +        PnvPhb4PecState *pec = &chip11->pecs[i];
> +        PnvPhb4PecClass *pecc = PNV_PHB4_PEC_GET_CLASS(pec);
> +        uint32_t pec_cplt_base;
> +        uint32_t pec_nest_base;
> +        uint32_t pec_pci_base;
> +
> +        object_property_set_int(OBJECT(pec), "index", i, &error_fatal);
> +        object_property_set_int(OBJECT(pec), "chip-id", chip->chip_id,
> +                                &error_fatal);
> +        object_property_set_link(OBJECT(pec), "chip", OBJECT(chip),
> +                                 &error_fatal);
> +        if (!qdev_realize(DEVICE(pec), NULL, errp)) {
> +            return;
> +        }
> +
> +        pec_cplt_base = pecc->xscom_cplt_base(pec);
> +        pec_nest_base = pecc->xscom_nest_base(pec);
> +        pec_pci_base = pecc->xscom_pci_base(pec);
> +
> +        pnv_xscom_add_subregion(chip, pec_cplt_base,
> +                 &pec->nest_pervasive.xscom_ctrl_regs_mr);
> +        pnv_xscom_add_subregion(chip, pec_nest_base, &pec->nest_regs_mr);
> +        pnv_xscom_add_subregion(chip, pec_pci_base, &pec->pci_regs_mr);
> +    }
> +}
> +
>   static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
>   {
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
> @@ -2664,7 +2706,12 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
>       pnv_xscom_add_subregion(chip, PNV11_XSCOM_N1_PB_SCOM_ES_BASE,
>                              &chip11->n1_chiplet.xscom_pb_es_mr);
>   
> -    /* WIP: PHB added in future patch */
> +    /* PHBs */
> +    pnv_chip_power11_phb_realize(chip, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>   
>       /*
>        * I2C
> @@ -2799,6 +2846,7 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, const void *data)
>       k->xscom_core_base = pnv_chip_power11_xscom_core_base;
>       k->xscom_pcba = pnv_chip_power11_xscom_pcba;
>       dc->desc = "PowerNV Chip Power11";
> +    k->num_pecs = PNV10_CHIP_MAX_PEC;
>       k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
>       k->i2c_ports_per_engine = i2c_ports_per_engine;
>   
> @@ -3365,6 +3413,13 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
>       XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
>       static const char compat[] = "qemu,powernv11\0ibm,powernv";
>   
> +    static GlobalProperty phb_compat[] = {
> +        { TYPE_PNV_PHB, "version", "5" },
> +        { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
> +    };
> +
> +    compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
> +
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
>       pmc->max_smt_threads = 4;
--------------aN5YO8s20MrW7FvVrrb0Rm0v
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/25/2025 12:30 PM, Aditya Gupta
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250925173049.891406-6-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">Power11 also uses PHB5, same as Power10.

Add Power11 PHBs with similar code as the corresponding Power10 implementation.
</pre>
    </blockquote>
    <br>
    <pre>Reviewed-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a></pre>
    <blockquote type="cite"
      cite="mid:20250925173049.891406-6-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">
Reviewed-by: Cédric Le Goater <a class="moz-txt-link-rfc2396E" href="mailto:clg@redhat.com">&lt;clg@redhat.com&gt;</a>
Signed-off-by: Aditya Gupta <a class="moz-txt-link-rfc2396E" href="mailto:adityag@linux.ibm.com">&lt;adityag@linux.ibm.com&gt;</a>
---
 hw/ppc/pnv.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8097d3c09a2f..2b4df6076c4c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -978,6 +978,8 @@ static void pnv_chip_power11_pic_print_info(PnvChip *chip, GString *buf)
 
     pnv_xive2_pic_print_info(&amp;chip11-&gt;xive, buf);
     pnv_psi_pic_print_info(&amp;chip11-&gt;psi, buf);
+    object_child_foreach_recursive(OBJECT(chip),
+                         pnv_chip_power9_pic_print_info_child, buf);
 }
 
 /* Always give the first 1GB to chip 0 else we won't boot */
@@ -2473,6 +2475,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
 
 static void pnv_chip_power11_instance_init(Object *obj)
 {
+    PnvChip *chip = PNV_CHIP(obj);
     Pnv11Chip *chip11 = PNV11_CHIP(obj);
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
     int i;
@@ -2495,6 +2498,13 @@ static void pnv_chip_power11_instance_init(Object *obj)
     object_initialize_child(obj, "n1-chiplet", &amp;chip11-&gt;n1_chiplet,
                             TYPE_PNV_N1_CHIPLET);
 
+    chip-&gt;num_pecs = pcc-&gt;num_pecs;
+
+    for (i = 0; i &lt; chip-&gt;num_pecs; i++) {
+        object_initialize_child(obj, "pec[*]", &amp;chip11-&gt;pecs[i],
+                                TYPE_PNV_PHB5_PEC);
+    }
+
     for (i = 0; i &lt; pcc-&gt;i2c_num_engines; i++) {
         object_initialize_child(obj, "i2c[*]", &amp;chip11-&gt;i2c[i], TYPE_PNV_I2C);
     }
@@ -2527,6 +2537,38 @@ static void pnv_chip_power11_quad_realize(Pnv11Chip *chip11, Error **errp)
     }
 }
 
+static void pnv_chip_power11_phb_realize(PnvChip *chip, Error **errp)
+{
+    Pnv11Chip *chip11 = PNV11_CHIP(chip);
+    int i;
+
+    for (i = 0; i &lt; chip-&gt;num_pecs; i++) {
+        PnvPhb4PecState *pec = &amp;chip11-&gt;pecs[i];
+        PnvPhb4PecClass *pecc = PNV_PHB4_PEC_GET_CLASS(pec);
+        uint32_t pec_cplt_base;
+        uint32_t pec_nest_base;
+        uint32_t pec_pci_base;
+
+        object_property_set_int(OBJECT(pec), "index", i, &amp;error_fatal);
+        object_property_set_int(OBJECT(pec), "chip-id", chip-&gt;chip_id,
+                                &amp;error_fatal);
+        object_property_set_link(OBJECT(pec), "chip", OBJECT(chip),
+                                 &amp;error_fatal);
+        if (!qdev_realize(DEVICE(pec), NULL, errp)) {
+            return;
+        }
+
+        pec_cplt_base = pecc-&gt;xscom_cplt_base(pec);
+        pec_nest_base = pecc-&gt;xscom_nest_base(pec);
+        pec_pci_base = pecc-&gt;xscom_pci_base(pec);
+
+        pnv_xscom_add_subregion(chip, pec_cplt_base,
+                 &amp;pec-&gt;nest_pervasive.xscom_ctrl_regs_mr);
+        pnv_xscom_add_subregion(chip, pec_nest_base, &amp;pec-&gt;nest_regs_mr);
+        pnv_xscom_add_subregion(chip, pec_pci_base, &amp;pec-&gt;pci_regs_mr);
+    }
+}
+
 static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
@@ -2664,7 +2706,12 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
     pnv_xscom_add_subregion(chip, PNV11_XSCOM_N1_PB_SCOM_ES_BASE,
                            &amp;chip11-&gt;n1_chiplet.xscom_pb_es_mr);
 
-    /* WIP: PHB added in future patch */
+    /* PHBs */
+    pnv_chip_power11_phb_realize(chip, &amp;local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     /*
      * I2C
@@ -2799,6 +2846,7 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, const void *data)
     k-&gt;xscom_core_base = pnv_chip_power11_xscom_core_base;
     k-&gt;xscom_pcba = pnv_chip_power11_xscom_pcba;
     dc-&gt;desc = "PowerNV Chip Power11";
+    k-&gt;num_pecs = PNV10_CHIP_MAX_PEC;
     k-&gt;i2c_num_engines = PNV10_CHIP_MAX_I2C;
     k-&gt;i2c_ports_per_engine = i2c_ports_per_engine;
 
@@ -3365,6 +3413,13 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
     XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
     static const char compat[] = "qemu,powernv11\0ibm,powernv";
 
+    static GlobalProperty phb_compat[] = {
+        { TYPE_PNV_PHB, "version", "5" },
+        { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
+    };
+
+    compat_props_add(mc-&gt;compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
+
     pmc-&gt;compat = compat;
     pmc-&gt;compat_size = sizeof(compat);
     pmc-&gt;max_smt_threads = 4;
</pre>
    </blockquote>
  </body>
</html>

--------------aN5YO8s20MrW7FvVrrb0Rm0v--


