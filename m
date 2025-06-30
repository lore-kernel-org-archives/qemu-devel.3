Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0024FC83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 06:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW8Gt-0006EU-Ca; Mon, 30 Jun 2025 02:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uW8GZ-00067C-TS; Mon, 30 Jun 2025 02:45:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uW8GY-0000g8-1F; Mon, 30 Jun 2025 02:45:23 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TMHM29023695;
 Mon, 30 Jun 2025 06:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KCuSkz
 OfSwVkbEBAsISXMZ2aewSZEGLupp4ZgobTG0Q=; b=HdT348fHOxYtcDSSSOWA1V
 3Nosr3xPUCH1OWgCf3c+5/mvl3zerm8OiLuIGWuCE39ZcL9ab+DRzNDifVMhA8Ch
 9p1W5Wrbs2O8vWpwya960OXssBfRIYEu3b32wvF7RjFF203tuMzyT4V87qCCH5mK
 S08SxXjHqGQOQbl2sjne5jEpoKTZfTU5SJj/DRXT7MhxW7odosiM3tkmEJF4Q3nK
 MDAldb5/5f9YuQqYDaOtQE4SYoo9P+mYjwYqymNHyarcGZCvvjwV2IcU8lDb2vys
 zSIYzH3AjKdEpQ79XT13d0Fqcrm53qHkWXFfWT3JnFNdXR6obnSZeDlHMf46bZ2A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tsyyy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 06:45:19 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55U6amrX032558;
 Mon, 30 Jun 2025 06:45:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tsyyy6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 06:45:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U5cTkE021914;
 Mon, 30 Jun 2025 06:45:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpcntp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 06:45:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55U6jGdn61407502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Jun 2025 06:45:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EC0758056;
 Mon, 30 Jun 2025 06:45:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 491BD58052;
 Mon, 30 Jun 2025 06:45:14 +0000 (GMT)
Received: from [9.39.23.32] (unknown [9.39.23.32])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Jun 2025 06:45:13 +0000 (GMT)
Message-ID: <0f092966-8471-45b1-bff3-3319a3d538b3@linux.ibm.com>
Date: Mon, 30 Jun 2025 12:15:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CPU hotplug crashed the guest when using virt-type as qemu!
To: Anushree Mathur <anushree.mathur@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, richard.henderson@linaro.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com
References: <96ce3e34-6d4e-4d92-a852-6eee5063140d@linux.ibm.com>
 <888a0d9d-ed0d-4a9c-81b6-0b3f3e6fc0db@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <888a0d9d-ed0d-4a9c-81b6-0b3f3e6fc0db@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fxMr93r8hvgVvYoDEY7tL8z5Qf9gZvRX
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=6862327f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=sPlpsh3DtUFHNmM4cxgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -PEedfkPPxf0WEJmXkRvJ5ylPx51hY9Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1MSBTYWx0ZWRfX/WwsyHLdVH1t
 NHW3vkMwxBxgpE1YIbhle2EGanAhNv9BsimMh8mejyUCwQ/NzZLh4jy8S9gMGCTCxYTz+YMP0yq
 FJiY2/RPDEtmh//dICNhyhkZPv9MEybTDTAecUFMuop4GXGCRJQgRoSN5sIvi97yZWyh4hmIIqu
 U+huw4Q7QYb0hFrwJeWvokTvJWnNrQFTBs1d+nGYcEbVuUbi5ErjOHkgCmDZnTbIhzzON9IS+n8
 KyKAPBnb84Mmrh6Zv6q+3hfJnDKMN/cRAAc2aIBeTxaryk8O0kGT0pDvpbmX7IiCTqGUJshz8XU
 reI4g96c68d3574BeLERH5BXCCB6yUuRbsf+OQrvLjnOaeXCt6rn9VczfSgsJ7uZZAUM3iP6jQd
 tJFVzzzlKIs98OQ30yGgAKctaDaTRMp5uqbWRWaqS++y4aIA3xvdLrzGUWgS3xUsrbsnLZBq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=860
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300051
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 6/23/25 17:54, Anushree Mathur wrote:
> Hi Richard,
> Any updates on this issue? Would really appreciate your inputs here. 
> Thanks in advance!
>
>
> Regards,
> Anushree-Mathur

Hi Richard,

Could you please share some inputs to investigate/debug this further ?

Thanks,

Chinmay


