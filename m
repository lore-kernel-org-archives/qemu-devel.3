Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E8AE6ADE5
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 05:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEiun-00084C-WC; Sat, 23 Nov 2024 00:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEiul-00083d-D4
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 00:42:39 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEiuj-0003k0-Bq
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 00:42:38 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso23240575e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 21:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732340555; x=1732945355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nhg/M+V5iZI9ZKsL5cgeLVB2R2fG7EArTVv5Xxqs/6g=;
 b=sfMyUHATljaW2yqRTYULhchsjTaDh4170NT4TgLKKwWj6fGiJS/bdv6sPtLcbe3JL8
 OsMKZqLfrwS6Te6vVDzGFTOsofk4j3uTBdJDoX4ztjZTki3KkX+uXDmUPt216Qf8pEuq
 4REpscZb7Y1p5+Eh6erFytwKiZLb4GvLGyvkb2CceEJaI5I7Eik7z2QKNZCd5H0z6VFT
 PT2BJUSqPgEJYA3blUjymIca2cZhFkIS2J5ZDRD6FH1OZmsr0jceGOC1EaQ64plPQQlG
 senFW6XVEdwUpbN/siMAeaLuJxTlT2RntzXiDAeXAVN3jwN+4Wjf+ETcfs9gdTfkrupn
 REwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732340555; x=1732945355;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nhg/M+V5iZI9ZKsL5cgeLVB2R2fG7EArTVv5Xxqs/6g=;
 b=ENurt4b28/FFjt+Bi3aEDRek8GvtYcA4Hgneoy0qaAmky2y76bPDSdnAfuWWheQaCC
 6QKSL7iJMfb3/uQeGN1Cna0I2A7+CJXTdjyHosD9rvAdmNhiifvXCjkz8LWaHtZhTDCY
 9Yw4Il7zgrwezXiu2Brof/2rWS9IJf3CGrngDcGkuaqSZMBgLZe1nDHIqA86kzKvd+/9
 idl3i55oOkJQSJkmMTaEe8bI5FDMw1oMbsGOFVyUB+P0ucFys9mJa9GR8rmczUxa1NC6
 X0bPmXmvVjdtgy4xr9bAysrPzZbNNZXRqkVELQnMVNlk3p4X8q7BTffWqCBEsWXTCgqk
 yXfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu2fwmiqnQFfvcR07phBO43Ivhsb7iG7474puz2s/vqdkwGfghGO3lchfUduv3QXBmQ9OzuCNdTqzr@nongnu.org
X-Gm-Message-State: AOJu0YxlU0O0urnHibhckl/FvFUdM81nHVR8KHCFRk0XeDR5+bPOalYR
 S9N1lsTAuTm2HlTVD3sTzDZK3kntP9133v5m78cAIa/oH3hvrjNwyk5SyOLpA2k=
X-Gm-Gg: ASbGncvIYBxHeFmK0HbK7JdshaK745YoFzekBPiJCM7vAKNR4oaw/krPmW8KKVhFAoi
 uQMw/HoAJb/t4qWXUWmjYlAyS1zfJdUBErGPIzIjLeMvU4Vq2n1Ggh0N9yMd+tCF73uxMQmvDr0
 ddsrmerDlAigbkMM6u3feCGKvDzwRAzGBvHkURePMvpxuYoJD4x1XgrKD4XVurBG/AJ9Iv6VMpa
 LifWfycsOSOuvOdJlvWE//Btfbxgoz0RcUB04DtBQjS67Fz2Gnqn1GBckwCt1o3
X-Google-Smtp-Source: AGHT+IEupZukp7+WR0NgRrnsdTzgKH5p1UrihkIvT2Wd4PLHL1Eq1mDyvEcmYjy6+Oki0L//pgijNQ==
X-Received: by 2002:a05:600c:34d2:b0:431:4f29:4a98 with SMTP id
 5b1f17b1804b1-433ce4c2319mr41974365e9.20.1732340554899; 
 Fri, 22 Nov 2024 21:42:34 -0800 (PST)
Received: from [192.168.69.146] ([176.187.206.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde110cfsm49083285e9.11.2024.11.22.21.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 21:42:33 -0800 (PST)
Message-ID: <99640655-11fa-4e8a-9d85-c7d1ea011d49@linaro.org>
Date: Sat, 23 Nov 2024 06:42:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] target/arm/tcg/: fix typo in FEAT name
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241122225049.1617774-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 22/11/24 23:50, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/cpu32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



