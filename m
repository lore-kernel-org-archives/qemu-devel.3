Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D881EC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 15:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTiwL-0002hx-Hn; Mon, 23 Jun 2025 11:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTiwJ-0002hA-AK
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:18:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTiwH-0002JT-Jv
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:18:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450dd065828so31548715e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750691908; x=1751296708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wIN+RgRGGCJnokaRdCTi07yk/D+XISYakVoaYJMHles=;
 b=C2rPdIehMbTfrwZdtChH7IUqiEEy4w1Zi6111B7AtOSZGlSEkJoeiiRdwUMIWECM7p
 LvYH0YgKiyK0j0ARrM5dOjrWRxmDRxcgm4/6E/f+mcY/X9Y1apxreAtfp1buNeEKq/wA
 jPmoPKOQd0tS95iGbEPtkJSy0CxxeQkKMFPwAn+IHWAxt4eUXHalSaPfgWSM5GxCqmPI
 yrPlxIwtNW38y8b0JiCTtrK+XPN8IbKCXMM+KPlYaMdpdt/hPcMiKmV7EsZDM7hmPnbP
 4qe4tGAtAxdOoVia0v+oy4sTqirIOTKY262rQsSlRY+uXS1DrP7Uzc6d7ctN6KPGUEBz
 curg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750691908; x=1751296708;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wIN+RgRGGCJnokaRdCTi07yk/D+XISYakVoaYJMHles=;
 b=rHSiusHyFIdSCbjQJ0Ub5VRAVKASLl3jWyeQ9BWp6DWYMwFBhfdP2XonWMborDfuHI
 f6TFH5ROVzSajOVDSn296AY9+bYgcHnfm+KrfIA0gFAO1iAs8x7Zzo5bn7UxG7YNdG4A
 9UQHL91x8gm37QiYCs8MaCE3ep4uoLjEEK8g9a1aIrloS1M8MngIAww9kDOdBK8lCf3C
 1w1BFg80lm2/JRKVpKAdUO3gq33aWqMAUfn5NYwXQRku6lsmuazlCQqyAYLwTfc5pc6T
 9AYGOnHpOvEpszaZDawOVXgKzVZqfqFOpwx1gY8AOOqsOWOu48yAsjjXUPqo+qGFKQia
 DyYg==
X-Gm-Message-State: AOJu0YxY0Q65CpnMGIr4DKTTSz0YFGwoYeyq/xtLDOT+h9oUBubXYtn5
 tGh2mjWXfKfuK2/9qhVW+j4XH+3Eft4ZPG4Ml5YMbooaLOH2FUJ8gOYh1+jhQzVJEKY=
X-Gm-Gg: ASbGncuvwhBljO1d+afs8YIjkvSVKPfc4y93gdjevg3n9m1uaPJvpvEARIC8quGxX/z
 2sJMP6yAcHXnDoGHt9GOXn73d/nkDH1TOFk5Ujoz7KUAgvVpVQTkWyINYw5Hby8XViCSSFX2sgH
 n+8PMN6A/PuNQC3MRNVdba6gGeHGgctK0bNSnoy8RSFUGL/8OB5z19zDOkgRGKC0tuJZRHxxeq9
 HF2sEf7xH5X9QjGwk5RD0AtZ7YjJYrL9FqNreJ+ZjMWShuODf6mT/GRG55SLoNr7Qc/tHZnABAO
 uWBq9Q0JKhUq8ZUwyhFI5pl1YljClZ7AbAbuoXoYf58ddZs3/yiG+nfK79Dmd0yvhTkUly4KbTN
 K9cnzxDY0bAnaKoIVpHc2rSw00F9EVQ==
X-Google-Smtp-Source: AGHT+IH5HwlDfedhxQ2UBOIYP7nsIw3gbY72muiBf9A3OzLSvMyE2iSR+eAsDWo7s2KE6DPTbZIwwQ==
X-Received: by 2002:a05:600c:3f90:b0:442:f4a3:b5ec with SMTP id
 5b1f17b1804b1-453653cf3c4mr109783435e9.4.1750691907914; 
 Mon, 23 Jun 2025 08:18:27 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45363c0f227sm55323695e9.2.2025.06.23.08.18.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 08:18:27 -0700 (PDT)
Message-ID: <a8a4d2f7-2341-4cdb-8ca9-8deda337434c@linaro.org>
Date: Mon, 23 Jun 2025 17:18:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/26] tests/functional: Expand Aarch64 SMMU tests to
 run on HVF accelerator
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Bernhard Beschow <shentey@gmail.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cameron Esfahani
 <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-27-philmd@linaro.org> <87sejq1otw.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87sejq1otw.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 23/6/25 17:04, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/functional/test_aarch64_smmu.py | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/functional/test_aarch64_smmu.py b/tests/functional/test_aarch64_smmu.py
>> index c65d0f28178..e0f4a922176 100755
>> --- a/tests/functional/test_aarch64_smmu.py
>> +++ b/tests/functional/test_aarch64_smmu.py
>> @@ -17,7 +17,7 @@
>>   
>>   from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
>>   from qemu_test import BUILD_DIR
>> -from qemu.utils import kvm_available
>> +from qemu.utils import kvm_available, hvf_available
>>   
>>   
>>   class SMMU(LinuxKernelTest):
>> @@ -45,11 +45,17 @@ def set_up_boot(self, path):
>>           self.vm.add_args('-device', 'virtio-net,netdev=n1' + self.IOMMU_ADDON)
>>   
>>       def common_vm_setup(self, kernel, initrd, disk):
>> -        self.require_accelerator("kvm")
>> +        if hvf_available(self.qemu_bin):
>> +            accel = "hvf"
>> +        elif kvm_available(self.qemu_bin):
>> +            accel = "kvm"
>> +        else:
>> +            self.skipTest("Neither HVF nor KVM accelerator is available")
>> +        self.require_accelerator(accel)
> 
> I think this is fine so:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks.

> However I wonder if something like:
> 
>          hwaccel = self.require_hw_accelerator()
> 
> Could fetch the appropriate platform accelerator for use in -accel bellow?

Then we'd need to make it per-host arch, and I'm pretty sure hw
accelerators don't support the same features. So I'd expect a
rather painful experience. WDYT?

