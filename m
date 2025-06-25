Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6380DC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURZc-0000ql-PT; Wed, 25 Jun 2025 10:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURZH-0000ig-7m
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:57:43 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURZ7-0006oX-CX
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:57:34 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b31e076f714so1026690a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863451; x=1751468251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+rciLibNP8bjqKG62fHEAUvmmavP2GihcTphTY7eAak=;
 b=NXxJtVTlWj6fgpnbX/mHYOsCCUD4GGHV9H+Ru2EzqjjAdJU99dc6eOmOwg9piljkCe
 B2fxlKdf3yRQheJJlZCuyhbYA+wR9BNhH+fFOiswOoDOD1HS19SZdrOVtEKkzP+ms/8s
 ojAi/CXxBboPUeujochHm9sBy9phMY+X6Ohiuyp2u3HvI+0FeugQlzT29GGh/yvloaW+
 DfljgL4CUbUibhVtWkAffVd8CIKFzY6r926hNs3OYUy2NRbx1VT9TQYKaR7qDkoL+CVI
 fU+EgQvoGtZH0cuW8eP/NXvsXK1tFNYMDAkrdnK4iHNCoxsxpEnN5TRLh+6VauaDpfWk
 lnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863451; x=1751468251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+rciLibNP8bjqKG62fHEAUvmmavP2GihcTphTY7eAak=;
 b=bw0AcNxM8E5WT/ePfGoH1loDsE3llbZfTADN057ZDew50/pawYUJEiMqArj7fi3ORq
 Sl0ssOnopsSvgSLEh7GG8h+kFYsGokOA6sHE6ep+kpLZUPGlj36Xsr8Q2m8hfXyIKrTl
 6dkX8M85wnhTp00YyCp5PS4cvjIp/VSD62XvYaMx2RBwOCqlY4DFLyc/XPaY9HmgipZv
 xwh1T1aFjJkur+153sQnFkt6WdpW/Sh+4hz36wO0J61LeQAKE4CstURzoOivg6D68jZG
 kz7uusbn63HHOi+ZYFaBUhm0SN3LmJWt4TqY6GKlI4HCpYpnHcxwHPT4Q+BB/hFPFN+i
 mNcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmLsFeiTpplv3ocZvcd8mkYy553XANIHhuyCB/fhZVi+mMXGANNOR0Q3IQPN7vlu/8DWRWtn+YiHZA@nongnu.org
X-Gm-Message-State: AOJu0YyskWC045HPZtpvzeG5Oj2ow/Esbcoh9slP74rHiDiWk6un0whs
 j9wSdkvE1Bk+v/Dtqd/7pk7dpJitQfowrsd4Nhvjm4Igc2I/TbnC5NLVr9Rs5MF4Sn0=
X-Gm-Gg: ASbGncs+b2kJMMNu8/JdKnjoLrlpyWrAZw8ntz8I8tc57FynBLaHC3CTTfdh1NGchGF
 KZ1pQsZv7GgisaNrbIlRAXC094WRiGUkV9u3e/nku82nl2i7gOW++XbI1tVCcoZK2gGv8eQRcjM
 ka7nCAxwqdrdJjA6mHqIPUfULuOBXCQF+jPA1A5l5JpjrQQ41VegRXo+5dn9LphLs7agi9JMXtT
 iqi2OrY4JDtcNgC7UvCxa9BBJz0nuqq0dtekEgaLIaiOC5lY6nwhpslxDBgf89K+gh3w4fDHgtd
 hKeiKgnLxtw8KVarHbU+mI+fQXn8Tm3EhFuVMaByFsNn+rZYLIULJh810bSYneR74v9Zym0w5YM
 =
X-Google-Smtp-Source: AGHT+IEsgVU2sOYzjacnKXbgYZzrnFPXmye+uqCnxQ+Gyj3enInUjcmiOEviXovTLA3AB16FnBLgZQ==
X-Received: by 2002:a17:90a:d64f:b0:311:83d3:fd9c with SMTP id
 98e67ed59e1d1-315cca1a32dmr12328372a91.0.1750863451248; 
 Wed, 25 Jun 2025 07:57:31 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f53f1923sm2085370a91.46.2025.06.25.07.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:57:30 -0700 (PDT)
Message-ID: <5e8dcb61-8ce3-4575-89e7-c09a5e4444c9@linaro.org>
Date: Wed, 25 Jun 2025 07:57:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/27] tcg/optimize: Simplify fold_andc constant checks
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-26-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 6/3/25 1:09 AM, Richard Henderson wrote:
> If operand 2 is constant, then the computation of z_mask and a_mask
> will produce the same results as the explicit check via fold_xi_to_i.
> Shift the calls of fold_xx_to_i and fold_ix_to_not down below the
> i2->is_const check.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


