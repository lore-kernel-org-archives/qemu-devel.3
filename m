Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C026CAC5A7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzW7x-0004yX-3l; Fri, 19 Sep 2025 04:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzW7u-0004wE-PA
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzW7r-0006mf-Du
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758269149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FbSXNfwjeJK59L1O0kxY34YbvRazp9gayZSbxh5qKww=;
 b=TZCVe44yO6i7RlXHO1aR7pfujWJboZ7eZ+xQ7vhU5oVK9FWv2LxHdV/LjdQ2XqfaUZYtSz
 5IrLHM1oCjwJz/Tnn+VDYMsYBx8OK2nK4uJkI0wxJaBQzIcl8A0DB/Hu1cBvm+VSu4am6W
 oFMo4DDy391gbf9PdFzTibiTNcBJmKA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-mtLxqPNoM-6jUtrK-WMOCA-1; Fri, 19 Sep 2025 04:05:47 -0400
X-MC-Unique: mtLxqPNoM-6jUtrK-WMOCA-1
X-Mimecast-MFC-AGG-ID: mtLxqPNoM-6jUtrK-WMOCA_1758269147
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ecdc9dbc5fso1130032f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 01:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758269146; x=1758873946;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FbSXNfwjeJK59L1O0kxY34YbvRazp9gayZSbxh5qKww=;
 b=qVKZQOPucYNqfu+sSOpTSxxyxcAiIYtNrS2F0w2Oc+thSklqIk+MDxJZxmaEmUlwSW
 U2z/buOFum6SM4Ioq5Kp2ePVO7wdxWYo5e2lT86TCrk3Q3tPTm6FXrfyU3dK2jlfp6pu
 GfkAx+j4qbIZadq6S46H2MfKB5q1Gv5HCV6ZzLG04h5SYwE8vSwrH1291BWH6XWgjESy
 Li0KvmWyBtosSVSVtpE4Th6Q6olj3hu3jKqBuv1jwF5ZSAaQHl3sMrdYdB6baywCtUeT
 Ns2QTcoY3NHBBu0NMH9/+z/lAzUTXgaJsbv8RZuiy6iQVYS5oMGKWd6QvxasQ1hyrHAv
 c8vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSlwrdqO1EP9mQHD7awo3AAOHXHUdKFfOkqgAlHkjhbieWVtgwwnF2u7iNIYV87t37QgEc6qGRYBQ5@nongnu.org
X-Gm-Message-State: AOJu0Yw5xaS51lYHcs54VdfAjqHax5S/n/te2Pq+oh7Sd71g4Ldi4LLX
 2DfGkOy39dSFU6z/i+reMKXx1GnKXeZluQ1AAHZGajV7+f8k/lZQ35PPwRyfOTuia083IZIMYwB
 mz6rVNlRGXnGMFKwHIfN6LkakowROfCLrsy+48KIADAS+UZDEohi5lwRz
X-Gm-Gg: ASbGncujn13bDWoD/jhLz9mWZ5jIEeWXB0spQdHWGZ4U29DP13nDeUxiAHFMECJd65I
 pnuioslhBYvPTpCy16MoI2bjBP76yCARRRvEGpeDpbAq9ropVpqQ5+6qUabVoFaqDquhzToVBq8
 P5flC7deZhb2P4svnymLjPhPVB3GdpcoGgwhiTx8jXDerfTTbB9zk6df/S/Qf4khkgp1ixEH3YW
 bdF7NN3Fj/0tW9NcWZgB1jEPboEDeHegcPrXfvr28kIz5rMLui5CX6l12XlZWMByHXwjhKir3GH
 qcSk1sQPEE9QF37fIFW+9SKKk7sO81zBji7JBxmndAepdBIA5fbmaVr72Z3AQCds/XbNMDdQNKw
 0ssE=
X-Received: by 2002:a05:6000:1a86:b0:3e8:f67:894a with SMTP id
 ffacd0b85a97d-3ee7c552a12mr1907883f8f.5.1758269146507; 
 Fri, 19 Sep 2025 01:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEabPYeM68K8ROwhOqzy0C4NhV47TDIPpOpIxeDeB5BouB3JP5ahSv08F7e5GxuPwmDD9V7tA==
X-Received: by 2002:a05:6000:1a86:b0:3e8:f67:894a with SMTP id
 ffacd0b85a97d-3ee7c552a12mr1907840f8f.5.1758269145993; 
 Fri, 19 Sep 2025 01:05:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7284sm6790274f8f.33.2025.09.19.01.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 01:05:45 -0700 (PDT)
Message-ID: <c282f3a5-11a6-4890-8d8e-1ce283d12ebd@redhat.com>
Date: Fri, 19 Sep 2025 10:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v4 13/14] tests/functional/arm/test_aspeed_ast2600:
 Add PCIe and network test
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
 <20250919032431.3316764-14-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250919032431.3316764-14-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Extend the AST2600 functional tests with PCIe and network checks.
> 
> This patch introduces a new helper "do_ast2600_pcie_test()" that runs "lspci"
> on the emulated system and verifies the presence of the expected PCIe devices:
> 
> - 80:00.0 Host bridge: ASPEED Technology, Inc. Device 2600
> - 80:08.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
> - 81:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> 
> To exercise the PCIe network device, the test adds:
> 
>    -device e1000e,netdev=net1,bus=pcie.0
>    -netdev user,id=net1
> 
> and assigns an IP address to the interface, verifying it with `ip addr`.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   tests/functional/arm/test_aspeed_ast2600.py | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/tests/functional/arm/test_aspeed_ast2600.py b/tests/functional/arm/test_aspeed_ast2600.py
> index 87e3595584..49ffe89d91 100755
> --- a/tests/functional/arm/test_aspeed_ast2600.py
> +++ b/tests/functional/arm/test_aspeed_ast2600.py
> @@ -101,8 +101,26 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
>           'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2600-default-obmc.tar.gz',
>           'cb6c08595bcbba1672ce716b068ba4e48eda1ed9abe78a07b30392ba2278feba')
>   
> +    def do_ast2600_pcie_test(self):
> +        exec_command_and_wait_for_pattern(self,
> +            'lspci -s 80:00.0',
> +            '80:00.0 Host bridge: '
> +            'ASPEED Technology, Inc. Device 2600')
> +        exec_command_and_wait_for_pattern(self,
> +            'lspci -s 80:08.0',
> +            '80:08.0 PCI bridge: '
> +            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
> +        exec_command_and_wait_for_pattern(self,
> +            'lspci -s 81:00.0',
> +            '81:00.0 Ethernet controller: '
> +            'Intel Corporation 82574L Gigabit Network Connection')
> +        exec_command_and_wait_for_pattern(self,
> +            'ip addr show dev eth4',
> +            'inet 10.0.2.15/24')
> +
>       def test_arm_ast2600_evb_sdk(self):
>           self.set_machine('ast2600-evb')
> +        self.require_netdev('user')
>   
>           self.archive_extract(self.ASSET_SDK_V907_AST2600)
>   
> @@ -110,6 +128,8 @@ def test_arm_ast2600_evb_sdk(self):
>               'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
>           self.vm.add_args('-device',
>               'ds1338,bus=aspeed.i2c.bus.5,address=0x32')
> +        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.0')
> +        self.vm.add_args('-netdev', 'user,id=net1')
>           self.do_test_arm_aspeed_sdk_start(
>               self.scratch_file("ast2600-default", "image-bmc"))
>   
> @@ -135,6 +155,7 @@ def test_arm_ast2600_evb_sdk(self):
>           year = time.strftime("%Y")
>           exec_command_and_wait_for_pattern(self,
>                '/sbin/hwclock -f /dev/rtc1', year)
> +        self.do_ast2600_pcie_test()
>   
>       def test_arm_ast2600_otp_blockdev_device(self):
>           self.vm.set_machine("ast2600-evb")


