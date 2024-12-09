Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E1AE77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 10:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKawK-0001mi-Us; Mon, 09 Dec 2024 05:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tKawJ-0001mR-5V
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 05:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tKawG-0007AM-Ne
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 05:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733739865;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTjikfuWg+hnSExv2qMFIfTaMCSigSWBfhqlPi5OZGY=;
 b=Fb7+ckPf3al2J1wviMiHTJJbegQ1ZEZfEG2vme5Kld6/65bdLJUK9Ii04bqbbtJFYt4A01
 DG8IcwnWZUaXQVd+im0Q11lsy8Hd9BlM+rE5kGWpXFSCpzcrPX9kphqeSVj7ZZMaiGrBET
 HZWh2s1b3fRBOeydqXX/tpojx9Vssw4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-bPgxJPYkMsWI39IV88quRA-1; Mon, 09 Dec 2024 05:24:21 -0500
X-MC-Unique: bPgxJPYkMsWI39IV88quRA-1
X-Mimecast-MFC-AGG-ID: bPgxJPYkMsWI39IV88quRA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385e4a759e6so2409129f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 02:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733739860; x=1734344660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dTjikfuWg+hnSExv2qMFIfTaMCSigSWBfhqlPi5OZGY=;
 b=B0+0DHfxji3VNHcWOo3ZXlejToOAvFhdiqfguxlJHNUztj6vELpTehSdcOtE0Ufiwd
 O7+Wlm+c4exDee0X9f3du/VBTV3tOMXsUUxstNHUloJIHRj3h13ddk0NSLAINioAx6Ri
 kMwO9gf/mu3fjVAqdpqKkE3fIQxkxScKDp/JOUmWUPy/WZ5GCbLS62Q9QWz4NlZlrOKT
 9NoqE+2cbLz5dvZEK+n+v/cubRWfzy5/IY3puTe7USTQIjj6rougLmbdPgLoU6/mu//G
 n5nCKYV+avfAbh/V0SbrrJACj3gOyXhTntkDKnFSMWvmTVxAxKzy/myZSBdqKBGeNH0+
 dnhQ==
X-Gm-Message-State: AOJu0YyksLPUBW9/wTNFX1YzL1I5fBRbzvHY5HoIUPaTZRmvftGXNpVe
 56zlyC8NUT86JdV9gw/BbEL7B4C0tU863VMc1JLC5mbuQKEgQ8tu97k/7Sp1I//UwAG3MV4MJi0
 EgI0rwu5DOtYWOEuM1uH6ZFRsfAsqgNVANTosI/JMviakaJevTK+9
X-Gm-Gg: ASbGncu7KKVUw8cTXUYa3PZ+c1CARmphiserhPWk06BqZZgNXomPBrXkEbWbyrz/q5Z
 hQYdAy4eiuoyYgYRXNImpOfi6EDvmzj8xlJosTjqQuQSV7x2o5UKgkIyTxLwC2SF8SN2EkiFmAa
 jEPQQrCOc045VZ5jfwIV+/pd+r3GSMKRzSFOFaQpB1KrmFGiGisAloRPgxGgxh9hIoYszrBRTUM
 uCeVfE9a5QKSwWUEpzmIwvqs5gTQO5d4XL6Swkqnou1Ob3A8avad4CptNwVUJYFtEkzqkFMNEAC
 kVHy5v/nFFiJPWpAOM8G2A==
X-Received: by 2002:a05:6000:184b:b0:385:f1bc:765c with SMTP id
 ffacd0b85a97d-3862b34532fmr9534426f8f.6.1733739860558; 
 Mon, 09 Dec 2024 02:24:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSXadjV05eccCPpWgIBvPAJIKBPM0dcxr2enGpHcVHthjzYHF1qRuuc6a4w4MMqR6DuKuAKw==
X-Received: by 2002:a05:6000:184b:b0:385:f1bc:765c with SMTP id
 ffacd0b85a97d-3862b34532fmr9534404f8f.6.1733739860111; 
 Mon, 09 Dec 2024 02:24:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf4119sm12638613f8f.14.2024.12.09.02.24.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 02:24:19 -0800 (PST)
Message-ID: <1f0edf58-6ae2-4c99-9944-ca51d3f876e3@redhat.com>
Date: Mon, 9 Dec 2024 11:24:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] tests/functional: Convert the intel_iommu
 avocado test
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>
References: <20241206181728.1241169-1-thuth@redhat.com>
 <d07f4ade-716c-4d58-b6d9-a95b4ffe58ab@redhat.com>
 <7e81c4a2-cc76-4d8c-b14a-fd008eff0c09@redhat.com>
 <Z1az26HxcIHVlB-d@redhat.com>
 <2fbfc1e0-4061-4f7f-87c7-161454f1025f@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <2fbfc1e0-4061-4f7f-87c7-161454f1025f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 12/9/24 10:25, Thomas Huth wrote:
> On 09/12/2024 10.09, Daniel P. Berrangé wrote:
>> On Mon, Dec 09, 2024 at 09:26:21AM +0100, Thomas Huth wrote:
>>> On 09/12/2024 09.12, Eric Auger wrote:
>>>> Hi Thomas,
>>>>
>>>> On 12/6/24 19:17, Thomas Huth wrote:
>>>>> Convert the intel_iommu test to the new functional framework.
>>>>> This test needs some changes since we neither support the old
>>>>> 'LinuxTest'
>>>>> class in the functional framework yet, nor a way to use SSH for
>>>>> running
>>>>> commands in the guest. So we now directly download a Fedora kernel
>>>>> and
>>>>> initrd and set up the serial console for executing the commands
>>>>> and for
>>>>> looking for the results.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>    MAINTAINERS                                   |   1 +
>>>>>    tests/functional/meson.build                  |   1 +
>>>>>    .../test_intel_iommu.py}                      | 119
>>>>> ++++++++----------
>>>>>    3 files changed, 51 insertions(+), 70 deletions(-)
>>>>>    rename tests/{avocado/intel_iommu.py =>
>>>>> functional/test_intel_iommu.py} (41%)
>>>>>    mode change 100644 => 100755
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index a62659b330..2ca452dbf9 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -3679,6 +3679,7 @@ S: Supported
>>>>>    F: hw/i386/intel_iommu.c
>>>>>    F: hw/i386/intel_iommu_internal.h
>>>>>    F: include/hw/i386/intel_iommu.h
>>>>> +F: tests/functional/test_intel_iommu.py
>>>>>    AMD-Vi Emulation
>>>>>    S: Orphan
>>>>> diff --git a/tests/functional/meson.build
>>>>> b/tests/functional/meson.build
>>>>> index 30c3eda7e4..dfc95fd904 100644
>>>>> --- a/tests/functional/meson.build
>>>>> +++ b/tests/functional/meson.build
>>>>> @@ -238,6 +238,7 @@ tests_x86_64_system_quick = [
>>>>>    tests_x86_64_system_thorough = [
>>>>>      'acpi_bits',
>>>>> +  'intel_iommu',
>>>>>      'x86_64_tuxrun',
>>>>>      'linux_initrd',
>>>>>      'multiprocess',
>>>>> diff --git a/tests/avocado/intel_iommu.py
>>>>> b/tests/functional/test_intel_iommu.py
>>>>> old mode 100644
>>>>> new mode 100755
>>>>> similarity index 41%
>>>>> rename from tests/avocado/intel_iommu.py
>>>>> rename to tests/functional/test_intel_iommu.py
>>>>> index 992583fa7d..6e47b1e9de
>>>>> --- a/tests/avocado/intel_iommu.py
>>>>> +++ b/tests/functional/test_intel_iommu.py
>>>>> @@ -1,3 +1,5 @@
>>>>> +#!/usr/bin/env python3
>>>>> +#
>>>>>    # INTEL_IOMMU Functional tests
>>>>>    #
>>>>>    # Copyright (c) 2021 Red Hat, Inc.
>>>>> @@ -7,116 +9,93 @@
>>>>>    #
>>>>>    # This work is licensed under the terms of the GNU GPL, version
>>>>> 2 or
>>>>>    # later.  See the COPYING file in the top-level directory.
>>>>> -import os
>>>>> -from avocado import skipUnless
>>>>> -from avocado_qemu.linuxtest import LinuxTest
>>>>> +from qemu_test import LinuxKernelTest, Asset,
>>>>> exec_command_and_wait_for_pattern
>>>>> +
>>>>> +class IntelIOMMU(LinuxKernelTest):
>>>>> -@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable
>>>>> on GitLab')
>>>>> -class IntelIOMMU(LinuxTest):
>>>>> -    """
>>>>> -    :avocado: tags=arch:x86_64
>>>>> -    :avocado: tags=distro:fedora
>>>>> -    :avocado: tags=distro_version:31
>>>>> -    :avocado: tags=machine:q35
>>>>> -    :avocado: tags=accel:kvm
>>>>> -    :avocado: tags=intel_iommu
>>>>> -    :avocado: tags=flaky
>>>>> -    """
>>>>> +    ASSET_KERNEL = Asset(
>>>>> +       
>>>>> ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>>>>> +         'releases/39/Server/x86_64/os/images/pxeboot/vmlinuz'),
>>>>> +       
>>>>> '5f2ef0de47f8d79d5ee9bf8b0ee6d5ba4d987c2f9a16b8b511a7c69e53931fe3')
>>>>> +
>>>>> +    ASSET_INITRD = Asset(
>>>>> +       
>>>>> ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>>>>> +         'releases/39/Server/x86_64/os/images/pxeboot/initrd.img'),
>>>>> +       
>>>>> '5bc29e2d872ceeb39a9698d42da3fb0afd7583dc7180de05a6b78bcc726674bb')
>>>>>        IOMMU_ADDON =
>>>>> ',iommu_platform=on,disable-modern=off,disable-legacy=on'
>>>>> +    default_kernel_params = 'console=ttyS0 rd.rescue quiet '
>>>>>        kernel_path = None
>>>>>        initrd_path = None
>>>>>        kernel_params = None
>>>>> -    def set_up_boot(self):
>>>>> -        path = self.download_boot()
>>>>> -        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
>>>>> -                         'drive=drv0,id=virtio-disk0,bootindex=1,'
>>>>> -                         'werror=stop,rerror=stop' +
>>>>> self.IOMMU_ADDON)
>>>>> -        self.vm.add_args('-device', 'virtio-gpu-pci' +
>>>>> self.IOMMU_ADDON)
>>>>> -        self.vm.add_args('-drive',
>>>>> -                        
>>>>> 'file=%s,if=none,cache=writethrough,id=drv0' % path)
>>>>> -
>>>>> -    def setUp(self):
>>>>> -        super(IntelIOMMU, self).setUp(None, 'virtio-net-pci' +
>>>>> self.IOMMU_ADDON)
>>>>> -
>>>>>        def add_common_args(self):
>>>>>            self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
>>>>>            self.vm.add_args('-object',
>>>>>                            
>>>>> 'rng-random,id=rng0,filename=/dev/urandom')
>>>>> +        self.vm.add_args('-device', 'virtio-net-pci' +
>>>>> self.IOMMU_ADDON)
>>>>> +        self.vm.add_args('-device', 'virtio-gpu-pci' +
>>>>> self.IOMMU_ADDON)
>>>>> +        self.vm.add_args("-m", "1G")
>>>>> -    def common_vm_setup(self, custom_kernel=None):
>>>>> +    def common_vm_setup(self):
>>>>> +        self.set_machine('q35')
>>>>>            self.require_accelerator("kvm")
>>>>>            self.add_common_args()
>>>>>            self.vm.add_args("-accel", "kvm")
>>>>> -        if custom_kernel is None:
>>>>> -            return
>>>>> -
>>>>> -        kernel_url = self.distro.pxeboot_url + 'vmlinuz'
>>>>> -        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
>>>>> -        initrd_url = self.distro.pxeboot_url + 'initrd.img'
>>>>> -        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
>>>>> -        self.kernel_path = self.fetch_asset(kernel_url,
>>>>> asset_hash=kernel_hash)
>>>>> -        self.initrd_path = self.fetch_asset(initrd_url,
>>>>> asset_hash=initrd_hash)
>>>>> +        self.kernel_path = self.ASSET_KERNEL.fetch()
>>>>> +        self.initrd_path = self.ASSET_INITRD.fetch()
>>>>> +        self.kernel_params = self.default_kernel_params
>>>>>        def run_and_check(self):
>>>>>            if self.kernel_path:
>>>>>                self.vm.add_args('-kernel', self.kernel_path,
>>>>>                                 '-append', self.kernel_params,
>>>>>                                 '-initrd', self.initrd_path)
>>>>> -        self.launch_and_wait()
>>>>> -        self.ssh_command('cat /proc/cmdline')
>>>>> -        self.ssh_command('dmesg | grep -e DMAR -e IOMMU')
>>>>> -        self.ssh_command('find /sys/kernel/iommu_groups/ -type l')
>>>>> -        self.ssh_command('dnf -y install numactl-devel')
>>>> I understand you cannot use ssh yet but the bulk of the test was the
>>>> execution of the dnf install meaning we lose the main substance of it
>>>> through the conversion.
>>>
>>> Ah, I see, so this was exercising the virtio-net device with the
>>> IOMMU ...
>>> and I already wondered why there was this "dnf install" at the end
>>> without
>>> doing anything with  the numactl-devel package ... (a comment would
>>> have
>>> been helpful here)
>>
>> FYI, I find 'dnf instal' to be a *highly* undesirable thing todo in
>> our test functional. Its performance is highly non-deterministic
>> depending on what mirror you happen to get sent to, such that it could
>> easily push us over the timeouts. It is also susceptible to periodic
>> broken mirrors, and instability around time of Fefdora EOL. I can't
>> remember if it was this test case, or a different one, but I've seen
>> problems before in avocado with 'dnf install'.
>>
>> If we want to test working networking, then can we arrange for something
>> more simple & targetted to run, with better worst case performance.
>
> That might also be the reason why the avocado test was marked with
> "QEMU_TEST_FLAKY_TESTS" ... I think we might want to replace the "dnf
> install" with some local network file transfer between the guest and
> the host instead. I'll have a look at it when I find some spare time
> for v2 of my patch.

I think the actual reason of QEMU_TEST_FLAKY_TESTS presence is the test
was too long to execute. But indeed if we can get rid of the dnf install
and exercise the network a little bit, that's the best solution.

Thanks

Eric
>
>  Thomas
>


