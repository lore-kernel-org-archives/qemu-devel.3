Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E128AEE6459
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 15:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vayI2-0004Iq-Nk; Wed, 31 Dec 2025 10:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vayI1-0004I1-CB
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 10:39:09 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vayHy-0006vx-4s
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 10:39:08 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso97728995e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Dec 2025 07:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767195544; x=1767800344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0iSNmST3qYJBcKtJAfZ4M4cPjncPLsMNOX9yQg/XRlI=;
 b=VPEjsiXLKaflZqjaRyBGkaIFiG3KXCJ/4S2ZhDDgs10KfHlL1lA9yp36LjaSYC7J4o
 e7AFq6qYN1r4nnVYH38l5eMyDyLeLiTWfg93p5hRTOILUDuGOwckA1yaMMyRIweiMct1
 5wD84Q/1Pz0wAuwHmtmpyoCKm+ESwxcXB5pR8DgYA7r0Mgdg+/HAxoj0biUXVLpqPwl2
 c3n3VnUI8sAOjZFq1VBpV8dmCXDsjIuPIN4IG83nZ31cd6RR9bkN82nwgRk+tglYum8M
 tuXqTH8Unxedrgnf2H3YZLsZ1Y2uMpfNGg04k6JGZ4iEMDU+e+7uNI2CObs53Wu2RSSx
 R7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767195544; x=1767800344;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0iSNmST3qYJBcKtJAfZ4M4cPjncPLsMNOX9yQg/XRlI=;
 b=OxnRjZm8YsJRnftU9NeRCxQ4PklfVseeB4DMnKFpe+QGDlLGezzChUpvIsgO+w7iDF
 68LXDnjgmCOQNzq22dRLVoa/efu5QZOd0mh3PZFXtTPUUghL6xn208G15NILAupe+Mkz
 9jw2pvd78RM0rFqQcR225h0yTwXo/xzBbllBqJRiE+Bxyby08Z7jA3FwZJiS+8KmToYE
 Qyl7PLsGwzgGik2zOWxWmRtiE4O8I/GjqAQKpZt55ZljA5szgZTufjcRnufXOgPAsbkR
 cCA6bQTWITX511RoCAt714psXG4QzAGKDeJhbJUxrGgicm+VvKFaJx4CD+DYg6DN/8H0
 KQfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIC3s7gLYZ+kSx34BH7TdS2+4R5GhmyBTMIQROs+MMLLlT6LSvcE3QZYaEBUzmUrHEEX2En5Cn8MXf@nongnu.org
X-Gm-Message-State: AOJu0YyJWwnAp0XNl/H6LxjfddJLWJmcjHXZX6acbeYChHt/m8bkT8CC
 wzGrF8pKaaBG7bSNpJqInfsnzM9TSkyyezJXNgBBAPxOmmxQPHhUOfRJqtx2F0zWYxkryqa54Tt
 2LARy5ys=
X-Gm-Gg: AY/fxX7g64Nydr912ubDRiJnxwnVXZvSr1ftc4b1sn2DNz85FS/epKeTZNaLGbZAoV/
 zdR4uRioNQzsNlfk8aaLCt8KkrgLYQjzjcKQydg/QjvanL7BClElCFMaez1LWeftxxop+Osndfx
 ypVyMrb36AVXonFS83pBUILCN+eWCDsJXJWBqFI4tPkPuxuQTrCYSxVN/iJhTmoSh9YMd79eFvm
 VgDjmAZExAa0094OhgusICH5tCmBZrLyo8XvMRN3Pxt8vf/PwhskDZIvEyUkhmzCozVMgB3JYL4
 Zwk/fxaVKVUnK7JdHM3fXQ1PtrCw8jSY7Vw8pODXvS1uvtjspkV9Dye5tWKeTo2jhOfA+wC2FV+
 Y0r7B/hanYQ9jb7fmRL3HO/mGmnHDycHiZgZR6hQcl280MxEevwH3GRMgi1fhpYw6/0S7mMwr4D
 lvXbZ7IRL24RjU2aBZORyEYxmkjnKiXN7dN/2nOwDTNMMd4TWigJTPVQ16OQ==
X-Google-Smtp-Source: AGHT+IFBpmqaIOQ+7TvHIqbWz+OVvQenR2wtL8QyOlXIua4egKRV+DMGGAhwpUo7MmUKcPCUENUYtQ==
X-Received: by 2002:a05:600c:468b:b0:477:b734:8c52 with SMTP id
 5b1f17b1804b1-47d195670b9mr406259335e9.14.1767195544441; 
 Wed, 31 Dec 2025 07:39:04 -0800 (PST)
Received: from [10.33.60.66] (91.red-95-127-39.staticip.rima-tde.net.
 [95.127.39.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4e91sm632713985e9.13.2025.12.31.07.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Dec 2025 07:39:03 -0800 (PST)
Message-ID: <22dbbb83-af26-49c1-9e55-49eee497fec2@linaro.org>
Date: Wed, 31 Dec 2025 16:39:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] contrib/plugins: add empty cpp plugin
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
 <20251231073401.2097765-12-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251231073401.2097765-12-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 31/12/25 08:34, Pierrick Bouvier wrote:
> This plugin makes sure we can compile in C++ while including qemu-plugin
> header. It includes all C++ standard headers, up to C++23 standard,
> minus the ones that are missing in the oldest environments we need to
> build for.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/cpp.cpp     | 119 ++++++++++++++++++++++++++++++++++++
>   contrib/plugins/meson.build |   4 ++
>   2 files changed, 123 insertions(+)
>   create mode 100644 contrib/plugins/cpp.cpp

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


