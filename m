Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75945C369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 22:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBLJA-00074k-Nc; Sat, 03 May 2025 18:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBLJ9-00074J-DJ
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:26:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBLJ7-0004uL-Bo
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:26:07 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so3774310b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 15:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746311163; x=1746915963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9i08Z+jcxbTTH6KQSk61zUEyMsxpIEuVYvglLCm0+hA=;
 b=tbjhR0TpcykPkUMpHb+0FLjY/3azbODEbk84StbGjOWJn7zjUN1oC2KNkMTAY946xb
 m/Y2sDnyfY3U9UGnjqf57P1s71YKPltBsRgHxsqbPfvJrnbdDoNTixtoW9OP60XNtvJV
 dJf7eFPN0pYVbtXq4jWBozHjTbp9+2DpEGcU3hlNHjOVM5jErwDSOkR+KXfv2ut1aXQz
 V/6w2uPtTI0N92B0xhptLm20rCZ+TwOT1itbVlrWsRH5iN3mk09/Qrkt3sJhegfCIHRJ
 aQ45xHjnuvjuXFksQdR3zAcAlDQjqMhTKssdw3/AFz5f48GtjeaEXBqrVA2Hol9HhI8R
 nMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746311163; x=1746915963;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9i08Z+jcxbTTH6KQSk61zUEyMsxpIEuVYvglLCm0+hA=;
 b=FtyHLiHQJl6/Q2VDw5OYguWEN244eJpVYTJQPaXT9Ri4XXyHX41aYZBtykApXsSP4p
 74U5XQGeYr3umtvCuIdhh8VEmHhNYee6i5z1BEg/wO8JR443nIUOT47BPXMsnopGGigy
 2KB3b5N8wGkUcGKioimjh2nDm1Z8SBqxDpPLvaI6Plxr7RsHBazpfCbAiYKiHcUSRtd7
 hySIx1l27g9d50fULOeM03cBRkCR55Vx6lLdJ0cEu8Mx+cBrVhbAQd2vcBluOVrpvDOG
 Lu4oy1SdToVlJSRlVu5kEjehCs3P8M339WIJdgh5qGahE4NtlpOPBCphVSSxYXq8wrAG
 8bSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHPmWi9nAItRogyOmCMDaDh0bOtw/BNHYWlvFUmsoFLHjrXMAv8pEgezC/e41CiaDxjNh48Q//33Fv@nongnu.org
X-Gm-Message-State: AOJu0YxZL+hbm/g/C2tbxp1my6uDK17s6e3J9Ia9ToQdLXxU9VHpS7Xr
 edFipHUjLbWbFXZtBb0x14Q+pC2ykH4/WMhEIfITzhpUNo50Ht/2Iv3PdGS8OJU=
X-Gm-Gg: ASbGncvMHum+9oMUsY6FCwRmjemC/N4U5KRmNxxdBRd4jHCdxYxMjnuzEdJ/7iHzq2K
 1KLcjXbT89A5gkHXuP9huicY+v4ivKUz4d3aQ2D1UGcE0o6gL7jqL6lu/79Q6NU17KkeJLqrvEp
 /9c6948x7ldn1LroiPcYng9GlcO4LebXZXbEyLBeICQKKhO7gNyG7bYjqYZC1qzORdy1PNLnbRL
 rQgkshN3jzw1nUggGXmCfARuvSaWE+yeCJQCFz9IojfUFf5X2OB/WooiWDJk78+g/JQcy3Pv4sI
 SZk9L4pQeShhc7OY5QF/tad2hVpBpF84iBCsR+ZnhUWKFxIT3OPXos8kpqQQXUS0
X-Google-Smtp-Source: AGHT+IFVS6pgrVlMsUM12y7XK5SWDSNHy0AmYyU8HwZ9dIIHsc3zzGiZRrDxyDbWSBlN9jiNSw7pwA==
X-Received: by 2002:a17:90a:e188:b0:2fe:a545:4c84 with SMTP id
 98e67ed59e1d1-30a61a7473bmr3079491a91.34.1746311163552; 
 Sat, 03 May 2025 15:26:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a4745f61bsm6240193a91.7.2025.05.03.15.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 15:26:03 -0700 (PDT)
Message-ID: <f37f5c9b-74ae-4c92-a731-803ec883b08c@linaro.org>
Date: Sat, 3 May 2025 15:26:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/33] target/arm/arch_dump: remove TARGET_AARCH64
 conditionals
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-26-pierrick.bouvier@linaro.org>
 <91c5f1ac-105a-4567-b1c2-e1d230d8cfc9@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <91c5f1ac-105a-4567-b1c2-e1d230d8cfc9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 5/1/25 12:30 PM, Philippe Mathieu-Daudé wrote:
> On 1/5/25 08:23, Pierrick Bouvier wrote:
>> Associated code is protected by cpu_isar_feature(aa64*)
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/arch_dump.c | 6 ------
>>    1 file changed, 6 deletions(-)
> 
> Should we assert() in the callees? Anyway,
> 

I don't think so, as call sites are guarded by cpu_isar_feature(aa64_*).

I understand your repeated question on this topic, and I think a good 
guideline could be to assert only when there are several call sites, or 
call sites external to compilation units. For a static function called 
in a single place, the risk to introduce a regression is quite low.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


