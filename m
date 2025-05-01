Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4E0C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVkW-0000Nm-6A; Thu, 01 May 2025 11:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVkU-0000NZ-ME
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:22:54 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVkS-0005Ed-Qp
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:22:54 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso994543b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746112971; x=1746717771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VNk59ZUe6VB2+qVVwcJX9X+M3hgSClHFSRBg0Eem0Gs=;
 b=QrNYtNNhSPqqtdngfUaDLXajJ3Bah3C8+UQSYJRZ7sLo8q0BiVECgD68UI1Oq5H4y4
 wqOLN1DJyx/NYshtIHYZLlZuseHHm3NS0Ed0gjaGyW8wAFhY90HIt9lXhPKgL/x+XbcZ
 EODJ4jrrMw6Wr098g18SqQWTPb7IYsxP97C89/jbg91YuB74BQD1W19dDvof7a0r1uJX
 8UdsOA86ViaZEFjepwxNeJz5bnpX65plOBJTUEVKpDqEIV9rs7+WITiTBKRuOZe+BGuh
 jmqLAqfBaTZR2spLA98SmR+aLwuuo+Bpca9mtQPYb0HBpF0DL9UcPdJVG57PA5RikS2d
 bQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746112971; x=1746717771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VNk59ZUe6VB2+qVVwcJX9X+M3hgSClHFSRBg0Eem0Gs=;
 b=LXKpkVfrDx8mnPQv3rYMwT61AP67GaeCh5mTMMoUoPc3CH31ew5Gk9R/4MesvajrkR
 N2mmeQ+g5qzO4CdBds+chjx7vISvFNMZiD5mpPXeIhnk0QX7j8eEGYUifgcd1AilZUwA
 5WpLRHIOPb6UwFfTSBnAvWc9OfLe+0P0UuWLog+moZaqrCk2wrifyqKG+Rz2pEabNjfb
 N65MSytSeC2iHn0Pz/hiGTctxHPdyzLkZev8QJhHw/MgLEy03NDJk+Z8I8FkmxDZ7vXp
 kBLWrS9yKtRxZlAc18mzdUqhwrClY5F9/UFsd23NE9/GaGuwMNcXBUh45ZYSk1UtnWFV
 0bSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRtQls6r3gPWW9DMDAnCRJ2cSrqxiXXhIVNky7Ay592NO6qT77oU04DXS3UyCB48t7B1MptHkPQIh9@nongnu.org
X-Gm-Message-State: AOJu0YwPdRTdH7yd0ofd+vEDCwtHD1RL39AcqIevYVG7KNRs0ckvMfVz
 GM1E29wDfc8fWv6ozmANntamVQ9AqIG75Q31pRHnnFEkJTPVpxDfTwzwP0nDXag=
X-Gm-Gg: ASbGncuA3Ehd7CZbG//v37rRAmM9kAXYA9XkUOSeuwb9ZO93PUGObsFNi58c5VGiOC7
 00Ke1Z2dHJ0J0JA9wL+99YZWFqJHux64vp4XczBTabkt1GezCCuahP7Kd4QZpni9ivnNqyFSO8b
 +NJ0dpVyx26sgGEjBjnbufPLz7UZHDr3Unefrtoyrf9dvCZoSSWtYm9O36XpRuRnOJob8P42Udp
 7qEB0yrKABcSkVeWbHfp8TP6V1YDP+MwipF9Ms6yeNY69hP694m4LULzYo2bO3qiJqdQxI14Pw+
 gsa9IC/USGRH6xduk8Q/Eqw0SMyHsMWX5362cySdUfsqNp0X/tBMUYNAy1ITBbY6uUYsHTMAOl+
 m0ndhY4E=
X-Google-Smtp-Source: AGHT+IHEkKsYHijqlvDmsJkdkB7qRhJgVhFklXe714vjVtUTqiyTUvUoNgHymuMuN/rnrtL7UgPMCQ==
X-Received: by 2002:a05:6a00:124a:b0:736:57cb:f2b6 with SMTP id
 d2e1a72fcca58-740477a8d24mr4786306b3a.12.1746112971170; 
 Thu, 01 May 2025 08:22:51 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404eeb194dsm928712b3a.21.2025.05.01.08.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:22:50 -0700 (PDT)
Message-ID: <aa169d85-c34b-48a7-98c3-cb44a31c878b@linaro.org>
Date: Thu, 1 May 2025 08:22:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/33] target/arm/vfp_fpscr: compile file twice (user, 
 system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-25-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-25-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


