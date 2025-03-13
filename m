Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20901C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 18:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsnaF-0005Cm-7t; Thu, 13 Mar 2025 14:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsna9-00056O-6Z; Thu, 13 Mar 2025 14:47:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsna5-0004TP-Kn; Thu, 13 Mar 2025 14:46:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGo4XS024463;
 Thu, 13 Mar 2025 18:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=B6PAfV
 WzpoIQo4PM+hpzcQGA2BK6YIKZ3QJi8oD3G84=; b=oGj6Qglt30du4yKocswPJE
 CvHkotdL7RH0nIf4Htbn5KN/7LFvshSZXVw0PiK2eQNZXflGKwH2LNoGmpPReCnW
 QLbWanXq2c6GiFtMtXl5rR/TyTqfnwD42cLin+a+P69htCgn84JRz5YstEK3amh1
 8hXxycKIiaVjH+YAPWA9iYXDgyjmc2g1bLUph2tVu4uMTnIsnagy7WQvtM0/fNyJ
 Qzarv6aIpyI21qDG6LTYN+ebNbAEio1Wc0YR6s745tS/MSIdWGDVAWquvQuQ4b19
 esAyypOfM1Sjh2ofjzQIvfeZ07bnCLTto/gCZFecTnKoCjyzQTZtAH2nDU8IPtag
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0sr9j5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:46:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52DIS1pc019654;
 Thu, 13 Mar 2025 18:46:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0sr9j5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:46:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52DFdlg9007428;
 Thu, 13 Mar 2025 18:46:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrb9f1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:46:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52DIknuD13762878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 18:46:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FD0020043;
 Thu, 13 Mar 2025 18:46:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DF6820040;
 Thu, 13 Mar 2025 18:46:47 +0000 (GMT)
Received: from [9.124.223.53] (unknown [9.124.223.53])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Mar 2025 18:46:46 +0000 (GMT)
Message-ID: <427f754c-3f40-47e1-873a-1beb69666506@linux.ibm.com>
Date: Fri, 14 Mar 2025 00:16:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] hw/ppc: Handle stash command in PowerNV SBE
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
 <20250217071934.86131-4-adityag@linux.ibm.com>
 <59df1008-2127-4ae4-b8e7-72334c58f12e@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <59df1008-2127-4ae4-b8e7-72334c58f12e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MmqRacv20pSrhrRziowySsde5vVFj976
X-Proofpoint-GUID: DwTFg2XlxZqYxHJ2OCkOMi8GR6vEnEUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130141
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 11/03/25 10:20, Harsh Prateek Bora wrote:

>
>> <...snip...>
>>
>> --- a/hw/ppc/pnv_sbe.c
>> +++ b/hw/ppc/pnv_sbe.c
>> @@ -82,6 +82,8 @@
>>   #define SBE_CONTROL_REG_S0              PPC_BIT(14)
>>   #define SBE_CONTROL_REG_S1              PPC_BIT(15)
>>   +static uint64_t mpipl_skiboot_base = 0x30000000 /*default 
>> SKIBOOT_BASE*/;
>> +
>>   static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
>>   {
>>       val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW 
>> do? */
>> @@ -281,6 +283,29 @@ static void do_sbe_msg(PnvSBE *sbe)
>>               timer_del(sbe->timer);
>>           }
>>           break;
>> +    case SBE_CMD_STASH_MPIPL_CONFIG:
>> +        /* key = sbe->mbox[1] */
>> +        switch (sbe->mbox[1]) {
>> +        case SBE_STASH_KEY_SKIBOOT_BASE:
>> +            mpipl_skiboot_base = sbe->mbox[2];
>> +            qemu_log_mask(LOG_UNIMP,
>> +                "Stashing skiboot base: 0x%lx\n", mpipl_skiboot_base);
>> +
>> +            /*
>> +             * Set the response register.
>> +             *
>> +             * Currently setting the same sequence number in
>> +             * response as we got in the request.
>> +             */
>> +            sbe->mbox[4] = sbe->mbox[0];    /* sequence number */
>> +            pnv_sbe_set_host_doorbell(sbe,
>> +                    sbe->host_doorbell | SBE_HOST_RESPONSE_WAITING);
>> +
>> +            break;
>> +        default:
>> +            qemu_log_mask(LOG_UNIMP, "SBE Unimplemented command: 
>> 0x%x\n", cmd);
>
> Unimplemented SBE_CMD_STASH_MPIPL_CONFIG key ?

Got it. Thanks for the reword suggestion, will do it.


Thanks,

- Aditya G

>
>> +        }
>> +        break;
>>       default:
>>           qemu_log_mask(LOG_UNIMP, "SBE Unimplemented command: 
>> 0x%x\n", cmd);
>>       }
>> diff --git a/include/hw/ppc/pnv_sbe.h b/include/hw/ppc/pnv_sbe.h
>> index b6b378ad14c7..f6cbcf990ed9 100644
>> --- a/include/hw/ppc/pnv_sbe.h
>> +++ b/include/hw/ppc/pnv_sbe.h
>> @@ -53,4 +53,7 @@ struct PnvSBEClass {
>>       const MemoryRegionOps *xscom_mbox_ops;
>>   };
>>   +/* Helper to access stashed SKIBOOT_BASE */
>> +bool pnv_sbe_mpipl_skiboot_base(void);
>> +
>>   #endif /* PPC_PNV_SBE_H */

