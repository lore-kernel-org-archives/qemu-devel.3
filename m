Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A954D44D78
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 15:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8hqb-0002r4-BU; Wed, 06 Nov 2024 10:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t8hqZ-0002qo-Fi; Wed, 06 Nov 2024 10:21:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t8hqX-00073w-Jv; Wed, 06 Nov 2024 10:21:27 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6F8ESX007256;
 Wed, 6 Nov 2024 15:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4bFpLa
 ltumf2qLsclcMeWZujkgU4sJrxb2XK7RLIDjE=; b=VXZM58jjxxeoVafZPcd/qs
 14PTTMj+UVu2BxFjCpdtSndfrSibXO466gh37ner5MYr/h/xmC9CclWI8kzKgPGs
 3qDQZZBSgAwZFyojYrjV1EUGuK0FR5wZsyeGAO90WoaXVuZFz+ZHSJw/6xtHrpYZ
 ADrXHfunfzrfCvqHNRVHKOdJHH62RnehXdxvyJsGPOQHJh+NESCankb+4t3kIU6q
 cLIEqiuRORmeh5Y6d897tAa4BY3u3wIGyiWRXp0+Xdydg/VaismQXe8ewauphIuo
 oPrwUFApeJ00VS7JullBpgmqSuBWtQ5HXnekM4yXkhbK1lXWUPJssPp58K8/YqMg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42radvg81f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Nov 2024 15:21:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6EMV5C024200;
 Wed, 6 Nov 2024 15:21:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nxds6fyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Nov 2024 15:21:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A6FLIU934537976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Nov 2024 15:21:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AD1858056;
 Wed,  6 Nov 2024 15:21:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C35858052;
 Wed,  6 Nov 2024 15:21:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Nov 2024 15:21:17 +0000 (GMT)
Message-ID: <08fd5270-8223-419e-b5ec-075b14c42c09@linux.ibm.com>
Date: Wed, 6 Nov 2024 10:21:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/17] tests/functional: Convert most Aspeed machine tests
From: Stefan Berger <stefanb@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, lena.voytek@canonical.com
References: <20241024063507.1585765-1-clg@redhat.com>
 <20241024063507.1585765-11-clg@redhat.com>
 <CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com>
 <91c2ac92-66b2-45c8-b4fe-e8f8587b0e9c@linux.ibm.com>
 <CAFEAcA84hhWu2ouirfDPbCpq_=QLQxAf3k47h0Pij8iEnOVj+A@mail.gmail.com>
 <2491bc60-9a0b-486a-8f6d-2c4c94332756@linux.ibm.com>
 <CAFEAcA85g2nX3MU5RzmBvAHT8Kis1JHhiEaBvnFFbEQkG+0OxQ@mail.gmail.com>
 <e6c33df3-49e9-4b8a-b7cb-d38c2ebee3be@linux.ibm.com>
 <CAFEAcA9La7y1Z2-nMnJDyC_p+z-3c0EnDzEE=w5LTYtRnXPT1g@mail.gmail.com>
 <1a1d29b3-c14c-42a9-93ad-c773e3b265df@linux.ibm.com>
 <CAFEAcA_awJURkAhyhz88iEyfe7BU-ApeHB8XZ5EeThoKFh3p5w@mail.gmail.com>
 <60734922-c31d-4a24-865e-45d03ff53141@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <60734922-c31d-4a24-865e-45d03ff53141@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ppOVMKymP4RT8U8y9u1nX49u0-uGOVbu
X-Proofpoint-ORIG-GUID: ppOVMKymP4RT8U8y9u1nX49u0-uGOVbu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=609
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060118
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 11/5/24 4:50 PM, Stefan Berger wrote:
> 
> 

>>>
>>>   > > One of swtpm or apparmor must be wrong here and I think it should
>>>> be fixed. In particular, having the failure mode be "something
>>>
>>> As stated, we were going to fix the AppArmor path in the swtpm Ubuntu
>>> package.
>>
>> But AIUI the solution you've proposed is to add the user
>> temp directory -- abstractions/user-tmp looks like it
>> adds permissions for $HOME/tmp, /var/tmp and /tmp/. None
>> of those will fix the failure we ran into, because we're not
>> using any of those tmp directories. We use a directory
>> that's a subdirectory of wherever the user put the build
>> directory, which can be anywhere the user has permissions for.
> 
> Yes, you are right. The same test failed for me locally due to the usage 
> of /var/tmp/ path but that's not what was originally reported.
> 
> I am not aware that user-started programs can have an exception from 
> having their profiles applied, nor do I know whether rules exist that 
> allow a user to circumvent any rule. So my guess is we need rules like 
> either one of the following:
> 
> owner /mnt/** rwkl
> 
> or worse:
> 
> owner /** rwkl
> 
> I don't see another choice than adding one of these rules, maybe even 
> the 2nd. Lena?

If there was value in the path-confinement of swtpm (for a few years) do 
we really want to loose it now because of a test case? We could either

- adjust the test case to have swtpm use a directory under one of the 
accepted paths, e.g., /tmp or /var/tmp
- or add /mnt as a newly supported path to the AppArmor profile

The latter works for the setup that Peter has but a new user creating 
paths under /mymnt would cause the same discussion again.


    Stefan


