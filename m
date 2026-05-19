Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550D0CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 23:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPTyg-0005fJ-KY; Tue, 19 May 2026 19:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPTye-0005ep-EN
 for qemu-devel@nongnu.org; Tue, 19 May 2026 19:35:57 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPTyc-0002PU-Sj
 for qemu-devel@nongnu.org; Tue, 19 May 2026 19:35:56 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-837dfccd950so1928024b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 16:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779233753; x=1779838553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hmp0CpG/IHRZbwhiBC218VOqIbzrm9kZ7PvKgUXAHok=;
 b=NhzwTT9qer/W5Pk8jARtaIT4oJrLIfhnJmzjGIZz79KL7ScLhnfR7H/mEcDE5zfwBi
 3qWyinQCwjB6HaaeIKVM1PP8hqAf4OM886jxhBdcjvFZsGO353MLlp+NlP0Nx3l7jf7D
 1Y1F0CK8e7bGxtbvx1GMDBs7JXs760ew6fIgHmFiauw8tCcxXFhd6GGVeNXwg+VEvyD1
 0xiGApdPgttEGfbt7kjPABRXUrY323BcsK6WcPe0p5DSIYkcpksq/g8FqBQDuYKaOsYy
 p7UgR6MNpwk6C/spAGE4SnQWpg41PmNtSltXwvQgXi/ojVORTdtoA4askejVTbTbvLPO
 0GBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233753; x=1779838553;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hmp0CpG/IHRZbwhiBC218VOqIbzrm9kZ7PvKgUXAHok=;
 b=KrpudvNagH1v4abfAiRQQ5r9rBSwASkHJQL0Po4ePGMzSyiqQzczzG7GaGe7hWTBy9
 DX6B45DJRM4TfpJAbUpDCqW0accnPWdZz6986On7uJbzFaDWjM/E53s5sH1SzNKNAuwX
 KxUs6uSV3dndrxS9Wr8rJKRPtbet7DoteSd1bXR/GE1V04GsbVazTlFVL91CUBsyseH6
 E3vprj5KANogpcFnW/K0b+adbfWj8XwPd2H/8CEtdJsYWgvtoV85x+NNIl/MfdN4V3W+
 dtnZJi04N3l4aEIvttGF7ZS4F76lPTBdEa9nIoBh23LA/1HGrBHIDL8Sg/195zKSL8M7
 yn8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ag0dFA0fcOq50DWaQBhiJMQmpOJ050gjoLy7Kk6cPNvI4/8p6ZOrD5DctMYKHiozwSjBjoL9JmbFG@nongnu.org
X-Gm-Message-State: AOJu0Yy9TuoEB/LNgZsxZe1ZVLXJWgQ1TRWqHkDDS5jFU7eLYRPg9zlp
 4qct98l4AeoNWQ8G8WWk6WLGeC4sR5uyYDfIi8EQgm57zMF2OJmQssuT/Vt19vLPX+A=
X-Gm-Gg: Acq92OHbKb4E80nko/fOe9PA53VP/kjiT8tMpyUeVIXH/DO0nQgxH1lzmaCjIaoL/C3
 gF0c2D0tmEfJMR/Y8JRrtKh3ic2/JjVQfKs6bDrDddhWHWj/KQc3ldZha+FZCW3GEavWZhAho8b
 RVVtcV3k9WtFl5S0tgQJ8SiammeX0DyBTz86gcawoAvDx7MoZ07tD5D53gAZgNe7QaoiYGhSAsy
 fTCOfnfVihI0If+ZkiuJHWHXN/oi9D6Lx2cJPGjYuLiRsO7H6a/NQ6rEWh2k6uWc//zcOCXzkwA
 G1WVAPC5SBNNrcUYH443x2+UyLbTMjSACO9i19e5gsprKz2Y+ir9VyrsHBPrxxe9s8p5K2/ak70
 UbefYT9DWR8NFJYmtPwIGeu1ZgOjWJbOjOppBy5pwR7em7+lCLa6JEmDTA0/vVIF7Mnny+nwcAe
 hgHCnn7PR1M/YNDuBtACH3vd9XAgZd56Cfxz/h
X-Received: by 2002:a05:6300:218e:b0:398:9662:10ff with SMTP id
 adf61e73a8af0-3b22e6685e2mr25092399637.4.1779233752475; 
 Tue, 19 May 2026 16:35:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm11012898a12.19.2026.05.19.16.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 16:35:52 -0700 (PDT)
Message-ID: <fd9960af-7ae6-4a60-8c7e-9dfb627a0273@linaro.org>
Date: Tue, 19 May 2026 16:35:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 25/40] target/mips: add Octeon COP2 crypto helper
 plumbing
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-25-d7dd735ecddd@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-25-d7dd735ecddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 5/19/26 09:22, James Hilliard wrote:
> +/*
> + * The shared HSH/SHA3/SNOW3G/ZUC register window needs selector-position
> + * arithmetic.  Instruction dispatch itself is still fully decoded by
> + * decodetree and calls per-operation helpers.
> + */
> +#define OCTEON_HSH_DATW(N)          (0x0240u + (N))
> +#define OCTEON_HSH_IVW(N)           (0x0250u + (N))
> +#define OCTEON_SHA3_DAT24_SEL       0x0050u
> +#define OCTEON_SHA3_DAT15_MT_SEL    0x0051u
> +#define OCTEON_SHA3_DAT15_MF_SEL    OCTEON_HSH_DATW(15)
> +#define OCTEON_SNOW3G_LFSR(N)       OCTEON_HSH_DATW(N)
> +#define OCTEON_SNOW3G_RESULT_SEL    OCTEON_HSH_IVW(0)
> +#define OCTEON_SNOW3G_FSM(N)        OCTEON_HSH_IVW(1 + (N))

What are these for?  The MF/MT offsets should be irrelevant now.


> +
> +static inline void octeon_set_shared_mode(MIPSOcteonCryptoState *crypto,
> +                                          MIPSOcteonSharedMode mode)
> +{
> +    crypto->shared_mode = mode;
> +}
> 

Unused function.  This patch won't compile with clang.
Also, as I mentioned against the previous patch, I think shared_mode is an error.


r~

