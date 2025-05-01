Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8E3C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVcg-0003eP-3h; Thu, 01 May 2025 11:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVce-0003dU-Fw
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:14:48 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVcc-0001s2-Gy
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:14:48 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so1053097b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746112485; x=1746717285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jbLSF72pruch0HGWlc9WZf5BHEj56Rx4pJZa2a38Hks=;
 b=sYcBcpvSTPpQe3S37mOEoe514uPZlAsQqtmmiScpi0gFmW7pLTwga15WuPmuYV1eZU
 SrvNLuhJjt+NN3GLlMxjnTmNj2V83IwuJjwFFTcXQLGnU0N3CSnJNF+HtduImNkmtplK
 SAjqK1iYJpCOzafEOSY+yTO25Xpuc2auKHthGN14jafqNTR3j6UMPh4s+2kRtBFDYQXp
 CdYoV17lzXw+nxR1s9x3OLmjEM7CVWs6misrq3Crlr2ygKX0Fc6O9xZGAmg4pfe3am3y
 fGLbx5Tx+xRa+BoDxAwLiV+/IQL6fqjg7N+71IpPxA5VYT4wH9cW9UkrZl5mi39O5MMO
 iFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746112485; x=1746717285;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jbLSF72pruch0HGWlc9WZf5BHEj56Rx4pJZa2a38Hks=;
 b=tN408Rh72r18QWXrjHMASINtLYFt54n+Cop/PY2pH7DUg1oKAdxFwIhC0D/7e60K4u
 mjuJTO8bh0cQjRpoddb/TACj2aHSSJw1At5VsyatO4JSGvWQKvdXi6/voDP+AQOy0sCj
 VHzjOqejCsEBIUONHebcXG2IhYrKkSm6/7sw+Y5Jl2xRjsqv6ji51zFvibjN2LeGjhw4
 FOTK20C/OyaDKQ8LHIJsGryqeIqpr6qeUIf/tgyFa5VYkd1dC0k4HHc86bYxxtRInPJA
 Ul5R+2k/z9Bqem0AlF7YUMkcEpgtxPwpw7v/H32eVZRlAq7jYt8UjmNGilmt9vHhzTAC
 0LDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBIZlszHCXW4OIs6NJrgHkgHk+tDhBFg+tnKDngWu+dedYvlPLrQLimmgLvtsLYHIrw4WorKvFgM4/@nongnu.org
X-Gm-Message-State: AOJu0Yz0HRunbVoXMjgqq2MEhwS6ljsc2dxdJ/GF0it69Ds09prfxe73
 Q2LZjp8VHJadwYCGoYwOcSUROVBXYXUMAcpd70+qxcHNQJZSL+QhWilW5dxKJSw=
X-Gm-Gg: ASbGncvlwaBXYkqTfrsJUV2OcVsAU9SxnXWS88ivLD+tC5gqXpprhOEhOzJTCmNI/ug
 FDAan7jSlvoMpUR0hbVICt5dPV+R2MZpqmt4DANBtZJ+CDwln+D85TFlANYBbcU9/aEPEh/6d3r
 viz79RDB4leppQtsvBzwHoVbe3/7fYJLXqP2OyKNgs9q47BLxwMVMagkfwUB9AkIx+72XJsk3Wn
 eoi40rTfPl8oEuVhzzxOve6lJSGJp0R/IMXHFYvanczLNIs1VONYzHkeTjK7dMaU9N5pY447iJ5
 MwXQwqZ5oHhfc0SeABhUKxIq6oIVC20Dp7zrru9nfNUfc+BJoW+/Gxk7eYnXjA3LxYJ8JlkNayi
 5Wz+/VlQ=
X-Google-Smtp-Source: AGHT+IFMgvqQh+s5Nyuz5qPHiDHOVmpKnz8SegFotdFjKojk6rVGT/GQv6niP61swtxBzwtl/6INPQ==
X-Received: by 2002:a05:6a00:2309:b0:73f:ff25:90b3 with SMTP id
 d2e1a72fcca58-74049275c32mr4772573b3a.24.1746112484843; 
 Thu, 01 May 2025 08:14:44 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404eeb1355sm917352b3a.20.2025.05.01.08.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:14:44 -0700 (PDT)
Message-ID: <50a5e081-97f9-4054-9b99-fdf1c1e88e72@linaro.org>
Date: Thu, 1 May 2025 08:14:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/33] target/arm/debug_helper: compile file twice
 (user, system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-19-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-19-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

