Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAC2C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzTF-0002Fg-3t; Tue, 25 Feb 2025 13:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzTB-0001wT-2K
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:15:49 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzT9-0003qz-AA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:15:48 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fbf77b2b64so11980067a91.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740507346; x=1741112146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VnizW27Aki8jqafN6FuuzagUR4Xg2XaT7v3oMy1t9cc=;
 b=PtJ+24a75oTDL8NWuUIe6FEP3dvMFU5hSpRQOu1gSwmUjRtEfq33PdHJWwDTs2sKsq
 55g9RfuloOkRXTkC63M+P2O66HE1ctU3QCAZvyl1i2jYkA7V4d/BXdcb4us+YS5m6KSn
 zPRMF8lhLkwYDHPifXyZj+778Fv6oWXbrLpJkiPuHidn08pgY8Atp99+W2kiaktdq2cH
 /0csg9qlmNK83LKQuMDJ8T5j2NxnNDBsby8z+5D/2rPqEMkiBVhnP68mdr8PnwPsIyM0
 oNu72MruCSuY2qLenY6XZBZ9mavgglvrEhncf15CiWz9H51w1FOlNlqO703fakOKtxam
 RsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740507346; x=1741112146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VnizW27Aki8jqafN6FuuzagUR4Xg2XaT7v3oMy1t9cc=;
 b=IE2AkXgX6KNE6BFEWrro04HsdbPrWijL6VzTU1mlG1XfwWnfZHP+TYWHiDq7IS3DHd
 6/tUw8Vn75AmnrdfFJ0jFvy9Ty0d6qAQKyNPRG5PhTCrFp4g5+5m6Fp60kV3CWWxICc4
 PUziqpHePUDEMrkvj/gDKmMWMBjorM8fVnDZWdjr660K0diHU+l+FN16oxhjk+pNawh9
 IHPDO7HXFeg8LtO0l21F3mGOcLtSKnp09+EbI6nKdp+o23luBP2+kCHIaRRDGl9c1n0j
 FYHPtAdRqSVk10+9OnZvNmhOqlP+ZfiL+RaR3gtb/Dulp2elKTL3Bm3yBbts1LO3Uygg
 PlGw==
X-Gm-Message-State: AOJu0Ywl0Tzn3uwaPpSW1t/GHHc9Cs8R6dp2Vr1uAzC1yNikgVamvFOW
 o1OEY4d5uelI2RqFQ5uDW3DHXCAet+75gNw1ubmp3LIbyK6c9aoLOS4SARg46JwK/Ee1aV387aa
 j
X-Gm-Gg: ASbGncuztckkxtVTcxWdzSsv/ucDw6XbGsolEWx3bjzPRTlL+xt54ty4lcQFIABCvNl
 KyUx5dlgiP48GlFEP69xyMNYEWnXmtDG4bZA4InLQzncH+C1t0Xo7F+lfzb8eEe81voyJes7BXS
 rNffh3HNOQbRRhNdFnTuadGF0OEbWHmrDexq/uWmIpWOMMMaMHtoJFdgLqu03+4L5pxxwfuBIfD
 gwP7OK/5EJEBohDUaTv98ettDavpJNexk1ofg7HJX8bXSBRT4cfNs911RFzv7R5fVVT5bXQDgxb
 xMMi80AWgXTsTW9D7IoboCkcHswXGUuALKTJM7FewQP+89brWxSOrFklLEb0bN0KhkHaSviKcYb
 zx66aPrM=
X-Google-Smtp-Source: AGHT+IF45iB1nTjRoBA9mrUbJEmhwDFdLqRxytiPOvSxDEgnZ2/JGruj5qHZEawL2NLgYsiN7Fvp8g==
X-Received: by 2002:a05:6a20:6a1a:b0:1f1:459:9fff with SMTP id
 adf61e73a8af0-1f10ae8e689mr244843637.33.1740507345714; 
 Tue, 25 Feb 2025 10:15:45 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a7f9abbsm1885888b3a.94.2025.02.25.10.15.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 10:15:44 -0800 (PST)
Message-ID: <96b2f516-2fb3-4507-b79a-699248da627c@linaro.org>
Date: Tue, 25 Feb 2025 10:15:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] plugins/plugin.h: include queue.h
To: qemu-devel@nongnu.org
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-6-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225110844.3296991-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 2/25/25 03:08, Alex Bennée wrote:
> Headers should bring in what they need so don't rely on getting
> queue.h by side effects. This will help with clean-ups in the
> following patches.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   plugins/plugin.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

