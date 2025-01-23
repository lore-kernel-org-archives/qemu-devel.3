Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE53C0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 08:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taslD-0004jY-IR; Thu, 23 Jan 2025 03:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taslB-0004jB-Eo
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:40:21 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tasl9-0007Jp-RV
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:40:21 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so3813435e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 00:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737621618; x=1738226418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9bKRhR3iiaZWzJQKXJXOCeZfuQmwj9OO1oO7sCuz6xI=;
 b=cTB/UhlcyzqdVAl8mofq81su6dz8V9WUy+p0z316QJWmqFCojGj8iOsIu2KlmKo95w
 QtmfeOfCVH9Khmz1sl9JqatAsRKNYYSUTWeZ9mGBF1tCaFJlu2nvm5DANWJ4e9OYT/p0
 QLL/JvRKFmail6s7h0mqxCPsaAvY82pnK/heA3YxVApNKgO7XHKYXaUKYhBrNsYCnpjf
 07fhginDCyfm4HsS6cIRlqBZEJj8DBex0kCybCc45mqYQM3jnSMiluhC9IEyBWhyxK/Z
 6TLxijfdsYPwoipFAXXGz/fD7p824u2PbYB5TDwk83fPqDANGdPeXisW572GLdIUczcO
 /+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737621618; x=1738226418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9bKRhR3iiaZWzJQKXJXOCeZfuQmwj9OO1oO7sCuz6xI=;
 b=V8i3hmHaadZmHuuNpgg0AUyWc5V6gfW6TzmBA7tO/2/ka/Z3U6RaMw/9rHELRtKGuU
 qBEl542Kkasgo4/jR7806Z6p/ikeEAyUMBuXEhdSuHc8Py//sfk9aKeDhvcH3KKwiIaW
 3ovYl3VxqKzjwnDgOYxRQBTp7+Z/5MZXITwR2xkucDdZ0LdPRlfiYG4QEQYDTVirWHOh
 VZ9rhlPXDggEvUZ7AQDsSFnngSY3ELhkTASuZrjwrHjU6MhBvHlzm6SkjRgLgaHZPop5
 /Z4jzflWMVN8zYIfjREuk39px9gD4EpiHieJsA9wMitSnbevf/hLO1miL+Q3NLeJEXQq
 biiw==
X-Gm-Message-State: AOJu0Yxfub3zyF4te40ets2DA8W0x5ulHg5mZ9ZDVhxaTpopObtXNzIr
 rf5KHeUpIwz99928k482Wh+DsvwuEtm7SODkAaRTyETkoboRZwJJI/ddWPVMJrYWRFRanIgTwln
 bZvc=
X-Gm-Gg: ASbGnct7D9sTucUgPErl7CtWB429GcwoVxmUE4O4Jq59OUYXLiqSlUIEVftE+x7QhEh
 VlKJxwrt8PIO4Oy33ciaw4aAa3QKHVCcWbyTTS24JoHk/O52HSeulj8cgupPzDvxlUpwu84VHKo
 APlPxLRsN9V6r1/wrY98MyZWJsfkDY5b1pD0zeDHjmz/xMGs1Tul/MgyojD5yyCEIEsMbGtGdAc
 NJT3B+F4Vfkq0Oofm8KeeoEw2D4g8Z4JZ6Xl6nPM3Lh2kia8Fi9lN0px1BCfyTsCb0BtTdFAa83
 77vIVj5GeLe9LjR3MSXa8giCFl47L3PTLD2AQgKLeZHPtUC5
X-Google-Smtp-Source: AGHT+IHjn23WkL1pNBJXl3Lbn73f/q7cYyN6uKSIYhK6Mcu1jqT0hnnq7ND1zaIz5FxBSG6BLO/h5A==
X-Received: by 2002:a05:600c:1547:b0:434:a04f:2557 with SMTP id
 5b1f17b1804b1-438913c7fbcmr228607625e9.4.1737621617672; 
 Thu, 23 Jan 2025 00:40:17 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327e1fdsm18798271f8f.94.2025.01.23.00.40.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 00:40:17 -0800 (PST)
Message-ID: <a1c0baaf-4a5b-4f7a-bad4-ef55ef69cd63@linaro.org>
Date: Thu, 23 Jan 2025 09:40:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] coreaudio: Improve naming
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com
References: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
 <20250123-coreaudio-v5-1-6873df4215a0@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250123-coreaudio-v5-1-6873df4215a0@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 23/1/25 08:18, Akihiko Odaki wrote:
> coreaudio had names that are not conforming to QEMU codding style.
> coreaudioVoiceOut also had some members that are prefixed with redundant
> words like "output" or "audio".
> Global names included "out" to tell they are specific to output devices,
> but this rule was not completely enforced.
> The frame size had three different names "frameSize", "bufferFrameSize",
> and "frameCount".
> 
> Replace identifiers to fix these problems.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   audio/coreaudio.m | 191 +++++++++++++++++++++++++++---------------------------
>   1 file changed, 97 insertions(+), 94 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


