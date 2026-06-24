Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A825CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM29-00082m-Bm; Wed, 24 Jun 2026 07:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcM26-0007ir-Ju
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcM23-0008O3-RH
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NUAXCC1nIQ7z4ocyZcEJ9W6QCHR/ae5E15zZ5aMgd7k=;
 b=WVmqZKpth4mZBi0lQfQE3uU8GaX9GivDwRTGwt6IigMmTb3Q8V7mNmUOrPFKVvXNji4QSF
 dee93ev89ej7vMtBF3TPkRcJPGK/xzj61ownteetOYDER1SmAqzWiK/mfdLQYaxrfu2NLw
 7bqY9Z5mUNWiTXS7DDylq1UUm1L9fJY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-jnTyzrReNqOq7_GeLiKhkQ-1; Wed, 24 Jun 2026 07:44:37 -0400
X-MC-Unique: jnTyzrReNqOq7_GeLiKhkQ-1
X-Mimecast-MFC-AGG-ID: jnTyzrReNqOq7_GeLiKhkQ_1782301476
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-462c4593a33so709930f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 04:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782301476; x=1782906276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NUAXCC1nIQ7z4ocyZcEJ9W6QCHR/ae5E15zZ5aMgd7k=;
 b=E0JVPi6ZOC+1ilUpCHFNpj1Ei6Rx5kX43IO7iWpTVG0kPg54FX0b3VdycO5DeCx98M
 JhEn4pYCj5EF+QM2jPPlXzEIa6qSM+PChi6Gw0NKam0gIOP9Vixb6cpPKuHiWG+lS4DF
 9n3M9rjRpjCGoIStRBuCE2ck+JEb2QJeC7P3Nzv0fE1dcWgyOZSXnfA2k24kIqq9stde
 qKjUbOV8+5Y4/Eh6DIEr3REj6t5+vsTTnBoLusGjOevzudy0d91/iafO0jc6p0TU6ptI
 eVhVLBij/o1eaT9zbsbNdb0qA7uZ6HndarxjwMQm9RBK830zR3DkMrye8M4/P46Sd04r
 2wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782301476; x=1782906276;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NUAXCC1nIQ7z4ocyZcEJ9W6QCHR/ae5E15zZ5aMgd7k=;
 b=NtoXxV0OWkxSSSP4MSVmXw9MYR0BLKtSjkqBpBV32jbiNKjSXzv0KUb756bytFxAAC
 Wqy9+IbEcKXAwFxMu41JXBs2RtygqQ0+2bmYc1d6zv4P0IykU0eUdh8s+4KMX4XOt7wp
 TPTSvMWOBZuBcj49z+TZffgY/WK4jl9jiZqfRkPxKNZXbt34/a9azAQs8fhSHcdcq5p0
 06afP6jsxIZWVxmP5DEhyAricteMmS5D1e3lZ5KOmDwHrUwhawwbb4waBldhrXqeFsBg
 rRe3PDWhdpsYu51XXzY+Fn3+nZYWB3kDDSbCePqEo8Pt1wOhAbXuRqw2ZNlJ0FWYsPRx
 bH6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHmpE+AtB1r4+ZetBNyYVHt5V4iHxqDUXziC5FUITtG6jHy6UeDMc6c6VNooJd6KXT1KwMkVOp1EcL@nongnu.org
X-Gm-Message-State: AOJu0YyXO4iDViZ5n6EX23jVga9ZB7GeJ8woxajpXe9dwsWh8WNS9QWe
 ftu4rAYOYlqa314nleT0hbHngco6h+rln/Uj4l7n/Pym+5fOFnlN3RG/sQofSTUA11hJ5xvg3gS
 /+cqoqhJXs7rzV1ILLV2hSlMUTwlU70D8pTu8+MUFq05dz5ECxj1YhsSP
X-Gm-Gg: AfdE7ckerpIKUPJqzPsUwetuT0dHJFWjGUsdG1sCGKUsXD5bySc8BJwrHk2d9fBwA9h
 EVwW1X2lLIhf7hUS2a4+g+1dJ2fzKlDkNPL8r+nkkFXhOfWDM6bbVYHcfkRr8fW5ptd0yqhPWZr
 qVwaqUVIaKrCoMVDKN7BYZLJ45KFhqxx6XUQPNAMSBlHrNEY842LksBk0XkQpNYqcT859ztNRt4
 deHwMwwbJMHoqs+BcFh/KxcTesYRYA75JwvBfTF7sq+jCPsROkXIhBUydRrDd6drYYKeknVZJQf
 rZhe2HJwjDCTGzOzXwkiLQD5G4Wa9fjKh01fFY953l6ytrJ8VDyPM6qBiQ//1P3oPzIZ8fdYcHt
 Lenwn2UQlv6vkk3OAoP8l8AzI4o45FBfeGgjFvIOdKdaBDemnJDAlpno=
X-Received: by 2002:a05:6000:27c3:b0:46a:45d:2bed with SMTP id
 ffacd0b85a97d-46ad8a3a181mr7696418f8f.8.1782301476169; 
 Wed, 24 Jun 2026 04:44:36 -0700 (PDT)
X-Received: by 2002:a05:6000:27c3:b0:46a:45d:2bed with SMTP id
 ffacd0b85a97d-46ad8a3a181mr7696388f8f.8.1782301475684; 
 Wed, 24 Jun 2026 04:44:35 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6?
 ([2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279bc77sm5412083f8f.32.2026.06.24.04.44.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 04:44:34 -0700 (PDT)
Message-ID: <2f6d69e5-e11e-4561-a38f-84760525a549@redhat.com>
Date: Wed, 24 Jun 2026 13:44:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] tests/functional: Add remote interrupts test for
 PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-2-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260623141933.577981-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/23/26 16:19, Aditya Gupta wrote:
> In the past there have been hard to recreate issues where XIVE changes
> cause qemu crashes due to multi-socket interrupts such as in [1].
> 
> Add a functional test explicitly to test whether remote interrupts work.
> 
> The test can also work as additional boot test for multi-socket boot,
> initrd boot test, as well as a check for e1000e to be working in powernv,
> though that's not a target goal, and are additional benefits.
> 
>  From docs/system/devices/net.rst:
> 
>    In order to check that the user mode network is working, you can ping
>    the address 10.0.2.2 and verify that you got an address in the range
>    10.0.2.x from the QEMU virtual DHCP server.
> 
> Hence use 10.0.2.2 with ping.
> 
> [1]: https://lore.kernel.org/qemu-devel/baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com/
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   tests/functional/ppc64/test_powernv.py | 86 ++++++++++++++++++++++++++
>   1 file changed, 86 insertions(+)
> 
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index 0ea6c93e4287..17d2447815f9 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -9,6 +9,7 @@
>   
>   from qemu_test import LinuxKernelTest, Asset
>   from qemu_test import wait_for_console_pattern
> +from qemu_test import exec_command_and_wait_for_pattern
>   
>   class PowernvMachine(LinuxKernelTest):
>   
> @@ -27,6 +28,9 @@ class PowernvMachine(LinuxKernelTest):
>            'buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2'),
>           'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
>   
> +    def helper_exec_shell_command(self, command):
> +        exec_command_and_wait_for_pattern(self, command, '#', self.panic_message)
> +
>       def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
>           self.require_accelerator("tcg")
>           kernel_path = self.ASSET_KERNEL.fetch()
> @@ -71,6 +75,88 @@ def test_linux_smt_boot(self):
>           wait_for_console_pattern(self, console_pattern, self.panic_message)
>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>   
> +    def test_linux_remote_interrupts(self):
> +        self.require_accelerator("tcg")
> +        self.set_machine('powernv')
> +
> +        # have more sockets with as few CPUs as possible, increasing the
> +        # probability to have remote interrupts from one chip to another
> +        # also have e1000e network device to generate interrupts

Can you attach the PCI device to a PCI bus known to be on the
second socket ? and then offline cpus on the second socket,
so that all IRQ servers are on the first socket.

> +        self.vm.add_args('-smp', '4,sockets=4,threads=1')
> +        self.vm.add_args('-device', 'e1000e,netdev=net0')
> +        self.vm.add_args('-netdev', 'user,id=net0')
> +
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        rootfs_path = self.ASSET_INITRD.fetch()
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_path,
> +            '-drive',
> +            f'file={rootfs_path},format=raw,if=none,id=drive0,readonly=on',
> +            '-append', 'root=/dev/nvme0n1 console=hvc0',
> +            '-device', 'nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234')
> +        self.vm.launch()
> +
> +        # Wait for boot to complete
> +        console_pattern = 'CPU maps initialized for 1 thread per core'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        console_pattern = 'smp: Brought up 4 nodes, 4 CPUs'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, 'Run /sbin/init as init process',
> +                                 self.panic_message)
> +
> +        # Wait for login prompt and login as root (no password in buildroot)
> +        wait_for_console_pattern(self, 'login:', self.panic_message)
> +        exec_command_and_wait_for_pattern(self, 'root', '#', self.panic_message)
> +
> +        # RX, TX interrupts to chip/cpu 1 & 2 respectively
> +        self.helper_exec_shell_command(
> +            "export RX_IRQ=$(awk '/eth0-rx/ {print $1}' /proc/interrupts | tr -d ':')")
> +        self.helper_exec_shell_command(
> +            "export TX_IRQ=$(awk '/eth0-tx/ {print $1}' /proc/interrupts | tr -d ':')")
> +        self.helper_exec_shell_command("echo 1 > /proc/irq/$RX_IRQ/smp_affinity_list")
> +        self.helper_exec_shell_command("echo 2 > /proc/irq/$TX_IRQ/smp_affinity_list")
> +
> +        # Capture interrupt counts before generating traffic
> +        self.helper_exec_shell_command(
> +            "export RX_BEFORE=$(awk '/eth0-rx/ {print $3}' /proc/interrupts)")
> +        self.helper_exec_shell_command(
> +            "export TX_BEFORE=$(awk '/eth0-tx/ {print $4}' /proc/interrupts)")
> +
> +        # Wait up to 15 seconds for eth0 link to come up
> +        self.helper_exec_shell_command(
> +            "c=0; while ! ip addr show eth0 | grep 'inet 10.0.2'; do "
> +            "sleep 1; c=$((c+1)); [ $c -gt 15 ] && break; done")
> +
> +        fail_msg="Fail"
> +        self.helper_exec_shell_command(f"export FAIL={fail_msg}")
> +        exec_command_and_wait_for_pattern(self,
> +            "ip addr show eth0 | grep 'inet 10.0.2' || echo $FAIL",
> +            '#', fail_msg)
> +
> +        # Generate network traffic to trigger remote interrupts
> +        # Ping QEMU's user-mode network gateway (10.0.2.2)
> +        self.helper_exec_shell_command("ping -W2 -c5 10.0.2.2")
> +
> +        # Show final interrupt counts to verify remote interrupts occurred
> +        self.helper_exec_shell_command("cat /proc/interrupts | grep eth0")
> +
> +        # Verify interrupt counts increased (whether interrupts were delivered)
> +        self.helper_exec_shell_command(
> +            "export RX_AFTER=$(awk '/eth0-rx/ {print $3}' /proc/interrupts)")
> +        self.helper_exec_shell_command(
> +            "export TX_AFTER=$(awk '/eth0-tx/ {print $4}' /proc/interrupts)")
> +
> +        # Check that interrupt counts increased
> +        success_msg = "Interrupts increased"
> +        self.helper_exec_shell_command(f"export PASS='{success_msg}'")
> +
> +        exec_command_and_wait_for_pattern(self,
> +            "[ $RX_AFTER -gt $RX_BEFORE ] && echo $PASS || echo $FAIL",
> +            success_msg, fail_msg)
> +        exec_command_and_wait_for_pattern(self,
> +            "[ $TX_AFTER -gt $TX_BEFORE ] && echo $PASS || echo $FAIL",
> +            success_msg, fail_msg)
> +
>       def test_linux_big_boot(self):
>           self.set_machine('powernv')
>           self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')


