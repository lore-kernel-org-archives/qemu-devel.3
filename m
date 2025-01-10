Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3112BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWGYE-0003xa-2L; Fri, 10 Jan 2025 10:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tWGYB-0003wK-RJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:03:52 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tWGYA-0002OQ-9j
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:03:51 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166651f752so46040965ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 07:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736521425; x=1737126225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jvr/7aBfEcJSJCzF48LFtTr/vSGDgyt9niw41w73X7A=;
 b=APJobIIuLVq7Ox8AF4kv+LKT+XNkYYx4gQT0gQkm0CT5naykPv6UxCpgyoWgntOZtT
 UM4YYW7lVco8XYRNhfUam71JhRUHZB1z2/LTBS0bit91IojeeL9vEHkqjS14mk9gthtc
 DAFUSf8fc7EuYZWG0mbCItfprqcyCCvLJw8hb+QlI6RLorVEST41StEMnHxzEbTcKD8o
 JCavNLOvSRo5v8zUW6oaFI1e4JkCIhBIWkjgqMYaSpTlWc9LXCIOrmr+ZRcZ8/KTGeVC
 fJWGX6RFJwmt8VR5z5KiZndP+kNiWXtWtBYN/9zf0XwuCbnszNAxck+KVKb9Lv+dIJL9
 h82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736521425; x=1737126225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jvr/7aBfEcJSJCzF48LFtTr/vSGDgyt9niw41w73X7A=;
 b=VwcFDayOYa7Im8vTbwV5oC1IRWt8B06vBTEEzwEdkW/pbAfT7Oc3g5NHQ0/Zj9QQg4
 g4zjvv/Fz3BBM63a+FCepj5b4I3VWhh3uikTdexGPtG73dd5fAj/DFXuP3wt14oLncnn
 yo0vCRZa2pFayoB3Mu8pg/rn/iTJ1NmB+jEDSNI83ou1DU0Ul/XykKbqHD5D3/rbtWtJ
 MXOxHMYthWj7B137G4FuerfBJKLSQHN/sNm2SIGXNIq4VyXRSqyjnJXp3CIECf2nlveb
 uS0Q52n1XGjxUAg2WUzZ3DEcW0t1FIViLttFPt3j6/q1ybnyqGHu3je4bjYO3qxGyMA9
 icUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKGN1Mf/ExNTlkQCiiWvqy8Jy04hdYdEyLbofaEzp045DTCGqXjYX0AlltE3Uuzc2yM5sVITYLMVuN@nongnu.org
X-Gm-Message-State: AOJu0YyZrhiImCIzEy5w47cAujSTbr87YzBFyHxsMHzpAEYdnsNXxmxk
 PcHIi/iN6ANO2yInFA9u5hPr5eUjQjA+Ee1rtAuqxgk5qFTn5jzMVJkLpog5G3w=
X-Gm-Gg: ASbGncsKE+fdGPgD91jplYFh3WG2tu6tiFK08DwEWidRhieXiQ1ptJiZ8v3CYAedLo8
 Uv9ndcQ9nvheaY7CyNiOEep2PSsOOmd7a7+ynTeHwYJuIhN8ilkB2fD6L04cLfWy+UDBkPCfccv
 P/RO3PSCCcQfx3SX2L3/W3JmRR8WdmOVaJq6F6QA4QsvnGe4BizRklT0MEvenuY99Jg4KjJzbl0
 WlpxYwx58U+Sr+pVm5ZVHnGQ3JJ1kSAbNaIQNJTooZj4yKSL0pJ8MVrIquCsijQwOCdtyqcphUq
 VR1nMeU1Rng1eYv+UFEr01+Hr+kt9ts=
X-Google-Smtp-Source: AGHT+IERifWrFYPMuqxeKJ3JdQeW2DkxRKzCdBFlKGMglXlcG4NNEf9vJyT6g+XUdnPRF27bPK2I2Q==
X-Received: by 2002:a17:902:f64f:b0:219:eb2a:dfa5 with SMTP id
 d9443c01a7336-21a83fe4b96mr164395275ad.39.1736521425367; 
 Fri, 10 Jan 2025 07:03:45 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10de6dsm15065255ad.17.2025.01.10.07.03.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 07:03:45 -0800 (PST)
Message-ID: <56bff73b-1632-498b-868a-a982c5ec1534@linaro.org>
Date: Fri, 10 Jan 2025 07:03:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] system/vl: more error exit into config enumeration
 code
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-9-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250109170619.2271193-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/9/25 09:06, Alex Bennée wrote:
> All of the failures to configure devices will result in QEMU exiting
> with an error code. In preparation for passing Error * down the chain
> re-name the iterator to foreach_device_config_or_exit and exit using
> &error_fatal instead of returning a failure indication.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   system/vl.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

