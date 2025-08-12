Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A48BC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliGA-0005TE-FK; Tue, 12 Aug 2025 02:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliG6-0005Ol-Pv
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:13:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliG3-00044z-0Y
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:13:18 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-459d7726ee6so25886995e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979189; x=1755583989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k8biUhPuZ8v0bOpEwmxilLP/Z15pbn6TWdYsg3Ok068=;
 b=pmeUSxWNyvxLrpluaBIXikpgTslon9rjGJsY/zlcjtvo2wRww42hbC5Lm8FQBK8cy4
 xzvvDWFICCljM8oNlN531OJVndSUcBvMfFT8Zw41an+29yHx3f3lQ10lTuUeCodF+yMY
 03chZ4JLcKQdEvoXYiLRF0iSCvyjvv99umUkdNUIbWXnr8NrYHcDM9h4G/uqcWpagkuK
 vcYa54yFWNNaaYussFiKbEhagkBs7iAPu3+zfXQ0JQgI4PSupN2otI2jv82bT9wqriAD
 24lg22DcHCUBLSw04U1518Vwltmv0nvAqO1TsCNbkoCx14KXrA1Qu5zxGlASp7GdoudL
 SQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979189; x=1755583989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k8biUhPuZ8v0bOpEwmxilLP/Z15pbn6TWdYsg3Ok068=;
 b=ijKxSzqLeLlpDWqdjEETJEx1D2HdLZhl6uQbehN8GtlhQsSWNraDD/OMzA9+ttuIXi
 i64meOiF/vsxLUZsLEqICLRw57pCTF3GNb6xv0wSOyBHLXHlvuGahJWqnM0h7gV9t1Az
 mgqQ1tAn0WKXSZ9rn5oSFGTeUyO0Zf2P6kqSTselACHlwGiu4x0VjQby3uAG1wrmcolO
 JSYGjDAJP6mg8Zk0roq8uccaIeOEh9zKMAvzwq2vszup5QldkabLe6lsFuVy5GCgsZxI
 qzmwNBinxIZxLXSa27nk3Ct0sWEb3SGpXRgvJpd6pPRlEjQPOyINmgfiQ2UvmCbo53Oc
 NGAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhJicN+y10rTUYMaXipfKyzFf8w1x09Yl/XyfXMKfWVc6Te6FNRTLSdA01zKvWQUHpm4lWb1PEh+le@nongnu.org
X-Gm-Message-State: AOJu0Yxg8GIkSM+E1tfazEN5tYPizQ6OZ8la5HoCnRZ8SJ7usOBpwE1a
 PsnYrJnk8H8uJKXcSpLItOKDpK1lUS1fWFsSoIqTyhhjLeGYVIh0aBYBdWY5Su8pVgY=
X-Gm-Gg: ASbGncvDVXlpI366VP8qkZQ+qTn0hOLtu0F4txBRLkOKaxcYh8qRXC20cyMjgeMqe5j
 vLRQ8V+Dgt5OKFiN7KJdjOtj8Ss4R9UcSLDBnmSyW53sbhGaRkFHphSPFpnD2OGFQoXPvAu4usC
 zbisSzBj4ghXfhOUGtfrnLbQZOCdAIdhKvjWiuzqhHGlMqgMJVWLNoWROHpGJudJ+85Vxbk2FW3
 yB4/pt9RWjOx4e41MtT25WlQ0MS2r7OSjp4fD8VZZ34EHb5rp2jogwOjVVr9qzNYADItDf4Huaw
 ArNV4TLnIZh1hqAPnxfGnkDzliIiw394dLi+Gyh1HioR8mt9ka+zSWtsR4mHGwgUUJqNUj5NF7Q
 YaFs48fDF7DDKUxVkkudMqAUB/FdW4jDnfy60m84QmlBONMmQrLipy/jR8mL+fboFng==
X-Google-Smtp-Source: AGHT+IFTGqgNDQH6NU9491xwzRyE+8GDvievYeIoqefjfTdrBxTCa8jtpxuzi1XGkUeJge6fKMUqoA==
X-Received: by 2002:a05:600c:3b27:b0:456:285b:db24 with SMTP id
 5b1f17b1804b1-45a10c00217mr16584895e9.28.1754979188947; 
 Mon, 11 Aug 2025 23:13:08 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e009e465sm34636740f8f.43.2025.08.11.23.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:13:08 -0700 (PDT)
Message-ID: <5cbdfe39-085c-4787-a390-5b7f9a7140fc@linaro.org>
Date: Tue, 12 Aug 2025 08:13:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 42/85] target/arm: Convert regime_is_stage2 to table
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-43-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/8/25 01:29, Richard Henderson wrote:
> This wasn't using a switch, but two comparisons.
> Convert it to arm_mmuidx_table for consistency.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h       | 5 -----
>   target/arm/mmuidx-internal.h | 8 ++++++++
>   target/arm/mmuidx.c          | 5 +++--
>   3 files changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


