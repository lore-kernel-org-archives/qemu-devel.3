Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2ECC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 12:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uloVv-0002OO-Qc; Tue, 12 Aug 2025 08:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1uloVu-0002O2-8e; Tue, 12 Aug 2025 08:54:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1uloVp-0002z9-RV; Tue, 12 Aug 2025 08:54:00 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C0k2IP021633;
 Tue, 12 Aug 2025 12:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=ScSXcKjWzHlMws+jL+Au2mGzYLU2Cj
 v3cZxwbarztUc=; b=M26Ld5o2rY1SxljX+ffjEukbvIDoziaxfyj0HJYiziCej1
 2TfPwXp/hVUIWvEqdPre2/jIJQWmjDKH9AUZR913TfmjAAPYBHactVu+ehX+CgNy
 2XOMniZGGi2pW8sz/14aHOwhkBokmkDv4UIHoE0ostf7f8cbARm38axoRlUH1ibJ
 LZlzjzroKPWXKYccYPnYZT3zVWzkaPbV6RKEKYeyV4Z3Pi11Go30zjHxD3AeUdHY
 IrI8HX6vpjYY+aIg1nfvS1CJC3D620G6uLVibAW45JgtT+Vbuck5dRttHhYFX4OK
 ixYZysDRX4jdlGPdn5dc4+LiyuDm17dvsKbjIybw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnx8ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Aug 2025 12:53:40 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57CCjfPJ004021;
 Tue, 12 Aug 2025 12:53:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnx8u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Aug 2025 12:53:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57CA155C028629;
 Tue, 12 Aug 2025 12:53:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5n2b1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Aug 2025 12:53:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57CCrZhI52953506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Aug 2025 12:53:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 208D220043;
 Tue, 12 Aug 2025 12:53:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2133520040;
 Tue, 12 Aug 2025 12:53:33 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown
 [9.39.30.216]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 12 Aug 2025 12:53:32 +0000 (GMT)
Date: Tue, 12 Aug 2025 18:23:30 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: milesg@linux.ibm.com, kowal@linux.ibm.com, ganeshgr@linux.ibm.com,
 clg@kaod.org, harshpb@linux.ibm.com, npiggin@gmail.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] ppc/xive2: Fix integer overflow warning in
 xive2_redistribute()
Message-ID: <20250812182040.b4241f71-34-amachhiw@linux.ibm.com>
Mail-Followup-To: Gautam Menghani <gautam@linux.ibm.com>, 
 milesg@linux.ibm.com, kowal@linux.ibm.com, ganeshgr@linux.ibm.com, clg@kaod.org,
 harshpb@linux.ibm.com, npiggin@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20250811074912.162774-1-gautam@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811074912.162774-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEyMyBTYWx0ZWRfX3c5rHh927Jyr
 sTQibm54EOZc7+A2gRX9PZ+90OX3uJf45nrnHXDYMA2BqP5ODtxbQM2Zdl1oIfBNrKRf2Af0Vtg
 aZIKX0FJyq2UsiFqg9nVJaLpImFQxkKOkUh4SrH3ZrzRmVZWZUxXi0crl1kFdQMfDoop/NiaBS3
 CQeFjooc9l332fZ6i3cb1KtPRJljgG5Cs+whv2LXj8CSIgjdqHSFXF3PzsT3AZsUt7mqouDMzRd
 qzS3lxmu21ka/KpX9onSmjAXNyM+2mpQBwkqOV/kSRT2i06QsJp28gn8d76bi8anh9aA/0hYCnT
 dd+7xvHLJnFJBHoLmAqfIWfcXfQbEKzrqYEbfrPvf6SRdUEe+yR7oaOJmFpDSuHbOVahWja2CXl
 na/zVUyqWM3mwWDKXYJczaXQzs34ZmItnrzwNtAZi0C/KuCaa2DiSi+ZJ9b67XLxJOrXmVOX
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689b3954 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=A2g5CHvs1-c_pVe_fnsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: MyLwIQYEQ7kHbDQBWv9k-CP1HaUdLFGu
X-Proofpoint-ORIG-GUID: Dt9FPwoJRGgo_rx15tGtTyx4V_4McjQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=-999 malwarescore=0 clxscore=1011 adultscore=0 mlxscore=100
 spamscore=100 lowpriorityscore=0 priorityscore=1501 classifier=spam
 authscore=0 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120123
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2025/08/11 01:19 PM, Gautam Menghani wrote:
> Coverity reported an integer overflow warning in xive2_redistribute()
> where the code does a left shift operation "0xffffffff << crowd". Fix the
> warning by using a 64 byte integer type. Also refactor the calculation
> into dedicated routines.
> 
> Resolves: Coverity CID 1612608
> Fixes: 555e446019f5 ("ppc/xive2: Support redistribution of group interrupts")
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>

LGTM.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

> ---
> v1 -> v2:
> 1. Remove inline keyword from the function definition (Glenn)
> 
>  hw/intc/xive2.c | 45 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index ee5fa26178..fbb3b7975e 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -95,6 +95,35 @@ static void xive2_nvgc_set_backlog(Xive2Nvgc *nvgc, uint8_t priority,
>      }
>  }
>  
> +static uint32_t xive2_nvgc_get_idx(uint32_t nvp_idx, uint8_t group)
> +{
> +    uint32_t nvgc_idx;
> +
> +    if (group > 0) {
> +        nvgc_idx = (nvp_idx & (0xffffffffULL << group)) |
> +                   ((1 << (group - 1)) - 1);
> +    } else {
> +        nvgc_idx = nvp_idx;
> +    }
> +
> +    return nvgc_idx;
> +}
> +
> +static uint8_t xive2_nvgc_get_blk(uint8_t nvp_blk, uint8_t crowd)
> +{
> +    uint8_t nvgc_blk;
> +
> +    if (crowd > 0) {
> +        crowd = (crowd == 3) ? 4 : crowd;
> +        nvgc_blk = (nvp_blk & (0xffffffffULL << crowd)) |
> +                   ((1 << (crowd - 1)) - 1);
> +    } else {
> +        nvgc_blk = nvp_blk;
> +    }
> +
> +    return nvgc_blk;
> +}
> +
>  uint64_t xive2_presenter_nvgc_backlog_op(XivePresenter *xptr,
>                                           bool crowd,
>                                           uint8_t blk, uint32_t idx,
> @@ -638,20 +667,8 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
>  
>      trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
>      /* convert crowd/group to blk/idx */
> -    if (group > 0) {
> -        nvgc_idx = (nvp_idx & (0xffffffff << group)) |
> -                   ((1 << (group - 1)) - 1);
> -    } else {
> -        nvgc_idx = nvp_idx;
> -    }
> -
> -    if (crowd > 0) {
> -        crowd = (crowd == 3) ? 4 : crowd;
> -        nvgc_blk = (nvp_blk & (0xffffffff << crowd)) |
> -                   ((1 << (crowd - 1)) - 1);
> -    } else {
> -        nvgc_blk = nvp_blk;
> -    }
> +    nvgc_idx = xive2_nvgc_get_idx(nvp_idx, group);
> +    nvgc_blk = xive2_nvgc_get_blk(nvp_blk, crowd);
>  
>      /* Use blk/idx to retrieve the NVGC */
>      if (xive2_router_get_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, &nvgc)) {
> -- 
> 2.50.1
> 
> 

