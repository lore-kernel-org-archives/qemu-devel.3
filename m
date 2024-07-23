Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ECAC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7m5-0001bw-5Y; Tue, 23 Jul 2024 01:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sW7lu-0001Ot-CY; Tue, 23 Jul 2024 01:09:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sW7ls-0000bi-Bb; Tue, 23 Jul 2024 01:09:10 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N4uldF007226;
 Tue, 23 Jul 2024 05:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=m
 DGaJ2vYJsy9EGmZmeOdy97xMhH7nAC2byoDtnEiwLs=; b=bzqymvSsim2z72wMJ
 WCwp1DlGmiOxXFjOu0HDdTSmoIjhUqNYYgYFWrkX/EC4H/7+PCX9IJpjaHK7Mc/j
 6xphV67FqutLWD7OzN+QcVV/Io4HCE/KVJxvzd7eUxwEF0Cb2sfUnH61FEuirec9
 fNcpCZloRZtWEiB8y6xRJ16pJZrJY1Nb8J1qZJFicclsFu06j+9E72426rS7tztV
 oXxPgRFZVKLtCGWMOXs0s55Lx5J9gZ8VLubwzJ0ksVLcVGP3x5KzSA4ZZt4/LL4+
 ZIENLzm4PRimv10Q6T6SgnTEV4JWII7K1oyA+R3PHDHaAJLYngDnOgakE0KUi7jP
 1koug==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3atg9jp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 05:08:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N58wfd024505;
 Tue, 23 Jul 2024 05:08:58 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3atg9jn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 05:08:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46N4pFOt007087; Tue, 23 Jul 2024 05:08:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gx72gwkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 05:08:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46N58qjL54460794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 05:08:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F0FA20043;
 Tue, 23 Jul 2024 05:08:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAF6620040;
 Tue, 23 Jul 2024 05:08:49 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2024 05:08:49 +0000 (GMT)
Message-ID: <55aacd7e-1591-4fa4-adc4-99b1e71d661f@linux.ibm.com>
Date: Tue, 23 Jul 2024 10:38:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] target/ppc: Fix regression due to Power10 and
 Power11 having same PCR
To: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240606121657.254308-1-adityag@linux.ibm.com>
 <20240606121657.254308-6-adityag@linux.ibm.com>
 <D2WNIPIYCNGA.2WYVT9ZXPW78Y@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D2WNIPIYCNGA.2WYVT9ZXPW78Y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 06-1i4gJU5mag63lSTNwbfiV3WOrOrcL
X-Proofpoint-ORIG-GUID: OnNzs-P4KIgYLXGqkF8jtETeyQ0dRNqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230034
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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


On 23/07/24 10:28, Nicholas Piggin wrote:
> On Thu Jun 6, 2024 at 10:16 PM AEST, Aditya Gupta wrote:
>> Power11 has the same PCR (Processor Compatibility Register) value, as
>> Power10.
>>
>> Due to this, QEMU considers Power11 as a valid compat-mode for Power10,
>> ie. earlier it was possible to run QEMU with '-M pseries,max-compat-mode=power11 --cpu power10'
> Isn't this expected to work, or no?

It works, but it didn't feel logical to be able to boot an older CPU in 
a compat mode of a newer CPU.

Major reason though, it caused regression where `-M pseries --cpu 
power10` was booting as Power11, since Power11 was the highest PCR it 
found as compatible.

The only issue I see in this patch is the assumption that a newer 
processor must always have a higher PVR value, which is true as of now.


>
>> Same PCR also introduced a regression where `-M pseries --cpu power10`
>> boots as Power11 (ie. logical PVR is of Power11, even though PVR is Power10).
>> The regression was due to 'do_client_architecture_support' checking for
>> valid compat modes and finding Power11 to be a valid compat mode for
>> Power10 (it happens even without passing 'max-compat-mode' explicitly).
>>
>> Fix compat-mode issue and regression, by ensuring a future Power
>> processor (with a higher logical_pvr value, eg. P11) cannot be valid
>> compat-mode for an older Power processor (eg. P10)
> This should be done before introducing the Power11 CPU so there's no
> regression inside the series.

Sure, I will move it before the 'Add Power11 DD2.0 processor' patch.

>> Cc: Cédric Le Goater <clg@kaod.org>
>> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   target/ppc/compat.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
>> index 12dd8ae290ca..168a3c06316f 100644
>> --- a/target/ppc/compat.c
>> +++ b/target/ppc/compat.c
>> @@ -139,6 +139,10 @@ static bool pcc_compat(PowerPCCPUClass *pcc, uint32_t compat_pvr,
>>           /* Outside specified range */
>>           return false;
>>       }
>> +    if (compat->pvr > pcc->logical_pvr) {
>> +        /* Older CPU cannot support a newer processor's compat mode */
>> +        return false;
>> +    }
> Hmm. I suppose this is the right way to fix it.
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thank you for the tag, Nick !


- Aditya Gupta

>>       if (!(pcc->pcr_supported & compat->pcr_level)) {
>>           /* Not supported by this CPU */
>>           return false;

