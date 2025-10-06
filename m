Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92D8CCA476
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 15:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5nQC-00036i-1j; Mon, 06 Oct 2025 11:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1v5nQ9-00035t-5i; Mon, 06 Oct 2025 11:46:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1v5nQ1-0008Ts-Hi; Mon, 06 Oct 2025 11:46:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596AKP5L028440;
 Mon, 6 Oct 2025 15:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=NZqiZ9+GsChO+6OpaJvPTWdDMR1dKY
 NabCeXlTA0iLc=; b=fhtzbUvv4lUXrUmP1ScGd5H5dvBF1bM9EbXScq6kMMpFR2
 j341e5DMz8Hi+nMeqUSienE/1ozyS1EjtLJmUaJN4394ZfDMikXbGbHbspkDCQwE
 EcBzK1yeEkcdeUJHTFazclwyfVQ0U3Uw1Jy2YkAe0I/eNuANgl0JJSS9j6+HjUq2
 n78FtQVW370AYauk5sVZldPf1iF/YM/mE7vj90EERhY1gsQTwCjgN7uRAHbJvW/4
 Uu+oS/ede3m4+tGdRmIM9/WdAjn0+mrLJZd8m0IkcFnBdiGdYQv+QR3RZjHL4HIL
 tNOeoY2I2NCwXSrACrbidevKF3YpzJppyrA2Jl2w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49js0sa4xn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:46:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 596FUVsg024417;
 Mon, 6 Oct 2025 15:46:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49js0sa4xj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:46:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 596CtTqA000875;
 Mon, 6 Oct 2025 15:46:28 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ke9xxx0t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:46:28 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 596FkQ3232834202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Oct 2025 15:46:26 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C5015805D;
 Mon,  6 Oct 2025 15:46:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1272758043;
 Mon,  6 Oct 2025 15:46:26 +0000 (GMT)
Received: from [9.10.80.187] (unknown [9.10.80.187])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Oct 2025 15:46:25 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------qN8O13IwusMh2nmuuWgNSu8d"
Message-ID: <ba125c22-3e45-4ff1-bcac-d1c23714749f@linux.ibm.com>
Date: Mon, 6 Oct 2025 10:46:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/8] ppc/pnv: Add PnvChipClass handler to get
 reference to interrupt controller
To: Aditya Gupta <adityag@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250925173049.891406-1-adityag@linux.ibm.com>
 <20250925173049.891406-4-adityag@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250925173049.891406-4-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e3e455 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=F6NbDVzyh0JcIBd0gXcA:9 a=QEXdDO2ut3YA:10 a=iorEynmUMFpPDaT-22UA:9
 a=BKIeoQz5Cp-robm3:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: ToQrCnsRKfL5g0j1_OFFDFOJv6MGfoDo
X-Proofpoint-ORIG-GUID: xhYj-g0qpjc-A1fR44nkIv0mwcFWO8PD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDIwMSBTYWx0ZWRfX6WvEDAFYQQz8
 jElBk7Tc2wQSeGk4CbMYHy2tBvfqdbQ51D8ZTsXej8zOz1HTQyPcQqg8xhkzO3qTp2fU2NqJiaw
 2XRCe6AEeMhiiKrtSvWf24ttWM1TmQb8ngXMySZbTRaHiijMT6k3BLeHawQurE2mlTnGpwEpIEM
 v5c/WrF0sglSuxsqQFfqPfV+o7RNks8645kTxuBa4zm8cL0nL8/OFUlei2GFcmjwNwHZ6B3/eIQ
 lwvLojEKlrysw5MTOh0WSMn5sMlqGm3sdlXEM1uXslBmlfjr9lqoeOL/j+4ZVl8DuyGXFv4Ih/f
 abrQoPCWrallcqJIqluG8I6Ax/JUfV2yrahJu7Hle0YRewleVRI2b+nGoFdPgqmsZ0nXv/UcD57
 Nn/bC5JOoUv+Id29Yvl+hist3n6Xvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510030201
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
--------------qN8O13IwusMh2nmuuWgNSu8d
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/25/2025 12:30 PM, Aditya Gupta wrote:
> Existing code in XIVE2 assumes the chip to be a Power10 Chip.
> Instead add a handler to get reference to the interrupt controller (XIVE)
> for a given Power Chip.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

> Signed-off-by: Aditya Gupta<adityag@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c       |  4 ++--
>   hw/ppc/pnv.c              | 12 ++++++++++++
>   include/hw/ppc/pnv_chip.h |  1 +
>   3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index e019cad5c14c..0663baab544c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -110,8 +110,8 @@ static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
>       int i;
>   
>       for (i = 0; i < pnv->num_chips; i++) {
> -        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
> -        PnvXive2 *xive = &chip10->xive;
> +        PnvChipClass *k = PNV_CHIP_GET_CLASS(pnv->chips[i]);
> +        PnvXive2 *xive = PNV_XIVE2(k->intc_get(pnv->chips[i]));
>   
>           /*
>            * Is this the XIVE matching the forwarded VSD address is for this
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 423954ba7e0c..a4fdf59207fa 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1486,6 +1486,16 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
>       xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
>   }
>   
> +static void *pnv_chip_power10_intc_get(PnvChip *chip)
> +{
> +    return &PNV10_CHIP(chip)->xive;
> +}
> +
> +static void *pnv_chip_power11_intc_get(PnvChip *chip)
> +{
> +    return &PNV11_CHIP(chip)->xive;
> +}
> +
>   /*
>    * Allowed core identifiers on a POWER8 Processor Chip :
>    *
> @@ -2680,6 +2690,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, const void *data)
>       k->intc_reset = pnv_chip_power10_intc_reset;
>       k->intc_destroy = pnv_chip_power10_intc_destroy;
>       k->intc_print_info = pnv_chip_power10_intc_print_info;
> +    k->intc_get = pnv_chip_power10_intc_get;
>       k->isa_create = pnv_chip_power10_isa_create;
>       k->dt_populate = pnv_chip_power10_dt_populate;
>       k->pic_print_info = pnv_chip_power10_pic_print_info;
> @@ -2709,6 +2720,7 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, const void *data)
>       k->chip_cfam_id = 0x220da04980000000ull; /* P11 DD2.0 (with NX) */
>       k->cores_mask = POWER11_CORE_MASK;
>       k->get_pir_tir = pnv_get_pir_tir_p10;
> +    k->intc_get = pnv_chip_power11_intc_get;
>       k->isa_create = pnv_chip_power11_isa_create;
>       k->dt_populate = pnv_chip_power11_dt_populate;
>       k->pic_print_info = pnv_chip_power11_pic_print_info;
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 6bd930f8b439..a5b8c49680d3 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -170,6 +170,7 @@ struct PnvChipClass {
>       void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
>       void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
>       void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, GString *buf);
> +    void* (*intc_get)(PnvChip *chip);
>       ISABus *(*isa_create)(PnvChip *chip, Error **errp);
>       void (*dt_populate)(PnvChip *chip, void *fdt);
>       void (*pic_print_info)(PnvChip *chip, GString *buf);
--------------qN8O13IwusMh2nmuuWgNSu8d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
      cite="mid:20250925173049.891406-4-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">Existing code in XIVE2 assumes the chip to be a Power10 Chip.
Instead add a handler to get reference to the interrupt controller (XIVE)
for a given Power Chip.
</pre>
    </blockquote>
    <br>
    <pre>Reviewed-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a></pre>
    <blockquote type="cite"
      cite="mid:20250925173049.891406-4-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">
Signed-off-by: Aditya Gupta <a class="moz-txt-link-rfc2396E" href="mailto:adityag@linux.ibm.com">&lt;adityag@linux.ibm.com&gt;</a>
---
 hw/intc/pnv_xive2.c       |  4 ++--
 hw/ppc/pnv.c              | 12 ++++++++++++
 include/hw/ppc/pnv_chip.h |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index e019cad5c14c..0663baab544c 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -110,8 +110,8 @@ static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
     int i;
 
     for (i = 0; i &lt; pnv-&gt;num_chips; i++) {
-        Pnv10Chip *chip10 = PNV10_CHIP(pnv-&gt;chips[i]);
-        PnvXive2 *xive = &amp;chip10-&gt;xive;
+        PnvChipClass *k = PNV_CHIP_GET_CLASS(pnv-&gt;chips[i]);
+        PnvXive2 *xive = PNV_XIVE2(k-&gt;intc_get(pnv-&gt;chips[i]));
 
         /*
          * Is this the XIVE matching the forwarded VSD address is for this
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 423954ba7e0c..a4fdf59207fa 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1486,6 +1486,16 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
     xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)-&gt;intc), buf);
 }
 
+static void *pnv_chip_power10_intc_get(PnvChip *chip)
+{
+    return &amp;PNV10_CHIP(chip)-&gt;xive;
+}
+
+static void *pnv_chip_power11_intc_get(PnvChip *chip)
+{
+    return &amp;PNV11_CHIP(chip)-&gt;xive;
+}
+
 /*
  * Allowed core identifiers on a POWER8 Processor Chip :
  *
@@ -2680,6 +2690,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, const void *data)
     k-&gt;intc_reset = pnv_chip_power10_intc_reset;
     k-&gt;intc_destroy = pnv_chip_power10_intc_destroy;
     k-&gt;intc_print_info = pnv_chip_power10_intc_print_info;
+    k-&gt;intc_get = pnv_chip_power10_intc_get;
     k-&gt;isa_create = pnv_chip_power10_isa_create;
     k-&gt;dt_populate = pnv_chip_power10_dt_populate;
     k-&gt;pic_print_info = pnv_chip_power10_pic_print_info;
@@ -2709,6 +2720,7 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, const void *data)
     k-&gt;chip_cfam_id = 0x220da04980000000ull; /* P11 DD2.0 (with NX) */
     k-&gt;cores_mask = POWER11_CORE_MASK;
     k-&gt;get_pir_tir = pnv_get_pir_tir_p10;
+    k-&gt;intc_get = pnv_chip_power11_intc_get;
     k-&gt;isa_create = pnv_chip_power11_isa_create;
     k-&gt;dt_populate = pnv_chip_power11_dt_populate;
     k-&gt;pic_print_info = pnv_chip_power11_pic_print_info;
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 6bd930f8b439..a5b8c49680d3 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -170,6 +170,7 @@ struct PnvChipClass {
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, GString *buf);
+    void* (*intc_get)(PnvChip *chip);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, GString *buf);
</pre>
    </blockquote>
  </body>
</html>

--------------qN8O13IwusMh2nmuuWgNSu8d--


