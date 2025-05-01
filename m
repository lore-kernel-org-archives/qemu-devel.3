Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE23C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZhi-0005oq-HC; Thu, 01 May 2025 15:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZhh-0005oJ-9l
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:36:17 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZhc-0001iS-8f
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:36:17 -0400
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85e46f5c50fso128233639f.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 12:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746128167; x=1746732967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QbG8B4F3h4q3N9mXDivZajjCwAknOK7U7lhDZ++KnKE=;
 b=b3A1enmAdYpfHS3r9sBUC9HGbW/mD/hIcyAcyeAjMW7gF4J1FcoSlaug6X4qUwuvTQ
 BKdxBnSoSDpCT0DfY0ToehBy8rUBlbub2IVbUVmzMf5n8JPsGPD3MbHKq5srtQDdBtwQ
 KhA6QOfVU41Zphl3AGd9WWRXGT7jg9fYEa/ayeomnorQJAKfZvKhO7DTtcbNB0Ov2nTl
 rY50T6DRksZyDTySjBazptkyaqn6mX91PSMCpDE8a96HbFOSgiMOqXYxmHEWylCPFnk4
 rQLCJLaSC10GcQ3+DBdQFtUjOVXXVy59dU9oiKzsZCoeU3DhJ2TvM+5qGSQN64/59pXJ
 WsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746128167; x=1746732967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QbG8B4F3h4q3N9mXDivZajjCwAknOK7U7lhDZ++KnKE=;
 b=JNQp6lkL9icpoOmHhx6wh2QO08QjgjLCnPwsa6fkPn5+gpyAyAYrYpRmmyxWeCjVcq
 GDAhLWnxMqx46cmKy/9XHcxyV3BP4vN7XlgpzCsAX5RbjS9UsancdG9b7olm6Qc8MAPP
 lIRwGeHddvKHwh4dFgPiQQDgS8tnEXQbqDBSE25rXc4RXWMxl23GiAPKDVaxO9AVBvMD
 vSKk40wo5fG50uJ3JRFR+cNoj5Wz44x1o2xSdEtZDXU2aN/vCc17109T+bVIp1txuVzb
 Hk2vuV5Q2sihBH+DroiwYj9lm5x6h1VSsiX29mmXEwyA1jqI06qNT+opdeKJ0eb/BKeQ
 FNFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVInet6kZ7Bq/qSWwcLVN3u29jIB9OIXpMw+VGKf6OkHTmWkAvMTMNdEjvHVyGnYGBhLA9TBBg0cQ4@nongnu.org
X-Gm-Message-State: AOJu0YwzWBNV970lgkBxTV7tBeQF7uUxHb7+vU7KodOlqigzQi1twxXG
 3Y6AsZXW4pLnbKHV8kRTDP0/yZzrOh2K8MY45zFk8rL6MmP9ZA3JYGe2yosrYeo=
X-Gm-Gg: ASbGncvYU7axZa3e7p6ecL78DwAnPCNVPVskyOqZMv110cx9v99FfzYiu9iATU6ecAx
 SMV+aoyhHZcyTi1Nuy3lkukvMO9uHcwkcOVXVuxXwO8aRJMjdlVrjrcS1UcFsP296YlX4FSigrA
 8Padv7pnoMJJhW+R2LU10PeZM2SNjl8WcZjk7m+IvtM1/fVnuX0ujxGMGLr87gQcw0xxg1gNRy6
 k0/59OBmTH0KLBbRhVxoiU8/6YCg8uv/0M43uVrLkXLdb9SBOFpmGPWFXQeG07G0m8C9oysgcjX
 I9QwjxDlHr9PRlB1LRVM1CHAIBpzKOuk2zsIkNm22j+u0zpwu/UQWIgZrUOFDubvyHOawDc2lhn
 Vhr0acekjvMvCoQ==
X-Google-Smtp-Source: AGHT+IFmEF1aOJSJyHbAQ0USlKrGSdhTT3r6lXu1PXo7h9NeRF/lMEW1uua1Y3ODC30grn2S/YfQZw==
X-Received: by 2002:a05:6602:276a:b0:864:4aa2:d796 with SMTP id
 ca18e2360f4ac-8669faecf3amr60612539f.8.1746128166917; 
 Thu, 01 May 2025 12:36:06 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2ecd8fsm22427839f.12.2025.05.01.12.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:36:06 -0700 (PDT)
Message-ID: <305ce532-c7d6-41bd-89e8-833613546de3@linaro.org>
Date: Thu, 1 May 2025 21:36:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/33] target/arm/kvm-stub: compile file once (system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-34-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501062344.2526061-34-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd31.google.com
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

On 1/5/25 08:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


