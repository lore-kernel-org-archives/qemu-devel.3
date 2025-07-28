Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7BEC87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 09:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugKbf-0004JV-Nf; Mon, 28 Jul 2025 05:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKUX-0007na-3J
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:50:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKUV-00062I-2M
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:49:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4550709f2c1so33809415e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 02:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753696193; x=1754300993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3D7J30RQFQG+DjJEwtvkauBIYDeMJ+VAAqw8yNV48K8=;
 b=H8UJFsEcE1kfiZ5rz8xEawbxSGJAECCvtApaTY/mKycQjMFYPLzVIBBlQFlGiXpQ9j
 2DB6ihp6DCsED7dqzq/0WsurVnn2PFuli+tTgPX3FBCe+81TOw1tQz4t+iB6OdmQhTYb
 HnQw9RB/PRrwHr6rOhj3mtLsaLSgAyILila3GtNzkp3IP3rWd3WxY6RKdCtvmtYcp1wK
 YVyQb3LV53Ui77VJt9F5OfNGa5N0ve0cgSEvcgdNnccDMbmrEg40Ina1YuyjvP4YWUgL
 wToiF2l5ZFnWNhw9Q+5v7+QaOb7sDbfpl3mxUVnJRlFVThwsAqCqa0CEHZiKDU0a8tQ6
 BXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753696193; x=1754300993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3D7J30RQFQG+DjJEwtvkauBIYDeMJ+VAAqw8yNV48K8=;
 b=CUZ+Co8IWFU9MPL3um7ofhpBaAAYGvSjo8S3X+Ka1RUPQ+aBpj1jvdbGn567o69DIF
 KYYKVHH31U6dsqSqDJDFTM+WuBfxk9nme7Lt+if/9O18c3p6/8ILThVrLmgnOE1Fko/M
 oPkEsdFRF56Z1Tx5FrxqQdCMvc6hbtD8nrrWvJhoG6mlxx6GCXHzDFRPq9MVBYG15j0O
 7X+1PEldPhK17apU/e2iw5jLCt1zm8Fuuds/dkY6li+L1mi2l1ZI4eiHV5QIgBKWbbIr
 dF2KaIy3zwe8BSAxzOQ5MjlXN1pIHwkDjO6F+FWBgARZab+Te16dPsr38MhtCc8AB2Z/
 wibQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrwjeOHcOQO/Z6j18SA2V9WqgtWP8j2+zqfQ4VJ+2wIdPHSyPXumOK2dc3mHzD+CuC/Ahojavplyjo@nongnu.org
X-Gm-Message-State: AOJu0YzvhRlk4jqdGN/cKlW7xkIkH7uJ7389Z6Me3i/sQfLcRCzizIQD
 3tfMEcye/1fz49CK9NE3WJ+WlwxxqSBxIRTiWShIuxcKsp//R6/Y/xygjpmTMgaHFXs=
X-Gm-Gg: ASbGncuEBtmTDVEOQQkf8ELl71HV/2uzV6mMhLOIQ4uMfkwzqu8V9vIMUNPDJuUNfJ9
 N4WUubBeH9wa4o22CxjYow5fwi8n6j3ISJqBITuOtqAwB09TLTNEUtB4gJLcXIHHL9JeOpiW+Ki
 ud3slf3jDTDQ9WaUMajhhTSfPPFuvbdnltU0tEyAnT07uqvkJBl6csQ9KY7DXTxGBA1cawFdxhM
 obpa0FMQe95UVFkke4vQ8bX6q4/BfPgwCo35kgF/Glqrzo5xyfob4s4HMPrN0ng0uid+4xY/Y6Q
 AjumKqQ6TPlmrO0F/D9C1WAbq1vs+abasX8X/CI7hlr+ev78h86pa1cYcXZc05yTj3STHCsCA4r
 y1eonsR5/vvsKT5kK3Sj629eRsjkgEtfx6Fxe5M6WsogKymlCpMzzHXu073TJfRnqsw==
X-Google-Smtp-Source: AGHT+IGegy9CU15rwtsVqUgAtJEFFLzsbQSgW3X4UvOHbFJiai3KgHja7TqudIBBN2tLM4Hkp9pHEA==
X-Received: by 2002:a05:600c:1c2a:b0:456:191b:9e8d with SMTP id
 5b1f17b1804b1-45876313d69mr71936245e9.11.1753696192739; 
 Mon, 28 Jul 2025 02:49:52 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac66ed6sm93357105e9.28.2025.07.28.02.49.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 02:49:52 -0700 (PDT)
Message-ID: <a9b3670c-f006-4a66-8865-28b71ad8f5a3@linaro.org>
Date: Mon, 28 Jul 2025 11:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix width of third operand of VINSERTx128
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Guenter Roeck <linux@roeck-us.net>
References: <20250725061736.1096206-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250725061736.1096206-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 25/7/25 08:17, Paolo Bonzini wrote:
> Table A-5 of the Intel manual incorrectly lists the third operand of
> VINSERTx128 as Wqq, but it is actually a 128-bit value.  This is
> visible when W is a memory operand close to the end of the page.
> 
> Fixes the recently-added poly1305_kunit test in linux-next.
> 
> (No testcase yet, but I plan to modify test-avx2 to use memory
> close to the end of the page.  This would work because the test
> vectors correctly have the memory operand as xmm2/m128).
> 

Fixes: 79068477686 ("target/i386: reimplement 0x0f 0x3a, add AVX")

> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


