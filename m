Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A7CC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2Th-0004h1-Ch; Sun, 26 Jan 2025 08:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Tc-0004dZ-9U
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:15:01 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Ta-0002Mn-IU
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:15:00 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2167141dfa1so62736375ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737897297; x=1738502097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KeWwfBzFpN3/eppmcSYI22kjCCgkvzxmYhJ660R+XJ0=;
 b=hPNhwKeho5jt7BO5fkHlBhK1fco33kqR34tMIU2ODLbzDzJoY2EQRGq0inTRALbY+c
 steO3m3SYqsHsl7mqTgXcz4/B1tCstpASGzOyadcauhGN3HEK7pI7bL8eeqtPptCUT6z
 oVWAZsl2MIvm/670v8AhPKqqVfxa35fTGu+vP0tvUzmodMJ9yvpJbnCx4ui+znViAqdY
 d0bJAWENIyICVYSgYFQn46srN76qGoXrHtg8dAfLVgersxJE+KoG4Q6q/E/T3eOKER9k
 0Kf3V7EYVA/FdylXgwqtI+inh0ghs0U0eyC5/X+tdYqD3uHAu8WQjejDuPKrcox+KXMe
 0Tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897297; x=1738502097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KeWwfBzFpN3/eppmcSYI22kjCCgkvzxmYhJ660R+XJ0=;
 b=w/toKlRx2boiteSSCZmXPLgUJvst2a4xPlmkH36RmnlFy/NCKH08BIEEeAMyx8PAET
 c3cgf9IU1xJXO76OxTCzk+PwassfOx69bMG/c+5LNk1QGJb8Z/YQ437D7C63qO0+51IQ
 CtTsBLEGuuN6BScGZ+g78onyhVP5fB6ZRZXViekJUJGTUiBvTsfPJevhtC7AusZ6Hefn
 U2g6exA+lzZyEnaFK+MCv3LiOei5pHoNkhT0GkNYNC5JS8KXf8JUY0bUrK6+MGhPojbG
 rUmp8YmCttwyX5oERMo7emeB8wl+/GaIB9weWs8q2TuZgOz7up2rVi6T10tM3+cWGyTh
 UlqA==
X-Gm-Message-State: AOJu0YxDgmQv3HWojvT/W0W1N+2KO96UuatmOsAEuPeMrHm6h0oYUMvi
 Vo37hKhxVBxzFfDO0mQZaWCJVmCEb2llZ/17XP3dkiU5HA4I+8i4LFVpHg8zCmickUmy0xgd5/V
 L
X-Gm-Gg: ASbGncsR8owkh3oIAmGfZR27UsN3jkfaDRucjyqMFGjqRuk4ixvLRZhK4Wga8KGO0sy
 Q6qYLYacssbnMWJRcgwhwg9vtD4iNRNu03zSwqRsxK9M120ObahyB2tKdJWTeOq5BAGMYrn+zLP
 Wh8rFMh/4QpX2p7o2yvv2SJHYjzvV1BMoFgUTCJDjkZeph7cGcxCSFIsqedyDTQ0lBgXXL9JSQR
 Y17eHWmyLJ/nqRjXAypZMIIVgKe7q5wCA23KEoW/GXoP4Ab5+mUeRprZdi3edaY5hmJkQ5lP15V
 HV6iSaAUDDHNJMBrMN3pDIs=
X-Google-Smtp-Source: AGHT+IFUekAM2OZoCEEVRkjHlOMKiRwqkQdXBF9dHzHcRX/j28Ikgdm1GgrQdqIbjKFu+L5WRW4XJA==
X-Received: by 2002:a17:903:2c5:b0:215:7287:67bb with SMTP id
 d9443c01a7336-21d99236461mr239208375ad.0.1737897296968; 
 Sun, 26 Jan 2025 05:14:56 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9c5d6sm45860145ad.52.2025.01.26.05.14.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:14:56 -0800 (PST)
Message-ID: <68020751-5d7a-41b1-9b34-de810df6cdd1@linaro.org>
Date: Sun, 26 Jan 2025 05:14:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 61/76] target/arm: Handle FPCR.AH in FRECPS and FRSQRTS
 scalar insns
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-62-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-62-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/24/25 08:28, Peter Maydell wrote:
> Handle the FPCR.AH semantics that we do not change the sign of an
> input NaN in the FRECPS and FRSQRTS scalar insns, by providing
> new helper functions that do the CHS part of the operation
> differently.
> 
> Since the extra helper functions would be very repetitive if written
> out longhand, we condense them and the existing non-AH helpers into
> being emitted via macros.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-a64.h    |   6 ++
>   target/arm/tcg/helper-a64.c    | 128 ++++++++++++++-------------------
>   target/arm/tcg/translate-a64.c |  25 +++++--
>   3 files changed, 78 insertions(+), 81 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

