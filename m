Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D68DFED9E8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Xkk-0006jg-CI; Tue, 17 Mar 2026 12:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w2Xkh-0006jP-7T; Tue, 17 Mar 2026 12:58:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w2Xkd-0000x6-VB; Tue, 17 Mar 2026 12:58:42 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H5g27K509786; Tue, 17 Mar 2026 16:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XWRky9
 N5EyIDH7sip+LNRInrchlOOounesryIPkwV34=; b=COXe6Ba+tXLRR0UPS8p4Hd
 TKGE4KpBHsLWp+RsDPBiwZIIx0YBB2OwGT3sX316g3Ebj5+cChq9JETMbQ9jfCNA
 GiXV5IeDOYKCd6KCxhjDXI52CNX0S/aLlU7BMyt2FUm5XPhF3CT1sQ1gFQUCNCUJ
 wQbSEv2VMInq1iZxI/J+FabEBl7O/oAEKQbWkBPhp9bK+QHFNDRizPoGjgn+0DTN
 UOZGHKtNl6dzU21EFbXbmWXgKYTHNXUhJdkOC89FGYsUUCDbjYN31h+AiOUH/Gw8
 Treb58c3KaXbiwfvHbbwQZZYUTW8aYDb8lNYqcpvz6mifYZzyc9L9h++EuTcEKiA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaudaqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 16:58:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HF6OCx013987;
 Tue, 17 Mar 2026 16:58:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy24tk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 16:58:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HGwV7k22217372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 16:58:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7BDE58053;
 Tue, 17 Mar 2026 16:58:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B5F65805D;
 Tue, 17 Mar 2026 16:58:30 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 16:58:30 +0000 (GMT)
Message-ID: <b569c01c-9e0e-403a-8d43-d6314aaa43d0@linux.ibm.com>
Date: Tue, 17 Mar 2026 12:58:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] hw/tpm: Remove CRBState::ppi_enabled field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260317120241.16320-1-philmd@linaro.org>
 <20260317120241.16320-4-philmd@linaro.org>
 <abdffb51-a16e-42e6-81b2-ef07b42afaa7@linux.ibm.com>
 <398bcb91-9d7a-4b7e-a392-bcc0aa51fa7d@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <398bcb91-9d7a-4b7e-a392-bcc0aa51fa7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0OCBTYWx0ZWRfX7d4L5k7PdyMd
 6ZXQPAJONuEX/+UCI6eLOAoDAXfJT5hVYChoEFLCWrvR6SD1FTXiXjLJW7/wplfBb7n5A+8iQrn
 ty0iUJsXV4NkMRtIZNRPblnx/km5j6yRn8i9aAi94LMcgKDeQbkV4GOTMFvTu12T+JKSl2leGyf
 zUftJ9YRw+sbLoAlkeaEOMdJX4fYxLUJeH8VX3DiQW1WhUehbHFPF+OWJql+0MvI7K9TVgU+r2i
 sK0hSI3Mgs/RMCq4W03UJvLXTP5ISrowMm9/NcXCFeVdxuosEdPROpMWAITc8JQ8mM+XEAr2Mru
 qJR0GMyH0rOY5KZVpi00TLtyt5NSQvY/6SgUT2TL46kr9GUnroX4v3Q7p1UY07mSSqWYbYxEwmH
 9EKWWr+eJMWnEFc8yfwvsCGG/Bm3RdfmttT8IanimEPe3TpGAxHdwOC0PioL0afxyHa9baL+0m9
 gQBWgLjQxIeeLujSUSA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b98839 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=D1azyKIUawxn05X-bxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gLwvqYWn_IYoKENKIHxP9SM8ltBa1yBF
X-Proofpoint-GUID: LHxevKfFIOvyRC3By_5gitmlIhR49myf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170148
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/17/26 11:16 AM, Philippe Mathieu-Daudé wrote:
> On 17/3/26 14:19, Stefan Berger wrote:
>>
>>
>> On 3/17/26 8:02 AM, Philippe Mathieu-Daudé wrote:
>>> The CRBState::ppi_enabled boolean was only set in the
>>> hw_compat_3_1[] array, via the 'ppi=false' property.
>>> We removed all machines using that array, and the array
>>> itself in commit a861ffef237 ("hw/core/machine: Remove
>>> the hw_compat_3_1[] array"). We can safely remove the
>>> now unused property. Since CRB devices always use PPI,
>>
>> s/use/uses
> 
> I used plural form. To you rather singular?

my error

> 
>    "Since the CRB device always use PPI, ..>
>>
>>> simplify removing the CRBState::ppi_enabled field.
>>> Set the generic TPMIfClass::ppi_enabled so ACPI subsystem
>>> can keep checking its availability.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/tpm/tpm_crb.c | 13 ++++---------
>>>   1 file changed, 4 insertions(+), 9 deletions(-)
> 


