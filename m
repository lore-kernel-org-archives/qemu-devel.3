Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA52C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 08:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnaKg-00074j-PQ; Fri, 22 Mar 2024 04:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rnaKe-00073g-LM; Fri, 22 Mar 2024 04:32:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rnaKc-0005kD-MR; Fri, 22 Mar 2024 04:32:56 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42M89nuC024972; Fri, 22 Mar 2024 08:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=R25hTsL3ipMuM5wa8WGmXT+GcQvjYn6gZfHXqhbsIdw=;
 b=FXiCv7vDLdu5C/kZiCUWD2hypgV3RzKZnLPijodzHVegCVHW8QVEgSw5S0v2CUjRjqNB
 97AyUlRUIpmt2DaoBGXLGKPzZyRWtya/mCml82JlsSQ49HA+ihIqYfz9ZikbLF09su3P
 XuGhAL6NVBfs3U7VugLrzxtaQwmUaoWtdQw15dEEy3/OkpAsam2tDw1JR1HleKXlLZJ+
 L57P1nSfc7rmMspe35RktfEHtFfPhSSymhHtWu6IE/kzV75g1IcdPrA8axr+WqFXVYVd
 dG27C76UE7W9/Du5iXqYqpHlsD5JG7vN0JvLEgCT3tKPUXKD+ijVaQRXH0p83+5oJx52 cA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x15d3054t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Mar 2024 08:32:51 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42M8WpVH000686;
 Fri, 22 Mar 2024 08:32:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x15d3054s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Mar 2024 08:32:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42M5XdMd023107; Fri, 22 Mar 2024 08:32:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x0x14jjnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Mar 2024 08:32:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42M8Wl5C26215046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Mar 2024 08:32:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 198195805F;
 Fri, 22 Mar 2024 08:32:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BD9E58065;
 Fri, 22 Mar 2024 08:32:45 +0000 (GMT)
Received: from [9.171.94.36] (unknown [9.171.94.36])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 Mar 2024 08:32:45 +0000 (GMT)
Message-ID: <a6ec42e1-b07f-4535-8c8f-2fffa3beab0c@linux.ibm.com>
Date: Fri, 22 Mar 2024 14:02:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Do not clear MSR[ME] on MCE interrupts to
 supervisor
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240321055415.2441812-1-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240321055415.2441812-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5gsqzlid1xKCHa_WfwAnXC7lhBdF_Pm-
X-Proofpoint-ORIG-GUID: 1nyDsLyv7-QM8EGOax8IS8Uz_LATO9ir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=920 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220061
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 3/21/24 11:24, Nicholas Piggin wrote:
> Hardware clears the MSR[ME] bit when delivering a machine check
> interrupt, so that is what QEMU does.
> 
> The spapr environment runs in supervisor mode though, and receives
> machine check interrupts after they are processed by the hypervisor,
> and MSR[ME] must always be enabled in supervisor mode (otherwise it
> could checkstop the system). So MSR[ME] must not be cleared when
> delivering machine checks to the supervisor.
> 
> The fix to prevent supervisor mode from modifying MSR[ME] also
> prevented it from re-enabling the incorrectly cleared MSR[ME] bit
> when returning from handling the interrupt. Before that fix, the
> problem was not very noticable with well-behaved code. So the
> Fixes tag is not strictly correct, but practically they go together.
> 
> Found by kvm-unit-tests machine check tests (not yet upstream).
> 
> Fixes: 678b6f1af75ef ("target/ppc: Prevent supervisor from modifying MSR[ME]")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/excp_helper.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 80f584f933..674c05a2ce 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1345,9 +1345,10 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>                * clear (e.g., see FWNMI in PAPR).
>                */
>               new_msr |= (target_ulong)MSR_HVB;
> +
> +            /* HV machine check exceptions don't have ME set */
> +            new_msr &= ~((target_ulong)1 << MSR_ME);
>           }
> -        /* machine check exceptions don't have ME set */
> -        new_msr &= ~((target_ulong)1 << MSR_ME);
>   
>           msr |= env->error_code;
>           break;

