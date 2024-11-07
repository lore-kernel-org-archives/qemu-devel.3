Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD25BD43352
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 11:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t919g-0003RC-6n; Thu, 07 Nov 2024 06:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t919e-0003QS-8S
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:58:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t919c-0002PT-6m
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:58:25 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7BeBVb021218;
 Thu, 7 Nov 2024 11:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=c/QwVk
 lal6MHkWodk/BJL5hd4p3nz9uhWuI15+giT1g=; b=ZuyYpjQJn9FOjq5LD17Q+R
 CuHSKrWMA5CGZcXVSa6FgmNcf81EQu6jkmbhJ1zXWnC7jcwHCDG9fTuQ/Uyd8YIT
 e5Nk3zQqTsJXVr5hw6xD4zt8jEqir4HZ3DQzcPzdsXbI0BeUXZbKR8QBc13oyE2s
 B9MMZShQCeRzDRtTC7XdXF17h3XYbuDRHdLPeJhPWV+6nAYkBRdWzzEyccA/AQMK
 qrqtXKyX+c6hU5FTVrI/K2W+xy/Q1f00aGdz1fAY3br9X5NB03NkGrMjH/7ZYY2N
 lx7XJhEtPn0xEDlLGKdYn+5YOax5ANU2gD6YEyJr/26fiSJBXmIDPpnuWhZC765A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rvvjg1kt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Nov 2024 11:58:21 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A7BwKRE026559;
 Thu, 7 Nov 2024 11:58:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rvvjg1kr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Nov 2024 11:58:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7BtwdR008433;
 Thu, 7 Nov 2024 11:58:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywm5u0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Nov 2024 11:58:20 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A7BwJJY48824608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Nov 2024 11:58:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D2DA58059;
 Thu,  7 Nov 2024 11:58:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69D245805B;
 Thu,  7 Nov 2024 11:58:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 Nov 2024 11:58:18 +0000 (GMT)
Message-ID: <cd0732c9-e5ae-4dd8-b48a-4ac769cece05@linux.ibm.com>
Date: Thu, 7 Nov 2024 06:58:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: Adjust path for swtpm state to use path under
 /var/tmp/
To: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, clg@redhat.com,
 lena.voytek@canonical.com
References: <20241106180751.6859-1-stefanb@linux.vnet.ibm.com>
 <CAFEAcA8P-a5XyACAovFLwCSPT-s0CX74aMKoPtHku0G89cYgkA@mail.gmail.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFEAcA8P-a5XyACAovFLwCSPT-s0CX74aMKoPtHku0G89cYgkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: doI3Gf5mC_K6Ll4rSa0cF_6Lpa1EPcjt
X-Proofpoint-ORIG-GUID: eF3ktXyxZU7i-CPaiHGFMSiMSKGT6zVr
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 11/7/24 6:09 AM, Peter Maydell wrote:
> On Wed, 6 Nov 2024 at 18:08, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>>
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> To avoid AppArmor-related test failures when functional test are run from
>> somewhere under /mnt, adjust the path to swtpm's state to use an AppArmor-
>> supported path, such as /var/tmp, which is provided by the python function
>> tempfile.TemporaryDirectory().
>>
>> An update to swtpm's AppArmor profile is also being done to support /var/tmp.
>>
>> Link: https://lore.kernel.org/qemu-devel/CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com/
>> Link: https://github.com/stefanberger/swtpm/pull/944
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Thanks for writing this patch. I can confirm that the test now
> runs OK on my Ubuntu setup, so

That's good to hear. However, it surprises me because the tests probably 
use /var/tmp/ as temp dir and that's no supported in the AppArmor 
profile yet.

> 
> Tested-by: Peter Maydell <peter.maydell@linaro.org>
> 
>> ---
>>   tests/functional/test_arm_aspeed.py | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
>> index 9761fc06a4..a574b1e521 100644
>> --- a/tests/functional/test_arm_aspeed.py
>> +++ b/tests/functional/test_arm_aspeed.py
>> @@ -227,11 +227,11 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
>>
>>           image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
>>
>> -        socket_dir = tempfile.TemporaryDirectory(prefix="qemu_")
>> -        socket = os.path.join(socket_dir.name, 'swtpm-socket')
> 
> I think it would be helpful to add a brief comment here:
>             # We must put the TPM state dir in /tmp/, not the build dir,
>             # because some distros use AppArmor to lock down swtpm and
>             # restrict the set of locations it can write to.
> 
> just as a guard against somebody in future coming along and
> trying to clean up/rationalize where tests are creating their
> temporary files.
> 
>> +        tpmstate_dir = tempfile.TemporaryDirectory(prefix="qemu_")
>> +        socket = os.path.join(tpmstate_dir.name, 'swtpm-socket')
>>
>>           subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
>> -                        '--tpmstate', f'dir={self.vm.temp_dir}',
>> +                        '--tpmstate', f'dir={tpmstate_dir.name}',
>>                           '--ctrl', f'type=unixio,path={socket}'])
>>
>>           self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
>> --
>> 2.34.1
> 
> thanks
> -- PMM
> 


