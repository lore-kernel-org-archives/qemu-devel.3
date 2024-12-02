Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091C5E69E8E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 20:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tICju-00041S-Vc; Mon, 02 Dec 2024 15:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tICjq-00040i-Fh
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:09:46 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tICjo-0004yv-Lx
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:09:46 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7fcdb53d849so652665a12.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 12:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733170182; x=1733774982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0uCaoz+owZcxrH4lSiRSvwy7ZK0/4LayKovoJZvtrTs=;
 b=EYOPvfwmumoM+VlXf++Uro2g22DyiiPp5sQvg8IlBP981EW2kY1l79n2Miq4nRp5vl
 eLhMYeFyuLIA567Um9XKH/elOqzmoslGNNb5Ip2jlzQbb0n6GjwEMTnnYJgrDnNgVKRg
 ANiv8uoTfTdVIYHUJdsz25+EvdMhsKwG33POp36u6LTpLQLaYpCO3vnJCHuflN+AYoML
 TaB8fH7C4V0m+vW1SVkytG0AjZRo2fcvwnt5Lu3qzhrnCUJzU6giyLnOmwngMlqinPs3
 u4nBsrskHpAiZ5kW+3FFyqGwThTbO9GYPt0wenWYjmfPoPLsI56kbUggPjdyTNEq7rTZ
 9K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733170182; x=1733774982;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0uCaoz+owZcxrH4lSiRSvwy7ZK0/4LayKovoJZvtrTs=;
 b=INipXYAJl3v+MttZvGTA2biWeksY0b7E/ZiE+pBDRzQZ3bw9WkpJQ3bbIqVMDwHDoi
 zyngBEU7Ih4BwajpPxMNVt7x+61A727WLoZKkQpiTUs1IyuzI8icATUamqZfGUCbyOif
 OLohH4fd6BA9TXiXW7zBwEWpUsIVx2DL+wuUIBnbtcyzgscF5dgE0nd9sZ6lOx9EMwzj
 4vdqcfBCnaAtX+FqjdBAGRUCBNqXMpRMf+nZT0CzUeurGfvw10kCrvmtmBRvNf5QcXSH
 3hW3ioS/C1FyPxxu4ggGQBnK9qZYvZpniXRNmNoT3/nkk6hr4+w90KahqeMZVxybQ/B7
 gR8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM42ZdMOfz9VXVgQFvMNC0fg2BbTH388eEltQnM7LJiN9V9q1EuFr5CoDwvWod/kFAaQOobeSypbBP@nongnu.org
X-Gm-Message-State: AOJu0YzP91jZ3dv8GC/QcjC6G3h3lR5j12rLLfKsQVcJHXe8RjVkLMkR
 +YkD4/qeZQzY2h8QUBvgatL5Y9pobLOlrlJt0qOAw5fxrjV5TZYF3Q6mZCXmrDU=
X-Gm-Gg: ASbGncs3dYD7hfLEWKrw6Vgw1kT0tG7UskA3eBiktMdoCSVc4loKiaEWfm2Ky25ZFa7
 s0OJvuziOWLWSpd0xJLNZZrchdnTNj0bFUV6EqD8gfbiIZxTzHbBF4nf1cRWMT/jO10bQpvWpG3
 ow+tqeftRFaS/mIrosRSX/kO3KXhoSISLZlF08RT7ZKM06Dn2XUgvVFPs5YMvrF1Jiz7kN9J+3O
 Ab8d5KJvxbb9O42iFsddr/VtywOOAOMKxHYCkvkACjlgGr9NUsMwb1qvqkY7zNsi/BCIsSkgof8
 HU2VSc9Z2VXJ13n1bnP3Dw==
X-Google-Smtp-Source: AGHT+IEVjQ/wUGASyXtZJZ4KgANHmE0K1EEKCV5ky326QolfK9hhZRSLxfajMC8DV8MVthSO3IaNYQ==
X-Received: by 2002:a05:6a21:3291:b0:1e0:dde9:f383 with SMTP id
 adf61e73a8af0-1e0e0ac69eamr40650963637.4.1733170182544; 
 Mon, 02 Dec 2024 12:09:42 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fc9c311eafsm7185611a12.43.2024.12.02.12.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 12:09:42 -0800 (PST)
Message-ID: <ecffacf0-1dbd-4931-b1db-db3718332fcf@linaro.org>
Date: Mon, 2 Dec 2024 12:09:41 -0800
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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


