Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855CDE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOK3w-0008Mj-Tl; Thu, 19 Dec 2024 12:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOK3v-0008LQ-Cr
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:11:47 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOK3t-0005mc-2c
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:11:47 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso10347855e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734628303; x=1735233103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CmHnEsj3gsaS1zdUBiynZBNgVYBd1XrnEMj/qbSnzLI=;
 b=TszhWQ6sBzJA5sCLF/G3da7SP/+FyctRLz3WR/7eFVO7lP95be0As+qeXEu4CsnP1G
 uTw1hdr1K7qQBzqHh3Tg6x0XXwLGVeqvtV7F3JxZeb1yxa4Omaz5fdo1/KShhObxjVqj
 32RPXuGW6BbnhmTc7b+ttL97vChYtKaBzY+YXmx2mXsua+I1xz5eXTDDgmWiBZLsEK5A
 jXMvquEaHPs1KzhZMEFSErkhaNfmJoc0br99vq/u1fJvBsry8f0430LYUe+qoFAcygyY
 xarBFoZ6+Lft2/zgXxkvxF+QI4P+24yg0n4yT1m1vbe9oPEeJylief1yw0X+Fny09jc+
 Y2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734628303; x=1735233103;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CmHnEsj3gsaS1zdUBiynZBNgVYBd1XrnEMj/qbSnzLI=;
 b=ippd/0lggQzKgSgYyQGbVc3UHc9r38mgJmsBi2UrU/TSYVHTBgs/q42mGZZWdkLCrN
 0e6MDQlCRcYtAyMQ16wROSJqOpxbl+8MC2V383hut/jqwFg9boO/KZ3RZfzFGoLveTYm
 Ib5YI0Yj0rmobBXh0gzPmOsR+b7Pm9//loexbdVkOJaXKmmScjaT8ARzc4tjCkG+U/y4
 pR5PmFhvtx7aU7A4P0RMjgT/0ivKfymCjfOXCo5GcMNoOGuhXfFZDnTIlmxvt3CBa/v6
 gmvOSGIxvk4nC7TJl882LoI/edJxesFQQ6gXDaXoeXiczTBd5nbP0aCUwZ5XGfJsdytd
 ovcA==
X-Gm-Message-State: AOJu0YwteYoqSBmbU8YhC2fajzSKJo2KN+tY90AvkIIAMdyWFLZrDQUe
 to8e++f8N3L2tqenaVjqZlDMZxkuQ/zLlNSEOVPeCwP7rn49xXEqBeA0pIkk1TszBTa97hOjzt2
 2
X-Gm-Gg: ASbGnct2L5FTjBSwfTuCJf5j8wJAMaIyWIdMQeTy4v8R6mHDRLVZtpCwjQ4CAqjHb/W
 sKaQXva6Qtb35I9as6w8OPRe7qt2NsPoEvIGYTWTx0uLMpFDgZQ4YjnnkqfY9PRocuLtiltnR7e
 4yDTCfuajqdZrlUk9Qc7NP0j3E4LfHy0CIdJTni7POgwfgqhNCzwvcKl544IYqwHFcUpf7wJ81G
 yromnisNqR9PmsQrG3npcGDpdaIGa0u1sfSJdMVMofyhCqKEKs4I7uNf2RId4IHsXQZULg=
X-Google-Smtp-Source: AGHT+IF+ZqXlAZt2iKiq6RbJ7N7JQxmAmuE6Pxkhc5ca1Mnl+qLhANmGSrqdNYRtpTI0ZVguN/Pu2A==
X-Received: by 2002:a5d:6c64:0:b0:385:edd1:2249 with SMTP id
 ffacd0b85a97d-388e4d99564mr6498460f8f.50.1734628303336; 
 Thu, 19 Dec 2024 09:11:43 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6aeesm57730605e9.6.2024.12.19.09.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:11:42 -0800 (PST)
Message-ID: <914c9d14-a416-4156-bd03-dc6764d17088@linaro.org>
Date: Thu, 19 Dec 2024 18:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Un-inline translator_is_same_page()
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241218154145.71353-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218154145.71353-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 18/12/24 16:41, Philippe Mathieu-Daudé wrote:
> Remove the single target-specific definition used in
> "exec/translator.h" (TARGET_PAGE_MASK) by un-inlining
> is_same_page().
> Rename the method as translator_is_same_page() and
> improve its documentation.
> Use it in translator_use_goto_tb().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Richard, I'll merge this myself once reviewed.
> ---
>   include/exec/translator.h    | 15 +++++++--------
>   accel/tcg/translator.c       |  7 ++++++-
>   target/i386/tcg/translate.c  |  6 +++---
>   target/riscv/translate.c     |  4 ++--
>   target/s390x/tcg/translate.c |  4 ++--
>   5 files changed, 20 insertions(+), 16 deletions(-)

Patch queued.


