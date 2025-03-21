Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE5FC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvghk-0008GQ-83; Fri, 21 Mar 2025 14:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvghL-0008Cq-9X
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:02:27 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvghJ-00035m-2N
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:02:22 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2240b4de12bso15870365ad.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580139; x=1743184939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A9wfgTNVwbh5MviuCEEjiqNP7cX1EHVYoRPAjNSeYzY=;
 b=OE1i3tqwP+0cOF9rQOlPLmS2yR3ixtigPNPtqc1y3bOafyfdVNyjY/a26GJtG72L/H
 WOoGq9urMR6hpWVGE55xZtlXB5vtt7zpfOoIUpY5c11d9KKerfcbUHMmVj/1LtAA72ZN
 iWLRdEDzDQr3dZDpcT2f2GJjcMxzH5lzA2ny9EurUtiyACLOqsq4Lqv5sNEDJEdP/ylx
 EuZhCYE7mJKS807rTXkB6JIfGyjsiTrVbAm+Wkm+ePMP8Xq4NCqYhJr1bzp8aMJGjbEC
 YQqZgQDdtiDSEpcxO/sNXqJ74ikZ6XinwX9NZW4PLgjXpJpdYnTh9WcufhpZMzwYZ1R3
 z10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580139; x=1743184939;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A9wfgTNVwbh5MviuCEEjiqNP7cX1EHVYoRPAjNSeYzY=;
 b=IDRNWJjHpIjRH+TRsEnXgKS6GRiDXPslpV7mmXKXlT2NV32y3+6pJ7ar43AYhrvQf8
 7HfA5o49PCuCfrXwWdj9XzbIUoYuTPn4u6LmNUnBB0xypiUmtX4BN7KI7d2+HaRxhGTw
 XFOqMvXWdenBZq9sPciy0b+hgOvoHML3uMvJMfm16L5+rd2hvMzfOjFS57ERCy5ZnBny
 GZQhufH+V02g1b635j+RcAC6lz7W1ntTTaHHKbPcDEqvhaWmM46TADotRKYC5Fvf6PAd
 5hQ9kxQOocq8GP6dFeyplIW9bq/ZQvayJNE5ab0RQprJBOdulepq7uHNsYlAOscnQNhe
 PFRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+07ZEci9dWny1VJP6aN0HtAu9Ypp9B1VvsR/YAspTpAfpZ57idSVOw2630O2bPECofLyShEdgR9JH@nongnu.org
X-Gm-Message-State: AOJu0YxInCC9v+VIvbN+PHBzqZIicUUE0mBhFZ9jIJDWS3aWLgMmN722
 ZkL5hRIhSEqxB+QS/YzhF1GMXk9+1Q6NPSWQaMi5k2RlqgR1vONmKEvfFjGVsEU=
X-Gm-Gg: ASbGnctEaOuipyGBnpZap0fdu7I+axjIsyDTM/VX5XWNUdXHJZGjoA/8jM9PNytS9No
 TAcTY5mznKzJnm3FixAlndRPtfFTTPi+3WqT3I2NNAz8VcrtY+7d20yZnoPMnj1LQ9qskO4j/XV
 tIGJa5i0r2AfhPCBpePwPYVVHBTMy0kGrHdqNDwXYUQyk89LRI4+6PyE0A4BrxibpgPqQ9P74/b
 c5Bu5rfh2Ls0Me0IItB75kHI+PtauRJJsprsMM4M4XaP+mE4oGyAiQ756f6jvJUOVizO0gDNS9Z
 K5//gjeiudrYAQdwcfEBhn7TZ3SH/3wRQgcbdXUDGKl+IbRfnkSHUrBmPy3wCYeoHG+S78c/Xyt
 dwhHRjKQN
X-Google-Smtp-Source: AGHT+IHbW47WrFwn8bPtk5JBZarkAnDdE580JK1jViCoJJP9Ixi4V6AItwt378nhBF0j1KTuI5MAIw==
X-Received: by 2002:a05:6a21:e545:b0:1fa:9819:b064 with SMTP id
 adf61e73a8af0-1fe42f2cd03mr7722012637.18.1742580139449; 
 Fri, 21 Mar 2025 11:02:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a292b1ffsm2070387a12.61.2025.03.21.11.02.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 11:02:19 -0700 (PDT)
Message-ID: <a5104aeb-6b4e-4634-9d46-9dab4e09595f@linaro.org>
Date: Fri, 21 Mar 2025 11:02:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/30] accel/tcg: fix missing includes for
 TARGET_HAS_PRECISE_SMC
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-14-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-14-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> We prepare to remove cpu.h from cpu-all.h, which will transitively
> remove it from accel/tcg/tb-internal.h, and thus from most of tcg
> compilation units.
> 
> Note: this was caught by a test regression for s390x-softmmu.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/poison.h | 1 +
>   accel/tcg/tb-maint.c  | 1 +
>   accel/tcg/user-exec.c | 1 +
>   3 files changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

