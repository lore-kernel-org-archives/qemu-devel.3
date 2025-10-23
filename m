Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468BFCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn8i-000206-HM; Thu, 23 Oct 2025 00:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBn8h-0001zu-Db; Thu, 23 Oct 2025 00:41:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBn8f-00028V-3j; Thu, 23 Oct 2025 00:41:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N0Cwcn024633;
 Thu, 23 Oct 2025 04:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XxH7fz
 mE4P6hVwXVE5RqwkB0iPebh0mHLUi2ZdQzt2o=; b=BSGPtEvRTsR9aObiqkgzoA
 GDRImamy7QmSGo5ZcPk9bapqmfjSgA526digcV2coY1tOzNtTFZ3x64uv0Bh05Cx
 nmtLVfSy5wFLKpH4xVc431n9U95m/qItBG1FDMbBUPiJMZYzZqpW9H2Hs43wcbeR
 59d9x2FpDdwCG8XCPU2R5Yh8sZ6dVsEteN+Y4Ity06lB8PNjGkgZrDEDWAdH57qP
 VLnkJ4LhEwBd5Q6ZKe3weIrR1WQhQpV4PLmHYwU7XiE9Ywh/a4PInR7M3Me0LYJ9
 bkC14hps78cgQ0fvogqyUY1MI+yXuBw0Fo4SefboftCVSsPh4QBX6WYI8WfUt9ow
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31ceykn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 04:41:19 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59N4VqPI014555;
 Thu, 23 Oct 2025 04:41:18 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31ceykj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 04:41:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N0NbLa014676;
 Thu, 23 Oct 2025 04:41:17 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sc6g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 04:41:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59N4fG5m51184006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 04:41:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A347458052;
 Thu, 23 Oct 2025 04:41:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E37775805D;
 Thu, 23 Oct 2025 04:41:14 +0000 (GMT)
Received: from [9.124.221.73] (unknown [9.124.221.73])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 04:41:14 +0000 (GMT)
Message-ID: <3071c558-61e0-49fb-8442-9f6e9b363c93@linux.ibm.com>
Date: Thu, 23 Oct 2025 10:11:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/amigaone: Free allocated struct
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251022211649.9A09E5972E5@zero.eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20251022211649.9A09E5972E5@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aAcOo04Tu693yGxTzmK7QGxMCdxSFkv-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9gDlELOPbVnx
 3st6Vf1OqCP8hMoKnbcJpHcmRj07/AXzU41ncxsZbPKYxQfUuD5f7OjNIPRBYXEtuc+2almXWYY
 2OvubCBT+wqY4ml/0T4hit9beCxXs+/ZEdLTfbqoRhZg+VdNz0rhCgdINPM1l8pwTQP90xmeWwc
 EAyjghxKIW4AG84hMUtKfJ34f99qWzYPVX3Pc+bpj1nRisxkFEuuq5XJ543iwNbtm9CFRVtTPSR
 UOEev7mCcwNmhDHGK05E3b1C4FLhbssJk8VRKcOkMQT9qkrc3xkMpQBtxX6Nuu3BGLNvhs40Z7Z
 OG9bv6WCWcCtn7m6b5RWrk+hNbzwVJ/WTrZTb7SoWNke0GhmlKIkEbHYnXyxmlPXezn6egHBaKM
 D/aiyNb8H3gnsD3uB6349vM668IuPg==
X-Proofpoint-GUID: 7X2LA4QUpRqcOJo8LUNGm9dU3b5eKn9u
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f9b1ef cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=O0fAPOUEty8ZO6K3NPAA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=oH34dK2VZjykjzsv8OSz:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/23/25 02:37, BALATON Zoltan wrote:
> In create_bd_info function a bd_info struct is allocated but never
> freed. Mark it g_autofree to avoid leaking it.
> 
> Fixes: 34f053d86b (ppc/amigaone: Add kernel and initrd support)
> Resolves: Coverity CID 1641398
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/amigaone.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 12279f42bc..47fb016b4a 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -221,7 +221,7 @@ struct bd_info {
>   
>   static void create_bd_info(hwaddr addr, ram_addr_t ram_size)
>   {
> -    struct bd_info *bd = g_new0(struct bd_info, 1);
> +    g_autofree struct bd_info *bd = g_new0(struct bd_info, 1);
>   

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>       bd->bi_memsize =    cpu_to_be32(ram_size);
>       bd->bi_flashstart = cpu_to_be32(PROM_ADDR);

