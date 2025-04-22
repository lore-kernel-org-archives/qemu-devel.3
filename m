Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7487C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GZr-0008BO-ND; Tue, 22 Apr 2025 12:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GZq-0008Am-NV
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:34:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GZp-00007i-2c
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:34:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so283695e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745339667; x=1745944467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uGP+0RyR+JMexgpD1H0GWcvg6990u3e27v/YUzrn07E=;
 b=bI+CkKqBc2X9y5+2ePhmqxWxNPBK+920dWexO4Gjb+BxigMqkbnA4e/GbknZ2X/b2d
 BpS0BgLhkGLUUTVxsxb9zho3Zon1Wrz/kUZrgy68EaIpr6VwCuCE5nt02LPSL/vZWe0K
 1fJ5HRVJ3B9nysCAQyLdypV4Iq1w15YyaTn/MmbMoImYGpkMcyP9NBT/lS8PJnWJRmYp
 IgoamvnnDan8YsSDMZ88+jZ+8FoHIwKbRr7TiHCLt82bf176jrNIQS6Rm8kyhhhWWcEV
 qC8Q9P/4eQEdtuDLOw/c4Yqp5Yf+UoNC7ummQTBfLnKtXqGCiTMortyWPeXaFNm1s7i2
 icTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745339667; x=1745944467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uGP+0RyR+JMexgpD1H0GWcvg6990u3e27v/YUzrn07E=;
 b=BEAReGSD2hAJLog5U49RCksF0uNIL3xi1Fxigs7seSnVzX2gWSVaZaugxExOL2TcmL
 2rzSvCSvJxxjbZGON5VSCDGp1XEivNHj3oB36xq4k7v5Y2ru2fHYgt57v/hhB+mFM2Fa
 vnfT5CQd4cxNFhEi6p7H0Q34BT8u89zOKMvws0EHkp6cGPK8qT5PTauwMMInBEyDTtaE
 fNKrdhfJswR5mh77wiW9JtftnJO99lYUqxSl6z7tsu/QH56otx3R1gImZIU86Lj81j97
 KLNTTkxKM4dbM4tQmrefVCeAWXS1n+Tw5wqmQ2dXTYm7j9DNDh3aO4UfbunmlCXuBhXQ
 I8Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6c1ivwXa8vhdTz9VTnqKqvhKf8Kgu4aY2lr8EEC5TauMBh6lTmWOWiJtJBsle0bMugMGTP7NxMEcD@nongnu.org
X-Gm-Message-State: AOJu0YwYMaHmCPjpyevC1GzY2SyldzU0AXt+dU/IzG9tn8xo78w0o49V
 8L+c4CkzYeiAWVuQ4eNVSu4/vqk6JjOmkcUgyoxZFrvAVUMaHVzMeJ2x0qbRnE86cF2ubqxPAgl
 m
X-Gm-Gg: ASbGncu7pCJZgGA5NXbRoqPoYjmaKT6SaQyIY+TvqDjADSHd6EJSlidGevfRl70Kkd2
 4JIVJyIbfGjwdGZQ2ChyFPozDx/yc73JMCHQnhbFyJ+4Jpt4dwzF7+Ctjs5VcBqTjeKskbSWK+G
 Azcx5mym9WqDV30OSqJBsTzP7FG7PA56Qnr1m+ewgvZ/hRpdoRUP4LQn0neWR3VEG3cgOACh8zN
 R6hQyVozuNd8OyVR6wIDhUxbhKVH/5ZLO1Xxb6eGVsjt51qfqrEH5xijdopSnJMiN0tlNpIWM7c
 EPBwgJLkVPe1Pv0eB66wyGqg6iAQHHMMLh0F5nW/Ut0cZCWdSv5pV04PfoHrsJb0twO8cANKKbQ
 Cx4+D8SuK
X-Google-Smtp-Source: AGHT+IFm1LuEQSx/elBsJgWaSAlWwQPCdyA9oMTUvB5n946LO067rz00O2Z34/ZUNKw7s9SE7oQByA==
X-Received: by 2002:a5d:64ac:0:b0:391:3207:2e68 with SMTP id
 ffacd0b85a97d-39ef8ba561dmr13186245f8f.9.1745339667436; 
 Tue, 22 Apr 2025 09:34:27 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa421c6csm16043636f8f.18.2025.04.22.09.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:34:26 -0700 (PDT)
Message-ID: <69dea323-96d7-4082-bda7-fc564f0321bc@linaro.org>
Date: Tue, 22 Apr 2025 18:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 130/163] target/sh4: Use tcg_gen_addcio_i32 for addc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-131-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-131-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 15/4/25 21:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sh4/translate.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


