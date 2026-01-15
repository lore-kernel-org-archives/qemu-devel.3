Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3387ED4662F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 22:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgVO4-0004l3-1Z; Thu, 15 Jan 2026 17:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgVNY-0004iY-Qq
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 16:59:47 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgVNW-0006l8-Sm
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 16:59:44 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so8609335e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 13:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768514380; x=1769119180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LSamhGQvngleve3YRFRZ+HCMddKF98Rae/+IXwDlVQQ=;
 b=xDVbr9haLLCW9sL1PIsWoY5tc47s9zi2LegtpCltUJ3E8Y/5Nqva2ZpAoy8DJwrd++
 6p8YeWM7mRXU9a5MQ4+2RwHKZ3MjPpp32MGNVHVqJDdMmqVNZzgfa5bR+fBeSFy5RjVa
 SexJIMtbJvsKX5HNvT7YZRKXBaJwaH6muc4mu/JTM2N3WDKIf06EKhcFdSzXL53/IO1v
 4fxel+3X/WWCNchEUcLBSLIv7XOITH/huepQBRK/P+QCmNr8DwuKzl7fkOMtUvXAcyju
 AIIMi2ft64tjc3iU5ZHysB0BfoTzfLikJqsXoYax48h3koL1t0ENuy2901JEHMvwpq4V
 g37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768514380; x=1769119180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LSamhGQvngleve3YRFRZ+HCMddKF98Rae/+IXwDlVQQ=;
 b=ruzjTY4aOixzhTWIWmvdbHwifU0doh+H7XkmjVV+yIKVQo23MS3vh/vYY3J623aiCH
 Z9a3WwjZLu5kPcHKzgIHFYL98PQ2bifmQ0bEM7w05mYejHT2h22/agtdYsipuQdxHLfy
 YtjJxOlCCdqHffvxDLgiMMt8iPsb5Fp05rsBZw/TVIXc3oTlLkwBfaGIVGcULRuArmRK
 XMORUcLVTn4Iy6zbbivkSn0CQD4RP9wdokYZKOJUuhgBrJtv6SpkzJ6YmuhP2Bd5W9Cj
 JdYZ4R3yhMzgl21w/MAWjQajeCURyFWnV8NfkmbpwW3bA6gbPPxqa5i8tuFEWtCHrFYm
 WONA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfQC1GDNhtd8E2RFmm4B6gnGZicRWiuLpTdQs4jD/6rFRPuBU7QQvTPuZrBZhHrRispMLW05LhpSJi@nongnu.org
X-Gm-Message-State: AOJu0YzFHcooUeE/1c1roWh01tQQ3dwTt7onggtlSUzzTYpYZd9qTAwx
 Pmx4Rmj7PP2Q8x878mUroqASxr+j8u3yZxe/rau/+i5fshbxh7YBzXToLkafl5Z6bUg=
X-Gm-Gg: AY/fxX5EB4WkZWYm2f2C/HTAVwjI8mAfJijnYaXz6Rx2AD9bm7j2xq15an+4dgAhCz0
 tG0vXxTr1B2dfV/vRrzzIAXgKmgA8IWDUrz9MznVQf9NxU4KXOxIOuUo1Fcd3xmXhU0wtatFfgY
 HzZz/CDoarA4vNh2R9KLh4g3PZF8VFSn/zbYYXb2MIZTB9TuTrLogjtNX0vdnkhhVYmm+D89ghy
 A3gxaFDx2eJCt4iX9UpWqkW32190AaUouL5oIZt8Oz+WB3+/U+s3ViyaPDCpzUW/avzE6TLO5yE
 Gk6mJGWaH/so1w4hniiiADI+R2+GwiDP12bS9a8j4G7bvrrOOHSPw9o8OfIOX0fyjMt2UkUTowJ
 N/qT/qTAqu/0fjBFWHhY1yMWKSPtZr5MX49UqWnmMzFBvqgW+2m4WI+iG1Gp8G4bLz3FgpPOcYg
 uOIcH5DQG5jTyTJ8LJQNsaA9fSiCOyX1jCPvggRsi3kwREiONsSIGitOnNOtjaKwVQ
X-Received: by 2002:a05:600c:1d0a:b0:480:1bbc:30df with SMTP id
 5b1f17b1804b1-4801e33c1cbmr11633425e9.23.1768514380211; 
 Thu, 15 Jan 2026 13:59:40 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe6d9a7sm2008115e9.17.2026.01.15.13.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 13:59:39 -0800 (PST)
Message-ID: <d848e36c-848e-4d3f-9b43-dbd14b1bbee6@linaro.org>
Date: Thu, 15 Jan 2026 22:59:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] wasm: Enable 64bit guests on TCI using wasm64
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1768308374.git.ktokunaga.mail@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1768308374.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi,

On 13/1/26 14:54, Kohei Tokunaga wrote:

> Kohei Tokunaga (4):
>    meson: Add wasm64 support to the --cpu flag
>    configure: Enable to propagate -sMEMORY64 flag to Emscripten
>    dockerfiles: Add support for wasm64 to the wasm Dockerfile
>    .gitlab-ci.d: Add build tests for wasm64

Out of curiosity, since the series is fully reviewed, who is
going to merge it, Paolo or Richard?


