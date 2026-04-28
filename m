Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51B6FF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbbj-0000H6-La; Tue, 28 Apr 2026 02:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbbT-00006j-OT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:07:27 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbbS-0007Ln-58
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:07:27 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so7465525f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777356444; x=1777961244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uFU2ZGoSm/almi5MTkoDlVd5GRD8jawMKIRCUPbOpnY=;
 b=KaGL4dtICnEypiXYQLcJhN/QomF5x1GABdAi8wVqdwAelDEsxIeNJVc0AZiVy1OAWJ
 qzCfDphhpejD0bJ6uzUIY9iu3b7kvMjPF5dyetOveAHZqrRRSvy3Ypq1hMWTWEdRwfFx
 mrgPUV2ni8ybSrpPFvIEd7xOFCuzwlqpEB9tUZByTyYS4VWZJUZxnkG63+MWBj9I/K8Q
 bImZm2OhAzUnfBbM/pr9OUUm86HoyxS+lQtxOdo9AIXpba0ZqkWa5xC+d4NZDB5xROjL
 Bk7WxrQo+VROuZyYdQkEwcVFJovwnqCqqQIO22NCRgODF7PK16rc0M9+S3+XXnPl0jJ2
 bUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356444; x=1777961244;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uFU2ZGoSm/almi5MTkoDlVd5GRD8jawMKIRCUPbOpnY=;
 b=IXizybkj7lod/3vO5f7SFtVfHULtfTUNsuzRu1AG4C/Nguejhsk4yFjvrifhLFOsAQ
 p2GMdZzAiLcowfCiGKrgV8hu8Fn8X3v9biIvdyEs0xXbrbZbmDGwtGH8/nBjoqPjABy5
 42cjK4TJjE5w5E2r0XUJpBzowZyRk4buBlv7l+tNLcwC09qOLFJgPDltS4ZgUfzJqMws
 4a3/C/n5iCVyCWMt2dqCWtXkSKPeFWZen0Lq7p5UaEimHRWrtwRNjV9QTPId54V0BOHZ
 3fMQ8woGTDAWvPuup1RkP7TFEcPXq75LA8YVCEqITn5PNay9Xk4sCp+4t1NrquvbXKyK
 9yeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ82HnO2PO2WHwE2mZO0Gr2eoMwlirXFjpT8lRWaaMZFyCPUDslpYzSL6UUmMEuRjLNKkSd+ina5FhMX@nongnu.org
X-Gm-Message-State: AOJu0YyNtNbXYnC2BdOtsRRqIsS8gPc1XDJy6X71E/8SzeCyav4odnd2
 +uZqWsWa9CGTrz1PyMWZJA0nOlzOB12dhN2YP+yV7e4eLpGntT8KoGZAkO3nEq6BWXkD46JSo7I
 diTfsN4c=
X-Gm-Gg: AeBDievaGd0/AautKy3V66QHOOkwBWRUyvP/+HKl4KkuPX5iMleOSli/6pQ5TP9s/7e
 63TPjiRSYzpImPsCzYWYSHaO4X0eZhfzYRfU6B6ZYlpszw0P12tWsNKAihLZYqPpRh8XlzW/EYv
 8TNgWQc6Exp9msietXlcTHbXbsTVnA2vXsDD9yh38UWeWAtA8GL33AHaNtsvi4k7trSUi/BSQ0g
 lKWUQV1QjO69uUKmORFX3GUbUN3Urt78h3IlLHG8GC9tTkGrFERuegKv/+FRL8YBaZ5OiiHZiyl
 O/g/r1ZXLRZW7YnAQ3dOZx4epnOuYwgSLl33B+TBmNAbcFU5PkZzE7GdfJSlSlIlCl7RXzQ8wnA
 9nz42KnyPXTD3GBk8QdnK6WtxFF+3eqXTBVEYsTQ8XmDYk+Oi2e7ybbI+zKT+OC61HrkZenar6D
 TiNiM1gPnVF74SPqXQJmQds8nUP92flt2OP1P4825u1pENbDICg7YcdODQWS5wT+K5dnjpZOCJ0
 c92/oAj1h1NrnQ=
X-Received: by 2002:a05:6000:26cd:b0:43d:1c39:593c with SMTP id
 ffacd0b85a97d-446496d7a54mr2917984f8f.30.1777356444299; 
 Mon, 27 Apr 2026 23:07:24 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d5ee9ecsm3868493f8f.16.2026.04.27.23.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 23:07:23 -0700 (PDT)
Message-ID: <ee800249-ecc3-4afc-ae3a-fedf5a9ddace@linaro.org>
Date: Tue, 28 Apr 2026 08:07:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/84] fpu: Inline float16_unpack_raw into callers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-37-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

