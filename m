Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22194D68B38
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcy6-00055Q-Vp; Thu, 14 Nov 2024 11:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBcy5-00055A-NR; Thu, 14 Nov 2024 11:45:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBcy3-0007hX-BS; Thu, 14 Nov 2024 11:45:17 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEGSljP006967;
 Thu, 14 Nov 2024 16:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9Kwkg9
 ssAcnO5yLvTRpsdyCXR8njCFnTxhTk4QpRt70=; b=hjptzpl7xqDFumpDa1dNyr
 bZFPV7NQc6YMqTDppZ3AmpMq7+S2u5N2aX4u0cf4djkvDBbb5O/RodnUHLFNIxvW
 cbDR42MBscQRoNVsbpW6lUoQKQZMfDrpAxkrIlylysjHty97jlKWhDOQb+jte0P9
 M13VkLlPU/y0IpOlG6Lnc9drWwcRJ8JzKXPFwJuleCt15V3oDJ/MsJCdamdgfzu4
 sQ3j34bf0H5mUKOj6jyeMiXJRSkWinInwW8Z7C8Xwvo8sPrAbKWdQOhCX9K4f6V+
 qLh35CLv/urrT9jvBSHIxLSbrPK0qNDfSll2WCeWk8QNHEs5J5AQo+LRZmOOIzFw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wkkv0f0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2024 16:45:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEGBELx008243;
 Thu, 14 Nov 2024 16:45:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjf09m9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2024 16:45:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AEGjAwX59900306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 16:45:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A170258056;
 Thu, 14 Nov 2024 16:45:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 193CF5803F;
 Thu, 14 Nov 2024 16:45:10 +0000 (GMT)
Received: from [9.61.167.191] (unknown [9.61.167.191])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 14 Nov 2024 16:45:10 +0000 (GMT)
Message-ID: <cb59817c-e9ba-4d64-913c-b68d640cde8c@linux.ibm.com>
Date: Thu, 14 Nov 2024 11:45:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Restrict "loadparm" property to devices that
 can be used for booting
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>
References: <20241113114741.681096-1-thuth@redhat.com>
 <bc1e420a-65c1-4e11-901e-24e55dc2265f@linux.ibm.com>
 <a3d5ecee-3959-4136-a29c-1f7ec36831e3@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <a3d5ecee-3959-4136-a29c-1f7ec36831e3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pgXORHDchoZZuLPySsXjubIEkHZ_RO77
X-Proofpoint-GUID: pgXORHDchoZZuLPySsXjubIEkHZ_RO77
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140130
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 11/14/24 7:39 AM, Thomas Huth wrote:
> On 13/11/2024 15.49, Jared Rossi wrote:
> ...
>> Hi Thomas,
>>
>> Thanks for putting this fix together.  As we previously discussed, I 
>> do agree
>> that my naive implementation of the “loadparm” property at the top-level
>> CcwDevice was not satisfactory, and certainly virtio-gpu and 
>> virtio-tablet
>> should not have a “loadparm.”
>>
>> The reason I had not yet submitted a fix is that I’ve gotten some 
>> feedback from
>> the Libvirt side that suggests the CcwDevice implementation is not 
>> sufficient
>> in general.  Libvirt will require that non-ccw devices (e.g. scsi-hd) 
>> also
>> support per-device loadparm.  I do not yet know how to add that type 
>> of support
>> and given that we are in hard freeze I’m not sure it is possible now.
>>
>> Obviously this is not ideal, and I truly do apologize for the confusion.
>
>  Hi Jared,
>
> yes, that scsi-hd problem is a little bit tricky, since it's common 
> code that we should not "pollute" too much with s390x specific stuff, 
> especially since we're in hard freeze now.
>
> After staring at the code for quite a while, I think one option might 
> be to just add a string "loadparm" property to the SCSI devices, 
> that's just a simple two-line change to the common code. Patch 
> suggestion can be found here:
>
>  https://lore.kernel.org/qemu-devel/20241114122919.973930-1-thuth@redhat.com/ 
>
>
> The only disadvantage is that this is now checking for valid 
> characters in the string after the property has already been set, so 
> it cannot prevent the setting of bad characters. But it still prints 
> out an error message later, so I hope that is also still acceptable.
>
> Let me know what you think about it!
>
>  Thanks,
>   Thomas
>
Thanks Thomas,

I replied to the patch as well, but the setter does other validation 
beyond just the characters.  In particular it ensures a loadparm value 
is assigned only to boot devices.  This has significance when probing 
for devices, since the per-device loadparm value is stored in the IPLB, 
and an IPLB is only generated for devices with an assigned boot index.

I would say the scsi loadparm probing issue is actually a legitimate 
concern since it can result in unexpected behavior with which kernel is 
selected, but probably we want to avoid adding too much s390x specific 
validation to the common code, so I'm not sure what the best solution 
is.  Maybe there is a better way to restrict the loadparm to boot 
devices that doesn't need the property setter?

On a side note, while testing your patch I also realized that the 
machine loadparm was being ignored during probing, so I've sent out a 
patch to fix that...

Thanks again for all the help with this,
     Jared Rossi

