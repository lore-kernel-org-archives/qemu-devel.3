Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56DDCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 17:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wadA3-0004Zo-RI; Fri, 19 Jun 2026 13:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wadA1-0004ZH-Pd; Fri, 19 Jun 2026 13:37:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wad9z-0003ob-R6; Fri, 19 Jun 2026 13:37:45 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JDIMsK2377760; Fri, 19 Jun 2026 17:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5xr5sN
 15u7VH+EZLDtCzaCbx/1EjVXsWigjzj4wN3Cw=; b=jleGiO8vmw8W7o6YQs0TmA
 c/FnFZX5Lq+pHFqypFSVgRCVnZL9eQQnrWbjQYp3ZHmjDZqfTn9Rs4DAlAZuXe+1
 0ROKs8QiI+l6XNwjQfYLk9xLb5wwEt3Qg+0T9AT7428b0qUQoo+caRiBw2u4FT+Y
 wfqPdtC14MZX+o1c/aAMSYdrWY6He6EIdRa0qdL1hXs33xN4L4L9RBUqMn+S8pDt
 976K2y9uNvV7eeRc/G3V+CfVtmPPpsyuN53Ml1dmTqSdfbhheAiT5wqVluUM6/YT
 hObjtjwO4DeLKVsClhXEW7FTvSi1UQpOi4OIJFApXuUQUMjx10+VVFpE60WdzHCA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw6wpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 17:37:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JHZ4cu000989;
 Fri, 19 Jun 2026 17:37:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172hw2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 17:37:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65JHbYJt24117926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2026 17:37:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5346458043;
 Fri, 19 Jun 2026 17:37:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DF9B58059;
 Fri, 19 Jun 2026 17:37:33 +0000 (GMT)
Received: from [9.61.19.86] (unknown [9.61.19.86])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jun 2026 17:37:33 +0000 (GMT)
Message-ID: <8bb5f783-e0b3-4f4b-b5c1-832f0e207f7b@linux.ibm.com>
Date: Fri, 19 Jun 2026 13:37:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] s390x/pci: Create function to contain fmb_timer
 start
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
 <20260605021728.1125090-16-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260605021728.1125090-16-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2NCBTYWx0ZWRfX+wMPLfv0pM4Z
 EpDTvtFu1sf8OfgT3/iDdg/east+5KFcOvbtVH1mSXYC1U+sY/s7MIbUFhPTqlesl/UoywDuNx5
 NGLEFDtVIRenxC1FYMnjbkpV4pPzCm8=
X-Proofpoint-GUID: njCkUAwEDGiwAgQKWkIopiaUx2mvdv0V
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a357e60 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=L2yL3M8d5HFB3c5Rrp4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: njCkUAwEDGiwAgQKWkIopiaUx2mvdv0V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2NCBTYWx0ZWRfX5KPZWsT5cwF7
 dBUMSVn+DrPhXxQrO8DSL4/jDj/KCCn+fC9vn/QMezhnTyMVOvW0aZRkmFmdQ58kYpIoN7WWszP
 L/hhkGH/5/whydoWxWoZQQqePwMmTp7W2kq49dvhYDvHOVP5srRrQV+aB5FA2MNagR49ilnRrWM
 eJrsut0oIyhTe/bLha1jrse1Zwc2gsheiddFBXNRC6vF4ys1FryjXrKsrxvQTfjDxWqDk57qbwg
 LWP+rIbN7X/9zVS9O5XSu52b/bJG3iSsPYMCUa5ql977sXZCrKt0TK7C6E2cDfRLMUBycsWxq8i
 5OFKuFYe+KVBdx/3mGx1fbTOLllutdAMNZgDJLyYr6k7OPsfLVgegS6elVlF2RVsHIa5u+ykF9q
 r9KWA5A+8sbyUJ5qXxgtOrjDyryes1lR4lVZjcOBnqAs4T35GcXSSjCIA4xosf9Muwb+BNCZymp
 7kFJYK6oOm7I1TYxxhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190164
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 6/4/26 10:17 PM, Konstantin Shkolnyy wrote:
> fmb_timer is now started in 3 different places. The new function will encapsulate
> that to make sure mui is added in all cases.
> 

Nit: move 'encapsulate' to the next line to keep git log output in the
80 char range.

> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



