Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED1EC35FE0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 20:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxuJq-0004fj-PE; Mon, 07 Oct 2024 16:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxuJk-0004er-LC
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:27:00 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxuJi-0003N7-Hx
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:26:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20b58f2e1f4so32611485ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728332813; x=1728937613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8+OvFNnVDFDD6saPwTPjN7Tl7PEtjzmJqWBI4NesMIA=;
 b=oK22oYTMC8TvXI7IehxyZ2LjFA9ah197WrlU5qyu2wG7/QDAqDxQ+huhFwuDPQRbRu
 a+FxLKCQFWKhQwUfa2pnbELlTjsGTQ8YymeTpcnfCfC2p8zwZ7Agm5wTRqOGXURu+8P3
 X489wyLwSW4LdbOzBd2Ovpx+s32/FhBU9n4lpMVd1Gh+k/LXrMSUJYfFSHBrfhJL1zs5
 9X/VxxIVTM+xA0PwxPD1mYcJX1N8xk7kjDmgzwKjrV3uWq0VAJ/rx/cNvtuQfoHff3Xo
 RTLkJZRDC+FKbhOm3pzh2XBxqMfUSVRFs5fi2HFuuIqVHuslB3NNoCcKOdA6zVF/8ERM
 oClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728332813; x=1728937613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8+OvFNnVDFDD6saPwTPjN7Tl7PEtjzmJqWBI4NesMIA=;
 b=b7UOO9ruBsU9P1+ZTaVkrLimMyTk0wiVCmc5N4lzJgYT2NqaHfPNssRz5kxxkakEgP
 D/REXyiaqM+kzoZLfjfQfg6YQ4mivzQcltYqlphBlVlNpjnMyZEnRvvOFZvtzj79ZcSF
 6fg0T395sokjho4PFV95XM2S/vDU+dhAClSrv7KBeZdlXkKV8daVmeDbQzHDKEsq5qhD
 Xu4T2/ML+Nk5XocSGAgY5NP+sVQkDnM+lhwe23i8IxZ/ZGazWPxCRy3roFQUA+KnbTNi
 +lrj7Zv4PXuwMaKwVjuFSA+xlCV7/aOSYWmocoGst7xqCIVpiNEk9X0byDSsCEgyjRhN
 d/TQ==
X-Gm-Message-State: AOJu0YyU5X2J7O2TVXbDNBDczPWQKDkO5G4nNGVLsYGrYjQceidlBldB
 SJS2KI+jYB2T//Ky2mLNMjCDh7MGRvztcRrnaf8kbaqn9fUdX96sTDcvqmlLMwE=
X-Google-Smtp-Source: AGHT+IENbHHLjHN6tFSpzPqVQD/6e/1HorL5wVQh2/J19g2dBIAhvtoq2IZIQe6l87fc198/bmUcXA==
X-Received: by 2002:a17:902:dacc:b0:206:ba20:dd40 with SMTP id
 d9443c01a7336-20bfe1964fdmr225895525ad.27.1728332812325; 
 Mon, 07 Oct 2024 13:26:52 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396df62sm43581605ad.233.2024.10.07.13.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 13:26:51 -0700 (PDT)
Message-ID: <8f868ebb-8fc3-4f50-b846-a9d93d44daa7@linaro.org>
Date: Mon, 7 Oct 2024 17:26:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] .gitlab-ci.d/cirrus: Add manual testing of macOS 15
 (Sequoia)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240917085058.1740-1-philmd@linaro.org>
 <20240917085058.1740-4-philmd@linaro.org> <Zul7dIheGE03MtgQ@redhat.com>
 <d2d5706c-882c-4643-bda7-c820fb2a42d5@redhat.com>
 <ZwOnPdXY8sMJfas-@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZwOnPdXY8sMJfas-@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/10/24 06:17, Daniel P. Berrangé wrote:
> On Mon, Oct 07, 2024 at 11:10:20AM +0200, Thomas Huth wrote:
>> On 17/09/2024 14.52, Daniel P. Berrangé wrote:
>>> On Tue, Sep 17, 2024 at 10:50:58AM +0200, Philippe Mathieu-Daudé wrote:
>>>> Upgrade libvirt-ci so it covers macOS 15. Add a manual entry
>>>> (QEMU_JOB_OPTIONAL: 1) to test on Sequoia release. Refresh the
>>>> lci-tool generated files.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> Pending libvirt-ci MR 501: https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/501
>>>>
>>>> CI job: https://gitlab.com/philmd/qemu/-/jobs/7841560032
>>>> ---
>>>>    .gitlab-ci.d/cirrus.yml           | 17 +++++++++++++++++
>>>>    .gitlab-ci.d/cirrus/macos-15.vars | 16 ++++++++++++++++
>>>>    tests/lcitool/libvirt-ci          |  2 +-
>>>>    tests/lcitool/refresh             |  1 +
>>>>    4 files changed, 35 insertions(+), 1 deletion(-)
>>>>    create mode 100644 .gitlab-ci.d/cirrus/macos-15.vars
>>>>
>>>> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
>>>> index f061687f1b..b84b42cce5 100644
>>>> --- a/.gitlab-ci.d/cirrus.yml
>>>> +++ b/.gitlab-ci.d/cirrus.yml
>>>> @@ -66,6 +66,22 @@ aarch64-macos-14-base-build:
>>>>        NAME: macos-14
>>>>        CIRRUS_VM_INSTANCE_TYPE: macos_instance
>>>>        CIRRUS_VM_IMAGE_SELECTOR: image
>>>> +    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-ventura-base:latest
>>>
>>> Something isn't right here - the existing 14 release is "sonoma", "ventura"
>>> was 13 IIUC which you just removed
>>>
>>>> +    CIRRUS_VM_CPUS: 12
>>>> +    CIRRUS_VM_RAM: 24G
>>>> +    UPDATE_COMMAND: brew update
>>>> +    INSTALL_COMMAND: brew install
>>>> +    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
>>>> +    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
>>>> +    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu
>>>> +    TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
>>>> +
>>>> +aarch64-macos-15-base-build:
>>>> +  extends: .cirrus_build_job
>>>> +  variables:
>>>> +    NAME: macos-15
>>>> +    CIRRUS_VM_INSTANCE_TYPE: macos_instance
>>>> +    CIRRUS_VM_IMAGE_SELECTOR: image
>>>>        CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
>>>
>>> And this should be sequoia
>>>
>>> I think the info we've committed to libvirt-ci is probably wrong.
>>
>> FYI, I'm going to queue this patch with the update to the fixed libvirt-ci
>> commit and this patch on top:

Thank you Daniel / Thomas!

>>
>> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
>> --- a/.gitlab-ci.d/cirrus.yml
>> +++ b/.gitlab-ci.d/cirrus.yml
>> @@ -66,7 +66,7 @@ aarch64-macos-14-base-build:
>>       NAME: macos-14
>>       CIRRUS_VM_INSTANCE_TYPE: macos_instance
>>       CIRRUS_VM_IMAGE_SELECTOR: image
>> -    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-ventura-base:latest
>> +    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
>>       CIRRUS_VM_CPUS: 12
>>       CIRRUS_VM_RAM: 24G
>>       UPDATE_COMMAND: brew update
>> @@ -82,7 +82,7 @@ aarch64-macos-15-base-build:
>>       NAME: macos-15
>>       CIRRUS_VM_INSTANCE_TYPE: macos_instance
>>       CIRRUS_VM_IMAGE_SELECTOR: image
>> -    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
>> +    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sequoia-base:latest
>>       CIRRUS_VM_CPUS: 12
>>       CIRRUS_VM_RAM: 24G
>>       UPDATE_COMMAND: brew update
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> With regards,
> Daniel


