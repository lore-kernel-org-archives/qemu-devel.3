Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AC3D2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vej1M-00021b-0J; Sat, 10 Jan 2026 19:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej14-0001y6-JA
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:09:11 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej10-0007Nh-HS
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:09:08 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso2331827a12.3
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768090145; x=1768694945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fLzqvaaS614LpysiF+r84j46WcA50sRfB2a7NRsSYi4=;
 b=LaP5RNTWvdgBCbZztp9DK095oxhBJA1ttTr8/Zt5WhPdhH/BJogLpIQj7WzdchcCka
 ntJhp+lwzSoTUrLAViHJ2tWw7MkVvLPvMZBONzs7VX50EjRGjbddobv3B0ZgNchnCM4y
 TzDElvWJBDCUCVcV+z5QHOmZUEAU7TwKwQiBifnpI6MrKsf6Zk3PJHd47og8Wn+GosFs
 FJ1dS3UK9WW0XO2kwnVihxGK0n/BOR1Vm61AbKQf9Asp6ICd5BBKO/7UIuPgGiO/wqlr
 Ivt5EtM8C2Dh8gOVuq72i+SlsDpuji878uiO6ftFhibjLMS1DuvM5MvJMcc6cziz9y3D
 LfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768090145; x=1768694945;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fLzqvaaS614LpysiF+r84j46WcA50sRfB2a7NRsSYi4=;
 b=SiOfDEBrbcHQXtxn+Pm3wg9DjZ3GzeXdLzjtmTGcVZ1xHRitzbErnuUG7H8ATm6eK9
 OaibDg7IKXPKHNB2MI78sOtcpqsmlMog8nHo1vnGe7EFWF5YeLtSLg3yubf7NLPLQ/L3
 ESBHcHXezHw0ULmBoCTyZkg2VAzvTd8e6tTWlzn/0wLE6HnBrqj/YGbAdQRnHOM095rX
 WNJF8FvkZFrgBwbOVYs+MKeY4iTR2g3gAplwITJZpMg/acqX4oxerM1zGCuUPgxQjSzx
 XdmY41K12vD2Uhjnfk+jS8fKVmhT2hHVICy/mvL3Pk3iFvAkZWDKDSPEM0Y7S9287Jvv
 Oa0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYKj+2qZjlxIlcVUPuhtoX/j7ze5z+FPmVZxtCoyL/9z0rd+5e9uWRU/aavkoqAOe+xs7kbXaJvVRx@nongnu.org
X-Gm-Message-State: AOJu0YwfwdtEm3ohSyzStl7OC3L+5j1DrdfQprHyHpnKeT5kiId1RL9L
 YvDH5DJRsk8BsJa5ww4ZnGkCXc7GcF3u6t+79PbBUWQzH5t5zILeIWRQg8F9UIEC+So=
X-Gm-Gg: AY/fxX4R0g4m/Lw3PcEIgfmm/qMvZgST65thui8VtLiq0uxSWjXAqtlWy6TFOdi1MLi
 HA8br6LcLzNsU4zO3XFJ/Cv07kYB5zMxP+B5d2zoJFSGDpZ370zcGkb4phy52JHMHrtE1JDg3zz
 e92beDvp7kcAHX+T8wIBz3+FQaI6TVgHECyT844K0JBlpVar0z1WlxW0RPBRYrZZSMOlA1vlREV
 KbtXMiA+YZD80wVlhQSFYjlLatF0WcVnL/UQSxa4bVNBsiLUoII4LvFgf0eKVmUdmbaL5mNoX9Y
 FVultxbgnakNMGBpog2MEyMVaz4ijpzUpm/oR19xxdAGnnsH7XryWnRURIvkBw/zQLakT4h40yD
 EEkb3XJQHqRAkBjUkbSJcNOU846sP0NJV36tOrlNIkLnriY1odFrb2bOVq6gPKzPUMGja5cDXGl
 GzOOeMJL2u7sUOejjYdNTrdK6xiw==
X-Google-Smtp-Source: AGHT+IEKGx6TF98/T6zd44hggCaYUWtl8LLb/SVAC9Puau93Cy47/Eq4R6mYnVSY02FWwG3uht5ZbA==
X-Received: by 2002:a17:90b:4d8c:b0:34c:60dd:1bdd with SMTP id
 98e67ed59e1d1-34f68ca4521mr11492087a91.22.1768090144600; 
 Sat, 10 Jan 2026 16:09:04 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6ae3234esm5593257a91.0.2026.01.10.16.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:09:04 -0800 (PST)
Message-ID: <d0a1be67-a897-4700-9b44-d849c25177b1@linaro.org>
Date: Sun, 11 Jan 2026 11:08:57 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] target/sh4: Build system units in common source set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260107200702.54582-1-philmd@linaro.org>
 <20260107200702.54582-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107200702.54582-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 1/8/26 07:06, Philippe Mathieu-Daudé wrote:
> Since commit range 42c90609b8f..82a1e739010 we remove all
> uses of the target_ulong type in target/rx/. Use the meson
> target_common_system_arch[] source set to prevent further
> uses of target-specific types.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sh4/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

