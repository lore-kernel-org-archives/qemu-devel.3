Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09B2F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6mj-0008ES-II; Tue, 24 Feb 2026 23:46:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6mc-0008DN-5K
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:46:00 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6ma-0008Qj-Qg
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:45:57 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-798374d0f44so7355227b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771994756; x=1772599556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AyipU4OmPeui2N0CWDqKa9srG/l4ukP3kBQTNtLYz8I=;
 b=Go5/oOB+YehHyMp3/r8CURwrpm8B91c2yy83B9BZjzFyz4glMPvIX0jcm7NYlgHLTD
 2cVO9RbeluMfBkslaqQ/JNx/EAd+2YGdf0GhMaSf/TIHy2v6Gbw7WQ18NZQyLV64IdAX
 iY6o44yBKhCo6cggsNBmlPxNJ3Tf216pojcoQJnmI0iFVPSnui8Z76BhzBDVrxBXDFZ5
 kNcLq0KeqN39xh5teIs9+KIHW9LeLwBIIrgrp1vvg+7Xt7OxnKTXVF9SFuG6cQXDw7Bs
 E3JoIL4YA/sS1X1nNP+OWiRdYDAvCS78UUvcKhjH4DoYhm64Ka9PFC/8alZLqkdE3PG5
 /jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771994756; x=1772599556;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AyipU4OmPeui2N0CWDqKa9srG/l4ukP3kBQTNtLYz8I=;
 b=oOKcDMa+iKy5nCKuxkb1CtZDVjqJ2f/N7EyU/DysFoYYtWRxYQVeW9uaePpjZAnR7o
 afiIkC4KNuUtTxeUcIDUvjehxTafoT4Thw063DzqjsoEXFmEc6ipMilV2Cihl5Ygbvgc
 Q78BkSznmlwn5GOd+9Ra1zM70kVQcprFqxNhR4OXlMkifyf/JR4C7SOAY0K0Line8ZDP
 ZzZToxiE0V5cxjpqpKZYkEvTjL4iSL7XWajnhfz3OFT/E3VInXe8MjKrZtI4gsUTGCT5
 HwXv7dP2I6Rv9bMOqzFOBnilcoS8lmdIslQysFGN5s7C4P8g5aK711HsD/RK4uEUpXS2
 C+MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYFq4LrW3iyVrI1VfZmuYq0xAV1jU/H0tJGwWCxQDDanO5BQN/9lbde23y/lXUvo5iPSZN2BErhJvw@nongnu.org
X-Gm-Message-State: AOJu0YxXe6rCqXc6V6kDvBIYbxiqwbZjALsnqECzhk6FfHqNk2YcV2HW
 gteQQPbHqINfluUnzw5fOf3EkyDc88MTPp5eqylD7v4OPk9K5YRKsDhF5fh3gBKnb1E=
X-Gm-Gg: ATEYQzwU1OH6mNAbmwHVDheRTquBVevwA4S1j4vjV3tuTs6B16j6kyB7brOXYvklWSA
 vBtAhRrVw0+jJvNpoc2IFNotig39nEe7FzycMLnOQDZG+GTYReDG3UqUafYYh5vZqKvDPViDxJM
 ACJ/vdIXbrfq+PoRA7908LHHArRUMzLbwu7LY4YQl5df8qTUoG/9ZVnveOzDD8GHL5PZv7g12Jr
 m49c/Wq6ef4drDEpPibudk/cnZqEE1kW6+6bPCGaG7lUYo62113sc1RS8Q93wvo7OO6WUy/9Yzh
 P4exr+Yfu5VyVSkCWzEQJ3+NZBgojNvp8nnejkclB7ySGFslr7rbKSS3XnkF9Xe8dHOjp+3Ah+t
 YbgTv8cGHiY2Mh3K39CvEwok+NRFxhI2cSUZQpPHb5MO+pHYykR+ZVU/fnrRJm7A5IEHoNJDQbN
 8AUMgDtYGEUheOon13L3mU2/tYF1hE+vGHGedToKxSfZEZup6Tcsx7Wq3j9BY3a7YsBMbm8qJLW
 aqt6okPdUzE/QPUVq8=
X-Received: by 2002:a05:690c:9a85:b0:796:3f8a:9607 with SMTP id
 00721157ae682-79865094422mr23378667b3.30.1771994755701; 
 Tue, 24 Feb 2026 20:45:55 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7982ddccc24sm52341097b3.40.2026.02.24.20.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:45:55 -0800 (PST)
Message-ID: <2e9125f8-b764-4397-9b55-d18cb0806cd5@linaro.org>
Date: Wed, 25 Feb 2026 15:45:47 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel: Build stubs once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260225044225.64059-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225044225.64059-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1134.google.com
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

On 2/25/26 15:42, Philippe Mathieu-Daudé wrote:
> Move stubs to the global stub_ss[] source set. These files
> are now built once for all binaries, instead of one time
> per system binary.
> 
> Inspired-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   meson.build             |  2 +-
>   accel/stubs/meson.build | 19 +++++++++----------
>   2 files changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

