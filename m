Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D64C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 19:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXQLp-000157-41; Fri, 26 Jul 2024 15:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sXQLk-00012z-Qv; Fri, 26 Jul 2024 15:11:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sXQLi-0007uI-K5; Fri, 26 Jul 2024 15:11:32 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QGprQc024126;
 Fri, 26 Jul 2024 19:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=k
 JYAmX6b/2jQ6iYiCBya63xP35HCg1sNQ6OoYMZXjUg=; b=F2qsC+zFl5dPZvS5y
 WphWbbkP93MDswGo5T/55JvgrqS9FsOwBumOYXfoyLT/Xa8JhBe8qABQEiWtITJP
 AKkr2FR5U4R9MyZrUgkiGPYWFHmxDSZHcw4jQoXlfarOfnEyLrZGr/j6mdfWAfAR
 Z63x3ESQ9J6e8AR/P+Y0tOcW9+eDtZND13IcpdH6r/MYk8fVSq2Ve1NAQOU13+5H
 pPV65wkXUurRVoxxdKKbkxylsTOeqAUkJDOCh2SlqEGVMl0rh7QJ4b1DVU6T8EB0
 msBTOdEV7LBRNCcO755ALBiwQnZW89Jy84BRLZKdr/o4tA076GJyJS5S8zoWFIoJ
 NxNLw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mewhrff4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 19:11:19 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46QJBIFp012456;
 Fri, 26 Jul 2024 19:11:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mewhrfex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 19:11:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46QH6Kkn005773; Fri, 26 Jul 2024 19:11:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2pvmkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 19:11:17 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46QJBEqX8913474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jul 2024 19:11:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80E2358054;
 Fri, 26 Jul 2024 19:11:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 877D75804E;
 Fri, 26 Jul 2024 19:11:13 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Jul 2024 19:11:13 +0000 (GMT)
Message-ID: <474aa180-431d-4724-945d-8e7dc4b91228@linux.ibm.com>
Date: Fri, 26 Jul 2024 15:11:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/s390x: filter deprecated properties based on
 model expansion type
To: Markus Armbruster <armbru@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, thuth@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 Jiri Denemark <jdenemar@redhat.com>
References: <20240719181741.35146-1-walling@linux.ibm.com>
 <87h6cksk4h.fsf@pond.sub.org>
 <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com>
 <87bk2nrzou.fsf@pond.sub.org>
 <9f8023a4-3edd-476f-9243-677138be3921@linux.ibm.com>
 <87cyn2ugyi.fsf@pond.sub.org> <87v80tudo7.fsf@pond.sub.org>
 <d20cdad7-89c2-47f7-8acf-dcce767d8db5@redhat.com>
 <fa452b18-d19c-4d00-a566-3ec82d53b153@linux.ibm.com>
 <87ed7gipxu.fsf@pond.sub.org>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <87ed7gipxu.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vLzCxmucZdRcQ5aYKiMKkf1sBOYYedxt
X-Proofpoint-ORIG-GUID: fdS6zQbT1aLssRIJ-uF70Sk5eh8V4EDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260128
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

On 7/26/24 3:15 AM, Markus Armbruster wrote:
> Collin Walling <walling@linux.ibm.com> writes:
> 
>> On 7/25/24 3:39 AM, David Hildenbrand wrote:
>>> On 25.07.24 09:35, Markus Armbruster wrote:
>>>> Markus Armbruster <armbru@redhat.com> writes:
> 
> [...]
> 
>>>>> Arguments that are silently ignored is bad interface design.
>>>>>
>>>>> Observe: when CpuModelInfo is an argument, @deprecated-props is always
>>>>> ignored.  When it's a return value, absent means {}, and it can be
>>>>> present only for certain targets (currently S390).
>>>>>
>>>>> The reason we end up with an argument we ignore is laziness: we use the
>>>>> same type for both roles.  We can fix that easily:
>>>>>
>>>>>      { 'struct': 'CpuModel',
>>>>>        'data': { 'name': 'str',
>>>>>                  '*props': 'any' } }
>>>>>
>>>>>      { 'struct': 'CpuModelInfo',
>>>>>        'base': 'CpuModel',
>>>>>        'data': { '*deprecated-props': ['str'] } }
>>>>>
>>>>> Use CpuModel for arguments, CpuModelInfo for return values.
>>>>>
>>>>> Since @deprecated-props is used only by some targets, I'd make it
>>>>> conditional, i.e. 'if': 'TARGET_S390X'.
>>>>
>>>> If we want just query-cpu-model-expansion return deprecated properties,
>>>> we can instead move @deprecated-props from CpuModelInfo to
>>>> CpuModelExpansionInfo.
>>>
>>> That might a bit more sense, because deprecated-props does not make any 
>>> sense as input parameter, for example.
>>
>> Will do.  Thanks for the feedback.  v4 in the works.
> 
> We better get this into 9.1.  Plan B: mark @deprecated-props unstable to
> avoid backward compatibility pain.
> 
> 

Agreed, it would go a long way to squeeze this in before things get too
messy.

v4 is posted.  I think Thomas is unavailable, so if @David would not
mind handling this?  I'm confident that including this data within the
expansion response is the right way to go.  If there are any lingering
discrepancies WRT documentation, that can be fixed later.

-- 
Regards,
  Collin


