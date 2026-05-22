Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4E7CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 16:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQT7I-0002G6-6m; Fri, 22 May 2026 12:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQT7E-0002Fn-MQ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 12:52:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQT7C-0001ft-Ro
 for qemu-devel@nongnu.org; Fri, 22 May 2026 12:52:52 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8383fb7143aso3447944b3a.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779468769; x=1780073569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iTs0HTuur3HWB23RVI5stuEqHFJEBcNEWU7eo6YsS2s=;
 b=VtFB6ELJ0G3UDwk1vO2lwO1O0GO8JUt/T6D4lN9n6WuN4PJoZho3//OACYh80pcZpf
 LkeCUPhlemgNy+LDAA6u2IcdLzeYD1Yqu5xEkC5Lbi23CeDuqaQ0UWbUsgMvlFABSEbF
 FMqBhDZf97wOxn0vMc+fUnnAPstZLLqxWLqVuI20wrkf0rBWnJ0CjXwDKdubM0hc87Sg
 BVUPtWQ2Zvl776sxFWIoQOaOlnJzvvOkWWOuDpiHXNJwvNBD5Yld+IY9I/phQqQDPT4V
 VjdrHxPXEynmfaRHXIBr9ENDwoguCn9J6votwT/M4Akmd6Zbu+60DV7cNPhhixc76hTX
 kFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779468769; x=1780073569;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iTs0HTuur3HWB23RVI5stuEqHFJEBcNEWU7eo6YsS2s=;
 b=l+Q9Tw+3cPusyvBdQoO+86ZsuGh6BRNkU6HduSEU75/xEGdfDBtr7LOq3vqdDCaHGU
 wOagf/iGCqSK5pOfl0LRLBPhDrHitppD1kNsj345CBiq2K0xDKdtpilTZrnx+hAJXep6
 83q0v9vD1TtT0gQeW+Yao7UvVND5QxZqnELJJJoooOX2tryQWG7FTEqc0dD5xybNr20T
 uL9sJx4Y+I/ss6a9q4gPd7gx1xTNMajbHfVxMVq9MRzNx1dnvaqCQ6DXtUGsp175vpuX
 HFqAaV89wLRVPpwOHzJ8gE9+Fmw5yWsdiFxjdcchfMBMChx4WQBg3W3ZIq3WwKGhfKcl
 Mbyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QPhsBMOJjWYFt9/HTuRHsIAWvJPlQgZCxC8vKCaqXslU6OZEBQhh6f7E9sJ4snhiG57nV/h4UH5PQ@nongnu.org
X-Gm-Message-State: AOJu0YwMmr8+QKJG/gIy4m8fzoK6rI6CgZw9jxtgSxe6v9oIonzpKHSS
 FH7u0Rx5iUEaeItr90tM+5et5pF2oCZUeQMAlUMAwaXZfyYidKOSSzrdB0sfvNSiujY=
X-Gm-Gg: Acq92OHWxy8vRffNCRFfIN3kKLnzGevt8zpXKWwf0IkLBwWP5H3hbELn/pyjP4bqcoe
 uz7wq8bU8e2Aolwop0/HCf7R9kFm4v8kEi23or+fP+WJNTCJpw+yEtLmyUxK1DJx8PvRCjVAE+T
 haR0twJiKMWUSNwkiQZo3Yh6+YzediFN0k0C2It/cLFjs3b1wEobujDQOQlfaPCQo8s3wnJuI0D
 UE8rhmN6NHol9jmx2jJPXO4KMvik6OL+jlMuMu3PSMn4GVXqyvrTJ6WmXkAYs8z05U1wYui/mJ+
 mQE8//1h9O6zO30MhbZGWOfcAtdRQktj6cVRiKsHdGzfaTpxtx1LXRFWSBYgV7zDoi863PAGR6O
 EOjGmO2YKxqKrlYVNZN9W7NAsaafcD+0NN6WRrZvoPixlMswgUyTBWOMmIb+TWopxMtjGVvKWgD
 p5Kq/U14Xk2G/qf14VxvIefayofaXbF1ZAqprQZ8fp
X-Received: by 2002:a05:6a00:2d1b:b0:835:3730:571e with SMTP id
 d2e1a72fcca58-8415f3a944amr4464641b3a.5.1779468768956; 
 Fri, 22 May 2026 09:52:48 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164b0427bsm2887447b3a.22.2026.05.22.09.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 09:52:48 -0700 (PDT)
Message-ID: <e8ac274e-1a59-41d3-bca5-43fb842b8276@linaro.org>
Date: Fri, 22 May 2026 09:52:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/22] target/mips: add Octeon ZUC COP2 helpers
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v14-7-fbf08e164830@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-7-fbf08e164830@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 5/21/26 22:19, James Hilliard wrote:
> +static uint32_t octeon_zuc_fsm(const MIPSOcteonCryptoState *crypto,
> +                               unsigned int index)
> +{
> +    uint64_t pair = crypto->hsh_dat[8];
> +
> +    return index ? octeon_crypto_lo32(pair) : octeon_crypto_hi32(pair);
> +}
> +
> +static void octeon_zuc_set_fsm(MIPSOcteonCryptoState *crypto,
> +                               unsigned int index, uint32_t value)
> +{
> +    uint32_t hi = octeon_crypto_hi32(crypto->hsh_dat[8]);
> +    uint32_t lo = octeon_crypto_lo32(crypto->hsh_dat[8]);
> +
> +    if (index) {
> +        lo = value;
> +        crypto->hsh_iv[2] = value;
> +    } else {
> +        hi = value;
> +        crypto->hsh_iv[1] = value;
> +    }
> +    crypto->hsh_dat[8] = octeon_zuc_pack_pair(hi, lo);
> +}

Where does HSH_DAT[8] come from?  The docs only mention HASHIV.

> +
> +static uint32_t octeon_zuc_window(const MIPSOcteonCryptoState *crypto,
> +                                  unsigned int index)
> +{
> +    switch (index) {
> +    case 0:
> +        return octeon_crypto_hi32(crypto->hsh_dat[9]);
> +    case 1:
> +        return octeon_crypto_lo32(crypto->hsh_dat[9]);
> +    case 2:
> +        return crypto->hsh_dat[10];
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void octeon_zuc_set_window(MIPSOcteonCryptoState *crypto,
> +                                  unsigned int index, uint32_t value)
> +{
> +    switch (index) {
> +    case 0:
> +        crypto->hsh_dat[9] =
> +            octeon_zuc_pack_pair(value, octeon_crypto_lo32(crypto->hsh_dat[9]));
> +        crypto->hsh_iv[0] = crypto->hsh_dat[9];
> +        return;
> +    case 1:
> +        crypto->hsh_dat[9] =
> +            octeon_zuc_pack_pair(octeon_crypto_hi32(crypto->hsh_dat[9]), value);
> +        crypto->hsh_iv[0] = crypto->hsh_dat[9];
> +        return;
> +    case 2:
> +        crypto->hsh_dat[10] = value;
> +        return;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

What are these?  No mention of window in the docs at all.

> +static uint32_t octeon_zuc_tresult(const MIPSOcteonCryptoState *crypto)
> +{
> +    return crypto->hsh_dat[11];
> +}
> +
> +static void octeon_zuc_set_tresult(MIPSOcteonCryptoState *crypto,
> +                                   uint32_t value)
> +{
> +    crypto->hsh_dat[11] = value;
> +    crypto->hsh_iv[3] = value;
> +}

Where does HASHDAT[11] come from?  Docs only mention HASHIV[3].


r~

