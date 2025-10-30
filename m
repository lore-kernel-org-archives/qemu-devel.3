Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1A5CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEU9g-0005nz-O8; Thu, 30 Oct 2025 11:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vEU8s-0005m3-J4
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:00:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vEU8m-0003vs-Rw
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:00:46 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UCDaQD005051;
 Thu, 30 Oct 2025 15:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=tFWdGCpsSTEw3qXYK5MXAzczXxxXI9
 zYfHgKAJq5mtg=; b=PL/DHAx/+tHr7R6KxePvEQyQRWH/NlJjtu/RqEXWyPpaiu
 3qlCq9dOODixEgE9M5mQTn1ZCx7izrVLOK+MzjUnwtwCqxKcvwHi1/F6fFyfGYNR
 iPDDtpAjN2wQ7aLSThjk4QRhqmAWwdDQONxBZsH7sxUZWeZM1zACATJ/lCIRN95V
 QozoGssTBFhepmNOhzT1csjwHh5OTRaZheXNV3Ht4sOvU/pd2cCGh9V9IwUaYM7o
 P8Gl96cagCzavLnQNgQbcdRnMYg1GF0ZBOXD93V94tsIXAV0QUtAN+dA3K1s0OBe
 kUduazpTQuvtL+Rji+Uu9D8uiSMGCwJd5XH4hX+Q==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8s3ph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 15:00:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDcwxr019510;
 Thu, 30 Oct 2025 15:00:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xy99s3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 15:00:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59UF0IGU26935588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 15:00:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 711CC2004B;
 Thu, 30 Oct 2025 15:00:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CB3720040;
 Thu, 30 Oct 2025 15:00:16 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.29.84])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 30 Oct 2025 15:00:15 +0000 (GMT)
Date: Thu, 30 Oct 2025 20:30:09 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Aditya Gupta <adityag@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, sourabhjain@linux.ibm.com
Subject: Re: [PATCH v2 1/2] hw/ppc: Fix missing return on allocation failure
Message-ID: <43z3ggtik6cmtjiyve62bldmhhl5tfgeqtbij6ycc3oq5aw6xl@sfcv4oilaplo>
References: <20251028080551.92722-1-shivangu@linux.ibm.com>
 <20251028080551.92722-2-shivangu@linux.ibm.com>
 <8d5a8cce-d769-4cd8-9753-7e9ad37d8a47@linaro.org>
 <dio77m3m5jj6ccgqpswkifiqztf5fz45qsjpspu2yszgwrfgha@mcwjruxszkn5>
 <47ac6382-3270-4179-8455-43cee36a9ca9@linux.ibm.com>
 <c089e14f-69a3-fe9c-cc80-b0c7bba4105a@eik.bme.hu>
 <fz5bixswyqecp2tgbobkz2vlncuhdm4cxagdndn77qpprltssl@opqtjw4ixgpk>
 <CAFEAcA8gZ5MEJvabd__asKLEA_+jf4=SPKaAy952pr6S0oJnqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8gZ5MEJvabd__asKLEA_+jf4=SPKaAy952pr6S0oJnqA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DYkaa/tW c=1 sm=1 tr=0 ts=69037d87 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Gu6rTDTfY5oMl6SCCRoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 5S6qOtW0bGWU-BMK7Q-YXr9gqP1NGXFh
X-Proofpoint-ORIG-GUID: 5S6qOtW0bGWU-BMK7Q-YXr9gqP1NGXFh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX4W8Vb6lby36O
 eVshJum00KbkWYuh5TS/UOi3BwRWlodSZy4ac4Jm8HmD96YICl4N405ZFhZu1T3ZLQCoFLIVQx9
 eewCr/CqVRPm/z5TCCY7jlzu/4ZDXX4bRMsf50A6na20N9YcjpAY3tdHnfjU6PIuv8aB16qGQtJ
 RIvBns8uYuMqTxxxE4biE9Gkn/Oopa+X9qXuIa/JBKM529XU/gowmArtZZCaiRRlt+hXiZvTc6O
 BT0qN+d+CEjjtPj2GPChG+KBu479AjE8PkA4HBvfLdjSLHDLYHcHQT1JTGND0kNoR5/uX85nepT
 CZPoSRzBaIz4nzcUiP8QDK1xK1iNIDoIf8rYXJpLU0YDuXH3EFD0kvuLqBm0ICpJgr0YCa4mlr1
 1fvcqEIPyUSU2C8xaVOBjHZ177m2MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Thu, Oct 30, 2025 at 02:45:07PM +0000, Peter Maydell wrote:
> docs/devel/style.rst has some notes on malloc choices, including this:
> 
> # Care should be taken to avoid introducing places where the guest could
> # trigger an exit by causing a large allocation. For small allocations,
> # of the order of 4k, a failure to allocate is likely indicative of an
> # overloaded host and allowing ``g_malloc`` to ``exit`` is a reasonable
> # approach. However for larger allocations where we could realistically
> # fall-back to a smaller one if need be we should use functions like
> # ``g_try_new`` and check the result. For example this is valid approach
> # for a time/space trade-off like ``tlb_mmu_resize_locked`` in the
> # SoftMMU TLB code.
Hi Peter,

Thanks for clearing it up.
> 
> Since we're trying to allocate 32MB at once and this is during
> the guest run rather than at startup, this is probably a reasonable
> place to use g_try_malloc().
> 
> There are other places in this code that use LOG_GUEST_ERROR
> for things that aren't exactly guest errors, so my suggestion
> is that we take this patch as-is to fix the logic error.
> We can consider whether we want to try to improve the error
> reporting of this group of functions as a separate patch.
Sure.

~Shivang.

