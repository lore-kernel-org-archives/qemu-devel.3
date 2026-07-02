Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7E3C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 03:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf8P4-0000Vt-Gd; Wed, 01 Jul 2026 23:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf8P2-0000Vc-TM; Wed, 01 Jul 2026 23:47:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf8P1-0001gQ-7Z; Wed, 01 Jul 2026 23:47:52 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KE1J2509418; Thu, 2 Jul 2026 03:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=awUpeg
 2K5uBcEmjPNETdW1oyLe6L4WQNKu1kPomGLsM=; b=Aidt5PBNX2EHxaUJlaBA7T
 ErmC+IFMtowz53hEmAqBiSavq0qkh1Bg+1gpTm3AyvHBvnoovGRAtj3zaOy/Vd6u
 rYO7vK1Q+ObpaP7FuE0TezGRp3XUZzr5rDjnDG9LyUFFyRrGltnznGaa7IIFGVtw
 EsGCb2p2QdOhPHdvRTjYjE3JY6StycYhPIHuX4QUGgbXE4nPl2J0AxXIbTF7Dc6j
 X9xzwm9WJltAesbXy2iGvL2ihSgpwppu/7iti8NyDqN4/NVx7Yw04xfZxW9zQ5zs
 ZPS04xTQQLKoxWlNTBh7by5CuBCS7Fd1LAf1Iuye0xAk8LiBf2bM0ZNp0Ul8z54g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe80f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:47:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6623YggV020804;
 Thu, 2 Jul 2026 03:47:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wac8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:47:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6623liCl24249064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 03:47:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E86A58057;
 Thu,  2 Jul 2026 03:47:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 188FD58059;
 Thu,  2 Jul 2026 03:47:43 +0000 (GMT)
Received: from [9.61.143.111] (unknown [9.61.143.111])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2026 03:47:43 +0000 (GMT)
Message-ID: <7a9aead0-32ed-4672-8526-bbaf6a96901c@linux.ibm.com>
Date: Wed, 1 Jul 2026 23:47:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 32/35] s390x/ipl: re-apply secure boot flags on DIAG
 308 reboot
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-33-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-33-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cqk6qV2hESFVIaTcnTSmbSk3cik3OU65
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAzMCBTYWx0ZWRfX63AANq/STP0D
 1N5AfA8s6FLDCJVSakPDmMjcVn9jr4gdytFr9iQF7u2iS6IjeyOlRxIIUIcKCU0H/iWPw+LWi9a
 lhPIsKe96QYL/F2o7sGR1tZ6filO1dU=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a45df63 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=wVf7Z-aBrM6DQMQhJy0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAzMCBTYWx0ZWRfX8zZL1Z6lul6R
 z2KHo5CNTscYCdPVsWEk8TiBJaiYzhRolrteUV4QtGFP2EIe+w8X4C7Oxe3RhIo9XOowgoXUIlm
 Vvd06fuBJM+b6sc90dMGcxs/XG94N/F0ANNTTWUK4ESqmHiE86zPQQjQdl88y4MAMqmuYZcq36N
 dSWoMC7cbGGqocxlzrmkdQiKHyy0E7N2Yvv/LTbLk+/FTKDF7kHWnt0xN4kzeAjdM9zZMiqsnc/
 93PF5OiHreDIRRte5BGciL7d33yU5zV2+mVWqEGqq0lnMTW3B4MVTQfdrJg77w6q2OiOhpvEX26
 WGrCaDQSeeti1tdcnYRI4YH8CYC0rutK+RfmSmjMyN03KtAEHr2mBYHpZ6MnBKwjmPIz7Z8E3wr
 IbDZgm3MMh+mECZky9kKHP23dj53GutnTC86sKTK72ZgmdJgX1Ac6KaknBYGmNY8f3dqCVydTjg
 5BzaUV66OLqUOOoq6BQ==
X-Proofpoint-ORIG-GUID: Cqk6qV2hESFVIaTcnTSmbSk3cik3OU65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020030
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 7/1/26 4:49 PM, Zhuoying Cai wrote:
> The Linux kernel does not preserve hdr_flags in the IPLB across a
> reboot, causing secure IPL flags to be lost on re-IPL.
>
> Set secure IPL flasg from s390_ipl_update_diag308() to restore the
s/flasg/flags

> flags from the current machine configuration.  Device validation is
> skipped here as it was already enforced during initial boot.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/s390x/ipl.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index f4e01b6918..f970b34126 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -737,6 +737,14 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
>       } else {
>           ipl->iplb = *iplb;
>           ipl->iplb_valid = true;
> +
> +        /*
> +         * The kernel does not preserve secure boot flags across a reboot.
> +         * Re-apply them here based on the current machine configuration.
> +         */
> +        s390_set_secure_boot_flags(&ipl->iplb,
> +                                   s390_secure_boot_enabled(),
> +                                   s390_has_certificate());
>       }
>   
>       update_machine_ipl_properties(iplb);
Can this be included with the initial implementation of true secure IPL, 
or maybe even earlier with audit?  I can't imagine any scenario where 
secure IPL is intended to be cleared on reboot, so adding this as a 
later feature doesn't seem to make sense.

Regards,
Jared Rossi

