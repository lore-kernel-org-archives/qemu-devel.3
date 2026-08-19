Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F5FC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmTO-0002Cj-Ek; Wed, 19 Aug 2026 16:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmTG-00026U-WA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:01:11 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmTF-0003cc-FD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:01:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so9890555e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787169668; x=1787774468; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NkWuS5LSxbD/ixrh6xT6e/tQisqs95xYiFhZ4PdFc4I=;
 b=d5UeA0drKzjou/bUfv0eXT4ghN8e0YeTohyBlVB3DeqIn0A/Sv5csi+H/GiBZ7MRoh
 kcSZVGEfN8a7cnWgJvSHRV5mS+k+qh4DQRkfCT2fwvL8pF7DqUocXb7a5604T1xYqp0m
 RYpvDf5RbKHvj43Mf91+h1A5wKyVu186MH2dtmBAz4YzCtdhdCDt2EMXymcWzOUPGkPq
 mtTg++fCcSxBGqe4dnJKDB190P0QbPRHm2Z2N/AmvnmRImqed4vuebplSc9Vz9YXjY69
 HDIByBHRELW0q+HkPH/MyVcWtXfZn567vR3SewO7GMViqMsYgvHQA7YnOTvQQD6olP2D
 MwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787169668; x=1787774468;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NkWuS5LSxbD/ixrh6xT6e/tQisqs95xYiFhZ4PdFc4I=;
 b=TS0l4Zhrm3jS72dHVkjW5rPhMjqKWiYjxkPpmTrWz+IUTyH+XNc1Ygn8S2LDA0+iPy
 QWg5uaJbcW8Fgw7Z0XZ4HWx2wFRe6GAw3oso9rg0eYof8nbEhGjGKL62p4yq8O9rGKsW
 H3fGRu3ZQpFzfER2c431aGemX6m36e14b5E/KZNDI1k+Ywudz/Xkb/H9Ac7ueaZ5amom
 OI4lgCwBSnGUDW02oxxGzZnrSz4fRYqXsEtpBGUQMJcjq8ASTTlgjFRPUlj29Vzg5sc7
 P7WFFnOXb/NwvlxKzS/PsqL2TdB0MFyH1kFJrWPMPYhkCNviDjGLiH/8MahYk3+4AeU6
 EA2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJsz77HTFwtTptcEiEI+KyZvp2f247BdnzXqanuAD8WVPnFE+18UdBTT7ZJmoxnPlpbMb2dhyJik5K@nongnu.org
X-Gm-Message-State: AOJu0YyunOTpwE9tzmEqbVP1+70Sui+X8w6mUuDTtTzv56owSfU7tl/j
 B1Z0ojBDT33RthJMiCVI4JhrLMX0tKflHOXIRooFUF1Cnam76IeUBsdZYG4UJ/06jbc=
X-Gm-Gg: AR+sD10MRXEUjwzUNyM0hDrZyIh83XxcRdiRwaEZmURmi6t12jpuSbRAKwEz8/kw8Hx
 slu72yahmrGLue3I9yHE4C38W3MbDysyMmbBacKuzDc5zjfFCNKvmAN4KUnrI9AW/sJL9KKM4EI
 4djQ4iMgieZaLbL+UCc5OcHiIY1y/9bJikzaHvMCRvbbpA4QbUsXDfJb/5AzKjG9gRUeVfQwfdV
 vMx4bt9uw5oWH4gpEHjD+MzN/C0MlHatxI17/9ejPQK+Avz4H3R3/McEJU2/IJpG7BtH8dMEBJ3
 ZUPEK7Gqdwtv2OqZMEP5CQN3YmYYo3eNnWySvuT2wbTvnvTb7ghrze3mP6eBlsscUGo7P5Cgkii
 fZhnffpfVJCNI5PR42q9vJq62TE5bjWXRVK96Z4aKt35hNeeos9J+TxMT5ybHpZLlb3lAlbChvO
 Rhki6ElnHSaGpn5zz2Q52M0Op6vSVlTB28i34BsZWVRqc1GhV08YXH4y75SKrZTfXawVuxWCmD8
 3/Tcs9a
X-Received: by 2002:a05:600c:354b:b0:499:872b:abd4 with SMTP id
 5b1f17b1804b1-499aa1a1f2bmr114214205e9.6.1787169667586; 
 Wed, 19 Aug 2026 13:01:07 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9b6d497sm74450895e9.1.2026.08.19.13.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 13:01:06 -0700 (PDT)
Message-ID: <1fce34d4-9f51-4d2c-8dff-23550650a38f@linaro.org>
Date: Wed, 19 Aug 2026 13:01:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] accel/tcg: Restrict EXCP_HALTED handling to system
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819145649.23439-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
> EXCP_HALTED is defined and documented in "exec/cpu-common.h" as:
> 
>   #define EXCP_HALTED 0x10003 /* cpu is halted (waiting for external event) */
> 
> Since vCPUs can not be halted in user-mode emulation, guard the
> whole block within !CONFIG_USER_ONLY section. No logic changes.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   accel/tcg/cpu-exec.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

