Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF63AD111AB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 05:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7pyE-0004v6-Hl; Mon, 04 Nov 2024 00:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1t7pyC-0004uS-LI; Mon, 04 Nov 2024 00:49:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1t7pyB-0003XU-29; Mon, 04 Nov 2024 00:49:44 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A42dpmK013726;
 Mon, 4 Nov 2024 05:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YTXQFF
 vGr/yxT4pM0LgTbX5K8bCOE0eLTiHc4EuH/8Q=; b=Q6nTAojx/zOer5v9a3zUyI
 6y7k9O2HnVVHxZFAIJ0HPc5xrbVKuVEpc4isNncqVXLqUYzq4FO3L3XgOitHG5Vg
 Q0KAe8iTZXHvMnJkeNS+XP880RjJO2WibRi399wU4zF2fTOZOxVEzZTJcVyntGMy
 mV5Z00oj8EXfI/jpLtnS8PtJ9fTeQZSpz2gM+6yanLG/sKqpFTMK9h7HjAL/IifN
 z6nNwHkmB2jl9SUTo7IcQAi8+W5HwcW9xhHvevc049CGWzZh7Q8htT5uqpEatTng
 hs3zed11txHFBSp/sfDiII0yliKt2MZuNlKltppXjx+M85T41/40roMd/9Tx6+rA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pnp98e3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Nov 2024 05:49:31 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A45loQg012238;
 Mon, 4 Nov 2024 05:49:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pnp98e3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Nov 2024 05:49:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A43forx023984;
 Mon, 4 Nov 2024 05:49:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsxtd67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Nov 2024 05:49:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A45nSxq27525872
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Nov 2024 05:49:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AD2D20040;
 Mon,  4 Nov 2024 05:49:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F25B2004D;
 Mon,  4 Nov 2024 05:49:26 +0000 (GMT)
Received: from [9.39.21.98] (unknown [9.39.21.98])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 Nov 2024 05:49:25 +0000 (GMT)
Message-ID: <d8ff3d90-a328-4be6-adf6-14ffed0faa38@linux.ibm.com>
Date: Mon, 4 Nov 2024 11:19:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/ppc: Implement -dtb support for PowerNV
To: Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20240820103003.550735-1-adityag@linux.ibm.com>
 <D5CIFVGK5UCZ.3S0N3TFQM5CCP@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D5CIFVGK5UCZ.3S0N3TFQM5CCP@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DHhcGJac7NGjqe2TLCck-nCOcEBxdtw3
X-Proofpoint-GUID: s4TBF-INv2dAQtV0rTWefvhKn25Q5Jh0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=607 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040048
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 03/11/24 17:04, Nicholas Piggin wrote:

> On Tue Aug 20, 2024 at 8:30 PM AEST, Aditya Gupta wrote:
>> Currently any device tree passed with -dtb option in QEMU, was ignored
>> by the PowerNV code.
>>
>> Read and pass the passed -dtb to the kernel, thus enabling easier
>> debugging with custom DTBs.
>>
>> The existing behaviour when -dtb is 'not' passed, is preserved as-is.
>>
>> But when a '-dtb' is passed, it completely overrides any dtb nodes or
>> changes QEMU might have done, such as '-append' arguments to the kernel
>> (which are mentioned in /chosen/bootargs in the dtb), hence add warning
>> when -dtb is being used
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> Sorry for getting to it late,
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

That's okay. Thanks for the tag Nick !


- Aditya Gupta



