Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663FFC5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwFB3-0001ny-3C; Tue, 18 Aug 2026 04:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1wwFB0-0001nC-Pk; Tue, 18 Aug 2026 04:28:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1wwFAz-0000Nv-4T; Tue, 18 Aug 2026 04:28:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HM1mYA2526562; Tue, 18 Aug 2026 08:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IcXq3X
 XVjREDpsWQDS84Wsm0PQJAK1t6wFqXfvagTlQ=; b=IKqkKdmkt3QKnYj+fUrXqg
 sVs+i3mLklJsqnav7uGgQHrkAviWbtB7Gpf+sfPHvebijmrWR6DZDZeM4VE/NpHg
 YczNy/BZuo8+wWmqemqU5UzOs15SnEQotu8FdPTycCzLZ1e89+8k/OTHt/LkKN97
 CIZi5xT5t6oVfjxOkbcn9zdyAgrmcHs0Zoo/Na4bCtA8uPOr7A2/5QhdOBjZx6AY
 MEXaPA9fzbiglO6Ffwgxkp49y7rbDSCxW6zkS/Xwe0kkwU0QCe9mDIDqHMlrSyz3
 PwEUuIfabDGbS6qgBJB2nbNy9Cjg50wlCM8N4QdKuAqsIdk6JIEaepNk2JnZmeWg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkxvks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 08:28:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I8QKgB008074;
 Tue, 18 Aug 2026 08:28:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34nga0d9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 08:28:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67I8Rui436176254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 08:27:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9D5920043;
 Tue, 18 Aug 2026 08:27:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E18AD20040;
 Tue, 18 Aug 2026 08:27:52 +0000 (GMT)
Received: from [9.124.210.82] (unknown [9.124.210.82])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 08:27:52 +0000 (GMT)
Message-ID: <9d89c00f-77d1-4bf7-991c-306ebef681e5@linux.ibm.com>
Date: Tue, 18 Aug 2026 13:57:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/ppc: reorg PowerPC RAS code for better
 maintainability
To: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, hbathini@linux.ibm.com,
 Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, rathc@linux.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, mahesh@linux.ibm.com
References: <20260714164745.573141-1-shivangu@linux.ibm.com>
 <87pl0ob9l1.fsf@vajain21.in.ibm.com>
 <CAEuJdmrKCJs_acaeJUu=WNif_hHnq1N5yikgiu7GoBcWjnxLTA@mail.gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <CAEuJdmrKCJs_acaeJUu=WNif_hHnq1N5yikgiu7GoBcWjnxLTA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1OCBTYWx0ZWRfX9RSmD8qU7cyF
 wMtho8p0FZmtEJdSmtc61ELcNbD2vIG8hPTC2KDS2uJCS3AMbvBo3fAohB7f/nGUpEK3RZjHm2Z
 9kOVu4//aYr6YtNrRL7D+XzNF60QKLPyblfNP5SkEXc9gwuA4JFa873biFcVT0rRFGzpTgvn/zG
 EvxrZdXjlq2UV17gNQqpyd30UygGX32PErNLnAcNQzugUA4d1IHHuS352/o+ih02XnFMDek/JBa
 tmB+51L2EnMgN/AbNNMaF/cebOV62AVrdP8aBWty4D9KfibZdL8OXwCyWMXWxFuVYx4pnnQ2K+S
 9ZQELdq/6niJs+fQ+4hG/c5HWzA0Xls725ovE9Eb/iqjxjIGytuLcxbiyIumGK+L60IL1s8mN7p
 JDGDnSLQuOlsUmNdTjMxLg99ICGKW0qQkHMioxyJmCM/NZeDiUmvu9q5f7x+I9pvhTkHuCak04F
 X1YsaR8Y5iJ/nB90TFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1OCBTYWx0ZWRfX8ztE4KuMocvq
 LOfjqWQiYnIbOtGtmUaDurRgose5OD1wUJlS2qkeMzdZ+iKOvea9yos+Er062ao41NdT1V/RCHX
 VRFxGJP6AEqsBOgwGWB43+4l6XFJqhQ=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a841791 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=RpNjiQI2AAAA:8
 a=VnNF1IyMAAAA:8 a=fS0MfFN5YSwb4SvH4yQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JvlIObs5useSQiD5E1I_TYuPZ_6_8OXo
X-Proofpoint-GUID: Tu-SL_HfvDNtjG4OYtzARMFQChY_MtZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180058
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 15/07/26 20:22, Harsh Prateek Bora wrote:
> On Wed, 15 Jul, 2026, 8:=E2=80=8A10 pm Vaibhav Jain,=20
> <vaibhav@=E2=80=8Alinux.=E2=80=8Aibm.=E2=80=8Acom> wrote: Hi Shivang, Tha=
nks for the patches.=20
> My review comments below: Shivang Upadhyay <shivangu@=E2=80=8Alinux.=E2=
=80=8Aibm.=E2=80=8Acom>=20
> writes: > Extracting RAS related code from spapr_rtas.=E2=80=8Ac,
>=20
>
>
> On Wed, 15 Jul, 2026, 8:10=E2=80=AFpm Vaibhav Jain, <vaibhav@linux.ibm.co=
m> wrote:
>
>     Hi Shivang,
>
>     Thanks for the patches. My review comments below:
>
>     Shivang Upadhyay <shivangu@linux.ibm.com> writes:
>
>     > Extracting RAS related code from spapr_rtas.c, to a newly
>     created spapr_rtas_ras.c
>     > and carving out a MAINTAINERS entry dedicated to PowerPC RAS.
>     This will cover RAS
>     > related functionalities for PowerPC platforms.
>     For a refactor-only change, this patch is adding 44 new lines to the
>     codebase which feels a bit heavy.
>
>     Just moving code from one file to a new file will reset the git blame
>     history of the code making future reviews difficult.
>
>     Such movement also makes code optimization difficult for compiler.
>
>     IMHO such code movement should only be done when:
>
>     * Its accompanied with patches for adding or fixing a functionality.
>     Or
>     * It clearly improves performance
>     Or
>     * Results in significant reduction in LOC
>
>     Since these patches doesnt seem to fit to any of the above criteria I
>     suggest you to reconsider these patches.
>
>
> I think the goal here is to ensure right people get notified to review=20
> RAS related code changes. Other option would be to keep entire=20
> spapr_rtas.c file listed under RAS and let it have non RAS related=20
> code also and do the split later when it's bloated enough to be=20
> considered for split. Open to suggestions.
>
> Aditya, Sourabh, thoughts?

Yes, I think we can drop the code rearrangement done in 1/3 for now.=20
And, as you said,
to bring the right people into the review, we can still consider the 2nd=20
and 3rd patches.


- Sourabh Jain

>
>
>
>     >
>     > Also adding myself as a reviewer, to help share the review workload.
>     >
>     Thanks for volunteering as a reviwer for this code. Having more help
>     with reviews is always good :-)
>
>     > Shivang Upadhyay (3):
>     >=C2=A0 =C2=A0hw/ppc: move RAS-specific RTAS handlers to spapr_rtas_r=
as.c
>     >=C2=A0 =C2=A0MAINTAINERS: add dedicated PowerPC RAS section
>     >=C2=A0 =C2=A0MAINTAINERS: add self as reviewer for PowerPC RAS
>     >
>     >=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 33 +++---
>     >=C2=A0 hw/ppc/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +
>     >=C2=A0 hw/ppc/spapr_rtas.c=C2=A0 =C2=A0 =C2=A0| 189 ----------------=
----------------
>     >=C2=A0 hw/ppc/spapr_rtas_ras.c | 232
>     ++++++++++++++++++++++++++++++++++++++++
>     >=C2=A0 4 files changed, 249 insertions(+), 206 deletions(-)
>     >=C2=A0 create mode 100644 hw/ppc/spapr_rtas_ras.c
>     >
>     > --
>     > 2.54.0
>     >
>     >
>
>     --=20
>     Cheers
>     ~ Vaibhav
>


