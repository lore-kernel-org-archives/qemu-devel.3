Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C83CD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVZkp-0006vA-QK; Fri, 05 Jun 2026 14:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wVZkm-0006ty-Hb; Fri, 05 Jun 2026 14:58:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wVZkk-00087I-6y; Fri, 05 Jun 2026 14:58:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655DTeaJ1796433; Fri, 5 Jun 2026 18:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wpGS2F
 PKmG4/pzq02zOMBUNlvTgTjQfEQl9SKtk7DrI=; b=IAr8a7dQGALU2NLPEwDOk8
 NaxAPI3Qfk+n40BcteanlpKiBHa5FaGIh3mX7PQCU7ZMDSRePJZangPbmj5spsEY
 LO+nROwh84mBSR6yuEYYAp5U29ImJ1TNCWtLHbb7bUns+vIUdDYmV0+74FYt6c8f
 DwovXA4SSur7duWwGXJNWjwA12s4JGOg5k/S6W2Gx9KAMiHR7kg1xpX+oTnVaUD9
 EGUaM2YfBwlQWFU+CqhlTI+/he9bb9LsoibHZ37deItFeivGnJy+Z7u1YQg4+FHz
 jLqJWnxn9/gnhW9pPN2aNBcEq7WWki5WoxAbulvaU6Mds9hOMdGWUIwOrxV4m+jw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtn5ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 18:58:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655IsB8J014344;
 Fri, 5 Jun 2026 18:58:39 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwytqk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 18:58:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 655Iwb7x6095694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2026 18:58:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 906AF58056;
 Fri,  5 Jun 2026 18:58:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A54D58052;
 Fri,  5 Jun 2026 18:58:36 +0000 (GMT)
Received: from [9.61.146.40] (unknown [9.61.146.40])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2026 18:58:36 +0000 (GMT)
Message-ID: <97f3b33a-17ca-4ba9-a714-20e70f7a7edf@linux.ibm.com>
Date: Fri, 5 Jun 2026 14:58:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 30/32] tests/functional/s390x: Add secure IPL
 functional test
To: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-31-zycai@linux.ibm.com>
 <ba1b75db4c3c110a7edae5a1753c32e5854a3ee5.camel@linux.ibm.com>
 <b82d095dd3616822279151e562e06689e3bd4b7b.camel@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <b82d095dd3616822279151e562e06689e3bd4b7b.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QqUcrNU6SC_UYSGiETSIozivVwkVLa2R
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a231c60 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=vTr9H3xdAAAA:8
 a=VnNF1IyMAAAA:8 a=WP5zsaevAAAA:8 a=bzaIFaoQP3wGUDjfQ98A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE4MyBTYWx0ZWRfX1z7JHLsm3gzH
 WIKV1oFqzxr1GaAKoG5ELC9l348C5ABViwx/1wNScSFu6bJY+LkxN9uy+RNPgvbEAcrrtNmTwfg
 3cxRmPP1u8qXWLi29d+McOxjqOfbRkaSLzdnxysgO0jWIWoaoAlFhm0IuOF8kLzywcdfaKnGmOs
 F25ynQDMbSzMJX95Q3xBL17JcegNf2lMfrpel+AW16FOT1rUyumNagYE3eL7Oram4sGuTDI6Uh8
 JmuWBDmC+gtRRMwPZ+0hUMFUGgy855ygGIrePK4SYjwCHMpiFAFUYfYFsXr+DFAas4mtf/DWE7i
 JZJWXwEKvt1woDSniSBjc9yIqJGpQ7nE6UA4qefZ1b/ysEF8bh2DOyjaqwycXtwPuPlsIq5zboo
 UrlsxHeaGNj/egwItJ2a8OMy3CIWdYAoKpXVXzqDyb8zemKoThem+FMKLTf15mopZjKHTCl6l6A
 Q4xENTFduwUQlEh313w==
X-Proofpoint-ORIG-GUID: QqUcrNU6SC_UYSGiETSIozivVwkVLa2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050183
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Thanks for the feedback!

On 6/5/26 12:25 PM, Eric Farman wrote:
> On Wed, 2026-06-03 at 14:50 -0400, Eric Farman wrote:
>> On Tue, 2026-05-05 at 16:19 -0400, Zhuoying Cai wrote:
>>> Add functional test for secure IPL.
>>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>> ---
>>>  tests/functional/s390x/meson.build        |   2 +
>>>  tests/functional/s390x/test_secure_ipl.py | 148 ++++++++++++++++++++++
>>>  2 files changed, 150 insertions(+)
>>>  create mode 100755 tests/functional/s390x/test_secure_ipl.py
>>>
>>> diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/meson.build
>>> index b065b666bc..01cb2d1d4c 100644
>>> --- a/tests/functional/s390x/meson.build
>>> +++ b/tests/functional/s390x/meson.build
>>> @@ -2,6 +2,7 @@
>>>  
>>>  test_s390x_timeouts = {
>>>    'ccw_virtio' : 420,
>>> +  'secure_ipl' : 280,
>>
>> How'd you come up with this value?
>>

I based it on previous test runs where the test consistently completed
within 200 seconds, so I set the timeout to 280 seconds to provide some
buffer.

However, I’ve noticed that when the cached qcow2 file is deleted and the
test is run repeatedly, the download time can vary significantly and
sometimes exceed this limit, leading to timeouts.

I’m not sure what the best approach is here — whether to increase the
timeout further or remove it entirely. Do you have any recommendations?

>>>  }
>>>  
>>>  tests_s390x_system_quick = [
>>> @@ -14,6 +15,7 @@ tests_s390x_system_thorough = [
>>>    'ccw_virtio',
>>>    'pxelinux',
>>>    'replay',
>>> +  'secure_ipl',
>>>    'topology',
>>>    'tuxrun',
>>>  ]
>>> diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
>>> new file mode 100755
>>> index 0000000000..0980daace1
>>> --- /dev/null
>>> +++ b/tests/functional/s390x/test_secure_ipl.py
>>> @@ -0,0 +1,148 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# s390x Secure IPL functional test: validates secure-boot verification results
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>
>> A general comment, you'll need some form of docstring for the entire file, and any classes/methods
>> defined later on.
>>
>>> +
>>> +from subprocess import check_call, DEVNULL
>>> +
>>> +from qemu_test import QemuSystemTest, Asset, get_qemu_img
>>> +from qemu_test import exec_command_and_wait_for_pattern, exec_command
>>> +from qemu_test import wait_for_console_pattern, skipBigDataTest
>>> +
>>> +class S390xSecureIpl(QemuSystemTest):
>>> +    ASSET_F40_QCOW2 = Asset(
>>> +        ('https://archives.fedoraproject.org/pub/archive/'
>>> +         'fedora-secondary/releases/40/Server/s390x/images/'
>>> +         'Fedora-Server-KVM-40-1.14.s390x.qcow2'),
>>> +        '091c232a7301be14e19c76ce9a0c1cbd2be2c4157884a731e1fc4f89e7455a5f')
>>> +
>>> +    def __init__(self, *args, **kwargs):
>>> +        super().__init__(*args, **kwargs)
>>> +        self.root_password = None
>>> +        self.qcow2_path = None
>>> +        self.cert_path = None
>>> +        self.prompt = None
>>> +
>>> +    # Boot a temporary VM to set up secure IPL image:
>>> +    # - Create certificate
>>> +    # - Sign stage3 binary and kernel
>>> +    # - Run zipl
>>> +    # - Extract certificate
>>
>> Can we break out those four chunks into standalone routines, so that we can identify them
>> individually rather than as part of the novella that follows?
>>
>>> +    def setup_s390x_secure_ipl(self):
>>> +        temp_vm = self.get_vm(name='sipl_setup')
>>> +        temp_vm.set_machine('s390-ccw-virtio')
>>> +
>>> +        asset_path = self.ASSET_F40_QCOW2.fetch()
>>> +        self.qcow2_path = self.scratch_file('f40.qcow2')
>>> +        qemu_img = get_qemu_img(self)
>>> +        check_call([qemu_img, 'create', '-f', 'qcow2', '-b', asset_path,
>>> +                    '-F', 'qcow2', self.qcow2_path], stdout=DEVNULL, stderr=DEVNULL)
>>> +
>>> +        temp_vm.set_console()
>>> +        temp_vm.add_args('-nographic',
>>> +                         '-accel', 'kvm',
>>> +                         '-m', '1024',
>>> +                         '-drive',
>>> +                         f'id=drive0,if=none,format=qcow2,file={self.qcow2_path}',
>>> +                         '-device', 'virtio-blk-ccw,drive=drive0,bootindex=1')
>>> +        temp_vm.launch()
>>> +
>>> +        # Initial root account setup (Fedora first boot screen)
>>> +        self.root_password = 'fedora40password'
>>> +        wait_for_console_pattern(self, 'Please make a selection from the above',
>>> +                                 vm=temp_vm)
>>> +        exec_command_and_wait_for_pattern(self, '4', 'Password:', vm=temp_vm)
>>> +        exec_command_and_wait_for_pattern(self, self.root_password,
>>> +                                          'Password (confirm):', vm=temp_vm)
>>> +        exec_command_and_wait_for_pattern(self, self.root_password,
>>> +                                    'Please make a selection from the above',
>>> +                                    vm=temp_vm)
>>> +
>>> +        # Login as root
>>> +        self.prompt = '[root@localhost ~]#'
>>> +        exec_command_and_wait_for_pattern(self, 'c', 'localhost login:', vm=temp_vm)
>>> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:', vm=temp_vm)
>>> +        exec_command_and_wait_for_pattern(self, self.root_password, self.prompt,
>>> +                                          vm=temp_vm)
>>> +
>>> +        # Certificate generation
>>> +        exec_command_and_wait_for_pattern(self,
>>> +                                          'openssl version', 'OpenSSL 3.2.1 30',
>>> +                                          vm=temp_vm)
>>> +        exec_command_and_wait_for_pattern(self,
>>> +                            'openssl req -new -x509 -newkey rsa:2048 '
>>> +                            '-keyout mykey.pem -outform PEM -out mycert.pem '
>>> +                            '-days 36500 -subj "/CN=My Name/" -nodes -verbose',
>>> +                            'Writing private key to \'mykey.pem\'', vm=temp_vm)
>>> +
>>> +        # Install kernel-devel (needed for sign-file)
>>> +        exec_command_and_wait_for_pattern(self,
>>> +                                'sudo dnf install kernel-devel-$(uname -r) -y',
>>> +                                'Complete!', vm=temp_vm)
>>
>> This is the last thing I see in base.log when running this test on my system. Looking at console
>> log, this errors out:
>>
>> 2026-06-03 20:08:33,829: ^[[?2004h[root@localhost ~]# sudo dnf install kernel-devel-$(uname -r) -y
>> 2026-06-03 20:08:34,147: ^[[?2004l^MFedora 40 - s390x        [===                 ] ---  B/s |   0 
>> B     --:-- ETA^MFedora 40 - s390x                               0.0  B/s |   0  B     00:00
>> 2026-06-03 20:08:34,147: Errors during downloading metadata for repository 'fedora':
>> 2026-06-03 20:08:34,147: - Curl error (6): Couldn't resolve host name for
>> https://mirrors.fedoraproject.org/metalink?repo=fedora-40&arch=s390x [Could not resolve host:
>> mirrors.fedoraproject.org]
>> 2026-06-03 20:08:34,207: Error: Failed to download metadata for repo 'fedora': Cannot prepare
>> internal mirrorlist: Curl error (6): Couldn't resolve host name for
>> https://mirrors.fedoraproject.org/metalink?repo=fedora-40&arch=s390x [Could not resolve host:
>> mirrors.fedoraproject.org]
>>
>>
>> Surrounding this, I'm noting that this is surrounded by messages from NetworkManager waiting for it
>> to come online, so maybe there needs to be a check that there's actually a network here, so we can
>> bail out rather than timeout.
> 
> Josh suggested (thank you!!) that perhaps I didn't have slirp enabled in my build when I tried this,
> which is indeed the cause for my hangup. Easy fix on my side, but it's a dependency that maybe you
> can account for in this test (or maybe -net none, if you dont need to connect it to anything?).
> 

slirp is a dependency since the guest needs network access to download
packages. Thanks to Josh for pointing that out.

I’ll add a check during test setup to ensure slirp is enabled so this
dependency is handled explicitly.

> Of course, remedying THAT problem gives me yet another error which I haven't chased down. Looks like
> the first of these [*] failed later on. This is a particularly crusty system I'm using, so maybe
> it's simply another thing that is missing.
> 
>>
>>> +        wait_for_console_pattern(self, self.prompt, vm=temp_vm)
>>> +        exec_command_and_wait_for_pattern(self,
>>> +                                    'ls /usr/src/kernels/$(uname -r)/scripts/',
>>> +                                    'sign-file', vm=temp_vm)
>>> +
>>> +        # Sign stage3 binary and kernel
>>> +        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-file '
>>> +                    'sha256 mykey.pem mycert.pem /lib/s390-tools/stage3.bin',
>>> +                    vm=temp_vm)
>>> +        wait_for_console_pattern(self, self.prompt, vm=temp_vm)
>>> +        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-file '
>>> +                    'sha256 mykey.pem mycert.pem /boot/vmlinuz-$(uname -r)',
>>> +                    vm=temp_vm)
>>> +        wait_for_console_pattern(self, self.prompt, vm=temp_vm)
>>> +
>>> +        # Run zipl to prepare for secure boot
>>> +        exec_command_and_wait_for_pattern(self, 'zipl --secure 1 -VV', 'Done.',
>>> +                                          vm=temp_vm)
>>> +
>>> +        # Extract certificate to host
>>> +        out = exec_command_and_wait_for_pattern(self, 'cat mycert.pem',
>>> +                                                '-----END CERTIFICATE-----',
>>> +                                                vm=temp_vm)
>>> +        # strip first line to avoid console echo artifacts
>>> +        cert = "\n".join(out.decode("utf-8").splitlines()[1:])
>>> +        self.log.info("%s", cert)
>>> +
>>> +        self.cert_path = self.scratch_file("mycert.pem")
>>> +
>>> +        with open(self.cert_path, 'w', encoding="utf-8") as file_object:
>>> +            file_object.write(cert)
>>> +
>>> +        # Shutdown temp vm
>>> +        temp_vm.shutdown()
>>> +
>>> +    @skipBigDataTest()
>>> +    def test_s390x_secure_ipl(self):
>>> +        self.require_accelerator('kvm')
>>> +        self.setup_s390x_secure_ipl()
>>> +
>>> +        self.set_machine('s390-ccw-virtio')
>>> +
>>> +        self.vm.set_console()
>>> +        self.vm.add_args('-nographic',
>>> +                         '-machine', 's390-ccw-virtio,secure-boot=on,'
>>> +                         f'boot-certs.0.path={self.cert_path}',
>>> +                         '-accel', 'kvm',
>>> +                         '-m', '1024',
>>> +                         '-drive',
>>> +                         f'id=drive1,if=none,format=qcow2,file={self.qcow2_path}',
>>> +                         '-device', 'virtio-blk-ccw,drive=drive1,bootindex=1')
>>> +        self.vm.launch()
>>> +
>>> +        # Expect two verified components
>>> +        verified_output = "Verified component"
>>> +        wait_for_console_pattern(self, verified_output)
>>> +        wait_for_console_pattern(self, verified_output)
> 
> [*] Failure occurs here, because guest panicked. Surely it's something not set up correctly on the
> guest that was created, because it's happening as soon as it tries to kick over to the guest kernel,
> but I don't see any errors in the log that suggests anything amiss:
> 
> console.log:
> ...
> 2026-06-05 17:51:03,344: -----END CERTIFICATE-----
> 2026-06-05 17:51:03,398: LOADPARM=[        ]
> 2026-06-05 17:51:03,398:
> 2026-06-05 17:51:03,398: Using virtio-blk.
> 2026-06-05 17:51:03,399: Using SCSI scheme.
> 2026-06-05 17:51:03,408: ..........
> 
> base.log:
> ...
> 2026-06-05 17:51:03,398 - DEBUG: qemu.qmp.protocol.default._set_state Transitioning from
> 'Runstate.CONNECTING' to 'Runstate.RUNNING'.
> 2026-06-05 17:51:03,398 - DEBUG: qemu-test._console_interaction Console interaction:
> success_msg='Verified component' failure_msg='None' send_string='None'
> 2026-06-05 17:51:03,398 - DEBUG: qemu.machine.machine.console_socket Opening console socket
> 2026-06-05 17:51:03,410 - DEBUG: qemu.machine.machine.shutdown Shutting down VM appliance;
> timeout=30
> 2026-06-05 17:51:03,410 - DEBUG: qemu.machine.machine._soft_shutdown Attempting graceful termination
> 2026-06-05 17:51:03,410 - DEBUG: qemu.machine.machine._early_cleanup Closing console socket
> 2026-06-05 17:51:03,411 - DEBUG: qemu.machine.machine._soft_shutdown Politely asking QEMU to
> terminate
> 2026-06-05 17:51:03,411 - DEBUG: qemu.qmp.protocol.default._cb_outbound --> {
>   "execute": "quit"
> }
> 2026-06-05 17:51:03,411 - DEBUG: qemu.qmp.protocol.default._cb_inbound <-- {
>   "timestamp": {
>     "seconds": 1780674663,
>     "microseconds": 409153
>   },
>   "event": "GUEST_PANICKED",
>   "data": {
>     "action": "poweroff",
>     "info": {
>       "core": 0,
>       "psw-addr": 17682,
>       "reason": "disabled-wait",
>       "psw-mask": 562952100904960,
>       "type": "s390"
>     }
>   }
> }
> 
> 

The console.log should look like this when the guest components are
successfully verified:
...
2026-06-05 20:34:33,447: -----END CERTIFICATE-----
2026-06-05 20:34:33,851: LOADPARM=[        ]
2026-06-05 20:34:33,851:
2026-06-05 20:34:33,852: Using virtio-blk.
2026-06-05 20:34:33,854: Using SCSI scheme.
2026-06-05 20:34:33,856: ....Verified component
2026-06-05 20:34:33,856:
2026-06-05 20:34:34,307: ....Verified component
2026-06-05 20:34:34,307:
2026-06-05 20:34:34,316: ....

In your console.log, it looks like the components are being loaded, but
the verification step is not performed. This might be because the test
is not using the built BIOS image?

For reference, here are the build steps I used:
# ninja -C build
# make -C build/pc-bios/s390-ccw
# cp build/pc-bios/s390-ccw/s390-ccw.img pc-bios
# make install

>>> +
>>> +        # Login and verify the vm is booted using secure boot
>>> +        wait_for_console_pattern(self, 'localhost login:')
>>> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
>>> +        exec_command_and_wait_for_pattern(self, self.root_password, self.prompt)
>>> +        exec_command_and_wait_for_pattern(self, 'cat /sys/firmware/ipl/secure', '1')
>>> +
>>> +if __name__ == '__main__':
>>> +    QemuSystemTest.main()


