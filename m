Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1766C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAMq-0001rF-PO; Mon, 29 Jun 2026 07:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1weAMo-0001qb-K3; Mon, 29 Jun 2026 07:41:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1weAMn-00035u-1v; Mon, 29 Jun 2026 07:41:34 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAmIDB3030303; Mon, 29 Jun 2026 11:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Z6A71ZNPufFKJkYCMHlGBC6TRnZ0hX
 XY+t7h3Bnbjtk=; b=I+rkKhd6Sja/z1Skhpdgs7RtY31VsHHayv5iHfZ3FpXPeA
 RGmNyogiF/eZLMsY1GKkUdnkIqz78c9wUi3swr+cFaqTFR4jXFxcm7czo8yxM8q/
 rDpxtsSKqWWjupblS6hz8UmGGOCu8zZHYcq7LbBPvXVgTcUp4V3Xvw81vYoNY6u6
 JT0qZhKOTX3bdbqo2TBFOfAxwLenevm5H0nvk+2dSUA9UePEHKRp4zU0XtSYPO4c
 9BD9t+QfUMiMOqmtdhZ3oiYLishPCufty1DWT2wNi47/C3EWzwkLZEpchZPfUC1Y
 qn3F063Vkwubv+bDno6l4pE+qlp66kuIJpSw4XKA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pds2jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:41:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TB4fmx001013;
 Mon, 29 Jun 2026 11:41:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7vwafb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:41:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65TBfOlM47317368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jun 2026 11:41:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 983F820043;
 Mon, 29 Jun 2026 11:41:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C96C82004B;
 Mon, 29 Jun 2026 11:41:22 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.123.10.203])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jun 2026 11:41:22 +0000 (GMT)
Date: Mon, 29 Jun 2026 17:11:20 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 1/2] ppc/pnv: avoid regenerating DTB if external DTB
 is present
Message-ID: <akJSWs7btybHFuMa@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
 <20260626112239.177191-1-shivangu@linux.ibm.com>
 <20260626112239.177191-2-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626112239.177191-2-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: nA2VnuRQnhG6tuorBUt4aTIEVg5LhBOD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5MiBTYWx0ZWRfX9zV5MkcfGDct
 roh4IPeumuzJ9W3xk3N4vUrQuyB4pmBfrU9rqdMVcXTPGXAyyq5/Rp12pKZpOBAUg90XsZAkLhn
 hzCX0jTI+TtmNzYBvWDQ8XCknGzHJOo=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a4259ea cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Bu0ecm2RSgxt74y_FWUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5MiBTYWx0ZWRfX2Np5YrfCb1Jo
 U/P/73MkEtL9B7rpdYsv+rAJIYvMTBApSNuRoPQhyP+9Jl6jxY0jGFaWkoaooInsPck9ppQEOSe
 85wtsLCz5jkTPim3m3kkqPt1fS2IGysgEEnjXYK4bHNpsIAhif9bF0ZXdQ9fC1HJYI3DzuAmEj0
 ch561oSj7Ipw65n3KfBhi4YwdL5nETSy6D9zPAaJX5T0GgQyBqET8RjENcZXgCS/IGHYeIFWIpl
 mWV91NNQfRh8uI/cFpDqv03n0p+cYGyo6sdOzC4sYpsaOYUMxpRE8Ins4Ztk6yL8HPHnMXB3jWX
 TervKRoRsWWOQpmT/H9NrW7oc13MWe8+Gu4LEurgpSSY/hKOFKbNETO+w7XojFNbRFtSYVvFWgJ
 TYtCPvkgQnw5Wu8KenZ6q2zdRJassEbFCnu3kPiEIjAv6brbreiVijOO5rq7SzCanBBN6eUsU5S
 wGxj/RnUENFHshAvFjA==
X-Proofpoint-ORIG-GUID: fdLoAI-qOatew41yv4vme_VR535kA7ET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290092
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/06/26 04:52PM, Shivang Upadhyay wrote:
> Currently externally provided dtb is overwritten in `pnv_reset`.
> Fix this by only creating dtb if not provided from `-dtb`.
> 
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>  hw/ppc/pnv.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 62812f22f8..e44fb7e2dc 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -803,9 +803,13 @@ static void pnv_reset(MachineState *machine, ResetType type)
>          mpipl_write_succeeded = do_mpipl_write(pnv);
>      }
>  
> -    /* Regenerate device tree */
> -    fdt = pnv_dt_create(machine);
> -    _FDT((fdt_pack(fdt)));
> +    /* Only create new dt if not provided in -dtb */
> +	if (!machine->dtb) {
> +		fdt = pnv_dt_create(machine);
> +        _FDT((fdt_pack(fdt)));
> +	} else {
> +	    fdt = machine->fdt;
> +	}

nit: indent is wrong

with indentation fixed, feel free to add:
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

- Aditya G


