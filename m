Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D35BC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJw6-00042d-Lc; Thu, 02 Jul 2026 12:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfJvm-0003GA-LF; Thu, 02 Jul 2026 12:06:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfJvk-0007K3-PZ; Thu, 02 Jul 2026 12:06:26 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662EI91m4074249; Thu, 2 Jul 2026 16:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Qonqtc
 K7qg5Pc0sg3VFayutA9QY4ZWorMW4FxU0F8EQ=; b=oHEFv9cxofK7u4VOb2ocne
 OGAHQ0xWt3/l+wr7qAn9nALFkWqLR7lYWPz5eMQGYQZZd0uWSgwrgkeIBA+qVnTM
 F1o02PtJY0XpKE11ZkdeXBlnQg4aAUpCZzNLEBiv8nf4dGcdvfbxMnUiLI36NOu7
 VjvTwtWZ/hDHtP1nrLzMfQkXl/0xQA7D/tSMV1gjHsY872IOGslC31ZqouVZ4lLV
 kqGiSzqu4d+A6+aXOT6q84qrUqmHZe1TeBT6jFKNcuOcxtWhPJfKH0uVifOqW6X2
 XevGCbA8+gnBkpGuxcBYIefwwMzzUhMFkTcKy+4thhHIdHZiCxCSJPaWvDiLDguw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n62vqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 16:06:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662G4lYF030935;
 Thu, 2 Jul 2026 16:06:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhmnda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 16:06:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662G5jLS42992080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 16:05:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91A095803F;
 Thu,  2 Jul 2026 16:06:18 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D9F758056;
 Thu,  2 Jul 2026 16:06:16 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 16:06:16 +0000 (GMT)
Message-ID: <b531d879-8743-4733-947d-0f698029c44b@linux.ibm.com>
Date: Thu, 2 Jul 2026 12:06:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 33/35] tests/functional/s390x: Add secure IPL
 functional test
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-34-zycai@linux.ibm.com>
 <c9a6b8a6-edbd-482d-9f01-7aa09073c934@linux.ibm.com>
 <f0a13552-a825-429a-be79-a75cea4ae75f@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <f0a13552-a825-429a-be79-a75cea4ae75f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2NiBTYWx0ZWRfXwCnxbque46kc
 JwRV2WvcyuY5xKNo2mtn4hHm4+Xps01va30bpuq8j7D9y23979ORV/xGXicL9tdAvJkSrH93v5N
 jZFbqkm83RsJ3CoW/73TVhmbAnFdKNEEghU4WXOVnFz8HjdNKN41TwsAxZT1q66BQymkstOD1RI
 vbyXxQP53q0m7K8qfXw6+ZwWhqE5C5q5TZwwrXHhEXbu046WEJsnrBX6189HfsIAsaeLpdFTxaM
 LcgHP+bHYWKZKU1Dye5jz4CKRcKkqhm9HJYkXL8rYi+mkNagnXibIjJIDVFy8qrbCZqVb9kYvdH
 7Lp2nDsdzwLOJXch6R6bY1GrBMd9h4OmQ9oYDwYrZDsNeZ0g7/XpZ6C/OO6/0AOoxJX5rUU+3ol
 /508NiWALHBw6t7Oq5kcVlWdvumz2coEgI/4FTx66nn9PfCkvcsXmSA87qbrJ/FzBbZBECQs/xe
 DC2JZ778kzLDVoC7YWg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a468c7d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=CtFJNZ2ykOYILP9N3LAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eqqaQaJesDFs0YMvzcfR3LfeRC4muitL
X-Proofpoint-GUID: eqqaQaJesDFs0YMvzcfR3LfeRC4muitL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2NiBTYWx0ZWRfX+AbU2rgzgmA9
 pMyTZ2L61EmDSpZc57VnSHsHOpyzi8fhPTxgh6lAoh6brXT0wLWSKTy0p3HRY/egeZ3o1Ba0Udk
 jA6IFr7H5vTr4hTr6qiH8COV3x1SUro=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020166
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

On 7/2/26 11:38 AM, Zhuoying Cai wrote:
> On 7/1/26 9:48 PM, Matthew Rosato wrote:
>> On 7/1/26 4:49 PM, Zhuoying Cai wrote:

>>
>> I thought this would work for tcg too?  If so it would be nice to be
>> able to enable this test also for cross-platform testing w/ tcg..
>>
> 
> Yes, it works with tcg as well. I ran the test with tcg last night and
> again this morning, and it passed both times. The main issue is that it
> took about 3060 seconds to complete due to the relatively slow nature of
> tcg and the amount of setup performed by the test.
> 
> We could enable the test for tcg and use tcg whenever kvm is not
> available, but we would need to significantly increase the timeout
> compared to the kvm case. I think something around 5000 seconds would be
> reasonable to avoid unexpected timeout failures. If that sounds
> acceptable, I can enable it in the next version.

Oof. 

We could potentially control this with $QEMU_TEST_ALLOW_SLOW; but let's
leave it as is for now and consider incorporating tcg testing as a
follow-on.

Thanks,
Matt

