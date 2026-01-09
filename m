Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C202D26D99
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 20:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJTF-0000b7-AE; Fri, 09 Jan 2026 15:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJT5-0000ZB-Jl
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:52:24 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJT3-0000by-HG
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:52:23 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34c1d84781bso2720172a91.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 12:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767991938; x=1768596738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/WT9KaLRjgWF0WwHsxRCo4jp5NA8MpK0tDWZnGqOrr4=;
 b=RvlDdFMH50DYm2Ph89wFIDn//y0hoamL+lASqf8BSCOPBTDzTxo/FSIcg+OrPhcLsb
 ooye/NVNbhDglh7dKza//t8nmPEJogNTrPhAbJMQ/3oH4s1AP5gptg0L3hziw2W8NP+N
 T4o6QpA2dnRDLFSkXoSn68BV+dfCpCaGHvDtLIBqkOAVPBZw2T47fRngyVPCjG3YCptt
 AhaQs2LINiRL2WX1lsy8qx0oG5XFR37yVXfQXPu8F+OyKLAyx1G47+He+H6PtQl3Yjfk
 V2ZrPT2O30VCqU5wWdZ+ji9LKTBzmKfJnaMlTwjbFHIYsCNUjO92kwv+yChzZh4G/3Gm
 y4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767991938; x=1768596738;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/WT9KaLRjgWF0WwHsxRCo4jp5NA8MpK0tDWZnGqOrr4=;
 b=rM0fKHZMIybYC+mXixyAqJYHgHKw3RoFGThdTI4a6Im/599mkcI6t1qv+qyTE7UP9w
 aCfze5bhpV/ao0pTOhj97Vd4lui2tHGbtQqpWl9oPDlO7Uwk/pzI5KPiHgETodlelTNb
 DbJVc9kkS4PqnPCLXLNTSnD2ZqSlQZ1CeVVPy3X7h/EYqsHKB05VS3J/DiTgpWDhdF3l
 J+VXysWj4L7MB5RY1ohTTi7s0DoqeQvHsJkaXHLccPknraPLyn2sRuJdjcIEsYXSQsg0
 OCcGILc+PFDP7AoeNfkX4JzrFBKc4GwqAO2latW15RwkShueDmmBLU/7xdBXrS6grMV5
 DL1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIWoR2my52EcGPKD0aGqPC4ZYAlEL9tEh1G9SP6lza4egc3j9H1Nb9/B8dd3L8zPDdXrDzf3vfLYKq@nongnu.org
X-Gm-Message-State: AOJu0YzWXt81eGiigP677Q1FsU9og/BnkGt7IK90ydPBWBf23KiOw9o+
 2ffnN1LrD1XLtOzFxYddH/VLvt57DEAKYzfh7H1ToJHHG2YHDZ2K7bLR/tBUxX7YGio=
X-Gm-Gg: AY/fxX45Jk6ZGob3390VK/LT+/kaN2SByg3jmWtDJdpnAyxp5MbvAFQccwJBFHQ32fS
 QTy1VO/QLWooSKV+AXqLnxbzlHw+xWS0qX+WjisUwDbsbuKwTi84KwQcwzN5Tp32tpMEYpSwdA/
 0m1REnZyxiIhXayWDDSNAGkJfi07uzhw75x10z03PBY1Ad7ySQwjz8Krnc1FftK9IYdOPt1F9q7
 rVuEp/kn763OT/Z1MbEczwrfskKPsePheCfa9fvPsk18yfQJ/3JRBL+wnrw+PlaS91puKi+dL4u
 DzMiWbgdG5DQUSLFPpbww2iqiEH0JwwjCzcDKVtkCwtf6h9qxHe5YllNaRzjlQyVVnqsXCjrdtA
 mYSSLb+eVA3Hu3jb0ENRxiKtLWA4uNXUHH9AcRdLSZ/hg9ThzzoXyv784gMJLyOdSTQWgm7spuE
 9yZ/bW6v0xVNumabqb4wh9WU62Iw==
X-Google-Smtp-Source: AGHT+IFe/+mxMAnLvQLcbgOSprpYeHKv0V5aUcI2c1+QJ2UUd0w3B85LlO5+xYNxler/pcUApwhfqA==
X-Received: by 2002:a17:90b:5708:b0:341:8b2b:43c with SMTP id
 98e67ed59e1d1-34f68ca4541mr10622154a91.18.1767991938370; 
 Fri, 09 Jan 2026 12:52:18 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c57ded24df5sm482682a12.1.2026.01.09.12.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 12:52:17 -0800 (PST)
Message-ID: <a17f477f-bcac-4eac-8fd5-09a6e99c8f30@linaro.org>
Date: Sat, 10 Jan 2026 07:52:10 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] .gitlab-ci.d: Add build tests for wasm64
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1767886100.git.ktokunaga.mail@gmail.com>
 <79ec37f7fa0352d0463ed6ec5496f6a88f47d111.1767886100.git.ktokunaga.mail@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <79ec37f7fa0352d0463ed6ec5496f6a88f47d111.1767886100.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 1/9/26 04:11, Kohei Tokunaga wrote:
> +wasm64-64bit-emsdk-cross-container:
> +  extends: .container_job_template
> +  variables:
> +    NAME: emsdk-wasm64-64bit-cross
> +    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg WASM64_MEMORY64=1
> +    DOCKERFILE: emsdk-wasm-cross
> +
> +wasm64-32bit-emsdk-cross-container:
> +  extends: .container_job_template
> +  variables:
> +    NAME: emsdk-wasm64-32bit-cross
> +    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg WASM64_MEMORY64=2
> +    DOCKERFILE: emsdk-wasm-cross

To expand on my question about WASM64_MEMORY64 vs --wasm64-32bit-address-limit, I would 
expect the two wasm64 build jobs to share the same container.


r~

