Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7A2EF070A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 04:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpJBO-0006Lm-AM; Sun, 08 Feb 2026 23:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJBL-0006LV-Pd
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 23:47:31 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJBK-00036o-4P
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 23:47:31 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3545d66bb3aso1107754a91.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 20:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770612448; x=1771217248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NHLA6Hqg45QzbYXkoElyh3EI5vF5e2eXE1LTa/vpB0A=;
 b=g56aOZTQ6qZafj2IlZp9y/NJ+dfCEeeCsxaHatZnX0xxynwBuqfIcwHoniN4TuotaT
 +XdX8ToMHr6OsyuHs3yaXwWfbGxOjXCH19wsRRwDkjseNDHl58kESmLswLgTcSjL51XL
 aC9sGd0X5eb1+jS/dZMjxm/Cvp8fSCLVXea+y5lE5fJUuDETGsiRMw1Dsk5pEyrEWz+h
 mfukWNMswsw0uRQiW9J1LLOIYNd6anlVse26E5hxOkPZ2o4rjuPZWGx4OYaEgIiNukQ7
 uL8BV4oZSwvrDQrqm1O/klTncuYwsbWqd2aftpYpBduWR0KMAu46Quy5Gj47vb76HLKn
 mL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770612448; x=1771217248;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NHLA6Hqg45QzbYXkoElyh3EI5vF5e2eXE1LTa/vpB0A=;
 b=TCm8QY6A3J1Yb10vpR0rissx/b9Y80g8ZPrfEDOtUgSh+Je5LPkOgd/8KyQkewmY0a
 oJRmzKahQvqVC3mQ0dzT3C7QJFRUC0w9jh+ZYlc0ChFlsejLi/A9YPp6mIo0huvbQfDc
 Wv3d/NC8tXIiHTyJEPXQum/dT2AvLrP9kHgIiEZBN2WmftWmFaZpz5sx/wDQ0tjaqZcX
 zOA+T9aoVe1ZpxWNO8E3N2YW6/+EjKL91vVubNgJzFgRWXpLZJXWaHTk8SFtZZgkiRWQ
 BYZC/rx24VFC7ug7xQAwTK4dBofa3NGqg8UOBa04GQDXE/rpOWeoI3wcz4mAs5ZM/aPd
 5Y2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUreEvJwx8Pji0b3zdaNtxanOgtSr9aDXWwBR7Dw1Mwvi8hrkU1cToYx2bGR3dgJfQHp//c3CSVUdoD@nongnu.org
X-Gm-Message-State: AOJu0Yws6k4b9qdpVLUbtNrqkmtvOntV6ZtCuoOdsOaP0EfoIae0zgsl
 JldvPFGfRpMaFbOeQ7KlmCg6PLuIjCmNovoqvjQMwnbZGybS6lkfVb+ECJiqcVVGnUU=
X-Gm-Gg: AZuq6aLf5Utro8Fi1dcr86iCIw9XRw+lxiv9Scw9u/u1cITxQXbdBz2kk1Kcm4FIJsj
 szvRYvPpNlp/paJHp47m4cEzFSA0K939qGAHqZlXp0Tzhatw+krojoUdG/B8j9nfeIBpc8xqVMw
 7OLbeZq0qTHz308n3zc7+bMAMTaCPWhCmi0ECM1AFTMsowMmky8/J3tT3YWTFw15WI9vgCA09Yz
 bShyTzR98NnHW/47FhaPJ8C+lhLNf33RgWUbTtPAHnkediwdM4pb/0bW/Z2wDTqcbHuWs04yn1H
 KUc51C/9uUBMzPuximUOJmp2m0ZLbU92lZn5d3hZMOPFZ6WYStbyxJREQ22OEY0G1DdCmtQuhoI
 d21SfNw6nPKT6OBnDmYQJCgwIaeWOIwxB3JAmqj0jPqtIXI/JVhd02D2TaxaFqR5ko8mfwKDsEF
 FlxFQRXpHnMoYHa6X66PmyukOAYtbV3ve2EvS3Nlms+Gh7W2t+JeXC/m6DcsI8WaD/pW7mlnJuf
 A==
X-Received: by 2002:a17:90b:3a4b:b0:32e:528c:60ee with SMTP id
 98e67ed59e1d1-354b3e2ee5fmr8093143a91.24.1770612448322; 
 Sun, 08 Feb 2026 20:47:28 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b1f49186sm8805732a91.5.2026.02.08.20.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 20:47:27 -0800 (PST)
Message-ID: <41c8406a-235d-4ec4-bee1-2a798f12f433@linaro.org>
Date: Mon, 9 Feb 2026 14:47:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] target/arm: extract helper-mve.h from helper.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
 <20260206042150.912578-3-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260206042150.912578-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/6/26 14:21, Pierrick Bouvier wrote:
> A few points to mention:
> - We mix helper prototypes and gen_helper definitions in a single header
> for convenience and to avoid headers boilerplate.
> - We rename existing tcg/helper-mve.h to helper-mve-defs.h to avoid
> conflict when including helper-mve.h.
> - We move mve helper_info definitions to tcg/mve_helper.c
> 
> We'll repeat the same for other helpers.
> This allow to get rid of TARGET_AARCH64 in target/arm/helper.h.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper-mve.h                            | 14 ++++++++++++++
>   target/arm/helper.h                                |  2 --
>   target/arm/tcg/{helper-mve.h => helper-mve-defs.h} |  0
>   target/arm/tcg/mve_helper.c                        |  4 ++++
>   target/arm/tcg/translate-mve.c                     |  1 +
>   target/arm/tcg/translate.c                         |  1 +
>   6 files changed, 20 insertions(+), 2 deletions(-)
>   create mode 100644 target/arm/helper-mve.h
>   rename target/arm/tcg/{helper-mve.h => helper-mve-defs.h} (100%)

  Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

