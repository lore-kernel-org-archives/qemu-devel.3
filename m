Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0644C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVhB-00079D-CB; Thu, 01 May 2025 11:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVh9-00078e-IN
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:19:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVh7-0002da-B1
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:19:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224100e9a5cso14488775ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746112762; x=1746717562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EQkfl6PWb1kXCkfaF29URjOl94N4FTQyK7ZQw8qsJ8s=;
 b=eouiVz9C13fC8aMhm+zq1c+FNyXUizh2TWlbyUpn38FbZq9qtV0FEJ01TbF7tYXu8L
 hKZDc6bj8V6eNK44ay3Yi4X1ig6pQ18EMXMl5B9nI3qgIf4uE0zV0UCVs39VP1jsec4K
 XJ7Mn8mJnWiqYGuAi0etOKe/uhPdMI+72eeCGLvgLd4J0L4fnhGb0XGVTVZkAMBySsJk
 qgOFp/GeRgzQMiArd0nW0aNmaSnWNn09Ti7ao3dGQIZKYiBPFnnEWNZYWir1zp3gmFGT
 kwvJP/3A93K9gY+lREnjqCzz6MIDQxuSlc7/8PwsPZLlZBpU8Lc7+vopE5S1oIoLJS/+
 x8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746112762; x=1746717562;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EQkfl6PWb1kXCkfaF29URjOl94N4FTQyK7ZQw8qsJ8s=;
 b=vO7muvauT2YEBm3GCidaStnBYMcGAgXmOfY62MEDw9gPkU3LD2vaKTfOgoKI4i4dbl
 9gdqtQE/EwCn+YSOkxbsbbhLpK7JQUXAQFhRClTMtdhnhLSTOF5EJF1b9XfyXs9MLaM5
 V65n9kCW9AFLTovgJltVXFcqH5FtktAdx5lbYc7S14Vbt0/0qndwnrKFnvHoXcV4pl7g
 I+hGMBNJYTwenY7aIlqE2oXqHJF/3ZtTK5UqMiOjJs+0hqywp+wXEYweDgaahg7o1NLY
 nADM0mSBCruGNU0eJ/UeyWCJMywOewAyV7WWkTvYKTk2rnSoE5qcDDwVEzQ2gbeT2kbz
 JY1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEX9aMue+7W1IF7qJL2J5BxvGH/f8eUYzuYduQNdxL74xXp2p2S3OdnFtDKyRNlHw/0YkVO0H314t6@nongnu.org
X-Gm-Message-State: AOJu0YxNASz+Gjadqc/R0gw6tRc41YVsg5XdB4N4+p32IoJvozb47Av1
 1WKS6uSkdnADQ3V8K5HZ6+fb0e87H53j7TGQX/GbuCjG8NGjv4tgiYNxI9+k0II=
X-Gm-Gg: ASbGncu2KoJkmPdsvzYQJ5UjWibsieSVLdmQUccZn0Dqy/nSLkTPyQwv9s8++X6GVfa
 ICdOTx0Ais9N/H7j35OdFR6Eiwzz9VgZN+flzpQJlTDUHm2ywtQ6uxVTBM+1eL86m/GT9b92CDk
 gKPvlzkZhbSLgBA40RNbDXHE53khmLMFcytrNigIVD55Pbh0bpks3ro3jXLpWf2RSC/0kD3tBca
 zLWb5eHl32g8HiJHduUuYBCYusWdmZp/Z6jqd5/Y0zI3SaY/2M2FcS9Am2N3GOcR/WW48i09G0B
 TmlanZl6o9I8pFzrLsqW93qf0BheNb72zFGPCKz17a157A2kLpeIEWEJvVbbKsJ46wVBRyycxZi
 IteOMiK0=
X-Google-Smtp-Source: AGHT+IHo1cQj3dctWO/PI4RDwJQxUMLzCGTpYaZ4IX9+6jZm2ktcxW6CnV9GH9l2Ufag+sg/SHlhbQ==
X-Received: by 2002:a17:903:3bc5:b0:224:1ec0:8a16 with SMTP id
 d9443c01a7336-22e08424e71mr45540075ad.21.1746112761851; 
 Thu, 01 May 2025 08:19:21 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bc7bea4sm7798285ad.198.2025.05.01.08.19.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:19:21 -0700 (PDT)
Message-ID: <0ced131a-0072-4b15-890b-3dae3a1c37f1@linaro.org>
Date: Thu, 1 May 2025 08:19:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/33] target/arm/helper: remove remaining
 TARGET_AARCH64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-23-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-23-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> They were hiding aarch64_sve_narrow_vq and aarch64_sve_change_el, which
> we can expose safely.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.c | 8 --------
>   1 file changed, 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

