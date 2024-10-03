Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8251CF34BA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 15:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swO9i-0006T4-AG; Thu, 03 Oct 2024 11:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9g-0006Si-Is
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:54:16 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9f-0003Xt-2X
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:54:16 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37cd8972738so880710f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970853; x=1728575653; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H4iuofAzmjQ69v9z61keFGhIgoYW/hbzQrKzWVkUNAU=;
 b=fNPzrsaP3dxSFF+gCQfAFEqDwC9ZvRIY+rmpXk2DoIkqAH5WpsEgRZvlLpCrqzeREe
 iFOhn8PmsT0nueqbjcPjEjJ8FWOvQC0ssLF8nRUyLZBWWqum1RPbdVWj/wzz2oRCXzbT
 uV9S5g7qHbtph40GrALblgEORWt5IToJy/WN3gtnlDQPnTPkpHvr4ju5TZpF7ChG18Ja
 0xqvFBoA0vaKBADelrd9j7RyyLo1SQMY7SUQNqgVgzwUx+muDB5j9otqFOkfW0MJviJR
 FCkPSzaqnDrcjotXF4CBY+miTK8ZRT9RGcF/esbkrTD5BOUqyEevokVKiW296wwf6+bZ
 JTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970853; x=1728575653;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H4iuofAzmjQ69v9z61keFGhIgoYW/hbzQrKzWVkUNAU=;
 b=Qu4zwnNYsHo0ni+iUVnzxxehb5hOYVJmXNQeKvWUF/Kg6yxNtzae1Be9tAwNGaeGFY
 WrMCIILxkbOC/DSf1vByczzCHKHmRZDfBazqi92RNkLP9s4wDDAVo7PGO9FPn8QHBiTe
 hepYc7NGCYHO1vPlGKsv7hRbRMFQLdzn/b2gRyRwEoX7iOckfut0mS43UlNdl9rjlIkO
 2yUw8XiCCmT5Wd3DwId2FzmpF5KyjQiOyrre60buO9IcXDuaEKrLkHnJzlxFiQQjMqX/
 XL8kizvEnqexVhbtulssN0CLnzBktZDBiWMLOqj/FOAab36oPPd0XFLctDFmJoPpZTz+
 7q4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI/rX8upnG5n+AJOIJlWHIp4aNMHHIrrr1wWfg4ctw/sRJF7/h5RWb6XjU/7ad5m2+5l6QX6qdsSpf@nongnu.org
X-Gm-Message-State: AOJu0YzAXwVuMOB9J3jN8pr6sX7diewlVajQTw2bw6VgavrvYWRaI+2e
 OsZBRbi07Cs9daDU5SBMNEF7nzltPUYVeyCO9TXmddv31bm7oucjXzYB8cUmZro=
X-Google-Smtp-Source: AGHT+IHOFx7F6Mh8L2bDLOZiCcAxlvdHMiurNEg/B5/5c5WNtylAf8nNky3eRxTMqVAOpefllBXKxQ==
X-Received: by 2002:a5d:5d85:0:b0:37c:fce8:b51f with SMTP id
 ffacd0b85a97d-37cfce8b58dmr4154026f8f.27.1727970853296; 
 Thu, 03 Oct 2024 08:54:13 -0700 (PDT)
Received: from [192.168.13.175] (49.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.49]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082425f5sm1544489f8f.50.2024.10.03.08.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 08:54:12 -0700 (PDT)
Message-ID: <25c66f65-f642-42d8-8b5e-46a3a6b97909@linaro.org>
Date: Thu, 3 Oct 2024 17:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm: Avoid target_ulong for physical address
 lookups
To: Ard Biesheuvel <ardb+git@google.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240927071051.1444768-1-ardb+git@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240927071051.1444768-1-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 27/9/24 09:10, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> target_ulong is typedef'ed as a 32-bit integer when building the
> qemu-system-arm target, and this is smaller than the size of an
> intermediate physical address when LPAE is being used.
> 
> Given that Linux may place leaf level user page tables in high memory
> when built for LPAE, the kernel will crash with an external abort as
> soon as it enters user space when running with more than ~3 GiB of
> system RAM.
> 
> So replace target_ulong with vaddr in places where it may carry an
> address value that is not representable in 32 bits.

Yay!

> Fixes: f3639a64f602ea ("target/arm: Use softmmu tlbs for page table walking")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   target/arm/internals.h |  4 ++--
>   target/arm/ptw.c       | 16 ++++++++--------
>   2 files changed, 10 insertions(+), 10 deletions(-)


