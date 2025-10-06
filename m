Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947B7CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 15:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5nRa-0004Rq-G2; Mon, 06 Oct 2025 11:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1v5nRW-0004If-AF; Mon, 06 Oct 2025 11:48:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1v5nRP-0000Hd-DJ; Mon, 06 Oct 2025 11:48:06 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596AP2Te024169;
 Mon, 6 Oct 2025 15:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=TNC4b9SrdXNB9cVKGE5BahyFtqgX7k
 +vbVazEjsYUtg=; b=SJNnEZWDmaErPSl2Lkys+3STd2Ph7vNOb3SBrQg+iOLAVp
 CjRT3fI1jHJVixnkePDk+mXTX36hOs87EN2MKGdpKVMXmp9IooSR76Oxf2Kis6wc
 p8f1AMIjqDDU3Kq+SXj8N/VS5Vi3dB09gTSnM2axj3tF11qvEmJtnwqB/NShGpvC
 gpLQlrLWwzr3vpq1LJoXJhXs3f3RkTfgfCDxmZhedsrHmYu4bBV3XTVb7VQ5DV9v
 gKkr8UgocvabfCW3YQ7ephPMzdxZqAC4UKtj2ACyZJdVp+A/outcdaANEpKzJKDm
 1AolG7lSF8P9dEG8Mo85VhpcIpl2FH90qHssWfzg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0p9yr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:47:53 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 596FlrYu013349;
 Mon, 6 Oct 2025 15:47:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0p9yr2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:47:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 596CVXKQ000929;
 Mon, 6 Oct 2025 15:47:52 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ke9xxx6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:47:52 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 596Flpgi33489258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Oct 2025 15:47:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF87B58059;
 Mon,  6 Oct 2025 15:47:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B2C058043;
 Mon,  6 Oct 2025 15:47:50 +0000 (GMT)
Received: from [9.10.80.187] (unknown [9.10.80.187])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Oct 2025 15:47:50 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------Q4Lg8xN3I04ZTLqQMWTnCzeT"
Message-ID: <6f4c213d-37ba-4745-966c-a9aad71c09df@linux.ibm.com>
Date: Mon, 6 Oct 2025 10:47:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/8] ppc/pnv: Add ChipTOD model for Power11
To: Aditya Gupta <adityag@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250925173049.891406-1-adityag@linux.ibm.com>
 <20250925173049.891406-7-adityag@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250925173049.891406-7-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XvT3+FF9 c=1 sm=1 tr=0 ts=68e3e4a9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=eQ7U-AIairlTTIg-Z_QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pI1jNxhr3gY-GODEvpkA:9 a=J1GbQNOhs2OjZ4RF:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-ORIG-GUID: Nxeaz4NRFEtibOMBgjZt1zErJAo17XAs
X-Proofpoint-GUID: Ghs4yRwYUhuqHs4uiLsInDlm1rhNL2ov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwOSBTYWx0ZWRfX5u50EPj9TkEZ
 XD9rmS2f86h4YNXSljFzVj0JeXRBTL1LNUJd/qlrSOFpzJnB19aSht4lRvblnaeMflnjAPYSx8W
 P2QDCvCqrW0X4i1Se2Q4PbnYMTJcqaD2pxZOkF/RsgviO6nkhY3hYd4ghDTKJAjdlTNEY0DIKGv
 kdMmee5ld9vWxDzLvu6xoj0GfTDNzC72xTTB/kXuFNJVwuErGDa9VO6QD0fCnRaa6Jjw9eUHEka
 88V+0xIB3FFv9m3dPS51GqS4bL/ZAQfM/28IvEzNSCaV3BqTjYA3DMKQ9aA6PxRFv0GgktV+pxp
 bPSuLDzZNeDp1HzLm6CsorMti50u77HFVNiP5CuDk0M3BtCG2L9UczhJFaOT065py5N+9excOdb
 AA5Q2HYUXgNf9B8zb2YaABt1urapyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
--------------Q4Lg8xN3I04ZTLqQMWTnCzeT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/25/2025 12:30 PM, Aditya Gupta wrote:
> Introduce Power11 ChipTod. The code has been copied from Power10 ChipTod
> code as the Power11 core is same as Power10 core.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

> Reviewed-by: Cédric Le Goater<clg@redhat.com>
> Signed-off-by: Aditya Gupta<adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv.c                 | 15 +++++++++
>   hw/ppc/pnv_chiptod.c         | 59 ++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chiptod.h |  2 ++
>   3 files changed, 76 insertions(+)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 2b4df6076c4c..f0469cdb8b65 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2495,6 +2495,8 @@ static void pnv_chip_power11_instance_init(Object *obj)
>       object_initialize_child(obj, "xive", &chip11->xive, TYPE_PNV_XIVE2);
>       object_property_add_alias(obj, "xive-fabric", OBJECT(&chip11->xive),
>                                 "xive-fabric");
> +    object_initialize_child(obj, "chiptod", &chip11->chiptod,
> +                            TYPE_PNV11_CHIPTOD);
>       object_initialize_child(obj, "n1-chiplet", &chip11->n1_chiplet,
>                               TYPE_PNV_N1_CHIPLET);
>   
> @@ -2653,6 +2655,19 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
>       chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
>                                               (uint64_t) PNV11_LPCM_BASE(chip));
>   
> +    /* ChipTOD */
> +    object_property_set_bool(OBJECT(&chip11->chiptod), "primary",
> +                             chip->chip_id == 0, &error_abort);
> +    object_property_set_bool(OBJECT(&chip11->chiptod), "secondary",
> +                             chip->chip_id == 1, &error_abort);
> +    object_property_set_link(OBJECT(&chip11->chiptod), "chip", OBJECT(chip),
> +                             &error_abort);
> +    if (!qdev_realize(DEVICE(&chip11->chiptod), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_CHIPTOD_BASE,
> +                            &chip11->chiptod.xscom_regs);
> +
>       /* HOMER (must be created before OCC) */
>       object_property_set_link(OBJECT(&chip11->homer), "chip", OBJECT(chip),
>                                &error_abort);
> diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
> index b9e9c7ba3dbb..f887a18cde8d 100644
> --- a/hw/ppc/pnv_chiptod.c
> +++ b/hw/ppc/pnv_chiptod.c
> @@ -210,6 +210,22 @@ static void chiptod_power10_broadcast_ttype(PnvChipTOD *sender,
>       }
>   }
>   
> +static void chiptod_power11_broadcast_ttype(PnvChipTOD *sender,
> +                                            uint32_t trigger)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> +    int i;
> +
> +    for (i = 0; i < pnv->num_chips; i++) {
> +        Pnv11Chip *chip11 = PNV11_CHIP(pnv->chips[i]);
> +        PnvChipTOD *chiptod = &chip11->chiptod;
> +
> +        if (chiptod != sender) {
> +            chiptod_receive_ttype(chiptod, trigger);
> +        }
> +    }
> +}
> +
>   static PnvCore *pnv_chip_get_core_by_xscom_base(PnvChip *chip,
>                                                   uint32_t xscom_base)
>   {
> @@ -283,6 +299,12 @@ static PnvCore *chiptod_power10_tx_ttype_target(PnvChipTOD *chiptod,
>       }
>   }
>   
> +static PnvCore *chiptod_power11_tx_ttype_target(PnvChipTOD *chiptod,
> +                                               uint64_t val)
> +{
> +    return chiptod_power10_tx_ttype_target(chiptod, val);
> +}
> +
>   static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>                                       uint64_t val, unsigned size)
>   {
> @@ -520,6 +542,42 @@ static const TypeInfo pnv_chiptod_power10_type_info = {
>       }
>   };
>   
> +static int pnv_chiptod_power11_dt_xscom(PnvXScomInterface *dev, void *fdt,
> +                             int xscom_offset)
> +{
> +    const char compat[] = "ibm,power-chiptod\0ibm,power11-chiptod";
> +
> +    return pnv_chiptod_dt_xscom(dev, fdt, xscom_offset, compat, sizeof(compat));
> +}
> +
> +static void pnv_chiptod_power11_class_init(ObjectClass *klass, const void *data)
> +{
> +    PnvChipTODClass *pctc = PNV_CHIPTOD_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
> +
> +    dc->desc = "PowerNV ChipTOD Controller (Power11)";
> +    device_class_set_props(dc, pnv_chiptod_properties);
> +
> +    xdc->dt_xscom = pnv_chiptod_power11_dt_xscom;
> +
> +    pctc->broadcast_ttype = chiptod_power11_broadcast_ttype;
> +    pctc->tx_ttype_target = chiptod_power11_tx_ttype_target;
> +
> +    pctc->xscom_size = PNV_XSCOM_CHIPTOD_SIZE;
> +}
> +
> +static const TypeInfo pnv_chiptod_power11_type_info = {
> +    .name          = TYPE_PNV11_CHIPTOD,
> +    .parent        = TYPE_PNV_CHIPTOD,
> +    .instance_size = sizeof(PnvChipTOD),
> +    .class_init    = pnv_chiptod_power11_class_init,
> +    .interfaces    = (const InterfaceInfo[]) {
> +        { TYPE_PNV_XSCOM_INTERFACE },
> +        { }
> +    }
> +};
> +
>   static void pnv_chiptod_reset(void *dev)
>   {
>       PnvChipTOD *chiptod = PNV_CHIPTOD(dev);
> @@ -579,6 +637,7 @@ static void pnv_chiptod_register_types(void)
>       type_register_static(&pnv_chiptod_type_info);
>       type_register_static(&pnv_chiptod_power9_type_info);
>       type_register_static(&pnv_chiptod_power10_type_info);
> +    type_register_static(&pnv_chiptod_power11_type_info);
>   }
>   
>   type_init(pnv_chiptod_register_types);
> diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
> index fde569bcbfa9..466b06560a28 100644
> --- a/include/hw/ppc/pnv_chiptod.h
> +++ b/include/hw/ppc/pnv_chiptod.h
> @@ -17,6 +17,8 @@ OBJECT_DECLARE_TYPE(PnvChipTOD, PnvChipTODClass, PNV_CHIPTOD)
>   DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV9_CHIPTOD, TYPE_PNV9_CHIPTOD)
>   #define TYPE_PNV10_CHIPTOD TYPE_PNV_CHIPTOD "-POWER10"
>   DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV10_CHIPTOD, TYPE_PNV10_CHIPTOD)
> +#define TYPE_PNV11_CHIPTOD TYPE_PNV_CHIPTOD "-POWER11"
> +DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV11_CHIPTOD, TYPE_PNV11_CHIPTOD)
>   
>   enum tod_state {
>       tod_error = 0,
--------------Q4Lg8xN3I04ZTLqQMWTnCzeT
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
      cite="mid:20250925173049.891406-7-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">Introduce Power11 ChipTod. The code has been copied from Power10 ChipTod
code as the Power11 core is same as Power10 core.
</pre>
    </blockquote>
    <br>
    <pre>Reviewed-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a></pre>
    <blockquote type="cite"
      cite="mid:20250925173049.891406-7-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">
Reviewed-by: Cédric Le Goater <a class="moz-txt-link-rfc2396E" href="mailto:clg@redhat.com">&lt;clg@redhat.com&gt;</a>
Signed-off-by: Aditya Gupta <a class="moz-txt-link-rfc2396E" href="mailto:adityag@linux.ibm.com">&lt;adityag@linux.ibm.com&gt;</a>
---
 hw/ppc/pnv.c                 | 15 +++++++++
 hw/ppc/pnv_chiptod.c         | 59 ++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chiptod.h |  2 ++
 3 files changed, 76 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 2b4df6076c4c..f0469cdb8b65 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2495,6 +2495,8 @@ static void pnv_chip_power11_instance_init(Object *obj)
     object_initialize_child(obj, "xive", &amp;chip11-&gt;xive, TYPE_PNV_XIVE2);
     object_property_add_alias(obj, "xive-fabric", OBJECT(&amp;chip11-&gt;xive),
                               "xive-fabric");
+    object_initialize_child(obj, "chiptod", &amp;chip11-&gt;chiptod,
+                            TYPE_PNV11_CHIPTOD);
     object_initialize_child(obj, "n1-chiplet", &amp;chip11-&gt;n1_chiplet,
                             TYPE_PNV_N1_CHIPLET);
 
@@ -2653,6 +2655,19 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
     chip-&gt;dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
                                             (uint64_t) PNV11_LPCM_BASE(chip));
 
+    /* ChipTOD */
+    object_property_set_bool(OBJECT(&amp;chip11-&gt;chiptod), "primary",
+                             chip-&gt;chip_id == 0, &amp;error_abort);
+    object_property_set_bool(OBJECT(&amp;chip11-&gt;chiptod), "secondary",
+                             chip-&gt;chip_id == 1, &amp;error_abort);
+    object_property_set_link(OBJECT(&amp;chip11-&gt;chiptod), "chip", OBJECT(chip),
+                             &amp;error_abort);
+    if (!qdev_realize(DEVICE(&amp;chip11-&gt;chiptod), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV11_XSCOM_CHIPTOD_BASE,
+                            &amp;chip11-&gt;chiptod.xscom_regs);
+
     /* HOMER (must be created before OCC) */
     object_property_set_link(OBJECT(&amp;chip11-&gt;homer), "chip", OBJECT(chip),
                              &amp;error_abort);
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index b9e9c7ba3dbb..f887a18cde8d 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -210,6 +210,22 @@ static void chiptod_power10_broadcast_ttype(PnvChipTOD *sender,
     }
 }
 
+static void chiptod_power11_broadcast_ttype(PnvChipTOD *sender,
+                                            uint32_t trigger)
+{
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    int i;
+
+    for (i = 0; i &lt; pnv-&gt;num_chips; i++) {
+        Pnv11Chip *chip11 = PNV11_CHIP(pnv-&gt;chips[i]);
+        PnvChipTOD *chiptod = &amp;chip11-&gt;chiptod;
+
+        if (chiptod != sender) {
+            chiptod_receive_ttype(chiptod, trigger);
+        }
+    }
+}
+
 static PnvCore *pnv_chip_get_core_by_xscom_base(PnvChip *chip,
                                                 uint32_t xscom_base)
 {
@@ -283,6 +299,12 @@ static PnvCore *chiptod_power10_tx_ttype_target(PnvChipTOD *chiptod,
     }
 }
 
+static PnvCore *chiptod_power11_tx_ttype_target(PnvChipTOD *chiptod,
+                                               uint64_t val)
+{
+    return chiptod_power10_tx_ttype_target(chiptod, val);
+}
+
 static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
                                     uint64_t val, unsigned size)
 {
@@ -520,6 +542,42 @@ static const TypeInfo pnv_chiptod_power10_type_info = {
     }
 };
 
+static int pnv_chiptod_power11_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int xscom_offset)
+{
+    const char compat[] = "ibm,power-chiptod\0ibm,power11-chiptod";
+
+    return pnv_chiptod_dt_xscom(dev, fdt, xscom_offset, compat, sizeof(compat));
+}
+
+static void pnv_chiptod_power11_class_init(ObjectClass *klass, const void *data)
+{
+    PnvChipTODClass *pctc = PNV_CHIPTOD_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    dc-&gt;desc = "PowerNV ChipTOD Controller (Power11)";
+    device_class_set_props(dc, pnv_chiptod_properties);
+
+    xdc-&gt;dt_xscom = pnv_chiptod_power11_dt_xscom;
+
+    pctc-&gt;broadcast_ttype = chiptod_power11_broadcast_ttype;
+    pctc-&gt;tx_ttype_target = chiptod_power11_tx_ttype_target;
+
+    pctc-&gt;xscom_size = PNV_XSCOM_CHIPTOD_SIZE;
+}
+
+static const TypeInfo pnv_chiptod_power11_type_info = {
+    .name          = TYPE_PNV11_CHIPTOD,
+    .parent        = TYPE_PNV_CHIPTOD,
+    .instance_size = sizeof(PnvChipTOD),
+    .class_init    = pnv_chiptod_power11_class_init,
+    .interfaces    = (const InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
 static void pnv_chiptod_reset(void *dev)
 {
     PnvChipTOD *chiptod = PNV_CHIPTOD(dev);
@@ -579,6 +637,7 @@ static void pnv_chiptod_register_types(void)
     type_register_static(&amp;pnv_chiptod_type_info);
     type_register_static(&amp;pnv_chiptod_power9_type_info);
     type_register_static(&amp;pnv_chiptod_power10_type_info);
+    type_register_static(&amp;pnv_chiptod_power11_type_info);
 }
 
 type_init(pnv_chiptod_register_types);
diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
index fde569bcbfa9..466b06560a28 100644
--- a/include/hw/ppc/pnv_chiptod.h
+++ b/include/hw/ppc/pnv_chiptod.h
@@ -17,6 +17,8 @@ OBJECT_DECLARE_TYPE(PnvChipTOD, PnvChipTODClass, PNV_CHIPTOD)
 DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV9_CHIPTOD, TYPE_PNV9_CHIPTOD)
 #define TYPE_PNV10_CHIPTOD TYPE_PNV_CHIPTOD "-POWER10"
 DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV10_CHIPTOD, TYPE_PNV10_CHIPTOD)
+#define TYPE_PNV11_CHIPTOD TYPE_PNV_CHIPTOD "-POWER11"
+DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV11_CHIPTOD, TYPE_PNV11_CHIPTOD)
 
 enum tod_state {
     tod_error = 0,
</pre>
    </blockquote>
  </body>
</html>

--------------Q4Lg8xN3I04ZTLqQMWTnCzeT--


