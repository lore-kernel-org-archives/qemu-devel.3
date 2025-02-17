Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDEBC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6yc-0004gE-O8; Mon, 17 Feb 2025 14:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6yW-0004cO-3H
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:40:16 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6yU-0001TO-1s
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:40:15 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220d601886fso60757765ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739821212; x=1740426012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KmN6lDAPvOU7V1Ov3DSSCfNMQID09MRLy94yMXyDCBw=;
 b=MjLjvoXvQt82+1sXTQqZ3d2HSeZ90H3AdZCUxBynVye7HIEVBy2rbwxll6WgfJ2ryf
 Vu52EMDPdg28co9asuXNR2x3wb+i4eCjPzDZFBasi//qGUuE5LnQqFxLfrK/AouZBeeN
 QEP1uUioGB2PgDYHylo83KxfVfLxgTKKLlrl82Bx0uahOmKr0rlN2akHsAJIOJubmD5H
 m8YS5VhUycgCnrcHQF66Tv/xD8cfxIsZVj+he1v17//32yHwUmUMw0sxIvHn1LyY8AGi
 Oxixy6upcLB1rMjmfSN4G5RnW8L58ilVnxj1lmahcA8pL/tXLoVnRW6rGvqUChAIhskF
 NU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739821212; x=1740426012;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KmN6lDAPvOU7V1Ov3DSSCfNMQID09MRLy94yMXyDCBw=;
 b=JFHTFMD8T4mIMeFixIwt2lQcmPpRe+5HkVUiYuPoyjDA+9/Ti9+tAAPr0ye160oO11
 xdYGn6ZwU+wEIxJVui5LpPbY5Z+V88i3sh8ihJf/fsUWy4Xs8HX7buQy5pxxHTau43OE
 G3xSsetaK8TCXwQDVB90WRsqhBZAugbCqSMHS0k/9KZNaBqkKZN0sbonydY8MI4IfVb8
 a6Fa3XxLc6IxjVZ3fC6NsNGQ/6QAjn7+WqNhMMHjHxbUBYtal6rcsznm4Yntr6lMMFPg
 BS3EZKNUq1nHnp5lD/qaRXhNt2CF/RFzsdUJfbWFn7yG6wAPm4nMc6Oml89ebrupa/BP
 gJ0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYKWZgXK6IVvu530YHzLmBGZxZsbHN0gxALZNYcUSMKHTnjglf7bP2ilVNehTVijQjrrJYtMHh9CK/@nongnu.org
X-Gm-Message-State: AOJu0YwaQNhPcjeC715yRiw5o2z7sQ77pYuedGFMMHyooAyI0qeFbcOt
 YZiDnqlipYOlsUs135WcDUgLOv/1O8SnhBHC7UD6svepGYuBa9u16PL/wuJJYAc=
X-Gm-Gg: ASbGncts7nbWSfEka1d96JKnnNyVtD8SRBcpENONs9RLuc3dLNV62MW9kQB/cVj2c8/
 dx9NpQrZKmvJPc1WTBw2FtUXLJq3XZMrF+3m7vMH23XMwRgPNoWkTStyXvQKVGHHAedugQvuI8c
 Ih1C1D7MorCN052wAB3AaosMuDIRdsZVTA7t53u4/weMpVAoTHcwbxzXJco9QXwNRm4569ukvEf
 4F2ZMEhXhP2Qn8z8rHPTeb7ETa+iaOm9BT5EiOxvtyHYrcTt+xGcmcJWHp0Gll7AgbNiF0V1xAa
 gtvUxC4f5/JACJ3XSgUCW26qe4US8aGxFMHEBl7vSrGlNyp5fRSIDwE=
X-Google-Smtp-Source: AGHT+IGHcBcbgmKlmR70f+iPoc49spKnwWqZYFuM4bIz5kWLlk6XMokxML6Fe/6kiZoPjw68yrSo9g==
X-Received: by 2002:a17:902:ce82:b0:220:e1e6:4457 with SMTP id
 d9443c01a7336-22104043055mr149307895ad.26.1739821212174; 
 Mon, 17 Feb 2025 11:40:12 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5367e97sm74826855ad.61.2025.02.17.11.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:40:11 -0800 (PST)
Message-ID: <12bfed4c-f261-4a46-9a49-a4e9b03856dc@linaro.org>
Date: Mon, 17 Feb 2025 11:40:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] accel/tcg: Move cpu_memory_rw_debug() user
 implementation to user-exec.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250217130610.18313-1-philmd@linaro.org>
 <20250217130610.18313-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217130610.18313-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/17/25 05:06, Philippe Mathieu-Daudé wrote:
> cpu_memory_rw_debug() system implementation is defined in
> system/physmem.c. Move the user one to accel/tcg/user-exec.c
> to simplify cpu-target.c maintenance.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/user-exec.c | 80 ++++++++++++++++++++++++++++++++++++++
>   cpu-target.c          | 90 +------------------------------------------
>   2 files changed, 82 insertions(+), 88 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

