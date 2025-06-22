Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FABC7115A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTBVO-0000W6-4R; Sat, 21 Jun 2025 23:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBVL-0000Vh-Tz
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:36:28 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBVK-0000YK-Hi
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:36:27 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-74931666cbcso304803b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750563385; x=1751168185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rJIlL8Mtrx5FhbRhRVVMaqxeE24s5msq06JFBkTg5Oc=;
 b=YqLOmYYLP+dxbrH4cZfJVm6lZLLSJbNZv6haBBwbKLzsoouAx4KjH5SpOsfeXU/Fgl
 wnKaJefsKoqKO57jfitoRtm2bxr18VYz/Iby7uviAex0CXKFdS64A55pig+bOKBuDdss
 N6CBzKNzeGLMjpwdYald8KKut6YcU4uYPmdcqXFvEhlOlKfoy6qb0uETQLO1T7BBUsHx
 ftR84ccheSydEdO4DgOqnylgjodkhrsVLkXHjj3HrVBgyQoXwuuiNnwZEmEc+SPVf88u
 YRBIZ9dr0DRHdkUrQ3swqw0u1g1VXMq2dbO7Bb+ySQPT1Nxac0P+/9AKqmERONbIKH4F
 4yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750563385; x=1751168185;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rJIlL8Mtrx5FhbRhRVVMaqxeE24s5msq06JFBkTg5Oc=;
 b=xKj3KCUmmyYLh/DsPK2nxOvma+C8m36Hu207v/8U8Ss08RYYlh/Brk751ie7xiZrZv
 tqbSqbaGI2bV+29v0K/V2ZxvFqH8ZYH+BsYLobEaIwStMS9s5bRVym6XWVZo4/eIDHAJ
 ABFF5lR6XYZrFnLFQv3qkB6I1F3TVgtq1GqoJHc0ISQBgIC+ou7LAvayxk0hb/eFUTVL
 ZtSZh1IiEkp8yaGMNCiR1Mu7CHh7Ovybdw1lxUXu4KvN3hYhhwWR/xyRpvUJ34J9AHHr
 rNsalTxOSYo3gb6Ee761ABi8+fX5DTGDcIr4QIEHyQNsUmt8+MR3wOH2zhhxhqtojjFL
 7JmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViWQviFxOzDu0daudscPHNMzRXApbFoI2DV+SQKp3qThGIlKf7tFBKDnuo78REmhg7JL8C3vlj7qpp@nongnu.org
X-Gm-Message-State: AOJu0YzdubOy5QEAIVmDWc+nIsl3XI4H5qAp9J2YSbseqG1YD9v72BP5
 naTL0NVmBTQFWwNouOAxRLvmYQeY3K2EnEDBls6IkOgYSTyy71o9+xwEm3vgwk59AgM=
X-Gm-Gg: ASbGnctpRXWlFrH3H7t+OqU24w+UmFQtXheVlvVa5tlrxVpJ3/WuXqECxQOaooLRHYr
 kWnUzYZY495u+BRfYWCVOGie9eeOGGlHUJOHmqfMUCOliIUYW3Be4fFrr+JF1czwvk4jPVxA82i
 DYuplUYJqeg3XsejB6WeditzU68FVIisULiXFs9NLZp+HsKh2ZqurENQITF+4Y/W8mq3XN0gaAh
 k25Td5+Ny2Q3iBwTfC2LgS6XWZbJpqKTAUYNULdTaqUgmVF8QuQWOmoRcJoutzVAFnhWpDd8Ydm
 U9kpSjI1uuwwtFAbUR4JgjESgDR36Lv3TYDW0nFdRpbZmUKgDew4jq9mMRxj1Bxfybd3X8H+/PT
 gEvuLyogyyB5bvT9QZ+gsTeLxCKfd
X-Google-Smtp-Source: AGHT+IEbBfvG7UGU1HZDhaKB1u0hpDyBJ46AJ5uvOkw9/6PC/L+PpiO5mfAVu6+Ps877OdbuiM/LTQ==
X-Received: by 2002:a05:6a00:1817:b0:748:34a4:ab13 with SMTP id
 d2e1a72fcca58-7490d4b89e5mr12613017b3a.6.1750563384991; 
 Sat, 21 Jun 2025 20:36:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a4a2eb0sm5393398b3a.65.2025.06.21.20.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:36:24 -0700 (PDT)
Message-ID: <aa5b2ed6-16fe-459d-bab3-9d9a5855a729@linaro.org>
Date: Sat, 21 Jun 2025 20:36:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 41/42] tests/functional: Add split_available()
 helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-42-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-42-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> +    return 'split' in list_accel(qemu_bin) \
> +           and tcg_available(qemu_bin) \
> +           and hvf_available(qemu_bin)

Do you really need 3 checks?  Kconfig gates on this already.

r~

