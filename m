Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46538C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDkx-0004Dj-21; Wed, 14 May 2025 11:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD5Z-00061M-AB; Wed, 14 May 2025 10:28:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD5W-0005wR-LB; Wed, 14 May 2025 10:28:04 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E6IOsQ026355;
 Wed, 14 May 2025 14:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QNIGt/
 q7AXwK684f8mx8PklyKsJ8rTRTBqL4JvKowXU=; b=fz8RnedYoL9lq28Myg+iaS
 bVK+EHQRGGfGTctsjBeOTJnUTWXF7/2eoAHdN72VNSXlBwDiDap1Tbx63ZQKWYDr
 w9dIqvP6E7ZQTdlVNqC4H4O46rO/hyzebPxFwMF7UZrjPe6v8AQAEjwFp1PJnr9m
 nsT89XN+T7zQ1OABuvLnNqxbyhoY6tgGAiCHVQ/YSBrOAho2tTFs9WG4HxwnUiTU
 yJbziPTDnkgQemu3uVifxhAMRle2nKyEW1zLoYbZUFAVC+vHBHLQM2gCXnFTIL0N
 I28yW/piwyExucQmJ+Ehq3RP9rqytZ7stgnpMMDXpWlB9D4jiSBGjXbF53rNBx5A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst2aeu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:28:00 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EES0S7009496;
 Wed, 14 May 2025 14:28:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst2aer-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:28:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDQOA2015330;
 Wed, 14 May 2025 14:27:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpvn3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:27:59 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EERwGK26936060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:27:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9081858056;
 Wed, 14 May 2025 14:27:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32D8458064;
 Wed, 14 May 2025 14:27:58 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:27:58 +0000 (GMT)
Message-ID: <d0a04b6e-b0bd-402a-ab78-b65891d74345@linux.ibm.com>
Date: Wed, 14 May 2025 09:27:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/50] ppc/xive2: Remote VSDs need to match on forwarding
 address
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-5-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LdTbjziFEuY9KVc1MQQbYshd-3nxIpb1
X-Authority-Analysis: v=2.4 cv=V+590fni c=1 sm=1 tr=0 ts=6824a870 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=BZqlLmCw9VANlYX6ozUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Nez9hNHtjUEibgNKYAXOpKOFxYUVWIpW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyNSBTYWx0ZWRfX0oZAZOz7dUmp
 RsPClis/7VCXqDPeHgymXeVXUK+JPEAiRf8A3C3UqpG+xDEn29+QTq6ApvrM/A5SpFq7dg4iF4a
 SQCIRaYyMkye5C2he7UspwMdvkQcGiG8/lQ8KIqrs9lNLkJIJB+BgreDfjRhugN6vCI7f/ogn6m
 d+t+bdvWX4aiQLIyZBB8aJQ+CZKbSudRzKm7yvizXYmbm1eO2u/kDF5CMh/3GEWHj5dy2EewDHo
 p+yetCRC5wGdCXbecfFiy1RsijlxAxwxC8wMY3OtUi4dsL9PxfbroflF2BsPmhguzyDfa3u9mhN
 xNf7AygnfJ2wZQku0DjbUDxSOwPfq2lHp6A+1ZPUdA7dh6UVCI3giVJZLvViLSv9CXCF+VvuChN
 le6gjClFMnXJV1afccaGQS8sb9mvzkzSCtbpGHFW8eqKsvMig3bbj0zhfRxpsHCWrYwaYb1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
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
X-Mailman-Approved-At: Wed, 14 May 2025 11:10:33 -0400
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

Looks good.

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 5/11/25 10:10 PM, Nicholas Piggin wrote:
> From: Michael Kowal <kowal@linux.ibm.com>
> 
> In a multi chip environment there will be remote/forwarded VSDs.  The check
> to find a matching INT controller (XIVE) of the remote block number was
> checking the INTs chip number.  Block numbers are not tied to a chip number.
> The matching remote INT is the one that matches the forwarded VSD address
> with VSD types associated MMIO BAR.
> 
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index d1713b406c..30b4ab2efe 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -102,12 +102,10 @@ static uint32_t pnv_xive2_block_id(PnvXive2 *xive)
>  }
> 
>  /*
> - * Remote access to controllers. HW uses MMIOs. For now, a simple scan
> - * of the chips is good enough.
> - *
> - * TODO: Block scope support
> + * Remote access to INT controllers. HW uses MMIOs(?). For now, a simple
> + * scan of all the chips INT controller is good enough.
>   */
> -static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
> +static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
>  {
>      PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>      int i;
> @@ -116,10 +114,22 @@ static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
>          Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
>          PnvXive2 *xive = &chip10->xive;
> 
> -        if (pnv_xive2_block_id(xive) == blk) {
> +        /*
> +         * Is this the XIVE matching the forwarded VSD address is for this
> +         * VSD type
> +         */
> +        if ((vsd_type == VST_ESB   && fwd_addr == xive->esb_base) ||
> +            (vsd_type == VST_END   && fwd_addr == xive->end_base)  ||
> +            ((vsd_type == VST_NVP ||
> +              vsd_type == VST_NVG) && fwd_addr == xive->nvpg_base) ||
> +            (vsd_type == VST_NVC   && fwd_addr == xive->nvc_base)) {
>              return xive;
>          }
>      }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                 "XIVE: >>>>> pnv_xive2_get_remote() vsd_type %u  fwd_addr 0x%lX NOT FOUND\n",
> +                 vsd_type, fwd_addr);
>      return NULL;
>  }
> 
> @@ -252,8 +262,7 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
> 
>      /* Remote VST access */
>      if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {
> -        xive = pnv_xive2_get_remote(blk);
> -
> +        xive = pnv_xive2_get_remote(type, (vsd & VSD_ADDRESS_MASK));
>          return xive ? pnv_xive2_vst_addr(xive, type, blk, idx) : 0;
>      }
> 


