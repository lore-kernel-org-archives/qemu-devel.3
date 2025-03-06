Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B606C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 23:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqKDz-0007vK-4j; Thu, 06 Mar 2025 18:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqKDw-0007sw-ME
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 18:01:53 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqKDt-0007Tp-I9
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 18:01:51 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223cc017ef5so25142045ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 15:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741302108; x=1741906908; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ytHOyfwRxokLFu3lT1VbdTpUTCElXlDMOtqzDFwyOIE=;
 b=NUKFO4WzuKu6rwbel3HYZQW4PymtnhNhPXr/pMQRrJTDxAIYlgejWUZN5SVthLM/JX
 0ARdW8cslO+4ln+T3kUYCJvzUJm1x3ALgUuTgw48hHFIwNNa8KA2jGqi4dKZNbb2q9eC
 dV/DBod/pdMxNZbhVkozdotgQyzvUW0DIQcgvsVjP1RORbvurKeD2mqUJwsTQsOctpqq
 LFfF1CkwSnyoeuxdqfUoMXQSl+reYAAb7XOqO83uTRRTTLkXnOKuLTPRNqDRXvJj4mx1
 8LAjeI4G/MlZ0BtfBZkLJ1yE6ccnEXWDFzslOeviUW+OV42aBgVNB3yqDoGznYAu01T5
 1tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741302108; x=1741906908;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ytHOyfwRxokLFu3lT1VbdTpUTCElXlDMOtqzDFwyOIE=;
 b=ZVxKnlHkycplbseivytZRKnRJ/vWuz6GqnPkTMkYapvCiyKGjmdKPe7fPkt+tA8k7W
 ZSiDPsvOKfKrrbvkH8Z2qdg0Ogzb2Ztj8RCGdNVfA0G0GJ1met+H9T35aaZD69fDl5HC
 UCTD86Il2NMAyWEyFrLn68z1aHXZMPX5nIRI8L+8AU9h1tgwrJ4Z+KlGUekTi5WUAH7p
 8/4cc8bYqTAeAZ/3GdESLl2c9ieuMepD9h2bgzThtdVvQWtdpwd5ky0D9jfntjxLV1P6
 0ySa6vQxqZakdtioYXH0qL8xerpA04dmQn6WcPGTUpsAFlEDj6XYFtZwGHVGpcoCkilm
 r2+Q==
X-Gm-Message-State: AOJu0YxzX0yn9N4OFWay1tUX5xH5usoUI75N3nf90cKM7tbBSTd2fXlq
 BFDRj7nMtqWn9OZvcxqBgJiJhoSDyBAnxI21GvkITTYGBrUpzCbDyEGLnzy3Az58shlqxFfa10e
 q
X-Gm-Gg: ASbGncsZYcF+G4zJDnIvsyzbbvtlXW64BCPKfQ9QfkfLM7Pqre1X/GRsmWXu4fcFtjS
 5EEC2axMnK2utZPD6X57Vp6W0+EXYp/+xnPllPuyRJbAHShkjypwK04J7Q8NPpdVWJfwnNE5sfB
 wSfTk4HbXTZZSm8gncRn0aTckQUVmkQOyaoiiezOCEI0/teZ/asEPTYftm4peeKJ99mgmg5ohHe
 t/z5YuBmhT352pW70Db4KMBvw0Y4sPH9zNKZqv3ZJSxkpgirzhje3ps8e0k7Pu4Z7/7MdII7rsr
 VXRKqSjFFqKh0NtzmDzIMzGzYe8TM64tON8mUqykRVUCSh9EFtVns56E8uFfXC+RFbS0Xd8rhI3
 XtT0kfe3s
X-Google-Smtp-Source: AGHT+IGag/SqiOgcN59w+QHUw8lMEM5TsY0q+Qd9bgBOF8ppg2OXVJFg7pHPjdsglhtSpzTF1Pu79w==
X-Received: by 2002:a17:903:41c2:b0:220:e9f5:4b7c with SMTP id
 d9443c01a7336-2242889f0abmr16410615ad.17.1741302107983; 
 Thu, 06 Mar 2025 15:01:47 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91e66sm17735475ad.202.2025.03.06.15.01.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 15:01:47 -0800 (PST)
Message-ID: <f3e37fee-405b-40a1-b975-153c44d2e049@linaro.org>
Date: Thu, 6 Mar 2025 15:01:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] target/arm: HCR_EL2.RW should be RAO/WI if EL1
 doesn't support AArch32
To: qemu-devel@nongnu.org
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-9-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250306163925.2940297-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/6/25 08:39, Peter Maydell wrote:
> When EL1 doesn't support AArch32, the HCR_EL2.RW bit is supposed to
> be RAO/WI.  We don't enforce this.  This isn't a problem yet because
> at the moment all of our CPU types with AArch64 support AArch32 at
> all exception levels, but in the future this is likely to no longer
> be true. Enforce the RAO/WI behaviour.
> 
> Note that we handle "reset value should honour RES1 bits" in the same
> way that SCR_EL3 does, via a reset function.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

