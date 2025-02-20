Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD83C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1XU-000823-0G; Thu, 20 Feb 2025 03:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl1XR-00081X-Cb
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:04:05 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl1XP-0005Kj-EX
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:04:05 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f2b7ce2e5so313418f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 00:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740038641; x=1740643441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxc3I3KJ4nhtdJiy3WdkftvN3k6H2z+mwMoCNlYxIGk=;
 b=kseRZXpWbzVWBV0cRGWmOrp4uv0OmeaZQVqLApu+wR5EuOws4E24r3obMdvhI4M+UT
 o9uCtMxhRqOkL5ljx2dNXO1bxhpdmjP/1sflOVmWI49Og2dO22JUCpClARbiwCO4N3mk
 dIcV+6y1aahySWQUq4Tlu4KQbCvDr1CODSGXUU2MmwDFtVe5zTgNJ6+qmhIeSpf5h1ag
 NQaeqHICpADTQXrqyyI/S68WYbmWRBsxOZfKV03DebrToIJKJdDE6yqhI9YudUMIAd6d
 KE8OT8VZ8HWzGZ5ERTr0OUdn3v0yhNnzS0jI1+jCqq9AU9BoaqPsikqqbaFvBAzavZzq
 k/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740038641; x=1740643441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxc3I3KJ4nhtdJiy3WdkftvN3k6H2z+mwMoCNlYxIGk=;
 b=Ga3HlKjQrYX/82MvDQLm8fjCNR5Stkn754jkAA/mXAIP7AYnw3Z6GuUJVHOT4nCy6Z
 cHGLUdiWB5WxO7KoyC6T6lMgbdJheWY+8W/KSovepYF9Yxs+tFRynjin0KWsxKGf5Tj1
 K1jmZWmloe7mhpc1Pid5ab6jd5Pc68xg3F+vNWq2DoWTBgX2FprlYyH9h0UM7k0KFTAT
 SSC2AMcTNmxxnqQEpRjzv0O1McxSbw2xp8fDL6MAMaqNpiIAJE1PqC6J6jVhH/PCgZB8
 WfTrRlxvXDJpgUv6grAxol1DN4XwPDmzYZqmd+sR45fTSXJYZuflErZccl5olnS62mQI
 L2hg==
X-Gm-Message-State: AOJu0YwCTVGZdP+2JJ5dP+RqiVenEGYxywUmEegUePojnt++KSfJBAnJ
 imBYsDq5VJnqgyb1OZ5yzSZ8WND84YZA0wXl5mJYKK3Aam4xGfNYHZ6meVv+yanqufpEyUavcfv
 3RL4=
X-Gm-Gg: ASbGncvQ6QrWpWHxDXyCNy0+jIUSa6cPHuFeDPGAwRiuRQC+TCwn2ztYH74ESODGjL/
 xGEHF+lu3Bu5eL0nTL2R5KcR6jM3KPgBjfwGn/3hHhE6f7zwfiKwOjnKV7+xAvLORvRO36Qk/EX
 PHOnRfAB3wjXkQTTSjzMKzFaFb4Ax/+ugFke96oF8bjQFzvkFWo7gc9eM4h5T9TA98vMDyi6Trt
 KeWtbo+W0L+I6htHG3o79yVaqsUgQOhyordJ+AOLXaqV9RGZ13Fykv4zFipkmKVh2M9ci6Y16MS
 4f96u7nhagxfMr0wyZd5AUe/fDAPi6lX7NBZ9rPPNBG2IBbmdQKDdDDnAbQ=
X-Google-Smtp-Source: AGHT+IFcRdEYMj0aVA31qnlXEI9zPnC0rseq9tkBFr76Wxa5b+la9+kgQ/elMARGJG44qUeZgR+IPA==
X-Received: by 2002:a5d:6d09:0:b0:38d:e3e2:27c9 with SMTP id
 ffacd0b85a97d-38f33f37422mr17282017f8f.8.1740038641134; 
 Thu, 20 Feb 2025 00:04:01 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7c7sm236392945e9.27.2025.02.20.00.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 00:04:00 -0800 (PST)
Message-ID: <3390aa1d-2505-414d-afc7-92df46d445c4@linaro.org>
Date: Thu, 20 Feb 2025 09:03:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tests/functional: Introduce the dso_suffix() helper
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250220080215.49165-1-philmd@linaro.org>
 <20250220080215.49165-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250220080215.49165-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 20/2/25 09:02, Philippe Mathieu-Daudé wrote:
> Introduce a helper to get the default shared library
> suffix used on the host.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/functional/qemu_test/__init__.py | 2 +-
>   tests/functional/qemu_test/cmd.py      | 1 -
>   tests/functional/qemu_test/config.py   | 6 ++++++
>   3 files changed, 7 insertions(+), 2 deletions(-)


> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index dc5f422b77d..254e23ef748 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -15,7 +15,6 @@
>   import os
>   import os.path
>   
> -

Oops, Alex, should I respin a v3 removing this change?

>   def which(tool):
>       """ looks up the full path for @tool, returns None if not found
>           or if @tool does not have executable permissions.

