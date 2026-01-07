Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AB9CF6BEB
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 04:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdLXQ-00070g-RH; Tue, 06 Jan 2026 23:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdLXP-0006yd-Lr
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 23:52:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdLXN-0005mV-0n
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 23:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767761565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PYXXDKhzSj2Nu5FLiufhOZhPt544RSPTrshVkHZCcec=;
 b=N2XboHNzWAjtvxzKECQiG7DbfyKnOStvDIlIDkz7Kyd0QGUBkGl/8UhZjbiQPLgsJVCgyb
 QV+/6BMgzav9pxbxY+tEg2UdH6vlG0n5GvpETlIIqVR1kvul8EbERK0Kn0F9qBhTskPAPb
 qmyv7gQk+My9mEcNsS+H+gjE+1lCnK4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-0JFa6h4hOxyx22xRxyL8bQ-1; Tue, 06 Jan 2026 23:52:44 -0500
X-MC-Unique: 0JFa6h4hOxyx22xRxyL8bQ-1
X-Mimecast-MFC-AGG-ID: 0JFa6h4hOxyx22xRxyL8bQ_1767761563
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477771366cbso11750605e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 20:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767761563; x=1768366363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PYXXDKhzSj2Nu5FLiufhOZhPt544RSPTrshVkHZCcec=;
 b=j6w2bKmKK+W6eCkKJUwVMdZnBZfcqYerX3G9+AD03/st2I4/D3/GgV0Amse1QWhMjt
 J1spqNs92GS8AG9G7+6s44cE87HO5eOlsySsfhrxA/JiC560PJxMNDwKEJZuhQ8BVKZL
 uHZDh6Gp7u7Hxcgm+0CPN5QVfOaShHaRroGMLI43moofxlUcuOk2arD9657jxgqUhgPp
 kxGZTDaDLbrRROwXm0dDl5LCp8SmEROqQsEdVnRCeVJoqBCkO46TC097LYYvz6hioMhC
 OggkKaB3J6YwKOlk6e3nJpO5V1ywp6C1vhXwVtMmBGuMNSfnyOoNygwHEDiGAL4cHywV
 +vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767761563; x=1768366363;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PYXXDKhzSj2Nu5FLiufhOZhPt544RSPTrshVkHZCcec=;
 b=eF6CKr9JealOfV5IqXKE70r3Y/8+7ja0BgjroOA4uuP30Vz8bnbmVXtPS+kl9ja25J
 GLuVpDH3j2bpEvwV8wYK2/2o007mi/dGjBkx6P2q84PcFN/6MGvd8jjEL+D8tZQrh8jy
 H1KKXnN3ndNbhMt/WaZ+8OdDrx3YY1Dl+NEbTowD1iiArMD7eNP4CluNwHWJiWwRMY2+
 r7pZ5H1RBIunkETr0CkKqKuV2bEqs+lcCo49wlEJ2efCyc2sJNUl2RsDKJFTCel1f4iO
 49R3CzOEj8HwE6t3UU2dKe9tlFY5GSPZsfK71qIUg9j5dHzXZnP7Fhf4nkC2flQTRBfL
 nVPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX60KiXBFNrsjHnACGaJZWh0Ui3SLnfVcvRtu19BD1fVrF27OKBWFpqQujq1F3XvcTBrBIUb0Cx57LW@nongnu.org
X-Gm-Message-State: AOJu0YwGCS/meyEM1YkeKQUkfWptGmwxUnJSIdqRFv/QVtBM38nYvWns
 pp9NHaF3aj4+ioRhooEsv6hWanfRJz3BhUc0wdFH6cYdVS+AXACxrL4o5CrhhCq0/yNDb1YzP+F
 n5RHActAw01whWug7UEKB15Y9hI2jbo6Eg2Ib5nS7Z2PStA1ukdmNPhMG
X-Gm-Gg: AY/fxX4082fiitg6Wst06vUCN29Qb2PMfz90BvuKWGoSs4uU1sla1AVC8yPCoq425Mt
 uK7G3ZRe3o8nrVRFEvdp+rP9cv6AWibvhcGg8izcvM8lM+/0ZpH0L7qhOW+rp6LDn2GUAaDBWj0
 Uu2WhZXtvQG2hHuJdLykWt6R+5UNXJ3zGScEkJOcQjQqfz+aY0l7/xrNNhpgQ+aBaMUJ8Bvz0k4
 7SvZRgjBv9xRP668BvkV5dAb7QXCGFuo8iDRBZ9pQ45gbuj47xzn4d5Y0ACNIPVUC3Hb6yznclB
 WwL2iU+yozAlIiHBmb19Mmf6YMHMmqT2/CmYSvyDmsKq8I3T/cpUebGJ6wnxE46nZEdfyKx93Ed
 d5Dnbo/U=
X-Received: by 2002:a05:600c:8b2c:b0:477:76cb:4812 with SMTP id
 5b1f17b1804b1-47d849bd639mr9548465e9.0.1767761562970; 
 Tue, 06 Jan 2026 20:52:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb6m6kXY6WoAipxd483l69AUf3TeJNksNliY1E4qDRwFWyyR6469QRtku9BXVEKj0Q7yAL9g==
X-Received: by 2002:a05:600c:8b2c:b0:477:76cb:4812 with SMTP id
 5b1f17b1804b1-47d849bd639mr9548405e9.0.1767761562539; 
 Tue, 06 Jan 2026 20:52:42 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5dfa46sm8052430f8f.27.2026.01.06.20.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 20:52:41 -0800 (PST)
Message-ID: <6157618c-5454-457e-b65e-d9c16c428aaf@redhat.com>
Date: Wed, 7 Jan 2026 05:52:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional/x86_64: Add vhost-user-bridge test
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251230002604.113632-1-yodel.eldar@yodel.dev>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251230002604.113632-1-yodel.eldar@yodel.dev>
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

On 30/12/2025 01.25, Yodel Eldar wrote:
> This introduces a functional test of vhost-user-bridge.
> 
> The test runs vhost-user-bridge and launches a guest VM that connects
> to the internet through it. The test succeeds if and only if an attempt
> to connect to a hard-coded well-known URL succeeds.
> 
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
> 
> This patch introduces a functional test of vhost-user-bridge by
> automating the testing described in its initial commit, 8e3b0cbb72,
> with adjustments like using hubports (formerly the vlan parameter) and
> memfd for the memory backend; hugepages are also omitted to avoid
> requiring root privileges on the host.
> 
> The test configures networking within the guest by invoking udhcpc, then
> makes an http request via wget to a well-known URL, example.org, that
> has a low risk of requiring https for connections (a limitation of the
> the test). An assert on the retcode of wget determines success/failure.
> 
> Please let me know if there are objections to the use of wget's retcode
> as the test's condition; determining wget success through its output is
> straightforward ("remote file exists"), but out of concern of some
> unknown failure message (besides "bad address") locking up the test,
> I've resorted to checking the retcode instead; perhaps, this violates
> some convention?
> 
> Also, I figured checking for memfd support on the host was unnecessary
> in 2026 for the intended users of the test, but perhaps not?
> 
> The guest's kernel contains an integrated initramfs and was built with
> buildroot; an attempt to ensure bit-for-bit reproducibility was made by
> building it via Containerfile based on a snapshot container image and
> use of the BR2_REPRODUCIBLE option of buildroot, but the latter feature
> is "experimental," so future builds may differ slightly (though the
> image in the repo will be left untouched). The image and associated
> build files are hosted on my personal account here:
> 	https://github.com/yodel/vhost-user-bridge-test
> and will continue to be well into the future, but if there's some other
> preferred location for the asset, please let me know?
> 
> Lastly, special thanks to Cédric for inspiring me to write the test in
> "<11454796-30d2-4a57-85a5-d42ff0dce2e6@redhat.com>".
> 
> Thanks,
> Yodel
> 
>   .../x86_64/test_vhost_user_bridge.py          | 124 ++++++++++++++++++
>   1 file changed, 124 insertions(+)
>   create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py
> 
> diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/functional/x86_64/test_vhost_user_bridge.py
> new file mode 100755
> index 0000000000..61afdbceec
> --- /dev/null
> +++ b/tests/functional/x86_64/test_vhost_user_bridge.py
> @@ -0,0 +1,124 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (c) 2025 Software Freedom Conservancy, Inc.
> +#
> +# Author: Yodel Eldar <yodel.eldar@yodel.dev>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +"""
> +Test vhost-user-bridge (vubr) functionality:
> +
> +    1) Run vhost-user-bridge on the host.
> +    2) Launch a guest VM:
> +        a) Instantiate a unix domain socket to the vubr-created path
> +        b) Instantiate a vhost-user net backend on top of that socket
> +        c) Expose vhost-user with a virtio-net-pci interface
> +        d) Instantiate UDP socket and user-mode net backends
> +        e) Hub the UDP and user-mode backends
> +    3) Run udhcpc in the guest to auto-configure networking.
> +    4) Run wget in the guest and check its retcode to test internet connectivity
> +
> +The test fails if wget returns 1 and succeeds on 0.
> +"""
> +
> +import os
> +import subprocess
> +from qemu_test import Asset, QemuSystemTest, which
> +from qemu_test import exec_command_and_wait_for_pattern
> +from qemu_test import is_readable_executable_file
> +from qemu_test import wait_for_console_pattern
> +from qemu_test.ports import Ports
> +
> +class VhostUserBridge(QemuSystemTest):
> +
> +    ASSET_KERNEL_INITRAMFS = Asset(
> +        "https://github.com/yodel/vhost-user-bridge-test/raw/refs/heads/main/bzImage",
> +        "3790bf35e4ddfe062425bca45e923df5a5ee4de44e456d6b00cf47f04991d549")
> +
> +    def configure_vm(self, ud_socket_path, lport, rport):
> +        kernel_path = self.ASSET_KERNEL_INITRAMFS.fetch()
> +
> +        self.require_accelerator("kvm")
> +        self.require_netdev("vhost-user")
> +        self.require_netdev("socket")
> +        self.require_netdev("hubport")
> +        self.require_netdev("user")
> +        self.require_device("virtio-net-pci")
> +        self.set_machine("q35")
> +        self.vm.set_console()
> +        self.vm.add_args(
> +            "-cpu",      "host",
> +            "-accel",    "kvm",
> +            "-kernel",   kernel_path,
> +            "-append",   "console=ttyS0",
> +            "-smp",      "2",
> +            "-m",        "128M",
> +            "-object",   "memory-backend-memfd,id=mem0,"
> +                         "size=128M,share=on,prealloc=on",
> +            "-numa",     "node,memdev=mem0",
> +            "-chardev", f"socket,id=char0,path={ud_socket_path}",
> +            "-netdev",   "vhost-user,id=vhost0,chardev=char0,vhostforce=on",
> +            "-device",   "virtio-net-pci,netdev=vhost0",
> +            "-netdev",  f"socket,id=udp0,udp=localhost:{lport},"
> +                        f"localaddr=localhost:{rport}",
> +            "-netdev",   "hubport,id=hub0,hubid=0,netdev=udp0",
> +            "-netdev",   "user,id=user0",
> +            "-netdev",   "hubport,id=hub1,hubid=0,netdev=user0"
> +        )
> +
> +    def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rport):
> +        vubr_args = []
> +
> +        if (stdbuf_path := which("stdbuf")) is None:
> +            self.log.info("Could not find stdbuf: vhost-user-bridge "
> +                          "log lines may appear out of order")
> +        else:
> +            vubr_args += [stdbuf_path, "-o0", "-e0"]
> +
> +        vubr_args += [vubr_path, "-u", f"{ud_socket_path}",
> +                      "-l", f"127.0.0.1:{lport}", "-r", f"127.0.0.1:{rport}"]
> +
> +        return vubr_args
> +
> +    def test_vhost_user_bridge(self):
> +        prompt = "~ # "
> +
> +        vubr_path = self.build_file("tests", "vhost-user-bridge")
> +        if is_readable_executable_file(vubr_path) is None:
> +            self.skipTest("Could not find a readable and executable "
> +                          "vhost-user-bridge")
> +
> +        with Ports() as ports:
> +            sock_dir = self.socket_dir()
> +            ud_socket_path = os.path.join(sock_dir.name, "vubr-test.sock")
> +            lport, rport = ports.find_free_ports(2)
> +
> +            self.configure_vm(ud_socket_path, lport, rport)
> +
> +            vubr_log_path = self.log_file("vhost-user-bridge.log")
> +            self.log.info("For the vhost-user-bridge application log,"
> +                         f" see: {vubr_log_path}")
> +
> +            vubr_args = self.assemble_vubr_args(vubr_path, ud_socket_path,
> +                                                lport, rport)
> +
> +            with open(vubr_log_path, "w") as vubr_log, \
> +                 subprocess.Popen(vubr_args, stdin=subprocess.DEVNULL,
> +                                  stdout=vubr_log, stderr=subprocess.STDOUT):
> +                self.vm.launch()
> +
> +                wait_for_console_pattern(self, prompt)
> +                exec_command_and_wait_for_pattern(self, "udhcpc -nt 1", prompt)
> +                exec_command_and_wait_for_pattern(self,
> +                    "wget -qT 2 --spider example.org", prompt)

If you've got python in the guest, you could maybe also do it the other way 
round and host a httpd server in the guest, and download something to the 
host. See check_http_download in tests/functional/qemu_test/linuxkernel.py 
for the helper function. That way you don't depend on any external host.

  Thomas


