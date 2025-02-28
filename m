Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8516EC19F32
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 03:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnqgf-0003EJ-6X; Thu, 27 Feb 2025 22:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tnqgb-0003D7-RZ; Thu, 27 Feb 2025 22:05:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tnqga-0006Vz-9y; Thu, 27 Feb 2025 22:05:13 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S092lp021215;
 Fri, 28 Feb 2025 03:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=R27skd
 qjoPRhnE0CA7idAXS9VSJtjlb2n7s+pLw7SGc=; b=NNwykcBKRgAyILHq3QjvRW
 aQLqUhx/pQx6pBxx2GIDPSQoAsdFtr5Uh+ZEYkSyIfFuafqPgWumN9TXfSLWy18S
 yFUc16FdRNI6cNUFXHpntFIxxs2J53m0DUcQ5HogrKnvOBHqlCU9PuFWq/TmEotV
 ujpF8HW3t12IgLpKM8ZDyw+yCHfjrLHsi5eUKu/x9vtgrbG3cwPzR3d44trfK+Cw
 DgyoNQkoJc2GUEUqi7m0hgw+563UJ7vNvSMG2jEhbLU1iS2Ddktqn3GwY+qmemk7
 IpNuoFKeNs/9eGFYD5kYSj01zmU5k0HPBMmZn1Zei+6XCIZeAD8vq3ae9aAUP2YA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452hv8x1cr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 03:05:05 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51S2wX6L023792;
 Fri, 28 Feb 2025 03:05:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452hv8x1ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 03:05:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51S2lTqv026287;
 Fri, 28 Feb 2025 03:05:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswnv7y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 03:05:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51S34xsC50004250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2025 03:04:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 571D720043;
 Fri, 28 Feb 2025 03:04:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5BA620040;
 Fri, 28 Feb 2025 03:04:56 +0000 (GMT)
Received: from [9.43.106.183] (unknown [9.43.106.183])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Feb 2025 03:04:56 +0000 (GMT)
Message-ID: <137e2b04-7a2f-43e9-9bb9-58ef9dbd83fc@linux.ibm.com>
Date: Fri, 28 Feb 2025 08:34:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] hw/ssi/pnv_spi: Put a limit to RDR match failures
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, clg@kaod.org,
 calebs@linux.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
References: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
 <20250103161824.22469-5-chalapathi.v@linux.ibm.com>
 <D82USMP2EKXB.1LFUGZQZKVFL2@gmail.com>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <D82USMP2EKXB.1LFUGZQZKVFL2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HEpYY77BwPYsJTHwTYVLCojtCdQRkqzt
X-Proofpoint-GUID: cW45wNpRj0lk09TlTgF0q6TvEs00FhSg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502280020
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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


On 27-02-2025 07:26, Nicholas Piggin wrote:
> On Sat Jan 4, 2025 at 2:18 AM AEST, Chalapathi V wrote:
>> There is a possibility that SPI controller can get into loop due to indefinite
>> RDR match failures. Hence put a limit to failures and stop the sequencer.
>>
>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>> ---
>>   hw/ssi/pnv_spi.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
>> index 41beb559c6..d605fa8b46 100644
>> --- a/hw/ssi/pnv_spi.c
>> +++ b/hw/ssi/pnv_spi.c
>> @@ -20,6 +20,7 @@
>>   #define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
>>   #define PNV_SPI_MASKED_OPCODE(x) (x & 0xF0)
>>   #define PNV_SPI_FIFO_SIZE 16
>> +#define RDR_MATCH_FAILURE_LIMIT 16
>>   
>>   /*
>>    * Macro from include/hw/ppc/fdt.h
>> @@ -838,21 +839,31 @@ static void operation_sequencer(PnvSpi *s)
>>                */
>>               if (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1) {
>>                   bool rdr_matched = false;
>> +                static int fail_count;
> This will be shared by SPI instances, is that okay or should it be
> in PnvSpi?
>
> Other than that, looks good.
This should be in PnvSpi. Will update in V6. Thank You.
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

