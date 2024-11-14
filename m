Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68338D6A25B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 23:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBjIu-0003FY-IN; Thu, 14 Nov 2024 18:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBjIs-0003F4-33; Thu, 14 Nov 2024 18:31:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBjIj-0003Hw-TS; Thu, 14 Nov 2024 18:31:08 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEMeSQ1012648;
 Thu, 14 Nov 2024 23:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dehG7V
 Uc4jFEMsMF1aco/E3l4ant4JgVCJQbD6Wlchk=; b=tfsSVkaVzCgl+AuAxf9mI5
 0oS3fqx9+726DJsUG6IXKiDPEhlKsdUDGSr2ky2EyRiLOk5Wjyj8r6QOhyKj0A7v
 e9GeVkIIKHdyiy9RbGuZtAYNVYqsEQuh6loYIzO8yuiuOz+p46kUQEVqjWYgrQdd
 USuDO4NhtSDY43Ifkhp45G/B/JV7Fml1lWN/MnKBj9w3algnIE+tmqbnP9+/JOHQ
 ES/e5V+miqYolPVpqg/ZcWv5CTw1gcxhkvRnBnhCuTdoSjec+nXqGD3Ob6ARDGzP
 G7DGFc/yRG4QLy4r+XUbx9IBz2OxXk6/NfA1nDSbmczQ/s3sxAsYIEuqCUMgF66g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wt6w84hj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2024 23:30:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEJmxOi017527;
 Thu, 14 Nov 2024 23:30:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tk2n1aat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2024 23:30:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AENUrJQ47841678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 23:30:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C6BC58059;
 Thu, 14 Nov 2024 23:30:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BA5058053;
 Thu, 14 Nov 2024 23:30:52 +0000 (GMT)
Received: from [9.61.167.191] (unknown [9.61.167.191])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 14 Nov 2024 23:30:52 +0000 (GMT)
Message-ID: <31889800-47fc-4ee0-8016-58a9d82b2719@linux.ibm.com>
Date: Thu, 14 Nov 2024 18:30:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: Add "loadparm" property to scsi disk devices for
 booting on s390x
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Farman <farman@linux.ibm.com>
References: <20241114122919.973930-1-thuth@redhat.com>
 <9e7cb217-a33e-48aa-b030-efb991ca33f3@linux.ibm.com>
 <f0315077-eb61-4134-b81a-7d33906c6d31@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <f0315077-eb61-4134-b81a-7d33906c6d31@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ajm8X54Qze_ecVHhLW0zeV7rtW3lSUuI
X-Proofpoint-GUID: ajm8X54Qze_ecVHhLW0zeV7rtW3lSUuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=908 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140182
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 11/14/24 12:47 PM, Thomas Huth wrote:
> On 14/11/2024 16.55, Jared Rossi wrote:
>>
>>
>> On 11/14/24 7:29 AM, Thomas Huth wrote:
>>> While adding the new flexible boot order feature on s390x recently,
>>> we missed to add the "loadparm" property to the scsi-hd and scsi-cd
>>> devices. This property is required on s390x to pass the information
>>> to the boot loader about which kernel should be started or whether
>>> the boot menu should be shown. But even more serious: The missing
>>> property is now causing trouble with the corresponding libvirt patches
>>> that assume that the "loadparm" property is either settable for all
>>> bootable devices (when the "boot order" feature is implemented in
>>> QEMU), or none (meaning the behaviour of older QEMUs that only allowed
>>> one "loadparm" at the machine level). To fix this broken situation,
>>> let's implement the "loadparm" property for the SCSI devices, too.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   NB: Unlike the ccw_device_set_loadparm() logic that we use for CCW
>>>       devices, I've decided to use a string property for the "loadparm"
>>>       in the SCSI devices to avoid spoiling the common code with too 
>>> much
>>>       s390x logic. So the check for valid characters is now done 
>>> after the
>>>       property has been set, i.e. we only print out an error instead of
>>>       forbidding the setting (like we do it with the CCW devices), 
>>> which
>>>       is IMHO still perfectly acceptable. Or are there other opinions?
>>
>> I wasn't able to think of a way to abuse passing invalid characters, 
>> but I did
>> find two additional differences about the string approach:
>>
>> a) it is not possible to override the machine loadparm by assigning 
>> an empty
>>   string (loadparm="") to the device
>
> Agreed, that's a (small) problem. There does not seem to be a way to 
> distinguish between "property has not been set" and "property has been 
> set to a string with zero length" with object_property_get_str() ...
>
>> I don't think that the inability to pass the empty string is a 
>> significant
>> problem because passing a single space will have the same effect.
>
> That sounds like a good work-around, indeed.
>
> > b) it is possible to assign a loadparm value to a non-boot device
> >
>> Assigning a loadparm to a non-boot device generally does nothing, but 
>> in the
>> case of device probing (i.e. no boot devices assigned at all), the 
>> device with
>> the loadparm assigned could be selected for IPL, but it will not use the
>> assigned loadparm (because no IPLB was generated for the device). 
>> This check is
>> normally handled by ccw_device_set_loadparm(), but I'm not sure if 
>> there is a
>> way to do the validation without having a setter function for the 
>> property.
>
> Hmmm, that could be confusing for the users, indeed. But maybe it 
> would be sufficient
> to properly document that loadparm is only working for devices with a 
> bootindex?
> What do you think?
>
> By the way, the loadparm section in docs/system/s390x/bootdevices.rst 
> looks like it should get an update, too ... if you have some spare 
> minutes, could you maybe look at it?
>

Yes, I suppose I would agree that documenting the behavior is sufficient 
in this case.  I will update bootdevices.rst to include per-device 
loadparm support and also indicate that that per-device loadparm values 
are only used for devices that have an assigned bootindex.

Thanks,
     Jared Rossi



