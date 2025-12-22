Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EC0E6B272
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 11:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY081-0007io-0X; Tue, 23 Dec 2025 06:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vY07y-0007hZ-C4; Tue, 23 Dec 2025 06:00:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vY07w-0006qc-2t; Tue, 23 Dec 2025 06:00:30 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM8etH5026247;
 Mon, 22 Dec 2025 10:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=och4ck5Z6JAZsFeTe2fc+bMz4CM373
 XGgS45umaL4+k=; b=KPEFOoIHqf3EIcjGcoRlH0z84Sf4JfgS5c9WLUVMP6FoZL
 FpKJ90uvDme5UGobxVKbbkld4hv7k1zjPM6zRF94k4oe8ChqiMyyUiGvQLc/YDBN
 GdDRqV7TVPWuvLq35UYuflPwzUfClDgxBUs1EHeMf6Vj488WIHNV2KcfT2fbBl14
 JGle2Z3FLOcLuyLoaB3x2JPnENVyMwSj6dVRCevMlGUwFCQLb5UFBrhyRTSUhOGq
 BV+Pvl/eHOJgUcf0Ugt4x8Xl/Llbga3MdIWshWPosc4260VZ6n6DV0/CcuSSfBoS
 e6bijc21dvwZlj7IZPTgxKaM8dVLgXfdjc6eoajw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh47j5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:48:34 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BMAfx4i022440;
 Mon, 22 Dec 2025 10:48:34 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh47j5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:48:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM8mHAJ001095;
 Mon, 22 Dec 2025 10:48:33 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b664s5rhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:48:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BMAmEfS17171008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Dec 2025 10:48:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3754F58058;
 Mon, 22 Dec 2025 10:48:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B62E258057;
 Mon, 22 Dec 2025 10:48:28 +0000 (GMT)
Received: from [9.43.97.98] (unknown [9.43.97.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Dec 2025 10:48:28 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------T3rRHlIE4GSR0ZjSTsSHuTac"
Message-ID: <7cf4cb02-fe6e-4438-b6bb-8e71702ec031@inux.ibm.com>
Date: Mon, 22 Dec 2025 16:18:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ppc/pnv: Add unimplemented quad and core regs
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-4-calebs@linux.ibm.com>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@inux.ibm.com>
In-Reply-To: <20251218200353.301866-4-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bulBxUai c=1 sm=1 tr=0 ts=69492202 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=531-BUQ_cv5humE0wNkA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=eGgGPLgfgt7bj44kCrMA:9 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: t1mBAnX-rzR8MboUziNS0tPNA2QF8vlU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA5OCBTYWx0ZWRfX4Ds++SQxDYy1
 3sxdF8Wnv0GaZqYcjVX/1dG67ZJh59DaBbVlMH2o7xjdpbHUlpfgO7CQlQq24tlxXPkIEdLNpB7
 2Xk2SHQWLBfJ2RGvwWq3Tl0LKo5Go/RJMcyoaNQPZWs8ppiBK/E3+e+eyx5qQLK3KKlqnyeZMug
 fmwW90e2YsHIECUQaiZwRZD4MFlpqYgR+cs+sZW11yWcvhJ7pp1MCHEWFjtt+T3+5dnGjtAzvZt
 +ZesfWAK7UfaIuaCEyITyPM3DwsHAoVr/dFaCAZImKVwtjwxsE6d+C6DKqJxiGiV9t4o4hHJzFa
 W330vR5qVtApFpFu5Mzj/H9V0f78MccUm1HdjFvarweKuVOoYYMTAKObETdw8aSlijoeutDYcEc
 YhER2iq6qjG0exCgcAezXVM8KZ7HcVllSclqwW1OxK1J9tEBe1NBLP14LqvES6Y3S5YiOL5rnqO
 Ix7HMLQ1zAHyblBdRAQ==
X-Proofpoint-GUID: ECZVLNrw6FJa1Ajwk9b7y3f-mJJUXDHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1034 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512220098
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=chalapathi.v@inux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
--------------T3rRHlIE4GSR0ZjSTsSHuTac
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com 
<mailto:milesg@linux.ibm.com>


On 19/12/25 1:33 am, Caleb Schlossin wrote:
> This commit adds the read/write functionality for few core and
> quad registers.
>
> Signed-off-by: Chalapathi V<chalapathi.v@linux.ibm.com>
> Signed-off-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   hw/ppc/pnv_core.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)
>
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index fb2dfc7ba2..84a2fa6364 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -184,10 +184,18 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
>    * POWER10 core controls
>    */
>   
> +#define PNV10_XSCOM_EC_IMA_EVENT_MASK       0x400
>   #define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
>   #define PNV10_XSCOM_EC_CORE_THREAD_INFO     0x413
> +#define PNV10_XSCOM_EC_CORE_FIRMASK         0x443
> +#define PNV10_XSCOM_EC_CORE_FIRMASK_AND     0x444
> +#define PNV10_XSCOM_EC_CORE_FIRMASK_OR      0x445
>   #define PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS 0x449
>   #define PNV10_XSCOM_EC_CORE_RAS_STATUS      0x454
> +#define PNV10_XSCOM_EC_SPATTN_OR            0x497
> +#define PNV10_XSCOM_EC_SPATTN_AND           0x498
> +#define PNV10_XSCOM_EC_SPATTN               0x499
> +#define PNV10_XSCOM_EC_SPATTN_MASK          0x49A
>   
>   static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>                                              unsigned int width)
> @@ -223,6 +231,19 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>               }
>           }
>           break;
> +    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK:
> +        return 0;
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
> +    case PNV10_XSCOM_EC_SPATTN_OR:
> +    case PNV10_XSCOM_EC_SPATTN_AND:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
> +                              "xscom read at 0x%08x\n", __func__, offset);
> +        break;
> +    case PNV10_XSCOM_EC_SPATTN:
> +    case PNV10_XSCOM_EC_SPATTN_MASK:
> +        return 0;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
>                         offset);
> @@ -283,6 +304,15 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
>           }
>           break;
>   
> +    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
> +    case PNV10_XSCOM_EC_SPATTN_OR:
> +    case PNV10_XSCOM_EC_SPATTN_AND:
> +    case PNV10_XSCOM_EC_SPATTN:
> +    case PNV10_XSCOM_EC_SPATTN_MASK:
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                         offset);
> @@ -568,6 +598,23 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
>    * POWER10 Quads
>    */
>   
> +#define P10_XSCOM_EQ3_MODE_REG1         0x1160a
> +#define P10_XSCOM_EQ3_NCU_SPEC_BAR_REG  0x11650
> +#define P10_XSCOM_EQ3_HTM_MODE          0x11680
> +#define P10_XSCOM_EQ3_HTM_IMA_PDBAR     0x1168b
> +#define P10_XSCOM_EQ2_MODE_REG1         0x1260a
> +#define P10_XSCOM_EQ2_NCU_SPEC_BAR_REG  0x12650
> +#define P10_XSCOM_EQ2_HTM_MODE          0x12680
> +#define P10_XSCOM_EQ2_HTM_IMA_PDBAR     0x1268b
> +#define P10_XSCOM_EQ1_MODE_REG1         0x1460a
> +#define P10_XSCOM_EQ1_NCU_SPEC_BAR_REG  0x14650
> +#define P10_XSCOM_EQ1_HTM_MODE          0x14680
> +#define P10_XSCOM_EQ1_HTM_IMA_PDBAR     0x1468b
> +#define P10_XSCOM_EQ0_MODE_REG1         0x1860a
> +#define P10_XSCOM_EQ0_NCU_SPEC_BAR_REG  0x18650
> +#define P10_XSCOM_EQ0_HTM_MODE          0x18680
> +#define P10_XSCOM_EQ0_HTM_IMA_PDBAR     0x1868b
> +
>   static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>                                               unsigned int width)
>   {
> @@ -575,6 +622,23 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>       uint64_t val = -1;
>   
>       switch (offset) {
> +    case P10_XSCOM_EQ0_MODE_REG1:
> +    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ0_HTM_MODE:
> +    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ1_MODE_REG1:
> +    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ1_HTM_MODE:
> +    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ2_MODE_REG1:
> +    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ2_HTM_MODE:
> +    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ3_MODE_REG1:
> +    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ3_HTM_MODE:
> +    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:
> +        return 0;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
>                         offset);
> @@ -589,6 +653,23 @@ static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
>       uint32_t offset = addr >> 3;
>   
>       switch (offset) {
> +    case P10_XSCOM_EQ0_MODE_REG1:
> +    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ0_HTM_MODE:
> +    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ1_MODE_REG1:
> +    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ1_HTM_MODE:
> +    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ2_MODE_REG1:
> +    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ2_HTM_MODE:
> +    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ3_MODE_REG1:
> +    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ3_HTM_MODE:
> +    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                         offset);
--------------T3rRHlIE4GSR0ZjSTsSHuTac
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
      Chalapathi V <a href="mailto:milesg@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com</a></p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US"><br>
    </p>
    <div class="moz-cite-prefix">On 19/12/25 1:33 am, Caleb Schlossin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20251218200353.301866-4-calebs@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">This commit adds the read/write functionality for few core and
quad registers.

Signed-off-by: Chalapathi V <a class="moz-txt-link-rfc2396E" href="mailto:chalapathi.v@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com&gt;</a>
Signed-off-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 hw/ppc/pnv_core.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index fb2dfc7ba2..84a2fa6364 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -184,10 +184,18 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
  * POWER10 core controls
  */
 
+#define PNV10_XSCOM_EC_IMA_EVENT_MASK       0x400
 #define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
 #define PNV10_XSCOM_EC_CORE_THREAD_INFO     0x413
+#define PNV10_XSCOM_EC_CORE_FIRMASK         0x443
+#define PNV10_XSCOM_EC_CORE_FIRMASK_AND     0x444
+#define PNV10_XSCOM_EC_CORE_FIRMASK_OR      0x445
 #define PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS 0x449
 #define PNV10_XSCOM_EC_CORE_RAS_STATUS      0x454
+#define PNV10_XSCOM_EC_SPATTN_OR            0x497
+#define PNV10_XSCOM_EC_SPATTN_AND           0x498
+#define PNV10_XSCOM_EC_SPATTN               0x499
+#define PNV10_XSCOM_EC_SPATTN_MASK          0x49A
 
 static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
                                            unsigned int width)
@@ -223,6 +231,19 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
             }
         }
         break;
+    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
+    case PNV10_XSCOM_EC_CORE_FIRMASK:
+        return 0;
+    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
+    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
+    case PNV10_XSCOM_EC_SPATTN_OR:
+    case PNV10_XSCOM_EC_SPATTN_AND:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                              "xscom read at 0x%08x\n", __func__, offset);
+        break;
+    case PNV10_XSCOM_EC_SPATTN:
+    case PNV10_XSCOM_EC_SPATTN_MASK:
+        return 0;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
@@ -283,6 +304,15 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
         }
         break;
 
+    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
+    case PNV10_XSCOM_EC_CORE_FIRMASK:
+    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
+    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
+    case PNV10_XSCOM_EC_SPATTN_OR:
+    case PNV10_XSCOM_EC_SPATTN_AND:
+    case PNV10_XSCOM_EC_SPATTN:
+    case PNV10_XSCOM_EC_SPATTN_MASK:
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
@@ -568,6 +598,23 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
  * POWER10 Quads
  */
 
+#define P10_XSCOM_EQ3_MODE_REG1         0x1160a
+#define P10_XSCOM_EQ3_NCU_SPEC_BAR_REG  0x11650
+#define P10_XSCOM_EQ3_HTM_MODE          0x11680
+#define P10_XSCOM_EQ3_HTM_IMA_PDBAR     0x1168b
+#define P10_XSCOM_EQ2_MODE_REG1         0x1260a
+#define P10_XSCOM_EQ2_NCU_SPEC_BAR_REG  0x12650
+#define P10_XSCOM_EQ2_HTM_MODE          0x12680
+#define P10_XSCOM_EQ2_HTM_IMA_PDBAR     0x1268b
+#define P10_XSCOM_EQ1_MODE_REG1         0x1460a
+#define P10_XSCOM_EQ1_NCU_SPEC_BAR_REG  0x14650
+#define P10_XSCOM_EQ1_HTM_MODE          0x14680
+#define P10_XSCOM_EQ1_HTM_IMA_PDBAR     0x1468b
+#define P10_XSCOM_EQ0_MODE_REG1         0x1860a
+#define P10_XSCOM_EQ0_NCU_SPEC_BAR_REG  0x18650
+#define P10_XSCOM_EQ0_HTM_MODE          0x18680
+#define P10_XSCOM_EQ0_HTM_IMA_PDBAR     0x1868b
+
 static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
                                             unsigned int width)
 {
@@ -575,6 +622,23 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
     uint64_t val = -1;
 
     switch (offset) {
+    case P10_XSCOM_EQ0_MODE_REG1:
+    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ0_HTM_MODE:
+    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ1_MODE_REG1:
+    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ1_HTM_MODE:
+    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ2_MODE_REG1:
+    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ2_HTM_MODE:
+    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ3_MODE_REG1:
+    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ3_HTM_MODE:
+    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:
+        return 0;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
@@ -589,6 +653,23 @@ static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
     uint32_t offset = addr &gt;&gt; 3;
 
     switch (offset) {
+    case P10_XSCOM_EQ0_MODE_REG1:
+    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ0_HTM_MODE:
+    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ1_MODE_REG1:
+    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ1_HTM_MODE:
+    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ2_MODE_REG1:
+    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ2_HTM_MODE:
+    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ3_MODE_REG1:
+    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ3_HTM_MODE:
+    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
</pre>
    </blockquote>
  </body>
</html>

--------------T3rRHlIE4GSR0ZjSTsSHuTac--


