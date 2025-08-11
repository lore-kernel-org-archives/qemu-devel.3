Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16E5C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 07:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulMwS-0004g2-Bn; Mon, 11 Aug 2025 03:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1ulMwI-0004e7-Ei; Mon, 11 Aug 2025 03:27:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1ulMwB-0006vs-Px; Mon, 11 Aug 2025 03:27:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B4e1vj028345;
 Mon, 11 Aug 2025 07:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=5cZc3REWPGP0iRPWggtcj0VzxwJWZe
 RahKfWKtHLNqs=; b=osXNST4zt7aUB0AVuYVoKB0dRu8hGf2/e1o+1MDvmKHzdj
 VBhvlRondRy2qc68NWWf4VCTsgY3Wf8X8tBb09RLp4U5XOJLn5mMRygc9g9znWx1
 2Vz/xb9Qsq5F5ykQuqUu+85ttdMfNSv/NREtEBjvTnuq6vNI8UUq2gFN26fMzGbz
 uhTwuYxtRPQi3f8CVmpJdx68RdKbDbO1jmLVT4Zqi0vjhek2RSWJrQmcweZXh6BE
 Y+e53kMBN4aHZMjDXVGwoyGEsy94qdcwdGqJFoh+lHSAIrOrZINy4qvbO/5da6fv
 saF7SkGvcwGdBxM4EK1edS8XAHZPEQRdU8diKfGw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnqx4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Aug 2025 07:27:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57B7R6RA001665;
 Mon, 11 Aug 2025 07:27:06 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnqx4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Aug 2025 07:27:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57B77a7c017600;
 Mon, 11 Aug 2025 07:27:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3cgk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Aug 2025 07:27:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57B7R1fw23069100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 07:27:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70A4020049;
 Mon, 11 Aug 2025 07:27:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4839020040;
 Mon, 11 Aug 2025 07:26:59 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown
 [9.39.30.61]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 11 Aug 2025 07:26:59 +0000 (GMT)
Date: Mon, 11 Aug 2025 12:56:53 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Miles Glenn <milesg@linux.ibm.com>
Cc: clg@kaod.org, npiggin@gmail.com, kowal@linux.ibm.com,
 ganeshgr@linux.ibm.com, harshpb@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] ppc/xive2: Fix integer overflow warning in
 xive2_redistribute()
Message-ID: <aJmbPW40BsrmU9Oe@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>
References: <20250808100917.37006-1-gautam@linux.ibm.com>
 <7fd16019aa7400e024bf1fcbcd1246cc1dbaea1b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd16019aa7400e024bf1fcbcd1246cc1dbaea1b.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA0OCBTYWx0ZWRfX8yiZ2AW7pN/1
 IMr+0XgBD6w2NOIWQS78lSb5IQOuCBEMhr/enCgIVJh8WIJ6ya9CprgmWoY8jOzQKcLlnYV9p1T
 FKTCTg4gLzQmUL4EzYtb+6tdwkbGSfzLpVbHqUozRb5u3bTVqkEHqv3MVFcZ91e28dvuVEhlS+6
 qOS3xAokF9dVRk9y9vhY3RdFD6ygyit4CuIVreiJ1a/uKVOVbDT9BhSDV7fviNTSNbYnT+6ZKff
 6cHlUGjKVLmxp2bb+eOqLWnJnkk/bg2TBvif5kXbZTK/WNP1Yqkn5eLiWF99uLslFGaKQTk1Gaf
 NodVzpsYGCDi1Hjd+WDJ2O9oOfVKT0OMdONJ4Q+cech0T11M77WFr8A3733vTFvIa6PeLIcVxYO
 OnNVu683xBqzUoM6AVFpyMOd9dj1q39BxOxv5qK4L7Aytn7PTvdq7zF0k5iyZxqyeU19LTfw
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=68999b4a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=w3VyHKy07UdvmkvWQnMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: s6kGlO3n-EUQnbxqRmTaKT3yKoAIWJ52
X-Proofpoint-ORIG-GUID: m1j0WM5zKA_RL9OUJqLohMBfMVEoa-ma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Aug 08, 2025 at 11:57:32AM -0500, Miles Glenn wrote:
> On Fri, 2025-08-08 at 15:39 +0530, Gautam Menghani wrote:
> > Coverity reported an integer overflow warning in xive2_redistribute()
> > where the code does a left shift operation "0xffffffff << crowd". Fix the
> > warning by using a 64 byte integer type. Also refactor the calculation
> > into dedicated routines.
> > 
> > Resolves: Coverity CID 1612608
> > Fixes: 555e446019f5 ("ppc/xive2: Support redistribution of group interrupts")
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> >  hw/intc/xive2.c | 45 +++++++++++++++++++++++++++++++--------------
> >  1 file changed, 31 insertions(+), 14 deletions(-)
> > 
> > diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> > index ee5fa26178..90fe9c883b 100644
> > --- a/hw/intc/xive2.c
> > +++ b/hw/intc/xive2.c
> > @@ -95,6 +95,35 @@ static void xive2_nvgc_set_backlog(Xive2Nvgc *nvgc, uint8_t priority,
> >      }
> >  }
> >  
> > +static inline uint32_t xive2_nvgc_get_idx(uint32_t nvp_idx, uint8_t group)
> > +{
> > +    uint32_t nvgc_idx;
> > +
> > +    if (group > 0) {
> > +        nvgc_idx = (nvp_idx & (0xffffffffULL << group)) |
> > +                   ((1 << (group - 1)) - 1);
> > +    } else {
> > +        nvgc_idx = nvp_idx;
> > +    }
> > +
> > +    return nvgc_idx;
> > +}
> > +
> > +static inline uint8_t xive2_nvgc_get_blk(uint8_t nvp_blk, uint8_t crowd)
> > +{
> > +    uint8_t nvgc_blk;
> > +
> > +    if (crowd > 0) {
> > +        crowd = (crowd == 3) ? 4 : crowd;
> > +        nvgc_blk = (nvp_blk & (0xffffffffULL << crowd)) |
> > +                   ((1 << (crowd - 1)) - 1);
> > +    } else {
> > +        nvgc_blk = nvp_blk;
> > +    }
> > +
> > +    return nvgc_blk;
> > +}
> > +
> >  uint64_t xive2_presenter_nvgc_backlog_op(XivePresenter *xptr,
> >                                           bool crowd,
> >                                           uint8_t blk, uint32_t idx,
> > @@ -638,20 +667,8 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
> >  
> >      trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
> >      /* convert crowd/group to blk/idx */
> > -    if (group > 0) {
> > -        nvgc_idx = (nvp_idx & (0xffffffff << group)) |
> > -                   ((1 << (group - 1)) - 1);
> > -    } else {
> > -        nvgc_idx = nvp_idx;
> > -    }
> > -
> > -    if (crowd > 0) {
> > -        crowd = (crowd == 3) ? 4 : crowd;
> > -        nvgc_blk = (nvp_blk & (0xffffffff << crowd)) |
> > -                   ((1 << (crowd - 1)) - 1);
> > -    } else {
> > -        nvgc_blk = nvp_blk;
> > -    }
> > +    nvgc_idx = xive2_nvgc_get_idx(nvp_idx, group);
> > +    nvgc_blk = xive2_nvgc_get_blk(nvp_blk, crowd);
> >  
> >      /* Use blk/idx to retrieve the NVGC */
> >      if (xive2_router_get_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, &nvgc)) {
> 
> Thanks for fixing that, Gautam!  I was wondering, do we really need the
> inline keywords here? Maybe it's better to let the compiler decide if
> they should be inlined (which it probably will since they are only
> called by a single function in the same file)?
> 


Sure, thanks for the feedback and RB. I'll send a v2.

> Either way...
> 
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> 
> Thanks,
> 
> Glenn
> 


Thanks,
Gautam

