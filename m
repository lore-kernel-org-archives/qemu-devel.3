Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18868C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwICG-0006ZL-QM; Tue, 18 Aug 2026 07:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwICE-0006SL-Mz; Tue, 18 Aug 2026 07:41:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwICC-0002jp-Ok; Tue, 18 Aug 2026 07:41:34 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IAVeZR069949; Tue, 18 Aug 2026 11:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kYjp/C
 usTxIrUNeX6lwe2+Hz1k7eB9RlQUbfBJC9fcg=; b=UUDei0JPaaXLv/WJniyVkx
 QnWLkkXJIeGg53C+HJV/l3mX8UuaxWgLD0Jcj82M+aCjUIUp2Z5nAVc1Ym2/oQH3
 B3spVqIf15fmD788ijl5iZAahav/Yxh/N3hUYgw/NhuC25HVnX2d7XSln0vCKL6L
 zoVEFgCWsqp8s2SeisAjl96kbg76C0tgOl1vF9wTqCbaasyGprLfJImpzjgRrwX1
 NtFXbERh3UBfHK7wwG2miE+fIwzQ8481ddsxY9+UqXTgRQk28cLK2lO6CIOsSGkT
 ijF1nNF4GIBh9OLL1XpInpLes0ucPPurzwXQsBxe9I80bDaGNxFLRBsTNfT4xHOw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt7cb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 11:41:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IBfKs0013729;
 Tue, 18 Aug 2026 11:41:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek2ypj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 11:41:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IBfQ3F62849468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 11:41:27 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91B6F5805E;
 Tue, 18 Aug 2026 11:41:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD0BE58051;
 Tue, 18 Aug 2026 11:41:21 +0000 (GMT)
Received: from [9.39.18.24] (unknown [9.39.18.24])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 11:41:21 +0000 (GMT)
Message-ID: <01070c86-0a61-43e5-8f55-7f217a3f96a9@linux.ibm.com>
Date: Tue, 18 Aug 2026 17:11:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/ppc: Add lower bound check for watchdogNumber
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, aik@ozlabs.ru,
 amachhiw@linux.ibm.com
References: <20260818104551.76023-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260818104551.76023-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a8444e9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=zk2K8ISp43fUAqkf_MkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX0XJE2CLYOTZN
 UHsUsjvdIJ6Rcqwy8Mq2PvUjll2t0cC17gq54r5UCN2tRAr6S0WHJyO8WYpn6VKJsLw1SyH6tw5
 0qLYTS83JaHk1/exCwx/6Who7qEZvhg=
X-Proofpoint-GUID: GbsTYsAD8gz9MOC2TDV_BCKefTmc_JIc
X-Proofpoint-ORIG-GUID: cG38s47JSvS7WYdS1F-uLHDKOfG9HPzh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfXxriVx+Hikcii
 sd274IpVDzq49g0eRiYeI/SEuu+sCHsFmBOUn6wCiMpDCM6iRDqMgUnKvmCXq2NX5DG8s/sK6kE
 4gAFbsVpg1lhkcmmYEKsva705MgSxSzbk+TwtRcVcC0moXjhZZdulI9V3GIlJ1ezvdK1F2UzhEV
 RPdwCfnZOkHHaT0BcsWZyIKhQTYqPrAfNVHTJvFBRYy1ElqxGyxDIoRg2PUnLp5YJneQn6dsWme
 u7tPL1k6tJ7AAeY8Nc5U/J97SWbOFnYSeCQP9XLTmf+qt/yboSjXeiDpKdQkb5G9jEhrwKka6bA
 HmC1S17rc9384jGfVhM/mJWdxD+eSsonHoy5LYF71fnvx/YtD8lDv/sDcvWj+OPsE+QqOrLN79W
 +J2GJDplm7E+ipe5LjH2671io0oJ/sV4Ag1hwTjDJot5glzia2YcLHwEMe0iFGx4ITxhauA3J6J
 Xkt7ynIy4xxJjDHkBvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180085
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 8/18/26 16:15, Chinmay Rath wrote:
> Add missing lower bound check for H_WATCHDOG H_CALL's watchdogNumber parameter
> as per PAPR documentation ver 12.10.00 section 14.15.5 'H_WATCHDOG'.
>
> Closes : https://gitlab.com/qemu-project/qemu/-/work_items/3600
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reported-by: huntr bubble <bubblehuntr@gmail.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>
> Changes from v2:
> Renamed watchdogNumber_valid to watchdog_number_valid - Amit
> Retained Amit's Reviewed-by
>
>   hw/watchdog/spapr_watchdog.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
> index 5b3f50de3a..5a72896066 100644
> --- a/hw/watchdog/spapr_watchdog.c
> +++ b/hw/watchdog/spapr_watchdog.c
> @@ -127,6 +127,12 @@ static void watchdog_expired(void *pw)
>       }
>   }
>   
> +static inline bool watchdog_number_valid(target_ulong watchdogNumber,
> +                                        SpaprMachineState *spapr)
> +{
> +    return watchdogNumber >= 1 && watchdogNumber <= ARRAY_SIZE(spapr->wds);
> +}
> +
>   static target_ulong h_watchdog(PowerPCCPU *cpu,
>                                  SpaprMachineState *spapr,
>                                  target_ulong opcode, target_ulong *args)
> @@ -145,7 +151,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>   
>       switch (operation) {
>       case PSERIES_WDTF_OP_START:
> -        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
> +        if (!watchdog_number_valid(watchdogNumber, spapr)) {
>               return H_P2;
>           }
>           if (timeoutInMs <= WDT_MIN_TIMEOUT) {
> @@ -170,11 +176,11 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>       case PSERIES_WDTF_OP_STOP:
>           if (watchdogNumber == PSERIES_WDT_STOP_ALL) {
>               ret = watchdog_stop_all(spapr);
> -        } else if (watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
> +        } else if (!watchdog_number_valid(watchdogNumber, spapr)) {
> +            return H_P2;
> +        } else {
>               ret = watchdog_stop(watchdogNumber,
>                                   &spapr->wds[watchdogNumber - 1]);
> -        } else {
> -            return H_P2;
>           }
>           break;
>       case PSERIES_WDTF_OP_QUERY:
> @@ -184,7 +190,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>           trace_spapr_watchdog_query(args[0]);
>           break;
>       case PSERIES_WDTF_OP_QUERY_LPM:
> -        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
> +        if (!watchdog_number_valid(watchdogNumber, spapr)) {
>               return H_P2;
>           }
>           args[0] = PSERIES_WDTQL_QUERY_NOT_STOPPED;

