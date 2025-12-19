Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC789D78771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 13:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWaSn-0002HF-J3; Fri, 19 Dec 2025 08:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWaSl-0002Gu-UH
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 08:24:07 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWaSk-0006ST-CK
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 08:24:07 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso6860815e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 05:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766150645; x=1766755445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T8oZhgC5TPS6KAZ43zGu6mquJSM0U/DmvWidEawgPK4=;
 b=EoQkZvVGZWhw+2SMJwL7fPeKlIHAYU2yNvifoqxp3zssZxf5cfk+MR8NIsgmvyXpod
 /sC/JRBpNjTHYfYnfcZvaYEFkh8DKffoAdUHC8dQN2PCkTfX6UYeNzBi4gteR07uy79B
 jtAKSNUU99TYZSE1yOJt9AxNBPwPAZQ82vM7e4209KuH6jfJVn48Ja65TRqdZzuReLCP
 LG4cT5saRyd/SIgv+8FcpNJAVG8+RsIbAHKYkf2iNeZCCYiK3BrOqUqAmedofu0EANgw
 RbwDtJengqsEjIQPsVGRUT4qZw84LHPHns66aKyNmWJs3+cO0MibhpXlbN7t6iSc3FNM
 Q0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766150645; x=1766755445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T8oZhgC5TPS6KAZ43zGu6mquJSM0U/DmvWidEawgPK4=;
 b=uaNHTUfH74Uq8bhNVo8m8Wr4+VTIM5XauO1qghKAzBdqgoLziUuNpBh/mMo6Ww7SlV
 gvlR9V/7lwfuo/xtgSg3vjnxxiZuFGMm3thdL+7w9/QH4qylGP7aS4W8I8o9ieYH/NSh
 cSPTc0jatCcv80Y3Qgf3xFb9AfiIEUKB7LKg1dm/sWNWnhTWDQeQsT77FcPYzCwLKzGE
 BWctMruTrK+Mic7Wne0seymhIFB1ePBAmc06Y5r5/2DurQUljCZpzd72JbXBIxFQ2EHr
 nvWzkPa7E+fRATmI5jFmVCMM6auCEkO+7ZRpLQN7rKo4o/m2eWXVZ/BMwrqFcQphihdz
 fkUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2w7j8QT+TUkvSPZFDqP5NH1PAYmpkqC6XKmHv2UPgQGCYsQ5ZtLM8f0Tys5TCPZI65bAcjYz7xHDa@nongnu.org
X-Gm-Message-State: AOJu0Yzi8uq+xHZ8mHTRBtiZqixyoQ/y9NTUHt7XDEctJi+qvs1SD3uz
 R6D9CKlezJBHkcv/HAWbz5ox31ZBbgLwgzVmeJDXarhlrklTMDy4TG5BHEiCsxORFq8=
X-Gm-Gg: AY/fxX5I4YE34LWA24cbi9W0oWsRgmy4250Tp8MvnM/jffeUiXwRMtSo+S3IeVhsGPF
 YbbecTbcRpOL5yRmoSK/VPSmCeg2lgMJxRkzsIhNLQR+fUfNsI8LV3X78D7Fbasjt9eeMOJ/AWW
 h+Vt+r1UbRlNeZFEwW2OdEh3T9DWbVtwsCFh9VMMDnF1kgU+624A+Now56HdLy1lPWeku/9UgC/
 9ocwe5gHGk+IS3rRCt9p5EgkQhZ2gUHkIrbxXFIZu9lX0Wj8jMRDkZ6Ex0ZQPfKVyGcP8rI2ixM
 8FLyZ7JuaTo4Xg2VoIAeZpymTl2uia/KCbbpA150ydXLD/yX4qnSqEgTv+v3tFfvW+YcKvhAp6N
 ScczNIMS94Kx+k5cTTvcWAZvQ47Wf3PyxF8qr/F7SuQiDW/CfqEUQCDHyPhvxsOn2VnV+mUuRqu
 Po3A6iIHNNisotmAS6Rl5wvkAS2o9ARGYo6O0W1Bnsj+/l+02RjlUsow==
X-Google-Smtp-Source: AGHT+IHf47bf29taIY+tBiBHdtVv/R/K3iN8qgDJYUZSMxuMucIH+2ZCgfaQIRq3ak21EECCPsQilA==
X-Received: by 2002:a05:600c:8718:b0:471:9da:5248 with SMTP id
 5b1f17b1804b1-47d19593864mr24087135e9.26.1766150644615; 
 Fri, 19 Dec 2025 05:24:04 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273e4d5sm99326225e9.6.2025.12.19.05.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 05:24:04 -0800 (PST)
Message-ID: <fa6211c1-c811-470b-b63a-d21e57d044f5@linaro.org>
Date: Fri, 19 Dec 2025 14:24:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: Re-enable the MAX78000FTHR machine in
 qemu-system-arm/aarch64
To: Jackson Donaldson <jcksn@duck.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20251218214306.63667-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251218214306.63667-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 18/12/25 22:43, Philippe Mathieu-Daudé wrote:
> Unfortunately while rebasing the series registering the
> ARM/Aarch64 machine interfaces and getting it merged as
> commit 38c5ab40031 ("hw/arm: Filter machine types for
> qemu-system-arm/aarch64 binaries") we missed the recent
> addition of the MAX78000FTHR machine in commit 51eb283dd0e.
> Correct that.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3248
> Fixes: 38c5ab40031 ("hw/arm: Filter machine types for single binary")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/max78000fthr.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Per https://lore.kernel.org/qemu-devel/87ms3e6a79.fsf@pond.sub.org/:
Tested-by: Markus Armbruster <armbru@redhat.com>

