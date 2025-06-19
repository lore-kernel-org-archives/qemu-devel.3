Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47C0C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMde-0003mC-Fr; Thu, 19 Jun 2025 17:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMdc-0003lN-On
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:17:36 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMdT-0000iN-6B
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:17:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-234d366e5f2so15337095ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750367845; x=1750972645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jhoSlWH0O2QTPZ3MeX4HDGceEnFV6wiIFjowDSDlgrI=;
 b=ObmTxmqCCOtAwV3xWEAnAOtQi1lhT5UaR6mOHV90XgwEaMwbQK2bvhasmvC1t8VrH7
 femJMrTpHK03jZyyg8ZVTZ7HIp1QvUh+nYfajhjcBu0keSTcO2/kVdhagd4WnBDItD6p
 VLxciqD5cOl38BAIzJHSGbxiEKmzmRariDAynP3k/9QRKT3zzEk59bqxgOhn5Psqg8lW
 Q0ZC8LooWKNPn0VosfOQmsXERglrv0nMA0XCN3TDLZX3h1gRkGWJGwqDOf88ZpYlto3a
 M3FCc8VvK6ObbUSV2Pc+OdF1qEJPXGDp/WCP8OWA7pSwGqZeR/PC+ZdiyHdVwG4028Sh
 q5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750367845; x=1750972645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jhoSlWH0O2QTPZ3MeX4HDGceEnFV6wiIFjowDSDlgrI=;
 b=kMMw7uWk6FmRMutW9VZGfNQ+lcRmRuRXHzGFFBSYtEbdWBLY6YxLcaot1ab9coaDXx
 P57oJRDnTE3ECeiXhRT6aJl78oT1SycowlXZHQ29aGMGe9wFhfyrSho/M0stWAlirK1z
 nd3+ag7XBt6/edoqb2iK31h4HpzIJ5cK8JmD+llPgdTIJV7yD3eScC4fkKmJyCnp1q/B
 szBIs8GlS5ot0CRrhDTyPbEKVewbrurUjhWTgy2N+8xbDOW4VkwC5uaPoxcYCPHCFn+u
 7tZOgqhlpLVMyjmdo/cYMuVaPVU+np4FlWZEGV4PUP8WPbE4v6kn17hfmWoC3RgS25uL
 cYmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVv/0C0purXsQK7bWlppqTDf1jBItvmjF8TejVYvFubXyoSzwSjp1bdOQ9TwSL65ljduuxgEUSFR/s@nongnu.org
X-Gm-Message-State: AOJu0YxmrI4PPW7ppZSC0xVkOaDj0lW0vR186R22s5qzPYFmnVisSuxe
 LrP4fP1UADL+44c6lf07FfEIVTTlIkcfWQU3dvmk0MZfWNzdyIYW9yyjJ1wRI6MFHCZ+k++mlyu
 PsK+ElwI=
X-Gm-Gg: ASbGnctwHwNHZuJGJfScAEQwARaub6W03jeNYiuBexcl15AD0NPYWdVb9yNiffQ1o/P
 fJUwB9HK5eUGl0XNQp5c1cvYvm4pGZ+BjKQNC5bXb0P3u0Cq5v37MYeHyn9+6ZB+pMG4UECbP8t
 U0HtamVNvVya8EkILZCGm0h1zoc+YeBRAVKKl8xf+E30yaWYLNQ/wKTaOLthLO2UC9sP5SgFzBY
 pCNa0I+5aFA1+OTPmuoWm5/KAF5V7oKWs6VCwObR39ceEDSZLKmH7Ziwq41e9UhirZvz15AxzG7
 WRrYSNdvrzNOiKwdaAaxVJDys0Nc1s7C0Y960bzfQB6xs3JhflxWVsKdtr2JLZRM9y7FWeaw7eU
 bFIo+9+aeQa2CNQ6Jrhxo7YF9hmwx
X-Google-Smtp-Source: AGHT+IElwVlHvtgkt9Lq/1h3VrGpzTzbZtdVOabMowVCeBP5i1QrPttQIUPWTiTPRzLjQYPvvwqHHw==
X-Received: by 2002:a17:903:988:b0:234:f580:a15 with SMTP id
 d9443c01a7336-237d97d1d6cmr3875785ad.14.1750367845319; 
 Thu, 19 Jun 2025 14:17:25 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df8167dsm226006a91.15.2025.06.19.14.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:17:24 -0700 (PDT)
Message-ID: <d43c2e41-8ab0-4059-9621-e4fa90216b1c@linaro.org>
Date: Thu, 19 Jun 2025 14:17:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] target/arm/hvf: Log $pc in hvf_unknown_hvc() trace
 event
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250619131319.47301-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/19/25 06:13, Philippe Mathieu-Daudé wrote:
> Tracing $PC for unknown HVC instructions to not have to
> look at the disassembled flow of instructions.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c        | 4 ++--
>   target/arm/hvf/trace-events | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

