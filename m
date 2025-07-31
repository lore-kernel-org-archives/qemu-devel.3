Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F29BC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbHv-0002Qa-Bv; Thu, 31 Jul 2025 17:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb9e-0002FV-AH
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:49:38 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb9c-0002c4-LG
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:49:38 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-313a001d781so868042a91.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998575; x=1754603375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F8xMV4hii1xkjt3TGEIWc3xjBMXe2QdhzyM56E/Zdps=;
 b=N1rnrst1XkbDIB8GMCCCx4mJnm4PgguvCPVeLARQfxtZietBBdNNvJcYXiDx94NoD6
 ItTEfJ1tO6Gtxh83IjR4FG+ERG9/eWkKGVKwVGscwHSXLZKw1NQu5rjdYn3kTpSkxT+U
 wmuYsAez/9ozlrR2BtX6+u7aJsGzsoYtDVWJABl3H/tUPtuoE+OG2KjZegn6t44svj40
 w7nkLPxLcKAgCI4WkDMg+r5kptFgqaoHjXCCAYXxkhOHgkCysaJ0M3Q8BPS2wX/o5Uk1
 IWGUd2bWIazSavTbtpXYm4DMNXsSHvol21ouniL527T9E1z/dZ5wSJ80M50kCFU0+ujF
 NutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998575; x=1754603375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8xMV4hii1xkjt3TGEIWc3xjBMXe2QdhzyM56E/Zdps=;
 b=LspoTYpht2XfiKXYG6/+OeVpOX3nxLuD6LuUffBFCenhDfEM4qEZ6noIlXMZHPnmFu
 vuYwvLYy40PGMJVbw293JUIOYGzw0WfYVhRFTg1BFx6D4JY+3la8cVd4WEt2xNW9sY6R
 XSryCZMpyR4LN9jfJOkUYoM6RJtdtDKts6W/5BCOd4kkYZOOoNyepyn4yW931Rvsfv3A
 ZVZyW36UkpzKFd+Esg4S3h5Kws8Z50W9jsSJNbYJaX8RebHY2h9WRf/HlRL8DUlNZQZW
 OGO2dgehE0q2B+TFhwhEfsKTtPfybq5CSYLel+TLp7xOM7vk70oAHvfpdLIFkVGgLsYr
 sTBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMJt6/mxtCQCpCVKd/KiBHHULZLPNTB0F7QWH5oOR/RUFL0h7+ZbIuaCNSFuLh/BW0pA/rqZfP5jJT@nongnu.org
X-Gm-Message-State: AOJu0YwWjjBHsJoMFoR9S6PH7Zattkb1GvoAgGC38BSQepBfuG8n9MyE
 UTr+7p1GBCcHH3le7+TSmR+G47p+nx1rXFNCMqcdMp8Fub6/K+PhviXVL1tzZx4pKWI=
X-Gm-Gg: ASbGnctCRG1q4lNM7a/rXeWZ7p5Bn+NjrJCsEerQsR6w8MnQf1daNg64IzC+yCyCUAq
 i43uXpMvCwpLv/u1V2/z41dgq0UJ18Tx6kKKcmyssrdyuWBMtP7ZrS0HuMd4dnYQ9ZYU5lIOK2s
 zKXDKCGoSEj8+yMKSitjQOFZTi5uY3ciBKs3BDckXg9ge4aw5zm2Hsrp/ygLdG4aDdxvelTWFDG
 0wq55cYNy4G/CNfgrXqf1W8e2TxEvgkKKA3GcmOw3eXNzKO11e1olvYb1iGfPwk8d0WAAQIrSbz
 t8v7ps97OUq3PowQM95hmKwxmA/5e+T4W44YGfQbvpw8lio9eOXm9yb0k2oX8g6bFrQthP7GPKf
 2Mq7gXMLG+lGgdWrz9jRUul31fV5gv5xgYdI=
X-Google-Smtp-Source: AGHT+IFeRsqvvS0brE+9yCeFceZLDh9zm6+yIw9g8eTMwy+ffdi/3TxdyqCJzZlc6+RZzQIX1auitw==
X-Received: by 2002:a17:90b:4d89:b0:31e:e88b:ee0d with SMTP id
 98e67ed59e1d1-320fb77b06dmr463434a91.9.1753998575098; 
 Thu, 31 Jul 2025 14:49:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ee49ebsm5473194a91.19.2025.07.31.14.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:49:34 -0700 (PDT)
Message-ID: <b701eba0-524d-4c41-bc48-be1e32ead02e@linaro.org>
Date: Thu, 31 Jul 2025 14:49:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 69/82] target/arm: Implement EXLOCK check during exception
 return
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-70-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-70-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/helper-a64.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


