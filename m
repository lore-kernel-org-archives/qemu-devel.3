Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7FCCF2576
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 16:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t01C5-0003BY-T6; Sun, 13 Oct 2024 12:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t01C4-0003BN-Sh
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:11:44 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t01C3-0004Zq-B2
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:11:44 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e5ae69880so484956b3a.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728835901; x=1729440701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=paNHDb2zQ5IqAg7BvwUkFh63YkVRjPVv9pcsIKgR0iU=;
 b=D2QtWwH/JvVYYPG6mNVOsLliZYg3+eODsHqgcOrCDYgDk/2MOXwi9nwx378KXkVLy8
 F7gQXNUp7CLDGXvwRFSBnpaW2OCY6eJHurrjMvfIeifW9cIeElMI54nayuwUilQ9ocPu
 9NIJSAfbKLnGSGGi0EYRcCaFOKyGYlxL2XsEZTuyMGIt9wW28WQ4lK1wJMbd6rU3NEnO
 6fcpsEnHmBpmtNthayi5HtJtZaFoPW+sucy3eR7AxNHz1zpWHLSlJKPOdvtTWw6knEWu
 B4Eg6Tnuj0KkjeTn4vBKj6Zqs0/gVl4PYS7USw+7RbjX+HuSRHyeg8OdVrhrx118XlDG
 Qidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728835901; x=1729440701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=paNHDb2zQ5IqAg7BvwUkFh63YkVRjPVv9pcsIKgR0iU=;
 b=N8/u6Y2T0mP2roINOTpOCmrppBn3URhRcwI8EhO5XU9S3mmxo/gy1KMdS1mWKwC8tE
 XMKJpsVeQ1GbDI5mlHfv7fQHoJBWJp7rZs89/+DygwgAZeR/B84v8eXDAJKke4jCXN07
 minXJHFIwmQBsaP+LoKRHFGfUkzGUXYl2HhGyFZ1GO3YXHj/TcD/rJIko/l24J4G+twz
 /tFgCes7tp4ASoNvL9fHU2xgc4/HK8kdANv+cXIIIm3WMevOIHQaucgNZ9BVUGWCXFAA
 3oB3/NGJ4If9+ddNKGranrfP3qmX+WMvblNvcz+vrC2+UQeWso3DTfNeXmNkALId0zpq
 PRtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNt+VOgQ0C9dlp2qEN3V59Gut2qPn1/QvQmiHDi2PuJu9pZaB7eWQvCKMUOrQ1CH0gE465AUY/K9bV@nongnu.org
X-Gm-Message-State: AOJu0YyFVd+iyprqSfms+Ogve7Vd9CzN3QOLyM+oXYEHXKRzq7+5tWOS
 H+QlZ0XCY7pEgTHJhDfDs3kLCTI6mvXujag7ztDI9o6o+FE+4on5E/A3mpuPHVQ=
X-Google-Smtp-Source: AGHT+IF3wvpe/yL3L2RDLq7hlXvL/0qx6pncwZts+SJAv0h6WpDdI3Z4pVQGsB6d06FG6xz91elZUw==
X-Received: by 2002:a05:6a21:3a85:b0:1d3:4675:fc06 with SMTP id
 adf61e73a8af0-1d8bceef316mr11085739637.10.1728835901364; 
 Sun, 13 Oct 2024 09:11:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2a9ea2b2sm5839685b3a.3.2024.10.13.09.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 09:11:40 -0700 (PDT)
Message-ID: <fa8d95ba-2e88-4b93-a5fe-daced3cba3d4@linaro.org>
Date: Sun, 13 Oct 2024 09:11:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] target/mips: Use gen_op_addr_addi() when possible
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
> Replace tcg_gen_movi_tl() + gen_op_addr_add() by a single
> gen_op_addr_addi() call.
> 
> gen_op_addr_addi() calls tcg_gen_addi_tl() which might
> optimize if the immediate is zero.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/translate.h               |  1 +
>   target/mips/tcg/translate.c               |  6 ++----
>   target/mips/tcg/micromips_translate.c.inc | 12 ++++--------
>   target/mips/tcg/mips16e_translate.c.inc   | 15 ++++-----------
>   target/mips/tcg/nanomips_translate.c.inc  |  4 +---
>   5 files changed, 12 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

