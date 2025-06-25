Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F102C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURXp-00079K-Mu; Wed, 25 Jun 2025 10:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURXo-000798-St
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:56:12 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURXn-0006j0-AZ
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:56:12 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b34ab678931so1359816a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863369; x=1751468169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cu2GlKKj1cSFTaMyXmfPW4kzXOV6PQe/F4SEimq5EJY=;
 b=nc/dpqQ9LRgg6dt+3qzSI6xbjwZjtd3ZYW+X+lJvOWQIv2zoLRzMIl55lhJJU0kbCR
 TtyA32+yhcxMTM9B3BkO1jsbI9ZpEVYxlbF7i/kJOXdHDtI5nzu+D83vG3JbCJMZLEYs
 pwjCDjWwN8OqH0Ku36hxvnuireSpxDyIZHTiOCJ3X6djX4pUDzUyKO3S/tWmoPbBkY/+
 kbMvxhfa0c9PFiP+XHLdhdC9N5xWAurOeEW2FDMaBV2xGiTiDYUczWbJCqBkFdW9WCy7
 LCFWbHS001dLKakUgVdsMjTROE40LPNSC2saLhPuYY+EEasyqbdIyMUoqV2XN+6ylHci
 REWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863369; x=1751468169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cu2GlKKj1cSFTaMyXmfPW4kzXOV6PQe/F4SEimq5EJY=;
 b=Y0pdsuofYgQfC7UvvqixIIbv1RT6ul4Fa1cJbRye7+4N+l+vCn4+eB6jhs10iB08lx
 BzEXUH+3nR/uEAdTQkWKcPwOMF6rqNJadACZWluHj9dz/ClZb9tSpURDXWJaHBUacf4R
 mAZLedM1/bN6vopyUojlfdNh93on1oIjAazg8EAx69/sWPE/mgPekDF6KIeT4Cp5lfXI
 pZ+Py+zw7vy4AkQBU3NZAwZ5f2aR1pPqCm6nroX3juANMjlmxSRKbF/6hsPVJBtQoA78
 xzRsLQSoutJ2RJ+pBM9KMBJdvkS2RIFtJVVobCV6cUcmUyDd/YSPelRqkDAXJe2pvoNR
 lN9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf3VfrkbaqWPBZvTKHiCA5QVpBL1blSp1k56U2X+UQ/uVrywt5pZEhF+nkgvPZZVgzQY1A3NRKUVZu@nongnu.org
X-Gm-Message-State: AOJu0YzK3dhXq0MsZkSt5HjwEB/e6c/YZQjNXLmVRrc2T6FNvEVLxBrT
 L5yKKOKVjyKLcC5QecK8lro+h6kfeFPI/hPHNZI2vZzYHcZOM06P80QJT4lhcuUYH8k=
X-Gm-Gg: ASbGncv6lcXBnriNEIqzenZyWQD8tjWJnUzqo0mlVmK2gm8zEc92ZrKu+0SFSm3q9LO
 GtEyMNOyXb7HPUZ9SCZQgs8QN378Kcf9dDqZ327s3aulHGj0uVlViwvgCQD4uBvia5W7pXkn4Sd
 cHvhtt9+PQ0oO2NzWVDZKTr0UU9+iJG8juMWKVhbcKyyx48RtotMJQjNawNio3OLvFMe14/0bNs
 ObNSP5C/ghBNC6q8HzEp040i2vyoHrcrZs91kPylQiRLC9+aPqp7+G6RUfVUhVhAZaP1LMthXX7
 8uezd/5HY+pwkYu6qYNApUkoiqGAkrTWGriYajxrQZExITTsYrt+fKgXvVfEj1X2WuWn3rZkKNL
 1BjUSTA7PMQ==
X-Google-Smtp-Source: AGHT+IEkAFMAjGKvdaJ0JzocMuifqkzCeGIaXPnMWK+Z35UaEw30rogx1SIqLJSLcCjWirrMHXr0Wg==
X-Received: by 2002:a17:90b:5285:b0:313:28e7:af14 with SMTP id
 98e67ed59e1d1-315f269ae61mr4457135a91.19.1750863368890; 
 Wed, 25 Jun 2025 07:56:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f53d83f0sm1979720a91.32.2025.06.25.07.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:56:08 -0700 (PDT)
Message-ID: <8f2cce42-ae1e-42ec-ba3f-0f0ba9cc7705@linaro.org>
Date: Wed, 25 Jun 2025 07:56:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/27] tcg/optimize: Build and use o_bits in fold_shift
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-22-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 6/3/25 1:09 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


