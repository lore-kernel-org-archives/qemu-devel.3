Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB92C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXyR-0007pZ-6M; Thu, 27 Feb 2025 02:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tnXyO-0007l8-61
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:06:20 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tnXyL-0006yb-OR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:06:19 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22349bb8605so10961085ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 23:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740639975; x=1741244775;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nRe8v3Rn5DLBXasq9/655MBvFp7sLercdc8l7HSrS+Q=;
 b=iUBDztddsZj1Y20Myif4cdXjQpbBrCJzzQA7HU3UxRwU3BngHNsM9ikBdsd+gp+pQs
 CsqxmPskbqgM6kG7O5/o2rpzXvklscn9KG67vcjNnYPicUaRWd8OUZePedYdyckWUmB6
 l64XNvp+ye1xUJd6P3Et3qLfmO/fPepGOv8EtebOI5zXBBvte4eRN7o39bbt6wPJ+w5v
 q80nCIG0nED4LAADiO4YmoXMuLos2dfYN4ERgtj+yL3xPmDHXZg95mk5EyctaWzMf2H7
 1wlc5Q8dzQkc3coOf9DpklBdxBbQVaCdFkmpAZq7LPAOzineRH7ihNVQe7PqKLTxhxTn
 fNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740639975; x=1741244775;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nRe8v3Rn5DLBXasq9/655MBvFp7sLercdc8l7HSrS+Q=;
 b=Opo+RgxE0KGMRk5z+Ayu0M7lOhnCylAZ8D91LeX4Y9iex8gb7YatZ3dCqg15/a6VyM
 FD98VK6s77XdQ3A1No8qbOV0v77t2o7luNzxgC6seRA7pst6w7LH9Y8Fjk9VhjyAw/m2
 whaJPtyBbqU/pA8HIOCqMoz8e8irZar0hNAdu95oYVhLYkq14ckodexvV/GtefK94Qd+
 9wXiVP3a1NNY9fPaf+7YvVJI53IPkPU7zQ6uxqAbn8CbiE0AUv3HPTyX7Y/aRXErNGZX
 W2lZ7NZpEYoToqet/ewbTDdsmheP1m3ioNqG8Jb7BHXUb+scf3KPGM00q44RfQOr7R7+
 0ULw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6lHuxyIRdchG7Jy98awVeJktdmOLYVXOgNLUjhKYDzRKN28V0hsTew8fwTNdXjH8NzC/x5R/UKnK5@nongnu.org
X-Gm-Message-State: AOJu0YwDZom/NvvBybi0r3jqLc6fKeHQwE7TcpFhZWC1StolaqZ8BIt9
 e4sPw4Wyo/CoFlurGfoZsqZzPL4dt/2QgjEVfDrb1OHjpmZlee0VYVglCG6h9CA=
X-Gm-Gg: ASbGnctctqJzr5OaL9HAN0L5ag7FV0d7lSY4AMpoBatmvZn1fAJlAkcee8crQMEDiUe
 TfJaZyQjyYtw2ONHAs1F8yFGGiyF49A2zRseigLSqBqhn5taNnj3mffh+ArLmaBWOZOYCdoTgtf
 sBm7JL1YJbXkpZH2QbzqTMy15ptm2I/b4zTJg9Tb2+zmpcSdHpyqqtX9zQ5j2Bz8M0dXfUQvL1X
 09UaOxLjbVuM9wFgqkllkku3lqOX7fUtUl6bPjOiXZIAKRO+Ssh4QHg8TlShK74O3yrqE8C99mx
 rgFvZp+l7yseJXDIDwFbhpdufeV4yl8CHMFIIMU=
X-Google-Smtp-Source: AGHT+IGTvfKaKy2VKTPRTk/nI+i55c30Hoq+TI89iTVXZzMrDlHzf+YH74UIou9CqsbX5nQAbyd/wQ==
X-Received: by 2002:a17:903:198c:b0:223:5645:8e1a with SMTP id
 d9443c01a7336-223564590a4mr9912465ad.51.1740639975293; 
 Wed, 26 Feb 2025 23:06:15 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a005fe68sm796790b3a.174.2025.02.26.23.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 23:06:15 -0800 (PST)
Message-ID: <7c7880f1-fd41-4e49-959d-6bbbb5689348@daynix.com>
Date: Thu, 27 Feb 2025 16:06:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tests/functional: Introduce the dso_suffix() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250220080215.49165-1-philmd@linaro.org>
 <20250220080215.49165-3-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250220080215.49165-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/02/20 17:02, Philippe Mathieu-Daudé wrote:
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
> 
> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> index 5c972843a6d..45f7befa374 100644
> --- a/tests/functional/qemu_test/__init__.py
> +++ b/tests/functional/qemu_test/__init__.py
> @@ -7,7 +7,7 @@
>   
>   
>   from .asset import Asset
> -from .config import BUILD_DIR
> +from .config import BUILD_DIR, dso_suffix
>   from .cmd import is_readable_executable_file, \
>       interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
>       exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index dc5f422b77d..254e23ef748 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -15,7 +15,6 @@
>   import os
>   import os.path
>   
> -
>   def which(tool):
>       """ looks up the full path for @tool, returns None if not found
>           or if @tool does not have executable permissions.
> diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qemu_test/config.py
> index edd75b7fd06..0eab1baa541 100644
> --- a/tests/functional/qemu_test/config.py
> +++ b/tests/functional/qemu_test/config.py
> @@ -13,6 +13,7 @@
>   
>   import os
>   from pathlib import Path
> +import platform
>   
>   
>   def _source_dir():
> @@ -34,3 +35,8 @@ def _build_dir():
>       raise Exception("Cannot identify build dir, set QEMU_BUILD_ROOT")
>   
>   BUILD_DIR = _build_dir()
> +
> +def dso_suffix():
> +    '''Return the dynamic libraries suffix for the current platform'''
> +    DSO_SUFFIXES = { 'Linux': 'so', 'Darwin': 'dylib', 'Windows': 'dll' }> +    return DSO_SUFFIXES[platform.system()]

It may be too late to comment, but:
I'm a bit worried that this can break tests on platforms (BSDs?) not 
listed here though I don't know if plugin tests work on BSDs in the 
first place.

