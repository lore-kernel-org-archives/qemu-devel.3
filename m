Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88ABCE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 11:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM3ch-0000Xj-F3; Fri, 13 Dec 2024 06:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM3cY-0000XM-5v
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:14:10 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM3cT-0006F8-Me
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:14:07 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43628e97467so9698935e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 03:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734088442; x=1734693242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=heRmhbZ2S8erniDW29tqDJdhp4iOFzqzZ3yRhCZnj28=;
 b=t/X9SQZSsBChVyV5b2I97LmEyH1Hah/gKdGIxXgRQxBAaPV198pVwMFYMbiwhHUCyD
 Eb4SEPkKtv2ntnQGZP41W7yRT38E5quNbQDLmXGqiOuzQXHKxbqlawxSqQ/f7qg7W+cP
 viBBkV0ns/51lL3G/kng8ma0IF9y7bhNbeTorYFoQtJueLovGQLFMnDXr904eD76VtJ5
 3rL4lKc49FZNzXU4npdj54zIcLXrqS6ojdKpiqsZ6Y1rkmNA+ASyMZ/W+t0btJvOGqbC
 vEkHI8JFHfVw6eS5ahqcMCyVvDInxn+RM4XHeTpAtdJJ7Wv2ZFz6nEwfxhDww1TP1WsW
 qbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734088442; x=1734693242;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=heRmhbZ2S8erniDW29tqDJdhp4iOFzqzZ3yRhCZnj28=;
 b=R2KSL2t2OFaOUsvULCgiQq+++lJXQPxDsrqybYsihYs4b2FDJGeedZQCCy49dezn+b
 UoIkEZ6OUeMWlp0P63ujPB5/y75gtcrRUYEm2GpW4Vt+r1GeDg4UcYIpOhCkZCWOZweI
 TEIxTmzOhtZUcpWGroKitWRINteAeKuJeEERQGKuqQCVBC/5VvW1EuJ7gVq8GwPL/qYn
 AW/e3JMpV134talBb8Qx8vvWugD2Fyxz9ghjzPhhg/PQJ1qprc5obobrOBj2kurutCJY
 WP/Qa//xtOScl32vrmBrJUUpmtQ+0gMqxQXqtC9XhJzDeVvsAym7I79Bh6Uq5Ro2eXcm
 TAqA==
X-Gm-Message-State: AOJu0Yy5nLlS/0mB5Q+83yBzwv9KBScd+LQHNty/l73LrmK7XjGbAi80
 Ko4pfcuD2jlC5/lJGjraL3FPMCZXyQq9ai2atPhJ++2XUYcjZpUTU6UPqkk7hFINxm0zRgnA3Q4
 h
X-Gm-Gg: ASbGncs5CuW88F1eUhKjBexvhkDfxnvQOA8hoGUgFoMW/aetNChSd4r5TvcDrbIXCyp
 S3nbys6NZtZO2+6H5Binc//FV700sJtVffM2syHIGOGCw7zBbHogOgPjdxkd6cR0aghP2bKWnk9
 wqsdOxDiVoLDxg/0yBVB7j8UgGrIeiA12fEEvB23JGaszYBE7pL1G5kCjpIZgatJyK8Ttm9KrbF
 06fofvlTVaVghSWs/cb7IIp2aVW42TtRzrawiSJeXKvlX2HgjqqkJ7PoOKA+08HwoIFV98yI0e9
 cYbQECxfLmeKvG9R+colwvQq
X-Google-Smtp-Source: AGHT+IHTTVt9CKCNAlYn67DiZL06Oelelsy2j/937naNcwhk8xD8a8pdHhWHFnSioSQeLaJomUVT+Q==
X-Received: by 2002:a05:600c:a011:b0:434:ffb2:f9df with SMTP id
 5b1f17b1804b1-4362aa40bbcmr18737115e9.17.1734088442207; 
 Fri, 13 Dec 2024 03:14:02 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362571765dsm45903935e9.39.2024.12.13.03.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 03:14:01 -0800 (PST)
Message-ID: <3aaffe29-8b30-4e92-b6e0-13e4cb64c390@linaro.org>
Date: Fri, 13 Dec 2024 12:14:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] accel/tcg: Extract user APIs out of
 'exec/[cpu,exec]-all.h'
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 12/12/24 19:53, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (18):
>    exec: Introduce 'user/guest-host.h' header
>    linux-user/aarch64: Include missing 'user/abitypes.h' header
>    include: Include missing 'qemu/clang-tsa.h' header
>    accel/tcg: Declare mmap_[un]lock() in 'exec/page-protection.h'
>    accel/tcg: Use tb_page_addr_t type in page_unprotect()
>    accel/tcg: Move page_[un]protect() to 'user/page-protection.h'
>    system: Remove unnecessary 'exec/translate-all.h' include
>    accel/tcg: Move 'exec/translate-all.h' -> 'tb-internal.h'
>    accel/tcg: Un-inline log_pc()
>    accel/tcg: Move TranslationBlock declarations to 'tb-internal.h'
>    accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
>      (1/4)
>    accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
>      (2/4)
>    accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
>      (3/4)
>    accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
>      (4/4)
>    user: Forward declare target_cpu_copy_regs structure
>    user: Move 'linux-user/cpu_loop-common.h' -> 'user/cpu_loop.h'
>    user: Declare cpu_loop() once in 'user/cpu_loop.h'
>    user: Move various declarations out of 'exec/exec-all.h'

Series queued, thanks.

