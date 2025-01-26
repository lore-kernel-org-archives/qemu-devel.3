Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCA1C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 20:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc9R4-0006nT-JY; Sun, 26 Jan 2025 15:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc9Qu-0006eg-Da
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 15:40:40 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc9Qs-0002BY-QR
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 15:40:40 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so5207089a91.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 12:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737924037; x=1738528837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8IakMPE25WQo15H6bcZ/5DvSR8Tj+5m00/ec4213Klk=;
 b=yLnazADocYunNaCJND2LPTDeQP/jwNRuZIHXvWpBRZiPIYUVEAxjz3jBm3+FbQqbUD
 406SR42SUZM7fxDIAKT+1KUDQP18GiADv7x6fOHGHa1rWye+qKJs2a/wzmBODcEoRkFL
 hlej39XdhLz5xJZhrDp3IpHA2EX9EtQJzo5KqEI8ZKgMQ7PvgdbnyLdHQbYRreqfk4+X
 U6InjY4eI1I1oq+Olgd77AGo94m1bBv31WDMTa1InRIlQUlKlbdu32zShHbJhYRJexyp
 Q/w0pD/L4ScD/xOJS6R2r5feiCUicEFcI5s9jm+1dnzGnZiIbmbpc1hs4/3W/AdFcoPI
 0JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737924037; x=1738528837;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8IakMPE25WQo15H6bcZ/5DvSR8Tj+5m00/ec4213Klk=;
 b=SqgGvyu5qktqSBAQEO5xLHvb3fFpUEMEmTUPrGaA+evf1cUtNUZAYhYbLZWN+sotko
 QOEifBUmvgCMFqF3wq+6gSLZQdnD37jRHBSmoP2TwkQ/ZHKdae8jzLpT2uIV2Bs/zLTy
 y2meC00CwVYaJ4xfEty47kM1R0JjEoGxEmpOOYEr5hsUMcB34uaC2t10y5Q+3a6NP0hy
 7Z2rlhdTEk2iNOKsnT6a7kGDZFn9JPl+FHtyqLUYzcR4V3LpsE6Vwuik0Jn9hCmvXNtD
 D9wHu5umVP888oEA/uzp2TU+ZFdCkMam8dVkwyBlTLnhEQSphknTDmqRJDVcIQNixpod
 zD2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlRZYAV/SGN58KqAwu+xvOoHI15NA4XZWGkOiCBLktaB6CzIjPYzLRnfWu5nWSD5lMLA+v0zJTZ6j8@nongnu.org
X-Gm-Message-State: AOJu0YyVNqBz+sknOBQu0QZbXAGHFEOvgIhVNCnXRXrRaeknIWgImsEb
 501k3of6YWwQ3JOMy+8H65uxlWUgmoQJKSyM1IcNY0EsJ+kqrcI0ntwc7FrtzYA=
X-Gm-Gg: ASbGncvkxtUyFLLRJRMhTsdHbk4dc3c10C7FuWRe6bfViWo7wCfDrZS2P+kc63f+mAx
 hrrv7eGppC3Wrn+lbyKLxR1uRvVKtAO6IBCbntIakcPrvmrf1MIQEI/EWU4DImsu3LII4767JKy
 WZP9sSgOZKNoWMbgyNQHqOaVrNWGZpDgsGkZLItJOA59VsmG9jEF8z+pMjzOrdMMNPOPu/xt2+1
 53fL6wqepYvm3vuhH/2DbeJrIvpdtseHKVWZ8UPBEMJ094/Li6f4H1eUWJAoDzABJYY0lYGOY5T
 bnKC5QQ50vY4T6ITa9SNmRdmv4pwwcN7H4ldOrg8YEYuPK4=
X-Google-Smtp-Source: AGHT+IHFyv2iybW4GBn6ydLEZa4E4dxLUY4YPXTswHBeV0LQk9iq0lO2cyUKBRO3s8sCKps06u6bpg==
X-Received: by 2002:a17:90b:2c85:b0:2ee:4b8f:a5b1 with SMTP id
 98e67ed59e1d1-2f782d30ecamr56371023a91.24.1737924036671; 
 Sun, 26 Jan 2025 12:40:36 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa44cc3sm5572845a91.10.2025.01.26.12.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 12:40:36 -0800 (PST)
Message-ID: <41f18203-efc6-43d5-90fa-ea20416ec01c@linaro.org>
Date: Sun, 26 Jan 2025 12:40:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/20] accel/accel-cpu-target.h: Include missing 'cpu.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/23/25 15:44, Philippe Mathieu-Daudé wrote:
> CPU_RESOLVING_TYPE is declared per target in "cpu.h". Include
> it (along with "qom/object.h") to avoid when moving code around:
> 
>    include/accel/accel-cpu-target.h:26:50: error: expected ')'
>       26 | DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
>          |                                                  ^
>    include/accel/accel-cpu-target.h:23:33: note: expanded from macro 'TYPE_ACCEL_CPU'
>       23 | #define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
>          |                                 ^
>    include/accel/accel-cpu-target.h:26:1: note: to match this '('
>       26 | DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
>          | ^
>    include/qom/object.h:196:14: note: expanded from macro 'DECLARE_CLASS_CHECKERS'
>      196 |     { return OBJECT_GET_CLASS(ClassType, obj, TYPENAME); } \
>          |              ^
>    include/qom/object.h:558:5: note: expanded from macro 'OBJECT_GET_CLASS'
>      558 |     OBJECT_CLASS_CHECK(class, object_get_class(OBJECT(obj)), name)
>          |     ^
>    include/qom/object.h:544:74: note: expanded from macro 'OBJECT_CLASS_CHECK'
>      544 |     ((class_type *)object_class_dynamic_cast_assert(OBJECT_CLASS(class), (name), \
>          |                                                                          ^
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/accel/accel-cpu-target.h | 3 +++
>   1 file changed, 3 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

