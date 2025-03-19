Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B843C35FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 07:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tunhG-0007pm-Oy; Wed, 19 Mar 2025 03:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tunh9-0007j9-8j
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:18:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tunh5-0004El-Tj
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:18:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so2219305e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 00:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742368706; x=1742973506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vm7WHNUNICAo6isyXzqpwjj9SRx/1pKB7I3hN70dEyg=;
 b=Y8FSfwuR7rUYMFDYOc2cHzy9psVk7fgG48GuzgGem2DBPwjLUVO5rZKktyFRoqi820
 D+F7VGqqKKEj8H7C4mMV9jPOytI+zyMZIIhrUwW5EXYPiOM/t9awqXt+PKgFOL13diKS
 ispMtclaOMHpVjsA//eGsfNHusCtifNn7kNbWYKHt9rsxs5KwsFqnflcDZ+FlonAaSbV
 620ReVr3GjX5DSeKUzE6xSm31pdUYG+Bx1PCPfVF/AOslP1KYZ9zgRdNWngQfWi0hqVT
 MV4A7cBVXfhWgQiyx0iPvB/Rbm9wQcTSZGNI1v5mj6P6B0bG3lEjVv8197phAJCcAYjw
 6JjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742368706; x=1742973506;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vm7WHNUNICAo6isyXzqpwjj9SRx/1pKB7I3hN70dEyg=;
 b=aVMFBlEHADQ7lyiTLpv+2hayJxZlNbvVJsGT/qbX75Wxg07HlNrj3bUmeYpNrM89Aa
 YX61IPD7Dj+vSZcCr+8+UEZcGpbUJv/qkDNxHuybtKdgz9fLUJTSuSWpbbFc1PxMeun3
 xj90OnFmh62H/arCHCW1KFwYtwgkdNhIFqHlEqYfm9+KVqZT7+zGBkxVHrXarvtbpaPS
 zu3weaA9oqEF3WweilhrccIyBYIePj/4et1GDDNVeWAFTiVsSYJMVMT/54UpepKid6Jx
 EF7oGb4BK7HQPBl4slOTH+eJVTAIBUzg7WW/u3NUwLTt7fpDC7jv9Ov+5ELljZvvKZn6
 b/mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVednmpdRXe5pgwYvyUd6ZigOxz6sJ5UPiBoaayHm94+/k3PEhwgpQI5WOSZWSR0aEO1OnUPel9tMoV@nongnu.org
X-Gm-Message-State: AOJu0Ywu18NUXehjDYLzSvm2BeTCBa3ifNraxQ5c4/ZBBi/SMferIJbW
 3JQrQNc7jw+mRGsTHjXbTxXjFbQJYRem9sJU3Syut2BALB65BlJRlDvkitkiU2gdzkpCV+LSCR0
 I
X-Gm-Gg: ASbGncvqXe63bISLo9qgVwza0jZks8BlpL2Fpa9eshRmA0irYLT2Vj01cXI5GW+N3pW
 n7GhgD4h2COEtnFXbD1s/vkEDWBTCMiY99PrJBqmz+a5TpW4czMHALsJZh/l4/1RUMDjhdNaCbY
 iDs7xvWDXazs2eRXCZbrc+D94AE4Hn9qEF7G/eiRkEiO6+i0dvINg/0MJvMsJY8/FI7VXa4Ex5/
 8WYc4mKgyo4U4Q37Dr0WsdZ3goUtiO+bWuHMRvC7rekDInBCNNmeII2bCzwjIJB6KrSykENgGrx
 /KedZ4eVrrcx6Hp4cwkOKaWiL9Ct0i7ezUdCu8XVzE/Rp4rgtc4k5n1Nrp/a8ak/5kwdDxFdx1R
 OXikSphth4yuS
X-Google-Smtp-Source: AGHT+IEX9JnWpwBh9LxlC5wc7gJieD+FoYhzZBTwYbyttzT2wydGLb77edJqp0tlwYDnbfIEzpAi0Q==
X-Received: by 2002:a05:600c:3146:b0:43b:bb72:1dce with SMTP id
 5b1f17b1804b1-43d3b9812ecmr42801045e9.5.1742368705919; 
 Wed, 19 Mar 2025 00:18:25 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f86762sm9865675e9.38.2025.03.19.00.18.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 00:18:25 -0700 (PDT)
Message-ID: <fafba61c-84ce-43ec-8f3a-9f1c7cf27c5e@linaro.org>
Date: Wed, 19 Mar 2025 08:18:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/42] system: Move most files to libsystem_ss
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-32-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318213209.2579218-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 18/3/25 22:31, Richard Henderson wrote:
> Some of the headers used require CONFIG_USER_ONLY.
> Do not move vl.c, because it has other include dependencies
> that are present in system_ss.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/meson.build | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


