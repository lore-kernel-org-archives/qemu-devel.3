Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E58D42B82
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 13:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tArEh-0001vW-2C; Tue, 12 Nov 2024 08:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tArEZ-0001sK-Pt
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:47:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tArEX-0002i1-W5
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731419224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XxdGOCx5Q5siNIPCy4KbuPGY8sno+XfI0MjSb/OmlIg=;
 b=T5rnaWqICO8+tFkTM+kVGgXeQ0SP+gkanKEG4hIqlTSBCrujoP0zWZbY3HABwTbLc5Es3A
 2fYkYL9OmZvtPcVeSKOMgGVtvFmSAXCoCZoLZW2conctAkbSIO505SEhRWjWKRP/aEvtmD
 KpMrcov9xxRNOU/KOVZzGHUWHuxyGUM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-UW6OMjduM6KA2anuMCOLkQ-1; Tue, 12 Nov 2024 08:47:03 -0500
X-MC-Unique: UW6OMjduM6KA2anuMCOLkQ-1
X-Mimecast-MFC-AGG-ID: UW6OMjduM6KA2anuMCOLkQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d462b64e3so2993941f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 05:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419222; x=1732024022;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxdGOCx5Q5siNIPCy4KbuPGY8sno+XfI0MjSb/OmlIg=;
 b=JdN3kAIteMJASKbxzuTg3zJyhMSQXyZ1mEcbn7Nx2RZCo56Bp/JYubcn2WAVLrhoUK
 7pFst3yGE3ABAuQter7BoBGCyCUmgcqdbKAtcyYS3vdtExOGgm1AA1o9R0zCs/OWs6ND
 rBvZX4VdFDXaN8cW4ETyi7KhlfwSE/HDg+nIrfLzxnl1honvpgLl8SXgdXZwQi3oAv7+
 T9mPIe3v26CPQwwPe129bnG7lbNNDh+rQoDqInHVs4/nDLrzTSiRTw6SLIlSju6LsKuQ
 aKYTaplKA67DJHC4kN9+FbW8JzI5llB1M51WCiIlxwBWnI0dpXEfZ9l0PvRLQIVy8GRc
 Isrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1yBsZ6MAm9cwRMGUlU8vSeFsKrsIbjFSGIuQc0QZW5av2PciRhp5LM3ch3WJ34QKqNco8dh3wEYPl@nongnu.org
X-Gm-Message-State: AOJu0YyOirAFd7RiAa66Hd+uJ5I05RUF3gLCqKdQKf404QhauTQt4xoW
 qVe10/APBTHd7ME1S8XSfoqFPIBmSSN4pMm+MSxORF1KtmfLf/NYbxzVpIwGOXZNC9DYTSTkgZ+
 2td5qmh3tFQpkuonYxZAb/ofNe/IDzFmDibZt6trG15aqywIJIrtC
X-Received: by 2002:a05:6000:2a2:b0:37d:5257:41bd with SMTP id
 ffacd0b85a97d-381f1862d93mr13893046f8f.3.1731419222039; 
 Tue, 12 Nov 2024 05:47:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHum53cyi/JccPa7SBTWqWGcydompndFIWwcften4faMuiYCWQSysSxFJDRkYEnJPEASHcEzQ==
X-Received: by 2002:a05:6000:2a2:b0:37d:5257:41bd with SMTP id
 ffacd0b85a97d-381f1862d93mr13893028f8f.3.1731419221661; 
 Tue, 12 Nov 2024 05:47:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05e5f77sm214193195e9.43.2024.11.12.05.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 05:47:01 -0800 (PST)
Message-ID: <095d9acd-80b7-44c3-afdf-6a4a05559bd4@redhat.com>
Date: Tue, 12 Nov 2024 14:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/functional: Remove sleep workarounds from
 Aspeed tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241112130246.970281-1-clg@redhat.com>
 <20241112130246.970281-5-clg@redhat.com>
 <c2fe0e26-9dcf-458c-926a-5be0a2a39181@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <c2fe0e26-9dcf-458c-926a-5be0a2a39181@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/12/24 14:36, Thomas Huth wrote:
> On 12/11/2024 14.02, Cédric Le Goater wrote:
>> These were introduced in the avocado tests to workaround read issues
>> when interacting with console. They are no longer necessary and we can
>> use the expected  "login:" string now.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/functional/test_arm_aspeed.py | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
>> index 7644ecbae750..2c9009f686fd 100755
>> --- a/tests/functional/test_arm_aspeed.py
>> +++ b/tests/functional/test_arm_aspeed.py
>> @@ -136,10 +136,8 @@ def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'
>>           self.wait_for_console_pattern('lease of 10.0.2.15')
>>           # the line before login:
>>           self.wait_for_console_pattern(pattern)
>> -        time.sleep(0.1)
>> -        exec_command(self, 'root')
>> -        time.sleep(0.1)
>> -        exec_command(self, "passw0rd")
>> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
>> +        exec_command_and_wait_for_pattern(self, 'passw0rd', '#')
>>       def do_test_arm_aspeed_buildroot_poweroff(self):
>>           exec_command_and_wait_for_pattern(self, 'poweroff',
>> @@ -158,7 +156,7 @@ def test_arm_ast2500_evb_buildroot(self):
>>           self.vm.add_args('-device',
>>                            'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
>>           self.do_test_arm_aspeed_buildroot_start(image_path, '0x0',
>> -                                                'Aspeed AST2500 EVB')
>> +                                                'ast2500-evb login:')
>>           exec_command_and_wait_for_pattern(self,
>>                'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
>> @@ -188,7 +186,8 @@ def test_arm_ast2600_evb_buildroot(self):
>>                            'ds1338,bus=aspeed.i2c.bus.3,address=0x32');
>>           self.vm.add_args('-device',
>>                            'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42');
>> -        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
>> +        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00',
>> +                                                'ast2600-evb login:')
>>           exec_command_and_wait_for_pattern(self,
>>                'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
>> @@ -210,7 +209,6 @@ def test_arm_ast2600_evb_buildroot(self):
>>                'echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-3/new_device',
>>                'i2c i2c-3: new_device: Instantiated device slave-24c02 at 0x64');
>>           exec_command(self, 'i2cset -y 3 0x42 0x64 0x00 0xaa i');
> 
> Could we please wait for the shell prompt here now? i.e.:
> 
>           exec_command_and_wait_for_pattern(self,
>               'i2cset -y 3 0x42 0x64 0x00 0xaa i', '#')
> 
> or something similar?

Done and that's the last use of exec_command() in this file.

> With such a fix included:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks,

C.


