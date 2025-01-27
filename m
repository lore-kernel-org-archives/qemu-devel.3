Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4594C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 17:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcStk-0003QR-8s; Mon, 27 Jan 2025 12:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcSti-0003PX-51
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 12:27:42 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcStg-00049K-GD
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 12:27:41 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385dece873cso2571876f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737998858; x=1738603658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vst1GWoYUOEqSaQQbfKIzhAHzh0PNZBIbP+qOUJbMGU=;
 b=m9VSG+0Ju+A+peN/twqoRFsminAYmzb8gydkIac5OwslnZtytf0fxFMY8WgY7/gE2K
 /57It8OID+UHILs0wE88vpmund1NxC0r0v7pLQJ82RS8J50Ws6uQGq2aUZgozvm/aMi/
 5dSeqwriG9T4r+Qw8ZqtILnUnzk468JdQHX+VhZWqLRfx3lfBHW5VlIw65d9dBWSuLDG
 1KuzZDh4KaIEjETLxmRa8E1dt/VwPd43cp21Xqk+rE+zt+8tLUtbz4uUDcIC9hCDlk1O
 e55/yMS9iyvaCmbe3fhYTgjydPD9gAQNEGzO1LUsUgCdeYbv4s/NLL9wqi7BWdJiV+6V
 C3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737998858; x=1738603658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vst1GWoYUOEqSaQQbfKIzhAHzh0PNZBIbP+qOUJbMGU=;
 b=kVHjkNugKKrTlLaQ7mvExfsGc/FzC7qpfMLFSsq/8ZWtJeEHxHmJv4Hx88MAI68fmo
 /l5/FFH9qDpbfvyNrfdBaAlw4Oc+IlPJ9WuFSo2frrz2fM3m2Njzo8r3OdjdD2fmnSwd
 rOZ3S86V8thhkc5rk210jGMvIElgkSSwIARQjRV4ti9OmhcQCfG51CJgxJV75Pyx52+Z
 mlh0IzSJTi9zz4S11/8+CG381qZDIcqZBkJBA+BQCD5/DzM7k9fhsKz0HxeGl8QLl2O6
 U2/16zlXw7Rllio0gkOon5lDBJOU6RmBSjgwfrtIE6L5bjtJqrrvISvJF5TRvxM8/hrl
 aDRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaay47BZpnef4HtcOi/HRqP0DUr0dollg5vOL2XUgats55qChcsZE2loew5zAIgeyr2bfVnosyNjNi@nongnu.org
X-Gm-Message-State: AOJu0Yyfi/CNjwi/OPNiJ06sf8IOlHeYyG4qYPwN0eaGSEzXF9ncS4sz
 SU5/v8yTB1OpPsxFrB9E0UpBzvUu2OpzHluFUdzApeUaz6Cm36rZ5oueMRKEop4=
X-Gm-Gg: ASbGnctJ5NeyPePSuVrlTDcWcstNG7Q6lEIdDbth6zAv/7lRUAzuIUGQY6DvaInViDV
 GEBrFrEXr/bWdBWJ56JtAo97aGVbDgsRLQfL2nkgANtS9fYS6k5hpLj7hTCOQzybQfcVT37X0hr
 HcbjcXLJ6l8xacpWvP7HtVlKrihZxf3x0bwzzGMbvJgFPmCRxDbVtz/IjixOqdj3/qEgiycOXa7
 fogx65Ga51tVap8gYmW6wY9rIbjcAy1rFIhAISNHXiG0MWGXRwjV84q27zy5qd3PY1aPexWIhM6
 vH2YoCI49SFGVZPz7a4CDCPWsLEICkVhsmQFcM+2iWkzBehC
X-Google-Smtp-Source: AGHT+IGwAGykwZ4NK4gCsYQVcsYy6NFAiin8OXPIvGYntidmLjsc/YAAipUlYTkzACWLbNbVBmPKCA==
X-Received: by 2002:a5d:6c68:0:b0:385:ef39:6cd5 with SMTP id
 ffacd0b85a97d-38bf5656ddfmr37640768f8f.1.1737998858565; 
 Mon, 27 Jan 2025 09:27:38 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb0d4sm11915942f8f.69.2025.01.27.09.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 09:27:37 -0800 (PST)
Message-ID: <44f75f64-4480-4cd2-a907-cf0638568e55@linaro.org>
Date: Mon, 27 Jan 2025 18:27:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Deprecate iwMMXt emulation and associated
 CPUs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250127112715.2936555-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250127112715.2936555-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 27/1/25 12:27, Peter Maydell wrote:
> This patchset marks all the CPUs that support iwMMXt as deprecated,
> because I don't believe anybody is using them, and we have no way to
> test the thousands of lines of code we have that's only there for
> iwMMXt emulation.  (See for instance the recent thread where a patch
> was submitted to fix an issue detected by a static analyzer: we
> didn't take it, largely because we had no way to know if the
> behaviour change the patch would produce was correct or not.)
> 
> The pxa2xx CPUs are now only useful with user-mode emulation, because
> we dropped all the machine types that used them in 9.2.  (Technically
> you could alse use "-cpu pxa270" with a board model like versatilepb
> which doesn't sanity-check the CPU type, but that has never been a
> supported config.)
> 
> To use them (or iwMMXt emulation) with QEMU user-mode you would need
> to explicitly select them with the -cpu option or the QEMU_CPU
> environment variable, because the '-cpu max' default CPU does not
> include iwMMXt emulation.  A google search finds no examples of
> anybody doing this in the last decade.
> 
> I asked some of the Linaro GCC folks if they were using QEMU to test
> their iwMMXt codegen, or knew anybody doing that upstream, and the
> answer was "no". In fact, GCC is in the process of dropping support
> for iwMMXt entirely.
>                      
> We have one test case in check-tcg which purports to be checking
> iwMMXt. In fact it is doing no such thing: it runs the test without
> selecting an iwMMXt CPU, which means the iwMMXt insns are interpreted
> as FPA11 insns by the linux-user emulate_arm_fpa11() code. So the test
> prints garbage and then succeeds anyway. Modern distro toolchains

Uh...

> can't generate a binary that will run with -cpu pxa270 (because their
> crt startup code uses Thumb insns); rather than putting in a lot of
> effort trying to salvage the test case to really test a feature we've
> deprecated, I opted to just remove the test.
> 
> -- PMM
> 
> Peter Maydell (2):
>    target/arm: deprecate the pxa2xx CPUs and iwMMXt emulation
>    tests/tcg/arm: Remove test-arm-iwmmxt test

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


