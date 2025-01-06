Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6257E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUuvN-0007t0-1f; Mon, 06 Jan 2025 16:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUuv8-0007kU-0l
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:45:59 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUuv6-0005Sl-L7
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:45:57 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385e06af753so7453525f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736199955; x=1736804755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r/A6aDED7Mz/Rcch7mXZePKqz8tMQkB3aUJTYigDJWc=;
 b=Auvlqd3vo2qIoAJz06eCkzmgtiqcP3DrZEZSyTDn5Cu1Re3tXYONIcmhfPUDd6ATjj
 G3Wdte7IMfAYUHLB1fk0/EVbL9Zc00xwHcUE9BGkBe3K4AtMvkSMjjp+19Xp9N7B5mSf
 3UEL+M8Sw14gZmOp6zGJf98repsTeTZzDkWJnfh/ZvLUpKxaTm3orKaskDIzxAdigEp4
 5unro0QsK9yZ/DrtoMSkfyGPiH1T1AUbFbPHLcsgs+0ZOvoujVLhieDUhcHkkR5k3OlF
 pJFRkf4mKmhvqLhvJk1MX2Wo68Hmg/cDpQYw8yv8IVm+ICCkfcHelbKYiQdnxnxsMQxP
 5+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736199955; x=1736804755;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/A6aDED7Mz/Rcch7mXZePKqz8tMQkB3aUJTYigDJWc=;
 b=Er9VRbHcBMVbp4pK+tzTOHPABMqtWuougERCk/fAOPiHWLGYGDA9A2sUR4mme/SEWh
 LGhGIPCJdEwVl9V+rlUPZXf+6V7uUFDdXMU6SJQm2HWWzC8lwRHYBnv20OtWglha7ImY
 TtJsiH2oxXXxqgJsxg6JbNAmz/YxugnQNIWyhPUEb4wwji/7HB0c/h4q0ddi8TOBrQNh
 i/wa8pGa7GTqXP+5w+zRQpMhUUUYS9UcjvoWHxlQIYDW/+zD400BY4LEIc2PTIV5Eu1s
 +JOXDNTGw8o27u2QJ/APhqPL9PMwYOqzhKJrsszgUJEbBUJ2EafFLDNldXQj6TSDhq3H
 liHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc/SWIi1EZ6aPudLRT/KunZpKidZ4RvZTBOXFM2RIuFnlP+plzWHm/jXT59Y2ClH1VPeeP43c7grub@nongnu.org
X-Gm-Message-State: AOJu0YxWQ/PCAfBUZVR+HWExgh3bJwXzbKUJ4RUwUvRm9MX2tnGnWAP/
 Vrg9pOk91yYsjlG7aS1v/WYQCPHqJkyCw9uw/1tJ48rAVUDWi1s+ppMugV/fZy93WSxIUTLnG70
 AG8w=
X-Gm-Gg: ASbGncuxNe+lyFzl8Ote0O6RSSlxHfLxynzwyQTz9vvweVHbp7MTxwVaH3c7cT//UFw
 EcNIJ/rVLROVuCRESFRS2NDdguFH91PIfj+FOlBv4sYVmqZxboO+V93AMNpiWexakEK5US674x6
 9wyNVxmSEYFcKUMJy5cAj8doe87ehsqqP4C++RMYhOhd59XQwPRMdFyD7Qoy7uz/62mUL9dNehx
 7cBI9WG1XFwlTi5d2TNSZebTmbYZ0cMFsTnzkEstlkWjCY5W0RbLrAVRfh567dLrQZ15G8GmtGo
 6OHDnJtSH9qREx/wR1b9CZnl
X-Google-Smtp-Source: AGHT+IEqybG0FMPTAp7/ZifzBbNhtPeocXXsMlYUbdRVvSvyZM/mZowHyFqR+NyJ/z1x0/6AuLyW+A==
X-Received: by 2002:a5d:6d0f:0:b0:38a:518d:97b with SMTP id
 ffacd0b85a97d-38a518d0c34mr28181374f8f.11.1736199955136; 
 Mon, 06 Jan 2025 13:45:55 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b11aecsm611629905e9.23.2025.01.06.13.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:45:53 -0800 (PST)
Message-ID: <84c5011a-1f52-4003-8d19-6b0369f358ec@linaro.org>
Date: Mon, 6 Jan 2025 22:45:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/73] tcg: Merge TCG_TARGET_HAS_{div,rem,div2}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-22-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 2/1/25 19:06, Richard Henderson wrote:
> Pass a type parameter to the macros; this is unused with these opcodes,
> but will be used with others, so keep it for uniformity.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  24 +++---
>   tcg/aarch64/tcg-target-has.h     |   9 +-
>   tcg/arm/tcg-target-has.h         |   7 +-
>   tcg/i386/tcg-target-has.h        |   6 +-
>   tcg/loongarch64/tcg-target-has.h |  11 +--
>   tcg/mips/tcg-target-has.h        |   9 +-
>   tcg/ppc/tcg-target-has.h         |   9 +-
>   tcg/riscv/tcg-target-has.h       |  11 +--
>   tcg/s390x/tcg-target-has.h       |   6 +-
>   tcg/sparc64/tcg-target-has.h     |   9 +-
>   tcg/tcg-has.h                    |  19 ++---
>   tcg/tci/tcg-target-has.h         |   8 +-
>   tcg/tcg-op.c                     | 136 ++++++++++++++++++-------------
>   tcg/tcg.c                        |  12 +--
>   14 files changed, 139 insertions(+), 137 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


