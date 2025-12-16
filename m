Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66B8D609D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVYGT-0004rS-Dk; Tue, 16 Dec 2025 11:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYGR-0004kI-Cy; Tue, 16 Dec 2025 11:51:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYGP-00010O-9Z; Tue, 16 Dec 2025 11:51:07 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGD8YHC003184;
 Tue, 16 Dec 2025 16:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=k0XBChS2v+i0P4yOGj0pN4Avfqb3xU
 mH3x/rHlAFdVU=; b=j/Wi+8KsT9p8h7jcqlVlSYw1xBK8X++qg/61ai+B65NA7l
 LnvjoY1GsbpBcjMuHoejPKwzvG7/6OnXxjDP0Ms4qlShD187teFmM85Ja6nBL+f8
 I3aoBdSNHi/Atn51yqDXsi77qFQwESQJ2M7j9MZdjNlm1S6UknAegfkf973Budan
 1zyJHWSTRYJaUCKl++p5ATdXs8SPP7mFaMXersgpyNn289qUhoGU2socaV0Uuv9Q
 IJP3pX0KAsM36jfiQK8BcvRBdnow9EzOEcV/AT3okFLh/tXYef8gAHrH6qz+WbWe
 v1XI4QDc0lQSSJvW9xwnHG5xG0uA+axnxgNujMow==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yvb8a16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:51:01 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGGOI8I024640;
 Tue, 16 Dec 2025 16:51:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yvb8a0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:51:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGES4uB002976;
 Tue, 16 Dec 2025 16:50:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kykn8h6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:50:59 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGGowwt20185750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 16:50:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E773558045;
 Tue, 16 Dec 2025 16:50:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3278F58054;
 Tue, 16 Dec 2025 16:50:57 +0000 (GMT)
Received: from [9.10.80.59] (unknown [9.10.80.59])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 16:50:57 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------HRmkqlDus6Zc4uNj73BA21rL"
Message-ID: <944eca68-64af-49ad-8274-33938c5dfd5f@linux.ibm.com>
Date: Tue, 16 Dec 2025 10:50:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] hw/ppc: Add VMSTATE information for LPC model
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251216151359.418708-1-calebs@linux.ibm.com>
 <20251216151359.418708-2-calebs@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20251216151359.418708-2-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/JwEOni c=1 sm=1 tr=0 ts=69418df5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=7OGu-YRogrSM9t1cXUIA:9 a=QEXdDO2ut3YA:10
 a=B0JCkwdW2SwKrekVXCIA:9 a=uv4-jtJmVzp5Cqxx:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: Yeund81J9VTbN6_nPb3YyBaLjkRSLu6N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfXzns6Qbkvlc0p
 BNf26to5pWpNDNlxhbM/PC/GMFoeS1h6Ji+7zyfJ6nyAl87vjcejJYw90n4FrgVSvRDv90IL8rj
 ZFzdEA6MP8VML5KOs5UXziuII/8+zgzssM4D7yrICOcnndWMYEXI1k741Z2JvtKDqcULZqayxpn
 gvOu2OszGhtsoxw7MPRdWINbFX5Ge8YuUJHDv1CUd4DI9zGeX0rg0Ah/eaEMYb2O7NYdTupR1Ol
 YKa7Gmz5JV3Q/kKy3ewiXox9ZOY/U7hDbnUCUAJXNO9wGmdXjiT3/QxqBPzc64f3i9LFRn5Tldc
 W9R4pAKx5OvYJrLZiW4aHSlGFTGmJpUub0AR+Mt3wxiK6kvicNB/cyfhxGCOD/nghPcPfiwNDlU
 ESsbtntdZYbXzAKKp5r/ofBGYia0Og==
X-Proofpoint-ORIG-GUID: u7IytEgQcJ86taaTVMmRaEXvyZ7YvDyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
--------------HRmkqlDus6Zc4uNj73BA21rL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 12/16/2025 9:13 AM, Caleb Schlossin wrote:
> The PNV LPC model needs snapshot/migration support.  Added a VMSTATE
> descriptor to save model data and an associated post_load() method.
> Snapshot support added for Power8, Power9, and Power10.
>
> Signed-off-by: Michael Kowal<kowal@linux.ibm.com>
> Signed-off-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   hw/ppc/pnv_lpc.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
>
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index f6beba0917..e52a062181 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -30,6 +30,7 @@
>   #include "hw/ppc/pnv_lpc.h"
>   #include "hw/ppc/pnv_xscom.h"
>   #include "hw/ppc/fdt.h"
> +#include "migration/vmstate.h"
>   
>   #include <libfdt.h>
>   
> @@ -696,6 +697,43 @@ static const MemoryRegionOps opb_master_ops = {
>       },
>   };
>   
> +static int vmstate_pnv_lpc_post_load(void *opaque, int version_id)
> +{
> +    PnvLpcController *lpc = PNV_LPC(opaque);
> +
> +    memory_region_set_alias_offset(&lpc->opb_isa_fw,
> +                                   lpc->lpc_hc_fw_seg_idsel * LPC_FW_OPB_SIZE);
> +    pnv_lpc_eval_serirq_routes(lpc);
> +
> +    pnv_lpc_eval_irqs(lpc);
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_pnv_lpc = {
> +    .name = TYPE_PNV_LPC,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = vmstate_pnv_lpc_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(eccb_stat_reg,       PnvLpcController),
> +        VMSTATE_UINT32(eccb_data_reg,       PnvLpcController),
> +        VMSTATE_UINT32(opb_irq_route0,      PnvLpcController),
> +        VMSTATE_UINT32(opb_irq_route1,      PnvLpcController),
> +        VMSTATE_UINT32(opb_irq_stat,        PnvLpcController),
> +        VMSTATE_UINT32(opb_irq_mask,        PnvLpcController),
> +        VMSTATE_UINT32(opb_irq_pol,         PnvLpcController),
> +        VMSTATE_UINT32(opb_irq_input,       PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_irq_inputs,   PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_fw_seg_idsel, PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_irqser_ctrl,  PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_irqmask,      PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_irqstat,      PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_error_addr,   PnvLpcController),
> +        VMSTATE_UINT32(lpc_hc_fw_rd_acc_size,     PnvLpcController),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static void pnv_lpc_power8_realize(DeviceState *dev, Error **errp)
>   {
>       PnvLpcController *lpc = PNV_LPC(dev);
> @@ -721,6 +759,7 @@ static void pnv_lpc_power8_class_init(ObjectClass *klass, const void *data)
>       PnvLpcClass *plc = PNV_LPC_CLASS(klass);
>   
>       dc->desc = "PowerNV LPC Controller POWER8";
> +    dc->vmsd = &vmstate_pnv_lpc;
>   
>       xdc->dt_xscom = pnv_lpc_dt_xscom;
>   
> @@ -766,6 +805,7 @@ static void pnv_lpc_power9_class_init(ObjectClass *klass, const void *data)
>       PnvLpcClass *plc = PNV_LPC_CLASS(klass);
>   
>       dc->desc = "PowerNV LPC Controller POWER9";
> +    dc->vmsd = &vmstate_pnv_lpc;
>   
>       device_class_set_parent_realize(dc, pnv_lpc_power9_realize,
>                                       &plc->parent_realize);
> @@ -782,6 +822,7 @@ static void pnv_lpc_power10_class_init(ObjectClass *klass, const void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       dc->desc = "PowerNV LPC Controller POWER10";
> +    dc->vmsd = &vmstate_pnv_lpc;
>   }
>   
>   static const TypeInfo pnv_lpc_power10_info = {
--------------HRmkqlDus6Zc4uNj73BA21rL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>
    </p>
    <div
style="font-family: &quot;Consolas&quot;; font-size: 11.0pt; color: #000000;background-color: #FFFFFF; font-style: normal; font-weight: normal; text-decoration: none;">
      <pre>Reviewed-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a>

Thanks, MAK</pre>
    </div>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/16/2025 9:13 AM, Caleb Schlossin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20251216151359.418708-2-calebs@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">The PNV LPC model needs snapshot/migration support.  Added a VMSTATE
descriptor to save model data and an associated post_load() method.
Snapshot support added for Power8, Power9, and Power10.

Signed-off-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a>
Signed-off-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 hw/ppc/pnv_lpc.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index f6beba0917..e52a062181 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -30,6 +30,7 @@
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/fdt.h"
+#include "migration/vmstate.h"
 
 #include &lt;libfdt.h&gt;
 
@@ -696,6 +697,43 @@ static const MemoryRegionOps opb_master_ops = {
     },
 };
 
+static int vmstate_pnv_lpc_post_load(void *opaque, int version_id)
+{
+    PnvLpcController *lpc = PNV_LPC(opaque);
+
+    memory_region_set_alias_offset(&amp;lpc-&gt;opb_isa_fw,
+                                   lpc-&gt;lpc_hc_fw_seg_idsel * LPC_FW_OPB_SIZE);
+    pnv_lpc_eval_serirq_routes(lpc);
+
+    pnv_lpc_eval_irqs(lpc);
+    return 0;
+}
+
+static const VMStateDescription vmstate_pnv_lpc = {
+    .name = TYPE_PNV_LPC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = vmstate_pnv_lpc_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(eccb_stat_reg,       PnvLpcController),
+        VMSTATE_UINT32(eccb_data_reg,       PnvLpcController),
+        VMSTATE_UINT32(opb_irq_route0,      PnvLpcController),
+        VMSTATE_UINT32(opb_irq_route1,      PnvLpcController),
+        VMSTATE_UINT32(opb_irq_stat,        PnvLpcController),
+        VMSTATE_UINT32(opb_irq_mask,        PnvLpcController),
+        VMSTATE_UINT32(opb_irq_pol,         PnvLpcController),
+        VMSTATE_UINT32(opb_irq_input,       PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_irq_inputs,   PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_fw_seg_idsel, PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_irqser_ctrl,  PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_irqmask,      PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_irqstat,      PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_error_addr,   PnvLpcController),
+        VMSTATE_UINT32(lpc_hc_fw_rd_acc_size,     PnvLpcController),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void pnv_lpc_power8_realize(DeviceState *dev, Error **errp)
 {
     PnvLpcController *lpc = PNV_LPC(dev);
@@ -721,6 +759,7 @@ static void pnv_lpc_power8_class_init(ObjectClass *klass, const void *data)
     PnvLpcClass *plc = PNV_LPC_CLASS(klass);
 
     dc-&gt;desc = "PowerNV LPC Controller POWER8";
+    dc-&gt;vmsd = &amp;vmstate_pnv_lpc;
 
     xdc-&gt;dt_xscom = pnv_lpc_dt_xscom;
 
@@ -766,6 +805,7 @@ static void pnv_lpc_power9_class_init(ObjectClass *klass, const void *data)
     PnvLpcClass *plc = PNV_LPC_CLASS(klass);
 
     dc-&gt;desc = "PowerNV LPC Controller POWER9";
+    dc-&gt;vmsd = &amp;vmstate_pnv_lpc;
 
     device_class_set_parent_realize(dc, pnv_lpc_power9_realize,
                                     &amp;plc-&gt;parent_realize);
@@ -782,6 +822,7 @@ static void pnv_lpc_power10_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc-&gt;desc = "PowerNV LPC Controller POWER10";
+    dc-&gt;vmsd = &amp;vmstate_pnv_lpc;
 }
 
 static const TypeInfo pnv_lpc_power10_info = {
</pre>
    </blockquote>
  </body>
</html>

--------------HRmkqlDus6Zc4uNj73BA21rL--


