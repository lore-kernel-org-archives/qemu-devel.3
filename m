Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFF3CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXC5-0000a8-7p; Fri, 19 Jun 2026 07:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1waXBv-0000ZB-UM; Fri, 19 Jun 2026 07:15:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1waXBu-0003Cl-Bu; Fri, 19 Jun 2026 07:15:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7mP541674570; Fri, 19 Jun 2026 11:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=NoB0MsjvKONo8dUKXVrEa4M8V5PD+H
 FK5kzM5qWb45M=; b=Ui1OI25syPDyA5GCKThqhQ3YDolEK499tzdNG4A1IMk13j
 sgOPEMlO9FPjFyQ13wvm88Cqc7VTLLE2oCiA6CxH9yP5wtYld023BYWoJcdc65wt
 CzlL6aTpnT2u11lZhz4q+nxnzot/KiUsdMMF5AJqveU6zwQhBPUO2KANMBU9okM1
 K8rQdg1GAemGL0GkLTY/tZGqgFdQBkV7v30onuzqEyL6c/vrspFm5w778XSTue+1
 tCyJI3Hag0IJMSPJeLgnmLuX0GXjzPbYRP8KvwC9mxLsQBEo+UVoGXD+cgFZLoCF
 JxT/8NSVe/pJDY2xTSmevJ4niYtXWfh0aHCcJc8w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw57e6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 11:15:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JB4br0014272;
 Fri, 19 Jun 2026 11:15:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172gh1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 11:15:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65JBFDGN9503484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2026 11:15:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B8125805D;
 Fri, 19 Jun 2026 11:15:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C5B75805A;
 Fri, 19 Jun 2026 11:15:08 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.17.1])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with SMTP;
 Fri, 19 Jun 2026 11:15:07 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation);
 Fri, 19 Jun 2026 16:45:06 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, Harsh
 Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles
 <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/3] target/ppc/kvm: Use host compatibility mode for
 nested guests
In-Reply-To: <20260616113915.25589-4-amachhiw@linux.ibm.com>
References: <20260616113915.25589-1-amachhiw@linux.ibm.com>
 <20260616113915.25589-4-amachhiw@linux.ibm.com>
Date: Fri, 19 Jun 2026 16:45:06 +0530
Message-ID: <87tsqybx39.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwMCBTYWx0ZWRfX4xwcrW/VnS41
 E4MEYFKJoXp8AjeJ3OKNR2zA/rBnnuVAD3MiqZT1kpVdesMymtse7J/t6nsyEL+58p6XF7d63Yj
 9uWvg0VQW3x+a/Aok5GQVoc1Ky6Y1eU=
X-Proofpoint-GUID: 46Ds43Rfojow832oKKqE9kcIHCQh5OYB
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a3524c4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=bvJF0EKgzo6ktdy21AQA:9
X-Proofpoint-ORIG-GUID: 017bLqA3rl5V9Dg7XXvbxbWGkJXjFKVK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwMCBTYWx0ZWRfXwOFfB3lMC5yo
 zQUy9wKwDzcVVtjoENaxdQWRJbBH+9cXaI9+ljtvytC8/4El+GNNIDFE5tjYsva/Gzgn10/EfGt
 tbVBZgZNn6T35T5ptWIj/1HJ27boUd81vO1u4yb9m95BIFDHsMrqtlfAYn4M2lZglDVpZaCLSQW
 8IyNY0Grqkvs5o31Oxg3SkpTiokOPUaO1QrXHJNf03OGlI5RfQHFTvvGaiE3h9PC4bmp0iMlp27
 NhZkH8LOsb6wLWpxWvfg8R4dKKPF453KrQOhAkkcp2v5yZWBL9W2jXmZyoaRykEHZBWOML/7RnC
 D0/5GQ+TJmaDUGcikzu11YP+gRwZzlAOx7FzNBMFjty1G6sLIIt0mt7FrWiFjkFd4cJXfBCwNjt
 sdexxZigqJtRMT+twdbfeHR93asd9RRRN2RcUWrPLiEuwFgEvUIMmDhiWRMVvhN2iXFbA+Um0Hw
 EW8gquxcwhqzSR6gu4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190100
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vaibhav@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi Amit,

Thanks for the patch. My review comments inline below:

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On POWER systems, the host CPU may run in a compatibility mode (e.g.,
> a Power11 processor operating in Power10 compatibility mode). When
> running nested KVM guests, QEMU currently derives the host CPU type
> using mfpvr(), which reflects the physical processor version. This can
> result in a mismatch between the CPU model used by QEMU and the
> compatibility mode enforced by the host, leading to guest boot failures
> such as "KVM-NESTEDv2: couldn't set guest wide elements".
>
> Update kvm_ppc_get_host_cpu_class() to check if the host is running in
> a compatibility mode using kvm_ppc_host_compat_pvr(). When available,
> use the compatibility PVR instead of the raw hardware PVR when selecting
> the CPU model. This ensures that QEMU selects a CPU model consistent
> with the host compatibility mode, allowing nested guests to boot
> correctly.
>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  target/ppc/kvm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 9e5006e0c2cd..a72f237f0c8a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2672,6 +2672,15 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>      uint32_t host_pvr = mfpvr();
>      PowerPCCPUClass *pvr_pcc;
>  
> +#if defined(TARGET_PPC64)
Use CONFIG_KVM

> +    uint32_t compat_host_pvr;
> +
> +    compat_host_pvr = kvm_ppc_host_compat_pvr();
> +    if (compat_host_pvr) {
> +        host_pvr = compat_host_pvr;
> +    }
> +#endif /* TARGET_PPC64 */
> +
>      pvr_pcc = ppc_cpu_class_by_pvr(host_pvr);
>      if (pvr_pcc == NULL) {
>          pvr_pcc = ppc_cpu_class_by_pvr_mask(host_pvr);
> -- 
> 2.50.1 (Apple Git-155)
>
>

-- 
Cheers
~ Vaibhav

