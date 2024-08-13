Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED6CC52D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtEb-0005m4-Lg; Tue, 13 Aug 2024 11:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdtEa-0005iN-MB
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:14:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdtEZ-0003q5-1k
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:14:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42816ca797fso41565465e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723562089; x=1724166889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lo6LVl9048dCRbf34Uz7ZrLtE5qX/YOrOn2Y11Gf99s=;
 b=VK86lm51CG9RqakWYMy1mEZGv/gpRmSrZ7JsmOCgN+M0r9nGSPrSjISpC6afu2cgid
 tLkBZHuVFWCr8qDxlue0W4OPaq1K4Hwcm/Ek/29RR6+SZv1q8++Mr4uMHBsL2tlL6U5G
 D8C3kSeeeyFdQY4ItGoJKNXIhaztay71tmZO3k/I/G2t8MR26MhPxAGZihz5Ns8GdZDQ
 8LsZGsZzAzwB2dp9olJXx02HxfBdHS/llaOykonSGFeNbgoK0rc/dR/MxpklNdLUo1ev
 qa1ho9gCy9N/UaK0ihRBpp61nfGbs3t1ES6j6WohK1eQNVSmKGWSFQPDdGX4vdcjPb+t
 Iqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723562089; x=1724166889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lo6LVl9048dCRbf34Uz7ZrLtE5qX/YOrOn2Y11Gf99s=;
 b=unOq+xHVqwTKxEUUqT24EHiDe9M/PW8AiMld7Z/wRERynZH0Cu93aXrIqt+/1skyfE
 HeItnfOHJKJUkGojVjFeLEfpxcKV+SCPVXBv5pu68UzBtsf1m/tumWE0uHMmx3XiB5sl
 24AoMx3hMf8xD1xY42ezzS/mvDv3ifcWXk0MWGn3Y2boQa3CREfsfv//zvzXp8fHOK/6
 D4/DlD8NkLinPKNNRFoprzzDg5d/frM3EWaBqBq469XSKiRFlx72p4JUR3/07JKJqgY0
 qF76tPH5/JYN0Y2LtQppGlVLvz/uol28WjRk98/nyGTuqGBhsAFMAUSteQQED8kengLg
 NTVg==
X-Gm-Message-State: AOJu0YzwsfSpVwhCxdQebD4pvDOLkLUIi8Ls3S62IMLMWpiCeElM9pct
 IfPmmhRHuHQvc2G3Rk266EJTBgBapdsiB4+rAmv/k7kb37cNp1Gn/wpMa+qewqw=
X-Google-Smtp-Source: AGHT+IF9fYkhNRm87Viv8jg4CoU9UcnnKZRbwQLXyaxgpUx1JE5Tzehorapg+xoEZ9f+1C+c7CYU0A==
X-Received: by 2002:a05:6000:1050:b0:367:434f:ca9a with SMTP id
 ffacd0b85a97d-3716cc5474emr2552382f8f.0.1723562088927; 
 Tue, 13 Aug 2024 08:14:48 -0700 (PDT)
Received: from [192.168.5.175] (80.red-88-28-4.dynamicip.rima-tde.net.
 [88.28.4.80]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4cfeeb09sm10657887f8f.51.2024.08.13.08.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 08:14:48 -0700 (PDT)
Message-ID: <c23a6547-fc94-48e2-aaa0-af4febca1e20@linaro.org>
Date: Tue, 13 Aug 2024 17:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] buildsys: Fix building without plugins on Darwin
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Konetzka <hk@zapateado.de>, Thomas Huth <thuth@redhat.com>
References: <20240813112457.92560-1-philmd@linaro.org>
 <87o75wa5kq.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87o75wa5kq.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 13/8/24 15:57, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Since commit 0082475e26 the plugin symbol list is unconditionally
>> added to the linker flags, leading to a build failure:
>>
>>    Undefined symbols for architecture arm64:
>>      "_qemu_plugin_entry_code", referenced from:
>>          <initial-undefines>
>>    ...
>>    ld: symbol(s) not found for architecture arm64
>>    clang: error: linker command failed with exit code 1 (use -v to see invocation)
>>    ninja: build stopped: subcommand failed.
>>
>> Fix by restricting the whole meson file to the --enable-plugins
>> configure argument.
>>
>> Fixes: 0082475e26 ("meson: merge plugin_ldflags into emulator_link_args")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Queued to maintainer/for-9.1, thanks.

Thanks, possibly also:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2476

(Cc'ing Helge to confirm)

