Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A053AC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 18:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsnWd-0003jj-DW; Thu, 13 Mar 2025 14:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsnWa-0003j1-IA; Thu, 13 Mar 2025 14:43:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsnWX-000487-8M; Thu, 13 Mar 2025 14:43:18 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGo5Pf003411;
 Thu, 13 Mar 2025 18:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9ZF9GI
 ZSPOPxwybwEy7mIQ21tkD2//2ZuJuQoBVetxY=; b=MPIUghwZWwMCxvm+uWAHmU
 WT+GqbclRFPtyDJ1TgX2Vlyyu6Sa/VVeybSmNgQwf69ZNC8laoqcHS4fEqKUHfjc
 U3vEmCV/MVq4FUj0xbkVXy7Yuqi64JLPHIAmAyPtKGiyhgTqZmTJFSq2AJE/noep
 yBrfU8mYOCI0WoUbTn2GstWEQWjB0vlfvDvF/3ZEMwoDm1oGb6LQCyow2MY1fPd4
 2BiN6/FQE5UfwO4q1y8+oLJk++23aSqJR3vPHWHvUQ7JLpU2cEzuMDTZNf3Rhg5m
 TRoJA4FjFs2PhbE3iCA59ebSCLwcNeAXYciEEdJJJtWNzc4CDxJzoeuXEJxPgWYQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhepnpcp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:43:13 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52DIUE51005974;
 Thu, 13 Mar 2025 18:43:12 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhepnpcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:43:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52DFs4lO015411;
 Thu, 13 Mar 2025 18:43:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspk9ye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:43:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52DIh8Ox55116206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 18:43:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A70020043;
 Thu, 13 Mar 2025 18:43:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F6D120040;
 Thu, 13 Mar 2025 18:43:06 +0000 (GMT)
Received: from [9.124.223.53] (unknown [9.124.223.53])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Mar 2025 18:43:06 +0000 (GMT)
Message-ID: <19f30836-3327-4001-9558-57d68efe017b@linux.ibm.com>
Date: Fri, 14 Mar 2025 00:13:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] hw/ppc: Log S0/S1 Interrupt triggers by OPAL
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
 <20250217071934.86131-2-adityag@linux.ibm.com>
 <d027a80e-cc4d-48ae-8804-9358e1b9e52f@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <d027a80e-cc4d-48ae-8804-9358e1b9e52f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jHi0zQiKPvS1kkL3a3C7h1Py01OarLRO
X-Proofpoint-ORIG-GUID: N3MGP5E2tNfW5WiG14VIrzvTChZsR1gk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=928
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Hi Harsh,

Thank you for the reviews.


On 11/03/25 10:08, Harsh Prateek Bora wrote:
>
>
> On 2/17/25 12:49, Aditya Gupta wrote:
>> During MPIPL (aka fadump), OPAL triggers the S0 SBE interrupt to trigger
>> MPIPL.
>>
>> Currently QEMU treats it as "Unimplemented", handle the interrupts by
>> just logging that the interrupt happened.
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   hw/ppc/pnv_sbe.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
>> index 74cee4eea7ad..62c94a04a2df 100644
>> --- a/hw/ppc/pnv_sbe.c
>> +++ b/hw/ppc/pnv_sbe.c
>> @@ -109,6 +109,19 @@ static void pnv_sbe_power9_xscom_ctrl_write(void 
>> *opaque, hwaddr addr,
>>       trace_pnv_sbe_xscom_ctrl_write(addr, val);
>>         switch (offset) {
>> +    case SBE_CONTROL_REG_RW:
>> +        switch (val) {
>> +        case SBE_CONTROL_REG_S0:
>> +            qemu_log_mask(LOG_UNIMP, "SBE: S0 Interrupt triggered\n");
>> +            break;
>> +        case SBE_CONTROL_REG_S1:
>> +            qemu_log_mask(LOG_UNIMP, "SBE: S1 Interrupt triggered\n");
>> +            break;
>> +        default:
>> +            qemu_log_mask(LOG_UNIMP, "SBE Unimplemented register: Ox%"
>
> This log could be made specific to SBE unimplemented register "bits",
> otherwise fall back to outer switch-default case.

Agreed, will fix it in v2.

Thanks,

- Aditya G

>
>
>> +                  HWADDR_PRIx "\n", addr >> 3);
>> +        }
>> +        break;
>>       default:
>>           qemu_log_mask(LOG_UNIMP, "SBE Unimplemented register: Ox%"
>>                         HWADDR_PRIx "\n", addr >> 3);

