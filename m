Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805D9CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 11:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBAiD-0004ml-VP; Tue, 21 Oct 2025 07:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vBAi7-0004mB-Ku; Tue, 21 Oct 2025 07:39:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vBAi2-0000FA-EZ; Tue, 21 Oct 2025 07:39:26 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KMn6ew017502;
 Tue, 21 Oct 2025 11:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ObN/jW
 yz7jZQNGrgvSTAzT/wTutn7xnYw0hdm2qBObw=; b=U5rLIf7iLlvnPRY5oSGNIX
 LzZlhQrPq7jsg5rDOoenwaKAGmn4Zth5nTV7jRNcstdtEyOiLK2nYgausHjV7SGj
 G/+fg3xrq+q+dO4dV/HJvvUzg/ZheX/XMO4ABf+pG/FDfltrbyu8ZIaFr+qiD37B
 /MvuNqMCLFfatiSdUopeRYUtYGo9vT52WvNn4UhcnHcTCCa8Hp4ZW3HB3obaPoKE
 EfzZD5QMJnysIIbsgFN6uUQuy8RFx041o89iq0aUqrRQOhJ+w2KjatioVRljiX3t
 9BNUWQ1C6ICap+UHgjgPAuSHFs1n03xHEs2GAG/l1nYm5tfWSDGh2oZ/A9fFbdIw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vncp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 11:39:18 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LBbfiv018048;
 Tue, 21 Oct 2025 11:39:17 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vncp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 11:39:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8x7uO011049;
 Tue, 21 Oct 2025 11:39:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx126eg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 11:39:17 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LBdGLm31588914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 11:39:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 997555805A;
 Tue, 21 Oct 2025 11:39:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C828258051;
 Tue, 21 Oct 2025 11:39:13 +0000 (GMT)
Received: from [9.79.201.141] (unknown [9.79.201.141])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 21 Oct 2025 11:39:13 +0000 (GMT)
Message-ID: <028fdb03-7bee-4a76-932e-a9247db2f2ac@linux.ibm.com>
Date: Tue, 21 Oct 2025 17:09:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] target/ppc/kvm: Remove kvmppc_get_host_model()
 as unused
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251021084346.73671-1-philmd@linaro.org>
 <20251021084346.73671-8-philmd@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20251021084346.73671-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OVF4HSMUdKU4xD4M7yuaZHQSyX2ecGbI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX4vncOItRNi2d
 CaKERxfIYEBxGH+vspKGf1Eogx7Op4/isnCS+wwyiDnTF6zQkf93qMvY17aB0FGMfl1VK6UnATQ
 FMfSkCbB/NGl0amXqf5WHat5pbSrZrZTfgjhHzXVSrV1abaaVD6GYMBLEGdr5Lf32BuzRYq2J9H
 LmtsugNBPcymXRk2GwHlc4UCQA4JXRAKGFs66Ipkd4dFbIL6VIrIDmjB6Picua7ughWzfSbwt35
 C3NHw62EMbMKojT3+LTr5KoVjJdd9Q1t2MkDQt2StV7dhigK3bX0SwvUPe18r6aAA313CnUMMQy
 c+QwECZz0SFWg6NMZQrEx+I5gLqQX+GCSUrDhgvjgIEJ7tnFwXK4+QMr7dxtUmuad76ttTzhBSY
 c2609UvahKWtf4RANW5HOk90Plxzbw==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f770e6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=cvRlsbrwNaNk8C4OaOUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: VFnuAz9LCY3QvhfgGYR41l5ntqgq0HH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
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


On 10/21/25 14:13, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/kvm_ppc.h | 6 ------
>   target/ppc/kvm.c     | 5 -----
>   2 files changed, 11 deletions(-)
>
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index f24cc4de3c2..742881231e1 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -21,7 +21,6 @@
>   
>   uint32_t kvmppc_get_tbfreq(void);
>   uint64_t kvmppc_get_clockfreq(void);
> -bool kvmppc_get_host_model(char **buf);
>   int kvmppc_get_hasidle(CPUPPCState *env);
>   int kvmppc_get_hypercall(CPUPPCState *env, uint8_t *buf, int buf_len);
>   int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level);
> @@ -128,11 +127,6 @@ static inline uint32_t kvmppc_get_tbfreq(void)
>       return 0;
>   }
>   
> -static inline bool kvmppc_get_host_model(char **buf)
> -{
> -    return false;
> -}
> -
>   static inline uint64_t kvmppc_get_clockfreq(void)
>   {
>       return 0;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index cb61e99f9d4..43124bf1c78 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1864,11 +1864,6 @@ uint32_t kvmppc_get_tbfreq(void)
>       return cached_tbfreq;
>   }
>   
> -bool kvmppc_get_host_model(char **value)
> -{
> -    return g_file_get_contents("/proc/device-tree/model", value, NULL, NULL);
> -}
> -
>   /* Try to find a device tree node for a CPU with clock-frequency property */
>   static int kvmppc_find_cpu_dt(char *buf, int buf_len)
>   {
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>

