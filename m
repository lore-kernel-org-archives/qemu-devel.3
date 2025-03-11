Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00FFC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts4ri-0003J3-Tn; Tue, 11 Mar 2025 15:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts4rZ-0003AC-9C
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:02:06 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts4rV-0008Se-Rt
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:01:59 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22401f4d35aso105915025ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741719715; x=1742324515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0L1IyJunlzrWONmYXq6l92TeqPwdHHlWg7dnHvcCg6Q=;
 b=qyEi5ofIo2bjDWtGcSuQmmkf/gq8GQUT1WZX20ZdifbdC2cS16JK9TIy67Wq91mrZj
 rxjM6aotmJ0M5mNqdgAL4J0NppBF8FRSM+xnvR4anNsO16lSLwBXJY9GM8vteSSl5vGX
 r+hRFMyRF93HdKycT+8266pn5pxX1jtKo/R3E1hPXdWlry4XlzM/fYF1VN1PCo3GRLw9
 fuY3lKkxQNnA75DLHOblSYvMOM/IextuVkyRt2V00kQyfpg0pVZMAbA1YxTPUa9uLsUJ
 dJMRX3sloUei5zWWpo8F1FqhaNxqQ5lCaKevIHP5bBihqd6IgcLig7kEO36gNd0uNf7n
 MAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741719715; x=1742324515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0L1IyJunlzrWONmYXq6l92TeqPwdHHlWg7dnHvcCg6Q=;
 b=jwLKGE73sXnojww/Jfh4AwRGtb3+Mukg6EqvHy2BYE4pEhOrkXguAudhwhKL/Y21XY
 5kWk9ovYcqbSVrn3bxheNGduXiFSbWgL/jpDTiZZel75KfVO98oyeId/2SpQ1UeOCdWX
 jGIlzg6L2pdJQlKqT68JaGDqQF6lHOWIZN4so3ZLQp10pilxtygEtBwfJATQWXKXX0Wf
 l7X4fNq7kt2/gk3ykwe+vV7mTqPhlyB5w80KyeNIag40Ta81wFdhRow0zYM4VWw5tjnw
 J2HQpZNV1BzRpw4OO31np5ZQjzS2um51XR2X1Ct2UgSKXJOlnjBXg23gn8iEoR+IL8a5
 1e1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAapWzHykSzdH7fl1u8j76tp4nowi4N3yZtyke9p3ubH80m9BNloXTcMCGWF7q88Io+ypCQCOtXpzP@nongnu.org
X-Gm-Message-State: AOJu0YyagHfWc//91qY/tqp7zx8/Fai33RfeXGLCo2Xeufc9hYAcIbLY
 cQ6dDG8zom1cThA+Qvy+vO/vZdkwJDOxkT0+mXkCZS1YXH0QB50aKaPErZc9hxA=
X-Gm-Gg: ASbGncuSZ8kUhzjPj4Iblmzb89xnwjxXdYnQEA/Fx3AKvRj0xmx4ZIL8XgDALpyvtKa
 qwOyxpw4v7ra54tIVFAOXONtBVWc8aDI69ROUf/5HEPsOxL0bOGdeQgD6IHG1lFMGIdTGazs7PP
 t41zGJOYGKBl8C2U04WgQEN5nJYDJO18vvLxdB+dV30+vomZzS4KO0dFrQFL7u4s53c/ANvIj4t
 xQB+1BCOVysJS9Eeci7SSsgL/ZSq0Toe5vWW1CblC65XUKqjdE/FINfhlz7TWbtm/otjNunpgAx
 4QhGX6wu+gHHgmIrTdotVoJm+XR3R5C3+n+NIe70sMQPq/Osp5SfbbNSriKYSZ3nS4qYFq4II4Y
 GH0VDEwZT
X-Google-Smtp-Source: AGHT+IFohTtcPf6UgF0q6qkvid5xMQoqjruolR3Zic/r9BB0LaNrZNwQMEgzQdLrUcRCuYa4T8eNEQ==
X-Received: by 2002:a05:6a00:a16:b0:736:53ce:a32c with SMTP id
 d2e1a72fcca58-736eb87c234mr6032016b3a.17.1741719715405; 
 Tue, 11 Mar 2025 12:01:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736984f81a8sm11044728b3a.100.2025.03.11.12.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 12:01:55 -0700 (PDT)
Message-ID: <5e61c2cf-1f5d-47bb-8e5b-7cf9aac44ad2@linaro.org>
Date: Tue, 11 Mar 2025 12:01:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] arm/cpu: Store id_mmfr0-5 into the idregs array
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-13-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311162824.199721-13-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/11/25 09:28, Cornelia Huck wrote:
> From: Eric Auger<eric.auger@redhat.com>
> 
> Signed-off-by: Eric Auger<eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   hw/intc/armv7m_nvic.c     |  8 ++--
>   target/arm/cpu-features.h | 18 ++++----
>   target/arm/cpu.h          |  6 ---
>   target/arm/cpu64.c        | 16 +++----
>   target/arm/helper.c       | 12 ++---
>   target/arm/kvm.c          | 18 +++-----
>   target/arm/tcg/cpu-v7m.c  | 48 ++++++++++----------
>   target/arm/tcg/cpu32.c    | 94 +++++++++++++++++++--------------------
>   target/arm/tcg/cpu64.c    | 76 +++++++++++++++----------------
>   9 files changed, 140 insertions(+), 156 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

