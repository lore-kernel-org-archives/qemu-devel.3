Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BEAC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 18:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHD2-0004A0-Js; Wed, 14 May 2025 14:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHCy-00045Y-0I; Wed, 14 May 2025 14:52:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHCv-0005cV-Tk; Wed, 14 May 2025 14:51:59 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EHxVqg029624;
 Wed, 14 May 2025 18:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Wg8gJG
 Msh2pJDB7M/OGI3/PGhdwKXBkD9d2HhE1XHdI=; b=OaD/boFXZAg4ixNbtO7Vv3
 te/hprh43MPAKbRWuznCNt6xwri9lG90O3+kyq5BwVLHsAAkM4p7ea0drFKFaJcB
 YRiIoE4TqzbA+NfSlUolvWyrdVVZOs94T7z4AMpDfHDNz0Y9MyLDWST6DCwNt4My
 gVT4VhTmErkevIGzTb97LCZ4+Um6gouBAtaEQ255qTYnyhRHSv5EpWrNIHLKN5OO
 mYTqZJqn4to2xqsbilUeUKHsZ9sRcWUYkz3bZGvNM1OvVcXnC2edB1gTsrWdUhJ+
 JDCmGqU6ySxZbMQ+lH4t/FkuFk662WXPfhDfIGdZdR1BjpO0ow1kn2zlP9YKgH3g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1gk4ns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:51:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIjX8r019506;
 Wed, 14 May 2025 18:51:55 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1gk4nq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:51:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGGeYv026954;
 Wed, 14 May 2025 18:51:54 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpdwe5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:51:54 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EIproj32047756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 18:51:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 254A458055;
 Wed, 14 May 2025 18:51:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 978A65804E;
 Wed, 14 May 2025 18:51:52 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 18:51:52 +0000 (GMT)
Message-ID: <5b66880f-619c-42d5-b3c3-4ae0a152c246@linux.ibm.com>
Date: Wed, 14 May 2025 13:51:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/50] ppc/xive2: Use fair irq target search algorithm
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-9-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tuP3MCDmBo7muLaGjq28pWpWv1Ad0udd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfXy4UhOZveyiUZ
 iV2KEMUPd1PLSCNUOCSY1gvuFNHSeXqHVHhmzkg6t9Mhyq66glIAiAxNXe9i7JaXuonD1xclZhV
 oETsXOc3sVt5raiMAABCqBxMvW5xOYaB5aCdRuk2N8+40EBBB5sIPmMZvTKwGq2hHehHmgAa+Mh
 tMYyeeMwiIrFTdKM6SLatu75cbYDScnJprXLbowwEOJ+o3RJyMlYlW2rgX51mqhPo4IrVFmlo9p
 yFIuwyQ6ecIzPpsXrXGiWfsVsJ0RAxbVKUklaMdbcHtjDfF51r6JSqbMbUKy2Km45c09/QJaPtO
 4JUvYQsQO7495yKyVDZOGceCpal4eyO12YZlPX052yjiLS1drBXm0ISawzf5nl3uUEkHKD2l4zR
 GWMszpI5Tm+VTHbskH6+1yXnA114JfcSJiWLSqoD+X9fcBUJBWHVMbHjGga15GabUAav8c1M
X-Proofpoint-GUID: KIncUFzfK2LSOOF7V_UDkWRHaBzSOhpn
X-Authority-Analysis: v=2.4 cv=QOxoRhLL c=1 sm=1 tr=0 ts=6824e64b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=CnnN3ae325je8tHnKTgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140169
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> The current xive algorithm for finding a matching group vCPU
> target always uses the first vCPU found.  And, since it always
> starts the search with thread 0 of a core, thread 0 is almost
> always used to handle group interrupts.  This can lead to additional
> interrupt latency and poor performance for interrupt intensive
> work loads.
>
> Changing this to use a simple round-robin algorithm for deciding which
> thread number to use when starting a search, which leads to a more
> distributed use of threads for handling group interrupts.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> [npiggin: Also round-robin among threads, not just cores]
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 72cdf0f20c..d7ca97ecbb 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -643,13 +643,18 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>       int i, j;
>       bool gen1_tima_os =
>           xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
> +    static int next_start_core;
> +    static int next_start_thread;
> +    int start_core = next_start_core;
> +    int start_thread = next_start_thread;
>   
>       for (i = 0; i < chip->nr_cores; i++) {
> -        PnvCore *pc = chip->cores[i];
> +        PnvCore *pc = chip->cores[(i + start_core) % chip->nr_cores];
>           CPUCore *cc = CPU_CORE(pc);
>   
>           for (j = 0; j < cc->nr_threads; j++) {
> -            PowerPCCPU *cpu = pc->threads[j];
> +            /* Start search for match with different thread each call */
> +            PowerPCCPU *cpu = pc->threads[(j + start_thread) % cc->nr_threads];
>               XiveTCTX *tctx;
>               int ring;
>   
> @@ -694,6 +699,15 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>                       if (!match->tctx) {
>                           match->ring = ring;
>                           match->tctx = tctx;
> +
> +                        next_start_thread = j + start_thread + 1;
> +                        if (next_start_thread >= cc->nr_threads) {
> +                            next_start_thread = 0;
> +                            next_start_core = i + start_core + 1;
> +                            if (next_start_core >= chip->nr_cores) {
> +                                next_start_core = 0;
> +                            }
> +                        }
>                       }
>                       count++;
>                   }

