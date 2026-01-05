Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E42C2A088
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 10:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vchw5-0004E5-5d; Mon, 05 Jan 2026 05:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vchvu-0004D7-MF
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vchvo-0006mX-DV
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767609321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MAF+l67F+A8nEsR9Tc335Wyu8/4YI20ftJJcehSFJgc=;
 b=KumrNvIhB9hSMSIwJTm1qSNGp0wPbyDmGZIFQRvU3sFJR5UksIcIr0fmoMAOT/fBMTamfE
 y3V/BT742AOduhEAT2FAo1k3Iz2gepAuSCXE+Urk0nF5VDMm3AF9pvSSxziDGqRlbtrTuj
 tNf1T+eQ8Tcx0/O4HjivS41W9PAYhOs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-gfC6UxtzMu6f4yyCG97QGw-1; Mon, 05 Jan 2026 05:35:20 -0500
X-MC-Unique: gfC6UxtzMu6f4yyCG97QGw-1
X-Mimecast-MFC-AGG-ID: gfC6UxtzMu6f4yyCG97QGw_1767609319
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fdc1fff8so6895301f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 02:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767609319; x=1768214119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MAF+l67F+A8nEsR9Tc335Wyu8/4YI20ftJJcehSFJgc=;
 b=Jg0Bt/Akzlj6b3Ahsl9w5G/VmV0LNVb6nRwj6eQfDWc7N6WB2uIymbgMx+CReocLJ4
 sTEKDaSORssTly7jv035IybVAriArzA6Ug/YjHh5R5VxmqQAkF7GWtZpfmj1vurC5l7q
 FZT1vp1gERBNufgf7gCVE6V/pDjnXrAb27yPjKniHqFeDT+AyjOBDsvBijq6y6oWZD9h
 rsCFmjSh8QP5gPBiZkAK1ozt/T0gtyzCgjqvweaoDutBI/U6OP4HN9IhkPTU01ehlpei
 QkO1SO4IubjJp+ZK/2k4MGw+9AVoBTO4RrY+mE5s14KC9UjCjw1KTcf294AflIeRPGL+
 PLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767609319; x=1768214119;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MAF+l67F+A8nEsR9Tc335Wyu8/4YI20ftJJcehSFJgc=;
 b=ek6FBY4AoH1C/1hWIcq4ogeOC01wtyvsaJo4oND09aGdNmKoUETjVUB08Raz5qJo2N
 sJbxN2UP/oP8vRNfgoFT7NdEXHnwNHh2U2738N08/wmMJAK8V5xbY+osXB/QSUDa9ysV
 GO+bQm+L363tIY6NdCBu66NAUmw/W81NQthw2rYhwbwZ9BVpys2oheQ9wpjPdMquDE6B
 HBMk+lYcUB/oH+HqsQhrYowS5ulv4xyvp2N5bTHaaTlw6h5XrhIx0T5427WlUPtviI2l
 BBY3Q0f6e1DlibwyfAsfYrBTKYcsNeQUlvCTgqWH/NfhCL71je2vIcNhx3E8ZEHcGY+g
 Xcmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwMpAoy2PYAXJClrCIyCWoKvIKY9G/+t0RiFVk58Wr8D/xCeVMgURGTN3KhQo8mUSZc9LVVKKZMugk@nongnu.org
X-Gm-Message-State: AOJu0YxQrZu+ZBPBbWiUvTGA2dKOoI5VwUcQyiwvUrjmNyEXdZHeO+kv
 LZZn1n2joNBjQV4c7/TC7XPItiy+LJ/aN9ZHZazYMt6uP1cn3Exuy7PzS8x1NMoQxfMIz/+yDiB
 ybktW1DIoOpmjTP8EiGtPeOe8EZ9zEpD6qWQt+/GVLqUItT8MC/XQckEL
X-Gm-Gg: AY/fxX6ELCZZSLQkaI++FKQLG2rTZIkiFUbRAp/IY/rlmnrxAsQzeACZvWgAlC8n6K+
 0m4cXbjNfulcKKxy91lI6x+BwvtwwEOTmc7rBvBUxk3v/UVR4vd381LSSe7CBcvkwWLGE7ED2dE
 6NinWVT8eY0rx70c3r1dazzsYY4euXQztgvUI31mFWxSRyJqnVH16F4q+B97LLatybfQ+dF/iMG
 nI8czREbHovkYPvsAJSnznHSe4BuFC8QLgAFU5Fh/mh90vc7wBZ/sKAzpmVsXmvs7odJtAuz/Gt
 6mer6G2sdRMh2cy0rouxEWilZuyHIogLMcdRaPOgkZtJtLjutJ15M32Fh+zAXu4msmtGN7a1U+Z
 5vmE2ty7SmTlx2sNZb+h+RRmfUgdFyS0NxsYND8/TjtG0Abxg
X-Received: by 2002:a5d:5885:0:b0:432:8653:6bc8 with SMTP id
 ffacd0b85a97d-43286536ce6mr38252697f8f.29.1767609318727; 
 Mon, 05 Jan 2026 02:35:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3Kv7vACRe3Oew383wm0emsPHt0eQQzOrydvubRLE9CJcaagE1ePF/4IN5vaYxpPFL//ePOw==
X-Received: by 2002:a5d:5885:0:b0:432:8653:6bc8 with SMTP id
 ffacd0b85a97d-43286536ce6mr38252658f8f.29.1767609318220; 
 Mon, 05 Jan 2026 02:35:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43277b82a58sm65886214f8f.6.2026.01.05.02.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 02:35:16 -0800 (PST)
Message-ID: <648af3ee-5a5b-4c50-9135-6eae776d37a8@redhat.com>
Date: Mon, 5 Jan 2026 11:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional/x86_64: Add vhost-user-bridge test
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>
References: <20251230002604.113632-1-yodel.eldar@yodel.dev>
Content-Language: en-US, fr
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251230002604.113632-1-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

+ Marc-André

(I don't know who maintains this test)

Thanks,

C.


On 12/30/25 01:25, Yodel Eldar wrote:
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
> +
> +                try:
> +                    exec_command_and_wait_for_pattern(self, "echo $?", "0", "1")
> +                except AssertionError:
> +                    self.log.error("Unable to confirm internet connectivity")
> +                    raise
> +                finally:
> +                    self.vm.shutdown()
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()


