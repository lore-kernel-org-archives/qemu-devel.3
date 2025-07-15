Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76099C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfw8-0003Lq-DB; Tue, 15 Jul 2025 09:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubfYB-0006Uk-VO
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:18:34 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubfY9-0007mp-Ij
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:18:27 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-73a4c557d47so2543851a34.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752585503; x=1753190303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5oZs3c10mgjmfE/TIOMRE408h4HSJUbhWoVweCJQRL8=;
 b=kcZyvqKx/q02o5Tu2aWI8D4gBm7/02zW6urdYk9CpX0n6zli/fjHslr5sGy7xIWkL1
 gcR9jw2Y0R6UZV6Neh2mibONLFmiBOW84YKDg7QvXHIrSFmHd6mGtKUjJ+0AMHyWchVh
 6hu4H21Cxv9de6Xtoeb7dCOgNeC0OdQ21Ng7blgEG0aKff01CZcXAkk1hT0LNtCM6Aa+
 TzFs1lDt8yNsZO5ali8CL7RDZg7MSkYi8/2gT718n3fyBQxh7EqQISFVfWOSsrX3JZOX
 9MUppUJEomxflaZmlDqfC5Cnn6jEguo4RXRSZ1wiULpsVCepgH6qGSh5FqB1QfFYtutc
 xkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752585503; x=1753190303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5oZs3c10mgjmfE/TIOMRE408h4HSJUbhWoVweCJQRL8=;
 b=BTEb0G0IBKOLihHzAsTFJmPwN4eiT486+7ZwqDotmlBJC9Umk/R7lRwTUib/DTy2RH
 n95g4fmAQ1Mzq6ipGFty43f0ADrric/R3OmRhd5BqTPip/u6xHOsfU4AavUWHfncBUkB
 mNxdYBt8uTOMO7bVlLCErhxpqjEEPn174In2sT2dmR0Gv2l6o3zTv+jWXGtF94Bi7EEi
 8guP8pJFt75aAK+CtKBd9GUHHmjX0bDJw7eP7LY8ZYt9rm179TjwXpcclmNblkT5nwF/
 3r8X/8ytmG5XtfQTSvZ22kKqBZq/GgPPRStKGk1JWY/TJ30sAljnZc4IvEapzhIRxt/j
 qv5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoBQYNpPAVqPbvOig2+/hcpv1ERe2X74ZxrUpQlVwwF+MiLU+1HhQ6hdMqpKFog3HkHihvrTGcSLrW@nongnu.org
X-Gm-Message-State: AOJu0Yw8Q89RxZTPb7RGFzFwUjeFbtJCqQJHvQT3cCgiRMZUompxnvXe
 ie+LVdI0/dcUEALO7af161qJXkP6P5K0xxRqF2bv/O2JWKaODA/NOmC1tiNte4V+jro=
X-Gm-Gg: ASbGncsOsAX5mn1wVNfUTBwDgdcxmxGppluiEwwJqc/Yqlp86BXcI1YtbMShZP2X/S9
 w17AclXr5+uaj5cazzaMSkWD9t8inOGdLnaXrWGoAHlot6Kbl8IhQCRy6q77cxWIgrLRuXBVeOU
 jhwA3f1ih2qTs0YLrnw1M2hyv5FuhJ91pRSCGi1U8ptKExNU1suzFfarlhfdxvZ2DCHX68cYF0I
 +vT7TV8AyVHtHmH2XADvXfHSMq0wK1y7ScOwyM5B7o/trM1JHsxWMTYiI7WrhoE6VIZEqy1kfWA
 B+0H6QBusUYQUOBMppOE5dmzFaNm45+bPjX/1LwH3bixxVBLSUU3lx7d79baH6c/CZ6zpBmdmXz
 UtRq1hO8MnjNWYU5MSGxWKwqKR8ElSYlwvvzxjkUwrbLJ+wptOxmlzhGQtVYoYlOOTC9m6yUAJr
 lA
X-Google-Smtp-Source: AGHT+IHBfpdnEqxAXAZ1s8j+ziNQVcYikba+tQCYqVABezNBzgw2pF7ovUVwtjAyc3MXe4UBQ8MpkA==
X-Received: by 2002:a05:6830:6316:b0:731:e7e8:b6ce with SMTP id
 46e09a7af769-73cf9f2e62amr12282861a34.19.1752585503512; 
 Tue, 15 Jul 2025 06:18:23 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf10aa35esm2127894a34.27.2025.07.15.06.18.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 06:18:23 -0700 (PDT)
Message-ID: <6b484004-3f7d-4a2e-b40e-a0a448a8d665@linaro.org>
Date: Tue, 15 Jul 2025 07:18:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v5 2/7] accel/tcg: Extract statistic related code
 to tcg-stats.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20250715104015.72663-1-philmd@linaro.org>
 <20250715104015.72663-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250715104015.72663-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

On 7/15/25 04:40, Philippe Mathieu-Daudé wrote:
> Statistic code is not specific to system emulation (except
> cross-page checks) and can be used to analyze user-mode binaries.
> Extract statistic related code to its own file: tcg-stats.c,
> keeping the original LGPL-2.1-or-later license tag.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Zhao Liu<zhao1.liu@intel.com>
> ---
>   accel/tcg/monitor.c   | 201 ---------------------------------------
>   accel/tcg/tcg-stats.c | 215 ++++++++++++++++++++++++++++++++++++++++++
>   accel/tcg/meson.build |   1 +
>   3 files changed, 216 insertions(+), 201 deletions(-)
>   create mode 100644 accel/tcg/tcg-stats.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

