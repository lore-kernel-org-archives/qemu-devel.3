Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953F2CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 15:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQRxl-00030A-Br; Fri, 22 May 2026 11:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRxj-0002yv-5E
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:38:59 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRxh-0000XG-Ja
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:38:58 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so3320194b3a.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779464336; x=1780069136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4o8jyaPaDbNEaB4qSFlUfuVhyt5racQTU2i3X0Y4JgE=;
 b=fhp4ZIWpsBAObC84dySsVbRpP2745+qnul3x3/5hpyarwKCH2HWpZ5eCb6FVKd3xC/
 LamaOKP5i5jJhwXxML67pgejujX1CbqbG/QHaGLy+4kWYtYJEWSZt5JB/zK8qrFWVI5t
 Qb7i8vIUJZkN/mRz91ISfDZXCRT9Q/sHHGH08NZMag1s8HETSsOZuITmn9IzACqTWJGg
 AAXH+/SyvoThPHsi7Ygxb6lXr7OqcEXbEVUoBEOm/K2ty1ZsrkOj1Qxb/vE+mGgaBiIw
 QN5Raoo+Q2vGbfA8X0B+DdZtODZUPhqwZIOA6K1MytYTInbFNtn5zf9PT0AAVpUy3LPU
 6wLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779464336; x=1780069136;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4o8jyaPaDbNEaB4qSFlUfuVhyt5racQTU2i3X0Y4JgE=;
 b=iK+SqwE2IyOtmICCw9I6lEkc/iAsip63CngSKEYXvSw3GtDlkEv92KyLlfYKSli6pC
 zzZiwOUnYyW10EAZPzyeXO6rBan06kuZ8JWPM+pmxl50/SrQe9+j3CkM2xb/P0z35Q7i
 oPJbs5Hmk+ZbfgtpktFJ7B2SdHcMp/neVxWeq3aoPxf5jw/seShnnrZIejK08AsFDDLE
 PVkhz0q3aI0LIs8rXZU/B7OPCGDW9btwAp6YcSAm/U7LRLjOKaYx3EUmXuOpGi7qBt2l
 UmmybfDaLLd3XDsgX6sSRLObOD0vt2lvzzrWhz7rXgwH2d3wYNdu/zpq1OTVtx43rcnM
 5iLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NJMSCpsRBHccKdAZs30ejTsVC1se8DYl7eO/qMnhSKv3VE77PBk+YHt0Fm/c/UHlETO6mO5N/befK@nongnu.org
X-Gm-Message-State: AOJu0YyfTbLxLPuaBzKG5UWLv+qszItIplymEcuCzOfbwnLigc3VD10D
 +QoIF7CVQEJcfO2ks/9sxlZcu3tjhq0zy/LtiajfoFuPeYqH5faY/UJ6FEcxm0yB8QU=
X-Gm-Gg: Acq92OGvrrtNORLDBpB2sP6YuQ2IQ8QsbtKGFeeE4o0qAin/NfwRnISoO00xlehnI4m
 yrvhLIcGnH0PbRygh3p76smffRwNCnQ4hXAs7TluXztMZXKdB2cCGAea62leQbdFOn0RoPUAbts
 2qmcs9GNm2ezrnzGL53QmCP2rDzMcSLCNjng2FV06GwRSKRBVey3BKVLS1n4RJybYjNV7AbSs5E
 oWjmD0Wz5cQ4uvm7vtAIjPgtmg0Mri9mCel4F9eYqCnF96n0JODYcPYtAW+M/xcG2Ie/Yz2XGxE
 rROF/4lalse5URM6RSFLLX5ZFv27BlFVCA7i57q4efCpQPNt3lQMnwnEValY2KeJ8UZNXv/EcOd
 VxsXqAr1oYpUVE7nPONT9UyWgXMwlkZer7PVFcC5CaR+7Nbhi5xzl6u1whCtxcduD9ttVMsg6GN
 g1MR2DhjfSezVydYXIbKiAemn0rej+PkxNGjpSck0+g+J0E2bBnIA=
X-Received: by 2002:a05:6a00:a92:b0:839:dd77:34fb with SMTP id
 d2e1a72fcca58-8415f1a05e5mr4198772b3a.22.1779464335989; 
 Fri, 22 May 2026 08:38:55 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164afdce7sm2383717b3a.17.2026.05.22.08.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 08:38:55 -0700 (PDT)
Message-ID: <7c37cf8d-0b94-4cc5-bf9c-d132f12c101e@linaro.org>
Date: Fri, 22 May 2026 08:38:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 18/22] target/mips: decode Octeon ZUC and SNOW3G COP2
 selectors
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v14-18-fbf08e164830@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-18-fbf08e164830@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/21/26 22:20, James Hilliard wrote:
> Add explicit decodetree entries and translator bindings for the Octeon
> ZUC and SNOW3G COP2 operation selectors.  These stream-cipher selectors
> operate on the shared HSH register window state, so dispatch them through
> the per-operation helpers added with the corresponding engine support.
> 
> Keep stream-cipher decode separate because these selectors share the HSH
> register window with unrelated engines.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> 
> ---
> Changes v9 -> v10:
>    - Split ZUC/SNOW3G selector decode out of the monolithic Octeon COP2
>      selector decode patch.
>    - Kept stream-cipher operation selectors helper-backed because they
>      operate on the shared HSH register-window state.
> ---
>   target/mips/tcg/octeon.decode      | 4 ++++
>   target/mips/tcg/octeon_translate.c | 4 ++++
>   2 files changed, 8 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

