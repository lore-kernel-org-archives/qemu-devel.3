Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38272C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7HPm-0001hc-Oy; Tue, 22 Apr 2025 13:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HPk-0001gO-MK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:28:08 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HPj-0006UJ-2S
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:28:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736a72220edso5476816b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745342885; x=1745947685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rKGdw56E4mhQ7muZoyJxyFMnMSJLBcWgnHzlWladJ1Q=;
 b=VfoBNAyLR0mZOFu06XnfYgPF7wX33KUXNEo12OqQpftanre//LHh9g/JoTODmU6GsU
 R+1WUz9xYiX4x7wNzDnZzr/aLbszITXPxIxVkIxFjmlSk8Z/fNTLDZvRxpOiczcBm24N
 VN8ZYJRZq32p0RJuxpe5Nh6yCX/AsNPJ/RhLh3Vo6aYT3rbCP1FB/VIe+9aF877JzrBV
 +HzW4fxaHmAd39iF0KCugaoySOeR6PhpU4R+dhTNvFcHgBaB1txoYnKBFOC+ep7Wob21
 52MVYLF96kIralcWzpXVb77UoHcSb0AmZsaNIC0dN+Lh7089+5zToWEyc7/kLId05sCJ
 ODkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745342885; x=1745947685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rKGdw56E4mhQ7muZoyJxyFMnMSJLBcWgnHzlWladJ1Q=;
 b=TcOKTSUDiyK9EQ6L8e/6CrXycnx3VD5eymYanOYy5ovfiN3d19TzifqQSe+l8CTIAi
 NRMH09NxOjKLOSh8XpW1phX8Hlv0slvhf+w3gz8Thsa8388NVsgQYcX1VGOSGvP7F9k4
 cBXgRUZfKKAu7V12W/7EmMd2tlNT9RZdStoIt9ElhelyPIkmS/mzBxYYgIBqFcTpHN8v
 ePK+O2zZLHfH3t4a5WzKkm4SciKZNkxkRAqOlKG+1L9NmGYhks0ZLfwM2HDvX3yCJuZF
 sTUSgCacsdWvbgkGY48MVN4LEvfA4c6atsvcmD/ITikMD90bi171hrSqzdeE5/F67guE
 rq0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp7VjvEu0y9MXbQESrkNOegapoL3q0Y3iJJR4sP2TBnFGPz5o7Nt9XayMU7il5a6UbjT+BSbtHcAoR@nongnu.org
X-Gm-Message-State: AOJu0YzpqPKfTJGRxrl5PrOd3yj5iWIw1cHaTVd1cYt9z6+KVhUoUq10
 Zj/Z2fwwZuAfsmfGnEA8XnGzXRC6j//S76yqF9zH1MxniLoB312tBHXnbkFwT8Y2VYUiFjg9AjI
 Q
X-Gm-Gg: ASbGncv59WQfRpOSB+shQTGu3ZX3s2lUSuEVue3KxRyBuav5mumYLhBO1Zg4calfawG
 Hm1Vecp13/xPyFvcp1iNg6IZMJlT+KnOZSih3Vpvmo1T3kAUtxHewcBc23k0XJjA+4uJS7GE1hO
 SZzq0+rlBBwN/I3HezOXmah2fjM2smtlD0vfJsUB9KAW8SNaDIjheFK2NkiaFECL08c8sh556nu
 H28JBp+PhsEgLzZfgJA4/4udSFs26jZwHFPKiZaRvG+xl/JAQX44qHj6Amjqjxega02o35xxO4s
 tCJfvabA5P1KOt03EmcW3vFknulwQvePf5n9vBiiDjOipVMYBYxacm2JHPxk2n/feW4G9zB5fNe
 Y02zwPNI=
X-Google-Smtp-Source: AGHT+IE5zBVmym7v/pK4BqtJbWQ9VmK5IQ0mywGtvkoNZQPtJlOC+J8zFRZw3bJTYRVXCgtZQNnpdQ==
X-Received: by 2002:a05:6a00:3990:b0:730:99cb:7c2f with SMTP id
 d2e1a72fcca58-73dc148fabcmr22073018b3a.6.1745342885461; 
 Tue, 22 Apr 2025 10:28:05 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfaad0f8sm9140963b3a.138.2025.04.22.10.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:28:05 -0700 (PDT)
Message-ID: <495cd1f5-586c-48a6-89c5-e6408e45f734@linaro.org>
Date: Tue, 22 Apr 2025 10:28:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 02/19] qemu: Convert target_name() to TargetInfo API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
> +typedef struct TargetInfo {
> +
> +    /* runtime equivalent of TARGET_NAME definition */
> +    const char *const target_name;
> +
> +} TargetInfo;

Watch the extra newlines.


r~

