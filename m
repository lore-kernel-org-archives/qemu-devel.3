Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBC3C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2WF-0006ik-8F; Sun, 26 Jan 2025 08:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2W7-0006gW-7A
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:17:35 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2W5-0002gh-Q1
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:17:34 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f441904a42so6487131a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737897452; x=1738502252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/qdxFs4xNVElUt3SDK1LP8kU1UAUo0M+x+DWT+FHaOs=;
 b=jg61Ba50EwvK4i922RK/VP39gzaaWLymy/Er4GUfPvod2ZUtagvuyyUhoO9Ssp3+pv
 +1CtsHCKHSEuTXIrWlNYFIycczRQIDJ4s5iwOmolNuMjy6yf6a4FMM6pfIzvXMS0JmvH
 t2BY4iuaogUsMh6u+cHfQDoq22i9sZBFplbN6MWRXKTj0hZ0lsa5C6sFEoT0jo4YX+Lt
 Bp/Jl2Gcza54wq75zGWYo5Tg6rDUER4KQB0Vm1CG3nQSrYR1CSdtMRsthec2f5myfO87
 KYmzF4KunHCDNvQdrujDRqlcaQVVbjEorIvjT88mS7573yc/MO9P25kBoX0HZwvHPnhj
 jqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897452; x=1738502252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/qdxFs4xNVElUt3SDK1LP8kU1UAUo0M+x+DWT+FHaOs=;
 b=U4HcSjopqtG6luj1wd51WaN/7RzjuxWk7ZXFHQ79NEfzPaVviGAV25ZaKBJPmajRBM
 JZrlyyMjmB0FFEnDfgAAcjNI+UXLysrwzIyufIlOwP5xq3dYHCSlw9fmxTqXOr79uK0E
 7gy9GdDA5NfT3GCk9aKHSx/ixeOG2pNmeH55T4Cq9HRDo5npJCEp0wM7idhaaIOf40C8
 GldyKv62e3/RUPOXaW7XXU9zOGQ3FraRekLuYqXO4R06cbzlY1jrb+wLbhPCmsFulqHJ
 ZTBoYAH/IfjxCMRV3EU34s7o4GHUAcTYrrT4nWzfp74cJa1ekpeJBIWJiThu33OgoPcU
 SJ+Q==
X-Gm-Message-State: AOJu0YwdVN7IzBjCpqu93wOGnrQX+LyMYn8McMgZqsF6cWCPtsGhK8o4
 z/nHvCJYjOnnWg8AhinuBJZzniL8iCUTPvlpj51CRKWrZ0Gz2qfPuFNjprXWXHNrRjvIAx8tsyD
 5
X-Gm-Gg: ASbGnctI2/BFEAvJe4eADXyC46LO0FJzuXklXOHwv/e7bzmDC5tLqRZGndMs3YPbFWE
 EJHeeBd9qCT21r6Z+rKcPzf0i7RgkdSwmJANYgIfprRXORTZ+usafGicCZwOgWRCOG2DgMzXEbD
 mHxTtxRa6kTVMEvLYT+uB8isK/2NdMbsnGXZpW0ymRXcHgTx19s3sTfSxkGtvHxYo7iSSCdvb2v
 GhBXzQWxS9VuFJ8zXywBCSfvztqjsP+rTpko5PPgdPffPPsI2P09Gf62hxwuOcyRnvfivVym6dU
 tcyjM4L3dbzrluzoWAZdCHE=
X-Google-Smtp-Source: AGHT+IFMgDR0h8HMgCMGkBW3bChaiUW7Q+IqGXNUA5ldjihzz+raFAMmUi/MfJx/TH98s7gs72iQrQ==
X-Received: by 2002:a17:90a:c88c:b0:2ee:c059:7de3 with SMTP id
 98e67ed59e1d1-2f782cc01f5mr61786754a91.18.1737897452467; 
 Sun, 26 Jan 2025 05:17:32 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f801ab77b2sm4883938a91.24.2025.01.26.05.17.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:17:32 -0800 (PST)
Message-ID: <23270032-869d-4453-9192-3aa8f8f74bf4@linaro.org>
Date: Sun, 26 Jan 2025 05:17:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 64/76] target/arm: Handle FPCR.AH in negation in FMLS
 (vector)
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-65-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-65-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> Handle the FPCR.AH "don't negate the sign of a NaN" semantics
> in FMLS (vector), by implementing a new set of helpers for
> the AH=1 case.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.h            |  4 ++++
>   target/arm/tcg/translate-a64.c |  7 ++++++-
>   target/arm/tcg/vec_helper.c    | 25 +++++++++++++++++++++++++
>   3 files changed, 35 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

