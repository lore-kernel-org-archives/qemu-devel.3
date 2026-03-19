Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A68F109190D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3IGv-0007ZW-6k; Thu, 19 Mar 2026 14:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IGr-0007Y9-SU
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:39:02 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IGp-00053S-1I
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:39:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso5082845e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773945537; x=1774550337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=slcgkeJZREcUKWH++EuYw/DPyXGfiXE9691tTklhLGg=;
 b=hRskFM2QT/FZuT+3/lJZS7geXqoAhJmQueVpJRkCAeuXiXUDiAXtx5WiIO/t0V/Cr4
 tnexHpaJMsDLVgg+rGQYbGhK0TLhGn04ircj5dO7E0Ze9DVfyx7bR/fspmeMplmibQb/
 o6EakMg+t2Dgxo2si4pfUrqfe9V+X4H0fvCw3Vw2FPfFKXI8o/3kbdTbek37ScoNa2N0
 y+Ppvj7teOJwFTFR3kDAP+3/lxPjiKf0FR95/LO23SxOloBX/jfhiM6WqNa8AUPKXuBW
 KQeYeNQvoUPI739uMRJ9FTyhHXqtga5XrviNd1Kew7x1UC6O1gMPKEYicXRvBWB46L26
 Tqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773945537; x=1774550337;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=slcgkeJZREcUKWH++EuYw/DPyXGfiXE9691tTklhLGg=;
 b=WBxb6dhZ11evy9S0Ms1rDoSa5K6OOOsJQcjCDgixb7dNBQShJ/8D4JNKtmhy3u0mtI
 W9zlJPAbxdnAGLRdXN79pYeVbSOR6TzGfVNxuqI3Cju5uzjaslBNiZM9hV0ULY2mbYZO
 cibqQ7+3eBbyIRC+tk3LvTq1IUOqlkOvJ6h/1IeaK+/j8VSHB3IwECmiKSA2a4BIa2ed
 sGCk4zDtBQv2xR21p80Tz4eGhFCcHI75/0qyIMHSUAwxnXjr1qZOMSlQRUfTKvKlmFud
 dfcu10ScfSaJW3XANZJMqc3LYmw5EaTe7iHhpqhAxqsILaMZgFFbUlWvX1kAYz1rFGyz
 nU6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKxSbM4fAoVA7FljPWFclRhX04cWeIgtxR3DFsp8b8AMfGTDQDkApIFI07Nf8XXd099Dk1v9/Goki8@nongnu.org
X-Gm-Message-State: AOJu0YzjRl5f93wXgJGTJ2TJdglGpgVCbmXRAI+0xC2sY4w3QSaAwltn
 bz2khdWDsWP8pb9XvByz0AlD464WnYjaUE8HbOzKft3lZEh6PlCvoZRua7qD6gdnFHQ=
X-Gm-Gg: ATEYQzwdB08LzRQfpnS0yE5U8HYKglIkyi/lVs/J2fe2aFE/TgBnJcXteb5T3e+I1dZ
 MQWv+1nwvnMp0L+z/o3lKAn8jJO4kt8drlIfJ1PvrlXRUbFNIglpzZe8j2BeYfpBdNf0/tAgxgS
 v3/nZ+PnOx2XvaaZtjSOx0945CKTkZBvl2vCP0K/7zA6rqVT0rHYHIylpWidQz3edSOHHWqBUCw
 wCwxCMZ5O/wsppV3pLyJeGw6lTW9RUsPAD9n59FFrEM471PW8WwxXkmIaKyog8J3Xrk+FVBEFEm
 jjOgZUhuxd3HImR6qUWv9sEQ3NV+IrXR3enbC7aua72OZ/4FS30pix3MU8ccu54vbXPLXsfklQQ
 8Sb3WPbgu4ZTSwMPfh3QwZtoxd9ZKhHuTILO24Ze+tM8LxljsvIAzzRu4TxSzFCcZS4YZ/u/GmO
 QJaKLI9moz8rc+JUkX0oT1fG0lYnpzPz2g4WrQfw0FHG/1Sg==
X-Received: by 2002:a05:600c:8b61:b0:485:3471:cffb with SMTP id
 5b1f17b1804b1-486fedd8164mr2461675e9.15.1773945536940; 
 Thu, 19 Mar 2026 11:38:56 -0700 (PDT)
Received: from [192.168.69.206] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe897fc2sm1645515e9.11.2026.03.19.11.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 11:38:55 -0700 (PDT)
Message-ID: <29365fee-2f5a-4118-be69-55198de91e55@linaro.org>
Date: Thu, 19 Mar 2026 19:38:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0] Fix several typos in documentation (found by
 codespell)
Content-Language: en-US
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20260319183453.100545-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260319183453.100545-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 19/3/26 19:34, Stefan Weil via wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> 
> These typos are part of the generated documentation.
> Therefore they should be fixed in the new release.
> 
> More typos can be found in the remaining code, mostly in comments.
> 
> Regards,
> Stefan
> 
> ---
>   contrib/plugins/traps.c        | 2 +-
>   docs/about/emulation.rst       | 2 +-
>   docs/devel/code-provenance.rst | 4 ++--
>   docs/system/tls.rst            | 8 ++++----
>   hw/arm/virt.c                  | 2 +-
>   include/hw/arm/virt.h          | 2 +-
>   include/plugins/qemu-plugin.h  | 2 +-
>   qapi/block-core.json           | 6 +++---
>   qapi/job.json                  | 2 +-
>   qapi/uefi.json                 | 2 +-
>   qemu-options.hx                | 4 ++--
>   11 files changed, 18 insertions(+), 18 deletions(-)


> diff --git a/qapi/job.json b/qapi/job.json
> index 0a301fc094..31618e6ebc 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json
> @@ -196,7 +196,7 @@
>   # the device to write to the target path only.  Note that drive
>   # mirroring includes `drive-mirror`, `blockdev-mirror` and
>   # `block-commit` job (only in case of "active commit", when the node
> -# being commited is used by the guest).  The ability to complete is
> +# being committed is used by the guest).  The ability to complete is
>   # signaled with a `BLOCK_JOB_READY` event.
>   #
>   # This command completes an active background block operation
> diff --git a/qapi/uefi.json b/qapi/uefi.json
> index a206c2e953..86f33b234b 100644
> --- a/qapi/uefi.json
> +++ b/qapi/uefi.json
> @@ -18,7 +18,7 @@
>   ##
>   # @UefiVariable:
>   #
> -# UEFI Variable.  Check the UEFI specifification for more detailed
> +# UEFI Variable.  Check the UEFI specification for more detailed
>   # information on the fields.

Sad to see fifi go :(

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


