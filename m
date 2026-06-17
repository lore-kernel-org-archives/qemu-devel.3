Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A162CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZvDZ-0007gl-85; Wed, 17 Jun 2026 14:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wZvDW-0007dN-OF; Wed, 17 Jun 2026 14:42:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wZvDV-0005Th-6o; Wed, 17 Jun 2026 14:42:26 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHmHRS1000321; Wed, 17 Jun 2026 18:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aHXiiX
 bMi1oqrJ+CZCWO7ghKEBRQBzuo+E6t6xG8/YA=; b=sYMcg1iFq59za3Rcu0A1l/
 KawGLAyofhxcKM1Ab2ip7fFF+VVXfcPUDBpTMgiSZtXEtLIyxQa04iMPXFsUMWgR
 igNfhr0CYmW2QNNhCIrT9rWTWvkn+tci4nzdKxHuMsjKwk1spK3GoQch2LR6M5sv
 rriBHqkUHYx8KTBF5JHb1vmKPMsQ2NzNVIe6hIZbUvOaeYpBsY1gWw+0jF2FwaNb
 hMxlFWRR95qOU/DBGpIysOedf5QzHbbnSetLrAf5EVTsm7/PbXVD3uwRYFrBKRI/
 xY5FCAE/MoWQym4lKMJnMREFxL4ftmfTkPn7KPO86G5zhUo9MShULEkrGEmkD4vQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx4f3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 18:42:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HIYb1P015419;
 Wed, 17 Jun 2026 18:42:21 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva4m7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 18:42:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65HIgJMZ57868756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 18:42:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36A1758052;
 Wed, 17 Jun 2026 18:42:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 687F158056;
 Wed, 17 Jun 2026 18:42:18 +0000 (GMT)
Received: from [9.61.108.75] (unknown [9.61.108.75])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 17 Jun 2026 18:42:18 +0000 (GMT)
Message-ID: <c5935381-f680-43c9-b01b-a0378f4fb67b@linux.ibm.com>
Date: Wed, 17 Jun 2026 14:42:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] hw/s390x/ipl: Remove TCG dependency in
 handle_diag_308()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260617164035.70788-1-philmd@oss.qualcomm.com>
 <20260617164035.70788-4-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260617164035.70788-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE3NyBTYWx0ZWRfXzmE84v6dy/yI
 XJ2bcbZ4jc5sHx9WVHjkEdNoDrvdHIHlPWVHxQEu+HrrhMqLHJNpLRteqfcmIuDMUmLpqpRQIsI
 YAWAlBtEtTo0SZ3CWdQFRJFGAb6g/G6UBIMDlkUF4rtziTCz47W6Uh483q37X7cI9uCen6T0Tlq
 ewP2fvfhHT9IdlnIw1AXVtTfCgqhQ34CC8vDU6p+7NLy3YZMrONaRej4JhpsWh/mQBmhxer1GqK
 DLe/w8rBNCEteGroc2G7oiVkl/shYR0K8VcScxSZLx93TU/8ucGvn4neeMrCTfxcb9VFvio3+hh
 g1V09Dtd+86Qj4ZGY9ofgXr92BuSXkBhuoJOEfYqduyoDdpMu54WKGxH14XMZCJa2e/r8OF0LPz
 UEyF09IMTT5R8MiXhDFHSlL0Wlcgnha8N9u0vfuwVxWfYoRRvYkQasg4n5/Xx+9/+hs6jl0oohm
 T1w19NYViqrl/f5Ub3Q==
X-Proofpoint-GUID: Fnzq_EbwSJ3bSOWSvll42oMRKQkz0HB1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE3NyBTYWx0ZWRfX/Lkoq3XM9xyn
 Bo6JMiAJ2bxw8tYLfeNbPWBxbuBLl/ytOijb9L8/Xev/0L4BgXlm032pvZtprP1p0Y3qycQHqO3
 meocBA1tmwMLYhhQQTVZxDdUrDhfv4I=
X-Proofpoint-ORIG-GUID: Fnzq_EbwSJ3bSOWSvll42oMRKQkz0HB1
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a32ea8d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=w7XQVQow14MHo6KoLCoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170177
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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


On 6/17/26 12:40 PM, Philippe Mathieu-Daudé wrote:
> Rather than calling a TCG specific method in s390_ipl_reset_request(),
> have handle_diag_308() return whether a vCPU reset is pending, and use
> that in the TCG DIAG helper to return to the main loop.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/s390x/s390x-internal.h  |  3 ++-
>   hw/s390x/ipl.c                 |  5 -----
>   target/s390x/diag.c            | 32 ++++++++++++++++----------------
>   target/s390x/tcg/misc_helper.c |  5 ++++-
>   4 files changed, 22 insertions(+), 23 deletions(-)
>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

