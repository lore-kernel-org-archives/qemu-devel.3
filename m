Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696D7CD37AE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slaNP-0005xF-RJ; Tue, 03 Sep 2024 16:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slaNL-0005wN-Ig
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:43:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slaNJ-0007tL-IA
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:43:43 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7140ff4b1e9so4476202b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725396219; x=1726001019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5oLq4jDrnix7Asl5lWkHaoR7vO7S00lk/Yem9S4+zDE=;
 b=IYZz3EbcIm5g9zQV0ItntLthe96D+mcx2qLJWzO44/xdOzrjWDDaNAfP38fc/jaRmD
 mvwsUEKXDFfRsdudwiSvRXl0HayO91lzM2T5Jwk2pk78SNrJdBbsx/bAxzf475qUjsr7
 h8GMfBqi5hE8GFX4yCG8HTG5tNx0EwIitJj9EjD2L2g8Jo4TEteMPTlM8jalu3teRMl0
 BzUQ6ey6GdBLybhe/FWnf98onN37aG3RW9Iwhf6O3YPgG+FPmqlqbG3KWkLoO9ftLBFA
 StdyZLK6m3V3bW+HSOEEPb4jk3MPaIdBNG+MddAoKVMVWH49AllKesQCKSu2nlKsLMt0
 AHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725396219; x=1726001019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5oLq4jDrnix7Asl5lWkHaoR7vO7S00lk/Yem9S4+zDE=;
 b=gjuKqOX+K+Juwvzrhiuz4HZ+eiAwFmNSjoWoNTVgO182jAHEAd4Ggog33ktDuKCM4Z
 9EOW3UflsHJ3FI4rduoAMiPTZWjY5DprUc51ZDKtFHjfPKUlSmHMH5mrnIKq5oJVJx/T
 gMEaR1SL5QruEWU+g5y5XSphLreihlgTlaUP+x2XRqjNJL1WGNVtBWM1JOURyi5Yjbmt
 VrCLlvH3TJ0RNMnalwGleMlPwE9uvNG94WijB7RcH999Ef9/CQvM2EptsrFNwqGuSrwc
 3KYyKAVYeL7gmCpJ3h5/mSrvaPN9WkvQviEwsJotGxFYDrVqueLWqkaeYB0EHelszshB
 uPDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxOV18CSF2f2FGxM7S6EKN+i1HCKa6wM5o4fhCZnY4XxtIGTinYsASMgF6XhEJC5Zyto19YCebz0L4@nongnu.org
X-Gm-Message-State: AOJu0Yz6tr7Cmr67pb+JcCgBVPetLGyUOk0DtSEECDzQZgoQN8lMQmdq
 Cjq0AMeivISTFTzMKlZHd8CqczQbzmk8tyTptrDmrqHyBW1UA4QaI6ntH6AOl2oeUBJvC24PFSf
 QPH4=
X-Google-Smtp-Source: AGHT+IHX6rAq/KJ3jSI6VQyHaCMpjEDAKM5SuoJrfI+tbIZzk1tiRjqRrNsp37p/3LT+S+5zct3xeA==
X-Received: by 2002:a05:6a21:38b:b0:1be:c9bd:7b8b with SMTP id
 adf61e73a8af0-1ced058a805mr12325545637.45.1725396219082; 
 Tue, 03 Sep 2024 13:43:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d4fbd85b0asm304104a12.17.2024.09.03.13.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 13:43:38 -0700 (PDT)
Message-ID: <d4409097-f60a-4f7d-adfe-dee8073f176f@linaro.org>
Date: Tue, 3 Sep 2024 13:43:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] escc: convert Sun mouse to use QemuInputHandler
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, chauser@pullman.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20240903203846.144354-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240903203846.144354-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/3/24 13:38, Mark Cave-Ayland wrote:
> Update the Sun mouse implementation to use QemuInputHandler instead of the
> legacy qemu_add_mouse_event_handler() function.
> 
> Note that this conversion adds extra sunmouse_* members to ESCCChannelState
> but they are not added to the migration stream (similar to the Sun keyboard
> members). If this were desired in future, the Sun devices should be split
> into separate devices and added to the migration stream there instead.
> 
> Signed-off-by: Mark Cave-Ayland<mark.cave-ayland@ilande.co.uk>
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2518
> ---
>   hw/char/escc.c         | 88 +++++++++++++++++++++++++++++++-----------
>   include/hw/char/escc.h |  3 ++
>   2 files changed, 69 insertions(+), 22 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

