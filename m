Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFD7C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WMX-0005Dm-Al; Wed, 23 Apr 2025 05:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WMU-0005C9-SC
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:25:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WMT-0006kD-2n
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:25:46 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ee5a5bb66so4349646f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745400343; x=1746005143; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Wzeng2VCXUsQVwQ/IrMyumjldJDESf4fFbzpWhxefU=;
 b=cNsKbJT4lviSdIHpaQ3JbmLKNrlNMzUJBGsBewVpAzJlxeiUV6t0c/45C3vSg/eCLp
 lziI6w7837bdI+C0B+d/rwROmnLiGkt8SYJl08fVxeGskPtSlBGKMFEOb+pJisYrfjyS
 ChrWwaYzoYSz7ICQfGX+R/3kPo1AX+B7Po9oH60FlW//lr9Ftce6n0RLLG81sqWZRMx5
 Z9H8AYDyZo7XuKir62dIMkQEJ9nfcIlESFFFXOZqCcAiOnBOqtb4xpX6WXUMG2h8P1im
 /ERSZEazWl6RpBkqwgb9qHZevQZR1CXPkhKVtR15Jlfp9H1jadh5uo+rPxtfTCfNBUUP
 7SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745400343; x=1746005143;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Wzeng2VCXUsQVwQ/IrMyumjldJDESf4fFbzpWhxefU=;
 b=hGQOt5OcAmowGHfPOE0r3OpeL6060Bk9HYUq/cWus3sHLb+0angKqiWss8cf1lwSBJ
 d7KTxMMQefowij7PWwF6tncIbsirNFax3h1qLpXc+3Q1UG8o2adzm+wKHSoabcpz3oxm
 VEqc8d7l0cIH0Z5A9IDVuPNZAACeHz+5dsWCEQt95/2xtSK3TnK34OrCFy9daiLtCNsE
 +2vQJ4KVuqBKXUih4adfyYnHTvUG1JFytiQDGnvNRLgnz3XGVTFmoWQs+7TnVePhmt7t
 mVGzpoiAzQAddo/weMDFipL13qyaRPd63cJgrRIAQw3psxL2abYoTmfgdzpdV1w60d6f
 aSCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm39ovfq5kR7FQmp3riGLE5NfLIFJW6FW5B9Kl63IHe8i7pVIR5ETW2fXHzDCa1S8IpiBDci2fYikp@nongnu.org
X-Gm-Message-State: AOJu0YzlKv8uyftoWlRQuuH7v78iiRJBsal4OSC8Jdwy4T2mZGXwt0w1
 85W/yMQrsqn94QixGg8g+6R57PPCYuR4zX87LappemjNzo7NU5Kv8NjczgC+S1E=
X-Gm-Gg: ASbGncuULdENkNFGw0S4Wx4NVQGUPTwZ+hU3fh9qp/G5SAR2C6VQzwKhbYjqtpXriak
 zpBr+q2B39INjzdLs5kxRkcKguIEzyS1zl3Xnh8HGW6kTEE8SfJQqzuXdcRFk2bS5+/Q+Wkijt6
 Ib1D7FNzOJK/0nNM3f5dHY6emscEgqmhh0WHCxa6hNI+G0My/qmQBaTtPo38opguAJbMpTsjAoY
 FRJMi24wqrWm/kTEfTFsc+DzArC4IEPH6GTfKDrZK9BPwgBvPz2GEjUKf73Q6G0beirtZjCguWD
 aoTd5bs+UeEnn+kWjVrENFO6UTS2A4Rylpn+5UuHb1cM/W6P7rIbHXp2KZFPT7JIIJh3F7UCTae
 FyVcx5rp+
X-Google-Smtp-Source: AGHT+IEN7mkNL33rSTKy0+SPAh7jF7VWPHQ6YMSteiKu4Nb8y1XOMDAlmcB6Fh7Fsm6jo1ykDHNlJg==
X-Received: by 2002:a5d:588c:0:b0:391:43cb:43e6 with SMTP id
 ffacd0b85a97d-39efbaf14b9mr15703568f8f.51.1745400343138; 
 Wed, 23 Apr 2025 02:25:43 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d1798fsm19191755e9.5.2025.04.23.02.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:25:42 -0700 (PDT)
Message-ID: <8412ab07-36d9-4e1a-82d3-c9b8c54e605e@linaro.org>
Date: Wed, 23 Apr 2025 11:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 018/147] system/ioport: make compilation unit common
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-19-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250317183417.285700-19-pierrick.bouvier@linaro.org>
> ---
>   system/ioport.c    | 1 -
>   system/meson.build | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


