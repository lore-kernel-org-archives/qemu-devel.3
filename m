Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A02CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 17:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2vZE-0004ht-OY; Sun, 28 Sep 2025 13:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2vZB-0004hU-O4; Sun, 28 Sep 2025 13:52:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2vYz-00013p-9g; Sun, 28 Sep 2025 13:52:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SHdKTE024982;
 Sun, 28 Sep 2025 17:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wjkaVt
 6+4nB2VK/Xd/UQKnWoN67KIBBsS2HSe77Eomg=; b=I0/SUqHEv65IuONcCZrnm7
 26WqvOoIkUQAkn9MrseBtJ2G+qdhl59N1hySO0XcLl0NeY+GcSEuj5UeAbUxuVgv
 qU/lHfwf4J/UdpsjE1EpFE4jLjG4BGttEfxCh7rWJfrC8Th/hHX+ohTX4KQlNSRY
 eXMbLyNBU+xH9MrknY+JbvxpYFk51b0iN5wOzRrRFL+QWDNYs3dLOh04R2s4gXtR
 0ak0GNCoOomiK0fthI63OmKTiLxUXh1y285W5w7Je6hXyMJ6T29PefVY7oQ5Ja/i
 1kE0c5YaoMmUdeM31fBKbmDiZVUTCZndVNp2nbPInHTYwPhiRpXeOHDESfuJhS/g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh6exy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 17:51:41 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58SHpeKS013800;
 Sun, 28 Sep 2025 17:51:40 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh6exw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 17:51:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SEpQZJ024163;
 Sun, 28 Sep 2025 17:51:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy0t8b4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 17:51:39 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SHpbS765601896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 17:51:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6AEC58056;
 Sun, 28 Sep 2025 17:51:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B84458052;
 Sun, 28 Sep 2025 17:51:35 +0000 (GMT)
Received: from [9.39.17.115] (unknown [9.39.17.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 17:51:34 +0000 (GMT)
Message-ID: <f023d7c8-1556-448b-8cf6-1ee1cc2f7b50@linux.ibm.com>
Date: Sun, 28 Sep 2025 23:21:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] hw/ppc: Support for an IBM PPE42 CPU decrementer
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com, thuth@redhat.com, 
 rathc@linux.ibm.com, richard.henderson@linaro.org
References: <20250925201758.652077-1-milesg@linux.ibm.com>
 <20250925201758.652077-8-milesg@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250925201758.652077-8-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68d975ad cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8
 a=0JqFtU6wa0VZc3-cCmoA:9 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfXwpHcffc4pZsj
 tgEytoyG4d1s8HvO+HZ8tuwzeVXMTc7/umWHnWweq5J4RDhYT7E+G0WUvwjK3WsZmlWhOoLi0ZH
 cbDiGeiHTOVBfs6dcW7W14cbadUZRc6E4upBL9WjOCF6pElXlt2AK96lM0ul7Hn5jxjRMZ5eiXw
 tYAcU6QRsXdzzVYREkTeQHF4IzGvLMzRq4TreitydcOvU5lL1sRnP6EJImXYI5ezEDCoRApF38K
 NY7TNRz0Kv1M5z2q2+m71QpbNEssDPXE7GqW1Rg1MTpgzcJfL36g3NyiJB9pjc55LiaBAekXAQv
 CaDkKYo3NUk0m9nY8Phd2gjVU2PajgKcw/ZrCdRde4havPgK77Qag84/l3jMLy0i1TR3pPvJGru
 b48nfu677yMcCIE9IEIxdIqodmW1Eg==
X-Proofpoint-GUID: nF-xNn-XXcqB_VXgztSRmW2_VMMMv0Xj
X-Proofpoint-ORIG-GUID: O3CUV2bYdgKNvc5e90r6PPr0tp9IQWlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_07,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/26/25 01:47, Glenn Miles wrote:
> The IBM PPE42 processors support a 32-bit decrementer
> that can raise an external interrupt when DEC[0]
> transitions from a 0 to a 1 (a non-negative value to a

I guess it was meant to be 0 to -1 (0xffffffff)?
No need to re-spin just for that though.

> negative value).  It also continues decrementing
> even after this condition is met.
> 
> The BookE timer is slightly different in that it
> raises an interrupt when the DEC value reaches 0
> and stops decrementing at that point.
> 
> Support a PPE42 version of the BookE timer by
> adding a new PPC_TIMER_PPE flag that has the timer
> code look for the transition from a non-negative value
> to a negative value and allows the value to
> continue decrementing.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/ppc/ppc_booke.c   | 7 ++++++-
>   include/hw/ppc/ppc.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
> index 3872ae2822..13403a56b1 100644
> --- a/hw/ppc/ppc_booke.c
> +++ b/hw/ppc/ppc_booke.c
> @@ -352,7 +352,12 @@ void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flags)
>       booke_timer = g_new0(booke_timer_t, 1);
>   
>       cpu->env.tb_env = tb_env;
> -    tb_env->flags = flags | PPC_TIMER_BOOKE | PPC_DECR_ZERO_TRIGGERED;
> +    if (flags & PPC_TIMER_PPE) {
> +        /* PPE's use a modified version of the booke behavior */
> +        tb_env->flags = flags | PPC_DECR_UNDERFLOW_TRIGGERED;
> +    } else {
> +        tb_env->flags = flags | PPC_TIMER_BOOKE | PPC_DECR_ZERO_TRIGGERED;
> +    }
>   
>       tb_env->tb_freq    = freq;
>       tb_env->decr_freq  = freq;
> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
> index 8a14d623f8..cb51d704c6 100644
> --- a/include/hw/ppc/ppc.h
> +++ b/include/hw/ppc/ppc.h
> @@ -52,6 +52,7 @@ struct ppc_tb_t {
>   #define PPC_DECR_UNDERFLOW_LEVEL     (1 << 4) /* Decr interrupt active when
>                                                  * the most significant bit is 1.
>                                                  */
> +#define PPC_TIMER_PPE                (1 << 5) /* Enable PPE support */
>   
>   uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset);
>   void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq);

