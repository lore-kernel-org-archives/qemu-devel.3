Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E56D4979A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPMc-0007cr-Iw; Tue, 03 Dec 2024 04:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIPMW-0007cd-TR
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:38:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIPMV-0004WJ-6h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:38:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43494a20379so43239445e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733218709; x=1733823509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=siw3i9ow94b0W2MqVn8dFFGqHatzh9bg4ipJImako/U=;
 b=f+YgiQsmeodelhiKGhlXGP5vSlSEMf6bbJG8nei0e2KGzSmpQjeZvHtpR5M/IJuJwO
 kqER1kVZfVzRScNyJBl9M48UZBfhOBqPR64j9V6pRmFRFVIzm5j6RzIKrOxWQnn4JjRG
 B7WhrGUXn8z1CS1w9v4MKX3JC8LhHExFsAiImOcX/RE62bN4iMr3iIv31fXmmUwa0Eqk
 pTXmgBVnuBEKKCt2GqIzBtiW0b6oKnqGzV2zNiEHy1kydGu50XXSvk09J8UCTwITjkWl
 cxPKiOy+kKHeUQWl8wn9RUuNATEDzG55FrkOxuVUN+BFmTf9XMuqvV7Vi53mWg2OeZOi
 RTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733218709; x=1733823509;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=siw3i9ow94b0W2MqVn8dFFGqHatzh9bg4ipJImako/U=;
 b=doNfEnlQlJWUkRAQdHYLn873aiF0ye61n1/yoSDGRM3Awym7ZBuVbkYYE089JjuFzx
 X/fiuQBMgVCmSerE3Nzd2jA4EufyGhPoaEk8jnAaegu0/v9pcK+gNNOtHg8ajYufnZm2
 0rzdwywiQh3P29d+v80MDb+DHWanCZ4fy6CW94f9ahu6aVB2RUNqcsVsHvsXdbn8u4jC
 NTb3S2zXxg79EMzGXnCOaFxpd6OeRs+dZHiouZZ/tMArAAaTCsnv9MuOyXzPIjBS3PCh
 +uBYUh7eCO54H3OiRETag1iZXdf1JEyoohpb2MiZRip3YKXFx0RrbltBO+KjNCch0Tgu
 dtQw==
X-Gm-Message-State: AOJu0YwOa0HW+59vIzDK76POuVruemV2JKYiDB5ZufdBXs0IRq9XqmTe
 9NTFBf2/Cc6fShQRUOegMav7hVYC3xnBRDtvvfvo7n7GYQTIdPOcLGdu6YsyBbY=
X-Gm-Gg: ASbGnculEqRu+Ud7Xwrq0kkriBquafm4EUJ6DzgqI7MpUnsanlrnM0l/VUkUkV1HyYp
 lARmQqadUvO/jp3/d0U8Zq8JYBUGY/iReVit0EiHzua07cb5oLyCngOmiJwKDDT+CRzUKRUsJwH
 cS8HXNHo/hNuZcC17CDUx8ZAbT17xhVG4Sc8vNxnxsEhMPNgFNQhaVg0C1opy5sb2LOIRXZoX97
 ZR5G9yDA8RFRV8Q5KUlcyi41OvdxlsO5+0EvqZb2h2WelN7/5/HkFQc77j5fpWEHA==
X-Google-Smtp-Source: AGHT+IEQB4M83c3V3/L0JjaVw775x6GanubHFObD+zbxoLa2Mr/k/Uv1oWJANKMGJ/RJBnatX0EadA==
X-Received: by 2002:a05:600c:a07:b0:42f:7e87:3438 with SMTP id
 5b1f17b1804b1-434d08ee8c1mr17022415e9.0.1733218709077; 
 Tue, 03 Dec 2024 01:38:29 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0f7dd78sm181675665e9.44.2024.12.03.01.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 01:38:28 -0800 (PST)
Message-ID: <9124df54-a9a7-401b-8b0e-b81ac4dab365@linaro.org>
Date: Tue, 3 Dec 2024 10:38:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2? v2 1/2] tests/functional/test_version: Use QTest
 accelerator
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20241203091036.59898-1-philmd@linaro.org>
 <20241203091036.59898-2-philmd@linaro.org> <Z07M4jpxZo9Ns0Rj@redhat.com>
 <884bb70b-bb7a-4676-ab74-fd19a2758955@linaro.org>
Content-Language: en-US
In-Reply-To: <884bb70b-bb7a-4676-ab74-fd19a2758955@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 3/12/24 10:26, Philippe Mathieu-Daudé wrote:
> On 3/12/24 10:18, Daniel P. Berrangé wrote:
>> On Tue, Dec 03, 2024 at 10:10:35AM +0100, Philippe Mathieu-Daudé wrote:
>>> When testing with a HVF-only binary, we get:
>>>
>>>     3/12 qemu:func-quick+func-aarch64 / func-aarch64- 
>>> version                                      ERROR            0.29s   
>>> exit status 1
>>>    stderr:
>>>    Traceback (most recent call last):
>>>      File "tests/functional/test_version.py", line 22, in 
>>> test_qmp_human_info_version
>>>        self.vm.launch()
>>>      File "machine/machine.py", line 461, in launch
>>>        raise VMLaunchFailure(
>>>    qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to 
>>> establish session: EOFError
>>>        Exit code: 1
>>>        Command: build/qemu-system-aarch64 -display none -vga none - 
>>> chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine 
>>> none -nodefaults
>>>        Output: qemu-system-aarch64: No accelerator selected and no 
>>> default accelerator available
>>>
>>> Explicit the QTest accelerator to be able to run the HMP command.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   tests/functional/test_version.py | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tests/functional/test_version.py b/tests/functional/ 
>>> test_version.py
>>> index 3ab3b67f7e3..d3da796991f 100755
>>> --- a/tests/functional/test_version.py
>>> +++ b/tests/functional/test_version.py
>>> @@ -18,6 +18,7 @@ class Version(QemuSystemTest):
>>>       def test_qmp_human_info_version(self):
>>>           self.set_machine('none')
>>> +        self.vm.add_args('-accel', 'qtest')
>>
>> IMHO this is wrong. The functional tests are there to test the
>> real functional behaviour under an actual accelerator not qtest.
> 
> It works using '-accel hvf'. The issue is:
> 
>    "No accelerator selected and no default accelerator available"
> 
> So we should select HVF over QTest by default? I tend to not
> enforce any default because we always get troubles with them,
> what is today's default is unlikely tomorrow's one.

So by using:

-- >8 --
diff --git a/system/vl.c b/system/vl.c
index 54998fdbc7e..2f855d83fbb 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2362,6 +2362,7 @@ static void configure_accelerators(const char 
*progname)
              /* Select the default accelerator */
              bool have_tcg = accel_find("tcg");
              bool have_kvm = accel_find("kvm");
+            bool have_hvf = accel_find("hvf");

              if (have_tcg && have_kvm) {
                  if (g_str_has_suffix(progname, "kvm")) {
@@ -2374,6 +2375,8 @@ static void configure_accelerators(const char 
*progname)
                  accelerators = "kvm";
              } else if (have_tcg) {
                  accelerators = "tcg";
+            } else if (have_hvf) {
+                accelerators = "hvf";
              } else {
                  error_report("No accelerator selected and"
                               " no default accelerator available");

---

All test suites pass on my HVF-only build directory. If this is
OK with you then this is also OK for me.

> 
>> We have tests/qtests for testing scenarios where we want to only
>> exercise with the qtest accelerator.
>>
>> If QEMU is built with /only/ HVF available and HVF can't be
>> used at runtime, then we should be skipping all functional
>> tests, not degrading them to be hardcoded to use qtest on
>> all platforms.
>>
>>>           self.vm.add_args('-nodefaults')
>>>           self.vm.launch()
>>>           res = self.vm.cmd('human-monitor-command',
>>
>> With regards,
>> Daniel
> 


