Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2FBC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvIu-0003WS-T6; Wed, 03 Jul 2024 04:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvIt-0003W9-Oe
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:25:28 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvIr-0005F5-Op
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:25:27 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52ce6c8db7bso7884562e87.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719995122; x=1720599922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y3607kfF/10a/THtRDGcXlnXhiR42W28Wwhe5ND7m/w=;
 b=P4CgImYS6c9rmpDXZf4AUPjd95pxNlpnkPIz+vNkE+c07c5pzrrglSTMM7VGZmGzVc
 i8KTIaZnDp7dvG3c3tJDVk4w5CESo38Lmr3SxC/Wqk2SoPO7+HjV5ImTsnBcWTJjMAKG
 kZoNGhxn+AxTNh0d3v3RefwzTlfZDjtD6n12o6vn1zHYYmC/M5ODptCCwJBNhB+EOA9E
 2KwwaymRYTnjd7jvMv7I3J084abcsErH9tZ8fjUxzIxHYF+m53KxNtPl/vYTuA2WpVxE
 viT8WUvMvHeA8BOerXhvMuDA4z3PmPZC+/a9LO9lqARvpzDc6DuCKGons/jpZzZ+QHB0
 tpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719995122; x=1720599922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3607kfF/10a/THtRDGcXlnXhiR42W28Wwhe5ND7m/w=;
 b=NHs66ph83+lY6fzQk9jMDbAgDV3jn6F3YdDs3Ha6JJwOCW+jmyFvdTljWwGu9BlFjo
 uPQrkY6yErHlu7wz39a/yxa+rp9jOrPmc0Oql4eoIHUnmg9bHF5FnjU87dHYAC04hRlM
 PzKoA2TQkgF7c6Rbw8VpvJttCnfJU11PhtlA99wn04iikc3jlZU+9zD6inlgn0sWe50L
 b2zeH+ho01dEBAJzIs5xaVW9AbvEPvCA326nqyttA+MA0O9Sj9B9jPJK1gFzf6jWDfam
 1koBw/riiPvfeXxaDubBvQduURaacqH8yHa03sm7vmvVi5i1xJ90W8XXhFAXOLLw39RC
 O8qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmmLPKbsjbUkgwXu3jQrGl+ZS2uGs3bvBPKaCz91+kP51LPmlyZpZGfBNKPPgaelSTkDq0+px+cDZwR5QIWPGy29wpPVo=
X-Gm-Message-State: AOJu0YzuWhgAf241Lzzi+0G2nu5Yj8v8XyAuDk9nFZVDCDm7u+LULyU3
 aGT1bGmrHbIFV3eWrdZvhymB4l6jU6H1/7jJXpCvyeebxLadwSpsvIX7aUew+vs=
X-Google-Smtp-Source: AGHT+IFimwdy9nk6iLz9KadfX09zUX6tFmb13oE7xBQz7GvjCSomQAmlvWY2zZKObUnFn5UK3O0yXQ==
X-Received: by 2002:a05:6512:104c:b0:52c:dc4a:fb14 with SMTP id
 2adb3069b0e04-52e826522c3mr6919040e87.14.1719995122056; 
 Wed, 03 Jul 2024 01:25:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e12fcsm15190163f8f.48.2024.07.03.01.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:25:21 -0700 (PDT)
Message-ID: <94406082-299f-4159-bfc2-a5c295f39a2d@linaro.org>
Date: Wed, 3 Jul 2024 10:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/22] qga: move linux disk/cpu stats command impls to
 commands-linux.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613150127.1361931-6-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613150127.1361931-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 13/6/24 17:01, Daniel P. Berrangé wrote:
> The qmp_guest_{diskstats,cpustats} command impls in
> commands-posix.c are surrounded by '#ifdef __linux__' so should
> instead live in commands-linux.c
> 
> This also removes a "#ifdef CONFIG_LINUX" that was nested inside
> a "#ifdef __linux__".
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/commands-linux.c | 195 ++++++++++++++++++++++++++++++++++++++++++
>   qga/commands-posix.c | 199 -------------------------------------------
>   2 files changed, 195 insertions(+), 199 deletions(-)

Easy to review using 'git-diff --color-moved=dimmed-zebra'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


