Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DA0C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 06:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOsx3-0000Qu-9F; Tue, 10 Jun 2025 02:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOswx-0000Qj-Tz
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:59:12 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOsww-0005Vb-9B
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:59:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d54214adso41368735e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 23:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749538747; x=1750143547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GKBLLygukal0kKGmI736nH+LlDBEjx3YZi9eSD93C5M=;
 b=fNE9C8cRKNK4399q3BZ3+iITVGgC7gkNy8ftBS30HefxCnpUuFT7A3g4WMGoR+V917
 EvbKwVTOBIcAbjF8sM0oz5BP2Fy8Zy89OFOlPM651UmGIMw4EmAEgYHa50AACo83U7Mj
 /a7hbqEKrg/IdRvTY3gvPlcBiV2rQayVbNLDHf0oeW5sK1SK+VJaZXv+joyTzNqAajBg
 1B6UKY+AFBnaCE4usJOGCs++LeBQ6ymaTQrI8o5vGg2XhC88jQ6eUIg9e79Y/s1QIvf3
 DSRooOg/u84IjqeJQMgqKN3P5O68iRAnSNiraWvdkyoDvGrTqWYptVzrg5GgJA+nRs3Z
 KBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749538747; x=1750143547;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GKBLLygukal0kKGmI736nH+LlDBEjx3YZi9eSD93C5M=;
 b=tKS7t7iBUOPu+P86SjSD+oLjAYek1w3FjdONDDfK2MQuJj7Dj2AfepoizGB0y3X0bM
 iT23RAlF/gpFL0uih5Qr4EwIlFhbN4DgAGKlwD5Q7bGyZY1Qxm3EjFfNzQ9aFNOsTXk7
 8ghYZ7NRA92eT8OyeJrsCs+AD5zkP2a96DxKgrbRuGQsJHSMJOhZqdclFUzMzxy7Znsw
 KkdgVTv/G589n4aQq637BKy3bkl1KH9pNU1PmR5MXwhrWePD6tx2z173a+lpH8/xIp3L
 BtsGel8TaG7Hnn0BL5cidzt1JdKdg85zk/s+G12Z4QC66AyFHEsuDhULK6yv8X4gALrX
 Felw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ0H0xGrEfFGkYwNjlH/T6f5jocPwGEkmdDnER0IKujbb+yqAEIbCFgbwhyCJeOH8NCeVlGaA0g+2g@nongnu.org
X-Gm-Message-State: AOJu0YwPu4LGs3T4T+gJR9ta2c4FcCcThof305tmQqMG5gVTLFSKM/HY
 GNOtw/vmQIH6fgomFiV++xT7z/sI3A+AGebz0hoas6LrVgw5cujyrk05BQNskaoQ1lo=
X-Gm-Gg: ASbGnctimjQZ3Ai9ya6tkWcxta9PdjY4GxJOPLkVWRQ6dOTIUZIrs8qGWF7ld2rW+kH
 18jqIbQVRUt1PLJQiyIr/AD6MoIuTLAfBDtpTGRVVr9jlKD5amChJTYV3ZrrVNiRS3B7/88nH8C
 +fU7BJRH/k79q83E80yLMXC5+mSOPKIzIC9eDE+zw+GC7djMXvBS2g6CALqjxWDs8Kv/SnUf87H
 6WIV7Uh4oUI12wWhPiUMPe/IXe5vhpYPRHWRI+szXrS0eMotNX7HcemJKwgPm8utM//G4CzjkH3
 U+1yYJmBj35PHtETQT9Y9hbYUVwuKXf48VS0RkpXEiu/vvYKM3/hTpGK0qWhg0sVhRlY5gfmaeM
 oWDWsB6KEz+gzqCTCDgAtunz+EY2hVw==
X-Google-Smtp-Source: AGHT+IH+XiBWwLrHYhk5S4ctB8NLgCK/V+9MhrGL6OrGrFL0Z5V5ZHbtF1TGgrGlnoN6OhIUSuoNJw==
X-Received: by 2002:a05:600c:1c08:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-4531ddffc27mr10291805e9.8.1749538747607; 
 Mon, 09 Jun 2025 23:59:07 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452669ada25sm131868955e9.0.2025.06.09.23.59.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 23:59:07 -0700 (PDT)
Message-ID: <d6a63d08-c1cf-45a1-b72e-6c7569dc353d@linaro.org>
Date: Tue, 10 Jun 2025 08:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/i82596:changed assets link + abstracted configure
 function.
To: tank0nf <soumyajyotisarkar23@gmail.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, deller@gmx.de, jasowang@redhat.com
References: <20250607152711.108914-2-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250607152711.108914-2-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 7/6/25 17:27, tank0nf wrote:
> From: Soumyajyotii_Ssarkar <soumyajyotisarkar23@gmail.com>
> 
> 1. Changed the asset link to one which is working from the PARISC website
> 2. Abstracted the configure function.
> 
> Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> 
> ---
>   hw/net/i82596.c | 38 ++++++++++++++++++++++----------------
>   1 file changed, 22 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

