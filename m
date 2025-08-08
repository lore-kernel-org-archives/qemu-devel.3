Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF9EC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQPm-0003L7-HI; Fri, 08 Aug 2025 12:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ukQPc-0003Jj-Tm; Fri, 08 Aug 2025 12:57:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ukQPb-0008EN-0b; Fri, 08 Aug 2025 12:57:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578EVFiv022100;
 Fri, 8 Aug 2025 16:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=cmltrdRDz0C8zf0bdzt8TeeVBZVdgTVZzvkdbh8v+OY=; b=h4WHatkhvlhC
 ZDRxQlfUWkeCVE/Kr0A5/jFX9OQJqcAsKHIvxItC69ia/+tYn8NfWU1uz3t6e/1f
 hDc9FCps1RWXTtSZ5GJ4dl52E8d1UqBbJxjs1g6ABxWYmxiFCY0WoCqyH0SlqmND
 MrXwGNQQpCPywJD1kLIANEXzMMKgFTXPOBqWlcqNEHejqYMfYMaMQFfz0axYSBEJ
 /Po1t2825L9WUvgGo0oF7sQWSQxxbIsTXaJlMEipNvgir3Dn1aNx0RvCsfm8zzYx
 c2jwov/pHNzUfCjRjd7/PZyzMNfAVgL/oxhIghhteESZIgdjBLc3kYurhoDurr5B
 33H5tMRo1Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dk2n8pya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 16:57:36 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578GrjpV021654;
 Fri, 8 Aug 2025 16:57:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dk2n8py4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 16:57:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578FBZur020626;
 Fri, 8 Aug 2025 16:57:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwn6fq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 16:57:35 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 578GvYXI26084088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Aug 2025 16:57:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10E8C58058;
 Fri,  8 Aug 2025 16:57:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 529D458059;
 Fri,  8 Aug 2025 16:57:33 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Aug 2025 16:57:33 +0000 (GMT)
Message-ID: <7fd16019aa7400e024bf1fcbcd1246cc1dbaea1b.camel@linux.ibm.com>
Subject: Re: [PATCH] ppc/xive2: Fix integer overflow warning in
 xive2_redistribute()
From: Miles Glenn <milesg@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>, clg@kaod.org, npiggin@gmail.com,
 kowal@linux.ibm.com, ganeshgr@linux.ibm.com, harshpb@linux.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Date: Fri, 08 Aug 2025 11:57:32 -0500
In-Reply-To: <20250808100917.37006-1-gautam@linux.ibm.com>
References: <20250808100917.37006-1-gautam@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEzNyBTYWx0ZWRfX+F8Rbl4z0kVT
 2Q77x0E0hiyvKCXVw348gcfMLT8PxCXrHGYBKnGSmpwn7guwveG5fDNfmfWDS2TrN5qT4Sdh/8o
 c7/MbMMwWpeh9lgXET9ZS/pl7q9/2QrSIQhkosuQJGXvTOCgToo2KexG0hyRD2aAbGHcPyASz/0
 nrCoDXvUPeq/53tfX8dRIE1XLpyCqNCPWty7DxviuEy0gprt5TpdAi+Od8RR/zrQapV+0NagJIh
 L2JW9Ql4sh++kZ6T+indyWf8mhl9E8FVCzn9dTGYkcZ6bz0apcA/ySBYEFvWWkAHNLVIAm1i+fv
 6+Om0JpT4OOgNUcCTI/EokfIgFd4y68bET344KtkbTRoL6xt58qJruw24OeZrgAnxzPnJMCE2Xp
 9weDPye5VVZlLr9o+8W7z27LTIK8bd+e5A38YFlis7E6WIUvkPCvlbR91yHRkfeyOu5TCFqr
X-Proofpoint-GUID: NlPHwMULOpKu_b_GHz4uxLkuSHMfoYBZ
X-Proofpoint-ORIG-GUID: 6sowt29E1DIlryE5cdmatTUDtuYtiqzr
X-Authority-Analysis: v=2.4 cv=BNWzrEQG c=1 sm=1 tr=0 ts=68962c81 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=kmnn1oEFiaEaPxf70MkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 mlxscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080137
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 2025-08-08 at 15:39 +0530, Gautam Menghani wrote:
> Coverity reported an integer overflow warning in xive2_redistribute()
> where the code does a left shift operation "0xffffffff << crowd". Fix the
> warning by using a 64 byte integer type. Also refactor the calculation
> into dedicated routines.
> 
> Resolves: Coverity CID 1612608
> Fixes: 555e446019f5 ("ppc/xive2: Support redistribution of group interrupts")
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  hw/intc/xive2.c | 45 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index ee5fa26178..90fe9c883b 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -95,6 +95,35 @@ static void xive2_nvgc_set_backlog(Xive2Nvgc *nvgc, uint8_t priority,
>      }
>  }
>  
> +static inline uint32_t xive2_nvgc_get_idx(uint32_t nvp_idx, uint8_t group)
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
> +static inline uint8_t xive2_nvgc_get_blk(uint8_t nvp_blk, uint8_t crowd)
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

Thanks for fixing that, Gautam!  I was wondering, do we really need the
inline keywords here? Maybe it's better to let the compiler decide if
they should be inlined (which it probably will since they are only
called by a single function in the same file)?

Either way...

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn


