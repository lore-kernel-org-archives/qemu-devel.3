Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33875D35163
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7s3g-0005C1-9A; Wed, 01 Apr 2026 05:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7s3d-0005BX-Py
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:40:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7s3c-0007bi-7y
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:40:17 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486fe655187so87138105e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036414; x=1775641214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GQPgIL8h39SzjAIulbdr6RAYnnPRy6iAJiU5keRwMLU=;
 b=Sc1xXd249hsKzvs259zrLZF+7iC9BMUWRj2HvAOxsdeRYa/MG64KAjIFJ//fRoVS45
 DnzQIfHPx8wJH08e4kdNk6n4HJZAedh5BWyQCQWIbok+JmK29jnU7beQ6snA9+Go1Jkz
 kOcuudK28gqjSorsxNPTBPRUC39pKLJDdO1c2j2nWorT+vG7oZi5y92GX00aqk2nWZ5w
 vflWh5bQWnLUoJSh/plYQOc1KtukElfJLHM7BzWoLiDd891U6Ig7PNw9rMDdaD/Omozo
 QFpl2iXh0EcYfFFmH+M339Qbf8IXfhzjc020W3GOQhNLNhWE82uRsuMXJiLHMko8De+r
 1zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036414; x=1775641214;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GQPgIL8h39SzjAIulbdr6RAYnnPRy6iAJiU5keRwMLU=;
 b=l5YwVzyx5UhQW7kevaHzImuvsEJmdRwEotRf1KtY9o+lq0aDbT2tgmM47m/ne0CesH
 KR5PZOHw8mF3pn6qRjY1i8liGuzwb0u397hKtYArV1UlxP6Jr7/LmAIi7g8kJH3zOHTb
 Pv5q+ZlC9f0yxAZ2Og48t54+6Pog/hX47Ow3DND1PRyfKIacYtu3buu3nVrKBezIxxNV
 jrkJU2U0+S2k0kgr4v5C1Mplel0OpuqS4NKI8RZJ329jBrLPZhvxUxF2GU190pBd32zo
 1qQrz1A+1pXqL5CffZSRUHAbKdouNZgBMnS09zxFwJ8L4IBqXc1GDk7qDiqyNFevfHs6
 Z+FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw4M519WRhOlYJDGtZg7tFq8kbGsS+WAPf0VH1N0bzQNPXffDWp+cUHUb4oxswHw/rZAXVEb7YTDL3@nongnu.org
X-Gm-Message-State: AOJu0YzMW6T9KpuhcKWiPerZSUBMV3sOaBRwa491O7qpyydF17myqfY+
 7KPMW2QwOsmT0+UfEH9ydkJ9u2EMdPM67AEaizo6sBPliAcsQb8uC/sf2MOJzwq9z9k=
X-Gm-Gg: ATEYQzwDCRCTLI1Ux1S8wuNurF1XnxGJn8FrKR/ld4AaCowea1AgCk7pFn3MfBmqY69
 i7HXPLs2JVrTGGfva8opHVhrQ1XiG/UFmWjop/KzhFpnU0c3H/0yWJ+KrniB89Aq4f7XqDtXcfc
 JDxvEM0XH3mPrSQfS6pj0uM5jbovUSRSFU9ESAtE0lcqAsmGddi+7EHfLLDveCJ1M3Ii1OQQk5X
 Tw1rMwHyAKoOHfNhcizS2sJ2pUvEryVoOaI5oCR/fVryFzUhA3HmVHvaKqWwYG9Obi5bQ5i2G0g
 eqC8LcDIQNVuKyCqudWwuH/wm4bl1fQF0nbLQmMGihGHmk6crW+qdw5sL4DKslNO1LrB+wk12zq
 RqrXxj4gz1fcsD7Emnn2FQsV0EP/Nx0HCUyOU05XhLaLfpOE4ycw1nS2whjIClunrU/zdd92sJ0
 5lAyoKkAIqQ+WxKOWUg6i0HLqupbXEZMswYyEbKi8SPb33OsQD7xEfwd/eyvbudQSd9X+xzCo/f
 /17
X-Received: by 2002:a05:600c:3b12:b0:485:3a27:a960 with SMTP id
 5b1f17b1804b1-48883303263mr44348205e9.0.1775036414224; 
 Wed, 01 Apr 2026 02:40:14 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80148csm108135735e9.5.2026.04.01.02.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:40:13 -0700 (PDT)
Message-ID: <292b5826-e6f0-4be3-b56c-176dfa9b8d00@linaro.org>
Date: Wed, 1 Apr 2026 11:40:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 56/60] ui: extract common sources into a static library
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-56-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-56-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 17/3/26 09:51, Marc-André Lureau wrote:
> Move clipboard, cursor, display-surface, input-keymap, kbd-state,
> keymaps, vt100, and qemu-pixman into a separate static library 'qemuui'.
> This allows these common UI sources to be linked by targets outside of
> the system emulator build, such as standalone VNC or D-Bus display
> binaries.
> 
> keymaps generation has to be moved earlier, so that header dependency
> are resolved first.
> 
> The library objects are re-exported via a dependency so existing
> system_ss consumers are unaffected.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/meson.build | 103 ++++++++++++++++++++++++++++++---------------------------
>   1 file changed, 55 insertions(+), 48 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

