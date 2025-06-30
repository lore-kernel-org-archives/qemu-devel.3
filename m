Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ADBC7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 06:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW8EN-00040x-IQ; Mon, 30 Jun 2025 02:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uW8EK-0003zw-QL; Mon, 30 Jun 2025 02:43:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uW8EJ-00008L-75; Mon, 30 Jun 2025 02:43:04 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TMFl9K024196;
 Mon, 30 Jun 2025 06:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Oflc9y
 v+dOaYWzTRnoYBYz3MvC0W12avFMrRs0k7MpU=; b=cfp7t630u1l3qxQsHFswI9
 xhLNcB/vAtLzqeIhbjG2/Q2YBVH2FrxQDmdmz9WKpuy6X4zdUuiI4TLFf6dQ3cFG
 BcUuC1kRMCnGQXqjXciCh6dfGRWTv4N4eYoknQ1d9vJ8UIz4C1tjueURmJzajWXh
 GJ59G5moNScTqJGqz7KVGcRQkAY0YJLTXPBo/STSNygaDstOk/BmnECewR5LGzr+
 OMBdG8TgYTniOW8WAfHsCa7WRmKUzQA6E1KrXS7fHvTMVKxvcGuFbVmKgSS9beTA
 W+h+Qlb59iFGd5c5+4cvkpZ7DCvcqkhuUELqtZYlWJ/s7h0RbNu2LvRbNObzYoxg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84cymtm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 06:43:00 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55U6h0dM020714;
 Mon, 30 Jun 2025 06:43:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84cymtg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 06:43:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U4UYXv032152;
 Mon, 30 Jun 2025 06:42:58 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47ju40ctau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 06:42:58 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55U6gwOn54067604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Jun 2025 06:42:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4797358056;
 Mon, 30 Jun 2025 06:42:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CE3758052;
 Mon, 30 Jun 2025 06:42:56 +0000 (GMT)
Received: from [9.39.23.32] (unknown [9.39.23.32])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Jun 2025 06:42:55 +0000 (GMT)
Message-ID: <594ef142-3b6a-40ef-9ded-c5f7789852a5@linux.ibm.com>
Date: Mon, 30 Jun 2025 12:12:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/ppc: Move floating-point instructions to
 decodetree.
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 danielhb413@gmail.com
Cc: richard.henderson@linaro.org, harshpb@linux.ibm.com
References: <20250619095840.369351-1-rathc@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250619095840.369351-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: km7ZXQnIVo2pjl2o9moFISQIUHrxMqee
X-Proofpoint-GUID: nMin8_ihss8uD6L18Wp9dnEs-U1VGqSi
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=686231f4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=pJG_TvXcrfF204dUgWsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1MSBTYWx0ZWRfX5p42vxyISINq
 2KB5xbv92FtUtDvWMShk6b9R28k1ACN8hgc8Wa5JBqneS7mneCTixSuN/LFltnvpXihoOeI0rjG
 SDYNTjKn4N/Ot38lE0Wlv0ZkUAPjp2VjL0knnhiBMQWiYJ4qTd/d6qf10pphLmbfvqmdN8hK0Fx
 IvmMzyfBuX5Y3/Hx2ppcuitgGUNu4KZ1WkFWqw4YxlP0NP9dK5z0Z3pxS2E0LvOQe7Rv6IVlzRa
 ADi9vJimAh7+SqSh9gxqMcOO9pVwqD6nK/uynx4VZGZASru1g9lqY2jHxL51i1+D9iqHGhVhW0Z
 SZ+kjQg94jnL04DiuFQo9kx3lB2qfdUMIcExyrpHkIhLRCcbE2xqnzyLb3+SNkfgwYmvjfNL8ax
 zJfcQEypKHx3A8TO+TxY6drJy4dSciMeXxClpFIL1neGCDFT/ViH7XPNAsiHTrd62dC9y2ht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=884 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300051
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 6/19/25 15:28, Chinmay Rath wrote:
> Moving floating point rounding, conversion, compare and move
> instructions to decodetree specification.

Hi Richard,

Could you please share your review comments on this series ?

Thanks,

Chinmay

> Also proposing myself as a reviewer for PowerPC TCG CPUs.
>
> Chinmay Rath (5):
>    target/ppc: Move floating-point rounding and conversion instructions
>      to decodetree.
>    target/ppc: Move floating-point compare instructions to decodetree.
>    target/ppc: Move floating-point move instructions to decodetree.
>    target/ppc: Move remaining floating-point move instructions to
>      decodetree.
>    MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs
>
>   MAINTAINERS                        |   1 +
>   target/ppc/fpu_helper.c            |  38 ++--
>   target/ppc/helper.h                |  38 ++--
>   target/ppc/insn32.decode           |  40 ++++
>   target/ppc/translate/fp-impl.c.inc | 289 ++++++++++-------------------
>   target/ppc/translate/fp-ops.c.inc  |  30 ---
>   6 files changed, 181 insertions(+), 255 deletions(-)
>

