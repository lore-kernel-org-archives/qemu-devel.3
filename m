Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05666D1489D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdiwj-0003fS-Nj; Thu, 08 Jan 2026 00:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdiwh-0003eS-BS
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:52:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdiwe-0001xm-H4
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767851546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O9wCDfbH8XQ2qLvw9iq7nY0v6UYPDlbPHyCxIW0GTuM=;
 b=bl5Zpvygr2pzUTPAZ8KouEjbv1ENUwCH6a5UlQFgwDuzLUjbvTQQ96Tgn8/TPYvkhT10eY
 OnrCOQM+OQ92Y5wRdSfqVdsVwdZkdfhMUaWUGbEqnXvO70ypnS+bj4WqeLiBMJevEggqo7
 WXI6FIJJAvH2jBVWCR8bwspTpl5OXlo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-ImdWty3NMbq_KOCTZZWtdw-1; Thu, 08 Jan 2026 00:52:23 -0500
X-MC-Unique: ImdWty3NMbq_KOCTZZWtdw-1
X-Mimecast-MFC-AGG-ID: ImdWty3NMbq_KOCTZZWtdw_1767851542
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b800559710aso220958266b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767851542; x=1768456342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O9wCDfbH8XQ2qLvw9iq7nY0v6UYPDlbPHyCxIW0GTuM=;
 b=bDDI7r9VRBWE7jAlF/UL5cX5lQHnjn7WBot88A0Xkp8u0tk7rjjBRbcnzXUfOMT3Kf
 QdalX4ZK4MmzTKIHjhfwwCorgnHE/kf6V4m5qRovpT6zi0YSebK4A1tJG/FOBd9kmH5G
 +l6pO6V+M0Y5TKM+61M0LJTyOxgG3JvNYSLEWn+ftX+MFR+exhupErhitc+mBKulOCR+
 xxh2r9LyOla3Qso4DJWKfZlK5GTlN3QHe86M377C65zRd6ZxdkI79QoO6JCjicbYHgR2
 7sfqYeIoEzcl4A3JB18qcTcyV18icNMmuzRIWcCIW3HDKQjmYuRKt9tjdsBOLsYn2iIn
 A4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767851542; x=1768456342;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O9wCDfbH8XQ2qLvw9iq7nY0v6UYPDlbPHyCxIW0GTuM=;
 b=BjnbfIUp3E6gBdv20vY/mDSr9MU+uT5b4bRdWUPkDO8TmixnTu+k+r0yZ2oD9pX3RL
 aF4PhlPFVBr/ZXQ3+q5ePPtOsYmGIlVNpMyVe+d38SfZzB8EbhqpCakTrGpg06scjxLf
 V+SRc1q8zSlMzct74PAtbD4g7vI9qDd5n0UBxygcIrmkKvSk4ivV9mBj0BO3EDI6eHA+
 hApwaA9XXT+lFw/M3fL7+WQOJrTYVMFVwuqsaITMJzow2ceMMscxZGKepsRcCmuEGdkR
 4svklLNI7zIxOZwEQs9OHwx4DX/YniPLZakh72GOQCBZv/g6cqYGvqDxBhfIvH5HNep7
 uihw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrU3sWE52YnhS8v7jVqQ6sJ6KqefT2IN3QocX+jXJacDf7+6T6n7KhqfTiRxa+ZhmS7Lb4w3jbyS78@nongnu.org
X-Gm-Message-State: AOJu0YzkjLdX38Cf7QXM/6MDnb3dG0GbuGMv6BbImvB1DWyYwscLwNdO
 Tyvo/vxLAsRwS5Scap2GfeHXiGB9sy5ChZKoxwl2mNVkj5pyzlTmwAuJY+33+SgNGYnaLhGL6qV
 7pmh62JxcFu9Dm0pW3TuPKkiU1fFcV+H1OtOwYACEnG0MhTef5fT4UYA2
X-Gm-Gg: AY/fxX5FaiKPVtRS1+VGCAAgEfDmIhOvsaj6ucCcSyUtbs2BJHJFAsn6QIEle9L6b8t
 SFEK5QWUUfKJcAmCUBqQBSSOS8uEFkeiq1azoTvjl+IuNy9VMLO0004rU9n7TR1cg40LdKm/u8i
 uHVSkjGna0S2mR+dDeTPXF1neKKn1Mz7LoDXfDEcaJjTik6XO7Ttc0itPIu3p8h3X+dITk+qGMr
 HQT+KZgzu1nqODMU7nBCEqj3HdK+jOwOaPXhairQiSdEU0oL7KE+WT3QEkRQ7zx2Qt1GfeBlG3G
 /siOzdZhaQbmz6ZDtJR6cit6JvUK2DpmFlZ+0/6qK2UGTD3lU+eslzo5Rep12X7vdgtOlkhVXEV
 51ME25fE=
X-Received: by 2002:a17:907:9603:b0:b80:a31:eb08 with SMTP id
 a640c23a62f3a-b84450205e1mr490635666b.55.1767851541905; 
 Wed, 07 Jan 2026 21:52:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElc3TodDCowEbLXD7PIMfnFOG97mI4T5gfPwdKYNQjVI3XTMdo4O0qaTG9VziUT4YXNlpgEA==
X-Received: by 2002:a17:907:9603:b0:b80:a31:eb08 with SMTP id
 a640c23a62f3a-b84450205e1mr490634266b.55.1767851541341; 
 Wed, 07 Jan 2026 21:52:21 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a2338cbsm701575466b.14.2026.01.07.21.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 21:52:20 -0800 (PST)
Message-ID: <30844b70-218e-41f5-a033-9956901d9189@redhat.com>
Date: Thu, 8 Jan 2026 06:52:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional/x86_64: Add vhost-user-bridge test
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251230002604.113632-1-yodel.eldar@yodel.dev>
 <6157618c-5454-457e-b65e-d9c16c428aaf@redhat.com>
 <93fe1ce9-6dc4-4c19-840d-9b1ad613c31c@yodel.dev>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <93fe1ce9-6dc4-4c19-840d-9b1ad613c31c@yodel.dev>
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

On 07/01/2026 18.32, Yodel Eldar wrote:
> 
> On 06/01/2026 22:52, Thomas Huth wrote:
>> On 30/12/2025 01.25, Yodel Eldar wrote:
>>> This introduces a functional test of vhost-user-bridge.
>>>
>>> The test runs vhost-user-bridge and launches a guest VM that connects
>>> to the internet through it. The test succeeds if and only if an attempt
>>> to connect to a hard-coded well-known URL succeeds.
>>>
>>> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
>>> ---
>>>
>>> This patch introduces a functional test of vhost-user-bridge by
>>> automating the testing described in its initial commit, 8e3b0cbb72,
>>> with adjustments like using hubports (formerly the vlan parameter) and
>>> memfd for the memory backend; hugepages are also omitted to avoid
>>> requiring root privileges on the host.
>>>
>>> The test configures networking within the guest by invoking udhcpc, then
>>> makes an http request via wget to a well-known URL, example.org, that
>>> has a low risk of requiring https for connections (a limitation of the
>>> the test). An assert on the retcode of wget determines success/failure.
>>>
>>> Please let me know if there are objections to the use of wget's retcode
>>> as the test's condition; determining wget success through its output is
>>> straightforward ("remote file exists"), but out of concern of some
>>> unknown failure message (besides "bad address") locking up the test,
>>> I've resorted to checking the retcode instead; perhaps, this violates
>>> some convention?
>>>
>>> Also, I figured checking for memfd support on the host was unnecessary
>>> in 2026 for the intended users of the test, but perhaps not?
>>>
>>> The guest's kernel contains an integrated initramfs and was built with
>>> buildroot; an attempt to ensure bit-for-bit reproducibility was made by
>>> building it via Containerfile based on a snapshot container image and
>>> use of the BR2_REPRODUCIBLE option of buildroot, but the latter feature
>>> is "experimental," so future builds may differ slightly (though the
>>> image in the repo will be left untouched). The image and associated
>>> build files are hosted on my personal account here:
>>>     https://github.com/yodel/vhost-user-bridge-test
>>> and will continue to be well into the future, but if there's some other
>>> preferred location for the asset, please let me know?
>>>
>>> Lastly, special thanks to Cédric for inspiring me to write the test in
>>> "<11454796-30d2-4a57-85a5-d42ff0dce2e6@redhat.com>".
>>>
>>> Thanks,
>>> Yodel
>>>
>>>   .../x86_64/test_vhost_user_bridge.py          | 124 ++++++++++++++++++
>>>   1 file changed, 124 insertions(+)
>>>   create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py
>>>
>>> diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/ tests/ 
>>> functional/x86_64/test_vhost_user_bridge.py
>>> new file mode 100755
>>> index 0000000000..61afdbceec
>>> --- /dev/null
>>> +++ b/tests/functional/x86_64/test_vhost_user_bridge.py
>>> @@ -0,0 +1,124 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Copyright (c) 2025 Software Freedom Conservancy, Inc.
>>> +#
>>> +# Author: Yodel Eldar <yodel.eldar@yodel.dev>
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +"""
>>> +Test vhost-user-bridge (vubr) functionality:
>>> +
>>> +    1) Run vhost-user-bridge on the host.
>>> +    2) Launch a guest VM:
>>> +        a) Instantiate a unix domain socket to the vubr-created path
>>> +        b) Instantiate a vhost-user net backend on top of that socket
>>> +        c) Expose vhost-user with a virtio-net-pci interface
>>> +        d) Instantiate UDP socket and user-mode net backends
>>> +        e) Hub the UDP and user-mode backends
>>> +    3) Run udhcpc in the guest to auto-configure networking.
>>> +    4) Run wget in the guest and check its retcode to test internet 
>>> connectivity
>>> +
>>> +The test fails if wget returns 1 and succeeds on 0.
>>> +"""
>>> +
>>> +import os
>>> +import subprocess
>>> +from qemu_test import Asset, QemuSystemTest, which
>>> +from qemu_test import exec_command_and_wait_for_pattern
>>> +from qemu_test import is_readable_executable_file
>>> +from qemu_test import wait_for_console_pattern
>>> +from qemu_test.ports import Ports
>>> +
>>> +class VhostUserBridge(QemuSystemTest):
>>> +
>>> +    ASSET_KERNEL_INITRAMFS = Asset(
>>> +        "https://github.com/yodel/vhost-user-bridge-test/raw/refs/ 
>>> heads/main/bzImage",
>>> + "3790bf35e4ddfe062425bca45e923df5a5ee4de44e456d6b00cf47f04991d549")
>>> +
>>> +    def configure_vm(self, ud_socket_path, lport, rport):
>>> +        kernel_path = self.ASSET_KERNEL_INITRAMFS.fetch()
>>> +
>>> +        self.require_accelerator("kvm")
>>> +        self.require_netdev("vhost-user")
>>> +        self.require_netdev("socket")
>>> +        self.require_netdev("hubport")
>>> +        self.require_netdev("user")
>>> +        self.require_device("virtio-net-pci")
>>> +        self.set_machine("q35")
>>> +        self.vm.set_console()
>>> +        self.vm.add_args(
>>> +            "-cpu",      "host",
>>> +            "-accel",    "kvm",
>>> +            "-kernel",   kernel_path,
>>> +            "-append",   "console=ttyS0",
>>> +            "-smp",      "2",
>>> +            "-m",        "128M",
>>> +            "-object",   "memory-backend-memfd,id=mem0,"
>>> +                         "size=128M,share=on,prealloc=on",
>>> +            "-numa",     "node,memdev=mem0",
>>> +            "-chardev", f"socket,id=char0,path={ud_socket_path}",
>>> +            "-netdev",   "vhost- 
>>> user,id=vhost0,chardev=char0,vhostforce=on",
>>> +            "-device",   "virtio-net-pci,netdev=vhost0",
>>> +            "-netdev",  f"socket,id=udp0,udp=localhost:{lport},"
>>> +                        f"localaddr=localhost:{rport}",
>>> +            "-netdev",   "hubport,id=hub0,hubid=0,netdev=udp0",
>>> +            "-netdev",   "user,id=user0",
>>> +            "-netdev",   "hubport,id=hub1,hubid=0,netdev=user0"
>>> +        )
>>> +
>>> +    def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rport):
>>> +        vubr_args = []
>>> +
>>> +        if (stdbuf_path := which("stdbuf")) is None:
>>> +            self.log.info("Could not find stdbuf: vhost-user-bridge "
>>> +                          "log lines may appear out of order")
>>> +        else:
>>> +            vubr_args += [stdbuf_path, "-o0", "-e0"]
>>> +
>>> +        vubr_args += [vubr_path, "-u", f"{ud_socket_path}",
>>> +                      "-l", f"127.0.0.1:{lport}", "-r", f"127.0.0.1: 
>>> {rport}"]
>>> +
>>> +        return vubr_args
>>> +
>>> +    def test_vhost_user_bridge(self):
>>> +        prompt = "~ # "
>>> +
>>> +        vubr_path = self.build_file("tests", "vhost-user-bridge")
>>> +        if is_readable_executable_file(vubr_path) is None:
>>> +            self.skipTest("Could not find a readable and executable "
>>> +                          "vhost-user-bridge")
>>> +
>>> +        with Ports() as ports:
>>> +            sock_dir = self.socket_dir()
>>> +            ud_socket_path = os.path.join(sock_dir.name, "vubr- test.sock")
>>> +            lport, rport = ports.find_free_ports(2)
>>> +
>>> +            self.configure_vm(ud_socket_path, lport, rport)
>>> +
>>> +            vubr_log_path = self.log_file("vhost-user-bridge.log")
>>> +            self.log.info("For the vhost-user-bridge application log,"
>>> +                         f" see: {vubr_log_path}")
>>> +
>>> +            vubr_args = self.assemble_vubr_args(vubr_path, ud_socket_path,
>>> +                                                lport, rport)
>>> +
>>> +            with open(vubr_log_path, "w") as vubr_log, \
>>> +                 subprocess.Popen(vubr_args, stdin=subprocess.DEVNULL,
>>> +                                  stdout=vubr_log, 
>>> stderr=subprocess.STDOUT):
>>> +                self.vm.launch()
>>> +
>>> +                wait_for_console_pattern(self, prompt)
>>> +                exec_command_and_wait_for_pattern(self, "udhcpc -nt 1", 
>>> prompt)
>>> +                exec_command_and_wait_for_pattern(self,
>>> +                    "wget -qT 2 --spider example.org", prompt)
>>
>> If you've got python in the guest, you could maybe also do it the other 
>> way round and host a httpd server in the guest, and download something to 
>> the host. See check_http_download in tests/functional/qemu_test/ 
>> linuxkernel.py for the helper function. That way you don't depend on any 
>> external host.
>>
>>   Thomas
>>
> 
> Thanks for the suggestion and that gem of a helper; I had missed that
> module when going over the framework.
> 
> I switched to using a ping pattern and checking vhost-user-bridge's log
> for the payload, but I don't like how brittle that is, because even
> though the log prints are hard-coded on right now, they might not be
> later, so having the guest serve a file's a welcome option, although the
> guest currently lacks python (and just about everything else).

I never tried, but maybe it's also possible the other way round: Use python 
on the host to simulate a httpd server, and then use wget in the guest to 
download a file from the host?

Another idea, if you happen to have a "tftp" binary in the guest, use that 
to download a file from the built-in tftpd server from QEMU, see e.g. 
do_xmaton_le_test in tests/functional/microblaze/test_s3adsp1800.py as an 
example.

  Thomas


