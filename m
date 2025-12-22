Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45A7E674B2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 13:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXgIx-0004a4-Cp; Mon, 22 Dec 2025 08:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vXdjF-0007d3-LN; Mon, 22 Dec 2025 06:05:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vXdjE-0001HN-1w; Mon, 22 Dec 2025 06:05:29 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM70Epg010628;
 Mon, 22 Dec 2025 10:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=cbEIsOUHLpyCdtzVJwEBzMZt5APapr
 e6WsS3wtj08vc=; b=gvjWtfja9boe7AZT41FYEWjvRLZzLal6pIWm50CtTs8f4P
 /NX+/9p1+jPlhC41L5H34T+/XiaYPMbOnDITQN1TK8zPelKTacYxx9fHo3zC5qjv
 +MbkweI4YCs5JQp9t1RSk2jIdWOyDhsK8t+yktST/F5VbPQWNRxroQViGjCUB5A0
 B44l6isFjJ9V+TQ9OYDkP4S3Kt52fo+I36DUnyeYU3BMwq23yQyb5WfcU/OerlwD
 Oec7G2UFCcbG4nz7uiSWAt55VAOPBzcHxNbu4cULNbKPS+EAsd1T2u5es3mPCol2
 N+hsTVpKcN/VKs60D7JLnBl/1MfP3CJQn0CJsa2A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5j7dyed7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:47:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BMAlZrM004720;
 Mon, 22 Dec 2025 10:47:35 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5j7dyed0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:47:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMAbotT026979;
 Mon, 22 Dec 2025 10:47:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b6r932p71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:47:34 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BMAlXX461473242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Dec 2025 10:47:33 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B0AE58058;
 Mon, 22 Dec 2025 10:47:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03E165805D;
 Mon, 22 Dec 2025 10:47:31 +0000 (GMT)
Received: from [9.43.97.98] (unknown [9.43.97.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Dec 2025 10:47:30 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------SuEtluKFEJm0YCMq61NQGsls"
Message-ID: <f32958f2-956c-4ce1-ba32-badd02198dfc@inux.ibm.com>
Date: Mon, 22 Dec 2025 16:17:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ppc/pnv: Support for SECURITY_SWITCH XSCOM register
 access
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-3-calebs@linux.ibm.com>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@inux.ibm.com>
In-Reply-To: <20251218200353.301866-3-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G8YR0tk5 c=1 sm=1 tr=0 ts=694921c7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=v778AP8itq83rbahFKMA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=rhZDsxdhWw0Yntd0-ucA:9 a=4UjEVrMdqFmxKs_O:21 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: fMTB5hl9bCX3G5mn-r40oVfbhDcp8xQ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA5OCBTYWx0ZWRfX6nayimQTyH3g
 44CZmAQIaX9eYxcYVwIXWtiAzqH/ryf7S+8JgeXS+XMGuC3DSICqPhJfA5O0Xy4E/4OQ/FRkmrR
 lXmZoVzU6AbCCrRZWgdCjkxk5lTdfTCnrIbUg9HoBlKmEipu3/KEJKVmCC3UoEV8mh8EDqIP7ml
 FI9ka5YwIZPtOaAkeThBf2bDNm+2XACttC4iqKETUDXsMRQzw5A8S4q5lkmzDDeN8NzMI3wFbWQ
 PgJte64QLmr1GNAVlgaptCPFxiTAE2/R8WtgHu0vsaPFPUX1a4pYFtIqD0T4b+G1L/Cu0/Rr4iv
 k1MMXyQ5mRg9hve20PINlGNFTbAiVY3vX/Ms+gR5vCTdw45FAXUKBGyxlelg3/8qZnEoK1qliom
 ld/tUuKSzjf+en9vvOM5GwNg6RmDExeck4eSZl/84sBsKVc9AbrPliFLxtBnhAcwK9YuWBp9+BS
 qHxzrFj9yByG86tioTw==
X-Proofpoint-GUID: 4bnDzsvKMQGhtASDE5hdNio_qyZwJZDT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1034 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512220098
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=chalapathi.v@inux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:50:08 -0500
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
--------------SuEtluKFEJm0YCMq61NQGsls
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com> 
<mailto:milesg@linux.ibm.com>


On 19/12/25 1:33 am, Caleb Schlossin wrote:
> Power Hypervisor code requires access to the SECURITY_SWITCH
> XSCOM register at MMIO address 0x80028 (scom address 0x10005).
> Adding basic read support for now so that is doesn't cause
> error messages to be posted.
>
> Signed-off-by: Glenn Miles<milesg@linux.ibm.com>
> Signed-off-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   hw/ppc/pnv_xscom.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index fbfec829d5..308430def7 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -61,6 +61,8 @@ static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
>   static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
>   {
>       switch (pcba) {
> +    case 0x10005:       /* SECURITY SWITCH */
> +        return 0;
>       case 0xf000f:
>           return PNV_CHIP_GET_CLASS(chip)->chip_cfam_id;
>       case 0x18002:       /* ECID2 */
--------------SuEtluKFEJm0YCMq61NQGsls
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
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US">Reviewed-by:
      Chalapathi V <a href="mailto:milesg@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com&gt;</a></p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US"><br>
    </p>
    <div class="moz-cite-prefix">On 19/12/25 1:33 am, Caleb Schlossin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20251218200353.301866-3-calebs@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">Power Hypervisor code requires access to the SECURITY_SWITCH
XSCOM register at MMIO address 0x80028 (scom address 0x10005).
Adding basic read support for now so that is doesn't cause
error messages to be posted.

Signed-off-by: Glenn Miles <a class="moz-txt-link-rfc2396E" href="mailto:milesg@linux.ibm.com">&lt;milesg@linux.ibm.com&gt;</a>
Signed-off-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 hw/ppc/pnv_xscom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index fbfec829d5..308430def7 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -61,6 +61,8 @@ static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
 static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
 {
     switch (pcba) {
+    case 0x10005:       /* SECURITY SWITCH */
+        return 0;
     case 0xf000f:
         return PNV_CHIP_GET_CLASS(chip)-&gt;chip_cfam_id;
     case 0x18002:       /* ECID2 */
</pre>
    </blockquote>
  </body>
</html>

--------------SuEtluKFEJm0YCMq61NQGsls--


