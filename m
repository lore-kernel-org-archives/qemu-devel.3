Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB6ED6ACCE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 09:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWA20-0000T7-8b; Thu, 18 Dec 2025 04:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWA1o-0000RQ-Fn
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 04:10:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWA1m-00024d-4p
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 04:10:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso4252105e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 01:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766049028; x=1766653828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7pH7brnT+CzZmvv2n6j1rb27nN/IVphYMBfxRRxp3SM=;
 b=xBssIbqo80zHsDvuvhrZRMgCvwIoyUiNFmtS3+WIl0fxVPcwiKrbPD8SFGeA4xxgNC
 7UDA5gJw7sScGDN3Zt9fKEkwmNHh0pxcCewHTdUQHZALnQnuj7mhR7nJoxxac0AMrak2
 a1Mk46IC8PbtJA8t0OqVltX+LG3ZwGg+++HTsiIIacoh6s+YUf7/jhwEUZm89SB62DFD
 ceS8gTpBpEAmxQc1cQWSH4WUQ5uVX1Ub3Ac2XBPvihuno+0Ec1V5xtIzCOjpeQqxXHKk
 Hpg1oey38ZwIaeJHF+UsQcV6ZoPJX2XGL4t6GPaE4GtE+PaP1cBFop2nsEoZ/JrgEaDu
 gfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766049028; x=1766653828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7pH7brnT+CzZmvv2n6j1rb27nN/IVphYMBfxRRxp3SM=;
 b=HW+c+yNMZnWSoY6fZPTWS6PNZckfca3J0OKnuRAHDGw/jEVmipEM9AZ6fWymIol7na
 XSvDM/uCEX/ow6CXSHVmJsRAmEX/XXbdom+4ISm9qc7LUS3ahHFrNMxoeYocQoQyp8Fk
 MNGFjDaQMRb+/XJDtxjJCLcrS5qeC2F4kxhj5Nu/hkjAAlWaXKqUSq41WnawDGS475+z
 kB3wzJuRp9nBc2cHTaHmeupX/xTuzK0zGQrTi3fKq1cdMNKrKEYgZdUqS4PLZVlj4V2A
 xukSEXvQOwSDo5gQkhUD1tPG0GhXzCk0/4pakern2ghjOdCLY5Lne7gKBIbnaDvAZ9Y2
 frkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV88sFG40DGN33Rdc7eXHkv2RZgk2+tkVMeVFMKIg6JawN+yb0Q/y8yapSzEsdKx5T1tNMipNcOJ7+N@nongnu.org
X-Gm-Message-State: AOJu0YzigykQ9VL+kwsZYC96I3YohiMyna50i8bWNqe2RYdgAiAefpkX
 tJyjFnyqUFJrdYphu5sp+K04aB60O8OMpHegYRh8B939f6yFDWFp5GPTPw4Bm31H0ug=
X-Gm-Gg: AY/fxX5Pa8/lKUsa3NJ2PlnD3bH6oiIXJ+titprVqWsI92cVSmKZdKPDsj8NCaVkZYQ
 23x7upyQkOfSTR8sAuVoveCIgvkK2m4ynzfmwPhQoQjDqIAzq4vA8tKAoZZ/gnWsZkepptM/rf3
 TVsenijn0lrKtm3ov68Bk0efLnqwW/yw1TB5QMY1KtseYFWyL+O/abic8HzN/zBKpbiyoQwdtzU
 P4mejkDcAEuqibwj+P2e5Qzmq8OCzzeViy5Euz6tICDFv2OmSXQJouUy+XMP34+TvHF46s4+hyK
 YdLf8u/m+bVF1Hk0l6P3Q5nxXI8KTYbBA7ZTvxb5XODZPjCSGOMJFJYW0Skbxjw1TwJ+3jAFO8i
 SqF4jtHrnx77CaY7diEYs4btmWKwRU5O9fL1lLNUQaJIngbiSlIvN4g5wbWnIf3yCf2TpUPcJkP
 Vl0LYjCw4bZHLvFY/KRqWTDDbe8LVEl4xdr6arGOWq926e3/ZoFFIScQ==
X-Google-Smtp-Source: AGHT+IHehX5oVoPcicS/DAwiuWukDvFW4dsn+1jd4UUnfI53Y8/DdK1WomASH3Usg7vi/LeiK6XO+g==
X-Received: by 2002:a05:600c:1c1a:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-47a8f89b8b5mr243653095e9.8.1766049027791; 
 Thu, 18 Dec 2025 01:10:27 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324498f8fcsm3889726f8f.24.2025.12.18.01.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 01:10:27 -0800 (PST)
Message-ID: <f88bab79-1524-44d4-9b3f-137011cd5476@linaro.org>
Date: Thu, 18 Dec 2025 10:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] util: Move qemu_ftruncate64 from
 block/file-win32.c to oslib-win32.c
Content-Language: en-US
To: phind.uet@gmail.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20251218085446.462827-1-phind.uet@gmail.com>
 <20251218085446.462827-3-phind.uet@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251218085446.462827-3-phind.uet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 18/12/25 09:54, phind.uet@gmail.com wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> qemu_ftruncate64() is a general-purpose utility function that may be
> used outside of the block layer. Move it to util/oslib-win32.c where
> other Windows-specific utility functions reside.
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>   block/file-win32.c | 32 --------------------------------
>   util/oslib-win32.c | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+), 32 deletions(-)

If not change, please keep the previous tags so we don't have
to review again and again the same patch:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Regards,

Phil.

