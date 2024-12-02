Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04564E69E90
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 20:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tICjl-0003zn-O9; Mon, 02 Dec 2024 15:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tICji-0003zW-48
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:09:38 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tICjg-0004xI-IJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:09:37 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee990ba9d5so1491690a91.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 12:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733170175; x=1733774975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0uCaoz+owZcxrH4lSiRSvwy7ZK0/4LayKovoJZvtrTs=;
 b=jaWZ/YG/ZLy6+AueyEwDDTkS0GRmPSauFyXLKvZhY1p5fOe8MpPCcYUJa+W7WVb+qU
 3e8xn6eBl40PHDoImFOuWHlG+XP+2vLBiBOfdx4pnl7hlnrSCsQAcRbq5uzG/DoHPy0G
 7Uccgf7kDDbkBne2wb3H5/3Ttx9UVDWI/K4nu9djRi5Ru2d2nvzeLF/lQXnYp8tRNkZ4
 dil8BS1wqn09FMHpSIAVaeDgOKhqeXTkaQU3PJZ9vm3MCwHt3fe/tCTZHAoTSm2vinLZ
 SN2pBNjVBOZUlaxRta9Hg4Fc7uT8LiW0waQrXCs7s/A3TSghztwWGxaa1kMPjxBw0g8K
 4vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733170175; x=1733774975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0uCaoz+owZcxrH4lSiRSvwy7ZK0/4LayKovoJZvtrTs=;
 b=BEbyFVnId/IHd6lF/3oZidNvaHafBj63kYxHgEAtNE+67tNoa8c8E2RXug5VqdQY2D
 fk+ruzwCjZRSXsRpa6ArXfWkPOS+i6Heo3tOTTmJMRnlCUJJqx1UGvS1UvXlofk5tVMn
 usW7V7PoHeEfnWwXyVwcxz7XkJzED8ri5LFLRvQWAibF2s9aXvv1zK+2507TBMfPPQND
 10JVWrScW1iBtae1nJl0KByxLmctVrZ4rpIk/PwDEjA4N0V73TmOMQuXveq749zSmbBW
 m/PvnGIQz8tuZZDPXh6sRAQo86IupSPLyQ4wU5pi7JFl6d5wcNcwCmznTtDpEyTvtQG9
 PbLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFXfAXvlvuH0PXTrLz308BCZC/mY1rmB0rpdjVs+Bq04AG+6W7vHyFVRnnsn2GhEkBx33vjq3KgTM/@nongnu.org
X-Gm-Message-State: AOJu0Yzr278BXUUPPoG8sj6PfsDBGHJe84EMcAmltSH+Ufykoeyo6jvE
 +8ytIRRiCVPIx1CYd5bY0h07l8EFMvgCMKHEBL7Q6f93LZjXiCPocg2wJeMAcSU=
X-Gm-Gg: ASbGncvsSUcic8wVbYQAzehoCxvIdSsKzvFO9MBzCVS7Y+ZKB4+fa8hdDTwAr5e2tTR
 z+GPAVD2R3257H1gAaiTsAN+N335E1uikt8O+872J5QUQ8zDiXjWxav+XeR+R6nZzk4H7LchLD4
 PBQt83r6JXHxfb+ChaEADkvlcSnkEcLISVPpmDCoQflMGl0rZ3BFin8uDn11EgzyILsDBOD9w8W
 i7fU+VQpYnHfWdRaS3WJhJPd7qPZCRrVd0tfCz8HPW/0JXW4fN9U6oMUBgdNErzwlsV6Bt0D+3R
 XpY1EGQcqjVo6cfMT66mUg==
X-Google-Smtp-Source: AGHT+IELy2r6StoU9KnaZdSIz5VSm335hm6epIOMbdT9KUwOypXhbZwTsHO29wV9p6nq/eski9rzEw==
X-Received: by 2002:a17:90b:350f:b0:2ee:c9b6:c26a with SMTP id
 98e67ed59e1d1-2eec9b6c52bmr6940952a91.11.1733170174896; 
 Mon, 02 Dec 2024 12:09:34 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee36170536sm8141802a91.28.2024.12.02.12.09.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 12:09:34 -0800 (PST)
Message-ID: <b16724af-0758-41b0-afdf-8a6eb138dd64@linaro.org>
Date: Mon, 2 Dec 2024 12:09:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <CAFEAcA-xa1AKf2GAv7go5wdu+Td=4jf7Nriin-Oe3S6qEV6X0g@mail.gmail.com>
 <fd7ad48e-1e72-4735-8064-7039eedc00ae@linaro.org>
 <87ser6c5be.fsf@draig.linaro.org>
 <a26e2a3d-d915-4e84-9b8e-dd5935049f31@linaro.org>
 <CAFEAcA9q7advmbws+xx6Mgcg-=072tBfdRReSSqymYz6p9zENg@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA9q7advmbws+xx6Mgcg-=072tBfdRReSSqymYz6p9zENg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 12/2/24 11:56, Peter Maydell wrote:
> On Mon, 2 Dec 2024 at 18:36, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>> Maybe our enable-debug should produced optimized builds by default, and
>> we could have a new --enable-debug-unopt for the "I need to use a
>> debugger" use case. Would save a lot of time for devs, and in CI where
>> minutes are precious.
> 
> The whole point of --enable-debug is "I might need to use a debugger"
> (or a sanitizer, or anything else where you care about debug info).
> If you want the optimized builds, that's the default.
> 

It seems like we associate debug info to "I might need to use a 
debugger". But, it's not the only use case.
Sanitizers for example, are usable with optimizations enabled as well 
(with some caveats, as some errors might be optimized out).

I don't have anything against what --enable-debug does, but supporting 
this for tests (and CI) because people *might* use it is a mistake IMHO.
It's an opinion beyond the current series use case.

It takes more time for devs and CI to run tests with debug build, 
compared to recompile and run test suites. And we hit timeouts and lose 
minutes because of that.

> thanks
> -- PMM


