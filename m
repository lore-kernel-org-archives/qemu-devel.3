Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BF8C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHgz-0007yR-W9; Wed, 14 May 2025 15:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHVk-000051-1V; Wed, 14 May 2025 15:11:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHVh-0001eQ-7F; Wed, 14 May 2025 15:11:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EFu9fB025668;
 Wed, 14 May 2025 19:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FAr7FC
 eah1jxRLDP5Jt+Eer08bAC8GKwtEHQNg3zYb8=; b=sp/FSTlEyzHqxsLUNHQyQS
 738mJsFCUUuUKXSqiAby9GDE74H0nntxo2HdwpM/1N8ZHW7r/iJJbtbRM5yPsiDb
 yN3KHu3UbTViAv8SNk3iCAqbw1qCIUcALS2th+ZCBKWlLUEPguEpzXaFzMlMQ7Gd
 ljbRkDRcxmaMGpCMfvmZhou8FBHKGzvMURdCp50KYe1MErf8wqP9rSt+UkXr7So7
 oibaKRCVe5vWacma3n1DhRT4ojCN3K2xEWmUz1H9X9IpIzdIinFtQ5TM/q5J+yIm
 AEf45PC3y9uiyOmV4eNhoH2qZgUnNC5xkLAMCG3oHr+CNLzhjh5D6kp/dx1r66Eg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst3v2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:11:19 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EJBIN9008018;
 Wed, 14 May 2025 19:11:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst3v2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:11:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGeFWe021439;
 Wed, 14 May 2025 19:11:17 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrp0g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:11:17 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJBC3j61997536
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:11:13 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 291F358054;
 Wed, 14 May 2025 19:11:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A219F5803F;
 Wed, 14 May 2025 19:11:15 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:11:15 +0000 (GMT)
Message-ID: <fdf1a8b9-9410-4730-8158-e82a3a97db9c@linux.ibm.com>
Date: Wed, 14 May 2025 14:11:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/50] pnv/xive2: Permit valid writes to VC/PC Flush
 Control registers
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-21-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-21-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X2UCLrorW1pcpXJzXJbMnPLw_sR8ViOH
X-Authority-Analysis: v=2.4 cv=V+590fni c=1 sm=1 tr=0 ts=6824ead7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=P93fn80vtagMCGxTHyoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _edd44sLJBE9cRxyfft-hLzqyXRfM_Ex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE3NCBTYWx0ZWRfXxzszxSu5FZBA
 wAh3SEXm+3AGnOt4X+4PISMn092Qd2CYvokK99EjD+i1crmgnJKwXmi7ZUFxvje9Ypoe6J6hrIt
 I3UlhnhBXlcFvB5EfXtNlfd6pUmROikshZcCqCZIUYO05XNkC4ij9HWRyErdioRQnR/YtPRnPSk
 COugqjodkKMtbKbMxXVAz9aFATaQa6iML0sNFYnQuOfjG30Dl/tTk+1Xik94exK3uyBL/OpoebX
 ljRoBHafhLEfxs5hHCDATtFpjruPZG5B0IBFK5ekvxr5O07sVaaHxJvBpI/ePqurgLFs1/vKK1v
 aSMqfT00K6fSQr3Y5D9SP6fh5CwV43Hbu0wmXDecaCvYJ0w/wC1DqMNtPUVjed00D58+E/uGm5P
 1Agh5K7dAjnpu4uvcACl/Q4/Haq6kAf1gleJr2pU1dG23u5zbUyG629wDBZ34IJAkYSCs3Ax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 mlxlogscore=866 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140174
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> From: Michael Kowal <kowal@linux.ibm.com>
>
> Writes to the Flush Control registers were logged as invalid
> when they are allowed. Clearing the unsupported want_cache_disable
> feature is supported, so don't log an error in that case.


Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c | 36 ++++++++++++++++++++++++++++++++----
>   1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 3c26cd6b77..c9374f0eee 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1411,7 +1411,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>       /*
>        * ESB cache updates (not modeled)
>        */
> -    /* case VC_ESBC_FLUSH_CTRL: */
> +    case VC_ESBC_FLUSH_CTRL:
> +        if (val & VC_ESBC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>       case VC_ESBC_FLUSH_POLL:
>           xive->vc_regs[VC_ESBC_FLUSH_CTRL >> 3] |= VC_ESBC_FLUSH_CTRL_POLL_VALID;
>           /* ESB update */
> @@ -1427,7 +1434,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>       /*
>        * EAS cache updates (not modeled)
>        */
> -    /* case VC_EASC_FLUSH_CTRL: */
> +    case VC_EASC_FLUSH_CTRL:
> +        if (val & VC_EASC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>       case VC_EASC_FLUSH_POLL:
>           xive->vc_regs[VC_EASC_FLUSH_CTRL >> 3] |= VC_EASC_FLUSH_CTRL_POLL_VALID;
>           /* EAS update */
> @@ -1466,7 +1480,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>           break;
>   
>   
> -    /* case VC_ENDC_FLUSH_CTRL: */
> +    case VC_ENDC_FLUSH_CTRL:
> +        if (val & VC_ENDC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>       case VC_ENDC_FLUSH_POLL:
>           xive->vc_regs[VC_ENDC_FLUSH_CTRL >> 3] |= VC_ENDC_FLUSH_CTRL_POLL_VALID;
>           break;
> @@ -1687,7 +1708,14 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
>           pnv_xive2_nxc_update(xive, watch_engine);
>           break;
>   
> -   /* case PC_NXC_FLUSH_CTRL: */
> +    case PC_NXC_FLUSH_CTRL:
> +        if (val & PC_NXC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>       case PC_NXC_FLUSH_POLL:
>           xive->pc_regs[PC_NXC_FLUSH_CTRL >> 3] |= PC_NXC_FLUSH_CTRL_POLL_VALID;
>           break;

