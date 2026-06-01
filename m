Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE59CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU5Ab-0005by-9L; Mon, 01 Jun 2026 12:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wU5AX-0005Zv-DH; Mon, 01 Jun 2026 12:07:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wU5AV-0000vw-GF; Mon, 01 Jun 2026 12:07:12 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6513vSnm2665536; Mon, 1 Jun 2026 16:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Wgpp4r3oUkFm3+nbnZovaIl1tTOLKp
 oaRekAxI0eJ7s=; b=jDx9HcCObkRT8jlo2W5TZ+9NxAJ2X5cNiEY0awKvJGuERG
 CO3RV+KV04QGEVXveNaOx8wX404U8Sd8lf/g5coHPe04JeFbV86D7GmIwvZigVB/
 hVu0J0W0ngG2RDa78+IWQaLXSIgkU3jfQOaulwpKLpwOOKlx4v9tT0F9rZCpMab8
 oqLc8lgUZ7FlyqZGGNUqINcf46AoD2yHGK5isLxUsZY/uFQZWvLgkaq0179eIsYM
 5Ntnz26wYx1FWZcEdn5fRvtKXSIfsrvcEjAcs5POWWwzd5NRhAD9lHGGOCoefRkZ
 Huxuz4d2JOXOG/vLw/xklzvU65tXqvH2Ig7a2X4A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht18pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 16:07:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Fs6rD027761;
 Mon, 1 Jun 2026 16:07:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqh6uk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 16:07:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651G72EC42664388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 16:07:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2E1D20043;
 Mon,  1 Jun 2026 16:07:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8204C20040;
 Mon,  1 Jun 2026 16:06:48 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.23.64])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  1 Jun 2026 16:06:48 +0000 (GMT)
Date: Mon, 1 Jun 2026 21:36:38 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, nikhilks@linux.ibm.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com, milesg@linux.ibm.com,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [RFC PATCH 03/28] target/ppc: Convert cache instructions to
 decodetree
Message-ID: <ah2rRgUYrfRMTM4g@shivang.upadyay>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-4-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520160728.2283628-4-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: R-zNSLdctYZsu_HnhAmFbhXgjTnVB1qn
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1dae2c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=0d468bUoJbC0vU7tc7gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2MCBTYWx0ZWRfX8UbGrTVo82y9
 9ZHwYYtIBpeY3n7n6ejsgtKj+n8oRE0t7et1fINvTs1+LOCNXizk+o3GiZzx2jGRQ+SrCuskDKP
 gUpjh3RaWmbhCZckPDpPhhvkRiv01nN792Bd3DDM/wX1mxgZdaY5BegD11EGMvsCm+HfpKZqBG1
 bD8APQxpYX8t16JunIrTNYe75BLKJYgVsAg2OO+NjemWg4JkdfmdfHKCLhHI05tX3lwJMQT1XGL
 Ajbw0t6MYyqB5LjM5WeC9lkbid+hdeTJFJ0LEoS32wtLB5GrYSJzS52wutacDVnUZq/Pwa8BZ+o
 lWXqWXsE/oveht0ACZAfoUVlV/8QXHoUbO94BhJ9rZ/RuZN2MvFLbvzyrDC4YIvHAJwMdyTZUpB
 5qkfnlM832yqZ9YJSSZ4d6IEPOkHeC8i18vLUGBRYC9h9QE05Qj6v+cTxGhsL8BEtjvnHkCG3a+
 zf/BgLYNo5MhMyxAWXQ==
X-Proofpoint-ORIG-GUID: r69QmMzauS9HXPo-kdb0xCK-FVxhIDin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010160
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, May 20, 2026 at 09:37:03PM +0530, Chinmay Rath wrote:
> From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> +static bool trans_DCBF(DisasContext *ctx, arg_X *a)
> +{
> +    TCGv EA;
> +
> +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
> +
> +    if (a->rt != 0) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +        return true;
> +    }
As per v3.1 ISA (page 1064), DCBF instruction has form
	DCBF RA,RB,L

L => a->rt, as per the decodetree.
in ISA, L can have values of 0/1/3/4/6 (other values are UB).
Extended Mnemonices sections gives a good idea of the usage,
for specific values of L.

 Extended      |Equivalent to:
 -----------------------------
 dcbf RA,RB    | dcbf RA,RB,0
 dcbfl RA,RB   | dcbf RA,RB,1
 dcbflp RA,RB  | dcbf RA,RB,3
 dcbfps RA,RB  | dcbf RA,RB,4
 dcbstps RA,RB | dcbf RA,RB,6

It would be good if you can align this (new) implementaion,
with ISA.

> +
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +    gen_qemu_ld8u(ctx, EA, EA);
> +
> +    return true;
> +}

Otherwise, LGTM.

~Shivang.

