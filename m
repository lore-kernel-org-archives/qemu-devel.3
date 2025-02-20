Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDB2C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8Tv-0007Xp-DL; Thu, 20 Feb 2025 10:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl8Tt-0007XN-AP
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:28:53 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl8Tr-0000QK-Gj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:28:53 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43948021a45so9459385e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740065329; x=1740670129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mq3pP2h+STAIFmDI6YkzT3qabhBdgezlJn9Dn3Hn3i4=;
 b=meisaucIgXUV/AVHWvQtom+KWah04/AQ3/GcNNssT55VYkzF8h6YW+ONFI0D2kXvga
 ugx3S06TCgpi8J2eN1J/EzT8YlyiOnODgPKx6JUUz5qd1Y3jyd6xjnnXG/77SqgEJ54x
 MayTLCMhYYq/Yjhj8DqZwgWgEBGFgmK6emOW8Ok1UZE42Uz4FewJwGGHkknTKWsVkEoV
 0+yL1IGIIsgqGOdjN7hV7z7Qx9NhwRlbl50hacxojMTHXKL7lHqvCn8cKNz/FVdGe8cl
 E729VOZ+N8q4Xtodk9xC+bYPbrb22jcI3TS4f/xz5+dpFRHlGWOubPyFN/UDAroQTSyd
 mjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740065329; x=1740670129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mq3pP2h+STAIFmDI6YkzT3qabhBdgezlJn9Dn3Hn3i4=;
 b=r0tAaIL4ZQoyi5n93VibikQYIMAGHet/UXUAfUHe/krLNkUVTe6CZ7UZmWG9pfZJJw
 HixXDuyl50DZiW3rtMCqBS2A1UCSCVCOq53sVaUmSFlZMJMrcRL7N28iz0Ks4XEwIfky
 JAyYBeuJCXJiZE3I23RLiFG62xTn3AAwqcZoLCiv3mN7LvAkivHrmKPU4HFYjYkzI3hK
 fmTpNXrgKJw1RCcVBGpoDlqGG6RkITSPBe+QWh2T354CP1YqKzSxCX+jP85bhn+LhiDn
 aU16HPJE6s4eNJDypKnsZDAb7vmHYHKxCWweSAnUYvBU3jxU+ygkUu11FLvJgUNeGNU4
 1F8w==
X-Gm-Message-State: AOJu0YxwTqaQneRQMoT4DyamhydlTBhqGIi8JZfM509DzJfJSQn4lPRs
 B2aAvQtNlOMU0QF1qrLLAOFzjNaLEcsrWg+3cBQKrLSSHxFKzq7v6Z5e0Rcc8qecMsr1ss8S5zt
 p
X-Gm-Gg: ASbGncuFBWQBnPFtKD3sGmSIxXdAjhEXNjt00h7AWYeXqYZQOxKiUe9LBMaAE/KDTOQ
 hqNcv0qcgOAsL65bwW44ujNp0s37aohVei6s7PRZi6V6fu4N9GhtiGU5Xpzgp4vBcNKuMpIaC7Q
 SA7EM69Iy4Jti5hka3SvtvpFgVI1c2Y2IsGDrpKGalIusD6v+u2viMlTHR/CzoJ3qnPmgYJ+7dY
 e5tI8Qb591R+tHrXub3MtYTyidXcBgVzqHjrAPNxbFAGArI6t58AxrimnqYqr5yaR6X8Li37oe+
 xlrYN86q/AjonX+BZ/A9ER/zuR/RmFEaibky1Ppyor5Nx/EPIyGF4CoCvEuQmBW6EKJ/EGpntSG
 E
X-Google-Smtp-Source: AGHT+IEfyV9wB9FXUB3/GVXAc3bxCAmAypTuLqiNZLuAulkYZlkDB2A2imzUjKf/BC6EDQUY/LnbUQ==
X-Received: by 2002:a05:600c:4e8c:b0:439:44eb:2d81 with SMTP id
 5b1f17b1804b1-43999da5b2bmr85949405e9.15.1740065329140; 
 Thu, 20 Feb 2025 07:28:49 -0800 (PST)
Received: from [192.168.1.33] (lputeaux-658-1-173-28.w92-154.abo.wanadoo.fr.
 [92.154.108.28]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7c7sm248203895e9.27.2025.02.20.07.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 07:28:48 -0800 (PST)
Message-ID: <40365ce5-74d5-4e9c-9e3e-5372726c0d79@linaro.org>
Date: Thu, 20 Feb 2025 16:28:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] accel/tcg: Clean cpu_memory_rw_debug() up
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250217130610.18313-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217130610.18313-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 17/2/25 14:06, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (5):
>    accel/accel-cpu-target.h: Include missing 'cpu.h' header
>    accel/tcg: Include missing bswap headers in user-exec.c
>    accel/tcg: Take mmap lock in the whole cpu_memory_rw_debug() function
>    accel/tcg: Avoid using lock_user() in cpu_memory_rw_debug()
>    accel/tcg: Move cpu_memory_rw_debug() user implementation to
>      user-exec.c

Series queued, thanks.

