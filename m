Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F57D609CE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVYJ3-0006KC-SF; Tue, 16 Dec 2025 11:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYIe-00069C-2j; Tue, 16 Dec 2025 11:53:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYIa-0001Hn-OI; Tue, 16 Dec 2025 11:53:23 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGCuvu0009110;
 Tue, 16 Dec 2025 16:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Iu57bU8N21ygC56ROeakRKhTR1mEWp
 NV8fCR+cIfdtk=; b=THzectssmnWOR6LOrJ5UkikhT3TQ3aeWMNzdT4EqiLAG+k
 ltuJ0Zy73ECP14vwRP7zW8/PWMf64Yg4YrLZKPlVaCRXR55WJ6Dfso+Jp4AEedJt
 caZybd7ztY2MZbI9R9YzcTYS2NiPnqP9XYj37xdqA6bjIGo4YzWIKN3vwZjSY2Aw
 dxTXZp3YcsDgjgFvFQSR4wGO0rKyQs+1bOmI2jRynClEAjHN3VAkW/ehv/ZucSpo
 06AiA4xECoyC7Q2XN+M0mH7ekFi18VVYsb66RavHbfq6nFAGWERBmd/mGGFQ/1jq
 8dLzjNxsGJJHPZYXOQvmCqqsljw2WnFAY64ocKFw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkyqpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:53:18 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGGjA0v016730;
 Tue, 16 Dec 2025 16:53:17 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkyqpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:53:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGF38wT014329;
 Tue, 16 Dec 2025 16:53:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpjw4au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:53:16 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGGrF7A38076796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 16:53:15 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0791E58050;
 Tue, 16 Dec 2025 16:53:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F01A58052;
 Tue, 16 Dec 2025 16:53:14 +0000 (GMT)
Received: from [9.10.80.59] (unknown [9.10.80.59])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 16:53:14 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------LfTPAcSxnWXoUAGG6cEy1vVI"
Message-ID: <409266c8-8729-49da-ab98-a0feec9c5336@linux.ibm.com>
Date: Tue, 16 Dec 2025 10:53:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] hw/ppc: pnv_adu.c added vmstate support
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251216151359.418708-1-calebs@linux.ibm.com>
 <20251216151359.418708-5-calebs@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20251216151359.418708-5-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6fOK_BWSjhN6uqbAnvhSFk-duOFT82Wr
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=69418e7e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=GSzVBLGgxtH2fgPNgbQA:9 a=QEXdDO2ut3YA:10
 a=PgXMhBZ8xRIDpNHfNDEA:9 a=uv4-jtJmVzp5Cqxx:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: vNYULOnb4QROO6CTh6qsGgiHiX70l6OK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfXwksV167k5KkW
 /9qRRvO312fs/K4yXLJd1jJMcBP/t8Yt0xfXT+5zm1ITuwjRpy5FNzNkDhx1lwRlF98mkLdjGJs
 35k7Gr2O5gt1mXgSZq+zut20AoNlVgUxELW1atjrWgpJTiWf/7cdHepuAyEdNFUWpFobIkgRxyP
 TDEEOlgdc3eA0lFyZPcflyi2pED9B5yYf8+ejNy9zUF6dVeus6Vtfty7Q8balrUVVQU0P5MUgsr
 VdD209V7gnX3oFCUQf3m8s4TutvrYyiKIzGu46arc0QqG5RnmdOqnC0FNFe961FbMlCWKoyPDOp
 uoCopOJuF1RDc+MjsX348HVXlCbJxiZrvdwib8fw2mNQQ8e6FcbyiQx9w91lMhJDuPJ2lXsJLBs
 gWgHmkXp9X8aPRbJxDD24ewFHMKuhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009
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
--------------LfTPAcSxnWXoUAGG6cEy1vVI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 12/16/2025 9:13 AM, Caleb Schlossin wrote:
> - Added vmstate support for ADU model
>
> Signed-off-by: Angelo Jaramillo<angelo.jaramillo@linux.ibm.com>
> Signed-off-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   hw/ppc/pnv_adu.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
> index 005fbda475..bd2a9e233a 100644
> --- a/hw/ppc/pnv_adu.c
> +++ b/hw/ppc/pnv_adu.c
> @@ -23,6 +23,7 @@
>   #include "hw/ppc/pnv_chip.h"
>   #include "hw/ppc/pnv_lpc.h"
>   #include "hw/ppc/pnv_xscom.h"
> +#include "migration/vmstate.h"
>   #include "trace.h"
>   
>   #define ADU_LPC_BASE_REG     0x40
> @@ -189,6 +190,16 @@ static const Property pnv_adu_properties[] = {
>       DEFINE_PROP_LINK("lpc", PnvADU, lpc, TYPE_PNV_LPC, PnvLpcController *),
>   };
>   
> +static const VMStateDescription pnv_adu_vmstate = {
> +    .name = TYPE_PNV_ADU,
> +    .version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(lpc_cmd_reg, PnvADU),
> +        VMSTATE_UINT64(lpc_data_reg, PnvADU),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>   static void pnv_adu_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -197,6 +208,7 @@ static void pnv_adu_class_init(ObjectClass *klass, const void *data)
>       dc->desc = "PowerNV ADU";
>       device_class_set_props(dc, pnv_adu_properties);
>       dc->user_creatable = false;
> +    dc->vmsd = &pnv_adu_vmstate;
>   }
>   
>   static const TypeInfo pnv_adu_type_info = {
--------------LfTPAcSxnWXoUAGG6cEy1vVI
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
      cite="mid:20251216151359.418708-5-calebs@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">- Added vmstate support for ADU model

Signed-off-by: Angelo Jaramillo <a class="moz-txt-link-rfc2396E" href="mailto:angelo.jaramillo@linux.ibm.com">&lt;angelo.jaramillo@linux.ibm.com&gt;</a>
Signed-off-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 hw/ppc/pnv_adu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
index 005fbda475..bd2a9e233a 100644
--- a/hw/ppc/pnv_adu.c
+++ b/hw/ppc/pnv_adu.c
@@ -23,6 +23,7 @@
 #include "hw/ppc/pnv_chip.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_xscom.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 
 #define ADU_LPC_BASE_REG     0x40
@@ -189,6 +190,16 @@ static const Property pnv_adu_properties[] = {
     DEFINE_PROP_LINK("lpc", PnvADU, lpc, TYPE_PNV_LPC, PnvLpcController *),
 };
 
+static const VMStateDescription pnv_adu_vmstate = {
+    .name = TYPE_PNV_ADU,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(lpc_cmd_reg, PnvADU),
+        VMSTATE_UINT64(lpc_data_reg, PnvADU),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_adu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -197,6 +208,7 @@ static void pnv_adu_class_init(ObjectClass *klass, const void *data)
     dc-&gt;desc = "PowerNV ADU";
     device_class_set_props(dc, pnv_adu_properties);
     dc-&gt;user_creatable = false;
+    dc-&gt;vmsd = &amp;pnv_adu_vmstate;
 }
 
 static const TypeInfo pnv_adu_type_info = {
</pre>
    </blockquote>
  </body>
</html>

--------------LfTPAcSxnWXoUAGG6cEy1vVI--


