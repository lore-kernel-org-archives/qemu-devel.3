Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E157FCAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 04:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0uyf-00038D-UP; Tue, 23 Sep 2025 00:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v0uyd-00036s-N5; Tue, 23 Sep 2025 00:50:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v0uya-0004av-Sp; Tue, 23 Sep 2025 00:50:07 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MMs4Xu012027;
 Tue, 23 Sep 2025 04:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LKOx8k
 k+6lH7FqcN3zxH9xUGjrPmldSivtqEY3yMldM=; b=NdYoanWN+LSNP5cjLHMM1e
 KdwaP6c9R3hLLzFuC5JVM+HUiLLcT/XZa6G5A1kNyEf0eSyKbmzDKeqStlV12Lz2
 C2w3F/+SvxJ8FNizr7esDsyET/H1cO7c4uDn12R91ou4Gz00CeqjB1mZpKyPomDf
 MuVAQHLiJxX0bj8dTR8JCW2JjU2HpgvGBUvlgkzDe5RybvDyKHeg/diSHOERoUvD
 f8Qe+n0zFZ6ljLFTve2NIS4jhUR5Sd/4dGdgX44txnHuXDD5OdZgrR6MFq4XwWys
 wAl2/yXKqGZbe1grvEwleGpU/Ce0Q9c28+2r7RoSe5Y7OwT0X3Tr6LD5ogXFULgg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksbpuy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 04:49:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58N4nsYP028600;
 Tue, 23 Sep 2025 04:49:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksbpuy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 04:49:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58N1mQkf019671;
 Tue, 23 Sep 2025 04:49:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83k1cu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 04:49:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58N4nqit34930944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Sep 2025 04:49:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFD5E5805A;
 Tue, 23 Sep 2025 04:49:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F0485803F;
 Tue, 23 Sep 2025 04:49:50 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Sep 2025 04:49:49 +0000 (GMT)
Message-ID: <c13cb29e-88c5-4751-9273-4e9833289f75@linux.ibm.com>
Date: Tue, 23 Sep 2025 10:19:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] hw/ppc/spapr: Use tb_invalidate_phys_range in
 h_page_init
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>, anushree.mathur@linux.ibm.com
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-7-richard.henderson@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250923023922.3102471-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tGRM27YPlM1PZHU8s20Ko5bmaLXn8dTP
X-Proofpoint-GUID: 4NtuJLd4cc3dZKjShn_VuJUiXW9WYsDv
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d226f3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=luTRIxdsBxbQojV5VVoA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX9drwdlKQl4x0
 l5fkfcCnIr5ucMRSl1GAi3eQ8i07UJ9qcNd8CPgazAekFKmGx4i+jcbEH8e9FNQ4Ze+3Ngd2uWk
 z0WISksfUBvjL+8MzyFVf1L6fAwc7odOs3wrXjwn+BOgdtKuXF7NFl7GlEQmOB4W4NhQSHCABG9
 5GppgFhf4D3sXrNW++590sgdlAbJSmZZk+YM8RHM4jJySjMwMYSDQkB2G08zY9jfhGywlTc+6Mc
 lF/wBLD7zIeveDVHA/aOBsyG3PadBN400Gfa1iEo44zHaY80fO7dEhe0ggoYTRjqp2+FCxEtCMD
 SM7J+5QGiHrhpfPnMZ+LwiL26GzycQ4SmVd9DPU2pqrmBXj0iWQgfENgz0NiZf2BM9nI4Ypw27l
 SNShhQNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

+ Chinmay, Anu - FYI

On 9/23/25 08:09, Richard Henderson wrote:
> We only need invalidate tbs from a single page, not flush
> all translations.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: qemu-ppc@nongnu.org
> ---
>   hw/ppc/spapr_hcall.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index c594d4b916..feb31d5dd8 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -8,7 +8,7 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   #include "qemu/error-report.h"
> -#include "exec/tb-flush.h"
> +#include "exec/translation-block.h"
>   #include "exec/target_page.h"
>   #include "helper_regs.h"
>   #include "hw/ppc/ppc.h"
> @@ -301,7 +301,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
>           if (kvm_enabled()) {
>               kvmppc_icbi_range(cpu, pdst, len);
>           } else if (tcg_enabled()) {
> -            tb_flush(CPU(cpu));
> +            tb_invalidate_phys_range(CPU(cpu), dst, len);

Much needed improvement. Thanks.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>           } else {
>               g_assert_not_reached();
>           }

