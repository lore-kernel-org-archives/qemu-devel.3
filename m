Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88C4C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNcs-0001fH-A6; Thu, 03 Jul 2025 13:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXNcY-0001dJ-42
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:21:17 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXNcV-0003SG-5V
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:21:13 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2e9a38d2a3aso146399fac.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751563270; x=1752168070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NqrAfLoSpXy32SZjGkLSj0+5pbZu4fxfsJ4Y6XSk3jc=;
 b=KVvj+/lCrYOo20i/W1MqN+uBiEsZaOcB2uqN2YJV0RWgQs9FSXLhmS9wQSXuflE5Yu
 pHlbfbuiNiV5091sS03MfrPAT9zO/wPUAL3Lb/JTzeRjXXsfJZ4iJMjBgLRkNMCjdyDR
 aGAIYWaYZE5meCzqzM/DHUpNh6u1ACicsyjVui7rAvV52cyBtY8HJ6Z2S+YO++L/bKGc
 dY6+LPEqdFZR1WHTrYmQo8E3YGdThAMk4NaL7OIBcGWOvn0BvZbJZQ7oWLQC60Moqzon
 XT1lN8J3Jw/9lmkh8lC2Em286/YIYHjhJfdJM7qkR7P+BA3lUtNYqMmAhHlGyusbbo7Q
 XB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751563270; x=1752168070;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NqrAfLoSpXy32SZjGkLSj0+5pbZu4fxfsJ4Y6XSk3jc=;
 b=UzhOoMWejPRzib6TQvR+eFmC4gyK0Y+7cs60cMUh1dlJI3jEMbm/EKcH/yqWQhMZfX
 +JtE1saMukluqjn/J0i5PcEjp0m4hkgVHOVUkMO7EJhK47Hml7NxiqOnuccSx+NZbttC
 oHmOXRDaKcZD9+dqiRIXBgZ4gtI69AzHIp6cdRdEpU8rv/uX0S5uT1ngXIEI9RTsgAuJ
 DRvPKzxn1taKcwO5VOpfqdGMQiwuvpzHPDu9hjtsZun7Y5FwlIB2Lf1ZwfU0S9jfo1hy
 YBNQetZnscf5nb4GhBEGbcJaw65ZktAU2XaE7Je/bPhv1oEQqeZeZneYcSflI8ozTT3t
 uvCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0LMttI64E8wbSbhfujHGrQiSdkgn4IyhzKsLW8cxU8K/izO5sLWUPcaheG9vpSa05k7ajPe/pjsfo@nongnu.org
X-Gm-Message-State: AOJu0YyXAKL5VgF2NfMOapr19RMMLn4cSZMDgFFAuTM+9VllGAW1L/M4
 VqLsXuEETwL5edvts3t+VJ6BW92hG7mvKXsmnn77l2jsVWdAO2oR0srMKbWk694qL50=
X-Gm-Gg: ASbGnctYX+seggPo3fqaagmAzK2j61UdBI7/oVj+9lWL2mL/Gz/1R4+gscLzeCmqjoc
 VxIO9xNaHeCeFS39nPPT/ku7rpluqv8dbekhhvLp6f9e0bIGGxB2kFJXPcgu5ECHG1fWSzbCvw+
 cPuARbH2/DYwUIeGPIjYdxe5cV8pzuUILz2V0PZbh6TIAiy+v7TmexeHJxqLtCd7vRMQVZZFIdr
 YFU3hZNEjFk6Rh7fIDxX4KelfUanXvTtpoUdEHftdghQgCSVP7TCqfflcmRhcpEbj1xTmW39OL+
 Ry1LPPO3e1Yqen+E5Am42RK7Qx/f4Q3gxQGnYgC1C8Wpp8S0FHVz9imR2b4HKwx9c8jekFoAiUe
 r
X-Google-Smtp-Source: AGHT+IHVZ7jMsIA9AwgqIo9DR90LBVuf615gjC3zVyIg0CTl3+dcwQRj3+3jhUsv+YqHMjpEXeChDA==
X-Received: by 2002:a05:6870:6f12:b0:2e9:fd62:9061 with SMTP id
 586e51a60fabf-2f5a8c83c06mr6205946fac.32.1751563267853; 
 Thu, 03 Jul 2025 10:21:07 -0700 (PDT)
Received: from [10.25.6.71] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f790209b9fsm4002fac.37.2025.07.03.10.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 10:21:07 -0700 (PDT)
Message-ID: <613a2591-d26e-4698-bbc6-38f5719c59b7@linaro.org>
Date: Thu, 3 Jul 2025 11:21:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 61/69] accel: Expose and register
 generic_handle_interrupt()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, xen-devel@lists.xenproject.org
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-62-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250703105540.67664-62-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 7/3/25 04:55, Philippe Mathieu-Daudé wrote:
> In order to dispatch overAccelOpsClass::handle_interrupt(),
> we need it always defined, not calling a hidden handler under
> the hood. MakeAccelOpsClass::handle_interrupt() mandatory.
> Expose generic_handle_interrupt() prototype and register it
> for each accelerator.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Reviewed-by: Zhao Liu<zhao1.liu@intel.com>
> ---
>   include/system/accel-ops.h        | 3 +++
>   accel/hvf/hvf-accel-ops.c         | 1 +
>   accel/kvm/kvm-accel-ops.c         | 1 +
>   accel/qtest/qtest.c               | 1 +
>   accel/xen/xen-all.c               | 1 +
>   system/cpus.c                     | 9 +++------
>   target/i386/nvmm/nvmm-accel-ops.c | 1 +
>   target/i386/whpx/whpx-accel-ops.c | 1 +
>   8 files changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

