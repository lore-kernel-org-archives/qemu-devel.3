Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A37E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrLO-0003xx-86; Wed, 18 Dec 2024 05:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNrL5-0003vk-Oe
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:31:40 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNrL1-0002EL-OH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:31:35 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38637614567so2903407f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734517889; x=1735122689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=suMzsYfpJ7bQ9Gz8dz5wY/qUas2Fx4gujlq02QwbgzY=;
 b=J8sPo6PgZc/qYp4y0XwsoAuo2DJOxA6Goff03Cbx0/9Wy/ANpg5bArwjOFh+/U8/80
 Sie1px5tHVxPfWdWjp748mWHQ2shwtTyp4zyh22kZcvW4jcpmeACYIaxOFGtr2coXetW
 QF5Fxv1qOuhJzw506sKqYvU3JSahL/P6GvBjgwotjHSL8WFHUhdvf75iYxx3BLVfz+W0
 Kcf//2A7JQJqjAp58WIhQOBIIpXDvMZRPQ4X6qjgQWvF3zio7CQomnbjFLxZfdECP4AA
 FRbvDq1jERbL4v543n2Xcjs4cJJoguE9w/5OiuyhY719TFiCtnlySdrp2UfVKsdTBvW3
 QaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734517889; x=1735122689;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=suMzsYfpJ7bQ9Gz8dz5wY/qUas2Fx4gujlq02QwbgzY=;
 b=sgeR/rBZIYBYhE3SSJmT1Rn4dkISvADD+LH+bu27rdo7VAhmWvdypgNJ6qMglkXMz5
 IdADVOAh6XavIWm5Dd3qrfEHCfr74cpv4zqQ6iepk866pVrbwC0tzE1mtIvXTc+1RsX9
 7xepT62gcG4EhJSw7Nqw68Xxp+ZU5oh2AByOTU+LOtVeKV7Yfsp2ahKu3rDYDglMmdZl
 byXcyPTku7bvZenK1xwiaalUQD7RKIXfq9sYpFFEBczY2NetSu+MvQ5J10fjxjZfcSbW
 LPiFkshHIpt10ui7Q32kyP9i/f6/rTNQw0H+Fl18LMlc85xySzPr0WoWH07GWBNMIybJ
 itGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/RSijt3OgJ8YH2hZWXRW4Vnqj7w99x6PFTVjd+rC/QQmEVluBrWsp4LikM5Mz8bpWtzwIl9oU7U5X@nongnu.org
X-Gm-Message-State: AOJu0YxKxU9VAn4eTypKeBs+vNHiPo186StmZfKID+U8bNnoQTN/t5pR
 HADBn7SeU3r/RelsqSvC8fgNNcQ6UXr2tP72BZyl2rf5p5W0H8iY0dVr/kkUzrY=
X-Gm-Gg: ASbGncun3UrElRnGgz4COwNmq6f80OuBeqHEi/T3HVjn55UPRUoOatx4pg06rR8mRcP
 CMhdIegA3uXp6J7tN5UU+OZGZ2qqBJ1P8qwIyXjcreemMUpJEvYKK/jWAQ+B5noHWu2IFdqt5ku
 h7U9ljEVfe4VnMrsTmrlBZr65AGjqo8/wVq6ZcAhYPynLzFYcjFD3JCZ+AIolGlL+EXl9KEmR6M
 3XgUCis4eStq0TZS1cLGF/An0yMqA/jCz0srEqQCkSI6+AcsXdXgxW5F1HGUvdXlNZOcSL5
X-Google-Smtp-Source: AGHT+IEnd/G4wv5VkMuPoMD0SLT3/c9br3sPkDmKwTam8i+f4gUPvF0Rl3QBwLLlrFGDsMwwjcLUQQ==
X-Received: by 2002:a5d:6d02:0:b0:385:f38e:c0c3 with SMTP id
 ffacd0b85a97d-388e4d2dddamr1685720f8f.6.1734517889149; 
 Wed, 18 Dec 2024 02:31:29 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801617bsm13557616f8f.39.2024.12.18.02.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:31:28 -0800 (PST)
Message-ID: <c278d12c-19ac-4806-934f-fe0fa0095730@linaro.org>
Date: Wed, 18 Dec 2024 11:31:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: Disallow libnfs v6 to fix the broken macOS
 build
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Lieven <pl@dlhnet.de>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20241218065157.209020-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218065157.209020-1-thuth@redhat.com>
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

On 18/12/24 07:51, Thomas Huth wrote:
> The macOS build in our CI is currently broken since homebrew
> updated libnfs to version 6 - and that version apparently comes
> with a big API breakage. Disallow that version for now to get the
> broken CI job working again. Once somebody had enough time to
> adapt our code in block/nfs.c, we can revert this change again.

Correct. Maybe mention:

"v5.0.3 is the final release of the old API." [*]

[*] https://github.com/sahlberg/libnfs/commit/4379837

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 85f7485473..6149b50db2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1145,7 +1145,7 @@ endif
>   
>   libnfs = not_found
>   if not get_option('libnfs').auto() or have_block
> -  libnfs = dependency('libnfs', version: '>=1.9.3',
> +  libnfs = dependency('libnfs', version: ['>=1.9.3', '<6.0.0'],
>                         required: get_option('libnfs'),
>                         method: 'pkg-config')
>   endif

Per https://github.com/sahlberg/libnfs/commit/976a9ae we'll
need to check for LIBNFS_API_V2 and adapt API calls...

