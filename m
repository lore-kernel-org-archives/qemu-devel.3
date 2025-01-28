Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19058C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 21:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcspP-0001N6-RX; Tue, 28 Jan 2025 16:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcspM-0001Mw-4Z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:08:56 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcspJ-000348-Eq
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:08:55 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2164b1f05caso106585615ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 13:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738098531; x=1738703331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ucbb9qmuVK87oA2mZ81iMzR3KJnu6u/nhAR7EnKBOVg=;
 b=D1L4NPCPt4tfe2eSNWA7U3Gmlp7x7h3kDzu/YEiZr0ZGufnA58sZPmIlYLTpA8UfpA
 3GDfNCYrDcrArGu3bp1sZmGrfXh8In87MS0jnq7tk52ogWPWbYA6iNBngE3nFSkxifl9
 CDK43LPO89zju+DUUpy4fpPFLnWX6FoBIDXmd7d44ptF7flBebnTFmoFk/3Ro+BVP+CS
 /IgOhMnn7vkAu3/0jxIDMEGDUmaOnSFxd04BEh2fJ3OtWgVKvoQzrJjMcunOgAB5iCpR
 67H53wq959h2QV9Qc24hjj6/iG1IQSKWg35ZIcMvcpS7OSw3SFcJJ4lOu+Xf+WJCgXQq
 t27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738098531; x=1738703331;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ucbb9qmuVK87oA2mZ81iMzR3KJnu6u/nhAR7EnKBOVg=;
 b=wn7jSOhH/L1WycCOD5aU4isT15J5W5mjzWsnS4tIRitwNlj4pteOjN6Wiu1i+GDebc
 /RYXumcackaOiBt0+LJEjAdzo1l7ih/GNt9VWJAx/DPYTwCZwAZqQ1T2ANiXud7t4Vjl
 PnV01Xg0iwo4A8XMm/wPVimRarOPHhDWsaa186z7uwzPbTssm1B3k8uvMXZ4vWNj5KOX
 GkKI18RQAl8k0zxOYyQtpyBsiy2p1oAVUBuyK0oL6HAp9cGkQd5xBNEhq4tymp1K0jQl
 DXv2JliUPvzRj32ye/QvTKKLXzO/tW5xnN1bfJIjtp2u5NVTwqZ/Fh1QHOiZE8lAM8P/
 Tkaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGnpCwuvdL8xDXUajenaO5mKmt42sKzv224nX2BqOxLB9XhKhRXrljxGwIBiEok7j1m7p4r4uSuBkk@nongnu.org
X-Gm-Message-State: AOJu0Yx9xT2ZOf/hfRT1MMAq4PWA66W9Ax7As4MIUGUGlnFgZ4l2MkmY
 rll/ppnjVP8fcO+U3sl3TiU/3GzQwcmK7nrVp/dAZ1ntxexyO0Zrc6XKx4ZRfCqBlHIVOCusYTh
 X
X-Gm-Gg: ASbGncv96YyuTrrIS5RvTEIowMU4S5DnP8VOMBh6L0Sccxr4zqaiwKEIxl0WNdsvsUk
 7gHJq0UbZEEjrT1j67AI1GkXpdyjg+vjCz3RF/I20f4G9/Lcnb3PugRMDQvM2+aIoSV/Z29S9qR
 fbjMWIBKJu2oDrjBBENLtQclIx4ZbtDBn8KRanNX0vjUad2en7viZneLqBeT9UaRKhxyrinsZp8
 azlAKutTm/0ootz3row9qIRcaW0I93RuCHoRccD36OFlWGgMWup64+i1KVPBNlDlVHheGeM3E+1
 InFtqKguX4/4FKdhJRoqtbK7EO2V7lPeSaqJ2Mg/1sdsoTNOUgdooetWcED8IFuL++3J
X-Google-Smtp-Source: AGHT+IE4uO8hUrMbFmpjdy8SwPd9r/hdSYFu4mE54IELOObvMf9o2U6+6OfHAOJy078qd8CsgOI0uw==
X-Received: by 2002:a05:6a21:700f:b0:1e1:f40d:9783 with SMTP id
 adf61e73a8af0-1ed7a6e0786mr1430845637.40.1738098531140; 
 Tue, 28 Jan 2025 13:08:51 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6c7ca3sm9771454b3a.75.2025.01.28.13.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 13:08:50 -0800 (PST)
Message-ID: <3f7347e3-59b2-4e52-a9b5-2c46a3d9a635@linaro.org>
Date: Tue, 28 Jan 2025 13:08:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] tests/qtest/migration: Allow using accelerators
 different of TCG / KVM
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-8-philmd@linaro.org> <87ikpzt1xw.fsf@suse.de>
 <aa745382-40e4-40f6-bec0-4012626f1fbc@linaro.org> <87frl2u39e.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87frl2u39e.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 11:50, Fabiano Rosas wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 1/28/25 07:04, Fabiano Rosas wrote:
>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>
>>>> There is no particular reason to restrict all the framework
>>>> to TCG or KVM, since we can check on a per-test basis which
>>>> accelerator is available (via MigrationTestEnv::has_$ACCEL).
>>>
>>> The reason is:
>>>
>>> CONFIG_KVM=n
>>> CONFIG_TCG=n
>>>
>>> The check is about "there is no accelerator at all".
>>
>> We perform the no accelerator check in meson.build on a per-target basis.
>> So you'll never have a qemu-system-foo binary with zero accelerators.
>>
> 
> Ok, the issue was not zero accelerators, but Xen. On aarch64, this
> produces a binary with no TCG nor KVM:
> 
> --target-list=x86_64-softmmu --disable-tcg --enable-xen

Right.  Phil's patch set specifically mentions HVF, but there's no reason Xen can't be 
better handled too.  Unless there's something explicit about Xen that cannot be handled 
here?  But even then, the if condition needs updating.


r~

