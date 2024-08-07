Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1E7C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 07:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbb6A-00021D-6D; Wed, 07 Aug 2024 03:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbb68-00020F-H7
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:28:40 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbb66-0008L7-6G
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:28:40 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52f01ec08d6so1868076e87.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 00:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723015716; x=1723620516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zroGU1+lvxost8RNVnnE3lD/cZpLIsMV4fTQMfmZmnM=;
 b=ElAwyBITQO20GKSm9pt4GqOGvt7lz2cjIvIgReyYDnoQaQmbidGKEX5DyrjV8Ola7m
 Ph0ymu7H+xnrG2G0lSwmtDmAjCfkl6jlhUeFAath3fN3F+HmP8M/PYT7SOeEPecQOzWJ
 WNv9HJR392E0H6z486ZpzSiabECZO3H3lH9yc0jV38Ovf13jSfDvgEF7blMpgGCbxshA
 +TgSLo8Prqt6u6gCPs2doOv4zke6eTctPtrZNjq/pnLAdJMWaGWCtHZ5rzvUaCUhmLbv
 cbKQsny+3DmAFnh9O/1jiHOjR803Ib332cQAlZrSUT3bOT2lMB6riQ5iTW3w0+cfGEp1
 i2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723015716; x=1723620516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zroGU1+lvxost8RNVnnE3lD/cZpLIsMV4fTQMfmZmnM=;
 b=NYsBhZiXUdiZ8EnpY2GIhMiICei348CCRqcLto8Z4KGWNaJwaGSYRn3Ph6Z6l+snE3
 59YBtZhEqYaQyIC+UsLby2fT/TqLp+aC/t3Uk2c94lTqqfscb+Y2y4c35fa3kLpa9Ou+
 jx/5Nz/4tN7bu4zjnEPp8W0gdYlvzJjFvWZL/upDxVA+xkdlQYWSO25iM5V4olUd6hjp
 tPMiMu6fzqsnYYlUu5r0CbPXGR9N62peHQOU5k0lO1KH+PxEVPf0pH7FsXfE9ghu1cPN
 6FK5Vbt6LESJprT3znLaVc0z27OHU3fNk0qBgB2lVDRbaj2EUfaTXyBqsY17e9VU374s
 Ftww==
X-Gm-Message-State: AOJu0Yy3qnMMLYLI84Jl/b1UJOXppeFTtNEFzLEqiNYWxAfahlejnLUc
 0eEFuaECK7U30KZ71IYQsS4260k8hMh6cyqlfGCnc8SLlT+ggHwpWRXTvQYIJBjCJE8D5PqoRHq
 c
X-Google-Smtp-Source: AGHT+IGFxiXaa9euhpDFD53X20XbPPydHURUNgFVcrYxAYmdKE7zAcsA/k2kmRnX7DvLVABQNuo+5Q==
X-Received: by 2002:a05:6512:3dab:b0:530:ad9f:8757 with SMTP id
 2adb3069b0e04-530bb39b897mr12710716e87.45.1723015715573; 
 Wed, 07 Aug 2024 00:28:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc8esm14972839f8f.19.2024.08.07.00.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 00:28:35 -0700 (PDT)
Message-ID: <df628091-6d6a-4fdc-b048-3dd91a8060a1@linaro.org>
Date: Wed, 7 Aug 2024 09:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-2-philmd@linaro.org> <877ccs29xh.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <877ccs29xh.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 7/8/24 07:12, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> qmp_query_gic_capabilities() is not specific to the ARM
>> architecture but to the GIC device which is modelled in
>> hw/intc/, so move the code there for clarity. No logical
>> change intended.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/intc/arm_gic_qmp.c     | 59 +++++++++++++++++++++++++++++++++++++++
>>   target/arm/arm-qmp-cmds.c | 52 +---------------------------------
>>   hw/intc/meson.build       |  1 +
>>   3 files changed, 61 insertions(+), 51 deletions(-)
>>   create mode 100644 hw/intc/arm_gic_qmp.c
> 
> [...]
> 
>> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
>> index afd1aa51ee..45d3503d49 100644
>> --- a/hw/intc/meson.build
>> +++ b/hw/intc/meson.build
>> @@ -39,6 +39,7 @@ if config_all_devices.has_key('CONFIG_APIC') or \
>>   endif
>>   
>>   specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
>> +specific_ss.add(when: 'CONFIG_ARM', if_true: files('arm_gic_qmp.c'))
>>   specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
>>   specific_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files('arm_gicv3_cpuif.c'))
>>   specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
> 
> You move qmp_query_gic_capabilities() from target/arm/arm-qmp-cmds.c (in
> arm_system_ss) to hw/intc/arm_gic_qmp.c (in specific_ss when
> CONFIG_ARM).
> 
> Both _ss are target-dependent.  In my testing, both get only compiled
> for target arm and aarch64.  Obvious for arm-qmp-cmds.c in
> arm_system_ss.  Less so for arm_gic_qmp.c in specific_ss; I guess the
> CONFIG_ARM does the trick there.  Correct?

Correct, Kconfig CONFIG_ARM_GIC depends on Kconfig CONFIG_ARM,
itself defined for configure TARGET_ARM (see target/arm/Kconfig).
(Also CONFIG_AARCH64 selects CONFIG_ARM).

I can clarify that in the patch description if necessary.

