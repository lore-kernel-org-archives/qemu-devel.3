Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3049C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFabk-0003hN-VO; Thu, 15 May 2025 11:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFabf-0003fr-6o; Thu, 15 May 2025 11:34:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFabY-0004mN-7w; Thu, 15 May 2025 11:34:45 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgAWK004678;
 Thu, 15 May 2025 15:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Q5fLeUg4etjdDQMELD7kAMIW9veuP+/bw6LHav8eWwQ=; b=FoJpN96AxBOf
 JgG5uBBf54F4t8sXIhXPs+LnnpRuuDVNMK2p9Qn60bPB871vn9Q72l80velDA3Rz
 PDILG2fNiQF+Mda6PAWft1rBvyf7qSHrHOOTDFTfmNjdvrIYXNhmuU3M/vLeof0Z
 OZx99aYzTukplWciwlDQKSBl5YMWt4UcClMXwUo7dN+NTRrVu7Z5OSsCiu0czdka
 mKFdGFWITSeSnQ2RV06jIijrJ8s+wSXdLMlWictjG9IHUiUd+UH1aIMXB0HqPwAB
 XwopahGN7vmQxURgSwkXDaEDMzS5XgOyyHAQ8xm002DKiHVbQyazVstI3NdwC+Cy
 dgRjpHDLOw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt0mm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:34:36 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFYZ53030966;
 Thu, 15 May 2025 15:34:35 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt0mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:34:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE7alx026947;
 Thu, 15 May 2025 15:34:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpjydd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:34:35 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFYXHb31261226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:34:33 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B8F45803F;
 Thu, 15 May 2025 15:34:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8F3358054;
 Thu, 15 May 2025 15:34:32 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:34:32 +0000 (GMT)
Message-ID: <197e590c8f77c8c1f0f47a19ca2ef322b0784fdf.camel@linux.ibm.com>
Subject: Re: [PATCH 04/50] ppc/xive2: Remote VSDs need to match on
 forwarding address
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:34:32 -0500
In-Reply-To: <20250512031100.439842-5-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-5-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Mq6o6O3yuacXPcsgX7SkZW8-JOXitD2f
X-Authority-Analysis: v=2.4 cv=ecg9f6EH c=1 sm=1 tr=0 ts=6826098c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=BZqlLmCw9VANlYX6ozUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4ZMxFHtmBiUUgrWNhw1H1V9wsHKXBfYM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1MCBTYWx0ZWRfX0cL08sDYnqPA
 iOf5BZy+sqU2g1fmRVA14lA0BGOtun91QcygGdhS3Z0Co2uv0mPtiVIjJdoQKTS/W9GhOt5eMe3
 f597W9codbNKBAZ3IJpLLtq7CvPDv5iNfU2+EMr0M9j71CRyXeNmSDvNM+vtKSXbjEcpY3guvVW
 kl1FI+z6/mc6PQaIMRbNup7rwyveyOdF9UgvxyK/FQ9vkXTl88vRkQrr8IfLe0jxYb6Vk9i+bTY
 dz6I9Rjus0IZ0Vmx/y6RMit/LPLLgZvGN84JaBov9ISEpFZEv+em/zcGQBUvZi6b5JzdasPhlzr
 aZHR4pbJcddWwe9PX+SOtTZx+9eePwh8mPcJ0hbnaSOhqx5PaZ0a45zFoGtcNC7T+gCEoJ+3k/X
 G2+NyxGEdgmnSUP4QmXHW28OOAWzKXsGLV/o+YUV3e3UataRe1JTAxVHV5Sn2XUID3Kt0UQG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
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


