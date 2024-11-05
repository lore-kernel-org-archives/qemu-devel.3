Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956EBD36136
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 20:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8PuR-0003iy-H0; Tue, 05 Nov 2024 15:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t8PuP-0003iY-AF; Tue, 05 Nov 2024 15:12:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t8PuN-00008q-DJ; Tue, 05 Nov 2024 15:12:13 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5K9koW011254;
 Tue, 5 Nov 2024 20:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6MA16X
 X6XU3OtjaydPQakNJtKjsrUu1XWRaI44weWzo=; b=oboUyLYIjDFj9ACI39MihT
 emepyov+80th++z/JWQu4t2wQ78icRDXxPWr51ofrwEI65QB/eqt2IaSIlFjTm52
 4XWxXVidclPdjQZCSfsXuODmSVA/uvXt5uL0UjZ9Kvp9pZhBgF9PplmddK01uXrw
 L8G9dhMyJDQPhec+92widRxZ26N5bFi8vqifr6BU5FBNG8fjdWoOjBqQ6j66CcB3
 nZLXHVzKeL/u+4dBHWBIwmbaBBtEnnfqSE5nNd2xL3udTEXBT8FeR2fTAAMPPUGl
 pqSAPCfYKUa9Mm6LntMFye3Od4E/OuleBVaz8j/eRJydmjiyUUPty5WCK/YLLBBw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qt5gg0jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 20:12:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5H58hJ024707;
 Tue, 5 Nov 2024 20:12:05 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nxds4ude-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 20:12:05 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A5KC5ai54198752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2024 20:12:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F26D258052;
 Tue,  5 Nov 2024 20:12:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88B3B58056;
 Tue,  5 Nov 2024 20:12:04 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2024 20:12:04 +0000 (GMT)
Message-ID: <1a1d29b3-c14c-42a9-93ad-c773e3b265df@linux.ibm.com>
Date: Tue, 5 Nov 2024 15:12:04 -0500
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
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFEAcA9La7y1Z2-nMnJDyC_p+z-3c0EnDzEE=w5LTYtRnXPT1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e7Qcv_TnRnuXueEDDGJCRYmvGSsu7o67
X-Proofpoint-GUID: e7Qcv_TnRnuXueEDDGJCRYmvGSsu7o67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050155
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



On 11/5/24 2:54 PM, Peter Maydell wrote:
> On Tue, 5 Nov 2024 at 18:36, Stefan Berger <stefanb@linux.ibm.com> wrote:
>> On 11/5/24 1:12 PM, Peter Maydell wrote:
>>> On Tue, 5 Nov 2024 at 18:02, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>> On 11/5/24 12:13 PM, Peter Maydell wrote:
>>> Is there no way to just have apparmor not apply at all
>>> here? I can see why you might want it to apply for the
>>
>> If you are root you can change things. I have shown the options using
>> aa-complain and aa-disable that you can revert once the test has
>> finished: sudo aa-enforce /usr/bin/swtpm
>>
>> You could also copy swtpm into a user-owned directory but you will have
>> to adapt the user's PATH. That's an easy option.
>>
>> The most compatible option is the 3rd option since I would expect that
>> we will have this rule in a future version of the usr.bin.swtpm Ubuntu
>> profile provided by the swtpm package:
>>
>> echo "include <abstractions/user-tmp>" >>
>> /etc/apparmor.d/local/usr.bin.swtpm
>> apparmor_parser -r /etc/apparmor.d/usr.bin.swtpm
>>
>>> case of "I'm using it as part of a sandboxed VM setup",
>>> but in this scenario I am a local user running this binary
>>> which is not setuid root and it is accessing a file in a
>>> directory which my user owns and has permissions for.
>>> This should not be being rejected: there is no security
>>> boundary involved and swtpm is not doing anything
>>> that I could not directly do myself anyway (as you
>>> can tell from the fact that copying the swtpm binary
>>> to a different location and running it works).
>>
>> I am not aware of how user/non-root-started programs can be generally
>> made exempt from AppArmor.
>>
>> There may still be a security boundary if a user runs QEMU and swtpm was
>> able to manipulate (with malicious input) the user's files in some
>> undesirable way or copy the user's data elsewhere. In this case it may
>> be desirable for the user that the profile be applied and the PATH he is
>> using points to the standard swtpm.
> 
> But our test makefiles could equally well just run "cp" !
> swtpm has no privilege here that we do not already have.
> 
> Anyway, the thing here is that we run swtpm like this:
> 
>   swtpm socket -d  --tpm2 --tpmstate dir=/path/to/somewhere --ctrl
> type=unixio,path=/path/to/socket
> 
> where we use command line arguments to tell it where to
> put the tpmstate and the socket.
> 
> Either:
>   (1) there are places where it's not valid for us to tell swtpm to
> put the tpmstate or to put the control socket
>   (2) it's valid to put those anywhere we like
> 
> If (1), then swtpm should give a clear error message that we've
> given it an invalid argument (and its manpage should say what
> the restrictions are)

There are no restrictions on the swtpm level when it comes to paths.

> If (2), then apparmor should not be rejecting this usage

AppArmor file restrictions are all path based. We have support for home 
directory and /tmp, but were missing /var/tmp. So, please.

 > > One of swtpm or apparmor must be wrong here and I think it should
> be fixed. In particular, having the failure mode be "something

As stated, we were going to fix the AppArmor path in the swtpm Ubuntu 
package.

> goes wrong after swtpm has successfully started and only once
> it gets sent the TPM_INIT command, and the information about it
> only winds up in the syslog" is pretty awkward -- it would
> be much nicer if it failed fast, as soon as you ran it, and
> printed the error to stderr.
> 
> In the interim, since we'd like to be able to run the test suite
> on Ubuntu, it sounds like we can work around this by putting
> the tpmstate and socket in either /tmp/ or somewhere under
> the user's home directory.

Right, I gave several options.

> 
> thanks
> -- PMM
> 


