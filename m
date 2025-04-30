Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04171C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACLX-0006Fz-79; Wed, 30 Apr 2025 14:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACLO-0006Az-PP
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:39:43 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACLN-0007UP-0G
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:39:42 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2295d78b433so1881635ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746038379; x=1746643179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ff8Y6zqBYXNmm9gwXG98+NPFRnuYVDI1VQURvXQtWA=;
 b=wCEuF+ecEcyKDp+JN9TKi0xHvnhr6QbkhJTJVxPGonTu9PIwuh6Gwgk2KvomJxw0oz
 FwkCRQKpZW+STwHRPhS4sVoYXg3hif6y84c+FevUIaCSzpqgB24z0U6KplwYCs95kNo9
 DHBEJH3nduO/x1h6FmaEVHtuMk51C+Uas9ZyXawru/csyloh+pFVxSvXZV2fQhbgthEn
 I1GtO6uxx5SHcRBgyFD9AiFVHT7+SukFEzljCTc3l6cWkkt6jBU+XimEmyoXycy/kWVT
 GRwLMfH6UQstg0b+rKi59SDxfzWHtymBrH5fq6BzLNGdd1FvSBSVdS4KyUkUNNE+Z/jh
 Icrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746038379; x=1746643179;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ff8Y6zqBYXNmm9gwXG98+NPFRnuYVDI1VQURvXQtWA=;
 b=l2Bhzci4ma47jxDLvB/wtX8rQSdg8CB8VDXu3x1vSGTIlg+IQcH0p3UlInUwkkyev/
 JXhRTnTTuwdKy7Oqb7mklXp4tmcbdH91M/SlyjMskj34UMxw0qc0gA5lpeV+Ge2quIsu
 4iEIfeiSYSab0JjYuMtpsTUdcHsL9gzxt58UzKve9+l7FL+lgWCyhnb6j26yrC9RueLf
 V0CBgpWdNmSjOfhg7Q2OLJpAOxgMGYEhT1tD5u+Hpf+CmFg826DMjRdq1RQeEx6K2Oxo
 fwX9sfXsTCTUKovQgptN7+bdCG6If8Lr5m8Y88g3mipDTYaglh4BSZUbLd0HNlGHXozf
 J4yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTfFNVx1pCija5oKIBvhzSoIFUec3Mbu2GIMdODSpeDt7ZXoK8xNbp0reBYvISMMZ5VT7DU++lz9Ey@nongnu.org
X-Gm-Message-State: AOJu0Ywz6pHDuPMX0ZRXBRIRnqp84juYa7zqObqV/0zRLnGPYbB5BcHg
 VjrRxET/CM02Emt21tvJhwYoUuUDT1bfmc663B4JJaHJMGC1BQNGdUeLIQx6d0M=
X-Gm-Gg: ASbGnctV5qLHTiBqHng0iBI+UltkH9+j2xCi7dCmKT6O6UWLN8ORb+fO3ByYd2Cn0qk
 YFAKuvQGNeBCg2/YPnMBccgp+bMsnouoXApj6fH5IhpkCzRbAA16FDFL6qE3ScXbGcahP3gfH4Y
 OOpHUhNluGMQEUWZgsGfli7xw9JcK87ret8fT6ub/mlWC739Yh3YY05snn9o9vDGoyoHAzVqSC0
 9i7bmYKEdUqCqWYbmdemKVhKxIeNb4mRDy2LsSnB0hKJdb+qK/k1UpD9r0uYh95qTDxbyrt51UU
 tGCk6lKG4Y2uPDJl3ZjsbIGs2y/Ujjy6OFP1DbZvPVzmnb3wMo+qRkySMfSnh6vNwmrFzzQXIk1
 2+jAOJXA=
X-Google-Smtp-Source: AGHT+IGXF4Fgw1kYgpyx8Ulqwz6AW0vOTKOeRFdEg9TqKru3gxSbDPa1DRENkGOwQUFTbr6oFy/sxA==
X-Received: by 2002:a17:903:3c67:b0:215:b473:1dc9 with SMTP id
 d9443c01a7336-22df5838ca7mr62603565ad.46.1746038379655; 
 Wed, 30 Apr 2025 11:39:39 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5103259sm125531555ad.185.2025.04.30.11.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:39:39 -0700 (PDT)
Message-ID: <1c9aa799-4254-45de-9918-435566299b2e@linaro.org>
Date: Wed, 30 Apr 2025 11:39:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250430145838.1790471-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/30/25 07:58, Pierrick Bouvier wrote:
> Needed in target/arm/cpu.c once kvm is possible.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/kvm-stub.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index 2b73d0598c1..e34d3f5e6b4 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -99,3 +99,8 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
>   {
>       g_assert_not_reached();
>   }
> +
> +void kvm_arm_reset_vcpu(ARMCPU *cpu)
> +{
> +    g_assert_not_reached();
> +}

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

