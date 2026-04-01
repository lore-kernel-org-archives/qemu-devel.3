Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673F2D35162
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7raH-0005ai-0u; Wed, 01 Apr 2026 05:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7raC-0005Zq-BE
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:09:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7ra9-0003NE-NZ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:09:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso65114305e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775034588; x=1775639388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3evvW8FxjJktOYEhkBoPuvmQDFhoNR9tWIZDpScjZjE=;
 b=h7CYPXxZgR2CcBg3cCk8MqqBxwOmI60Qu6vYjWb9T86t+9DrLYfAWAUQ6sJXucdRQt
 jgDDK0EI5Ut49fkoxLjdrUfVeeUKNFdCGx88YVZbK1AFdR82jeBiQF0wi9RY2i7QCXzp
 B7sAZWiIw2FAZLMNXYe0gT+b/SodIIUL6Lih42NqeeK/XMOQlH26J8u/pXHuhC7iMLlV
 56hiZiopQVEUSMeln/3jflqv7M1Je9+A6ZXfrvEDW3ez+OlbpdKgLR6ePKBEYU/QDuXw
 ihFpqG08HpncSkoAFu0pEwnQFSCFKHDP7ssMSVZ3+s0d3PX9EBNSh2IOVKfF1PmufPqe
 m3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775034588; x=1775639388;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3evvW8FxjJktOYEhkBoPuvmQDFhoNR9tWIZDpScjZjE=;
 b=LNAcYVz26nX0gJ7wkCT3HMf2NaaCF7kHjGCuSi38YVLQyqH3dKkn+4u/nrWSCrETLc
 mIDrz7NExIMnljIEt36TRJ8pqF39xiNM1+WF/VA/P12wuHpnFkuA9voA31DXvc8OJ79i
 lRwcRU7a5mnGybQ+sAq//499Z8KrDp/SHue20FsRi6VIgjOflYdNzgbdG9vMuUmdsqyk
 tGXvAGt0yW4s7mX/VpDuvrlfxCJ0QBQBuPkgfoBv6iXC+uTreEz0ViMUHPWoBrnuzskf
 7Sed9piFfngb05sUzRq7L7jWEsnXlQowMkU20ZQAzaiswiky2oHol+SIA2FllHAHphMD
 QgGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/eEIHDJuEzy1monPPSe8iMJOl6LHeKBQF53jH1x6uDoItIt//0xRE8jFyyLp+HsjdKfKULYmuDqAx@nongnu.org
X-Gm-Message-State: AOJu0Yzry+IX/f4URiv4M24wkQcrwSmJy7S+q90Kh7gyUAxQVlnSezK+
 E6n/U88f3akpqO6y6lvm10+uetnCg+j/BI35ooMv4XM6CzEuZLNP168/dRObcWq8mZA=
X-Gm-Gg: ATEYQzwKVVvrdUoksZ4EyBP8x+gUkL3NY7fjxG97/xaoXGyWys0ReH80NVQHaRaEjT3
 qSQhRNOqfS5QuUVt431jgwTaauMZaZa7EdH5pPUcsjcCaY1JXua5GGSVrv0hCObEPeVjRV1lMHH
 u3n5iud5yUKSlnWnaA8ZliLhm1oIFiZ6AFJwLdfTn3hf7B5JJkcPOV7A2cMV6ySBpxooT51TR9N
 Orw3S4LuLED1wZyvkzvlntTHHdOUe+b6y3NRXKV/hFkr4p9UI06oVPbly/hLThGmofihg63MzdB
 sDyAll69rdg11TriUz0PaxosePbVvXKMYakNxrZelUak/pZwn9kG+Br7ikpKk2vnQhlKifZOCUO
 6MI6qGmadK0AJTzv4kd9h2JsiK+mYIp/KhQOoIMQ/wXAbFk+0hKlyR4H1o5t5bpgYsFdZDA82ZG
 F5lZ+0V4kgAYaZNtpPu00XsFBq6Fhum4ffZWaLDXSw7j/1I/OBNO7UrCuN9y6+pAJ9Ng==
X-Received: by 2002:a05:600c:c0c7:b0:487:1108:48af with SMTP id
 5b1f17b1804b1-4888355e7a7mr32652515e9.4.1775034587851; 
 Wed, 01 Apr 2026 02:09:47 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e9e18sm32078659f8f.9.2026.04.01.02.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:09:47 -0700 (PDT)
Message-ID: <d8f7baef-09c6-4739-9eed-168bc1a6d15d@linaro.org>
Date: Wed, 1 Apr 2026 11:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/60] ui/console-vc: set vt100 associated pixman image
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-16-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-16-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> Start removing dependency on DisplaySurface for vt100 handling.
> 
> Note that before, the rendering is done on the current DisplaySurface.
> It's not obvious the QemuTextConsole associated surface isn't changed
> over time, in particular if it was doing resize. But
> qemu_console_resize() is only implemented for QemuGraphicConsole.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 54 +++++++++++++++++++++++++-----------------------------
>   1 file changed, 25 insertions(+), 29 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

