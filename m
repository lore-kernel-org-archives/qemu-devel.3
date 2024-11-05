Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551A9D3E775
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8RRw-0002Ce-4L; Tue, 05 Nov 2024 16:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t8RRr-0002C5-Jf; Tue, 05 Nov 2024 16:50:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t8RRp-0003ak-PK; Tue, 05 Nov 2024 16:50:51 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5Le0Av024574;
 Tue, 5 Nov 2024 21:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SCRzrw
 oqB2kaM1wSKS8SxCklGv3d16pW68d1Gs0FUmY=; b=OQPQBUoTlI19LXRzseEJBR
 llZueAk7FonSd2GgAg5ApDzGQktAX+ccCxXgIte+Bbpwxs7bQ2P9gnXfsk4/Ds9p
 Hcc1uaggQHcC2MUKKaZO2pqsVsRslq1Vg1wJZ1ZAGr6qHyBQjCI9dgmoJHZ7It7A
 +NC7eueTJKzRREV8Y/BlcSRDnr9et7lgcujIXOyX5Zx5fkWHCX3vugwzRTnCXyKh
 iF3Q4FBtsiW0ATLHizasamCX0pHWh4a7CucdGEvENyrKou0g9b6JZ6SKAoR9NEyr
 AzFxcaXbsKx2YzSdA91rB/cewHQ0pOoj/F8V+Mefc17FMEgE+4PeC8hwcL3gc5RA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qufn01bd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 21:50:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5K3LuA008470;
 Tue, 5 Nov 2024 21:50:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywkmbkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 21:50:43 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A5Logqq40960730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2024 21:50:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D78A358063;
 Tue,  5 Nov 2024 21:50:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69FB458056;
 Tue,  5 Nov 2024 21:50:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2024 21:50:42 +0000 (GMT)
Message-ID: <60734922-c31d-4a24-865e-45d03ff53141@linux.ibm.com>
Date: Tue, 5 Nov 2024 16:50:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/17] tests/functional: Convert most Aspeed machine tests
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
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFEAcA_awJURkAhyhz88iEyfe7BU-ApeHB8XZ5EeThoKFh3p5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rXxAu0hM8-7JEzrCZZ0I1OLMo11gWmPs
X-Proofpoint-GUID: rXxAu0hM8-7JEzrCZZ0I1OLMo11gWmPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050167
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



On 11/5/24 4:34 PM, Peter Maydell wrote:
> On Tue, 5 Nov 2024 at 20:12, Stefan Berger <stefanb@linux.ibm.com> wrote:
>> On 11/5/24 2:54 PM, Peter Maydell wrote:
>>> On Tue, 5 Nov 2024 at 18:36, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>> Anyway, the thing here is that we run swtpm like this:
>>>
>>>    swtpm socket -d  --tpm2 --tpmstate dir=/path/to/somewhere --ctrl
>>> type=unixio,path=/path/to/socket
>>>
>>> where we use command line arguments to tell it where to
>>> put the tpmstate and the socket.
>>>
>>> Either:
>>>    (1) there are places where it's not valid for us to tell swtpm to
>>> put the tpmstate or to put the control socket
>>>    (2) it's valid to put those anywhere we like
>>>
>>> If (1), then swtpm should give a clear error message that we've
>>> given it an invalid argument (and its manpage should say what
>>> the restrictions are)
>>
>> There are no restrictions on the swtpm level when it comes to paths.
> 
>>> If (2), then apparmor should not be rejecting this usage
>>
>> AppArmor file restrictions are all path based. We have support for home
>> directory and /tmp, but were missing /var/tmp. So, please.
>>
>>   > > One of swtpm or apparmor must be wrong here and I think it should
>>> be fixed. In particular, having the failure mode be "something
>>
>> As stated, we were going to fix the AppArmor path in the swtpm Ubuntu
>> package.
> 
> But AIUI the solution you've proposed is to add the user
> temp directory -- abstractions/user-tmp looks like it
> adds permissions for $HOME/tmp, /var/tmp and /tmp/. None
> of those will fix the failure we ran into, because we're not
> using any of those tmp directories. We use a directory
> that's a subdirectory of wherever the user put the build
> directory, which can be anywhere the user has permissions for.

Yes, you are right. The same test failed for me locally due to the usage 
of /var/tmp/ path but that's not what was originally reported.

I am not aware that user-started programs can have an exception from 
having their profiles applied, nor do I know whether rules exist that 
allow a user to circumvent any rule. So my guess is we need rules like 
either one of the following:

owner /mnt/** rwkl

or worse:

owner /** rwkl

I don't see another choice than adding one of these rules, maybe even 
the 2nd. Lena?

> 
> That's why I'm confused -- as far as I can see the only
> way to make swtpm work the way its documentation says it
> should work is to for apparmor to permit anything
> (or at least to permit anything that matches the file paths
> the user handed swtmp, if it can do that).

and from what I know we need explicit rules for allowing paths.

> 
> Or if you want to say "this has to be in one of these
> handful of authorised /tmp/ directories", then it should
> say that in the manpage and check that at init time, not fail
> near-silently much later. At the moment the docs and the
> distro-integration of swtmp disagree, and the effect for
> somebody trying to use it is very confusing.

We haven't run into this type of a problem with paths in a while. The 
applications return 'permission denied' but to find the exact reason 
(LSM) for it one may have to dig into the audit log.

> 
> thanks
> -- PMM


