Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CD9C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfmB-00048V-No; Fri, 07 Mar 2025 17:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfm8-00047v-LO
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:02:36 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfm7-0002Vt-06
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:02:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so26992595e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384953; x=1741989753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iXn/6zJjEbwyqAdHSVxh0+VAxmIkkdH7zRMMMIveCAk=;
 b=qD/hwR3i497sOtw1ekvQ+CbPmc2lqOe4/uFHyTQ6nv2EIrgkqPFEYO8dXOXrpOj1nD
 kxir8wQ2Ojjlr0SiPxg6Yguy2M5q7NtCZjmo8l8NZUscPJTqv7WpxLPxeaME8nQH4ABd
 U9f1o0eCKoJlJEgshDKVHScuE7tTKNggTYFpIw1VnlOa0WZXv07X7TTVhsmKa1DE3BRz
 vIVnCzVLSGq8bRkqshGqJBY6bgQrgGmyOILPCMt2n7AZDdVgc93xIsfFuG1ZhjTcdNbc
 R/F60eEpVZJZ1jkdIZ9m4INXJS3zlnrbr2J/zzp5AP7rK8LMZRg5go17ngGtADpHJWUZ
 o+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384953; x=1741989753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iXn/6zJjEbwyqAdHSVxh0+VAxmIkkdH7zRMMMIveCAk=;
 b=VUhRkYm9EVi11T7IH9O9lg78EX4OZTUCVEtmjeBlfM6Vck3mOlCAqrJwy5tPEj/Wan
 vsaLmQtpPNGE+NnFvnVPFGphei8zfHiNyqYOCLqqlmm2dZ+arTVpAQgijFBiyqq4/2xL
 F/3Z3avSHNCslf8e+XDN/CJnf0U07/zj4JDZzGJ9hByCHW+uENe633K7YVQvBBNwMEyF
 xHvxMNDuZ5V53YunopMKVtrY64fauY+oh2TLIxPfx20RFBel1OCBYn4bKwdYQSrhzcwx
 TitJ+BG3g01Mfbt/AvII51JsX3Wh+STzkhn873d0kujZwwteXsnCa4CzE7DNZ/yzqRYP
 hY0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtOJk4DxRjPoM1kpv48XVixDTWyNZSignttPDBxwJTvI/67USVCC5nXE0my/lnL5sVNeMSlmd+sgz8@nongnu.org
X-Gm-Message-State: AOJu0Yx0IKvwm7mQG9B2vDbpHOj21kd54rgFYR3ElI22Mg4SpZnUtRk5
 RYVzu1LVSSSDXh/GCS3canfWngZkTMX8T0kM7Re/qHhPGAwCM24tkHnLAkN4fW8=
X-Gm-Gg: ASbGncul4jNsziis12Sd9QJXqtG48XAaz7pxqNrEOncO828W5sv31Nzjqsbtca8CGnl
 p0C6O8zpOetIrXn9J5iqUskPH3thYKicL5DEK+NclSYHdtni0p36qjrXMz9YlPMdYUPCGZMRsOS
 hGAuqd5x70WNvEae5wHz/3Od0QvvXahL3sBAk3wiCLnU2Zjzmopp8XoCYlN+aCYDumQafvyzVWf
 TctHepKYBafERah9q5OttdKnmkSceudcr5YzU0v3j+R9IjhOQvOF6ykv5tA8O0oIxAmWT+z7T4a
 B7soxDOUZIU5g301H88UY/gcRHZIy+Ll/AhWuFYPEhj3kujD7ZnHF4FjR1HRiztofIGCDrwHSHf
 z0BadvjVUoaut
X-Google-Smtp-Source: AGHT+IFbW0m/UOEi/LNO8fpkt3jL7bXAu11jnkP4yPUjPPYWQow0e6MtD1TOk8QLxe55NQecqMBCfA==
X-Received: by 2002:a5d:47cc:0:b0:391:3049:d58d with SMTP id
 ffacd0b85a97d-39132b58ad8mr5047393f8f.0.1741384952919; 
 Fri, 07 Mar 2025 14:02:32 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfde7sm6717052f8f.32.2025.03.07.14.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 14:02:31 -0800 (PST)
Message-ID: <1c1984c3-6e31-4d17-9d2b-1ed58f564018@linaro.org>
Date: Fri, 7 Mar 2025 23:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] accel/tcg: Compile watchpoint.c once
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307185645.970034-4-richard.henderson@linaro.org>
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

On 7/3/25 19:56, Richard Henderson wrote:
> Move tb_check_watchpoint declaration from tb-internal.h, which is
> still target-specific, to internal-common.h, which isn't.
> Otherwise, all that is required to build watchpoint.c once is
> to include the new exec/cpu-interrupt.h instead of exec/exec-all.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-common.h | 2 ++
>   accel/tcg/tb-internal.h     | 2 --
>   accel/tcg/watchpoint.c      | 5 ++---
>   accel/tcg/meson.build       | 2 +-
>   4 files changed, 5 insertions(+), 6 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


