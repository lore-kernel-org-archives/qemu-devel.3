Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1987FC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 04:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsaRl-00027D-0k; Thu, 13 Mar 2025 00:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tsaRU-0001mg-QT; Thu, 13 Mar 2025 00:45:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tsaRS-0007Gl-DS; Thu, 13 Mar 2025 00:45:12 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CKpaT2001152;
 Thu, 13 Mar 2025 04:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZihVD9
 +xZjkcRwgSm2fshlaJU0sYYIlRLdXdYsYUwEI=; b=pzvmse4iiksXv9lziVs8+6
 w09SSUhpYb6y2X/3US0fU5iGkl6OZSzf3FfFUT8A5P5TJ3ldCeRAlnvy0fS3HSf3
 DqfLnpx4oJsvinWLFJeE+njtRdeRc5pIAskZteyLP/unSabgFCugwz7DYhbGB+ti
 7RMorwUo9ZM8YwkfCqw0jhykOp9srvpw/u4FZT4hbCfnlQQimMxhTYisrXomsuMI
 avVKBF35XUM0Hdj37pk6+ZsSeD5GBeXxFkTaKGhey90LvtL23PoXHGoELOivkMiZ
 +6IlWr8JI86s/9X+b6tB15pNTjGtZ2TDahd47IU6bH8e+lCTkEyRE+W3MXoxVy2g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhp59jm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 04:45:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52D4j7Pv009281;
 Thu, 13 Mar 2025 04:45:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhp59jm1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 04:45:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D15fgZ027045;
 Thu, 13 Mar 2025 04:45:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsqyvmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 04:45:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52D4j5kj32375478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 04:45:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF26F58053;
 Thu, 13 Mar 2025 04:45:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D50E5805D;
 Thu, 13 Mar 2025 04:45:04 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Mar 2025 04:45:03 +0000 (GMT)
Message-ID: <0eefc09a-138d-4b9d-90d8-c1796f4fed52@linux.ibm.com>
Date: Thu, 13 Mar 2025 10:15:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: fix default cpu for pre-10.0 machines.
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250312055804.2134569-1-harshpb@linux.ibm.com>
 <408efa3d-bd73-47bc-8723-08c805df6815@linaro.org>
 <89d61c6e-5a4e-49fc-a285-2215fa476709@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <89d61c6e-5a4e-49fc-a285-2215fa476709@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NNCMPuqjhtLwRLQ2EpEo5OMBHBo4R0wI
X-Proofpoint-ORIG-GUID: Y-OIkF4Jw8Oq1s5Pm6CuLW7XWrGd-E72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=871 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130032
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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



On 3/12/25 15:50, Harsh Prateek Bora wrote:
> 
> 
> On 3/12/25 15:39, Philippe Mathieu-Daudé wrote:
>> On 12/3/25 06:58, Harsh Prateek Bora wrote:
>>> When POWER10 CPU was made as default, we missed keeping POWER9 as
>>> default for older pseries releases (pre-10.0) at that time.
>>> This caused breakge in default cpu evaluation for older pseries
>>> machines and hence this fix.
>>>
>>
>> Should we also include:
>>
>>    Cc: qemu-stable@nongnu.org
>>
>> ?
>>
> 
> I guess so. Not sure if we need a patch v2 for just that.
> 
>>> Fixes: 51113013f3 ("ppc/spapr: change pseries machine default to 
>>> POWER10 CPU")
>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> ---
>>>   hw/ppc/spapr.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index c15340a58d..b31a91e2e2 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -4748,6 +4748,7 @@ static void 
>>> spapr_machine_9_2_class_options(MachineClass *mc)
>>>   {
>>>       spapr_machine_10_0_class_options(mc);
>>>       compat_props_add(mc->compat_props, hw_compat_9_2, 
>>> hw_compat_9_2_len);
>>> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
>>
>> This is confusing because v9.2 has already been released with that...
> 
> I think it still needs to be fixed for v9.2 (and older) if someone wants 
> to use pseries-9.2 (and older) with future releases.

Gave it another thought. May be moving the default to v9.1 could be
relatively better. 9.2 stable shall get the fix for pre-9.2 but 9.2
default need not change.

Nick, Daniel, comments?

Thanks
Harsh
> 
> Thanks
> Harsh
> 
>>
>>>   }
>>>   DEFINE_SPAPR_MACHINE(9, 2);
>>
>>
> 

