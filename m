Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A038CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWa1b-00020V-Cd; Mon, 08 Jun 2026 09:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dengler@linux.ibm.com>)
 id 1wWXao-0007ex-Rh; Mon, 08 Jun 2026 06:52:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dengler@linux.ibm.com>)
 id 1wWXan-0002QL-9K; Mon, 08 Jun 2026 06:52:30 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657NfGW14023506; Mon, 8 Jun 2026 10:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2h14IG
 irb4yzQHx+2IUhzs5iUX0FOXjrnZv4/ty/9h8=; b=e3rd6ONor4o0eiMHRI7/OU
 m1WC1p+nj95rNSg1qIE3mAT78OV00XSWuepiz8cBjw2yXbBCC87YwfMNQ/tVKs0S
 913rhtcvOlIzotlxR61EpcD397Mx/tGYb4YX4ecx68ppz6PA+wbKXi71/4vK+26x
 L+zO4Yr+UAIarTIQF2vGnMwewYYxNuPjp27hyFCsVHWDS1ryMoTpLYKeInguHiMK
 Aann9Zp5n+tkLBtcZGZPxvzUHf2eU9QRYatzor9PncQAOPHV0nMDnOKsHrSS87Zm
 vaDphQP+gyEcgcaa67Z3Z1CPXCKLwqHY3Xumc9L14rTiYm/vbdFq1FSMcpiIUvZw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6spqyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 10:52:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658AnklE026055;
 Mon, 8 Jun 2026 10:52:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjmxb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 10:52:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 658AqJ1K50856244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 10:52:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DDAB2004B;
 Mon,  8 Jun 2026 10:52:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C360220043;
 Mon,  8 Jun 2026 10:52:18 +0000 (GMT)
Received: from [9.111.215.124] (unknown [9.111.215.124])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 10:52:18 +0000 (GMT)
Message-ID: <60756e0a-0dba-4e0c-a3c3-cf1758062556@linux.ibm.com>
Date: Mon, 8 Jun 2026 12:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/17] target/s390x: Extend qemu CPACF support
To: Cornelia Huck <cohuck@redhat.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
 berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 borntraeger@linux.ibm.com
References: <20260526121550.5296-1-freude@linux.ibm.com>
 <87y0gpmnnp.fsf@redhat.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: de-DE
In-Reply-To: <87y0gpmnnp.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fsVRJP84kM-5RoUNNfBhGVBTciJcm4ve
X-Proofpoint-GUID: fsVRJP84kM-5RoUNNfBhGVBTciJcm4ve
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a269ee7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=BDnArHBwf9zq2L3U8vkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA5OSBTYWx0ZWRfXyb8gEtnD7dUl
 app09SNfZr23LZGVy9KgT9Dd29biA05tfgcwTJVbRnsEttA2vWpoN0G2V2sSEG51jIN98HxH/8o
 3G46NBdAn6xK9wZe8Jg/QnrQBawT6ju09kqX8vCgEcnIReDLkkjLJ0vApUIurMA3kLmLcbhn5xL
 XcTPf0C5biAyFaB/YIX+7SJbWi4xd6SSNn28MEWiPC9C8m7ZOmzD9yhNxuAmVZY5kIyPV0I5lT8
 k05dsSMgS2wlxGEZGYz6sHiQdxTQ42UQw7qp/v7ByxT6Nyz+YyJgV+y2WC9iMAfO9kQqg0580sU
 IhWe0IrUA5LvRTwXYgGizsd0a3XmEuH0kMynjiEjTSTvZaEq3WCT8yv2CQkD+L1PAuFrtZ+yxxg
 b5arWUyRcL9Lituk6ZL+I4mJhy2U7rpr6npq7AoYeHYIfN9K9Kr5ZAkGIayhiSYdoNiFqEClSw+
 d0rUCoI4AAFgNkXAUug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080099
Received-SPF: pass client-ip=148.163.158.5; envelope-from=dengler@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 08 Jun 2026 09:28:01 -0400
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

Hi Cornelia,

On 08/06/2026 10:39, Cornelia Huck wrote:
> Also, is there any public documentation for these instructions? If not,
> it would be helpful if someone with access to the documentation could
> give an R-b here.

All CPACF instructions and related topics are documented in the z/Architecture
Principles of Operation [1].

[1] https://www.ibm.com/docs/en/module_1678991624569/pdf/SA22-7832-14.pdf
-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler


