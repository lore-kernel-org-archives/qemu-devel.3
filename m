Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4B1C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 16:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFxq9-0007gH-Hd; Fri, 16 May 2025 12:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFxq6-0007fh-L1; Fri, 16 May 2025 12:23:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFxpz-00065Q-T6; Fri, 16 May 2025 12:23:11 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G9FPel007532;
 Fri, 16 May 2025 16:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=B37YaK
 nvDsx/BiBUPpczKfSYxBtIGh5xF6WWMzo+WaM=; b=aQHCuEKWfA6J0RQemXRVCb
 J9YJ1AFA8/cxyPLsYQJu6lzG50i3QUAK3eCq4x1GZlrkG02RZPJAqJ1Rdgz4YG5d
 ZLr9iYcQDJuZWmUzS1079ntng79cfoHcTYfWSwwEfpNsJKs5B0cymShrD0G7ZA6X
 IoWLuDIn1VXO6aBlQgChuWx4nYXIhTfBG5Gl3roR0TNkU7ImTES/3TnXQc5RCLAd
 LH/AwzBsiSDA3QHtygqPHYYX/iBiTadyuju8o44huimtViRRDnPdqTmT+UINvgUg
 KPskT7zBA4oRRExYvtFGi6L0z/k5eMt6chBRpNMu+WnG+VPFSw+ObNKhtuvZZALg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46p2jja097-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 May 2025 16:23:02 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54GGMxNg022996;
 Fri, 16 May 2025 16:23:01 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46p2jja094-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 May 2025 16:23:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54GEScpe015329;
 Fri, 16 May 2025 16:23:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfq8cg9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 May 2025 16:23:01 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54GGMx4H28050028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 16:22:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26A3C58059;
 Fri, 16 May 2025 16:22:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7E4558043;
 Fri, 16 May 2025 16:22:58 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 16 May 2025 16:22:58 +0000 (GMT)
Message-ID: <c955a654-1199-43e2-bbf4-905933ea17e0@linux.ibm.com>
Date: Fri, 16 May 2025 11:22:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/50] ppc/xive2: Use fair irq target search algorithm
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-9-npiggin@gmail.com>
 <D9X5FDZ917LB.1HYODTEUEB7LH@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <D9X5FDZ917LB.1HYODTEUEB7LH@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE1NyBTYWx0ZWRfXylGD/xIC9cjK
 v7oba3Id9P6NOscoh7EeMuKta6j+Gf7b+cFmAYF4MzHmlJSjD6ZrotwzF+IdgBS5zNx+d0sb3Dw
 falgNLH3C6XMiRniSF4uoA/IfxMJadSyQlc3Y7kvowx/eRmlc6SZ7kcjBrl7UTAycnBVsAQVFml
 6op88bcGN6x9IcfcAGwmRlweQh/cFZpDztmw9ajiEHslM3xyp9rzT5l+C7uwCudER5KdjKP40My
 Pol3gBzQGzffhf2tiMTeyqY6Cx4O1gUd3xe+MjTu0jNZLVQg0Ixf3iUHH5sGXpHMHR0fhx5V44a
 Xzxvd1o/omR4IX4AkZRDkGZMsSrhFIGmIbhw6l4PmClU2e+fpIqDaDH4MdoSqu5c62/V9P6c+XF
 xB0hC4cqfA+DNOYOXY/HnLBvQlnhx9J3wvZ5oBw3RdAp9pbpaYMeFfHvNFlIgjRg2VgkPZ2c
X-Proofpoint-GUID: WOiYToYcWFIVhfd4uahmpeIhRm-gdMX8
X-Authority-Analysis: v=2.4 cv=O4o5vA9W c=1 sm=1 tr=0 ts=68276666 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=hY41RpR-_kkGXo8SPmQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YBr1ncqyru2fpwHfo1Jk_9MmC0R3DzgI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160157
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 5/15/2025 7:12 PM, Nicholas Piggin wrote:
> On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
>> From: Glenn Miles <milesg@linux.ibm.com>
>>
>> The current xive algorithm for finding a matching group vCPU
>> target always uses the first vCPU found.  And, since it always
>> starts the search with thread 0 of a core, thread 0 is almost
>> always used to handle group interrupts.  This can lead to additional
>> interrupt latency and poor performance for interrupt intensive
>> work loads.
>>
>> Changing this to use a simple round-robin algorithm for deciding which
>> thread number to use when starting a search, which leads to a more
>> distributed use of threads for handling group interrupts.
>>
> Does hardware always do the "histogram" distribution? I wonder if
> there would be any performance benefit to do something like send
> to an idle thread/core with preference. I guess the xive controller
> might have a difficult time querying the state of a bunch of cores
> before sending so it's probably not practical for real hardware.
>
> In any case this is a nice improvement for group delivery.
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


Yes. The hardware does a histogram to determine the best 'match' for 
multiple matches.  When we implemented Simics Florian and FW said it 
wasn't important to implement so we just came up with the round-robin 
starting point when looking for a match.

MAK

>> [npiggin: Also round-robin among threads, not just cores]
>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>> ---
>>   hw/intc/pnv_xive2.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>> index 72cdf0f20c..d7ca97ecbb 100644
>> --- a/hw/intc/pnv_xive2.c
>> +++ b/hw/intc/pnv_xive2.c
>> @@ -643,13 +643,18 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>>       int i, j;
>>       bool gen1_tima_os =
>>           xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>> +    static int next_start_core;
>> +    static int next_start_thread;
>> +    int start_core = next_start_core;
>> +    int start_thread = next_start_thread;
>>   
>>       for (i = 0; i < chip->nr_cores; i++) {
>> -        PnvCore *pc = chip->cores[i];
>> +        PnvCore *pc = chip->cores[(i + start_core) % chip->nr_cores];
>>           CPUCore *cc = CPU_CORE(pc);
>>   
>>           for (j = 0; j < cc->nr_threads; j++) {
>> -            PowerPCCPU *cpu = pc->threads[j];
>> +            /* Start search for match with different thread each call */
>> +            PowerPCCPU *cpu = pc->threads[(j + start_thread) % cc->nr_threads];
>>               XiveTCTX *tctx;
>>               int ring;
>>   
>> @@ -694,6 +699,15 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>>                       if (!match->tctx) {
>>                           match->ring = ring;
>>                           match->tctx = tctx;
>> +
>> +                        next_start_thread = j + start_thread + 1;
>> +                        if (next_start_thread >= cc->nr_threads) {
>> +                            next_start_thread = 0;
>> +                            next_start_core = i + start_core + 1;
>> +                            if (next_start_core >= chip->nr_cores) {
>> +                                next_start_core = 0;
>> +                            }
>> +                        }
>>                       }
>>                       count++;
>>                   }

