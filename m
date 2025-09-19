Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40670CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWvB-000836-Eu; Fri, 19 Sep 2025 04:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzWv3-0007xH-QM
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzWv1-00018N-1f
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758272197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DUIlpLrP8KtniGAQuaphcCyVXwcfPTJrbF1jvotASKs=;
 b=TBSO0d6Szsts5ySJkNahTvtixq+kDYmH/Cw8JKK9+z+r+VdkBGQSB2fJtqA8um6GrOSLkC
 EUuOfq/p94GfHldHyrRHRyroX2uw703m3FfOYmafqEC0W59HvLeV0SrknhhQ99ulinvq59
 6vBxUEsRR6fJcnibwv6q38f7EfltZjU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-HDr7Uqj4NSaqTg0WL-vq1g-1; Fri, 19 Sep 2025 04:56:34 -0400
X-MC-Unique: HDr7Uqj4NSaqTg0WL-vq1g-1
X-Mimecast-MFC-AGG-ID: HDr7Uqj4NSaqTg0WL-vq1g_1758272193
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45f2b0eba08so11401215e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 01:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758272193; x=1758876993;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DUIlpLrP8KtniGAQuaphcCyVXwcfPTJrbF1jvotASKs=;
 b=cRRybCYNvP7KHsnvUoImQnIhmlFqLxbEQi+wgPMTrBr/0SVT2QsEX0W40syG4G3FQI
 vtiRmA6oW4+AbFdyO+cqIDEtq4upAkCEgZZc6df5Oxx6kf2OjXp1dcW6UYOdrj+32wkx
 UflvWwOASBmFxUH+J+gH+vMC/QEkCKuimB7DE6XcuTD9Y+3akYi+8w2FSVi5F7vVsWmZ
 jSMpbknEetdnsKCd6/6Zxj7ldTOSGKD1ZoHdxwUGQcwfw/S0vKF++1+KfoKlqz37rMn4
 EA32A/Fxbto7yNQx3aYyUXbHvlW4UiFakS/BCD+YLq3PPTqt4y6s2/YvrPZ06whfNkOJ
 rRIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl3Zh7MoCLjbB3bwzSXdpSGsQPhoTkkcMvy8p8OqJkKk1WsdJ15FACorPTShipPgAB/zlLqQnBlm/c@nongnu.org
X-Gm-Message-State: AOJu0Yw7mUpQKjcts07Ueo0S/i70xv/Qc+ImWvcNfFr+9bpDx86VGVxm
 2SyxZxlmDc+G3ID/XaptvJUxK9auoeLZRCM7PrmTTs/NyaLJKVIIauIsMC5+TV2nXQyc/+Kuxun
 Jy7Ndu9NfeUBDR/1tVJ3xfTJbo8QSmQQNuaY/784YNonhad93IhAMrHWo
X-Gm-Gg: ASbGnct5RN8zykIWyWXAx159iQKX2HEE8aaE+M/Q4iYycSX4E0zPCVpF5J0NNHYj6Sd
 ypLAMDuoL9rvtnkVv9s4lIRn9z8aa0NIoG8I6wTjHAWqwzMwMlIFMKH2cYVy/sVSd1ciawtlEHZ
 6IoRDwrjG6tlj108XkBYdOk9SkSVNf2KRCn0fqpOrypvS4TEOUDf90Mk1EoT9hu78p+0yDlqbxI
 HaMbrHfCBDketDLGAmE2FfRdsHZlzNpYRCqkhU+RXTvVpUaPMm5gVAmJxT57fqWR4MF4A6LISHD
 B7jVVmRFJosAIg+pK/Ym33bf4MPtTAH+wQUPrp1WU/dPG1zxP5XZF8EZKuhxerspVAnZ7Aj642p
 yDic=
X-Received: by 2002:a05:600c:c48e:b0:45d:f88f:9304 with SMTP id
 5b1f17b1804b1-467ebbbfff4mr23265565e9.30.1758272193244; 
 Fri, 19 Sep 2025 01:56:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD9VBMowZN7Z0Ku5HXJ1EqA2KkTVbwKtbLX0BMh+nhXiopWv1Gs/INnYYwt4AKywyXqxuhGg==
X-Received: by 2002:a05:600c:c48e:b0:45d:f88f:9304 with SMTP id
 5b1f17b1804b1-467ebbbfff4mr23265165e9.30.1758272192706; 
 Fri, 19 Sep 2025 01:56:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f527d6cdsm87446965e9.12.2025.09.19.01.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 01:56:32 -0700 (PDT)
Message-ID: <6d96d3c8-07de-4bc8-a173-dee5784da075@redhat.com>
Date: Fri, 19 Sep 2025 10:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v4 14/14] tests/functional/aarch64/aspeed_ast2700:
 Add PCIe and network tests
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com, wuhaotsh@google.com,
 titusr@google.com
References: <20250919032431.3316764-1-jamin_lin@aspeedtech.com>
 <20250919032431.3316764-15-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250919032431.3316764-15-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/19/25 05:24, Jamin Lin wrote:
> Extend the AST2700 and AST2700fc functional tests with PCIe and network
> checks.
> 
> This patch introduces a helper "do_ast2700_pcie_test()" that runs "lspci"
> on the emulated system and verifies the expected PCIe devices:
> 
> - 0002:00:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
> - 0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> 
> Additional changes:
> - Add `-device e1000e,netdev=net1,bus=pcie.2 -netdev user,id=net1` to the
>    AST2700 and AST2700fc test machines.
> - In the AST2700 vbootrom test, assign an IP address to the e1000e
>    interface and verify it using `ip addr`.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   .../functional/aarch64/test_aspeed_ast2700.py | 21 +++++++++++++++++++
>   .../aarch64/test_aspeed_ast2700fc.py          | 13 ++++++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
> index a3db267294..0973fce0e9 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700.py
> @@ -69,6 +69,16 @@ def do_ast2700_i2c_test(self):
>           exec_command_and_wait_for_pattern(self,
>               'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
>   
> +    def do_ast2700_pcie_test(self):
> +        exec_command_and_wait_for_pattern(self,
> +            'lspci -s 0002:00:00.0',
> +            '0002:00:00.0 PCI bridge: '
> +            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
> +        exec_command_and_wait_for_pattern(self,
> +            'lspci -s 0002:01:00.0',
> +            '0002:01:00.0 Ethernet controller: '
> +            'Intel Corporation 82574L Gigabit Network Connection')
> +
>       def start_ast2700_test(self, name):
>           num_cpu = 4
>           uboot_size = os.path.getsize(self.scratch_file(name,
> @@ -125,20 +135,31 @@ def test_aarch64_ast2700a0_evb_sdk_v09_06(self):
>   
>       def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
>           self.set_machine('ast2700a1-evb')
> +        self.require_netdev('user')
>   
>           self.archive_extract(self.ASSET_SDK_V906_AST2700A1)
> +        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
> +        self.vm.add_args('-netdev', 'user,id=net1')
>           self.start_ast2700_test('ast2700-default')
>           self.verify_openbmc_boot_and_login('ast2700-default')
>           self.do_ast2700_i2c_test()
> +        self.do_ast2700_pcie_test()
>   
>       def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_07(self):
>           self.set_machine('ast2700a1-evb')
> +        self.require_netdev('user')
>   
>           self.archive_extract(self.ASSET_SDK_V907_AST2700A1_VBOOROM)
> +        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
> +        self.vm.add_args('-netdev', 'user,id=net1')
>           self.start_ast2700_test_vbootrom('ast2700-default')
>           self.verify_vbootrom_firmware_flow()
>           self.verify_openbmc_boot_and_login('ast2700-default')
>           self.do_ast2700_i2c_test()
> +        self.do_ast2700_pcie_test()
> +        exec_command_and_wait_for_pattern(self,
> +            'ip addr show dev eth2',
> +            'inet 10.0.2.15/24')
>   
>   if __name__ == '__main__':
>       QemuSystemTest.main()
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> index b85370e182..28b66614d9 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> @@ -20,6 +20,8 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
>           self.vm.set_console()
>           self.vm.add_args('-device',
>                            'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
> +        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
> +        self.vm.add_args('-netdev', 'user,id=net1')
>           self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
>                            '-net', 'nic', '-net', 'user', '-snapshot')
>   
> @@ -49,6 +51,16 @@ def do_ast2700_i2c_test(self):
>           exec_command_and_wait_for_pattern(self,
>               'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
>   
> +    def do_ast2700_pcie_test(self):
> +        exec_command_and_wait_for_pattern(self,
> +            'lspci -s 0002:00:00.0',
> +            '0002:00:00.0 PCI bridge: '
> +            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
> +        exec_command_and_wait_for_pattern(self,
> +            'lspci -s 0002:01:00.0',
> +            '0002:01:00.0 Ethernet controller: '
> +            'Intel Corporation 82574L Gigabit Network Connection')
> +
>       def do_ast2700fc_ssp_test(self):
>           self.vm.shutdown()
>           self.vm.set_console(console_index=1)
> @@ -128,6 +140,7 @@ def test_aarch64_ast2700fc_sdk_v09_06(self):
>           self.start_ast2700fc_test('ast2700-default')
>           self.verify_openbmc_boot_and_login('ast2700-default')
>           self.do_ast2700_i2c_test()
> +        self.do_ast2700_pcie_test()
>           self.do_ast2700fc_ssp_test()
>           self.do_ast2700fc_tsp_test()
>   


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




