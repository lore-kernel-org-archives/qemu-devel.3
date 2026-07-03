Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0396C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfa1P-00075v-KT; Fri, 03 Jul 2026 05:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wfa1N-00075L-0u
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wfa1J-0003vs-Dn
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783070231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mYhDmxK9okrCb0d1k9tDrXSHmkuQ/QBsjspnrCeC7iQ=;
 b=PKTwmAdbzpxVZ3hBqR3lZaGxKYijaFF+S2C1S3p2lQGGI0Zl7fW/rdbz0ZetkOoHTBU0b7
 olY5C6sLGZdfcg2JkKjXs0ImkTgpzJzHl801FNJeTs2f8CE37yOPDJ6B593SMPcegtS4qR
 Xb59rmIMmqfCWsxkPLZ+WSLpmyvsSuc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-i2MCmsoSMoeLwQcSIfk5NQ-1; Fri, 03 Jul 2026 05:17:10 -0400
X-MC-Unique: i2MCmsoSMoeLwQcSIfk5NQ-1
X-Mimecast-MFC-AGG-ID: i2MCmsoSMoeLwQcSIfk5NQ_1783070229
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47162f83c75so1059971f8f.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783070229; x=1783675029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mYhDmxK9okrCb0d1k9tDrXSHmkuQ/QBsjspnrCeC7iQ=;
 b=ElnNVfJeKN02z/Q1zxh6KgFzht4I6FDoSeiLKZrH2QuL0u7Kxankkg/QL3N0CyK88+
 7klPukK+SnrhpMDFCZVzd1YHcA8o/qzKdA8/LnhSDEpTjH6eAZW+VFkpTqVimawTSwA3
 A+Fp+7og9M/+YjTaJY/4xnGjJyM39QVaTxqqMiKhjlghzHRij2qfe821IDNRVpMdDsXj
 57CBgvresHl3q4Tpb7rkZpF9k4WSirgDMQZmb6rbD0fb1i7cDhB89t1ANudXKreDhPBY
 T4sLxreAlwy/ux2yVZedje7RB59fj2v+Ej8ZOfB+GM/BZxBwkRn05yntvHEfoO9O0IV6
 /bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783070229; x=1783675029;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYhDmxK9okrCb0d1k9tDrXSHmkuQ/QBsjspnrCeC7iQ=;
 b=gStUrBxJ8jVvI1WpZhke1gB1X+2cWRLG7oSfRlIpjmAi22CAp1v8P+A9TS+96leO9h
 CbCnmVL8solRn5bQid+/tQyO4gyHn+eOAgV02FhhhoDG7u0Kz2wKmbvPYCcEToq8HC53
 cQO6ew5I9ws7iksz8M9SnD+VtbVSIdtVmqnca6HxcdGDmFdLqMeiiKTKGRUoOCqoCz3o
 UQhJdEAXlpoEAfd6yHG2/74lyx34xIkePo235hX8z1oM+iBmpw6KYn10jFuuXj0ImET+
 wT3SexsSbscgt10vsoHmcpGHsJ91OicIdjqZIkyJv7WAZFpKJpJrrNydedQPteIn2tr+
 snNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9auKP/caDMPHMCZtRQLTbngMXhBuOIaDWdz/PGiHLoGvnWpUNkfUQXXPTYSKe6lh7WcZ1WgPO2Z4ft@nongnu.org
X-Gm-Message-State: AOJu0YyOYl54XoyQ0IYw6EZeexe4ALDRVROrofOaUXEyfYnqu4Q9v8/O
 EhY2REKbmXjjKxNMLdX9Y4eVhv4LeCNPqYGQcyXpL7JmvB2ZiryMeYWp1w4HZUQz3QBlxihpXkK
 PVNRfs9mCmkq8M6hwHTrrcTKR5djJwO7BXcAbEkVf9GLgJdPiSMXUKMvH
X-Gm-Gg: AfdE7ckexDg9OyN15V/QExnmSSLSd3PhhA81WsNNT/PWMcwxHQFj8qdXZzvmoQpO3Qc
 HGwfLd4ZMlvIOZT9ccPSU1iHDLKH21d7VW239ejDw1L7pRBBsZ73sjI3rjYF2w4kzXy4+LpSsMp
 kSWthpep70B2wplINZixVSRK9LLO3dlwDwLlBX+yNbnu4lQNPLEFO/WlAUa3fkc3i7gABzyLCA9
 LyDh51j8hF4b14cVLGJqpFuICDo9OsybNlpjvwvMFrAcIi9U+ws64dBf85I8AcHKaiaevnwkUJL
 g/mamkqn98a7bYoioCP2+0/HoE4D/yG/K8xgPax4VeqIC6TMZ3GgEv3WJaJweWcfNIK9FhPZE7E
 BwpCAX3cBYNo344v6SaCGv/2A08j7XNL8PYXXTUW8SZfwsAjXbA==
X-Received: by 2002:a05:600c:3e19:b0:493:c566:7bd6 with SMTP id
 5b1f17b1804b1-493c9b6cdbdmr42330245e9.18.1783070229118; 
 Fri, 03 Jul 2026 02:17:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3e19:b0:493:c566:7bd6 with SMTP id
 5b1f17b1804b1-493c9b6cdbdmr42329885e9.18.1783070228585; 
 Fri, 03 Jul 2026 02:17:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab3a8sm37648415e9.6.2026.07.03.02.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 02:17:08 -0700 (PDT)
Message-ID: <b1d16c72-3485-4cad-ae51-5db4a78e3a48@redhat.com>
Date: Fri, 3 Jul 2026 11:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 1/8] tests/functional: Add remote interrupts
 test for PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>
References: <20260703085955.2318600-1-adityag@linux.ibm.com>
 <20260703085955.2318600-2-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260703085955.2318600-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/3/26 10:59, Aditya Gupta wrote:
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
> Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> Reviewed-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   tests/functional/ppc64/test_powernv.py | 95 ++++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
> 
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index b5b2f0d15857..bac2017e18df 100755
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
> @@ -32,6 +33,17 @@ class PowernvMachine(LinuxKernelTest):
>           ('https://github.com/roz3x/qemu/raw/refs/heads/sample-dtb/qemu-powernv11.dtb'),
>           'ea1271516264eea1eb58a067a99d0c2ca9528be8dc7d4e46bb2d5ae0d42fc568')
>   
> +    def shell_exec_command_check_fail(self, command):
> +        fail_msg="Fail"
> +        self.shell_exec_command(f"export __FAIL_MSG={fail_msg}")
> +
> +        # If the exit code for the command is non 0, print fail message
> +        command = command + " || echo $__FAIL_MSG"
> +        exec_command_and_wait_for_pattern(self, command, '#', fail_msg)
> +
> +    def shell_exec_command(self, command):
> +        exec_command_and_wait_for_pattern(self, command, '#', self.panic_message)
> +
>       def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
>           self.require_accelerator("tcg")
>           kernel_path = self.ASSET_KERNEL.fetch()
> @@ -76,6 +88,89 @@ def test_linux_smt_boot(self):
>           wait_for_console_pattern(self, console_pattern, self.panic_message)
>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>   
> +    def test_linux_remote_interrupts(self):
> +        self.require_accelerator("tcg")
> +        self.set_machine('powernv')
> +
> +        # Have below setup in this test:
> +        # 1. e1000e attached to pcie.6, which is from 7th PHB, belonging to 2nd
> +        #    socket (chip 1), in a powernv boot with default 6 PHBs per socket
> +        # 2. CPU on 2nd socket (chip 1) disabled
> +        # 3. RX IRQ's affinity to chip 2, and TX IRQ's affinity to chip 3
> +        #
> +        # Then ping is done, to generate interrupts from e1000e which should go
> +        # to IRQ server on the remote sockets
> +        self.vm.add_args('-smp', '4,sockets=4,cores=1,threads=1')
> +        self.vm.add_args('-netdev', 'user,id=net0')
> +        self.vm.add_args('-device', 'e1000e,netdev=net0,bus=pcie.6')


2 sockets are enough.

     # grep -E  "eth0|nvme" /proc/interrupts
      76:         12          0  PNV-PCI-MSI 268959744 Edge      nvme0q0
      77:         62          0  PNV-PCI-MSI 268959745 Edge      nvme0q1
      78:          0         67  PNV-PCI-MSI 268959746 Edge      nvme0q2
      79:          0         34  PNV-PCI-MSI 2416443392 Edge      eth0-rx-0
      80:          0         20  PNV-PCI-MSI 2416443393 Edge      eth0-tx-0
      81:          0          4  PNV-PCI-MSI 2416443394 Edge      eth0
     # echo 0 > /sys/devices/system/cpu/cpu1/online
     # grep -E  "eth0|nvme" /proc/interrupts
      76:         12  PNV-PCI-MSI 268959744 Edge      nvme0q0
      77:         62  PNV-PCI-MSI 268959745 Edge      nvme0q1
      78:          0  PNV-PCI-MSI 268959746 Edge      nvme0q2
      79:         10  PNV-PCI-MSI 2416443392 Edge      eth0-rx-0
      80:          0  PNV-PCI-MSI 2416443393 Edge      eth0-tx-0
      81:          0  PNV-PCI-MSI 2416443394 Edge      eth0

A non-zero count on eth0-rx is good enough.

     # ping -W2 -c5 10.0.2.2
     PING 10.0.2.2 (10.0.2.2): 56 data bytes
     64 bytes from 10.0.2.2: seq=0 ttl=255 time=7.339 ms
     64 bytes from 10.0.2.2: seq=1 ttl=255 time=0.673 ms
     64 bytes from 10.0.2.2: seq=2 ttl=255 time=0.405 ms
     64 bytes from 10.0.2.2: seq=3 ttl=255 time=0.369 ms
     64 bytes from 10.0.2.2: seq=4 ttl=255 time=0.516 ms
     
     --- 10.0.2.2 ping statistics ---
     5 packets transmitted, 5 packets received, 0% packet loss
     # grep -E  "eth0|nvme" /proc/interrupts
      76:         12  PNV-PCI-MSI 268959744 Edge      nvme0q0
      77:         62  PNV-PCI-MSI 268959745 Edge      nvme0q1
      78:          0  PNV-PCI-MSI 268959746 Edge      nvme0q2
      79:         34  PNV-PCI-MSI 2416443392 Edge      eth0-rx-0
      80:         10  PNV-PCI-MSI 2416443393 Edge      eth0-tx-0
      81:          0  PNV-PCI-MSI 2416443394 Edge      eth0
     
That's even better I agree.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



