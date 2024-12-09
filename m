Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BC2E77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 08:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKZ6A-0005SS-FK; Mon, 09 Dec 2024 03:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tKZ68-0005SF-Vl
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 03:26:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tKZ66-0004js-R0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 03:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733732787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZSnjAqMZCp0rieYGq1pMF4DNMYuiCVvKvDCH5oNGXRs=;
 b=CSy1NVNOwQp/TxKtbd/RIQ1L2CdsNEt5Y5GkZ6jTdx2zdCTx6+XBviJVmPdQNlRbDy3x7V
 61OEv/l2UHAzikeGXdfh5AEwuVha63NGJB3WjBHXZ/7ysWwsLtFdpuX5v/4Ina8w11Xr0E
 wSJ95s+FYaT3ZcsqcnJvqN4g8F2CDUA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-eIRgBDA6NNSbIi3a6HLY7g-1; Mon, 09 Dec 2024 03:26:26 -0500
X-MC-Unique: eIRgBDA6NNSbIi3a6HLY7g-1
X-Mimecast-MFC-AGG-ID: eIRgBDA6NNSbIi3a6HLY7g
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e3cbf308so680100f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 00:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733732784; x=1734337584;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZSnjAqMZCp0rieYGq1pMF4DNMYuiCVvKvDCH5oNGXRs=;
 b=J/E5zu9aweWbvQyVcUyMExzFxawNKoGzHyTkCj7b3hyyQr2KDZyYdS31QKuTKg7Mcn
 w+Pg4tvuiz8gkNBgS/eTbauL00TRM+XkNT14nWe2d9tU5YVjAcdo5pX6m3FbZ9CrP/nC
 ntjoBJSuUvFv+dqj+PK8AoxwgOlEwMDhs6//Iv2gkPL7h2AXyrly6oxJIuB6uhtsR96s
 5iTENmSa93LxJGmcl19aIT4/D6Tev6zz2NWR4GVGGf7fSa9AeglKDziW3Dmu9SS9M0UH
 i9o8z4CLd0BvAHx3TTjxFo+lQdWAiUtqVpp/MdRUd8S7turkS0UUllmtom+YhCcKuecX
 AFDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/YgBH0kiyFGeQURceNaRVwv9f3GsSNHpX6wH74x8df8BvrrPc4pQZ3osSKQBTDLhmxMd+6fwWHP+n@nongnu.org
X-Gm-Message-State: AOJu0YxKZ0k1b3hTsAuTqI9eHQLj9SWCJQGGi/oxV6JvapYWmH+pLmko
 cjfsbbGAQY0u2gDl/F01P3Dcp2p48MJngIMu6373j/8R3P0Q4A2KJugnqaA7HF7z4Z/ehNu5Ccq
 nIN2wBjrC9TGye5Mxi9SGjhp4e8NqpHrkQ0V/FZW+ltQBIcon+y6l
X-Gm-Gg: ASbGncu4UXJDtntFgBGCW4F3yqEcYYCIODnW07MNAInwskUWnAs8+HxlG4jg5n51MYD
 +vVvr7kWbJztjd6+u8mpK1aFACyY41Gw29ovCcMCg1MSiF35fjFBKtUidARUnBdhrwALdqxd/vt
 SdjGpqN1QZsNishQYTPX8pSHyHsCElQKEjT0bjfjZqpIgfOb762nRQl0O5VvPf2NRYR+6Jpx0wo
 0yq6Ncm0MZS/ZqHcRQK3+5ok9N+tblcJWkx6Pz7IPMuB2JEV4nCxVsBKcaoe9qYKn6rLsrHWbsu
 m7o=
X-Received: by 2002:a05:6000:1fa9:b0:382:4926:98fa with SMTP id
 ffacd0b85a97d-3862b3e5dfamr8922861f8f.40.1733732784588; 
 Mon, 09 Dec 2024 00:26:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFftDBYsrgY+D8yMHRorOyrbLRsCjkQcvcCJM5O77Y9qT3N5Ousn5KwnGU35U13/TWNimQhqQ==
X-Received: by 2002:a05:6000:1fa9:b0:382:4926:98fa with SMTP id
 ffacd0b85a97d-3862b3e5dfamr8922833f8f.40.1733732784205; 
 Mon, 09 Dec 2024 00:26:24 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-49-52.web.vodafone.de. [109.42.49.52])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38621909644sm12708172f8f.76.2024.12.09.00.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 00:26:23 -0800 (PST)
Message-ID: <7e81c4a2-cc76-4d8c-b14a-fd008eff0c09@redhat.com>
Date: Mon, 9 Dec 2024 09:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] tests/functional: Convert the intel_iommu
 avocado test
To: eric.auger@redhat.com, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>
References: <20241206181728.1241169-1-thuth@redhat.com>
 <d07f4ade-716c-4d58-b6d9-a95b4ffe58ab@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <d07f4ade-716c-4d58-b6d9-a95b4ffe58ab@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 09/12/2024 09.12, Eric Auger wrote:
> Hi Thomas,
> 
> On 12/6/24 19:17, Thomas Huth wrote:
>> Convert the intel_iommu test to the new functional framework.
>> This test needs some changes since we neither support the old 'LinuxTest'
>> class in the functional framework yet, nor a way to use SSH for running
>> commands in the guest. So we now directly download a Fedora kernel and
>> initrd and set up the serial console for executing the commands and for
>> looking for the results.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   MAINTAINERS                                   |   1 +
>>   tests/functional/meson.build                  |   1 +
>>   .../test_intel_iommu.py}                      | 119 ++++++++----------
>>   3 files changed, 51 insertions(+), 70 deletions(-)
>>   rename tests/{avocado/intel_iommu.py => functional/test_intel_iommu.py} (41%)
>>   mode change 100644 => 100755
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a62659b330..2ca452dbf9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3679,6 +3679,7 @@ S: Supported
>>   F: hw/i386/intel_iommu.c
>>   F: hw/i386/intel_iommu_internal.h
>>   F: include/hw/i386/intel_iommu.h
>> +F: tests/functional/test_intel_iommu.py
>>   
>>   AMD-Vi Emulation
>>   S: Orphan
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 30c3eda7e4..dfc95fd904 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -238,6 +238,7 @@ tests_x86_64_system_quick = [
>>   
>>   tests_x86_64_system_thorough = [
>>     'acpi_bits',
>> +  'intel_iommu',
>>     'x86_64_tuxrun',
>>     'linux_initrd',
>>     'multiprocess',
>> diff --git a/tests/avocado/intel_iommu.py b/tests/functional/test_intel_iommu.py
>> old mode 100644
>> new mode 100755
>> similarity index 41%
>> rename from tests/avocado/intel_iommu.py
>> rename to tests/functional/test_intel_iommu.py
>> index 992583fa7d..6e47b1e9de
>> --- a/tests/avocado/intel_iommu.py
>> +++ b/tests/functional/test_intel_iommu.py
>> @@ -1,3 +1,5 @@
>> +#!/usr/bin/env python3
>> +#
>>   # INTEL_IOMMU Functional tests
>>   #
>>   # Copyright (c) 2021 Red Hat, Inc.
>> @@ -7,116 +9,93 @@
>>   #
>>   # This work is licensed under the terms of the GNU GPL, version 2 or
>>   # later.  See the COPYING file in the top-level directory.
>> -import os
>>   
>> -from avocado import skipUnless
>> -from avocado_qemu.linuxtest import LinuxTest
>> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
>> +
>> +class IntelIOMMU(LinuxKernelTest):
>>   
>> -@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
>> -class IntelIOMMU(LinuxTest):
>> -    """
>> -    :avocado: tags=arch:x86_64
>> -    :avocado: tags=distro:fedora
>> -    :avocado: tags=distro_version:31
>> -    :avocado: tags=machine:q35
>> -    :avocado: tags=accel:kvm
>> -    :avocado: tags=intel_iommu
>> -    :avocado: tags=flaky
>> -    """
>> +    ASSET_KERNEL = Asset(
>> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>> +         'releases/39/Server/x86_64/os/images/pxeboot/vmlinuz'),
>> +        '5f2ef0de47f8d79d5ee9bf8b0ee6d5ba4d987c2f9a16b8b511a7c69e53931fe3')
>> +
>> +    ASSET_INITRD = Asset(
>> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>> +         'releases/39/Server/x86_64/os/images/pxeboot/initrd.img'),
>> +        '5bc29e2d872ceeb39a9698d42da3fb0afd7583dc7180de05a6b78bcc726674bb')
>>   
>>       IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
>> +    default_kernel_params = 'console=ttyS0 rd.rescue quiet '
>>       kernel_path = None
>>       initrd_path = None
>>       kernel_params = None
>>   
>> -    def set_up_boot(self):
>> -        path = self.download_boot()
>> -        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
>> -                         'drive=drv0,id=virtio-disk0,bootindex=1,'
>> -                         'werror=stop,rerror=stop' + self.IOMMU_ADDON)
>> -        self.vm.add_args('-device', 'virtio-gpu-pci' + self.IOMMU_ADDON)
>> -        self.vm.add_args('-drive',
>> -                         'file=%s,if=none,cache=writethrough,id=drv0' % path)
>> -
>> -    def setUp(self):
>> -        super(IntelIOMMU, self).setUp(None, 'virtio-net-pci' + self.IOMMU_ADDON)
>> -
>>       def add_common_args(self):
>>           self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
>>           self.vm.add_args('-object',
>>                            'rng-random,id=rng0,filename=/dev/urandom')
>> +        self.vm.add_args('-device', 'virtio-net-pci' + self.IOMMU_ADDON)
>> +        self.vm.add_args('-device', 'virtio-gpu-pci' + self.IOMMU_ADDON)
>> +        self.vm.add_args("-m", "1G")
>>   
>> -    def common_vm_setup(self, custom_kernel=None):
>> +    def common_vm_setup(self):
>> +        self.set_machine('q35')
>>           self.require_accelerator("kvm")
>>           self.add_common_args()
>>           self.vm.add_args("-accel", "kvm")
>>   
>> -        if custom_kernel is None:
>> -            return
>> -
>> -        kernel_url = self.distro.pxeboot_url + 'vmlinuz'
>> -        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
>> -        initrd_url = self.distro.pxeboot_url + 'initrd.img'
>> -        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
>> -        self.kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>> -        self.initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
>> +        self.kernel_path = self.ASSET_KERNEL.fetch()
>> +        self.initrd_path = self.ASSET_INITRD.fetch()
>> +        self.kernel_params = self.default_kernel_params
>>   
>>       def run_and_check(self):
>>           if self.kernel_path:
>>               self.vm.add_args('-kernel', self.kernel_path,
>>                                '-append', self.kernel_params,
>>                                '-initrd', self.initrd_path)
>> -        self.launch_and_wait()
>> -        self.ssh_command('cat /proc/cmdline')
>> -        self.ssh_command('dmesg | grep -e DMAR -e IOMMU')
>> -        self.ssh_command('find /sys/kernel/iommu_groups/ -type l')
>> -        self.ssh_command('dnf -y install numactl-devel')
> I understand you cannot use ssh yet but the bulk of the test was the
> execution of the dnf install meaning we lose the main substance of it
> through the conversion.

Ah, I see, so this was exercising the virtio-net device with the IOMMU ... 
and I already wondered why there was this "dnf install" at the end without 
doing anything with  the numactl-devel package ... (a comment would have 
been helpful here)

Ok, then please disregard this version of the patch, I guess I have to 
tackle this in a different way...

  Thomas


