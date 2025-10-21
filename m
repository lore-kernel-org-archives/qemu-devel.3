Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14C5CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 11:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBAfk-0003nx-1d; Tue, 21 Oct 2025 07:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vBAfb-0003mz-4n; Tue, 21 Oct 2025 07:36:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vBAfX-0008V6-Am; Tue, 21 Oct 2025 07:36:50 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L1wCNs023518;
 Tue, 21 Oct 2025 11:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qcZU/p
 N2tuV/PgXpaqeha0Av0//BrntA0yr7jG0T988=; b=aqoLqVmm2++SYMhgCXXtZC
 tzlYEP5sGUrv1l8TA5hZgs+uGmb1en5qbgBtvp0zI7gS77J9ubdjk6J9JtXDI5fY
 iVRdonBI1WsEUbUiDC+6tEx/XIy53aEuZHpvsNYcBaioWWO2jr68ey/NA1d2yqnO
 28ktreXHO5OI7w+qoPzslANhyB8RCfoYuUClWc4dgYmmElJ6+imo3wBE3PeyMz9M
 evX0Ui11enT2F2OWnqwJcwuKkNGxTYARAv6MaAKidPzE+6mIh3bxnD2k1wNVlGfQ
 US3EchpFSNm0s6N26IpQawFyGSvXp50FdtKX3FmbGTd4bAinX6CEWt+5/yPFFQ7g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vncbw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 11:36:38 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LBWdM1005627;
 Tue, 21 Oct 2025 11:36:38 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vncbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 11:36:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LAqrok014650;
 Tue, 21 Oct 2025 11:36:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s2nfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 11:36:37 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LBaa0T10945382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 11:36:36 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3D245805C;
 Tue, 21 Oct 2025 11:36:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1988558093;
 Tue, 21 Oct 2025 11:36:34 +0000 (GMT)
Received: from [9.79.201.141] (unknown [9.79.201.141])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 21 Oct 2025 11:36:33 +0000 (GMT)
Message-ID: <e9cd32c2-7e38-4d7f-aa97-138d53eb530d@linux.ibm.com>
Date: Tue, 21 Oct 2025 17:06:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] target/ppc/kvm: Remove kvmppc_get_host_serial()
 as unused
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251021084346.73671-1-philmd@linaro.org>
 <20251021084346.73671-7-philmd@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20251021084346.73671-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BE7zzDZZhZ4KivfZNgIXzhbg18U3mJqQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7h2PyKMBnTfe
 rzyha/HZTJaKYbxtufID4zk0PGomNqAZ5Wpb51fHIV4YBpNWPZUHOZPrVAQX48x4f/+DvuTb4BM
 hQFCXxWZr9xuM/B07g2KNSTryAG2Aqwj5NP8KVx95xfufVEuEYNP1SuK0oHTqVHgEEah0MzP0Vr
 jtN4dLmLUKrGvO7MliJhztcPJwHmNpXBxnux4V2FkqbLbh7H0RlDqGw2DD3WjRdz0b8uYxD9OOx
 WZfBUkiD6FvL21hZTHSKJjZ3kvJR6cI3TDiqW6KCENlnbKJ0dLH1R01Csk+NoM9LN6PVSaBvuCB
 Y7GlvtDzPoYpdwmwNbYfXNiD7yITVBk21hMluupNILN4/GMXAnUGvWUQPFNMiDbS8sgj9yEsnnz
 K6VpqBLmZum6Ac6ZnZojZC77RJ5qHQ==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f77046 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=cvRlsbrwNaNk8C4OaOUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: sjzkwcplo6_88gfInGQk4ReUpLT_v9uY
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
>   target/ppc/kvm.c     | 6 ------
>   2 files changed, 12 deletions(-)
>
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index a1d9ce9f9aa..f24cc4de3c2 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -22,7 +22,6 @@
>   uint32_t kvmppc_get_tbfreq(void);
>   uint64_t kvmppc_get_clockfreq(void);
>   bool kvmppc_get_host_model(char **buf);
> -bool kvmppc_get_host_serial(char **buf);
>   int kvmppc_get_hasidle(CPUPPCState *env);
>   int kvmppc_get_hypercall(CPUPPCState *env, uint8_t *buf, int buf_len);
>   int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level);
> @@ -134,11 +133,6 @@ static inline bool kvmppc_get_host_model(char **buf)
>       return false;
>   }
>   
> -static inline bool kvmppc_get_host_serial(char **buf)
> -{
> -    return false;
> -}
> -
>   static inline uint64_t kvmppc_get_clockfreq(void)
>   {
>       return 0;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index cd60893a17d..cb61e99f9d4 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1864,12 +1864,6 @@ uint32_t kvmppc_get_tbfreq(void)
>       return cached_tbfreq;
>   }
>   
> -bool kvmppc_get_host_serial(char **value)
> -{
> -    return g_file_get_contents("/proc/device-tree/system-id", value, NULL,
> -                               NULL);
> -}
> -
>   bool kvmppc_get_host_model(char **value)
>   {
>       return g_file_get_contents("/proc/device-tree/model", value, NULL, NULL);
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>

