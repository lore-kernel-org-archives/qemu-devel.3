Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBF9CCF2D9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 10:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhmPd-0004pW-Cs; Mon, 19 Jan 2026 05:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vhmPa-0004nT-1l; Mon, 19 Jan 2026 05:23:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vhmPY-0008Ko-JN; Mon, 19 Jan 2026 05:23:05 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60IJ10X7022744;
 Mon, 19 Jan 2026 10:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=UXwhZfIegBGpY7cfmPVYIrTUgzcnwe
 FZMCjdep6ADG8=; b=mDvdnAqZ55LI9VyAMTrJLmI5wnfG28dF+0LmByg0AKV+/2
 1sb+HU0WOGMzKKmM+pTi5FaJaHh258TkBTtUQFEeFPwyafA+hEcuCTwFosLEaz8E
 QIenMNHpP/ed9M+rk13VDDeNWSZnBnBacwSdvC2V+2+8B8LhO5ZnbonCIbLdAwgT
 RcPCO6dt8omzJiG6BF+WKA2wwY98iFhal9LXOwLRs1l885yT9fL0It2D8uE+FeTd
 4im/8lJoCE1m7fCb7T/U56qlXojvkFHjY8r1/H6whyBAlOM5V8inqwvb88pg10Nt
 4e+VAa75RaFYNJ7jjOH6xGLqLOROO3Yy6/4qS2Ag==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyujyabu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 10:23:03 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JAN2pi007481;
 Mon, 19 Jan 2026 10:23:02 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyujyabr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 10:23:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60J7mUcb001404;
 Mon, 19 Jan 2026 10:23:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyjdwgy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 10:23:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60JAMv1W59113864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jan 2026 10:22:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D213F20043;
 Mon, 19 Jan 2026 10:22:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59B5B20040;
 Mon, 19 Jan 2026 10:22:56 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.21.137]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 19 Jan 2026 10:22:56 +0000 (GMT)
Date: Mon, 19 Jan 2026 15:52:54 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com
Subject: Re: [PATCH 2/4] ppc/pnv: Support for SECURITY_SWITCH XSCOM register
 access
Message-ID: <aW4FseV-i3Nv18Sx@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-3-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218200353.301866-3-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA4NCBTYWx0ZWRfX+5cXYGbRVXKT
 m66JLCBCADcUyey6NHnUzrLCu1IukE0TNMV97h+tufVrzdZ7Hj/I/eq44YgtCqbfQAo/iiMJ4a4
 gq6n3/iGtwikeY7wvJJK0Ht9CEUSRQq0pxu0HQ13buJT3ShCeEjFzoJFuL94FOhkxjBCnKWl0qP
 obBOVUtgoLl7YA1/oqf2g5VOQUY3e3EDHiw19UW/zIO/8VCPFb6kY03BfTdEnLFp5sTKDJcZsym
 juzvf9A0XIUydLmvkR5Loy5LbCaKd+TvU/9WmH18n66nUx9eeiN09USXUm/o038dc38hvINTcvT
 QRKPGwseTCO1tNglnh0UCf1P2Vw/Icx7obgnUdNxVkLkUO5Nhe6eEb2FoKLEwoydBSEO67bCOjF
 LlMbyMxTSkh2juRJaF03+QszVIhJRoeeALjDAmlxvBmc2tE2suUN2PBAPhwhrrjeuirGMCW6Ho3
 zgj4JIDpQvNPwZCaUvg==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=696e0607 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=TRwDyEk3oLEpmU-Z7y4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Er9K5mbwCa3PvjSFZh3o89bI7YfveEXo
X-Proofpoint-GUID: 6TFyJfAJ-Qjc2wHBLYJUjk2wOGG3neQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/12/18 02:03PM, Caleb Schlossin wrote:
> Power Hypervisor code requires access to the SECURITY_SWITCH
> XSCOM register at MMIO address 0x80028 (scom address 0x10005).
> Adding basic read support for now so that is doesn't cause
> error messages to be posted.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_xscom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index fbfec829d5..308430def7 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -61,6 +61,8 @@ static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
>  static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
>  {
>      switch (pcba) {
> +    case 0x10005:       /* SECURITY SWITCH */
> +        return 0;

Looks okay to me, and returning 0 here makes sense.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G

>      case 0xf000f:
>          return PNV_CHIP_GET_CLASS(chip)->chip_cfam_id;
>      case 0x18002:       /* ECID2 */
> -- 
> 2.47.3
> 

