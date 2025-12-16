Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321CFD609CE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVYI6-0005U5-AW; Tue, 16 Dec 2025 11:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYH4-0005Eb-Gc; Tue, 16 Dec 2025 11:51:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYGy-00014o-9N; Tue, 16 Dec 2025 11:51:43 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG6vStP024778;
 Tue, 16 Dec 2025 16:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=1kHLIEufp7oO4Ou2dto4+ssyfIfwu2
 M2mXAGtz7p7X4=; b=AyZKoWdTlKYvKQS6YBwQzjkD4s2yni8eP6TE8N36gK0iFq
 09H4/eV0mthD6aCfdA7kQ3CW2RLVxKT/UpsL8mkuFzT38AxE4N9a7DIHpHqxAhH6
 exAWWAKI08nuUt6IrfrKiwlu0YnfwkRsT9ySvDmgHBSYAt1Pq7a2ZMLwQn+/olKf
 yii6d7npfZwY0PKT/vEburZf7tuGtH4Nt/MiZ3j/Z9/GXpM+iRQmYHmWP7x0Kzcb
 K3Nm3a8pF38JmZbWnoBqQCAzREfhWxPFu/5hfu9hFx+IKGZFXWI6m72f8ULDJUzT
 8LKzoMK54pqDC0UVMRt+ct9KzCqTa33e4Xz/CnDA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv8a0c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:51:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGGpZ1w011679;
 Tue, 16 Dec 2025 16:51:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv8a08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:51:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGGjMo7002960;
 Tue, 16 Dec 2025 16:51:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kykn8nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:51:34 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGGpWRc27853414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 16:51:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8651358050;
 Tue, 16 Dec 2025 16:51:32 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C779F58045;
 Tue, 16 Dec 2025 16:51:31 +0000 (GMT)
Received: from [9.10.80.59] (unknown [9.10.80.59])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 16:51:31 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------1yMmSQm8nwqg953ZcckMWKiu"
Message-ID: <655e89f2-c153-4e47-bccc-4dccfd2b8edf@linux.ibm.com>
Date: Tue, 16 Dec 2025 10:51:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] hw/ppc: Add pnv_spi vmstate support
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251216151359.418708-1-calebs@linux.ibm.com>
 <20251216151359.418708-3-calebs@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20251216151359.418708-3-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX3AvoaAKeymnr
 XNithJzzz/BilM21K/fMxMAD5nZQIBDyAK3HPl+LtugsgBPlOnHS0OdZu2OULvTnimcBLwuF402
 Kfgac4/Yfym9fDV8sC0KEIrM5bPge2zEzWokkkptq0E0p6G/HcEtZ+9RLgrntNoMpFTOPbhPtF2
 KnybC9FpRs6L3keqN/L0rUD/ZcrZGIMN70FqonUmzicxyELCX5dMcFDEcAzD1b4zsSlp2/ZGWgc
 JbxX1YqHTkPSbxHKYWy6JkUf+uZHqYouC7mVf1rfHHE6BirMgTg/AT3RfnV82aTIXuDscEV8zDG
 KWWFVpjBuYiS3OAfPYYdCPWr6PRs40vC1A2HVNtETI0L9VMPL/JMidEPOs95InMaLD0bv/YXTFk
 pemWEqpuZmGRmUuFxURkTZsoiiplJQ==
X-Proofpoint-ORIG-GUID: 0T03VF60XAoW-rYD_Yof62wuwtd8bB0l
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=69418e17 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=LEF61e_nMQqlYfngrsEA:9 a=QEXdDO2ut3YA:10
 a=zPJzuvo3V7OF8ZkWVCkA:9 a=mWF-ngff775fd86O:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: bnIFGWy4rK410ZqfV1VO7BgZ46DpL_i6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
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
--------------1yMmSQm8nwqg953ZcckMWKiu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 12/16/2025 9:13 AM, Caleb Schlossin wrote:
> - Add support for needed PnvSpi structure variables
>
> Signed-off-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   hw/ssi/pnv_spi.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index f40e8836b9..389a2cca6b 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -13,6 +13,7 @@
>   #include "hw/ssi/pnv_spi.h"
>   #include "hw/ssi/pnv_spi_regs.h"
>   #include "hw/ssi/ssi.h"
> +#include "migration/vmstate.h"
>   #include <libfdt.h>
>   #include "hw/irq.h"
>   #include "trace.h"
> @@ -1199,6 +1200,31 @@ static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,
>       return 0;
>   }
>   
> +static const VMStateDescription pnv_spi_vmstate = {
> +    .name = TYPE_PNV_SPI,
> +    .version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8(fail_count, PnvSpi),
> +        VMSTATE_UINT8(transfer_len, PnvSpi),
> +        VMSTATE_UINT8(responder_select, PnvSpi),
> +        VMSTATE_BOOL(shift_n1_done, PnvSpi),
> +        VMSTATE_UINT8(loop_counter_1, PnvSpi),
> +        VMSTATE_UINT8(loop_counter_2, PnvSpi),
> +        VMSTATE_UINT8(N1_bits, PnvSpi),
> +        VMSTATE_UINT8(N2_bits, PnvSpi),
> +        VMSTATE_UINT8(N1_bytes, PnvSpi),
> +        VMSTATE_UINT8(N2_bytes, PnvSpi),
> +        VMSTATE_UINT8(N1_tx, PnvSpi),
> +        VMSTATE_UINT8(N2_tx, PnvSpi),
> +        VMSTATE_UINT8(N1_rx, PnvSpi),
> +        VMSTATE_UINT8(N2_rx, PnvSpi),
> +        VMSTATE_UINT64_ARRAY(regs, PnvSpi, PNV_SPI_REGS),
> +        VMSTATE_UINT8_ARRAY(seq_op, PnvSpi, PNV_SPI_REG_SIZE),
> +        VMSTATE_UINT64(status, PnvSpi),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>   static void pnv_spi_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -1209,6 +1235,7 @@ static void pnv_spi_class_init(ObjectClass *klass, const void *data)
>       dc->desc = "PowerNV SPI";
>       dc->realize = pnv_spi_realize;
>       device_class_set_legacy_reset(dc, do_reset);
> +    dc->vmsd = &pnv_spi_vmstate;
>       device_class_set_props(dc, pnv_spi_properties);
>   }
>   
--------------1yMmSQm8nwqg953ZcckMWKiu
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
      cite="mid:20251216151359.418708-3-calebs@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">- Add support for needed PnvSpi structure variables

Signed-off-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 hw/ssi/pnv_spi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index f40e8836b9..389a2cca6b 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -13,6 +13,7 @@
 #include "hw/ssi/pnv_spi.h"
 #include "hw/ssi/pnv_spi_regs.h"
 #include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
 #include &lt;libfdt.h&gt;
 #include "hw/irq.h"
 #include "trace.h"
@@ -1199,6 +1200,31 @@ static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,
     return 0;
 }
 
+static const VMStateDescription pnv_spi_vmstate = {
+    .name = TYPE_PNV_SPI,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(fail_count, PnvSpi),
+        VMSTATE_UINT8(transfer_len, PnvSpi),
+        VMSTATE_UINT8(responder_select, PnvSpi),
+        VMSTATE_BOOL(shift_n1_done, PnvSpi),
+        VMSTATE_UINT8(loop_counter_1, PnvSpi),
+        VMSTATE_UINT8(loop_counter_2, PnvSpi),
+        VMSTATE_UINT8(N1_bits, PnvSpi),
+        VMSTATE_UINT8(N2_bits, PnvSpi),
+        VMSTATE_UINT8(N1_bytes, PnvSpi),
+        VMSTATE_UINT8(N2_bytes, PnvSpi),
+        VMSTATE_UINT8(N1_tx, PnvSpi),
+        VMSTATE_UINT8(N2_tx, PnvSpi),
+        VMSTATE_UINT8(N1_rx, PnvSpi),
+        VMSTATE_UINT8(N2_rx, PnvSpi),
+        VMSTATE_UINT64_ARRAY(regs, PnvSpi, PNV_SPI_REGS),
+        VMSTATE_UINT8_ARRAY(seq_op, PnvSpi, PNV_SPI_REG_SIZE),
+        VMSTATE_UINT64(status, PnvSpi),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_spi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1209,6 +1235,7 @@ static void pnv_spi_class_init(ObjectClass *klass, const void *data)
     dc-&gt;desc = "PowerNV SPI";
     dc-&gt;realize = pnv_spi_realize;
     device_class_set_legacy_reset(dc, do_reset);
+    dc-&gt;vmsd = &amp;pnv_spi_vmstate;
     device_class_set_props(dc, pnv_spi_properties);
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------1yMmSQm8nwqg953ZcckMWKiu--


