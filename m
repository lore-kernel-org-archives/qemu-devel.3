Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7D8CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 15:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwjD5-0006TH-4W; Thu, 11 Sep 2025 11:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwjD2-0006SM-Nb
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwjD0-0001Og-EM
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757604450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2QCAmnJLGBLN51jNUOoc+FaOgOXUPOO3XmKhNDK1ytY=;
 b=P6Sm2DXHRkoZ6VjYjbpde7p0v3SL0ZWzuPed57X8+dUIJKeeTiBMKBTqluH7wDPjFYVJWY
 sznr6XKCTkVMsPnfIN3pcPWtOJxhGnehuLS1/PlBcSW5qsOCKmkba8ESiIf5NhHYKhU+LF
 VPlHk5geHmaII8X9mR49buMSXxVVR5Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-w_Bdxf00O3aeQ3V0F-fHpw-1; Thu, 11 Sep 2025 11:27:28 -0400
X-MC-Unique: w_Bdxf00O3aeQ3V0F-fHpw-1
X-Mimecast-MFC-AGG-ID: w_Bdxf00O3aeQ3V0F-fHpw_1757604447
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3e04ea95c6cso430728f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 08:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757604447; x=1758209247;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2QCAmnJLGBLN51jNUOoc+FaOgOXUPOO3XmKhNDK1ytY=;
 b=I9OEnGpustQeYGn5AxPAxZREb2sdZGXAdhPHQUNK51sJQnnj2LCG+/H3K/T5e5L+8X
 h87a2eFS6obajH44CtHmHHRdyXKDWE46os5YM/MkQYZ1Qc8S2RAdCTPP6qK88jeU/FCD
 KHNr0CrRE14IZiedlC6Qk5i9mimXeqWvL3o9UaKgduNW1K8MfASdbJUwnnNm2rMEiB2A
 ncPjBYFUGClM/NHcuH1E9bZg91pc6nVpgUNRdIH0/Zibk48Sx/7NepGawkXuB/OToatr
 5zpNJk9FpEHLmtEIB05oOHm05OKe9XCTKZKdbCx9qsMkO8UNuQYKOrvouSAgu9Ae4FOq
 u2+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgZIEDDIxDtE1jb6pYsqtLIB1I3/G5FVdApsPE12bhZyoh+LGxGK2NJb86KHetfntFdwY2KwS/m9Eo@nongnu.org
X-Gm-Message-State: AOJu0Yy0vrPyzc5eVh52uBTMF/BR7OtSLL3N+vT7ttfYILVd4L+V6Oi5
 tZZfy0Pa/J9zshuley3tqxVZGDpz6uy3FT21cKYDFa7x9Ahv83Gk/6d9x2IX6ilfr9bMIqAKPa2
 0fJG92lPN9rVIgolQKkMEk7ZPoq7Ngr8VHse9SGEwJ468t67zzJxwCQqb
X-Gm-Gg: ASbGncsdsm0YyzEVZWwk5QhEhiCvP7FTIrm4svRB57/ejVnEK+YCP94QZFGEGZhDATu
 v902gO+4E2esucFEeek1BqQXFEZfUcAXsnN6NZB6/1j5jKDEeM5JM9Pwc6UvyWS+vl8rzL2+WdK
 DxkN6Nkm0Wh8T4eBqLSbvmRajk1wXPY9VvaAOc78ZlT2y0mSqq7ybBBFes4exz1SfCxNp9ahGzp
 HOij6png0nLU6fZGOgKmGbi3rEQ+x68dkwGN3UEo81UAOBGqq8YLkbaTVbCUmBwQfH5Yh2ol2gh
 1ikLo02I+9YWByKKeGUvSkGec3Q+6PQrqMay9mfLHPYVyza71tAsQb9Cv9jIljOUtXkO0ovQOsX
 FHwK4NA==
X-Received: by 2002:a05:6000:2c0b:b0:3e0:37f3:7778 with SMTP id
 ffacd0b85a97d-3e64317d070mr18537833f8f.26.1757604447052; 
 Thu, 11 Sep 2025 08:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/PncLgqQh9eRLISbvQTaQVREJoO4tI6qsOmiMxOyJvIC8zbAdkaJsYHBwcuc90MFBE0zxDw==
X-Received: by 2002:a05:6000:2c0b:b0:3e0:37f3:7778 with SMTP id
 ffacd0b85a97d-3e64317d070mr18537794f8f.26.1757604446366; 
 Thu, 11 Sep 2025 08:27:26 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e76078761asm2861028f8f.25.2025.09.11.08.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 08:27:25 -0700 (PDT)
Message-ID: <0d71919b-d5f9-47cd-9979-a692f3cf6a8d@redhat.com>
Date: Thu, 11 Sep 2025 17:27:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tests/functional: add a vfio-user smoke test
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20250911142228.1955529-1-john.levon@nutanix.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250911142228.1955529-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi!

On 11/09/2025 16.22, John Levon wrote:
> From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> Add a basic test of the vfio-user PCI client implementation.
> 
> Co-authored-by: John Levon <john.levon@nutanix.com>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
...
> diff --git a/tests/functional/x86_64/test_vfio_user_client.py b/tests/functional/x86_64/test_vfio_user_client.py
> new file mode 100755
> index 0000000000..1e4c5bc875
> --- /dev/null
> +++ b/tests/functional/x86_64/test_vfio_user_client.py
> @@ -0,0 +1,197 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (c) 2025 Nutanix, Inc.
> +#
> +# Author:
> +#  Mark Cave-Ayland <mark.caveayland@nutanix.com>
> +#  John Levon <john.levon@nutanix.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +"""
> +Check basic vfio-user-pci client functionality. The test starts two VMs:
> +
> +    - the server VM runs the libvfio-user "gpio" example server inside it,
> +      piping vfio-user traffic between a local UNIX socket and a virtio-serial
> +      port. On the host, the virtio-serial port is backed by a local socket.
> +
> +    - the client VM loads the gpio-pci-idio-16 kernel module, with the
> +      vfio-user client connecting to the above local UNIX socket.
> +
> +This way, we don't depend on trying to run a vfio-user server on the host
> +itself.
> +
> +Once both VMs are running, we run some basic configuration on the gpio device
> +and verify that the server is logging the expected out. As this is consistent
> +given the same VM images, we just do a simple direct comparison.
> +"""

I'm not a python expert, but I guess it would make sense to move that 
description block next to the "class VfioUserClient(QemuSystemTest):" line 
so that it's the description for the class? (that would fix the "Missing 
class docstring" that you get when using "pylint" on your code)

> +import difflib
> +import logging
> +import os
> +import select
> +import shutil
> +import socket
> +import subprocess
> +import time

pylint complains:

tests/functional/x86_64/test_vfio_user_client.py:28:0: W0611: Unused import 
difflib (unused-import)
tests/functional/x86_64/test_vfio_user_client.py:29:0: W0611: Unused import 
logging (unused-import)
tests/functional/x86_64/test_vfio_user_client.py:30:0: W0611: Unused import 
os (unused-import)
tests/functional/x86_64/test_vfio_user_client.py:31:0: W0611: Unused import 
select (unused-import)
tests/functional/x86_64/test_vfio_user_client.py:32:0: W0611: Unused import 
shutil (unused-import)
tests/functional/x86_64/test_vfio_user_client.py:33:0: W0611: Unused import 
socket (unused-import)
tests/functional/x86_64/test_vfio_user_client.py:34:0: W0611: Unused import 
subprocess (unused-import)
tests/functional/x86_64/test_vfio_user_client.py:35:0: W0611: Unused import 
time (unused-import)

... so I think you can remove those.

> +from qemu_test import Asset
> +from qemu_test import QemuSystemTest
> +from qemu_test import exec_command

Same for "exec_command" ... you don't use it in your test here.

> +from qemu_test import exec_command_and_wait_for_pattern
> +from qemu_test import wait_for_console_pattern
> +
> +# Exact output can vary, so we just sample for some expected lines.
> +EXPECTED_SERVER_LINES = [
> +    "gpio: adding DMA region [0, 0xc0000) offset=0 flags=0x3",
> +    "gpio: devinfo flags 0x3, num_regions 9, num_irqs 5",
> +    "gpio: region_info[0] offset 0 flags 0 size 0 argsz 32",
> +    "gpio: region_info[1] offset 0 flags 0 size 0 argsz 32",
> +    "gpio: region_info[2] offset 0 flags 0x3 size 256 argsz 32",
> +    "gpio: region_info[3] offset 0 flags 0 size 0 argsz 32",
> +    "gpio: region_info[4] offset 0 flags 0 size 0 argsz 32",
> +    "gpio: region_info[5] offset 0 flags 0 size 0 argsz 32",
> +    "gpio: region_info[7] offset 0 flags 0x3 size 256 argsz 32",
> +    "gpio: region7: read 256 bytes at 0",
> +    "gpio: region7: read 0 from (0x30:4)",
> +    "gpio: cleared EROM",
> +    "gpio: I/O space enabled",
> +    "gpio: memory space enabled",
> +    "gpio: SERR# enabled",
> +    "gpio: region7: wrote 0x103 to (0x4:2)",
> +    "gpio: I/O space enabled",
> +    "gpio: memory space enabled",
> +]
> +
> +class VfioUserClient(QemuSystemTest):
> +
> +    ASSET_REPO = 'https://github.com/mcayland-ntx/libvfio-user-test'

Not sure whether that indirection works with the asset pre-caching 
mechanism? Daniel, could you comment on that?

> +    ASSET_KERNEL = Asset(
> +        f'{ASSET_REPO}/raw/refs/heads/main/images/bzImage',
> +        '40292fa6ce95d516e26bccf5974e138d0db65a6de0bc540cabae060fe9dea605'
> +    )
> +
> +    ASSET_ROOTFS = Asset(
> +        f'{ASSET_REPO}/raw/refs/heads/main/images/rootfs.ext2',
> +        'e1e3abae8aebb8e6e77f08b1c531caeacf46250c94c815655c6bbea59fc3d1c1'
> +    )
> +
> +
> +    def prepare_images(self):
> +        """Download the images for the VMs."""
> +        self.kernel_path = self.ASSET_KERNEL.fetch()
> +        self.rootfs_path = self.ASSET_ROOTFS.fetch()
> +
> +    def configure_server_vm_args(self, server_vm, sock_path):
> +        """
> +        Configuration for the server VM. Set up virtio-serial device backed by
> +        the given socket path.
> +        """
> +        server_vm.add_args('-kernel', self.kernel_path)
> +        server_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
> +        server_vm.add_args('-drive',
> +            f"file={self.rootfs_path},if=ide,format=raw,id=drv0")
> +        server_vm.add_args('-snapshot')
> +        server_vm.add_args('-chardev',
> +            f"socket,id=sock0,path={sock_path},telnet=off,server=on,wait=off")
> +        server_vm.add_args('-device', 'virtio-serial')
> +        server_vm.add_args('-device',
> +            'virtserialport,chardev=sock0,name=org.fedoraproject.port.0')
> +
> +    def configure_client_vm_args(self, client_vm, sock_path):
> +        """
> +        Configuration for the client VM. Point the vfio-user-pci device to the
> +        socket path configured above.
> +        """
> +
> +        client_vm.add_args('-kernel', self.kernel_path)
> +        client_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
> +        client_vm.add_args('-drive',
> +            f'file={self.rootfs_path},if=ide,format=raw,id=drv0')
> +        client_vm.add_args('-snapshot')
> +        client_vm.add_args('-device',
> +            '{"driver":"vfio-user-pci",' +
> +            '"socket":{"path": "%s", "type": "unix"}}' % sock_path)
> +
> +    def setup_vfio_user_pci_server(self, server_vm):
> +        """
> +        Start the libvfio-user server within the server VM, and arrange
> +        for data to shuttle between its socket and the virtio serial port.
> +        """
> +        wait_for_console_pattern(self, 'login:', None, server_vm)
> +        exec_command_and_wait_for_pattern(self, 'root', '#', None, server_vm)
> +
> +        exec_command_and_wait_for_pattern(self,
> +            'gpio-pci-idio-16 -v /tmp/vfio-user.sock >/var/tmp/gpio.out 2>&1 &',
> +            '#', None, server_vm)
> +        # wait for libvfio-user to initialize properly
> +        exec_command_and_wait_for_pattern(self, 'sleep 5', '#', None, server_vm)

Could the sleep be avoided? ... it's still a race condition (even if it's 
unlikely when you wait for 5 seconds), and always sleeping 5 seconds slows 
down the test quite a bit ...

Could you maybe poll something instead, e.g. output of "dmesg" or something 
in the file system? (sorry, I don't have any clue about vfio-user, so I 
don't know any better suggestions)

> +        exec_command_and_wait_for_pattern(self,
> +            'socat UNIX-CONNECT:/tmp/vfio-user.sock /dev/vport0p1,ignoreeof ' +
> +            ' &', '#', None, server_vm)
> +
> +    def test_vfio_user_pci(self):
> +        self.prepare_images()

Please move the "prepare_images" after the set_machine() and 
require_device() calls. Reason: set_machine() and require_device() could 
skip the test if it's not available in the qemu binary, so in that case you 
don't want to try to fetch the assets first.

> +        self.set_machine('pc')
> +        self.require_device('virtio-serial')
> +        self.require_device('vfio-user-pci')
> +
> +        sock_dir = self.socket_dir()
> +        socket_path = sock_dir.name + '/vfio-user.sock'

Better use os.path.join() instead of hard-coding slashes.

  Thanks,
   Thomas


