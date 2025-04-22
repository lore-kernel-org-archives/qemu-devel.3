Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF20C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Hd6-00022V-Ba; Tue, 22 Apr 2025 13:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hcx-0001zY-Ma
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:41:48 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hcv-0008NO-NB
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:41:47 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223fb0f619dso62743215ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745343704; x=1745948504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Suajg0X5Sbn1KnC2L1BOXXSUTYiHZYzr9uzW9VyvuFo=;
 b=GpX16zzhwG7oUnND8Eb+YvuNgkYr5cIZ7ZJW2uRHMyqDIk7QlciEnbb83pPe28/AIo
 qgnl84OzVgpShDga4pnDItF9y4oE+m9EKm0GdiACh/da8MQTT+x6SZ+qMMTCMh/ujLyX
 LZWhr6xk4tTdCJRwAsrG3z5c3P5974HuIcjfEpQceWarrCyoqaOdb7G7SunQDSBTZjSF
 t7qJwUHG2QN3GwZTjSqzDD2fhKBjHO9S0bKQgTMvXtzo+xnh4uYYrAiB7WZI++CfGWPH
 FX5ri3LG0toX5mv80Hu/IOuV78JtrYCRafrzsjuwMi/w7uepfSnkIJGaJ8lWeNO3Odyo
 aZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745343704; x=1745948504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Suajg0X5Sbn1KnC2L1BOXXSUTYiHZYzr9uzW9VyvuFo=;
 b=DrNmtoRD3eqi6sHpZRjsAc9EwENAzt+wZOU9d8Yq3lPV3BCMCrGgPQ+o32YRv9Yt/u
 y03m21l5DVnSxXZGOWMTyLQDv+1X6ThDztBGwiRnGzF6yQjlUKVaPYIbXzRhkbD+ebci
 m6WNOn1FXEI0RICjY2q12WDmOC3EKzym10hzuAJeFGhMkSiFaEwnnIBLkutlvZY0pC+T
 xwIV1WQnNT0+BWE/q8IvMQu1utXdZowXz4ENTu+ZHgXHxgA3HFiL5E4aFzg3vx/2/TZT
 TUC0JrO06cMhB4nA9+mSvXp9uY3q27JnkW4OqyXC70ZNR/YNE3RNy0uh5Qz9tMtMgmn5
 KzDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhRtRAFCNl0fb8CPb5d01QBH59cbLPqpFigAjkPFL+/vKon+QLi9NuMCJ559Nyxeql2yDbBq5pqcv3@nongnu.org
X-Gm-Message-State: AOJu0YzrCHPgCIWKjHqJWA1y+F/KSOJ8xRLF4pcw13ce/Rv6hHBmeWQR
 +KBkEUU5Qimqs70FQOLkx1PTRLuw1Niol80hUgN9MQNdqIPSQKNvzaZfNTSFrFg=
X-Gm-Gg: ASbGncsR6RQ7w71NZsWwOdE700uTqEoS8VIZQ8TckwY39MT6NvrOkZQlmJ/URSelPT0
 rXE6dKW2xxk7cqnPvmSqcQbOXxakKtJJL+mKyu8ZUX6hMuBEr1WtpohCab/HOwW2W5tfNuDpBbO
 xoIu6YjRqzpLrn/iYE+bEeP1QxkGWgPqYHMTaqTPGDza4WLKbsz9G2vfIeV3N41chN5WndGCd9t
 2BDzhS/wimZLXNRf3R4IECtNdONb9o8XxkYp9XVttExRaVFVTG4/GzKlfljiPS5fD34XgWAjft4
 ZY11jL+QDkDz+inohAxjk4p8p8Zfy4QXg+h7+lxrlT4RCz1iTdmoCuHOOtnSvELMh3fRrfRs5Cn
 SLSHzRAY=
X-Google-Smtp-Source: AGHT+IGs24wk15ZQgElmGmlLcnI4drrQk+E9mJU81Tf+VpdJ0Dcxl2oHK+rpFcAM8BZzp9WBfEdpvw==
X-Received: by 2002:a17:902:e5ca:b0:220:c911:3f60 with SMTP id
 d9443c01a7336-22c536283ffmr222727065ad.47.1745343704210; 
 Tue, 22 Apr 2025 10:41:44 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfaad7e0sm8859024b3a.125.2025.04.22.10.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:41:43 -0700 (PDT)
Message-ID: <53d5e86b-20f8-4c15-867b-adffff8217d7@linaro.org>
Date: Tue, 22 Apr 2025 10:41:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/19] meson: Prepare to accept per-binary
 TargetInfo structure implementation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> If a file defining the binary TargetInfo structure is available,
> link with it. Otherwise keep using the stub.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   meson.build                 | 9 ++++++++-
>   configs/targets/meson.build | 3 +++
>   2 files changed, 11 insertions(+), 1 deletion(-)
>   create mode 100644 configs/targets/meson.build

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

