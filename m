Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D92FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHGqg-0005Nv-DL; Mon, 27 Apr 2026 03:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wHGqe-0005Mt-Cv; Mon, 27 Apr 2026 03:57:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wHGqc-0005jA-Pu; Mon, 27 Apr 2026 03:57:44 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R6JBZX793693; Mon, 27 Apr 2026 07:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+dLY1Z
 WbL42CDjZcm4VN4N3otPVU5ynA+ZpVS+E+gAM=; b=UuFiNkvK3DsjD/itVUhi/Z
 4x/SVM/ent1IFVaIBFkIVdgazZhKBlkkntDHX/rjphNdEhK7Ypklt33VPIhPRq0m
 Ew3jj5/8Gfe9qqp23AMC35ZTqiOmDCtnfzUDNyUEZ9qGP5PKimBNXJW+ZOXR4KwZ
 AZiQ8/lKoeUddsR72hviEPyoubQE2mVbkL6DZatmDf2LHUFL2bq3EedGO+ZLrsYX
 quvsHez6AJ/ROjoNtmPWzZyQwvkVBm2RLJkllPvfIPAWDMWZ4pRmAvZUJnmjBv40
 dJCrjcafC7IwvwrwG24jadOOomT/9wNUjz1BrzrQovoZET/3Ee2d5JbEDFtwLp3A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9qy9r5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 07:57:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R7rnKF032451;
 Mon, 27 Apr 2026 07:57:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy409j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 07:57:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63R7vY9126542574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 07:57:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BC1B2004F;
 Mon, 27 Apr 2026 07:57:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4B012004B;
 Mon, 27 Apr 2026 07:57:33 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.136.63])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Apr 2026 07:57:33 +0000 (GMT)
Message-ID: <3d49dc79-00ea-4f2d-9fb3-d6fc2dd3b418@linux.ibm.com>
Date: Mon, 27 Apr 2026 09:57:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 81/84] target/s390x: Move
 float{32,64}_s390_divide_to_integer
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-82-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260426134002.865628-82-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WpZTV0jm3HtehcHPhELtz4X9sQ-vnpDY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA4MiBTYWx0ZWRfX8wqfih5qZuIK
 Qy/pw/d+VbNB+QgbwSyg4DMXmBoCHv7IswC+NEm66j9v8mfQYEtqzUebinhM3X5+L6tBM5b5WmE
 eb4lmm9gMzizQtdX8uxXURKuXwQZ5+bOK6XlyiZXTJVhm9yjOitocciCe6YakhJvvY62UlZvWos
 KGAQaOoJ/s1zM8gRO6DULZRV+nv+F73LKUN78+kly5aJTUsA6hfEB6HSOEEWNpJv2Bm/DDlHWDI
 g0pLfUrRnUGwpfsvaJ7Ensmj0Qh7w3MuvZlxYNIIG20ylk16oOYTLuGFj4p2UKhLysjYgC+yqUf
 9c2medHp64faBADyxpTekh95pU01y9u1ELCdGWcBmcBXhbfy/PPV8tSple0VoAe9pTmV6d8tj2D
 C5Fya6Sw+zwnep1u678UpMdT6tY5xljw5xqw338jHHUORO8Z6ObuSngLP/qUcwjvaVLsTooBSvd
 0/IOYC9mIVER32k/ExA==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69ef16f0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=OWbXl1IpBWa9Eo39IC8A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WpZTV0jm3HtehcHPhELtz4X9sQ-vnpDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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


On 4/26/26 14:39, Richard Henderson wrote:
> Now that we've exposed enough infrastructure, this can be
> implemented in the backend that needs it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat.h       |  11 ---
>   fpu/softfloat.c               | 137 ----------------------------------
>   target/s390x/tcg/fpu_helper.c | 135 +++++++++++++++++++++++++++++++++
>   3 files changed, 135 insertions(+), 148 deletions(-)

The series looks reasonable to me, but I haven't looked at every single 
patch.

For this one:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


