Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FA6C5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 07:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwDrj-0004zm-Sj; Tue, 18 Aug 2026 03:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwDrh-0004zH-Qs; Tue, 18 Aug 2026 03:04:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwDrg-00028E-5B; Tue, 18 Aug 2026 03:04:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HM2D9B759810; Tue, 18 Aug 2026 07:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GyccNF
 0BE67a2K+QkuPeGIDuGb91TzDIqTOGmlK7gB0=; b=HR10kQEB5f/5L73nIS7+sc
 7Rez+DgaHxBNHxF/NKAlwvZYT4UyUi1tBJK94AhEIKR4/wggZQpFkW3OkeBFSEZe
 CWSyCZFTJNBCdDrEClNcBB5/JkXdONSvPoRvLTlyWedWfS/uA1QSQHopkAZKirgr
 wRmOdYdtiDJqXLm/Exlw1yBDtQxLk0e1Vh4o3mN6jvAvOE4Pkou+CQEmVrCU9PS7
 cJQDBJPSnI4zrqx8iv6FbSjbkRDJ7RxJdq0YMlc89Z0lRmmVOAUH8YjUcsZRAORF
 FvVUI1tSLFJ6q00f2JPZ5hmNb6vMtVHIMrNn5ilU/t9Lb/Ys6TSab7AQwA9Tw9SA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqpkru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 07:04:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I6uOWA020355;
 Tue, 18 Aug 2026 07:03:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh1umj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 07:03:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67I73s3718219712
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 07:03:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46BCD58052;
 Tue, 18 Aug 2026 07:03:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B1C85805D;
 Tue, 18 Aug 2026 07:03:50 +0000 (GMT)
Received: from [9.123.8.229] (unknown [9.123.8.229])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 07:03:50 +0000 (GMT)
Message-ID: <c51d7573-0555-4e66-84ec-c470ef176125@linux.ibm.com>
Date: Tue, 18 Aug 2026 12:33:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] target/ppc: Add ICBT support for ISA version 2.07
To: milesg@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, tommusta@gmail.com
Cc: richard.henderson@linaro.org, shivangu@linux.ibm.com, tasmiya@linux.ibm.com
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
 <20260715125634.2107320-8-rathc@linux.ibm.com>
 <4131f802840910b277f6e0a681ce7e51e8a9dddb.camel@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <4131f802840910b277f6e0a681ce7e51e8a9dddb.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1MSBTYWx0ZWRfXxdfMcPR750NI
 ojuELZ2NX2P1/CrhoEpIIxWX5bOxOr1wh2crzn/Yu9FAYD1LLO2rqAY5FSpX1qHd/wR30+OfZWe
 D0Y+Zp73B096ZMIjXwXzY0GQfcT3j3VdMeekYMpr0tO5Y4XYEvxquX9WEZGK8vpCdBK7EqpnlRy
 dhyWLegmXBhQKk5qNxIXbJ0s6Wa+NsElSvyNlGT7fDP4anZ+0TPrWtZOsBH7iKRFD/Hhul0XRJ0
 JPsJ5WvxwS3t18kwX3MTgPB0AuVYDdM6Ixg2KBl73sMtDvbn4l7oCTO4GIvpB+wJ41zuflp8Wvd
 ZJqBAArPlmt8ijYlWPxI7iFI7YogwQVlMGI1j+nM+hi7ZrGGaaJ3Gm0BQMatB+Yl9EUSxFhdTG+
 Djs65RHO/RK13HbhrLNu4widcn/zZ1egtzqFzq/VZiOZreEwhPowsMhbtso2W8c304aFXPmPjCr
 4aGK8RuAckkfc5bhAFQ==
X-Proofpoint-ORIG-GUID: WKXrFc4s6JbahSF7MGwx0QSH5uzxTwUP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1MSBTYWx0ZWRfX/WDh760WOJXv
 kTqE+NvAki69MwFNlIGZERqvaYNUrvKZgz36BMwmkXUNT7yi9tjVenu2imQOKgAdgY+Fi0VANOo
 l6Sp8DI8SWbbw1cIbYtvf5+ZvegBP64=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a8403e0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=CTmI0cp366HRXVE_oNAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 43z5hsP-4zLEYnkrVVB7f6jh3HUt2oI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180051
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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


On 8/17/26 21:26, Miles Glenn wrote:
> Seems like you are fixing a bug here.  Does this require a "Fixes" tag?
Hi Glenn,

Thanks for reviewing the patches in the series !

I wouldn't consider this a bug since this particular patch does not fix 
any wrong or missing behavior from a specific commit. The new 
modifications to the ICBT instruction in the recent ISA versions were 
simply not incorporated in the qemu code. So no previous commit is truly 
at fault here.

Tasmiya had observed certain HTX workload being run in TCG env caused 
illegal instruction error, due to ICBT not supported as expected in the 
latest ISA; which brought this to our attention.

Regards,
Chinmay
>
> Thanks,
>
> Glenn
>
> On Wed, 2026-07-15 at 18:26 +0530, Chinmay Rath wrote:
>> The summary of changes in Power ISA version 2.07B mentions :
>> "ICBT instruction has been moved from the Embedded category
>> to the Base category".
>> Updating ICBT flag for the same.
>>
>> While we are at it, correct the invalid mask as per the ISA as well.
>>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>   target/ppc/translate.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index 8dab54ccee..3cd849c706 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -4559,8 +4559,8 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
>>   GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
>>   GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
>>   GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
>> -GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
>> -               PPC_BOOKE, PPC2_BOOKE206),
>> +GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x02000001,
>> +               PPC_BOOKE, (PPC2_BOOKE206 | PPC2_ISA207)),
>>   GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
>>                PPC_440_SPEC),
>>   GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),

