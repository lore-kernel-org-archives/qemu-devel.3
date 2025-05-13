Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D35C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmUD-0002rX-Je; Tue, 13 May 2025 06:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmU6-0002qI-GM
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:03:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmU2-0007L8-K3
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:03:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso34700315e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130612; x=1747735412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L/LxQMLiirTAwzHHf55PiXQBKZGHg6X4mycHe1m+VHw=;
 b=Y+sBjUf6hods7MSRnTB819L9m2GtkkezuUK76SeQRZy6hmCs9rfbYyhOc+u7cDU8Xy
 xI/nJ5bZp/vTxwLtJSS5ZiSLX4V9KCV6LDWO24MnN6Jr8XrNCdK43Sp/cB9BVoE1v6rN
 UUPSaHn6JetpVn8mYYWxK1dgkAuZuQYMjoPfz60sw6Qe5ZRvTUS2uNqxWPb0tGG3DoPM
 VvhqH/MUEjG8QX+NHlaK/Oa/0NqRpLP5QwAAn26GPbiOt1EyrlpariTZD9ZnTDd7v2fS
 JXFCO7xW/UBtBCOWBqjFUHfQq1sPNIfnHA9jzMz+31hvxBpT+WAIwIH+QTQbDlbIT8ML
 ruHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130612; x=1747735412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L/LxQMLiirTAwzHHf55PiXQBKZGHg6X4mycHe1m+VHw=;
 b=h6D7aAnoKXbioV8GFbpGaDJMi3D6gfCbmyYsvmMyh3b2FJnsn+e02uTfgUyHXvtv5q
 0eqXv1k0bvLsAKAs2tB64/gyCUDDC8All/8XmGP9EMHYWmBKiMUrwbAmz64bBnabEbS1
 s594Fsq0X6E3bWQUu2+AtfQzFvh0OzSOsxfG0lchSQyXki3svrlgHl6eDxSNQ0980spF
 oKkI0BQ4y41KRcACc4gzsJoWqPoCcBcF9pTI9znD4C4yjf4D/UMxwo5r3mf84M/5TZTs
 ZJFER7nbXx8GsosFQm9kZk4u4Fis6x2Dq7tmihiv5k4g8lVX7H5V/cmQHn3OSyAzxG1b
 HZkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDrV8vuM3NRbCt0Q8w2EadhYk7kgl0Cd9q11IdyiDc9dnM7ivMvvvmCC8izys2RkcABsdtsFjDmDCz@nongnu.org
X-Gm-Message-State: AOJu0YwbaFd5MyZ4jDa0cVLWV4f6pGqUf2s/HNWgLaq6YHYPmo7Je6Di
 /5z5Pv/zAI8gCxAd+xonlQHqfcuZrLCyVv2bqydYjwIn/L3fDCe5FXOafztf33A=
X-Gm-Gg: ASbGnctfDyllFfGCmTkn45YJlLhtSvik8KJkMUjmuk1K1oMDB7alN6rYvnpytMbmayg
 xRV2BDp7JOu4tE1AknqHaVoVSMSdrCdsjCxFveXY1SGEum3Pw7lpdTkBdaJ7Z8UE/OiRFtAf+br
 jTEM25RfGeN4mjKuLLJKMr48nidWiK/IU3Jp68/6xj5LLxS4ZKglD5Gfc82X1rvq5VZYRkU8hQg
 34j8SHI2xfryNf4/t/aYQNNPacyFeM9Mq6CHyO7J23NaNfElml9s0FGzEBAJLlYgD4E4dT0HZCk
 D7xyadPbA3NLLzH6/z/wIjF4Ih5xhOJXtb6+uPPRA1Nv3eMo8WcJ7iJSE7wl6udlG4/GXYRHZXj
 TsYtV2YWuUR8kGk2KNgGU+nPXe4QH
X-Google-Smtp-Source: AGHT+IHeMZpbCe6AjNqaTchvt3/JWTGthyYrXrKkltYuFRy8/cgx7qSRFjSrBA5eKOd4J++UmxSKMQ==
X-Received: by 2002:a05:6000:430d:b0:3a0:ac96:bd41 with SMTP id
 ffacd0b85a97d-3a1f643c6a4mr13835068f8f.27.1747130612050; 
 Tue, 13 May 2025 03:03:32 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4d0dbsm15336725f8f.88.2025.05.13.03.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:03:31 -0700 (PDT)
Message-ID: <f18e1932-12e7-4a31-ae82-f6c4c11a0d9e@linaro.org>
Date: Tue, 13 May 2025 11:03:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/48] tcg: add vaddr type for helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-13-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-13-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Defined as an alias of i32/i64 depending on host pointer size.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/tcg/tcg-op-common.h    |  1 +
>   include/tcg/tcg.h              | 14 ++++++++++++++
>   include/exec/helper-head.h.inc | 11 +++++++++++
>   tcg/tcg.c                      |  5 +++++
>   4 files changed, 31 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


