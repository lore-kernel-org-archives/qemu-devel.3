Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164C4CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDerx-0007ts-Ke; Mon, 05 Oct 2026 05:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xDerN-0007jX-Go; Mon, 05 Oct 2026 05:19:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xDerJ-000460-G4; Mon, 05 Oct 2026 05:19:47 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69515mOa3138333; Mon, 5 Oct 2026 09:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iod7op
 9+NzIGlqg39M1sf9w38i0ihekxm/DydDhqDek=; b=EZqJrj2yE0HJpMCUZ+piKS
 B8bpdTe2H+d3Xl0BLZqEEB+16UfGhCbMdgDgiMpKeQYhTvwUabtgEAD+hB1SxjQZ
 T/EhLr/m1TOP66U2PbuvtSoMe7Rb98WuUWzCuI4HjkxueOEMUgZ1b1PMtmov/+0O
 v5MWl4rgJQJm8IRK3EWbtNqfwl/zUsYvguO771J9n3kFG+6NQrwbmYXoXIM4B2Q6
 lGXNZK9QlQSFJVLmaBcLPorW2M0548GbenFSuNtDGSZw7Bi822irGZCKpNaHTE02
 cwc18SHpxDaJ4L+o7/NZnwSyIBb4QJOZNATTTieq1eRhP+aRmhOVaoG4Dx81IOOQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jh1t3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 09:19:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6956dXst2163522; Mon, 5 Oct 2026 09:19:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvmveb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 09:19:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6959JepC49807792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 09:19:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80E462004B;
 Mon,  5 Oct 2026 09:19:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57C6220043;
 Mon,  5 Oct 2026 09:19:39 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  5 Oct 2026 09:19:39 +0000 (GMT)
Date: Mon, 5 Oct 2026 14:57:50 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: =?utf-8?B?6J+55r6k57+U5aSq?= <zakinko@snowrabbit.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH] hw/ppc/spapr: Add the "rtas-version" property to /rtas
Message-ID: <20261005145654.9aa03d20-a9-amachhiw@linux.ibm.com>
Mail-Followup-To: =?utf-8?B?6J+55r6k57+U5aSq?= <zakinko@snowrabbit.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260929094138.16A18C92A0@bambi.snowrabbit.org>
 <20260929161126.2679fec2-3f-amachhiw@linux.ibm.com>
 <5E17BD06-6338-41C7-BA4E-E43771862D8E@snowrabbit.org>
 <20261005144738.9c0e1f8c-ba-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005144738.9c0e1f8c-ba-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: G6ht0o7wsksgPPWV-40AILnS1-9s4ih2
X-Proofpoint-GUID: QoI6lbw_-IvVmAHhL8FV3ReMDOj6Gj94
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzNiBTYWx0ZWRfX6dOgBTOK6eAg
 T+8o8vIB9p86T/LXcrcY05gJVggdHWeBj7AESqnLFfW+Yuf9iE1VdNn/jQonOYjMgFkFYsxJaW7
 v/rKY5cThvk4hmAqvqpDRK2A/b+ppkI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzNiBTYWx0ZWRfX04ocsBZFs36U
 1/Mqfc1jiHxA6ZRCxyMyT6R8HNF9gBWNG/IbdQbuSkYNk6z6mJNqgZIkAgqnqUsoFVJQaCcDW4Z
 wnRWR2ooiRv5QZiAQS9lfl1cyGtnhhjGJ6X8FXCOCQ+DPi+asoiIwkVkQTpuCF6oB9Y/inMjpqQ
 FqPfx58Mt5REmzEu7tK1hNGXoNpzsTtfGTw7R5GZTvWplRtcHU1/4bAKm2rt0d1XCy7uDnh7OWM
 ltxP8TBUQbo6vLLjHK+qiheYmb4BsJzNCHRhUcWqWYFJA3F2MCRMS70OZyoSjx1yf/XHiaoC8mh
 zQSJ47A0z6pyxQQ2JJZgMD1WbCrxBV1PDRYV53mQrWaugx1JmIZ1Jc+y2g93O2rWVZG4iN1ESY+
 c/OqrxwTZX2LSi7Qu+Y0c1Ms8KpECDscliFVYxaqcSQhSkwQi3fBt48Guj6jSkYpYN1fSIXicle
 Rf4yaBi/s+WplfJo1ag==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac36baf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Qh0I4lJ5mTKsEwSnB44A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050036
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 2026/10/05 02:53 PM, Amit Machhiwal wrote:
> Hi Showta,
> 
> Thanks for addressing the nits — both look good.  A few things before this is
> ready:
> 
> 1. Please send v2 as a proper standalone patch submission (not inline in a
>    reply), so it gets picked up correctly by patchwork.
> 
> 2. Since the nits have been addressed, please carry over the tags in v2:
> 
> Reviewed-by: Amit Machhiwal amachhiw@linux.ibm.com
> Tested-by: Amit Machhiwal amachhiw@linux.ibm.com

Correction, the tags should read:

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

