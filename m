Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70500C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZFS-00035h-Kn; Thu, 01 May 2025 15:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZFP-00030D-EV
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:07:03 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZFN-00057Z-De
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:07:03 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d940c7ea71so7212025ab.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746126415; x=1746731215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Pr0ZTtrxxWlbqRuc7hGMdv9IMHjrV4fkbELicrr/5Y=;
 b=YWki8QYtPAYPeOEpUypjBDBgGaiZS4ohcybjJvNJExfNy6cbiID4sRLIgOuX7rikFq
 yBlvOSlGwyjBejLAhcPxEgrvhVYDzd0D6tp3TDk7hjJB72uJDDVIedHnYYwDK+GF6pwu
 LheenQAwqZd2vvMj0BsBup82DMz8h6vHFDb3/19jTTSVA68TzobUjdr2GgPG8kVxGguo
 xPlCnDTZxgU5/5HkdEurHa3y2U0sAGfxgJvYIJbcdO7Rly3WTxCzn95CP+p++sqGLKHr
 xPTTqLfE1qUF9Dw2X0rrlR+8RNEdkz9rb4nsByZKGTt1DKrgpVTZMrHfUkpdMC1ObVFA
 5izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746126415; x=1746731215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Pr0ZTtrxxWlbqRuc7hGMdv9IMHjrV4fkbELicrr/5Y=;
 b=gUema56vbRuXqpyNleaZXC8GFkf0KDYiSAGxs0ez5c7K3l6nHut/1Awq7dJeXqwEqo
 6XTtTlZj2df8rjFyKpJwF3Qvj91O+si+Vnvspqu7djV1Me+v40f/Y4mf/Csix0QFE3hP
 aQBXR4fx15EQy5UcHwfdpxEy6VAb4FFfvKU/Oa/PvEnJ/zleEpBZwEfR7DiJVTkdQiPr
 WIWC+7LmVKVoOAnt6xzU6LTx4fFldPsEJBDdorLzDt6u/+9+fKO9BH6VAWuOx0sTGO6l
 59ZsC4AycACnQkMXrb8SZhEMlcpauCMyAKBrR1xQxe5yGeXB0CAYtENxL+2roMOMWZKN
 w7HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPFJXtAvdmrEipJmZKlF42oxAszsZhsVNvDwCdsCM0qLsRLPpPelxxP5NpwJON/loRzGYx6F1r9peI@nongnu.org
X-Gm-Message-State: AOJu0YzUPQ5OaH+/5NdjcNPzAuYEGgmZEQ/PjyqDpGGFHCvf1UCcgQlB
 FdbMtAWtLC59zwWOpquSsPR6a4agoP1mNH8FuyMDTQ/RM6qe9iH4fUC2pZ40ajM=
X-Gm-Gg: ASbGncssbQg8CaBOSnbq8L5Sb0xIl8Oi/ooKU8sfwCW6W0EnOsifwm2zovNau4SjbCQ
 jioSsUXaXqDZ6KHGTMgI6WP+zPF8M55Bp6lGfdH8qA4ONEO3Ot6S1IbWW6t6Outi5FV6CLYKqBX
 SggsstaTqtFwiS+TXACujbT8XYrGQifJKciyMAnWUbh9cmTEZfmLgKa8+JqxtG+uC3oUhju6VSN
 lTGT6yu74WwznbSzSnSjpP589yZXWsr3eQUY33mHBVssvaAK70z0ni0JzvGI80fPBhOXaetESvc
 gauOSjqwaNFGvpb5YJ+qw5fUrVdGOYyx1Lzm6sOgyO60w03Agydn02oXC6VcvFpw/z+80HcKD1M
 x2xPKdwkBq6qfew==
X-Google-Smtp-Source: AGHT+IFWe47sTKQaDKHadNBexo5LU2njaufHJh/pzZ8fp/gyYC1c73rGYd7uWAJ2tQ0v6YOC57URfA==
X-Received: by 2002:a05:6e02:1fef:b0:3d9:64e7:959f with SMTP id
 e9e14a558f8ab-3d97c2607demr498335ab.21.1746126415659; 
 Thu, 01 May 2025 12:06:55 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa5896asm355173.86.2025.05.01.12.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:06:55 -0700 (PDT)
Message-ID: <39751e9c-ab4c-4daf-bbb0-d9ed01943370@linaro.org>
Date: Thu, 1 May 2025 21:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/33] target/arm/cpu: remove TARGET_AARCH64 in
 arm_cpu_finalize_features
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-11-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501062344.2526061-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12c.google.com
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

On 1/5/25 08:23, Pierrick Bouvier wrote:
> Need to stub cpu64 finalize functions.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.c         |  2 --
>   target/arm/cpu32-stubs.c | 26 ++++++++++++++++++++++++++
>   target/arm/meson.build   | 11 +++++++----
>   3 files changed, 33 insertions(+), 6 deletions(-)
>   create mode 100644 target/arm/cpu32-stubs.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


