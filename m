Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E2DC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8l9-0007rj-Bt; Sat, 21 Jun 2025 20:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8l7-0007rB-W6
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:40:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8l6-0006ef-Gv
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:40:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-235e1d710d8so42014875ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750552831; x=1751157631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=edFXEUvbAXoIl+0j1rKDHnFmOAd9k+2imwYgni4DINE=;
 b=Q2b+23aygQy8cfb0hQDj/JbRDC6YU9GBUh+FqsQoCnJK590uPVZ3sK96t/S10ovPmz
 IHXVYJbaQr5O7pFImIVv2jTrS0XQ5G+N+rsCjqHg8b6fvLdliepCdVgcb1v4jN2mKZWR
 +IzhYT6mXVS0XGpvvFywSd/ca20vItQ85EdSOb2YZWIjwnRWKEPnedBOQi5tbRS37REc
 mDb/J52Wa1Jshy55H41LVUI9fy57p90powg46ek5mkAt5gIAXGB/6uXc7VoFuYcMxeyQ
 GmeY0WC7oP0sXlNEw6XkkfFUf7X9p6OUPXHaJhPX69GTG//PJ7VBGoLMher+O6VW1dec
 Ek5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750552831; x=1751157631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=edFXEUvbAXoIl+0j1rKDHnFmOAd9k+2imwYgni4DINE=;
 b=lQAZlRRhw6F/oBpNOX9ri6Q46dN0GgVW7+6zy9PmSO7MQG/Tf+2TeGSe1OTvyERbZu
 Qz0r7jtb1Rtjm9qt9UaUbi/pTzKXQ+dqWAY7H29lo+EaJUQGh4kBifHGK52MvrTxllAH
 q4rtpEUB2ExvBtwZFBGkTjD77UqNTr9j6K0zPu1wsysqBTKYeqjHIIZePH1Dx7KzmizQ
 uFYnu7leDlzhnEVlIP++ZfTJ1qQSsXmRaS9K3Sxt2MqVAVcF5WbOSe+eBsUUseylDTV+
 PGC26Uwoh8YVAQ1xDi/G8eYD2ZEJScZv2BtHIGgv80bUdogdxh4O31AiGG9SwhlKGFYi
 psZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpbKX22BKiudJ/PtkAII92F7bMgdFqxKr0GWEx20fz1hzBB7FYPRm84pBuIIc9atMGfFoh9WOYTARR@nongnu.org
X-Gm-Message-State: AOJu0YwbyTPf8rEwIFoMncI/FQQUFM+9Bzt2h2l3wIfE8vpmjzfoH9Um
 yt9SiJbKqMZ/PtnK1NnehZRWUw82cfwdlroTqrvfZI5UKNdS7dULXrqyByplaJl0dp4=
X-Gm-Gg: ASbGncu21tmlHjIylVJg/+uory9l47CckntaXER2/x8SlI+r/X0L+xy/kitSWSdIqAQ
 Oex6ae9j0Ygip3DtQfNgO4/DL4u7Xs8xF8qQ2wOzvI6DLqQTzrPT+bXFG6DTwT3Qe8NVTUlBGpF
 0yy0ZI5t9dxLP2AYr9ivg+p3tR1RRGQEd9xCFrssQCAF1FGwvBhqFn9JZGvuyynBl1lmHB5Daql
 ARoAc3R8s08UP/4jsnKCoSruq24KvvIagf1HarGaJ96DchZ+h0WQe38Rzf1qHsJH31E3RqWeCGI
 Wcx9LllvnmqZt8zVOIBljX2x7QFWxoaVQRWTazi7z5M7HlOHRO63/MVm7rZDhRksh5Ui0MupN3k
 Oiq2BcuzLQE7s7q8sFBYuxr47mYH5
X-Google-Smtp-Source: AGHT+IGh+Kv7NaxOIDB5K88AU8M8Kq1cG5Tu77XtbY7U6qEi2kpnpsY9HrDrfmnI9rbD1L5O0Qs2TQ==
X-Received: by 2002:a17:902:e94f:b0:234:8ec1:4ad3 with SMTP id
 d9443c01a7336-237d991fademr125051265ad.40.1750552831169; 
 Sat, 21 Jun 2025 17:40:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83f029csm50098165ad.76.2025.06.21.17.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:40:30 -0700 (PDT)
Message-ID: <e5f1660c-abe0-4abd-a2af-72e8077ec0e1@linaro.org>
Date: Sat, 21 Jun 2025 17:40:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/26] accel/hvf: Model PhysTimer register
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 6/20/25 06:06, Philippe Mathieu-Daudé wrote:
> Emulate PhysTimer dispatching to TCG, like we do with GIC registers.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

