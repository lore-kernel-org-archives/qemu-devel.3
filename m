Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842DACAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 20:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzLOS-0005Qo-Dm; Thu, 18 Sep 2025 16:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uzLOQ-0005Q7-IZ; Thu, 18 Sep 2025 16:38:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uzLOO-0005hg-5e; Thu, 18 Sep 2025 16:38:14 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IICND5006031;
 Thu, 18 Sep 2025 20:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AoAzgz
 vUhbPHmOq8WCnfvhroWVXY3sPLad7q5aqHJsg=; b=P2myOEI3ycuR+X6jUPre0n
 9cpYeg/caTDV7WGnWcTv4gFi+2BwCHhtYdxb4AidomCb5sTfUz6tY3esZldlzN+Y
 yVG40Ga8vyHPyNM5j885Q0olffOpY3TMdEr59wjWMSQyzUSPjoA5xhCK+7+dZaTH
 0ZZcO5uCGzhcKljDMrSQw+bc1pt7OY2Mu/yNGQ9OYoJw5ez6/iLbDx2jxBItsFDp
 mJKcPNj1tOt/I8S90v3xUJW/UfHlfVKop/WCFNqe1yRKDKqpdMUEpNoAKbE5m3mb
 o3c4E4pweNg0ebm96NMH1/2HwEbgxu9384YOGfGErj0ciLEl9w4mK8FWGzQudMOg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4nm7pm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 20:38:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IHgn2o018629;
 Thu, 18 Sep 2025 20:38:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mrfgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 20:38:09 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58IKc7gr66519402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 20:38:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD94B58045;
 Thu, 18 Sep 2025 20:38:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 235E158056;
 Thu, 18 Sep 2025 20:38:06 +0000 (GMT)
Received: from [9.61.251.145] (unknown [9.61.251.145])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 20:38:06 +0000 (GMT)
Message-ID: <4c1fdfac-d366-40f0-b580-a341ff583e63@linux.ibm.com>
Date: Thu, 18 Sep 2025 13:38:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/28] s390x/diag: Refactor address validation check
 from diag308_parm_check
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-7-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250917232131.495848-7-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cc6db2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=XA1qvbxqqnLpSlYgOKIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QGKCAb7NefZPkCsea0SMOaftE5ROrjPR
X-Proofpoint-ORIG-GUID: QGKCAb7NefZPkCsea0SMOaftE5ROrjPR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX+eWVwSPUoLMN
 J/GNdkqjUmv+z1Aq/L9egLyWocM6oxZnLBW7HdhCfmcS3dmo98waViaG4Wh32lT6f6ei/ObKtnR
 GOrbLyD7N6VIy78tGzjzTmzJ7Shos53fzZrXp2XWW00ziEMGr62drJDQju75BEwCPoMfKLpqH3T
 Es4+ta625BQXbOnvPOIlgU4784bEC7Jkge80DoR1fDe0rEZmRXRUpBPDmq13f8/RZEu4w5m8Y3u
 /XQsHX5ZDxTmP48WrZFXQ5MqArhvhRSRJnB7cQ95E0RaC1HRWZVx5YXclluaRys6GMK8AD6oZ7b
 bUwFkjM03Zu5vUCthya2CljAjCZVmIlR9JgH/7rgkLHjDhJs7MSt5Vehz6AQXTiKKWfmPTf8EJc
 i5V68Jjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

On 9/17/2025 4:21 PM, Zhuoying Cai wrote:
> Create a function to validate the address parameter of DIAGNOSE.
>
> Refactor the function for reuse in the next patch, which allows address
> validation in read or write operation of DIAGNOSE.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/s390x/ipl.h      | 6 ++++++
>   target/s390x/diag.c | 4 +---
>   2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index bee72dfbb3..e26fc1cd6a 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -118,6 +118,12 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>   #define S390_IPLB_MIN_FCP_LEN 384
>   #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
>   
> +static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
> +{
> +    return address_space_access_valid(&address_space_memory, addr,
> +                                      size, write, MEMTXATTRS_UNSPECIFIED);
> +}
> +
>   static inline bool iplb_valid_len(IplParameterBlock *iplb)
>   {
>       return be32_to_cpu(iplb->len) <= sizeof(IplParameterBlock);
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index a35d808fd7..e67ee57f01 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -65,9 +65,7 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>           return -1;
>       }
> -    if (!address_space_access_valid(&address_space_memory, addr,
> -                                    sizeof(IplParameterBlock), write,
> -                                    MEMTXATTRS_UNSPECIFIED)) {
> +    if (!diag_parm_addr_valid(addr, sizeof(IplParameterBlock), write)) {
>           s390_program_interrupt(env, PGM_ADDRESSING, ra);
>           return -1;
>       }

