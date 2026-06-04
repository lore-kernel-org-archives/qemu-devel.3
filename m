Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CD0CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV5J1-0003bA-O6; Thu, 04 Jun 2026 06:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wV5It-0003ac-2j; Thu, 04 Jun 2026 06:28:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wV5Ir-00008r-BM; Thu, 04 Jun 2026 06:27:58 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653Ii2IL3294139; Thu, 4 Jun 2026 10:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9SeXEx
 I0KhlFOYRfKNdvQigy1sHVNuarXz0/m45MFnw=; b=BeBbVYrg/Btcv+hu5z07AK
 nhiBOzm9NoUMDYAgUTwa129isaH4mKjcuV0cGJrnuEbjDU3zHQ33NhvKFncVz/sa
 RXoVJqemR+ukT7k1jvcRuFdP6K9YiA7LYjjUQouK5eKFHvHMpYfqJkswL7gU9HIl
 DaeMghrWnpmKlt/C0DQNQwGa5FHUHnGVHZOq3HKePuHhIAnB+UXySF3LW7DRs4kX
 maHQqbL3jjc9ZoceRZ5vyFIrn/dTdaZLpbQoePGCjZhDa+tp0KM0hkBrNIyZmUkf
 LeHj6b9rjray/j57lAEKMT+/uu7tDxlpMUKvY8ko8wiQawO1aKAg3d47Hw84nlwQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahxvtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2026 10:27:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654AO6sE018840;
 Thu, 4 Jun 2026 10:27:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhmgs5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2026 10:27:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 654ARnLG4457416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Jun 2026 10:27:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3238258056;
 Thu,  4 Jun 2026 10:27:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 462875803F;
 Thu,  4 Jun 2026 10:27:42 +0000 (GMT)
Received: from [9.124.208.6] (unknown [9.124.208.6])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  4 Jun 2026 10:27:41 +0000 (GMT)
Message-ID: <db664ddc-79c1-4828-9129-9d183b133467@linux.ibm.com>
Date: Thu, 4 Jun 2026 15:57:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/28] target/ppc: Moving instructions to decodetree
 specification
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <846d7958-6515-4e4e-8c15-513e282aaaa3@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <846d7958-6515-4e4e-8c15-513e282aaaa3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5NyBTYWx0ZWRfX9kJQbIqxBCjK
 +rmz2hYkUyDXZIguvrSLJD5Y9XS2RQzlwBFm/qmbR/Gu/kbbE0TRCHMEYjcE1h4z5iwyZwa6M8j
 Fi6KEMcUDGBovogQACk8hMpbBTmQToRl3sK2YfJPi5CNOTJ2h91jUakTj7uXVMMJk5Wjmg+XTfW
 PX19TTihsPSFYzB1ejfXoLCv+ylbrV8SUhdO+zqstCDV6sb7DwMBuht6Bi5onel/T6WzvnPFbkf
 mlZGeIh68UR8yIjK1KPyvFV/tmvjZFoUAVCDSFU///9dZQsPckdT/xbwC7Not4iUKfRVEdgMPxJ
 27c/lkFFB441mrqWZS7gNrEOgrCQxqFESLKA3FXXLplNbnv7ZZ5Po9u3dCAh6w71Q7LcQNrDmfj
 SkWeV7nydQfqVfhvNKK0k6n9cI5wF88b7iLrEfAzzK6WFAHVd05hYDdu9IsMALLID4OyWDSkf9D
 VLBJGVLGOCzfTEZrtLQ==
X-Proofpoint-ORIG-GUID: VGx4n-p6Aajvy8t-gx0eV_KDXn4DilTP
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a215327 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=-EKdfv4u6AsgaGVaOz8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mS9CYwoVHxt3EGbAXUzCdULJYlnvmkir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040097
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 6/3/26 20:00, Richard Henderson wrote:
> On 5/20/26 09:07, Chinmay Rath wrote:
>> static bool trans_LDAT(DisasContext *ctx, arg_LDAT *a)
>>                                                      ^
>> I see this happening in the last pointer argument in function
>> definitions after macros (like TRANS(..) in this case).
>>
>> Richard, Peter, Stefan,
>> Could you please advise if it would be okay to have the above false
>> positive in the patches ?
>
> Just ignore those.
>
> r~ 
Alright. Thanks Richard !
-Chinmay

