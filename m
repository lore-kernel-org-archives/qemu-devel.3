Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65E8C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpBA-00007g-Nu; Fri, 17 Jan 2025 11:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYpB8-00007P-Vs
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:26:39 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYpB1-0005Sx-6o
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:26:38 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so67607905ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 08:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737131189; x=1737735989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nCQOljGW7J1GDPf+/THeVvs+mBN6LG8D231Jzvn3x/0=;
 b=oxNqxvKxa1fVPccJQw/D1FtP83sN4gp/tF5Zkp5xfuzuWDr4dFtdG5pcUX/S/5wnfM
 6fhQitQ96KjBrokR1lyJvpzAdveTmqgvA5VXjP2IF8CH0Oqh1qnQCZLPpiEuUwV6bCPe
 DOLhgXySmA1J++WTEpKNmGFA5BfHwJINqUd2Owpfcu6YEg8MUB/+HhWerIJadc6XjYsY
 MMLemLVRdSZ64qw7fLsZBz5J9pIQ4TjrNH815zKFkt9yRKdy1ctys4l8toKISkDIrGo5
 lXyvoJwJjy/ATtmgJQhL556DzHqarFCJGH7oLIv+cgByQDlS4dllonlwMZpWY7QuewSQ
 9VHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737131189; x=1737735989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nCQOljGW7J1GDPf+/THeVvs+mBN6LG8D231Jzvn3x/0=;
 b=Mka09Pb0HPFx0TVwys+/DJrJXNFi18H9/pe76DC///L+DskkaIRigg3jqtRpfUBYMu
 6PtgXaJ8/O4Z92DeHPsrkzDrIpkLq0QOWNX1SOVYOUWkgnQGogbkWos25ov2Jbc7vZfj
 gGkxzNF3SFQJA2uqXlzyB/Wn0lBlmDDBzpNDoxVebOUgZdX7aysEycKB1EuGVnQHhk0q
 cN7p8UhUBIXjsFipat6P5++r5ytG/y2tIod3hNOtPE9b4VqquRzn64drBFb4rNDZOpIS
 P/XZszFbL7c5lTv8uMm3LPdesa+5Ff35Mvnw7mqIN08qk8yRXZ0Bmf/UzRkyqdgs1aj7
 wUdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfr0tFgqb/6ZtpYqTRGJ6ADOuqlKlM96y/GXi83rNE5zovQa6f0oj7FP9g8yCekIjmkdiNRFrZmy+n@nongnu.org
X-Gm-Message-State: AOJu0YxBqBPZWsx3VPdPHIjRUnzE8m+IE/+x0L7y9deNrWqgCc+rF9I0
 6SMFGhEiDaJFXQIcfhLz10p4ekJAHFLwoom1XSiu0KrepX0kYzaoqFJOQ/guun8=
X-Gm-Gg: ASbGnctl9L0eB96OBy4teGMc3in+rlXRdWs2eCirrm3hKLFt3idzDMVyzQvSfieym4O
 styWcYoqOoAeonCsfgM5SnqZ5CrSqFIXo9tEJcXbFp9UlQDZTgNpwi8S9zS4e+NxJigr7QJox6M
 +8OJW4lw38X6I4E5kUtHKu8Gt/EozfbzQYHh7uJUFe6j2KSJ1Jvyeft4RY9WzGCARpeIZBw4Ltb
 AXuuRP6E6rfQTwQwisQrEBuzAD8WHetCLI+WNbvRz7tnD/MftokP7KtsiXzlMtvxJ6RGk8vk7Ox
 nKOMklq0J9zNvnPq+p7m6VY=
X-Google-Smtp-Source: AGHT+IHSoi+V6Exv8SyeTdIYtasCUMGnbFXU0cI3FRDYAt3kUUHdytfhmFlcWlBTdtc/dUrTPulcTA==
X-Received: by 2002:a05:6a21:3389:b0:1e0:cc01:43da with SMTP id
 adf61e73a8af0-1eb2131a4e8mr4925110637.0.1737131188985; 
 Fri, 17 Jan 2025 08:26:28 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dabab64ebsm2097347b3a.169.2025.01.17.08.26.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 08:26:28 -0800 (PST)
Message-ID: <eb37267d-3131-4cc8-a58a-baf0350aae3e@linaro.org>
Date: Fri, 17 Jan 2025 08:26:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qemu/compiler: Absorb 'clang-tsa.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Hanna Reitz <hreitz@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250116211111.53961-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116211111.53961-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 1/16/25 13:11, Philippe Mathieu-Daudé wrote:
> We already have "qemu/compiler.h" for compiler-specific arrangements,
> automatically included by "qemu/osdep.h" for each source file. No
> need to explicitly include a header for a Clang particularity,
> let the common "qemu/compiler.h" deal with that by having it
> include "qemu/clang-tsa.h" (renamed as qemu/clang-tsa.h.inc).
> Add a check to not include "qemu/clang-tsa.h.inc" directly,
> remove previous "qemu/clang-tsa.h" inclusions.

I think merging this into compiler.h itself would be better.


r~

