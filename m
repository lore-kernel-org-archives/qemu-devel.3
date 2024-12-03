Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98EDE6C61A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPAk-0002of-3D; Tue, 03 Dec 2024 04:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIPAg-0002oL-Jv
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:26:19 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIPAd-00038n-HI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:26:17 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ffc3f2b3a9so69014641fa.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733217974; x=1733822774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ATnngnHL+pjcktSWXsx3tHUsPKr2Q+ZxPE8g/lZk+Y8=;
 b=EmKwVzFAoYIe6fuwOuZm+0JH9J1LSCZLalnq3WqgFeR5grL0ZONTpc8a9U2ke+woHQ
 Ue22XF7P8mI+v0WLodD9djZBb3b/EQdggppYkaU76Amgi8bxmsfzv2ukji6fsCKXbtoY
 AMi3MPVt+qbD47E6eG0Tk+Qm/EpwF52WLxK+IAILWoJ+pZWkY7B4lWFRoA4lHxqHSq7L
 rrscrM5TW4vAhZ2ge4n1ZDuHMp8Q2jikbU+RPFRZqAYKqO4U3RQp/H+jjA/3Pw3SwJ/J
 U5uHRCa1pGsOaF66EHCtsJH3hDUMO0h2LQYBkuo8VQpXSlVJqEwQwoJs1Mjign/XZasJ
 YkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733217974; x=1733822774;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ATnngnHL+pjcktSWXsx3tHUsPKr2Q+ZxPE8g/lZk+Y8=;
 b=OOzvtrdtWtRodGSIEGDrloGRmZsUTO6peqeZf1+6qjz391yy/9rdaBM3J3s47a2rvT
 pUrqvWIdTpDL3c+OGLi7cWeenasNup4ElknnnXlioKrI/4MpJ434Tt7CTs111CUx4Ibr
 SSehhhtOwzVCaroQ6H7vShEOyaaNWr3JLx7AzCusze/sGtZcfDM2l+XQ3bylLHW5oKjx
 FY3zba/S2P1v098fWn7pbyUy5m6nv3Ubg/0msWUJFb+CpUVLI5D4M6LUrWwTYmNryO/B
 lyyynM9Ni63th+WevC4ngDZC5xAC4WN26nWiWntErLyVjkrfvsN9+nMP3RxNNTAIIOmX
 ZJpQ==
X-Gm-Message-State: AOJu0YzThLWyddEoSn1Aw55Mh2bYL2FkcdI7lOT1WYxKYCEhGdYPfIkN
 6si/fU/Zw/U9Xy0H6cKX8jAsAoF5GZ2edJW25a2Kjm1gZX2JDJKr3fy0rMokNyI=
X-Gm-Gg: ASbGncvXLSwwwqOlR2+Zpey0vmWOhzn4xPcVaSwl+3+uBLL6qF9c37U7wabGsmSz3Tk
 cIosLTwCHR+F48gzKDztGAFqByvD/PMeFP8NS9pauX2aaCCPYVjSJBk5p292UdGjRTXo2oMxLfj
 3MZKmkAgH3RaGFKm4PXfeGZ820fL/spL5zY4hEFclp9x+Rdd5X2DCb1fkmPOvXXaY4r/hYCBwcA
 C5+vRoUVYPhqqiv5HNQcEPUJv9k4wVsWZEfg5/CIcBl5QoJaHV9QQPX2OqGct3f6Q==
X-Google-Smtp-Source: AGHT+IHF6XcXOL31jJQExL0nqeA1QXifJMGLaNWFWDHj98ouCSF5sTvVlteeQdASy+guQC6Izn5mOw==
X-Received: by 2002:a05:651c:546:b0:2ff:d36a:2b31 with SMTP id
 38308e7fff4ca-30009c4649cmr15071481fa.6.1733217973612; 
 Tue, 03 Dec 2024 01:26:13 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5996c1408sm588558166b.15.2024.12.03.01.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 01:26:13 -0800 (PST)
Message-ID: <884bb70b-bb7a-4676-ab74-fd19a2758955@linaro.org>
Date: Tue, 3 Dec 2024 10:26:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2? v2 1/2] tests/functional/test_version: Use QTest
 accelerator
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20241203091036.59898-1-philmd@linaro.org>
 <20241203091036.59898-2-philmd@linaro.org> <Z07M4jpxZo9Ns0Rj@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z07M4jpxZo9Ns0Rj@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/12/24 10:18, Daniel P. Berrangé wrote:
> On Tue, Dec 03, 2024 at 10:10:35AM +0100, Philippe Mathieu-Daudé wrote:
>> When testing with a HVF-only binary, we get:
>>
>>     3/12 qemu:func-quick+func-aarch64 / func-aarch64-version                                      ERROR            0.29s   exit status 1
>>    stderr:
>>    Traceback (most recent call last):
>>      File "tests/functional/test_version.py", line 22, in test_qmp_human_info_version
>>        self.vm.launch()
>>      File "machine/machine.py", line 461, in launch
>>        raise VMLaunchFailure(
>>    qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish session: EOFError
>>        Exit code: 1
>>        Command: build/qemu-system-aarch64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine none -nodefaults
>>        Output: qemu-system-aarch64: No accelerator selected and no default accelerator available
>>
>> Explicit the QTest accelerator to be able to run the HMP command.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/functional/test_version.py | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/functional/test_version.py b/tests/functional/test_version.py
>> index 3ab3b67f7e3..d3da796991f 100755
>> --- a/tests/functional/test_version.py
>> +++ b/tests/functional/test_version.py
>> @@ -18,6 +18,7 @@ class Version(QemuSystemTest):
>>   
>>       def test_qmp_human_info_version(self):
>>           self.set_machine('none')
>> +        self.vm.add_args('-accel', 'qtest')
> 
> IMHO this is wrong. The functional tests are there to test the
> real functional behaviour under an actual accelerator not qtest.

It works using '-accel hvf'. The issue is:

   "No accelerator selected and no default accelerator available"

So we should select HVF over QTest by default? I tend to not
enforce any default because we always get troubles with them,
what is today's default is unlikely tomorrow's one.

> We have tests/qtests for testing scenarios where we want to only
> exercise with the qtest accelerator.
> 
> If QEMU is built with /only/ HVF available and HVF can't be
> used at runtime, then we should be skipping all functional
> tests, not degrading them to be hardcoded to use qtest on
> all platforms.
> 
>>           self.vm.add_args('-nodefaults')
>>           self.vm.launch()
>>           res = self.vm.cmd('human-monitor-command',
> 
> With regards,
> Daniel


