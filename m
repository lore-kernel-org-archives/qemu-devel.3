Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C93FC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Xgp-0008VU-Tm; Mon, 07 Sep 2026 07:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x3Xgl-0008Ny-2y
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x3Xgi-0001m7-EP
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788781139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zUz10O7nPnCG5Za2iPKfg50BMls+0EXqt9EyVtC2SxE=;
 b=IxUtbC0rhS9LzeHZHxOX/ZcQF+AOYymgLuL+kwSj2Fute0BtcfmN8jFCF8aoPUrvqlOJDg
 7XmES8yJNOMuJ7T4y/z7d51Haw7eUF8DKIag0aa8MdJj1f/18e9Yqdo5s6pwyFqafWEEyF
 uufmmjyTjBqdzIEE0Ffr74NTVM7R0Fk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-7lmpbhCPObOlVF2Otjyeqg-1; Mon, 07 Sep 2026 07:38:55 -0400
X-MC-Unique: 7lmpbhCPObOlVF2Otjyeqg-1
X-Mimecast-MFC-AGG-ID: 7lmpbhCPObOlVF2Otjyeqg_1788781135
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cf5bd2f12so48460985e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788781134; x=1789385934; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zUz10O7nPnCG5Za2iPKfg50BMls+0EXqt9EyVtC2SxE=;
 b=r55xBo8X3iRgEwO4nrSYfT89wWnNSrV6gwIBSY8TNN5iCNmNJXG/l1EmTV9tNYdrsh
 IXWycDnPTkShCnruijAOckxCuvbEfDDHxqKg+y0665kgGa7zumZ/LiA+7QVaPolZQsSY
 IgrO7dS4VqTMy1HMjMoK8U94Q6exDHBsFIgRxd4JOc8EmlKN3S1e95mOpJun40hYx5Ie
 9Q2Q+W++F5VGdTHyR3MocSWwT/DQFJH9Hlhn0lr/JKYs+raErUW1talaaxavpSsucyrg
 CJVEhYoDcQIljHJogoyml0E46MsuKfaqJVRmcXypd76JRJrQArciZluRrLKaONx4/6uC
 tdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781134; x=1789385934;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zUz10O7nPnCG5Za2iPKfg50BMls+0EXqt9EyVtC2SxE=;
 b=VvudHqGB3MZX/Kcn53OrKAKAfCS5yX5ehGfipMtMubQa0Fh7JDdymht8vVx+mcRC0q
 C6KY0FdAfis9TgcjNZ8nRQr3GIp8oGwHa6jC5aIiVrorHuvd+BjgzAcsBGKljz690nVv
 zG5pLcc+hxJDZ9YRvpwy410r2MQBgC/qJdNj9qJh1mFHi1ncpAAomfmRyrs2dsMiOPB/
 OO+tL/LuY2FVW9n3gyzpO7NLkYUScL9WTsIt6AVCXSJniyhhaCP2eHoJAI8GWanVjkYK
 JMV6rZAVFwAoiCXXQYwvU5AQVpDQ5B2SWHUYk8dpScz6Usji9MPCjOvwT4PwYGmc74OR
 8Zaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwPQ/aB3lhUfVT2DjbEpUgABol8w2dn5ZztTH4nY3Xejx2ilxzekKQ0husbS0Yk2d9QHb53if2DqMh@nongnu.org
X-Gm-Message-State: AFuF++nK0gELEVtSE8ilXc7DLQu8rcRssjlmPGY+g3QC3gDyMXFE8I9i
 OWO4f0AFjDu2RI/r3HHJW40bgdDeK7mYoihNlERW5/LE83ShNNvElOzvQ8EWG8TVb87cYzYtALA
 lfGn2QtfrAiF2D8TrsYHZ5JAFe3VZd8nHxtIHtnBLcMJcIlzn0oEYCHj6
X-Gm-Gg: AYBFou2pA1ngnG4xouJX2wp4oTjd4d3Cm1duIWNTwoA/807krOAjYTyKq6U4Scn44Cl
 wkaC483Q5YgiXBzdpzKDcnhegOfQbHnJ6XAPffxAoKpBD56IcZ/qx78GeR9CYZ7UzdqbHs8Ei8v
 lz5TpmaE9NBKhqQQWTq/qgvg2wryY86/8wFyGebI57azWpto0bCrv/aTdwocdeV0sr/5QpsjJi1
 TQTYTC489MkINMpCyuOfyRD/S3HJXQkDNmqFbWlMIBP3M2PL+/Cf8V/GxH3mGQZP8UoykQpDPUo
 DqjVflOYyX9fJ7oa3ZYkoSSuhbIRivgcy2zOiOu64I2udlXXHN9tQkq60JORBoSWcSYvPKtg
X-Received: by 2002:a05:600c:3550:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-49cf7f4a6cfmr198882705e9.0.1788781134563; 
 Mon, 07 Sep 2026 04:38:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3550:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-49cf7f4a6cfmr198882305e9.0.1788781134136; 
 Mon, 07 Sep 2026 04:38:54 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.70]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff81c9b5sm194086685e9.4.2026.09.07.04.38.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 04:38:53 -0700 (PDT)
Message-ID: <ba2ecdc6-8a8f-4217-a3e1-0cfb52a9636f@redhat.com>
Date: Mon, 7 Sep 2026 13:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/ppc64: add pseries migration and powernv
 NVMe tests
To: Aniket Sahu <asahu1x@linux.ibm.com>, npiggin@gmail.com,
 Chinmay Rath <rathc@linux.ibm.com>, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
References: <77e89fea-0284-4e19-8ee7-04b900b13749@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <77e89fea-0284-4e19-8ee7-04b900b13749@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 30/08/2026 19.52, Aniket Sahu wrote:
> Add two new groups of functional tests that cover scenarios currently
> missing from the ppc64 test suite:
> 
> 1. pseries live migration (pseries machine type)
>     - Extends the quick migration suite (already covering mac99) with
>       tcp-localhost, UNIX socket, and exec (socat) migration tests for
>       the pseries machine type.  This complements the existing
>       test_ppc64_linux_migration test in test_pseries.py (which boots a
>       full kernel) by providing lightweight no-boot migration smoke tests
>       that run quickly.

Is this worth the effort? If we already have a full migration test with a 
booted kernel, what do we really gain by testing again without a kernel?

Also, you are adding two completely different tests with one patch here. I'd 
suggest to split this into two separate patches instead.

> 2. PowerNV NVMe + network device boot (powernv machine type)
>     - The existing do_test_ppc64_powernv() helper in test_powernv.py
>       already boots a rootfs from NVMe for P8/P9/P10/P11.  This patch
>       adds a complementary test that also verifies the e1000e network
>       adapter and USB xHCI controller are probed successfully by Linux -
>       previously these were present in the device args but no console
>       check was made for them.
>     - Adds test_powernv10_rainier() for the powernv10-rainier variant
>       that models the IBM Rainier system board.
> 
> Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
> 
> diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/ 
> meson.build
> index cb3c745624..19c32c8b67 100644
> --- a/tests/functional/ppc64/meson.build
> +++ b/tests/functional/ppc64/meson.build
> @@ -1,6 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
> 
>   test_ppc64_timeouts = {
> +  'pseries_migrate' : 60,

Default timeout for the tests is 90, please don't add something with lower 
values, ie. simply drop the above line.

...
> diff --git a/tests/functional/ppc64/test_powernv_devices.py b/tests/ 
> functional/ppc64/test_powernv_devices.py
> new file mode 100644
> index 0000000000..6135855612
> --- /dev/null
> +++ b/tests/functional/ppc64/test_powernv_devices.py
> @@ -0,0 +1,151 @@
> +#!/usr/bin/env python3
> +#
> +# Functional tests that boot Linux on powernv machines and explicitly
> +# verify that PCIe-attached devices (NVMe, e1000e, xHCI USB) are
> +# detected by the guest kernel.  Also covers the powernv10-rainier
> +# board variant.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest, Asset
> +
> +
> +class PowerNVDevicesTest(LinuxKernelTest):
> +    """
> +    Boot Linux on powernv variants and verify that PCIe devices are
> +    detected by the guest.
> +
> +    The existing test_powernv.py::do_test_ppc64_powernv() attaches an
> +    NVMe drive, an e1000e NIC, and an xHCI USB controller, but only
> +    waits for the CPU-generation string and the init process. This
> +    test adds explicit console pattern checks for each device so that
> +    regressions in device enumeration or PCI/PCIe topology are caught.
> +
> +    An additional test covers powernv10-rainier (the IBM Rainier system
> +    board variant) which has a slightly different PHB topology.
> +    """
> +
> +    timeout = 480
> +
> +    ASSET_KERNEL = Asset(
> + ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
> +         'buildroot/qemu_ppc64le_powernv8-2025.02/vmlinux'),
> + '6fd29aff9ad4362511ea5d0acbb510667c7031928e97d64ec15bbc5daf4b8151')
> +
> +    ASSET_INITRD = Asset(
> + ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
> +         'buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2'),
> + 'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
> +
> +    def setUp(self):
> +        super().setUp()
> +        self.require_accelerator('tcg')
> +
> +    def _do_test_powernv_pcie_devices(self, machine):
> +        """
> +        Boot *machine* and verify NVMe, e1000e, and xHCI are detected.
> +
> +        Device topology (matches the existing do_test_ppc64_powernv helper):
> +          pcie.2  → NVMe drive (boot device, rootfs)
> +          bridge1 → e1000e NIC (addr 0x3)
> +          bridge1 → nec-usb-xhci (addr 0x2)
> +
> +        Expected kernel log patterns checked:
> +          * "nvme nvme0" — NVMe controller probe
> +          * "e1000e"     — Intel e1000e NIC probe
> +          * "xhci_hcd"   — USB xHCI host controller probe
> +          * "Run /sbin/init as init process" — reached userland
> +        """
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        initrd_path = self.ASSET_INITRD.fetch()
> +
> +        self.set_machine(machine)
> +        self.vm.set_console()
> +        self.vm.add_args(
> +            '-kernel', kernel_path,
> +            '-drive',
> + f'file={initrd_path},format=raw,if=none,id=drive0,readonly=on',
> +            '-append', 'root=/dev/nvme0n1 console=tty0 console=hvc0',
> +            '-device', 'pcie-pci-bridge,id=bridge1,bus=pcie.1,addr=0x0',
> +            '-device', 'nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234',
> +            '-device', 'e1000e,bus=bridge1,addr=0x3',
> +            '-device', 'nec-usb-xhci,bus=bridge1,addr=0x2',
> +        )
> +        self.vm.launch()
> +
> +        # NVMe controller should be detected first (it is the boot disk).
> +        self.wait_for_console_pattern('nvme nvme0')
> +
> +        # e1000e NIC detection.
> +        self.wait_for_console_pattern('e1000e')
> +
> +        # USB xHCI host controller detection.
> +        self.wait_for_console_pattern('xhci_hcd')
> +
> +        # System reached userland — final sanity check.
> +        self.wait_for_console_pattern('Run /sbin/init as init process')
> +
> +    def test_powernv8_pcie_devices(self):
> +        """powernv8 (P8): NVMe + e1000e + xHCI detected."""
> +        self._do_test_powernv_pcie_devices('powernv8')
> +
> +    def test_powernv9_pcie_devices(self):
> +        """powernv9 (P9): NVMe + e1000e + xHCI detected."""
> +        self._do_test_powernv_pcie_devices('powernv9')
> +
> +    def test_powernv10_pcie_devices(self):
> +        """powernv10 (P10): NVMe + e1000e + xHCI detected."""
> +        self._do_test_powernv_pcie_devices('powernv10')
> +
> +    def test_powernv11_pcie_devices(self):
> +        """powernv11 (P11): NVMe + e1000e + xHCI detected."""
> +        self._do_test_powernv_pcie_devices('powernv11')

Booting a kernel always takes a lot of time. So please don't add new test 
for this. If you feel like we really should check for those PCIe devices, 
please extend the existing test in tests/functional/ppc64/test_powernv.py 
instead.

  Thanks,
   Thomas


