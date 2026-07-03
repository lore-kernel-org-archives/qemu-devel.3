Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1F1C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdIr-0001rU-Ns; Fri, 03 Jul 2026 08:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wfdIp-0001qv-4y
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wfdIn-0005mr-82
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783082847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8tdLhzRCMjeitT6/7BUFXex6sFn2WdiStqFLbiYX6+k=;
 b=V8XY0u0X6A082pW64dht/TZDcDoW002G0EEYnN0ekdeq8MUy1q3DNOZUCyJ0Ph4EnmkqWZ
 3gxrHnbuJo+WZuCiNezJxHhLvJREL92Y3QI2rfPHS4G0JPBs3xYRu+HdMmvqOHunQVymUk
 TXF1q7qHPTOq74rW5vAeks5H+goL47k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-FIyqXBNSN3Cx0hfB3lELQA-1; Fri, 03 Jul 2026 08:47:25 -0400
X-MC-Unique: FIyqXBNSN3Cx0hfB3lELQA-1
X-Mimecast-MFC-AGG-ID: FIyqXBNSN3Cx0hfB3lELQA_1783082845
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-470cb859d96so356962f8f.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783082844; x=1783687644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8tdLhzRCMjeitT6/7BUFXex6sFn2WdiStqFLbiYX6+k=;
 b=afz7kWfF8NMfCcbe+zh5lnqv8wfQiAhnCScSp+qSz+mI6TvWn/SOcdjD65rnAryCF9
 Fnbvu4pqq/q+ypmzY+4pQuBxmzElLsojPHnk5BYkJMr9jR5cfYIrEBbJmVFHnylVMn7+
 drDeTrWsI9/lsdnl6LKuFCWklz3+ZySuo7++QTJUCjxfRfUwxzBwJmcVsJ5nOpUO95la
 kMY+Bu8C38+gg1fSMnkVHG43DGDAEy+FF0lZ8idP8CZrLctAGr+PkBDYsHE2mW3ucgSe
 krTLwxdcGLTZ9ffjaftmdDv1l0lJbAjQX1wp4K00LOANgyr+Th/wM69lrUVUN2rBPMmG
 +nGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783082844; x=1783687644;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tdLhzRCMjeitT6/7BUFXex6sFn2WdiStqFLbiYX6+k=;
 b=lyiylqvs38l6Ymc9RadLU2CN4dgpiW50Au7mgWlWxBzkQ9+oFHdKvpQK+NQhkYcJT9
 n5D6x8gqk43CAWhfZ7uasMeLBEuaCLkyrfc6ETQ/WixYM/vA3MLxpDZFTm3usIrTI5+D
 5BwPFyAGBpsoG4rR6G8LAqKfHZSDYniKRw2efIpGlfGaN1bz+0f29ZDLBxBEJmC89HdZ
 4IBE1gnMV+mZ3VHDa79WTntFUy+qdPDh907i7UH5AiHliB1jRAp3m1dafFtp+S3QCQiE
 /4itm9hAT+dUxnoHrqgYDuZNNIQKFklq08tuy1fE2IM+il6/0jjqeXYs75hTQod2gn4a
 tPog==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QkE+u0wdP8r+StLobIKv1aHH1rrtcpXiECSVQ60VmXbemnkJJaSY9SrX5kHonobEeYq1VZeYfc1KM@nongnu.org
X-Gm-Message-State: AOJu0YxGT2AIOMoK6wx5AZLhfhn6v2HVOWSPfFh6qh3f7y6BWN1QMUT2
 thqU/yrStjU6+hNNLF3HRD9cBp809VPGECm4wz4SRAxPHB6ZFqWubtTczwNVJSsPGxPlA/guBlq
 JNFppeLqdxR5JX8/jv38Mi90tbNMAHFZvYLQXWeCgoJy+stTHcQFEwV+h
X-Gm-Gg: AfdE7ckLZb6xyrIwbgPvgk7zePFur/YyvrE7jkeOoLoy3deeolS3eQgJZhjaszK/yKZ
 yrgmrqwzFTo7bqg0rmXZdb8LFgAXq3fBqoWSiI0ll9bhLBNxNQi6QdSZncLgICRjXRTb8ffC6JH
 AnfPYcSAhlIVFUoUXo0/VApnFGcVvAqob8qu+qebC2ya+wNIjPt6QA47/xA7L9ClLZAz7TDLKMO
 Ui2SkPjbGYm8NqS5Y4XQMXh2rcQOaoygHAlgxZx/l6RDDxKgqxIKOZ/S/w1z+PXqKWsugq6iTFP
 uBoGzK3oLANeNFlWPUL26I+rNk793PwlWVT5EQVQWD778GMNutVKu33Qs8UTQWfvs/aeL3pP3J2
 8wNrjTDqiwzDJ87mQX/ZCeVOC5qAEvBOStCFNV8biU0g=
X-Received: by 2002:a05:600c:c3dc:10b0:493:c389:d436 with SMTP id
 5b1f17b1804b1-493c3cdac6emr101951745e9.9.1783082844618; 
 Fri, 03 Jul 2026 05:47:24 -0700 (PDT)
X-Received: by 2002:a05:600c:c3dc:10b0:493:c389:d436 with SMTP id
 5b1f17b1804b1-493c3cdac6emr101951575e9.9.1783082844246; 
 Fri, 03 Jul 2026 05:47:24 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-22.web.vodafone.de.
 [109.40.241.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f8csm118028745e9.11.2026.07.03.05.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 05:47:22 -0700 (PDT)
Message-ID: <47bbae62-aba8-4641-97d7-f1dc1b2141ea@redhat.com>
Date: Fri, 3 Jul 2026 14:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tests/functional: Add hotplug_scsi test to hotplug
 virtio-scsi disk
To: Siddhi Katage <siddhi.katage@oracle.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Cc: fam@euphon.net
References: <20260210113135.771697-1-siddhi.katage@oracle.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260210113135.771697-1-siddhi.katage@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/02/2026 12.31, Siddhi Katage wrote:
> Signed-off-by: Siddhi Katage <siddhi.katage@oracle.com>
> ---
>   tests/functional/x86_64/meson.build          |  1 +
>   tests/functional/x86_64/test_hotplug_scsi.py | 86 ++++++++++++++++++++
>   2 files changed, 87 insertions(+)
>   create mode 100755 tests/functional/x86_64/test_hotplug_scsi.py

Sorry, looks like this patch fell through the cracks...

It looks fine to me, so I'll add it to my next pull request with functional 
testing patches.

  Thomas


> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
> index f78eec5e6c..466e9db96e 100644
> --- a/tests/functional/x86_64/meson.build
> +++ b/tests/functional/x86_64/meson.build
> @@ -24,6 +24,7 @@ tests_x86_64_system_quick = [
>   tests_x86_64_system_thorough = [
>     'acpi_bits',
>     'hotplug_blk',
> +  'hotplug_scsi',
>     'hotplug_cpu',
>     'intel_iommu',
>     'kvm_xen',
> diff --git a/tests/functional/x86_64/test_hotplug_scsi.py b/tests/functional/x86_64/test_hotplug_scsi.py
> new file mode 100755
> index 0000000000..10fd306616
> --- /dev/null
> +++ b/tests/functional/x86_64/test_hotplug_scsi.py
> @@ -0,0 +1,86 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that hotplugs a virtio scsi disk and checks it on a Linux
> +# guest
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
> +
> +class HotPlugScsi(LinuxKernelTest):
> +    ASSET_KERNEL = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
> +         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),
> +        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129')
> +
> +    ASSET_INITRD = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
> +         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),
> +        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b')
> +
> +    def blockdev_add(self) -> None:
> +        self.vm.cmd('blockdev-add', **{
> +            'driver': 'null-co',
> +            'size': 1073741824,
> +            'node-name': 'disk0'
> +        })
> +
> +    def add_scsi_controller(self) -> None:
> +        self.vm.cmd('device_add', {
> +            'driver': 'virtio-scsi-pci',
> +            'id': 'scsi0',
> +            'bus': 'pci.1',
> +            'addr': '1',
> +        })
> +
> +    def assert_sda(self) -> None:
> +        exec_command_and_wait_for_pattern(self, 'while ! test -e /sys/block/sda ;'
> +                                                ' do sleep 0.2 ; done', '# ')
> +
> +    def assert_no_sda(self) -> None:
> +        exec_command_and_wait_for_pattern(self, 'while test -e /sys/block/sda ;'
> +                                                ' do sleep 0.2 ; done', '# ')
> +
> +    def plug(self) -> None:
> +        args = {
> +            'driver':'scsi-hd',
> +            'drive':'disk0',
> +            'bus':'scsi0.0',
> +            'id':'scsi-disk0',
> +        }
> +
> +        self.assert_no_sda()
> +        self.vm.cmd('device_add', args)
> +        self.wait_for_console_pattern('[sda] Attached SCSI disk')
> +        self.assert_sda()
> +
> +    def unplug(self) -> None:
> +        self.vm.cmd('device_del', id='scsi-disk0')
> +
> +        self.vm.event_wait('DEVICE_DELETED', 1.0,
> +                           match={'data': {'device': 'scsi-disk0'}})
> +
> +        self.assert_no_sda()
> +
> +    def test(self) -> None:
> +        self.require_accelerator('kvm')
> +        self.set_machine('q35')
> +        self.vm.add_args('-accel', 'kvm')
> +        self.vm.add_args('-device', 'pcie-pci-bridge,id=pci.1,bus=pcie.0')
> +        self.vm.add_args('-m', '1G')
> +        self.vm.add_args('-append', 'console=ttyS0 rd.rescue')
> +
> +        self.launch_kernel(self.ASSET_KERNEL.fetch(),
> +                           self.ASSET_INITRD.fetch(),
> +                           wait_for='Entering emergency mode.')
> +        self.wait_for_console_pattern('# ')
> +
> +        self.blockdev_add()
> +        self.add_scsi_controller()
> +        self.plug()
> +        self.unplug()
> +
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()
> +


