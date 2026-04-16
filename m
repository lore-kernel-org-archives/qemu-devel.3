Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CEAF8E48F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVg6-0005XK-2I; Thu, 16 Apr 2026 18:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVg4-0005X9-Rs
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:59:16 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVg3-0001Ul-9b
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:59:16 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b2494440f3so86055ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776380354; x=1776985154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+yx2Mi4a31RlM2Vmu4Ilip6w0vjoRvaqTZ0g7ICNbC4=;
 b=CyeBFMBQcDgo0zb/hiMJKlyu4pH9t0ww13fUitmFnvRUuXvDwLTJ8dkquRbhQNOGMD
 Ux/XP2tgp7TkRqNiMUSypgtOUjBnDDQcfcPo6+1imZbaK4vQhjApDyN6yNFZ6t7xjhoS
 M/27SYOSzjL2AOiL498CyU4KOkc2GrKFB8VblUXkNS7vefp/HD/n5Td/54a87gWoAiBD
 Rc9z3XFSi0SSsYctVSBFnTEiSfQeoLkzF3nkf1z9LTvo3XqswP3EGb2C6eFwGlT6ap8R
 UIeHAVZVyuyyJgCOOzA6YkxoHoMNmUZMlNW7+0/KcgwDEsf7e/Fqz54zGBdVBZufvM1E
 QCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776380354; x=1776985154;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+yx2Mi4a31RlM2Vmu4Ilip6w0vjoRvaqTZ0g7ICNbC4=;
 b=FtV4uirPk1RjqyREetWQ2KMhVViJQVhaGPc3MZwjXGNx6jZ2C25E00/DUgIeRcmjHk
 ftoWCFLo0CWiK9x09I9TxBxJSYKfr4QObDp2hCFYn0Z/ZQifT1KBsYSmaJkvQ7zLG4j7
 P/9kqbz2X5ywprDKi4actU/5QZgQBv22Uq+si+Ii2Q4H1dm6TIsURNA5WrDbs4xPjNBA
 mfFESBaK/QFN2N8lSycKa7tzEjfiTKwNBW90bOLDjQ0Mx+UqUULfAOIrQTgLMXtzjiZs
 mocNsQKHZ/OjYnNVgsz9ygQI2FWeIdRrnR0/mSYG3HFCOo4DyYUCFz7h8gow9fWbn+ct
 7ciA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yZAEnw7hwSZrOalt8aFAZ3Ron9wbO3vlCyiMKlMCNWg4SMrs7FcWu6jTVayxNN2GaoCvFBoCOI5u5@nongnu.org
X-Gm-Message-State: AOJu0YyASv2C5TkgPPy5TIeAw3I3gPgTwbEQF+0tpmU1FwvkXNlzhbJf
 bYtrYVjWBPcdz3fn35G4FwkV+nMUO1T2/euOuWLoohH9FjZpdZorCLG6+KhzPi4KteQ=
X-Gm-Gg: AeBDieuEmnBOqma2c8xLkvgtacxRcIiKYuVjP9kDBkegHHy3uU4uPpNnKr4l5yXg9HM
 gixard7bcPFbNHueuKY3MproPfPO3jpc4HxPQtOfxfJQrkE+lFXvBIIRk8QHWk0vSnxdnARD1kb
 BX2d3EEYxiwLzZVxx/NCPQl3lgkVQgRoyeKk5ynhDTrKSwRymR69dlvCKj9VsH/VSvP3cbnOrOr
 fuxh3V04CJHqpavmnNTr9+GyvwFi78giHbiCM+In0WlWcaZf9LR/OBg5PKFUIsp+5xHtsNWrd3D
 pg0xMa+FjP4cw56ESTa77NrrIvIIXQJPKWV2/1RY5obePoku3F0NTCQ/ztM0OqYyKhFndTkKFWa
 QGrGQnbHrnHvNZlQdY0GC3R3kGgkiAz+lGMBF34Y7vplxbQ0IdHpCKk5DNHRx0c/YXM3avXRSxT
 VmHPNyRV+va2WR5t2AlUqtRZoddgz/JZnmJt2bQxnqHnX8kS0fhkTDqoZ5kml1GSy5IKSu3iNb2
 aIz+2A0f4n4foKQmsylgu35ijrvLaq/eUYBChEMEtFZqgjZu6/XZtRcDscFGpScNnD+yiPVEI2j
X-Received: by 2002:a17:903:166e:b0:2b0:a957:304 with SMTP id
 d9443c01a7336-2b5f9e85b42mr2923355ad.6.1776380353646; 
 Thu, 16 Apr 2026 15:59:13 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a60a:7c34:dd75:e66c?
 (bg30dj02y68bx09myf73.ip6.superloop.au.
 [2401:d002:dc0f:2100:a60a:7c34:dd75:e66c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa5c06b6sm448105ad.84.2026.04.16.15.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 15:59:13 -0700 (PDT)
Message-ID: <3a27667d-1a4e-47e4-944c-ffe68fe5b579@linaro.org>
Date: Fri, 17 Apr 2026 08:59:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] target/mips: Use probe_access_full() in Atomic
 Load/Store helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260416200513.27100-1-philmd@linaro.org>
 <20260416200513.27100-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416200513.27100-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 4/17/26 06:05, Philippe Mathieu-Daudé wrote:
> Let the probe_access() API check the address alignment
> (request MO_ALIGN in the MemOp bits).

I just reviewed v4 without seeing a v5 existed, but comments still apply.

https://lore.kernel.org/qemu-devel/73a6d4c3-9108-4172-b1b6-11ee857909fc@linaro.org/


r~

