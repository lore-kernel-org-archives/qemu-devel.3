Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556EEC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 02:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK6Ij-00080d-CT; Tue, 27 May 2025 22:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uK6Ih-00080V-8J
 for qemu-devel@nongnu.org; Tue, 27 May 2025 22:13:51 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uK6Id-0005Zs-I5
 for qemu-devel@nongnu.org; Tue, 27 May 2025 22:13:50 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-52e728960c3so1535868e0c.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 19:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748398425; x=1749003225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z5Oxj3vlg74NXclXNNPUdD/eVWdV1JzWwV2IMntEOZo=;
 b=xg7/wsG64n1jp8Hk66T2wcRj5DpRHmDHIXu3gdTNXnVHU1lrbZclo6aTfDqu5OEU5m
 ENWdix19mcq+QU7wOkKpRs+p/1wBf7DDbk+KO87KGauPWnwJWNzEhpD67gonFKTuBVVO
 TPC5bAge6RyouKX7HZKWWukPpA2QBku5hVjlWd34ZTsJE7VLb9E4xVpcaBUNOCCVjERb
 f/sLwOamZtYItobBx57Yjt+iqumVL51gqRisRjKvVXTG7VQlGMUH+8NVu/65W9Wdhb4X
 NiUoj7XpskCec/lZnvFvZF5zReUTCQ89ypVYzKOfeZCqbMhz1Lxmude3Zb+zCRNp5wdG
 CxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748398425; x=1749003225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z5Oxj3vlg74NXclXNNPUdD/eVWdV1JzWwV2IMntEOZo=;
 b=R3MzLhVdVHbhOtRNo/xOnDsdFiBMuVJ8w5TTjG2dIqwAjOe3jSvD/JU5BtIYwe3cgQ
 XesqwdB6z3XpCibiUoU2xfIPm1RoR/Pmpol6u2XiMjFQ00W8ys52qjcGNEiI0nJ7VJsX
 FlxPVsX+WTfCn5q3xWxwH5+mRK0QdIcvB96J9MiRm47tuGPpEYyrpDRxe5sZ1qNAkggN
 RMwpQAscTq0jwuc/OrUcw1SWilnxWSiPigIjA2AW0jPMNLqpTW6TtHAyOGg1j7FeVlR7
 eceRS2x2YBQIfTQjTWlV5JX1qqPLMkbBDzWZp8w3C0gjfsfyuFJNKPrdLe99qSNYpLpO
 RnDA==
X-Gm-Message-State: AOJu0YxAto48/Mby0Z9A8v1np98owBVieNmo+cipAm159LkceD5RvD8x
 65TkdKeEOOQgJ9C+ojrS4DnAKcZ4O2Llh/G9gDroLhF670BjFShkO0iy/3bM7Jkj+H5y6LjcPTZ
 YYdLG
X-Gm-Gg: ASbGncsTzoSMgb1Iiib71uC+0/6O3wjTjQ7f4WIbPJDnNj5kAb2bLEWj7Vvc4creIG7
 9STQck+Eyk51R5Vob68/D+tyVRBtJrh/eTJOunRZ1hFvLC+LwrNKY7POETxpyXixEP09iRxGQ1V
 /mJ8Bt/GRNJFWE8zUOLMfz3obQyhKgHOGAETCl/+Qel4NNJk30WUY4LzLnbysnQ3k4ZjJAzqqZP
 6ui7GHvEP2AkgxDiBFHvianzY1XfaXq2skuVY84XZL1XWv5EvNhu5hHqyqr220IyHO0cm67Xj9V
 JrwL7veXQNLKWjIRsgFVLQS4DuPo9z8FFa6CoG62cn+b7ROsYGnAvrqHeHQdlLCZtnZG3+5LI1J
 +6c6Vbpbi84glGwkZbhZ5V0z7XsEGrU1b4wSW5ott
X-Google-Smtp-Source: AGHT+IEXHC8zBStbvtUE7ChtTV9sGiqjBzk5X3C7KCIDaeDqq9XlWqKgGunnJkKSnBBmGl8puAhspg==
X-Received: by 2002:a05:6122:1d9e:b0:52a:79fd:d05e with SMTP id
 71dfb90a1353d-52f2c4a8cd0mr13166552e0c.2.1748398425584; 
 Tue, 27 May 2025 19:13:45 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:2066:dacd:9134:8586?
 ([2804:7f0:b402:6ba2:2066:dacd:9134:8586])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53066944109sm177520e0c.32.2025.05.27.19.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 19:13:45 -0700 (PDT)
Message-ID: <67a82638-b4b7-43e3-8108-42f1a18a0162@linaro.org>
Date: Tue, 27 May 2025 23:13:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional/test_aarch64_hotplug_pci: Add test
 for ACPI PCI hotplug
To: qemu-devel@nongnu.org, eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org
References: <20250527150229.1617074-1-gustavo.romero@linaro.org>
 <20250527150229.1617074-3-gustavo.romero@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250527150229.1617074-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/27/25 12:02, Gustavo Romero wrote:
> Currently, test_aarch64_hotplug_pci only tests PCI hotplug using the
> native PCI hotplug mechanism. Now that aarch64 supports PCI hotplug via
> the ACPI mechanism it's time to support it in the test as well.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/functional/test_aarch64_hotplug_pci.py | 24 +++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
> index bb2c121503..862bb6746b 100755
> --- a/tests/functional/test_aarch64_hotplug_pci.py
> +++ b/tests/functional/test_aarch64_hotplug_pci.py
> @@ -27,11 +27,26 @@ class HotplugPCI(LinuxKernelTest):
>            'current/images/netboot/debian-installer/arm64/initrd.gz'),
>           '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
>   
> -    def test_hotplug_pci(self):
> +    def run_vm_and_test_hotplug_pci(self, use_acpi_pci_hotplug=False):
> +        """
> +        Run an aarch64 VM and test the PCI hotplug mechanism by plugging and
> +        unplugging a PCI network adapter to the VM. Proper plug and unplug of
> +        the adapter is verified by checking if the network device is correctly
> +        added and removed in Linux.
> +
> +        Parameters
> +        ----------
> +        use_acpi_pci_hotplug : bool
> +            If true the ACPI PCI hotplug mechanim is used, otherwise the
> +            Native PCIe Hotplug mechanism is used.
> +        """
> +
> +        acpi_pci_hotplug = "on" if use_acpi_pci_hotplug else "off"
>   
>           self.set_machine('virt')
>           self.vm.add_args('-m', '512M')
>           self.vm.add_args('-cpu', 'cortex-a57')
> +        self.vm.add_args('-machine', f"acpi-pcihp={acpi_pci_hotplug}")
>           self.vm.add_args('-append',
>                            'console=ttyAMA0,115200 init=/bin/sh')
>           self.vm.add_args('-device',
> @@ -70,5 +85,12 @@ def test_hotplug_pci(self):
>                                             'ls -l /sys/class/net | wc -l',
>                                             '2')
>   
> +    def test_native_pci_hotplug(self):
> +        self.run_vm_and_test_hotplug_pci(use_acpi_pci_hotplug=False)
> +
> +    def test_acpi_pci_hotplug(self):
> +        self.run_vm_and_test_hotplug_pci(use_acpi_pci_hotplug=True)
> +
> +
>   if __name__ == '__main__':
>       LinuxKernelTest.main()

Re-posted here as a single patch:

https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg06332.html

I missed the Based-on: 20250527074224.1197793-1-eric.auger@redhat.com tag :-/


Cheers,
Gustavo

