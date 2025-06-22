Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893EBC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTA5h-0001XQ-JE; Sat, 21 Jun 2025 22:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA5e-0001Tp-FA
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:05:50 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA5c-0007bC-U9
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:05:50 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-234fcadde3eso41915495ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750557947; x=1751162747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gv15nL32o6AuQDGBra8BCyqqxCUcLJ0trXMSHcf7UDE=;
 b=k+qlZqTWkojCkEg8reSWRZgMJ6d+bpR8ksKXdoTdoZAo4xm7YFMTeL8iZhXfM3EI6P
 LaOuRe/RUFIXZE55T7FiPvGHeR0J4qWzDTBM9UOaitLVeA8lPuRxoYo6Fgsn4c7Q27fg
 k0qMiuSZq7Z4sQuiNefUsp4+FBiZr+U7/wQ6yQxPcUsKFtqkep1dvbiAZRHoqBZne5Sp
 lomdFgjOQjzFwAby41jIjZIOhH3K5Xe1bsHW9UVa1LXl7ffK1Ag4kBuqL/9813HfDg8+
 tb/BOEJnCmeZeMob0PA/xJ3+5alcIWGx3AvUggM44+YX0c5yWxgA2MGVEGGTfnoHyaom
 ozmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750557947; x=1751162747;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gv15nL32o6AuQDGBra8BCyqqxCUcLJ0trXMSHcf7UDE=;
 b=TATmCZayIvxLAiUkNcJy4hg08yA4OCTD2VVDVp+cle+LUYFIfxWDiZJx6t5gPYsTaS
 s7ZMUcMPvpWNwbry7U9yb88t6JyRyPLDrhzcPs2tRvFtGuMPpAXCszO2w+qSSOxWsDCt
 X6EsX4Fmy2Sk1YUTCSd6GX18Yv/6s+pyFW9rYPlodkPp71kTqFtAtp+iftkk9JRuM6hu
 QKFhY1LQllvlagP+v6Glyuqavrza6RDj+MEd/49FeNAiOt2jJDx5qeY47nnB0irFWd6s
 N0q73dxgYfd1m8CedhFYo0IyxMvobX8rd0k9NqZI0+/Rl8e+s2OD6JS6qEFvLD8yaLYy
 x96w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOUIQGlp2munm02nnwZnwe0UoecJaX6FuRg9wtcXAIJEhX6rL2/BAH+vC9AMxLPIjyux7j3NFGsdSE@nongnu.org
X-Gm-Message-State: AOJu0YwoY3Wh87xJ4rnrBm9vs3KJUaiPCxi1+upk0ydaTHZIN4PFSX73
 kkw049/3BrCaUCpOS+MxLkZ3kwBCkCkqsLwEsO8+jPDFy4peoMu/Tpz3vif1lzyXeOc=
X-Gm-Gg: ASbGncu6ru55k/v9iQ52cSQOqSi1h+0gFotigsrYfVY5m9ZAerqpXR6OIslldJJFHPJ
 vD4TewE5DflZCphlPHQ2248U+FCm8+fwO4Nl4QvjuNHqK+/BUFhCo300QQH7XHT7TgIbAPl8rDE
 apMdQ9zohX7E+EbpkCNaKyrv67sfFO15iGxodXKh0UStVLX8ShsmpnRNg5henoPEjFS+uwFUXFi
 JVvkFBOOyhPQWLdiCA3jizGw48A8SPL87VTnLF19JB6wsddOOK88LedwEHmbNwBFuIFmj/zeVqr
 9JBOKo01PKWGzhmRFUK277RLwJaJxskUXisDvGlGU2llLWY077RcmO5Iaiz4mI6jRSlrkDViinG
 4QA/mELbvCnlNmZTeGBoK12N+KGKZ
X-Google-Smtp-Source: AGHT+IFDihmphKohdnq5Kja4WPGtq/D1j2OO6hXiDWU14ZEZ/9JeYT3nphl+OCCNWfXeUri//8uujA==
X-Received: by 2002:a17:903:40ca:b0:235:f4f7:a633 with SMTP id
 d9443c01a7336-237d9917e38mr128886505ad.28.1750557947462; 
 Sat, 21 Jun 2025 19:05:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d869c5a1sm49980585ad.192.2025.06.21.19.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:05:47 -0700 (PDT)
Message-ID: <3b04e860-78a9-4ab7-aeb3-9741cec634f2@linaro.org>
Date: Sat, 21 Jun 2025 19:05:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 36/48] accel/whpx: Convert to
 AccelOpsClass::cpu_thread_routine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-37-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-37-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
> By converting toAccelOpsClass::cpu_thread_routine we can
> let the common accel_create_vcpu_thread() create the thread.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/whpx/whpx-accel-ops.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

