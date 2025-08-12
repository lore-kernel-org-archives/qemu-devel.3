Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A05CA0EDA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 04:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulgf8-0000Bu-G1; Tue, 12 Aug 2025 00:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulgf6-0000BQ-OO
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 00:31:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulgex-0000ne-Jl
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 00:31:00 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459e20ec1d9so49541475e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 21:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754973047; x=1755577847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8iLQpSrZs5LYR1kh2Y8BJw4WkpUaVWk076aDBEVtGbU=;
 b=SSAermILw5oQfizFYaZ6vM5Csp3iCkM7mHg3V1UWwAbktN5+RN2lmS1aSHYd2N5IF0
 bpw+ECXFjThulhVPZhWvXGi8s9N8UITIMxrPn0AyES86eRYUkcuskssMhLF4ml/qXlmy
 LcZnc9+khJekusk05f25+JxwTafg9NSL02auvByT9xv/CyH0D4p9jxTaMaeJ7v/qYg2v
 9FyOYobmIrl1W4fb5031+i1TfGStiUJNBtUm8X4O30oO551XXZp+8d05nxX7x2b/Rmsh
 eVdIAzd1+Riuj647WRpmpHhFgtwqHqTVxb5rLufafH0M/YkUAr/PSYmzns0VMvaE5e2Q
 ddNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754973047; x=1755577847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8iLQpSrZs5LYR1kh2Y8BJw4WkpUaVWk076aDBEVtGbU=;
 b=eq1G2fMXafU9wzMRMmWdhvIaVlr+rfCP0w1JXinAnOsM8WV1zET9xiecuEHcUH0Jv1
 vV8N+q+Ue++9Un8aFxDpn1SCZIsa9YQHc7E8Ga9tS2JycVY0cxf7O0GDJ7HoQtBiuXWs
 B1ggL2FwouEO7+e1kYOS/1h2bH3ZAfcC9w5bvc3yp+h4G6yR2ryy9RlTuyv2E6opKZL6
 dJF76ORr2AbefjKagNyjmLGdglDXvPTy2Ww8vLJjhzCrxxhL8exFm/8Cn3x0RppwAb0/
 LrlnQFOcDCnYv5cY0QNxk9Oxc7RBbSnQPaAt9J/J/BxkIYru9YcvRPI7h+a3vm2hSiUS
 QaWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjPUZ4yIIYNQQ0h0BsELbMLkyyiShKg1+Slb/5wO/L8+d0fCUZEh7TuLagtLaLDfoJ69OQCIUI2muz@nongnu.org
X-Gm-Message-State: AOJu0YzOMUoqtvkVmSekVXlUu8aGjW7urB1XIlaD9bMtVotSVv9SZpD3
 LzQ9XneWDETTw6ipTLdVnMT/uKQPwd20xl+Evywr0WM4D7x8D1pYJXBkqGu+AcLGp24=
X-Gm-Gg: ASbGncvjJ8HiRXuwzIW9+gZDKKIg3xzFS/bj2nT4fRcHipOfjGP2eYjLhYcvzV3ML35
 o7QaxjLo6QhG9JudWZg6q9g0oE+b4Dv/fZjWEZGfmRtqfqJ4rSbWNVinqWcL8MaA2EXqKbtjJYB
 5nIrFThLaMBQddAbI6m105nV6WxL+8uvB4D6Gp+Z9kBUx42RBxN0SsRJA+ooHUlPHJNZAyOdyOi
 9Js+JD1CuFiBnUyqzX1f+b0ug+RAR8b4eeNJxe1AfFgZu85tUIEy/NYY+s2KTx2rOzeYjohUe7f
 S1jQl9gIfrrTgS2IWkwnhdwedp23qzsmsnT1V82lAay1/41Qm3aPKBP4yBAq3bCeqcvsXlUIsEa
 TifxgvG4gBLsHCkK50ZZt/XwkxII8v8WKVCM/LPFTceLw8iW06J60Bn8HGdNpdoKCb1DjZO0sQa
 5g
X-Google-Smtp-Source: AGHT+IGb0s83pgcUaREds9xow7jn8S+ExjJurESEVNytMAps9PVMMW1P4zcjN65g1fesJk2n32MO7w==
X-Received: by 2002:a05:600c:35cb:b0:456:1d4e:c127 with SMTP id
 5b1f17b1804b1-459f4f5124cmr129324485e9.8.1754973046829; 
 Mon, 11 Aug 2025 21:30:46 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e577d0f5sm279948795e9.0.2025.08.11.21.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 21:30:46 -0700 (PDT)
Message-ID: <810e397e-3809-41d8-8f60-579ec01032c0@linaro.org>
Date: Tue, 12 Aug 2025 06:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/11] target/arm: Introduce
 host_cpu_feature_supported()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-7-philmd@linaro.org>
 <34cb2f32-1cc9-40af-803d-78f5d995dd5f@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <34cb2f32-1cc9-40af-803d-78f5d995dd5f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 12/8/25 02:44, Richard Henderson wrote:
> On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
>> +bool host_cpu_feature_supported(enum arm_features feat, bool 
>> can_emulate)
>> +{
>> +#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
>> +    static enum { F_UNKN, F_SUPP, F_UNSUPP } supported[64] = { };
>> +
>> +    assert(feat < ARRAY_SIZE(supported));
>> +    if (supported[feat] == F_UNKN) {
>> +        supported[feat] = arm_hw_accel_cpu_feature_supported(feat, 
>> can_emulate);
>> +    }
>> +    return supported[feat] == F_SUPP;
>> +#elif defined(CONFIG_TCG)
>> +    return can_emulate;
>> +#else
>> +#error
>> +#endif
>> +}
> 
> How much startup time is saved by this cache?
> This feels like premature optimization.

It is called for each PSCI call here:

https://lore.kernel.org/qemu-devel/20250808070137.48716-6-mohamed@unpredictable.fr/

+static int hvf_psci_get_target_el(void)
+{
+    if (hvf_arm_el2_enabled()) {
+        return 2;
+    }
+    return 1;
+}

But as you mentioned in patch #9 "by the time we get [here] we have
already detected the host cpu features and have updated env to match",
so checking with:

   arm_feature(env, ARM_FEATURE_EL2)

should be sufficient.

