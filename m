Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9142CC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDl6-0004M8-NU; Wed, 14 May 2025 11:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD8t-0007PQ-Iy; Wed, 14 May 2025 10:31:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD8m-0006eT-OO; Wed, 14 May 2025 10:31:31 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9F158012727;
 Wed, 14 May 2025 14:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rzv9mh
 wyyICrVAz5ILkPpDtcuMJH4j4/cxmpoZHPEB0=; b=dkbExenOU5BwnqLp/8jXr7
 AKy06HlvM34rT2J0+No4Ex9qly1ONDvr+Gkm2C2b78WoUg1rgzwBlO7C0woJ2Ewc
 tr0qj870EasecuXCezezNvWgpxOM+vVAqgUShGbz/m/rnNJYX4RIvGhc3oUPZvvF
 R6TeQZZfY0IST0QL8wXD+bn8F/qhAPEB1veMGKJeXCRdKrcDWImwqV+UGyh9zsF2
 kOGxvUf/FXT/bFYSxoNT920tSFEkh/J2v5Fsymvw/XelKH1AMIIKWEMYTZgikt2V
 CdpphlTK8AZa3jVApcJoM3ci42Tnar+wIzIo5Cw9WjIAJP2T2nU/S9XRygz4KZdg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcj9hm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:31:22 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EE4nTj003892;
 Wed, 14 May 2025 14:31:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcj9hm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:31:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDPJlR024309;
 Wed, 14 May 2025 14:31:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs4ncd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:31:21 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEVGS830999192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:31:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DBBE58064;
 Wed, 14 May 2025 14:31:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EAD058052;
 Wed, 14 May 2025 14:31:19 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:31:19 +0000 (GMT)
Message-ID: <921ffadd-502e-4fd9-b7c8-fe977cda52a3@linux.ibm.com>
Date: Wed, 14 May 2025 09:31:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/50] ppc/xive2: Use fair irq target search algorithm
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-9-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=6824a93a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=jthM4rBR-rtT7kyaBgcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cosKkqi0aeTqkrbBm0CbKKgxHAmGu3fh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyNSBTYWx0ZWRfX2sxlU9vbA0jL
 BZKCUtoMWGqMp24odikW6VEDO8TmxkzmCSc6QabcTH7CaMa3TUw6QdCY8Z+n9iITI5HXWkKuuMI
 M949mVHvoQodlbLpfQ4I+A0kvN4eQ0c8xwIzfSevCWXxBJohyM8dRT5d1fkiNsIaYdwAUO57pFm
 Ykvp/WSTyFysxHL9fJFj5Cy0HMUSsYXCkD1rRgFgyCpX5cPIN4kKcjgK457rdau1LPaeTbY8JFx
 cLrG6RcrhxJuX45kHgVdGfluiufs+gsLebxyAUpeeh+3BR/eYkE13s9Tzt+L08Kl9U1CYVerTlg
 r3GXfy5nAihJ3FPKpDugysohar4094YF4j3rPkYZaZ3UMxObNwCGci+l/vOwYbPJGHRySh049Bj
 +Vmv2cQdX9cjw1hy1Us/HHEmA3X7HbFquVUDR0MxxXQ7gjueu0S2vRovjmvqXHcWAeHqa1MF
X-Proofpoint-GUID: zUQYOLqicrSrxfghH7RoIRQFtcwtUGBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
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
X-Mailman-Approved-At: Wed, 14 May 2025 11:10:34 -0400
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

Looks good.

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 5/11/25 10:10 PM, Nicholas Piggin wrote:
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
> 
> [npiggin: Also round-robin among threads, not just cores]
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 72cdf0f20c..d7ca97ecbb 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -643,13 +643,18 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>      int i, j;
>      bool gen1_tima_os =
>          xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
> +    static int next_start_core;
> +    static int next_start_thread;
> +    int start_core = next_start_core;
> +    int start_thread = next_start_thread;
> 
>      for (i = 0; i < chip->nr_cores; i++) {
> -        PnvCore *pc = chip->cores[i];
> +        PnvCore *pc = chip->cores[(i + start_core) % chip->nr_cores];
>          CPUCore *cc = CPU_CORE(pc);
> 
>          for (j = 0; j < cc->nr_threads; j++) {
> -            PowerPCCPU *cpu = pc->threads[j];
> +            /* Start search for match with different thread each call */
> +            PowerPCCPU *cpu = pc->threads[(j + start_thread) % cc->nr_threads];
>              XiveTCTX *tctx;
>              int ring;
> 
> @@ -694,6 +699,15 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>                      if (!match->tctx) {
>                          match->ring = ring;
>                          match->tctx = tctx;
> +
> +                        next_start_thread = j + start_thread + 1;
> +                        if (next_start_thread >= cc->nr_threads) {
> +                            next_start_thread = 0;
> +                            next_start_core = i + start_core + 1;
> +                            if (next_start_core >= chip->nr_cores) {
> +                                next_start_core = 0;
> +                            }
> +                        }
>                      }
>                      count++;
>                  }


