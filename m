Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA04C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdBz0-0001AC-Bd; Wed, 29 Jan 2025 12:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdByy-00010X-KZ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:36:08 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdByu-0002fG-4a
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:36:08 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so48414175e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172162; x=1738776962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FTpyDz1pyMkVfutrnBjGeF25+QFQA1J+1FCECLYY1YI=;
 b=exNbGTTwGSOFKzj0L5Qg8oplx/Zjku8Hn1BD4cHswaNP7MqRSX7gqfo7w0dMaJL7ia
 aFh57by3A8Y63AC859+kmcNK177t/sEOtlY3RxelKBZDLG17RptSivMmPit7WwM79TP0
 rDdrXEZ2dSaCty+cPund86XoOlFFbKFQr+prZXZtmgnYA5OHpDmFrGbgDelE5fSX5Fvm
 FuKM6OCk94CmwUCkwBcyOZSRMjGlzvwKYrdbtXBtooex5CxeqpO0KCXGoyIbDxo71IfC
 qwK+5UnHRmbI+4uaL5ROLqJWPs5z5JsWrhyL2v2jsHfug1I4FwX/W2SgJYOMGkHm1WBe
 c5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172162; x=1738776962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FTpyDz1pyMkVfutrnBjGeF25+QFQA1J+1FCECLYY1YI=;
 b=uhSQVSrLJ87er+q8pmsoJ5Wwdp+1wz595DNjamB4lf7u/xJauaU5VVGaYXuknRUkU/
 /1FKoufbtuyJytFjwh8Uo/4IXBaI1Y7di6sVy0pZIvDac1poPabTmWYhX1JVe5sBEx/B
 WAZCE6YGLWo6QhnPzxinRB+s4wkUVbn5/2WpYtsqTIDJjzFF3jTpTUjD3lYjMeZnoSXu
 3vsOM9qEykOLQOhbPUemNyQIWGw89wkfaiaMWunCUx1/rGyZ//9lDHjJSDd90B7+495X
 lOneZqfK05FC9UPndsOhDLPlJNDQlEHG0KOQuEpJpvxPIOyUQtDY9KBE1YyjKs0ZNTHv
 AXGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV14eCw216ORb4093AZ8/nkAEo6qYHmon2sRjXX3sgXoUS6pcVo4YXLeSiZMIaVNJxhsJ4IKY+wwTUM@nongnu.org
X-Gm-Message-State: AOJu0YxV9XNy1LR64ltCkZapmtQTb62yDJWf310mnBEQc1ojLNDZO2lT
 Q8tq00FM3ijK7e+Q+ajSZBnXyyhJ0RZS94Sim4HJj8EV1yr+0+BfA/J16KlX748=
X-Gm-Gg: ASbGncvQa+BsQXZekhnmDeKkqJhoOQxXA6BCYB0s+UvIwczOiDXsv3rzWqg9Ag0/hAI
 mfXuSyRatREQb2AMX7qSOFRU4qXRDBO2Oc5l7hDsRtKWcPmfUok5lpfRVTzIIIXtdcTGDSrJLh9
 HRCOVFDd6sWZNJEpVcgy1sZZfYI0cRMSjQNdWe1cW7/4xkBZJSSn46o+9BTHvM6xo2EhCeaCKw6
 fJd7UcW+SgnqED6b8mAILiFyhcUUOFYBlV5UFw4iCsZNM/fLxYNJUeBuBuYvowy8K1MLW8rv3mH
 5BfTOSbT8WjrJZwaWBdCsqO7o0aVYe2olUng41iVvsEyu899UTXzmgt6MKI=
X-Google-Smtp-Source: AGHT+IH/IheAJuhKzd9NUSroucqvKxZsULtKguB2NehErJLlQxzCejcvO/smnngEkZurccUX80L99Q==
X-Received: by 2002:a5d:6d0c:0:b0:38a:888c:676f with SMTP id
 ffacd0b85a97d-38c5194a531mr3423087f8f.15.1738172161793; 
 Wed, 29 Jan 2025 09:36:01 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2f17dsm29609445e9.23.2025.01.29.09.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:36:01 -0800 (PST)
Message-ID: <7e49af7b-e74a-4db2-8521-aaf152af6994@linaro.org>
Date: Wed, 29 Jan 2025 18:36:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/34] target/arm: Remove standard_fp_status
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Replace with fp_status[FPST_STD].
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h            |  1 -
>   target/arm/cpu.c            |  8 ++++----
>   target/arm/tcg/mve_helper.c | 28 ++++++++++++++--------------
>   target/arm/tcg/vec_helper.c |  4 ++--
>   target/arm/vfp_helper.c     |  4 ++--
>   5 files changed, 22 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


