Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DA0C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxE1-0005v6-Tj; Tue, 12 Mar 2024 04:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjxDx-0005rw-CZ; Tue, 12 Mar 2024 04:11:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjxDq-0006qZ-E7; Tue, 12 Mar 2024 04:10:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C86WL0015395; Tue, 12 Mar 2024 08:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NCkYxn1/Tm/Mq/TFNGQFcpRi8E6u6TqwK25UFuaAHo4=;
 b=DNNyfWS2yafY551cOhwCWHYt6h9gwqSmfR50izeWca0X6NGuPFO13l27tNb0audBGKJb
 Coln2ZpKHa1FRpsYe8cNFUHtWN3YTae4OBhGIngQYfRKvX8g00x+dJtxziLb4lxq0LIx
 PlveFTxGnKuJgIRjMyY/p/h0JxBwjpUnZQoZ4sZu8rfT/7oxms+iTywxpraSv4K7e9KD
 zlKRuOaWAMhSbJIhgus/jZvyRdlrdg7sBF30/c4gze1A6abknCzlEIWFtjg2p4QwqTb3
 Ytm67BG/EHpiR9oAKmRP54l+fhHxv7DwQvu2peNMy/OKQ5bcfOvBFY/9IpP8G4Pd+aLK YA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtk4483rn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 08:10:40 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42C86fD3016261;
 Tue, 12 Mar 2024 08:10:39 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtk4483rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 08:10:39 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C5BhQf018112; Tue, 12 Mar 2024 08:10:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23t6127-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 08:10:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42C8AZp328967264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 08:10:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A27D75806D;
 Tue, 12 Mar 2024 08:10:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6A7358063;
 Tue, 12 Mar 2024 08:10:31 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 08:10:31 +0000 (GMT)
Message-ID: <df3f326b-2519-4a0b-9734-f425a9ba0972@linux.ibm.com>
Date: Tue, 12 Mar 2024 13:40:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] target/ppc: POWER10 does not have transactional
 memory
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-3-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240311185200.2185753-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xpW5cssffRHBLEEMVnGajWM_8XZ0G4m4
X-Proofpoint-GUID: Mcr5a_dY0uAGgyEaudU59u-0z4c26iKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_06,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 suspectscore=0 mlxscore=0
 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120062
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Nick,

One query/comment below:

On 3/12/24 00:21, Nicholas Piggin wrote:
> POWER10 hardware implements a degenerate transactional memory facility
> in POWER8/9 PCR compatibility modes to permit migration from older
> CPUs, but POWER10 / ISA v3.1 mode does not support it so the CPU model
> should not support it.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/cpu_init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 572cbdf25f..d7e84a2f40 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6573,7 +6573,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
>                           PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
>                           PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
>                           PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
> -                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
> +                        PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
>                           PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
>       pcc->msr_mask = (1ull << MSR_SF) |
>                       (1ull << MSR_HV) |
> @@ -6617,7 +6617,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
>       pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
>                    POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
>                    POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
> -                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
> +                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV;
>       pcc->l1_dcache_size = 0x8000;
>       pcc->l1_icache_size = 0x8000;
>   }

Shouldn't we also have below change included with this:

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index aac095e5fd..faefc0420e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6641,7 +6641,6 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
                          PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206 | PPC2_ATTN;
      pcc->msr_mask = (1ull << MSR_SF) |
                      (1ull << MSR_HV) |
-                    (1ull << MSR_TM) |
                      (1ull << MSR_VR) |
                      (1ull << MSR_VSX) |
                      (1ull << MSR_EE) |

Otherwise,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


