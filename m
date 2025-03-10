Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BC3C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trf1S-00084y-GP; Mon, 10 Mar 2025 11:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trf10-0007vZ-Vc
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:26:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trf0y-0001Yo-Lm
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:26:02 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2243803b776so69303895ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741620357; x=1742225157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=slRfnU6Q2/zH0EwAfSsPUw2ZuO7rMZfRwrDu3zuWoYM=;
 b=I7nJil/BHuw7QTAa/f+SIT7HF5wt6ThjqfUhYdP6tbTiZK/wtA1m2T5xlGfmLhxgLH
 43OboBgAy9IvUPArkgnfMmx3pU/4PytYi02cO23Z+/kCB/SG2e2rHirQUMTLy/kq9sJn
 81y9rLhJMDgAZ9O4HKnCg12xepKWwbapvxrBc+l1eZEtqEu1MBr9IYBwBa+a2yXKv7f8
 xzYMcZgi6/QYlwOgEzJQ841PKdhbAfxSoi+wrfT05Cn0KDe1r7pScGBTLxLot5q17L07
 3K/iAIUVbM/33mHbrPkOq7yKWI7EE2b2Xo5ywJWi2JJtsaFgnAghI0v0mSl0detw19Ev
 rDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741620357; x=1742225157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=slRfnU6Q2/zH0EwAfSsPUw2ZuO7rMZfRwrDu3zuWoYM=;
 b=W6tZ9Kv7qQf0HKSTwoekO1sYmjsHB1SmxDZj1pVuZNUtdemqSzrfocI5br0V+mQJuI
 xnOFxOo4TKBuGPgK629jmHp/Y6/KmU3u6a+V8eQ2M00lWA7sYKC7NwWsn5TIVMVxhvfQ
 Fl4Gui4ujmlI8le49kL5eFTlcelAINPy/VctBmr+Ywvt2vvH49dbXf3HugEJM6ruzXa6
 c3Og8yPiM74xwzdSFyCorkA2oDLFTJ4FlUwHr+IxZwIBR28NGLKIZglZ0RGIDqixRtAi
 SuX0zZBGwH8LTDI2XJbxMzVkwamH3pKfqQTvI4LT2fp0FC8PdybZwIue8O1iHCU1/3hi
 Q09g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV0Mb5wlono65kY6WUTbAoIMFC8FjUM5JJCsBSfx4KCvutEah8DZ3COXzSLJSNvpqrrqzbB7OubKVT@nongnu.org
X-Gm-Message-State: AOJu0YxMd4KPfPNsXkYjVRJyuyInZhsfBekWGmxVX43nnED0YBdbwQbX
 +3MaeKcBaW0w88WGirEJRYUPcDGtgE+OMfEqTatOC1hG4vFxA4dpCv60uKwokiw=
X-Gm-Gg: ASbGncsX4yYnielCMJc3/lv8u4wE2WXjAdDvhxZgfwY5/pzAvsTor5yipGQpWh8STzB
 l2V4apPEVUc00ZcNuAS+ZaRUtDoErSJhVK5yduqUFsRoaI48/EuU30h7ViQJq4uLK3uQjrsUp2z
 VPrR4gxo93ure+oY5ZbxojnYhE04O06bMKFq7IeeEbCKwQKMaCFM9+5woans2GNO+7Ef6GcTQNg
 O7eoGl7MPht7q7t+Br5USRa31pMeCRT/iuBxcPjhre+gRAk38wHqv2QMLXvuHgWpaAfpv++rIjs
 OLi4jLyJTv4bGdnnr093j1Ujdn8tVa7AP8yoh8pSaDnzHD7KQIDnsd6KRdeN5fLnjiwbtqvRVWW
 EEgggM+kz
X-Google-Smtp-Source: AGHT+IGuHF5D+4pYZNd0vUvmqUqMBviaQEBy/xUgvjSXM95A52T3sI8CwnGHq+7nP3qNj/ZEksGGRg==
X-Received: by 2002:a17:902:f70c:b0:223:90ec:80f0 with SMTP id
 d9443c01a7336-2242889f43bmr256177195ad.22.1741620355734; 
 Mon, 10 Mar 2025 08:25:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109dddafsm79528955ad.25.2025.03.10.08.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 08:25:55 -0700 (PDT)
Message-ID: <b58ef75b-36fd-4089-aa64-3dd8601a1f5e@linaro.org>
Date: Mon, 10 Mar 2025 08:25:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] exec/memory.h: make devend_memop target agnostic
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> Will allow to make system/memory.c common later.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/memory.h | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)

I guess this was split from patch 3 without updating descriptions,
and this is the TARGET_BIG_ENDIAN reference removed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

