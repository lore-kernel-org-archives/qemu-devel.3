Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889E7C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhWuD-0005cU-TL; Tue, 05 Mar 2024 10:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhWu7-0005aO-73
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:40:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhWu1-00054Y-QX
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:40:30 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412e6bdd454so13993745e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 07:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709653224; x=1710258024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pk46VOydOiXXgzSHbizEopV9uHvauF7wEU0t0ZL10YU=;
 b=umB5QghynSBRdO+1/SMs1n+eXUM/aqP0EHB+1LfGZ2EpA0aBQWXh114qCB9uX1t64t
 ffQYhzu0xhZ15m3tCXiikJUcznWzrwMBvtw8bYqvXIyaPTnl3rU/Y6SFq8vLMe6Eel8A
 lMMOWT1rcB83dW5YZKudVtaKvvH1Cts74yr0RiNPcTj66RFfB+mzx1r91vDGjFpjZizx
 eudzfKEfEavTXUnRGjiPzY1CMMaH3EvNT4Lm1RvAogJRmDbtl+MVmEUDgLX/hDTUnw9x
 FASjnCTYHcsvDRCqMcRYz45gEaFr/MXlzuJpqcSVyW1aMbekdSb1UuMBLDdWkMVTzal/
 RtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709653224; x=1710258024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pk46VOydOiXXgzSHbizEopV9uHvauF7wEU0t0ZL10YU=;
 b=Dv/V7dm8qhSjfWbjUq3En8+olTW0dsx7NF+0S3sTxEz3Mifo5hzLvB7HiWygW6h3XB
 lVy7STy808jfyTYYZ8/kDqpJlHWwIi5FxxxAmsNyEXbDDVMTiqQqCCiaW8BlRbti5k1p
 Wxdjx4sdTvvPE0OxwSvcud1PXFEjnMKrCPqKGKm83nNEdW6vYGVndJg0ysxmugW75JSR
 /XLocbJEJ4tWFibg/DYOzyKefDLRtrhTEmU/vFw3wP8lkxMKpSSQSeC7Obs0fWmYV3Hm
 eUrCsbk05GLExRzJPFgkc8Us4lcbMTwtHt3u4abvx3yrjdO0rnSjJ6YDeNmo7ZtwNBZX
 YJaA==
X-Gm-Message-State: AOJu0Ywh8iICYNKK69+AjB51WDkccMqwiz2l7qZ2/qvHRqHD1U9HopCt
 4CDO3COtl89zI/JMIfQGRR1rZo/PhEebO/7sKy9SgnrJiXTCXtpC1H8JlLxKrHw=
X-Google-Smtp-Source: AGHT+IEO9N4O+18Hqdpco3w9+bVRuN6PAb8BHG5amIx+cF2ovF8IIRWXFJ73SrJMjvTa0IoHn4CdFg==
X-Received: by 2002:a05:600c:46ce:b0:412:6c5f:d971 with SMTP id
 q14-20020a05600c46ce00b004126c5fd971mr9536241wmo.11.1709653224138; 
 Tue, 05 Mar 2024 07:40:24 -0800 (PST)
Received: from [192.168.69.100] ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 jn3-20020a05600c6b0300b004128e903b2csm20845222wmb.39.2024.03.05.07.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 07:40:23 -0800 (PST)
Message-ID: <bf7d183c-21a3-484e-8820-f334bd4c9be4@linaro.org>
Date: Tue, 5 Mar 2024 16:40:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/9] Add Rust SEV library as subproject
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Tyler Fanelli <tfanelli@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 stefanha@redhat.com, marcandre.lureau@gmail.com
References: <20231004203418.56508-1-tfanelli@redhat.com>
 <20231004203418.56508-2-tfanelli@redhat.com> <ZecieNcFinT76L0k@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZecieNcFinT76L0k@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/3/24 14:47, Daniel P. Berrangé wrote:
> On Wed, Oct 04, 2023 at 04:34:10PM -0400, Tyler Fanelli wrote:
>> The Rust sev library provides a C API for the AMD SEV launch ioctls, as
>> well as the ability to build with meson. Add the Rust sev library as a
>> QEMU subproject with the goal of outsourcing all SEV launch ioctls to C
>> APIs provided by it.
>>
>> Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
>> ---
>>   meson.build                   | 8 ++++++++
>>   meson_options.txt             | 2 ++
>>   scripts/meson-buildoptions.sh | 3 +++
>>   subprojects/sev.wrap          | 6 ++++++
>>   target/i386/meson.build       | 2 +-
>>   5 files changed, 20 insertions(+), 1 deletion(-)
>>   create mode 100644 subprojects/sev.wrap


> Now, the second issue is that my patch to QEMU's meson.build where
> I look for "CONFIG_SEV" is wrong. I've not tested whether it behaves
> correctly on non-x86 hosts - basically I'm hoping that CONFIG_SEV is
> *NOT* present if building qemu-system-x86_64 on an aarch64 host.

See hw/i386/Kconfig:

   config SEV
       bool
       ...
       depends on KVM

and meson.build ($cpu is the host):

   ...
elif cpu == 'x86'
   host_arch = 'i386'

if cpu in ['x86', 'x86_64']
   kvm_targets = ['i386-softmmu', 'x86_64-softmmu']

So SEV is only on selectable on x86 hosts, with KVM enabled.

> Assuming we get this logic correct though, this unblocks one issue
> with getting this merged - Rust platform support.
> 
> We've said we want Rust platform support to be a match for QEMU's
> platform support. We're probably pretty close, but still it is a
> review stumbling block.
> 
> If, however, we demonstrate that we /only/ try to use libsev crate
> when building on an x86_64 host, then we don't need to think about
> Rust platform support in any detail. We know Rust is fully supported
> on x86_64 on Linux, and we're not introducing any Rust dependency
> for QEMU on other build target arches.
> 
> With regards,
> Daniel


