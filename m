Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD336C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDlC-0004Oc-Oe; Wed, 14 May 2025 11:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDEx-0002dD-1G; Wed, 14 May 2025 10:37:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDEu-0007X7-Co; Wed, 14 May 2025 10:37:46 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDn4fV003571;
 Wed, 14 May 2025 14:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LvlrJN
 zFUtTJYVeCKxbt6thPVNKqX8a05rZumg6GwiU=; b=fFOq5HO9qTuVgJDLgABZX0
 aCsIcbJeekZXwDTfofTXl7LYbFmWKRGTQ8MEAARQprdc1QDdXw4cUAALa1kh/1Jo
 WZraks0PHht0/3N9bGlBfoTb49YedG454Evg5woL3rjAvFPAkN1gY/8/p+KgC2hX
 YKltO0eN7mFBNFCcbFdaNgaH7SdhCiFNxUvkmGctlAq9UdChEb2N1WX7CihLB2LR
 hrY/zUxmEOcwFmn/vCkxNVphBLV6D8rl1kCeUp0X0z125IScjFBSCWgS4b719hvc
 2grl489fXMtbksyH0YwZk41HGzIu7OmX+UfZ95dTX6/B6VleNisJFQgOPtiKgVsg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd3894u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:37:42 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEWoaU012072;
 Wed, 14 May 2025 14:37:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd3894r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:37:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDc8sU021809;
 Wed, 14 May 2025 14:37:41 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpmpta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:37:41 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEbeFa52822328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:37:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C0E358056;
 Wed, 14 May 2025 14:37:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBBB458052;
 Wed, 14 May 2025 14:37:39 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:37:39 +0000 (GMT)
Message-ID: <38a9bbb0-92ed-4877-912f-725bb28f6dd0@linux.ibm.com>
Date: Wed, 14 May 2025 09:37:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/50] pnv/xive2: Permit valid writes to VC/PC Flush
 Control registers
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-21-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-21-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6Kj-V04g6_MlQWKnl3sKbyK5u50A2wZj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEzMCBTYWx0ZWRfX+vt9qiJqbr4g
 AQWGPfcnil65E+FpvOIBda8Ach+Zs4I2zI95LXs4W9keUlkDl4OoPx52UHjVSlAi/EwC7VirAMj
 V4hrFcSaVb3JzlCVu3bpOcjX5V591EgAw7iuWAJhGSAC1+osWE2dnKZG1/pNL2UXyrNKaME0goi
 SyCK+9MMCSSd8Z1WI581nZPwryeSFdzCTNqu4t4VAMBgHZiEgpysOYEd0mN/wrqZu5Nol54wg5E
 TSZqYv2DzIgy29qOqIcH6dscP4KmgcGmToApcWIlVn0sMZTXZiQ5dfcZQC0bxuWWirO6iIW8geH
 8DpHLtJp9n7ZpyTcU7tqYg2WWGEwzrRmYQLWQqdBBf9KJWHugy1IFZe74ZqocDHpiabeDnT9/+P
 /N+KV0H1ePV+pt372OyfsZwA4xr+31SjatkdIrCpi2Nshs+0pLY5taWFNtreX3j++tVpPiSx
X-Proofpoint-ORIG-GUID: ff96PEEswlnmcFCKmSiDqTi4vqbIxJ3a
X-Authority-Analysis: v=2.4 cv=GbEXnRXL c=1 sm=1 tr=0 ts=6824aab6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=K43VmlK4zf_02HQK-ZgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=770 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140130
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 May 2025 11:10:39 -0400
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


Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 5/11/25 10:10 PM, Nicholas Piggin wrote:
> From: Michael Kowal <kowal@linux.ibm.com>
> 
> Writes to the Flush Control registers were logged as invalid
> when they are allowed. Clearing the unsupported want_cache_disable
> feature is supported, so don't log an error in that case.
> 
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 3c26cd6b77..c9374f0eee 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1411,7 +1411,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>      /*
>       * ESB cache updates (not modeled)
>       */
> -    /* case VC_ESBC_FLUSH_CTRL: */
> +    case VC_ESBC_FLUSH_CTRL:
> +        if (val & VC_ESBC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>      case VC_ESBC_FLUSH_POLL:
>          xive->vc_regs[VC_ESBC_FLUSH_CTRL >> 3] |= VC_ESBC_FLUSH_CTRL_POLL_VALID;
>          /* ESB update */
> @@ -1427,7 +1434,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>      /*
>       * EAS cache updates (not modeled)
>       */
> -    /* case VC_EASC_FLUSH_CTRL: */
> +    case VC_EASC_FLUSH_CTRL:
> +        if (val & VC_EASC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>      case VC_EASC_FLUSH_POLL:
>          xive->vc_regs[VC_EASC_FLUSH_CTRL >> 3] |= VC_EASC_FLUSH_CTRL_POLL_VALID;
>          /* EAS update */
> @@ -1466,7 +1480,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>          break;
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
>      case VC_ENDC_FLUSH_POLL:
>          xive->vc_regs[VC_ENDC_FLUSH_CTRL >> 3] |= VC_ENDC_FLUSH_CTRL_POLL_VALID;
>          break;
> @@ -1687,7 +1708,14 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
>          pnv_xive2_nxc_update(xive, watch_engine);
>          break;
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
>      case PC_NXC_FLUSH_POLL:
>          xive->pc_regs[PC_NXC_FLUSH_CTRL >> 3] |= PC_NXC_FLUSH_CTRL_POLL_VALID;
>          break;


