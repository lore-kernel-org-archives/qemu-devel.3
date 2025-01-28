Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC23C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 09:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tciB4-0007Us-Bs; Tue, 28 Jan 2025 04:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tciAj-0007TM-0e; Tue, 28 Jan 2025 04:46:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tciAg-0007rw-Oo; Tue, 28 Jan 2025 04:46:16 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLITFJ009914;
 Tue, 28 Jan 2025 09:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EZBxax
 4BvqadIxSiHy2Chyv0Ob5B14CGE6BFREmS4pk=; b=i9a5nRAaTZVV7HBb1XGHN0
 QSoKp0FSmX1xoHUX5ilkeKR/LMP7wzLapiveVywW/zjW+U6xQn2ehjaf8bjBswvw
 Rrh+h937XAEW/561OBkvfE9RHqt4BBkNvVWHT4u2nBpsJCzFlzooJ955hzl2o+Co
 yr52QrVGzO/JGeNjpN7cJBLh0wWOEdSEler8jq13GsiQ2GK5L0ZoyX6wAlFbgyPT
 LZkuOtVyrH3lRoGsXTDJANgMqobIiqBoyc84qbS4yRayKdoGjGWg4c/z0TFrlGo+
 Lh9PW72cEaYb6w8yue/NXO4ySJ+RJvipcvas0AxRnh+La0WQivaOQPD6g+Tb8U9Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdyck4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 09:46:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50S9kBKe007309;
 Tue, 28 Jan 2025 09:46:11 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdyck48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 09:46:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S6RcPX022193;
 Tue, 28 Jan 2025 09:46:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjjbjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 09:46:10 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50S9k9CC22413998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 09:46:09 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77CB25805E;
 Tue, 28 Jan 2025 09:46:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BB5258056;
 Tue, 28 Jan 2025 09:46:07 +0000 (GMT)
Received: from [9.124.214.156] (unknown [9.124.214.156])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2025 09:46:06 +0000 (GMT)
Message-ID: <0e1dfcad-c4fb-49a5-ab8b-0a5673957e3c@linux.ibm.com>
Date: Tue, 28 Jan 2025 15:16:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] target/ppc: Remove raise_exception_ra()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-9-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250127102620.39159-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B4HUYPcVRuJWzXpAtz_C__5UeLeByCyD
X-Proofpoint-ORIG-GUID: e1Rwt_v_tSfCRir-c98MJ2pQko63bTIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=493 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280073
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 1/27/25 15:56, Philippe Mathieu-Daudé wrote:
> Introduced in commit db789c6cd33 ("ppc: Provide basic
> raise_exception_* functions"), raise_exception_ra() has
> never been used. Remove as dead code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Although there are a bunch of raise_exception_err_ra calls passing
error_code as 0, I hope removing this is fine as still unused.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/cpu.h         | 2 --
>   target/ppc/excp_helper.c | 6 ------
>   2 files changed, 8 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 0b8b4c05172..4ca27d6b389 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2753,8 +2753,6 @@ static inline void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
>   #endif
>   
>   G_NORETURN void raise_exception(CPUPPCState *env, uint32_t exception);
> -G_NORETURN void raise_exception_ra(CPUPPCState *env, uint32_t exception,
> -                                   uintptr_t raddr);
>   G_NORETURN void raise_exception_err(CPUPPCState *env, uint32_t exception,
>                                       uint32_t error_code);
>   G_NORETURN void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 236e5078f56..9e1a2ecc36f 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -2528,12 +2528,6 @@ void raise_exception(CPUPPCState *env, uint32_t exception)
>       raise_exception_err_ra(env, exception, 0, 0);
>   }
>   
> -void raise_exception_ra(CPUPPCState *env, uint32_t exception,
> -                        uintptr_t raddr)
> -{
> -    raise_exception_err_ra(env, exception, 0, raddr);
> -}
> -
>   #ifdef CONFIG_TCG
>   void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
>                                   uint32_t error_code)

