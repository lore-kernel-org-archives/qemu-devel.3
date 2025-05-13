Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078EAC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmYL-0000H6-MS; Tue, 13 May 2025 06:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmYH-0000Cn-22
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:07:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmY8-0007tA-Lo
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:07:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so39825155e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130867; x=1747735667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q5InSWHz49sEJKfoQ2QNQ6ZQPGuqc5C2fmBxgyhIp60=;
 b=hHF7VhoDRW+8jmVcBSUcXkGek+q0Q9XvoybkJwfkZYXuDV1NgYftyOiZp60z/vMero
 CW/+TUfbwUnK22ZCpriZGP5kYYuilQn9EeoXR//fTtpvtRWwtAy4gvegfH3QNlMUlG6o
 SDAHiQIrqDmH6clgAE3qy+Q73Rj0NfhmXD1ame8r9ncBV71hkyhmz42E/n8y0Q5PL9Se
 nvMuntZr9KPZZWv9ouIG00It07kQC4pJdSb9c+Db+B2cJIsYkQPqcKP/7SMTQNfckTeK
 Ve/kpxrQuDVlRH25QOMTQsnHUGCb35TErV/3Yrde9qXMksZf0kl+9VM/0gdM6TA2GqI9
 o8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130867; x=1747735667;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q5InSWHz49sEJKfoQ2QNQ6ZQPGuqc5C2fmBxgyhIp60=;
 b=Oc1RDCaULZzcuNtiq4IfSqVdxa1GIjgswuP05Kc3H1XBaYeX+yyOwI1p5gNDxUN9aN
 lNAAdT9PHon6gEH2eeNMeaiH3Ex3EuPu8IlaaL/VrpV8VanwRio2+GCF31viefE6svLC
 pbf1er+oQowrcuFxxnNYGJLyNSF+bSHq+PGRMlxk3NT1dzizl2tAqRJBuqPSC22ZPgaY
 S2t48K4YtCel3BO4c56YEOJBhSmHUn/TqwpPsT4nGB5GyAtFdAxWJC7QFu68ZxNt05BO
 byPCHss6VpPVvA50YgP4hlOnENPdTXem9UUz97OI/UzAngXQ+Vz7SoxAhVDPlrcjwDIF
 d0Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9+yAWgnXTq+fb/wJ4o7LxhvBexLTjO/xVJObYF7GRJ+CBsKPI5J8iZo58uCSKEwrNzqdnall+BHbP@nongnu.org
X-Gm-Message-State: AOJu0YxrGAdQHQPOtv7HL3hYPYPV4dOLXG7liSg1ULLn17VCVUER/82m
 wRRrEiv7BUkUWPtGspC0mXWW1ZSpkAflWx3/V3fJ5lcwRYJ41hv0pT7/YBcPp6M=
X-Gm-Gg: ASbGncvu1QcGoQYywSs0jBeXQx29LcCYtwIwtkFf41J5itUw1TSXtBrmQhk/dfaRwFf
 3P3iWzuKd5E4uR1zRV5MVLHZtSYuuXO1fpDyN+JAHACF5KRsJkiAUXiPkx7kyLRs44Phy7PZuAh
 QWY9LVHgBeaEE+U5NJdSdz9DUqHcO5ADk4RLM9Vl4shAKHRQI2i4VP66u++59uIZk1t0XcVLU2T
 eY0mZdRTgok0+Zc9XNx+gmwU2oDmMUp9mUXlHJ3UOr8+e0IfUMuFg/iLl4xnkjwzUg5Q1Kbqj1s
 HDJ9IJAObRPRK1DaPjPrJT6KHy6ozm00J+gxYdfRjm0kSaFA2aK1g5B2YRBtxDjW0055bMTjA/D
 QnLadk+NeQ05jYJRfeg==
X-Google-Smtp-Source: AGHT+IEOnwxZ1JusNsoCvG1vd1NMxSbChqXI542igsHv2GaoEABqup6FroB8iwhfyjOBtmplA56SdQ==
X-Received: by 2002:adf:b34a:0:b0:3a0:b8b0:440e with SMTP id
 ffacd0b85a97d-3a1f6482d4amr9896034f8f.45.1747130866873; 
 Tue, 13 May 2025 03:07:46 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57dde27sm15954772f8f.17.2025.05.13.03.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:07:46 -0700 (PDT)
Message-ID: <f5c8fc6d-35a0-41a7-864e-ae89713f8f9b@linaro.org>
Date: Tue, 13 May 2025 11:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 26/48] target/arm/arch_dump: compile file once (system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-27-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-27-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


