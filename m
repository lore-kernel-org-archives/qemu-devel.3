Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02C9C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KLZ-0004SH-91; Thu, 17 Sep 2026 18:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KLX-0004Q2-IV
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:12:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KLV-00071v-19
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:12:47 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HLG8a93271956
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YPPM0cIFQ4yFpEpnmvxkQzI1Qkj8qkq+H0Xbbxhx7Ac=; b=V6Lzy+nG+rPHjZP8
 QqgX3JzhTr/AkbVbfxtkNS9hsMF79jK+vjxpZiNH09LrfjpROg2WTsJHkGHk5Mhd
 /TmF0j530KvIDF978OFtwXvyn6+NwlkHU8OpTYWxm4s16vvs48KXVy7vLiw6qoZ8
 beQl6rnO56gD8vFvToC6WjbIxwUmkIKYCK7YkHCpmYXfzZ1+OsfrExj6o9Q04E1W
 YvaovmkN1/wIXdarwEYleRoZSh96hxG+Vu7UzXxrYM1XLtpMXIh7BaTxyt3CuY27
 O44UgtgZgFlN0QPET415hETGDeXOgX7OPr6g/0w456oyMQbxScmsj34LrJzpQDDW
 UJ/Kuw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grfppjsh5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:12:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39de1f85cb2so173243a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789683162; x=1790287962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YPPM0cIFQ4yFpEpnmvxkQzI1Qkj8qkq+H0Xbbxhx7Ac=;
 b=Ko01nZLIEl9svlQ1K2bVDtatP8Zv0G8KmarT0UXAVgCkvkcEoUUn6fHHzm/0le3R+Z
 2aYhuly4AJHj2OxH8cEw14pC2QaR8iUJeNIal8CnDlJgQIaAmV5zoKB0yeEOKEQWHRuM
 Or+Kax1wGj8rmJ7QbN78D39CkHnvM3wLNFz2dIcmkD+bbg3mbIC9JRVSnYCNuBUWkeul
 NfoTQasQ1UPCfs83MbRqA3iq/CxiNgSsT5nWNP2RZHiOHE4YtgGEvBHsiRmUNvRiGylP
 t1bfKUYsPlIKU43gbWRS4ixyu6yJYk8RBiyQX/ceMRN8PwZaWRqAccfGdwVv0QWBa9Oe
 EDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789683162; x=1790287962;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YPPM0cIFQ4yFpEpnmvxkQzI1Qkj8qkq+H0Xbbxhx7Ac=;
 b=eOejX6ndXHpWHIJdJxZ4mS2q4/tRK3Pnn5yNKeipaFWdTDrnllAN7J2qHiiX4EFKMn
 QAzoPYoY/KgDV4RIyUQzQSOqh6gV5zh9RMqMDtqsZuEK7lzu2743ZA17SirEkC0uQPtq
 D3+MTmqETr5+A1vKY/X36IiY2hpfjjv/yshYbSXwZZ3fXDm5+M1LSoxP9TtFFMTI/iy7
 g7wuIJ2Yqce44g289V3ZFnCRvI7aVSSZT5o1C79aqgMNDj4ncSGchKML/fsNCl2kHbNM
 gNYQYlb2QY8QkPOYSEG+yapdFa6ipqJvbea0NWZen3CZI77FBFh27X5nHLiquHuMh0kt
 BU2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFzpuMbtP5TCF+nae/LSTneyIfhQ55HYTw1f8ATBTvaOTJ7YYtND2pJfWfof+qp5y4BkVGTiXK/0qv@nongnu.org
X-Gm-Message-State: AFuF++kzj1pYud6vzjpjlOxtgW+saMkxrBzyEt0Wd3cIu5rq4cbZAtsu
 9oZLolXd0iWYzWkFUbX1n+pA7/TX55BZyZQgCVXv4Y9CaPPpo5WwZKpo1oves+1sGXmdbv4KmMi
 qmvX0dSrQTeSSaRcASZ3MelisEkmvzIvYxINZHK761MobRoETuuTAQO/5xyOE2AsuIQ==
X-Gm-Gg: AYBFou3pHdKygPLmvvBeLro7FOGQ6o06HFHvIXErKO/CLRYT7soKCXjHLUhARz4BgbX
 1IJ21Y/DuHOM0gMwhSO+0vzkpIa2G/d+yIS6wphFKlzXGmBLRg6J984GC0LOa0103gU3oQHo8bn
 QyZMM8aKCfDgFxYLTf+o8s241dTCQkRCBp7MMsl0vO0FyDxIpCYsYlq05TfAg4tkmUZki2y966r
 KCGMq/bXaL0RzTtJSIG5FZQONm3wlnVCFlyCIqozby5tUMJ7WgwPw7m7cqkxruOIaD7pqh35vCB
 xWdGs/GmQdEzZIjmXtXu0G/EFd0pzZfmmKpJTDV3B9O5lryenprFiDWudg540vkF5YrYIHlkIpR
 P+TBWapcH3wxFCS48R0KJKRLcWysQ+Q6F/t/4XJ0X+QPnqv+BOQ/2FMeCTI4oLmU/ER+A
X-Received: by 2002:a17:90b:548d:b0:398:e96a:8999 with SMTP id
 98e67ed59e1d1-39e54f99118mr1008676a91.16.1789683161871; 
 Thu, 17 Sep 2026 15:12:41 -0700 (PDT)
X-Received: by 2002:a17:90b:548d:b0:398:e96a:8999 with SMTP id
 98e67ed59e1d1-39e54f99118mr1008623a91.16.1789683161321; 
 Thu, 17 Sep 2026 15:12:41 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1eb05bccsm1775947eec.3.2026.09.17.15.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 15:12:40 -0700 (PDT)
Message-ID: <6a9dffd1-6b53-4b05-8d4a-564de0cc08f2@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 15:12:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 000/105] move check-tcg into the meson build
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260904150826.2331577-1-alex.bennee@linaro.org>
 <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
 <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
 <a80c4add-8c2a-4a20-8888-223fecc3f697@oss.qualcomm.com>
 <CAFn=p-bLuN2La1aqp7rpanjNiezUPk-v4D3kneGiHAPqPO-iyA@mail.gmail.com>
 <05149892-fad2-4576-a47d-bd8523ae6ada@oss.qualcomm.com>
 <CAFn=p-a64Dq7NOJo-7KqtkGovw6m+r_7q6ronAoy5ivWRGgZSg@mail.gmail.com>
 <ce78d727-046a-4755-b807-a996f06ae47b@oss.qualcomm.com>
 <95c18d55-87ca-4f81-bfa9-364b4b012657@oss.qualcomm.com>
 <78c818a4-2619-4dd5-87f8-af5e1017c9db@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <78c818a4-2619-4dd5-87f8-af5e1017c9db@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9oKRLy_LuzDSqz3eZspjUELtOFy7gW1Y
X-Authority-Analysis: v=2.4 cv=YcYodARf c=1 sm=1 tr=0 ts=6aac65db cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=cuQ-uVdTs4UneFBt07IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 9oKRLy_LuzDSqz3eZspjUELtOFy7gW1Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDMxOSBTYWx0ZWRfX8xcJVIiQ+Kzc
 ckCGrDdWOUUJDk0Y+BY9OcU+En5ZU6inV7nVNwnj6dXGkauidccqQcp4chBtq9f45kZMIqjMRzD
 dFJyfnbXnMHfQytF+ut+sd8sVjAijiYNCHK/1VjnnhIJZeZBzuwoycXA4RfHasUyYQuMAKxVs/a
 mJ4Tj8wpuEVnOSEzWnhrOulvnc9USxf48mfftHN0MmlQn7q3+XHI8Gjlwqb5j0Eo24A+/EnTvOx
 +EScGkZu6Cpn9lP4589RFVdZ33CtX/XaE28ueRbxugFSxdA2RPpDSYWnxN+4WmbOFW/ABmyZFS9
 5AiuJ0K9JMwSvFOPMmLe4Sjj9GHo9nwfU9X/X8sksIhM9hcUQP++bKaGiW7bkYTcsfpRX/ebANe
 s3FQZbNSCFHOVE2A302XZQznmVI3O52ohRSql3V5qqmrE/pNou+52FuoFGQzN8LGmayNS1Xm5gA
 qnAHl+j78TLsb2nZ5+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDMxOSBTYWx0ZWRfX6DsUTpYwuxI4
 Vuer4Zt9jP3Ek/Hp/CZMZQXdt7P/YtkTVSQN/QRBiM8PVJxXRJbkeML3YHEClGpGt6O2sfQqZoc
 wYqHayxlQYv5OOOPWO9CDQiVNmSpC5E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170319
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/17/2026 12:27 PM, Pierrick Bouvier wrote:
> On 9/15/2026 1:10 PM, Pierrick Bouvier wrote:
>> On 9/15/2026 1:04 PM, Pierrick Bouvier wrote:
>>> On 9/15/2026 12:22 PM, John Snow wrote:
>>>> On Tue, Sep 15, 2026 at 3:07 PM Pierrick Bouvier
>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>
>>>>> On 9/15/2026 11:26 AM, John Snow wrote:
>>>>>> On Tue, Sep 15, 2026 at 1:17 PM Pierrick Bouvier
>>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>>
>>>>>>> On 9/15/2026 9:52 AM, John Snow wrote:
>>>>>>>> On Fri, Sep 4, 2026 at 2:04 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>>>>>>
>>>>>>>>> On Fri, 4 Sept 2026 at 16:08, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>>>>>>>>
>>>>>>>>>> The following changes since commit d2843fbf80260e4346c856819e8cea11768c9d0e:
>>>>>>>>>>
>>>>>>>>>>   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/alistair23/qemu into staging (2026-09-04 09:43:27 +0100)
>>>>>>>>>>
>>>>>>>>>> are available in the Git repository at:
>>>>>>>>>>
>>>>>>>>>>   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meson-040926-2
>>>>>>>>>>
>>>>>>>>>> for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b3002597:
>>>>>>>>>>
>>>>>>>>>>   MAINTAINERS: add maintainer for tcg/tests meson infrastructure (2026-09-04 16:06:22 +0100)
>>>>>>>>>>
>>>>>>>>>> ----------------------------------------------------------------
>>>>>>>>>> tests/tcg: conversion to meson
>>>>>>>>>>
>>>>>>>>>>   - remove unused variable from multiarch/memory
>>>>>>>>>>   - standardise checking plugin output
>>>>>>>>>>   - bump minimal meson to 1.6.0
>>>>>>>>>>   - introduce meson plumbing for check-tcg
>>>>>>>>>>   - return error code if docker probe fails
>>>>>>>>>>   - add CI/self/mem test to gdbstub prot-none tests
>>>>>>>>>>   - use raw opcode for fprcvt test in arm
>>>>>>>>>>   - remove unused variables from gpc-test
>>>>>>>>>>   - teach probe-gdb-support about mips
>>>>>>>>>>   - identify or1k pc register
>>>>>>>>>>   - port check-tcg logic to meson (all targets)
>>>>>>>>>>   - update documentation
>>>>>>>>>>   - add Pierrick as a maintainer for tests/tcg
>>>>>>>>
>>>>>>>> Hi, I'm having difficulties building after this PR, after eb7f0c14 in
>>>>>>>> particular.
>>>>>>>>
>>>>>>>> I keep seeing stuff like this:
>>>>>>>>
>>>>>>>> FAILED: [code=1] tests/tcg/x86_64-softmmu-hello.test
>>>>>>>> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman
>>>>>>>> run --run-as-current-user -w /home/jsnow/src/qemu/build -v
>>>>>>>> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross
>>>>>>>> x86_64-linux-gnu-gcc
>>>>>>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c -o
>>>>>>>> tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF
>>>>>>>> tests/tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g
>>>>>>>> -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I
>>>>>>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib
>>>>>>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c
>>>>>>>> ../tests/tcg/x86_64/system/boot.S -Wl,-T
>>>>>>>> ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64
>>>>>>>> -Wl,--no-warn-rwx-segments -Wl,--build-id=none -lgcc
>>>>>>>> cc1: fatal error:
>>>>>>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c: Permission
>>>>>>>> denied
>>>>>>>> compilation terminated.
>>>>>>>> cc1: fatal error:
>>>>>>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c:
>>>>>>>> Permission denied
>>>>>>>> compilation terminated.
>>>>>>>> cc1: fatal error: ../tests/tcg/x86_64/system/boot.S: Permission denied
>>>>>>>> compilation terminated.
>>>>>>>> Traceback (most recent call last):
>>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 657,
>>>>>>>> in <module>
>>>>>>>>     sys.exit(main())
>>>>>>>>              ~~~~^^
>>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 653, in main
>>>>>>>>     return args.cmdobj.run(args, argv)
>>>>>>>>            ~~~~~~~~~~~~~~~^^^^^^^^^^^^
>>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 395, in run
>>>>>>>>     return Docker(args.command).run(argv, args.keep, quiet=args.quiet,
>>>>>>>>            ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>                                     as_user=args.run_as_current_user)
>>>>>>>>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 353, in run
>>>>>>>>     ret = self._do_check(["run", "--rm", "--label",
>>>>>>>>                          "com.qemu.instance.uuid=" + label] + cmd,
>>>>>>>>                          quiet=quiet)
>>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 230,
>>>>>>>> in _do_check
>>>>>>>>     return subprocess.check_call(self._command + cmd, **kwargs)
>>>>>>>>            ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>   File "/usr/lib64/python3.14/subprocess.py", line 420, in check_call
>>>>>>>>     raise CalledProcessError(retcode, cmd)
>>>>>>>> subprocess.CalledProcessError: Command '['podman', 'run', '--rm',
>>>>>>>> '--label', 'com.qemu.instance.uuid=0df29d1fcdc947f1b0cde41104eebed9',
>>>>>>>> '--userns=keep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build',
>>>>>>>> '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
>>>>>>>> 'debian-amd64-cross', 'x86_64-linux-gnu-gcc',
>>>>>>>> '/home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c', '-o',
>>>>>>>> 'tests/tcg/x86_64-softmmu-hello.test', '-static', '-MMD', '-MF',
>>>>>>>> 'tests/tcg/x86_64-softmmu-hello.d', '-Wall', '-Werror', '-O0', '-g',
>>>>>>>> '-fno-strict-aliasing', '-nostdlib', '-ffreestanding',
>>>>>>>> '-Wa,--noexecstack', '-I',
>>>>>>>> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib',
>>>>>>>> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c',
>>>>>>>> '../tests/tcg/x86_64/system/boot.S', '-Wl,-T',
>>>>>>>> '../tests/tcg/x86_64/system/kernel.ld', '-Wl,-melf_x86_64',
>>>>>>>> '-Wl,--no-warn-rwx-segments', '-Wl,--build-id=none', '-lgcc']'
>>>>>>>> returned non-zero exit status 1.
>>>>>>>> filter=--filter=label=com.qemu.instance.uuid=0df29d1fcdc947f1b0cde41104eebed9
>>>>>>>> ninja: build stopped: subcommand failed.
>>>>>>>> make: *** [Makefile:170: run-ninja] Error 1
>>>>>>>>
>>>>>>>
>>>>>>> Interesting, it seems to be an issue with podman user mapping.
>>>>>>
>>>>>> Maybe something I set up ages ago and promptly forgot about? I haven't
>>>>>> fussed with user mapping permissions in several aeons, it's possible I
>>>>>> have something stale in some config somewhere ...
>>>>>>
>>>>>>>
>>>>>>> Which distro you use (especially which version)?
>>>>>>
>>>>>> ~> cat /etc/fedora-release
>>>>>> Fedora release 44 (Forty Four)
>>>>>>
>>>>>>>
>>>>>>> Also, could you please report output of those commands:
>>>>>>> $ podman --version
>>>>>>
>>>>>> ~> podman --version
>>>>>> podman version 5.8.4
>>>>>>
>>>>>>> $ ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
>>>>>>
>>>>>> ~> ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
>>>>>> -rw-r--r--. 1 jsnow jsnow 229 May  7  2025
>>>>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
>>>>>>
>>>>>>> $ /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
>>>>>>>   run --run-as-current-user -w /home/jsnow/src/qemu/build -v \
>>>>>>>   /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
>>>>>>>   touch -v new_file && ls -al new_file
>>>>>>
>>>>>> There's no "-v" option for touch, but:
>>>>>>
>>>>>
>>>>> Copy-paste mistake sorry, thanks for fixing command.
>>>>>
>>>>>> ~> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
>>>>>>                                                                   run
>>>>>> --run-as-current-user -w /home/jsnow/src/qemu/build -v \
>>>>>>
>>>>>> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
>>>>>>
>>>>>> touch new_file && ls -al new_file
>>>>>> touch: cannot touch 'new_file': Permission denied
>>>>>> Traceback (most recent call last):
>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 657,
>>>>>> in <module>
>>>>>>     sys.exit(main())
>>>>>>              ~~~~^^
>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 653, in main
>>>>>>     return args.cmdobj.run(args, argv)
>>>>>>            ~~~~~~~~~~~~~~~^^^^^^^^^^^^
>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 395, in run
>>>>>>     return Docker(args.command).run(argv, args.keep, quiet=args.quiet,
>>>>>>            ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>                                     as_user=args.run_as_current_user)
>>>>>>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 353, in run
>>>>>>     ret = self._do_check(["run", "--rm", "--label",
>>>>>>                          "com.qemu.instance.uuid=" + label] + cmd,
>>>>>>                          quiet=quiet)
>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 230,
>>>>>> in _do_check
>>>>>>     return subprocess.check_call(self._command + cmd, **kwargs)
>>>>>>            ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>   File "/usr/lib64/python3.14/subprocess.py", line 420, in check_call
>>>>>>     raise CalledProcessError(retcode, cmd)
>>>>>> subprocess.CalledProcessError: Command '['podman', 'run', '--rm',
>>>>>> '--label', 'com.qemu.instance.uuid=d2faaf6ef4914d83b429069b4497cbb2',
>>>>>> '--userns=keep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build',
>>>>>> '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
>>>>>> 'debian-amd64-cross', 'touch', 'new_file']' returned non-zero exit
>>>>>> status 1.
>>>>>> filter=--filter=label=com.qemu.instance.uuid=d2faaf6ef4914d83b429069b4497cbb2
>>>>>>
>>>>>
>>>>> What is the content of your /etc/subuid?
>>>>>
>>>>> Giving your user id (21266), I guess you have a LDAP account or
>>>>> something similar: not a local account.
>>>>> I had the same issue on my corporate VM, and had to add an explicit
>>>>> mapping for my user.
>>>>>
>>>>> You should have something like:
>>>>>
>>>>> $ cat /etc/subuid
>>>>> jsnow:100000:65536
>>>>> $ cat /etc/subgid
>>>>> jsnow:100000:65536
>>>>
>>>> I updated my entries to this; I am still having problems so I assume I
>>>> need to refresh my login or restart or some such thing. Will have to
>>>> try that a little bit later :)
>>>>
>>>> Do you think it's possible to add a simple "hello world" example that
>>>> tries to touch a source file to determine if permissions are
>>>> appropriately set up, and if not, gives a nice human-readable error
>>>> message? (Along with advice to try --disable-containers as a
>>>> fallback.)
>>>>
>>>
>>> It could be possible to add something to docker.py probe directly.
>>> However, it would be good to know why there is an issue on your setup at
>>> the moment, just to rule out another obvious error.
>>>
>>
>> Would that be possible to try a shared mount (:z)?
>>
>> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
>>  run --run-as-current-user -w /home/jsnow/src/qemu/build -v \
>>  /home/jsnow/src/qemu:/home/jsnow/src/qemu:z debian-amd64-cross \
>>  touch -v new_file && ls -al new_file
>>
>> If it works, that's related to SELinux blocking such access by default.
>> And we can add the flag inconditionally.
>>
> 
> I installed fedora and could reproduce the issue. SELinux is enabled by
> default, to the opposite of debian.
> 
> The right fix is not :z (not enough with podman), but to use
> --security-opt label=disable, which works with docker and podman.
> 
> I'll send a patch today so Alex can include it in his PR tomorrow.
>

Sent:
https://lore.kernel.org/qemu-devel/20260917221117.274619-2-pierrick.bouvier@oss.qualcomm.com/T/#

> Regards,
> Pierrick


