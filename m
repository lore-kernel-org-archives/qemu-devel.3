Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB83C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 05:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFnoc-00069O-6t; Fri, 16 May 2025 01:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnoa-00069D-6g
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:41:00 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnoV-0002ve-Dt
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:40:58 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-74068f95d9fso1552386b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 22:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747374053; x=1747978853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nDcZjwUukkoB7sHWbC1y8j+40Igx7lKhn/oBmgj1SYA=;
 b=KfO9HIB7rcnPIA585p9Zy1/9RB1YtQmuUWxs7sGYVZzgI42VqxrWDReOLYNuAbnNkt
 /DY/+ic6CLUGClYOzS1JMG7n+u7iesm2rN6wNW9dbfbHkC2p56osoys4dTQs70tbHWl3
 ER8ELbX5FJdpyLCIEJDbdUigvvAFcWgKbmq0627xxQLYCovUMDGawmiOLQ/M/RSIZ51t
 UuMJ8/t/kY0L+b+MdZ76mZJ5iITXEiDePNq4Meru9hwb6Nq4pmJ/S6L2nfYDLKmm99tE
 ggPUyOy/d/wv1pUhgI8Z37hlgG6VuqCaoSDfLskvm2KEgKc0g8amFuqrH4O/KceCMMWr
 KMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747374053; x=1747978853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nDcZjwUukkoB7sHWbC1y8j+40Igx7lKhn/oBmgj1SYA=;
 b=s77wdqI18TTMlJkbHX1VqLo57hpkCZhkUM1dE279htTYSTBD+IPE8CZ5O/TUmyU6/Y
 4sEEcOwreDmdl/MGevp3L5umjkYsx0OldxfaUs3RpB9azc2TxIYcoYHCjl277wSV35w2
 ItO1Qq8TJSY0448/WE14opqXpM8up23KwyQ8BhF8YY4KDrsQ1xuHkNJFpLJ0rAimGhGb
 sau2so2wDvPnBI7E4fkrzpaVqxrjWYt821TcSX8ZziKvTDK++lKJE5aZwSfhuL+HOMcT
 NKuywcFYM0Ttx9bhbdJ/1p0+eWT28cHbnGK5WN9w1WfZTROAebm8aMC3A1vwbHnMlqRT
 Fb1A==
X-Gm-Message-State: AOJu0YwydFniF0HhxGlGkbbqsSnb5+ctgEYdbWnPSR15Itxje2BnPF4G
 6NyM9YxcvcAUdzOSstbW6y9gdM8ypAGWHzBcziko35NrSgniDH7gNVqRnfD2FC+w7VuS+pYdvvW
 xeQ3D
X-Gm-Gg: ASbGncswnrrnJmhXAcK8tkjn7wZFLICWi1T41nb/u+nGxJE0haQL/odv/z/OJ1jrX9b
 c+ppL1TS+s0/76mp4RgF+FXPCAeX2S8pQuE8ACMtpPTbYuK9qZPNQ0cd+WzIOe71qPMFTPge9Oi
 FZ1AD91pKVSwHvPfJVx/Qh6qr5wgRGXaoMPLqtpNmiWUMQM9c7/eu7riJlfm/HNlQ3b7FZFIyYv
 gM0pItVLHoRaFPzDwI+Kr4W6NhP0JlnGuc1/L1hXIFPgemvMODMq6zKoQux3sNjypI9gHDhN6zz
 C1FqQ5tb+AVpdqcmP5u/2mnUaIpgGNTnNsFk6tMa/Fr7wI7NPerHgNGmY5SiXheK
X-Google-Smtp-Source: AGHT+IH3s9Sr6NPsiRUIqoGdOXPJ/sUC9wSo5fQmaHliycifi8iJazralhvAIFuhe7r4Fw8pAzRbSQ==
X-Received: by 2002:a05:6a00:3c83:b0:72d:3b2e:fef9 with SMTP id
 d2e1a72fcca58-742acd72449mr1674191b3a.20.1747374052708; 
 Thu, 15 May 2025 22:40:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96df5f5sm783357b3a.13.2025.05.15.22.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 22:40:52 -0700 (PDT)
Message-ID: <53d00c4a-6fd4-4822-8533-626d94bee0bb@linaro.org>
Date: Thu, 15 May 2025 22:40:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] single-binary: build target common libraries with
 dependencies
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/15/25 10:27 PM, Pierrick Bouvier wrote:
> Recently, common libraries per target base architecture were introduced in order
> to compile those files only once. However, it was missing common dependencies
> (which include external libraries), so it failed to build on some hosts.
> 
> This series fixes this, inspired by Thomas fix [1], and applied to other
> libraries introduced very recently with [2].
> 
> As well, we do further cleanup by removing lib{system, user} source sets that
> were recently introduced, by merging them in system/user libraries, thus
> simplifying the work on single-binary.
> 
> This series was built on {linux, macos, windows} x {x86_64, aarch64} and
> freebsd on x86_64. Fully tested on linux x {x86_64, aarch64}.
> In addition to that, it was checked that compilation units compiled per binary
> stayed the same, and that their size was identical.
> 
> [1] https://lore.kernel.org/qemu-devel/20250513115637.184940-1-thuth@redhat.com/
> [2] https://gitlab.com/qemu-project/qemu/-/commit/b2bb3f3576e5dc99218607dde09e25ac0e55693c
> 
> Pierrick Bouvier (6):
>    meson: build target libraries with common dependencies
>    hw/arm: remove explicit dependencies listed
>    target/arm: remove explicit dependencies listed
>    meson: apply target config for picking files from lib{system, user}
>    meson: merge lib{system, user}_ss with {system, user}_ss.
>    meson: remove lib{system, user}_ss aliases
> 
>   meson.build            | 65 +++++++++++++++++++++++++++---------------
>   accel/tcg/meson.build  |  8 +++---
>   gdbstub/meson.build    |  4 +--
>   hw/arm/meson.build     |  4 +--
>   hw/core/meson.build    |  4 +--
>   plugins/meson.build    |  4 +--
>   system/meson.build     |  2 +-
>   target/arm/meson.build |  2 +-
>   tcg/meson.build        |  4 +--
>   9 files changed, 58 insertions(+), 39 deletions(-)
> 

As well, openbsd build works with:

make vm-build-openbsd J=4 TARGET_LIST=aarch64-softmmu

(thanks for the command Thomas)

