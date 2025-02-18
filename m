Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D0AC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPU3-0006vi-AY; Tue, 18 Feb 2025 10:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkPU2-0006vK-11
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:26:02 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkPTz-0007gb-L0
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:26:01 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so38019005e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739892357; x=1740497157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kO8ZjQjaFKbnEHTOpCzz+11SR4934oDmM1CC/TSqYe0=;
 b=JuhzjHm+LdmJx/+9zkipcIXV+UFON4QR5uApch8nu/cbk2x4GfKnJKan1xy+Hq0oIQ
 I6/fNeCg5XSnsB8B62iF20s7BcoaZJvCwscLZ+XrCNL1Z76ec6DWI2jv96FuoNOHfadD
 5opiD/tFEZf4I2qOd26xOqbhMkh2o8772Gn9xFRX1IsPHrRcGfwCRfr00U+gBtfznOGq
 082jsV0h9PN7pYCbREamQRd+Bj6laIgxjgksvz98imiBH3lM57jP9UmwRPgX52D2wao4
 2gJ8fbuiLLFvAzngqztNxkaX4g/Uul1EeH2RwlC+1Y9X/p0zgLtDx0eiJRMYDM9b2Sl0
 nxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739892357; x=1740497157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kO8ZjQjaFKbnEHTOpCzz+11SR4934oDmM1CC/TSqYe0=;
 b=KNlwGPFWSGiF6Bb+hDD9cqy16cKXvolePXiGAUldxAjZckRVa344p7UiX3RDF1R+p4
 aZuKRugmjFXRWOkixKFIt7WdHk6l4QxFbXhUuNLA1EgPbMnXQ9izg3hccWxbZllmeUqt
 JUWxP4uWzTFunlabRFU7/dNS44fTGPW88DW3Cvo8BJhFZZpaje51WTtM8yoQj/NypXA/
 hmpzy4clNXSSrxfgRbzHAIY63RzYjyZf+EJeUVq8P0Kw2Zk1EmAQV+jyCjpIiVCqU7+/
 UPllb123sBC3aXbploveN4V7pNr2nG/yHHShtPLLlKt8nC23SP4WUnTGvAWwuW7AED/L
 qFIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf08B1i82tyN4C3kYfwqhkIPtgsrZhXxvKE3z8frR3Xalf1zYg3RfjcygsheqdEEhMjq771ma+WxaG@nongnu.org
X-Gm-Message-State: AOJu0Yx+6HetsaJncCr8vGwsPP9jkdy+Vz1V33CcEbTodTWE5/6TIU3l
 Zm26t2ijWrCLuTlpqDb62/8sMAu72omEj321kCBpdqstCag6EANA6jq01/Eoyi8=
X-Gm-Gg: ASbGncu1lOEcOb0vAnXtOngzbaLMtogBmgJo2Z4M3w6IJfuDzsSyX11a1ew1x/dxoaV
 42t3pkqA4l8OtY9yBcyUgPGiJU2aV3bE3w/NWeyEqxt9T8s5v49iild2RAorM86wrfNSrMySDnn
 bXLgPCp6YQ3vSRfaox6S09gj5HlQXVfPWolji9NkfDURPOHkjgiCtX7SEOqBEs6PEZ/qmGGmcES
 jBZ/W7VbM+ZtsZrKxZXrc5ISN6W/3Xibp4wYoq6AwG0Rx9MhbZnAdut2qYdWqdkuwLovDIyuQ3m
 YNTv5CPVWGcN4o3MDgs+CFm60GAkZD45rk75vYTBZSOyX1cd6tlkaurf9+I=
X-Google-Smtp-Source: AGHT+IEfQkZCEMZr8K3W+1iS/umucsBFRf5X6CifaRXiFtiDEf5G7/tN5hMhY5suxFVLoEfx6kpx6w==
X-Received: by 2002:a05:600c:1552:b0:439:90f5:3942 with SMTP id
 5b1f17b1804b1-43990f53d17mr32639405e9.25.1739892356885; 
 Tue, 18 Feb 2025 07:25:56 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43996aa820dsm16090465e9.5.2025.02.18.07.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 07:25:56 -0800 (PST)
Message-ID: <3fb630f4-ebd2-4f14-a1fe-4e84786a1400@linaro.org>
Date: Tue, 18 Feb 2025 16:25:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/9] meson: Disallow 64-bit on 32-bit Xen emulation
To: Andrew Cooper <andrew.cooper3@citrix.com>, qemu-devel@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
 <20250208205725.568631-4-richard.henderson@linaro.org>
 <aeaf0f19-0f14-4a02-9c51-09521e7c75e1@linaro.org>
 <9b22d0ff-5902-4ec7-ae54-e974482ebd87@citrix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9b22d0ff-5902-4ec7-ae54-e974482ebd87@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

+Vikram

On 18/2/25 15:10, Andrew Cooper wrote:
> On 18/02/2025 11:20 am, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> Adding Xen community.
>>
>> On 8/2/25 21:57, Richard Henderson wrote:
>>> Require a 64-bit host binary to spawn a 64-bit guest.
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    meson.build | 9 +++++++--
>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index 1af8aeb194..911955cfa8 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -304,9 +304,14 @@ else
>>>    endif
>>>    accelerator_targets = { 'CONFIG_KVM': kvm_targets }
>>>    -if cpu in ['x86', 'x86_64']
>>> +if cpu == 'x86'
>>> +  xen_targets = ['i386-softmmu']
>>> +elif cpu == 'x86_64'
>>>      xen_targets = ['i386-softmmu', 'x86_64-softmmu']
>>> -elif cpu in ['arm', 'aarch64']
>>> +elif cpu == 'arm'
>>> +  # i386 emulator provides xenpv machine type for multiple
>>> architectures
>>> +  xen_targets = ['i386-softmmu']
>>
>> Is actually someone *testing* this config? I'm having hard time building
>> it, so am very suspicious about how it runs, and start to wonder if I'm
>> not just wasting my time (as could be our CI).
> 
> It was intentional.  I believe it was Stefano (CC'd) who introduced it.

In the introduction commit, "ARM targets" is used, so apparently both
32/64bit were picked deliberately:

---
commit aaea616d54317b8a0154adf52303a51da2d8d56f
Author: Vikram Garhwal <vikram.garhwal@amd.com>
Date:   Wed Jun 14 17:03:38 2023 -0700

     meson.build: enable xenpv machine build for ARM

     Add CONFIG_XEN for aarch64 device to support build for ARM targets.

     Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
     Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
     Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/meson.build b/meson.build
index 481865bfa97..cfa98e9e25f 100644
--- a/meson.build
+++ b/meson.build
@@ -136,7 +136,7 @@ endif
  if cpu in ['x86', 'x86_64', 'arm', 'aarch64']
    # i386 emulator provides xenpv machine type for multiple architectures
    accelerator_targets += {
-    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu'],
+    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu'],
    }
  endif
  if cpu in ['x86', 'x86_64']
---

> Xen uses qemu-system-i386 everywhere because qemu-system-x86_64 doesn't
> make compatible VMs.  I'm not sure why; I suspect it's bugs in the Xen
> machine types, but I don't know QEMU well enough to be sure.
> 
> Another thing that (at least, was) tied to qemu-system-i386 was using
> Qemu as a XenBlk <-> QCOW adapter, at which point it wasn't even really
> a system emulator, just a paravirtual disk implementation.
> 
> This is, AIUI, what ARM wants with the xenpv machine.  If there's a
> better way to do this, please do say.

No, I concur.

> Looking through Xen's CI, I can't see any of the ARM builds building
> QEMU at all.  I think it's quite possible it's not tested any more.

We only cross-build, see our cross-arm64-xen-only job:
https://gitlab.com/qemu-project/qemu/-/jobs/9165958873

Note, if it is not clear, the problem I have is to test Xen on
32-bit ARM hosts; I don't have any problem with 64-bit ones.

Regards,

Phil.

