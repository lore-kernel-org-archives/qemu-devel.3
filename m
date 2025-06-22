Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3E9C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9KG-0008Pq-MX; Sat, 21 Jun 2025 21:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9KE-0008On-V9
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:16:50 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9KD-00064H-C2
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:16:50 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso2556405b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750555007; x=1751159807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VKbC4dtfTCrNR4qx5acT082N6ZlLhtQptoM3+zGOdNc=;
 b=uNJTK4hvPIa7b0UMPw09ABe+fnC83DnRi1m1EB7Z+CIztQmpAopFr+nfvgGbECTPDB
 6jPqJtvQROtfdnsMLRmln52Zb0f25Q/3L4A/a0nVvMF9vVVDGzjMPqBh3dzp4PK0bAkM
 RYJDQcZSdKWWsnQkKvoTGcasrwgDZFCIabZBphcQYH1wzzpQZFsF9aOBLJSNKcN/MIa+
 ITA25ZlxxJYD5TTj44ph74TwgTE6X8Gx0THdv0w6zYmY89I/Xc1BU7/S1NFrkNnp7Y0P
 vyjT1wbMrdL2GZxaJ+w1QkNboWKb+LRRchxUtGnvjeeg7YFrX1KkwFT+sKqggBbEJp6q
 tdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750555007; x=1751159807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VKbC4dtfTCrNR4qx5acT082N6ZlLhtQptoM3+zGOdNc=;
 b=rHY9Z+D2N4wZI7yYPMf0yIPJSjSEodDn9MqlJ0wxUNNWUTm+VFMXQjSVr48u3TWr1c
 PgYSc2N6wAECWfHakaueqY4lkE7YREti8z/KOaJavfmC8g4vBdy/Bi0WHESgzzusqKOC
 WV8wYdImSFGp86B7HaY5sG1zeMYBvPUfD6lXTf/P09KR8LI0qfafxvMZW3NKve/L9iBF
 COAntlkkyxAjS9RBaoSXUQ5GBm29iZZ/K0NoPOkcu8KZ1yskHUSSaD1orjBWmZKpnuhu
 ZlcWQYyFNBxnqUZ61nl9v+1uxTFjq6nP0pzjWOrxymLZv7uvt4Db0jZv1ZDTZaIobccj
 ihRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULcefiVZ520z4++AAeP2esVvxFM1/zGP8F/Yu6OsilXtsFecZNixraPlWhjTmwgRr1cu9PAaBEux3s@nongnu.org
X-Gm-Message-State: AOJu0Yz+CDEBBonvScGz6z8Ao9c9ZjpikWG22xG/lupIAH0sSJpVzgoC
 56tzwckPuaq05SygaceofiuidHY5z9L23iUC2Ou+XxAlOeBZNpzIYftvqPhRgoE74f8=
X-Gm-Gg: ASbGncsKewkGvHfz3u7kQGyOR0IECib3IcXgQPj2PvW6bE7qJciITqj2et+wwuWqShr
 dDll7YpMrLVdvrI63+B5xHlSD2H3pZeMPi/CnAxb9avcENVwuVRDlw0SUTlhYW+vydG1Goq0oju
 QqthFv1mA+l/yCssrNDF8XrdXUGsHsgM3IhStCv1wGxMcOeibeSWv7rUQn8illIhCMvfw/ab1Ij
 vmMemz4GlysnTK3el+U5W6LYO2VkauOQzWKvZ0M1jVk6g9i11KJgi44iuETT4+4+cSsc54FnfUL
 JEEPclzRPDej+U3GCXXDNISiRCiMHGv6fnP5ErPlv/GSui/Bb+SnPY1JiWdWy9si3yYZW7/IWjE
 +4f6JPwnbWblzP/SuX7cShOZl0ImG
X-Google-Smtp-Source: AGHT+IGVXWGWEpkqNRfUGFZAiHYaQIN5CnXSc1yXxX6D9DAve9nRc8177wYrAr50tscO+GfQ76wjVA==
X-Received: by 2002:a05:6a20:2589:b0:220:193b:913 with SMTP id
 adf61e73a8af0-22026ef740fmr13508530637.34.1750555007528; 
 Sat, 21 Jun 2025 18:16:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b5e8sm4956821b3a.4.2025.06.21.18.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:16:47 -0700 (PDT)
Message-ID: <d487d254-aeb3-48dc-a689-46098f3ce6ca@linaro.org>
Date: Sat, 21 Jun 2025 18:16:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 10/48] accel: Pass AccelState argument to
 gdbstub_supported_sstep_flags()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> In order to have AccelClass methods instrospect their state,
> we need to pass AccelState by argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/accel.h      | 2 +-
>   accel/accel-common.c      | 2 +-
>   accel/hvf/hvf-accel-ops.c | 2 +-
>   accel/kvm/kvm-all.c       | 2 +-
>   accel/tcg/tcg-all.c       | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

