Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F19C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcA21-0003TW-TZ; Sun, 26 Jan 2025 16:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcA1z-0003S2-Sf
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:18:59 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcA1y-0008Or-8h
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:18:59 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21661be2c2dso63080345ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737926337; x=1738531137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X+G0ryUleEoZxvXmUvLzmbIUvRMHYbb2l6B2uT5mTT0=;
 b=DOoJznXee6jjCVqD8YDziyoR2w/JMH6M/OizvjC2df43E7+xhnOnIALv6G4when83t
 pO2XxT1ZqRRwNrxsFe67lk/nY11PTnsAzIBxtsUwiM4c3pmWvuIX79fX9834o2IIdrSf
 6ePVQUlp+LCGm8Gr6IEbKtMNIng192xvS7oQqUSv7JNS7K547smqUNnI8hr1Vp9zr2I8
 J/+z/E16x+XIUcB62WGv6oG3O8r3gURrm64sjjjEadyC4SINj8GYepXJVrFzmVNGDPQR
 6sL157B6QYdY0QK7nBYf8D0su3o74ynPwaeWpQJ0Ku/EG2YPGi+oTh7a9l4LX7LpuAgs
 DM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737926337; x=1738531137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X+G0ryUleEoZxvXmUvLzmbIUvRMHYbb2l6B2uT5mTT0=;
 b=eopDTsbmislW+/wlHDzEIyaMZJHgCQwbbgF4sesgTSN1S0vkbwhGymXhrGTJxmSNX3
 T4cC8ritwwJU9LJRYA5950VMo/WWjbze7Yycp/wS6jFT3WB1N51e3mHo2+XtJu5nVdRg
 PClC3z3RigAIinmzaAdQrnjEYXS2Um8ZCOZEv/l4icRUDhFGjZ1Yf9INTI9aSu6UIjAC
 yDGTIRrZ8kOlgd6sWPTqKD2XL58LRxUZW/5ooQNNXMVFeh8ShOQiY871oPCoLFu0Eobh
 pLvjlzwOY4rgko5PJ7vFvuD4H5NPM6xmjbwJgEHnCKjImTgcBx40wu0UJLOeFktInkVx
 HfGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQZUNENMu1Sn/nVy6BucG6CSo/3UE/lkkPjOOFCyL9NUJBL97KDCqrnFDNDjwelHUrA4nqMpqpHTyL@nongnu.org
X-Gm-Message-State: AOJu0Yx2OFGAqCABCopd2XzpOET8NVCL18r6ZyfjIGMQ9WVxXdi6MvVP
 Pp7owebDu5+1a60GUN9c4IYDG+veFZFu6auuaiMfJznZLRKxwUnBeIURMoup/cE=
X-Gm-Gg: ASbGnctHxwmJYTyPbQB4M4yygXundgr0+9aj9VP/ZeN/Qzraseoh7E2HbUWx83xtAfN
 T11/znd2oTo/jwqOVkz4k5ngUZL+QdzlNrzazga3annk8vRWjf/sPnVjL4oK9a6JJL6XL7gphhM
 GmpU7bynT6kBUc+Wnlgjnzgempr/y5Sr9bH7NgvG8I4KLdNE802cPTTVxy075eXN6HOvMP2Ul34
 FzOYZnUuV4L7CHTvIqxYhmtzlkNpPchFyU/1CWyfH6TBlbpkfD3bZj5fbb9AwFVDZeNOelAwubd
 TBmxJhK7y5bFnMq94/MIiqUf68qKk9ZnqfG/uEOGBznaqOzno24iCPCC6w==
X-Google-Smtp-Source: AGHT+IFqQ9SrCqtaqHBxnEeUe9wIIgiFAi160abwNWKtJLcX5dR1YlfbX/KbmypQ71AFHncXjFvVWg==
X-Received: by 2002:a17:902:db0e:b0:215:522d:72d6 with SMTP id
 d9443c01a7336-21c355bae02mr611350715ad.38.1737926336707; 
 Sun, 26 Jan 2025 13:18:56 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9db91sm50141815ad.48.2025.01.26.13.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:18:55 -0800 (PST)
Message-ID: <39ee3338-aa9b-4cdf-a06c-ab25341d3cd2@linaro.org>
Date: Sun, 26 Jan 2025 13:18:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/20] cpus: Have cpu_class_init_props() per user / system
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-18-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/23/25 15:44, Philippe Mathieu-Daudé wrote:
> Rather than maintaining a mix of system / user code for CPU
> class properties, move system properties to cpu-system.c
> and user ones to the new cpu-user.c unit.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   cpu-target.c         | 58 --------------------------------------------
>   hw/core/cpu-system.c | 40 ++++++++++++++++++++++++++++++
>   hw/core/cpu-user.c   | 27 +++++++++++++++++++++
>   hw/core/meson.build  |  5 +++-
>   4 files changed, 71 insertions(+), 59 deletions(-)
>   create mode 100644 hw/core/cpu-user.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

