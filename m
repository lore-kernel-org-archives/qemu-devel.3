Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CA7D609CE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVYI6-0005UH-A6; Tue, 16 Dec 2025 11:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYHq-0005Mm-Gd; Tue, 16 Dec 2025 11:52:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYHm-00019j-TW; Tue, 16 Dec 2025 11:52:33 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGBYZ0V019005;
 Tue, 16 Dec 2025 16:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=p0dj4TAglZ5GAzCM89pdeBtYL+6Oy7
 lA61a5JrHYydA=; b=BWuQJBs0eVAiuHx1jKMAJJM/QanZDTwtvHyyGMQTv9JYhO
 m9OvMvkvdpdw7eQ4XJSQbg0RcBcj/0XcNyf6XYpX0gU0X0Bg+2HnfIuFjVhFRCGB
 X4Jg55fHELWavjyv4vJn5mb7Pyy3YjMJ4L0XUja18iOWJEFLRlblbY9GpG/gzwPn
 q/vlOdLAkXTgXyEDqDsCY6afpTA1kEaf9WVmIEqHwytm4vRtSbESIleQuORDDBNI
 OhKNUYXtdD2K+iSUvI0NhUKt5/JzTe2Ud0/hzj5qr2LILmZuiZcixRcqHulgOPjQ
 gN3DLYwn7ublevjC/uMyDgzQUKZmMRIskOprXh9Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjpyynk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:52:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGGqPZG022209;
 Tue, 16 Dec 2025 16:52:25 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjpyynd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:52:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGElbCc014337;
 Tue, 16 Dec 2025 16:52:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpjw42n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:52:24 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGGqNBc19530348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 16:52:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0655A58050;
 Tue, 16 Dec 2025 16:52:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ED1558045;
 Tue, 16 Dec 2025 16:52:22 +0000 (GMT)
Received: from [9.10.80.59] (unknown [9.10.80.59])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 16:52:22 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------3NP46Y1RggOkLEx7zc29C8Wg"
Message-ID: <5799198b-9f4a-4ba9-95cc-d571339f9a1f@linux.ibm.com>
Date: Tue, 16 Dec 2025 10:52:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] hw/ppc: Add pnv_i2c vmstate support
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251216151359.418708-1-calebs@linux.ibm.com>
 <20251216151359.418708-4-calebs@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20251216151359.418708-4-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwMSBTYWx0ZWRfXxrRtFg+bxU21
 jSLulmHlEDzLXtWoOjNLjTXLN5neMyv0JsOnhaCBzfZy/PRM6JDEyd8cjRsWF7fQi04jqZxM3o9
 01K6wwbZN7nzqIDadXsO2dOvdkMJ8rlQkHhKmH8MxisHG/q77y4ABd3Tb0f7zMXOVY8BDGTgHVK
 CLmA8+fX1skv/rNBhJKcEvBTFVJpW7Yg3RS6T8k9xAUIfocGzyzifc/oIGvrUVo+3UmLaj6JQUv
 Z5F6rmXhPv7Knf6tFPQnOSeW4nz213G7cjQJsa5lwMmWG7R3D7EsR5y1NMvE6LgyoNOPVHrcZM2
 GXXgqnFRbOGLea4vH6vHal6eeCvIGITMcQqxneAGJ/IBKIEWB4AGnJAw0hAcZpWZddatxUDcnPi
 oYf+eIw9jOjhfEl/n5GpyLb4gh0/Uw==
X-Proofpoint-GUID: hBWxDPQW8cvjAa3XOWOygYoRqtIXd5bP
X-Proofpoint-ORIG-GUID: JCiPDWxFz6UgsLzaGf2BlJ5QVS65ARsj
X-Authority-Analysis: v=2.4 cv=Kq5AGGWN c=1 sm=1 tr=0 ts=69418e4a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=g0mLvYsXCx8DZqASf1AA:9 a=QEXdDO2ut3YA:10
 a=DGM2Vrrcx73IGRt511UA:9 a=mWF-ngff775fd86O:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130001
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
--------------3NP46Y1RggOkLEx7zc29C8Wg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 12/16/2025 9:13 AM, Caleb Schlossin wrote:
> - Add vmstate support for i2c registers
>
> Signed-off-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   hw/ppc/pnv_i2c.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> index 60de479491..1018078228 100644
> --- a/hw/ppc/pnv_i2c.c
> +++ b/hw/ppc/pnv_i2c.c
> @@ -19,6 +19,7 @@
>   #include "hw/ppc/pnv_i2c.h"
>   #include "hw/ppc/pnv_xscom.h"
>   #include "hw/ppc/fdt.h"
> +#include "migration/vmstate.h"
>   
>   #include <libfdt.h>
>   
> @@ -549,6 +550,15 @@ static const Property pnv_i2c_properties[] = {
>       DEFINE_PROP_UINT32("num-busses", PnvI2C, num_busses, 1),
>   };
>   
> +static const VMStateDescription pnv_i2c_vmstate = {
> +    .name = TYPE_PNV_I2C,
> +    .version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(regs, PnvI2C, PNV_I2C_REGS),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>   static void pnv_i2c_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -561,6 +571,7 @@ static void pnv_i2c_class_init(ObjectClass *klass, const void *data)
>   
>       dc->desc = "PowerNV I2C";
>       dc->realize = pnv_i2c_realize;
> +    dc->vmsd = &pnv_i2c_vmstate;
>       device_class_set_props(dc, pnv_i2c_properties);
>   }
>   
--------------3NP46Y1RggOkLEx7zc29C8Wg
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
      cite="mid:20251216151359.418708-4-calebs@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">- Add vmstate support for i2c registers

Signed-off-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 hw/ppc/pnv_i2c.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 60de479491..1018078228 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -19,6 +19,7 @@
 #include "hw/ppc/pnv_i2c.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/fdt.h"
+#include "migration/vmstate.h"
 
 #include &lt;libfdt.h&gt;
 
@@ -549,6 +550,15 @@ static const Property pnv_i2c_properties[] = {
     DEFINE_PROP_UINT32("num-busses", PnvI2C, num_busses, 1),
 };
 
+static const VMStateDescription pnv_i2c_vmstate = {
+    .name = TYPE_PNV_I2C,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(regs, PnvI2C, PNV_I2C_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -561,6 +571,7 @@ static void pnv_i2c_class_init(ObjectClass *klass, const void *data)
 
     dc-&gt;desc = "PowerNV I2C";
     dc-&gt;realize = pnv_i2c_realize;
+    dc-&gt;vmsd = &amp;pnv_i2c_vmstate;
     device_class_set_props(dc, pnv_i2c_properties);
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------3NP46Y1RggOkLEx7zc29C8Wg--


