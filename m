Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3345D1D89F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR60a-0007x6-Ll; Thu, 04 Dec 2025 04:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vR60T-0007wU-41; Thu, 04 Dec 2025 04:52:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vR60R-0006ur-D3; Thu, 04 Dec 2025 04:52:12 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B411Cc1020119;
 Thu, 4 Dec 2025 09:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zmxF3/
 DP1IQrzzwdBMIgMxlVlzfhSXqo+7j42U4/G00=; b=r4/Vt3GKB6fRiO9HjtmYyq
 KtWANXfZxiydeNwg+jSkE9cKc6wMwEHsHHOnhoNossHg8hiWoZyglgjrmdKUr0lX
 ZFMA1lTvkiJpaP0cTwrdHOuWJ+mYbEcKc7X9ZOSC2gkcYtn/ZPoJubUR9LIikmup
 6LKUkteXdT0lhwtH8/Ucdgr5lk1ItG4CcQp37e4Xrmy12HTkmjvLOHdntWvJZW9Y
 myaAuImF+GfHvL6Dp3xpeidZ4lZXjyCfbqm+rivYJ6OzU2lNWPC5mVZkqHdHieaV
 /yCfjSmf0lVj2oBa5R8PKwS4lSWu941yuawbKgZGr00tINA/QEeEgzqfjNYxY3tg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8q785u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Dec 2025 09:52:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B49o2qD012391;
 Thu, 4 Dec 2025 09:52:08 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8q785s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Dec 2025 09:52:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B48Tjmr003857;
 Thu, 4 Dec 2025 09:52:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardcjxu0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Dec 2025 09:52:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B49q6oZ25887476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Dec 2025 09:52:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65A3658053;
 Thu,  4 Dec 2025 09:52:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8488658061;
 Thu,  4 Dec 2025 09:52:03 +0000 (GMT)
Received: from [9.79.201.141] (unknown [9.79.201.141])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  4 Dec 2025 09:52:03 +0000 (GMT)
Message-ID: <23721641-d08d-4e1c-8fc2-8c0f16f82b1f@linux.ibm.com>
Date: Thu, 4 Dec 2025 15:22:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/kvm : Use macro names instead of hardcoded
 constants as return values
To: Gautam Menghani <gautam@linux.ibm.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, pbonzini@redhat.com, sjitindarsingh@gmail.com
Cc: qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20251202124654.11481-1-gautam@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20251202124654.11481-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX3Zo8A80o9QD8
 xLUoYpetH8x6kPGBPbCXJ1faFKZ1C7KFgmCdCH5e09P/S4EVKt8W8QxB3fb61FdoNz9AMVvw3OL
 JfVqzMNfnkljSXZJ7b1SO7Qe1OY39UvjBEPjLfc/y9/2FSgGDFFvKu+5AoGcAhofz6gUx9k4p6S
 H7PSyGNlT/qa2A42v4QpX11LwY+6w7hVbvImjhHc+L7bfbqvRTdL2D2HCtBY+JpzV38zy3TeMtv
 WWHcesfDOJSdpHkT252rdbJpcXuygJmFgIJFPzlCt2lZXKgv2hS0Rqf/p6l1/hfZ1HPJ7Qq+iD2
 n73QYXCcMDXYp7OwEimdBsaBtacu3dKheYidsXkHDBdEGdFFOuc3DHpXzi7U/NKw+OwFYLDK1ny
 kT7+9YxfpmUBtHjehhyrIA1g7Q9CWw==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=693159c8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=uOFx0X2q0oB2CtcaZQEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P444gTh1akQPUw3NrLTQa33jLUo5XqGb
X-Proofpoint-GUID: oyPRJJMIJ8COq1WCb2W0JNhBtluK8aVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000
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


On 12/2/25 18:16, Gautam Menghani wrote:
> In the parse_* functions used to parse the return values of
> KVM_PPC_GET_CPU_CHAR ioctl, the return values are hardcoded as numbers.
> Use the macro names for better readability. No functional change
> intended.
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
>   target/ppc/kvm.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 43124bf1c7..464240d911 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2450,26 +2450,26 @@ static int parse_cap_ppc_safe_cache(struct kvm_ppc_cpu_char c)
>       bool l1d_thread_priv_req = !kvmppc_power8_host();
>   
>       if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_L1D_FLUSH_PR) {
> -        return 2;
> +        return SPAPR_CAP_FIXED;
>       } else if ((!l1d_thread_priv_req ||
>                   c.character & c.character_mask & H_CPU_CHAR_L1D_THREAD_PRIV) &&
>                  (c.character & c.character_mask
>                   & (H_CPU_CHAR_L1D_FLUSH_ORI30 | H_CPU_CHAR_L1D_FLUSH_TRIG2))) {
> -        return 1;
> +        return SPAPR_CAP_WORKAROUND;
>       }
>   
> -    return 0;
> +    return SPAPR_CAP_BROKEN;
>   }
>   
>   static int parse_cap_ppc_safe_bounds_check(struct kvm_ppc_cpu_char c)
>   {
>       if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR) {
> -        return 2;
> +        return SPAPR_CAP_FIXED;
>       } else if (c.character & c.character_mask & H_CPU_CHAR_SPEC_BAR_ORI31) {
> -        return 1;
> +        return SPAPR_CAP_WORKAROUND;
>       }
>   
> -    return 0;
> +    return SPAPR_CAP_BROKEN;
>   }
>   
>   static int parse_cap_ppc_safe_indirect_branch(struct kvm_ppc_cpu_char c)
> @@ -2486,15 +2486,15 @@ static int parse_cap_ppc_safe_indirect_branch(struct kvm_ppc_cpu_char c)
>           return SPAPR_CAP_FIXED_IBS;
>       }
>   
> -    return 0;
> +    return SPAPR_CAP_BROKEN;
>   }
>   
>   static int parse_cap_ppc_count_cache_flush_assist(struct kvm_ppc_cpu_char c)
>   {
>       if (c.character & c.character_mask & H_CPU_CHAR_BCCTR_FLUSH_ASSIST) {
> -        return 1;
> +        return SPAPR_CAP_WORKAROUND;
>       }
> -    return 0;
> +    return SPAPR_CAP_BROKEN;
>   }
>   
>   bool kvmppc_has_cap_xive(void)

