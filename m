Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4432CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 23:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v45w2-0004RG-DM; Wed, 01 Oct 2025 19:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v45vz-0004QI-7U
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 19:08:31 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v45vp-0004I4-Kw
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 19:08:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-78118e163e5so1465905b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 16:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759360086; x=1759964886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0NduVUyQ85gtrdIqd/hM2I8IkeDghN4HwH8u8BvlAcc=;
 b=pyDo2ci/ml2TOS59/60NEt2PtbvPQZQ66UlENVZzVnv+iMJ+losL5NvrgGls43rK0g
 DUz5zRuGgjPp3grvPwd/QncvOSnDOX8XXGIXhhfX+6wEVOdxXfBTICEWRwDCCn5SysUz
 04K4vyHkIpQI2JOt+FgDfqpGd1eYfKrB8bapHabKU1BzhBDdHWa09vihzYaFJzkk9RLd
 EEqZYey7oXbN4Bw4fD0+XNBh4AfHhtBpIh4yHdaagQBSGZA0yCJhIHnGVvrJkqMx+N2y
 TIuLuOTMCBaz3prve9JTpy/D9KG13a5KnkgsPsJYjsQAv133/31l7IZ2/sMN/y9Wlq2p
 nhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759360086; x=1759964886;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0NduVUyQ85gtrdIqd/hM2I8IkeDghN4HwH8u8BvlAcc=;
 b=Xyogyp/3i1UoxlDqsWZV11CCA3Nntb6eGPtirKsKv7IHcB+ABvHg3BHgT6AbVLUtbJ
 xx5ra9ykhuz/Gw0MF7lJ4qBwrAMXq8RotffyXupW8ed3HfzZTvsDreY7oCpwtGoKURj5
 bPa/JaKrNa1i0q/wBumh742aA2lhyWEsJAS/FYjjr1Pejp8w/FpYLiXSIP6qq3s/pvnp
 nUBQcITnEYkSAHNVMK/InwWHPDr5huy/kvzUuzoSRoW/zQdMuAesdLmZUSPzFP/doZV8
 8wK9VWxVt6q1lCSGd1Gt3e6hirNH/kqywn9jP2zUeQPERt6RhN3QkyirhCU6XUfWXrS3
 Uz1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4GeKfZ7a3tMgMVMV78TEa9e/Aimr8Glf9djl3hW+w0GjA9kSsaKhdt0Oup2qq6fpogpbl9YSdh7m3@nongnu.org
X-Gm-Message-State: AOJu0YyFYCR7D43omE9OWa77EcXafTc0yEVIJFatgmHhg4dL2UTH6b9X
 cjYAO1gldQQXTL+JHL8E8V6sq/0Q9fDtRqpfrBBmwcK7vSgxpefHtFbjQjzdWphSQLg=
X-Gm-Gg: ASbGnctRndj7M8W3a874xYcqwa6FjTnLSOK9nlC+Op9jn41gq9eyW4e+3uZS8DGgUv9
 J4Z0Rpr6tncFSVtuR33Th+t7//8fOMdaazG8YrUtMa++H7rdwGKJlfMw1hOpLaAtpKgBZUUtNRB
 DGBVI8j0FCwCXiwfkoZWwGSAZLc6KX3wxktscOp6OZ2g+TU120QDa+KKVADpPwmyVq+J0bkF2bk
 ++r9BBdnkckwnbJNw0taOMLmDfa1AgfYt72EseocXxBVkNH9OuQUQVNdCPdR/I02eHtL8iwfdwD
 JOLBx3ainjvSzpREM9kCbyISX741KfIVWyM98Z/vE68bC6bgT/et7xIDxO6aBMBevVmbqH9Wwjh
 G2pnI3SfV4j/V7hnGVcSidO8NbzeImw4e2tNps4wZMlONnr3I7wkihhr5S4Q=
X-Google-Smtp-Source: AGHT+IGg3ZqhSK78RAKzfCQSnMuBzFTdqIP7QoDVXe2GuVM4amd0jtgHILbFhywgin+qBJ+H5PtZbw==
X-Received: by 2002:a17:90b:4d05:b0:32b:7d35:a7e6 with SMTP id
 98e67ed59e1d1-339b50d51e9mr1368341a91.18.1759360086087; 
 Wed, 01 Oct 2025 16:08:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a6ec12fdsm3364723a91.10.2025.10.01.16.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 16:08:05 -0700 (PDT)
Message-ID: <096db5eb-1915-453d-8fd1-fd6d23777a1a@linaro.org>
Date: Wed, 1 Oct 2025 16:08:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/35] wasm: Add Wasm TCG backend based on wasm64
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
 <ba60c570-fff0-4ab8-b3bc-d191663d2912@linaro.org>
 <CAEDrbUYAAbF5g4-HEvqDWZyycPzZQCJvqasJ355RkLOnfm0R3A@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAEDrbUYAAbF5g4-HEvqDWZyycPzZQCJvqasJ355RkLOnfm0R3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/30/25 1:26 AM, Kohei Tokunaga wrote:
> Hi Pierrick,
> 
> Thank you for testing this patch.
> 
>  > * /builddeps/target/include/ffi.h:430:6: error: 'FFI_NATIVE_RAW_API' is
>  > not defined, evaluates to 0 [-Werror,-Wundef]
>  > * various "format specifies type 'long long' but the argument has type
>  > 'long' [-Werror,-Wformat]"
> 
> On my side and also on the GitLab CI, these appear only as warnings and the
> build completes without errors[1]. I'm curious why -Werror is being
> triggered in your build. Have you applied additional configurations that
> enabled -Werror?
> 
> [1] https://gitlab.com/ktock/qemu/-/jobs/11544442966#L7016 <https:// 
> gitlab.com/ktock/qemu/-/jobs/11544442966#L7016>
> 
> Regards,
> Kohei

You're right, I indeed have a local patch forcing werror on my side that 
I forgot I had. Sorry for the noise.

I have been able to build successfully, thanks.

