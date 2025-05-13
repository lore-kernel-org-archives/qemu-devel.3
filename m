Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADE5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmbb-0004zr-49; Tue, 13 May 2025 06:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmbB-0004vN-DC
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:10:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmb9-0008GG-FK
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:10:57 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a1fa0d8884so2452854f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747131053; x=1747735853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YmugX3GRqGD1c+UyMRnrvs+PUb5JfixmDAgVPG7ZL0w=;
 b=HYFR00V8tkLZkplecF0Rq0XqZ9Z7QvjGetsClpGPojGuprE8lXg30OeenUB6Omhrxl
 SeN3W1UE9Kkul5ekX0G0PC+wjZU35Arf9IzIW0F1akz1knt7ngAoKT2UYTGjQ/X3NHze
 ArveD0lPe7DN2RXrncLzp2FSghL1BU4SbQXJeNCO+9P/QVPvLG92o/rBZoVHuzB4hkfc
 omcbuDIzX9DWZr7o5Zo2DULlTCsD2ESwSV3PPGh9Vk0jMse51zToyYqbuiI8vlxsEu1m
 1eZzWoXl7TMk/GAPeXXHT3WqJU/te1+fSEqNcrrfd7lpIgpYuWnC1KIBoRENL5lxe2o/
 vHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747131053; x=1747735853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YmugX3GRqGD1c+UyMRnrvs+PUb5JfixmDAgVPG7ZL0w=;
 b=kjhWhv+4kFKDFc3XfXIU7ibTnytRY8EABQmlzToYrG4mc6XQBu0ynqM5qpaKHXC8+V
 HrFE/NiN+99L+1vU/YBElHMhWJQPNUB3gv9BeuHWuFLSMTJGPiKOcdk4AF7Q/ERV5uOZ
 rufEMJW0SYFJUtZpD3zF+pCBT3S5a6OFGj33uFimWoctlpXn9qGIEcoS89+D2rxPtNDQ
 ZF1a2LXLXOaLmThKbSZhwOiHTkNc0E4kpe30zhykqe8D3gCV9s1yUl4X95MHh7bZobif
 27iqBicP7eQGIFFTGZcZakcDP/uOGfPUNUfAIQnVYTvOX7i5chDlRqhV2hMiF6iyIl9Z
 qgeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW//HTNgb5g5f6IV2yVhklzlHFyoLTFEWSYGW49JUTxi8WPcV/E7NJSVgpInmTIiKGG4qGUaBtMgzbj@nongnu.org
X-Gm-Message-State: AOJu0YxyZaJZBMvFr4R3iUbAU/gzdk4N+7OB3wBVUoIENi3+UnI/yBpx
 NR7UHRZfGrMdfM/sBwT7xZO3N+cKxfcZa3HlZaIbCB3py2fpX1ajViv8dG8bXQjt+OqKYBZEx2i
 Sw/omG66v
X-Gm-Gg: ASbGncuPOfTrbSlmJtGOfkl3ElfUlnnoq+mq18OLWraCjtnI/bWZKTHs7HBaKwvt6KR
 HlYAJnSgrbr4SD3vae9mWa1O/3i36HA1swNUOGhPx2adfQHqoDxHubtjqrOVZkyJvCRyIpuonr8
 doAjYfSG/gPeWI6uKF0f42wu/wgpN3MTzUDFOK0MOm0tOWNGqnVsiqixRuCjO27yHUowVWfioVE
 LQf+k/WygOswYqx4xM1jINB/GSOEccg3OmYjwiJdypUVI+tOtp8hFPiA7uMqMhY5nsIXB+shzAn
 L1CH+j/9ADZ3+DbGyWiVOEk09PUrIBeCn3TNmpj5IZfGOy85n0a+R1DKGOsk+rLxg9Jl3NIujSC
 LOpSirVOilS51WDcplz1NRov15Huf
X-Google-Smtp-Source: AGHT+IHPSdYV9Hvg10t6s81fQYAul8iIZbBu93I4T7U/xvXG+7WQ9zkVHbb4vFUD6IQs0mSvASr5Hg==
X-Received: by 2002:a05:6000:1a87:b0:3a2:6b2:e558 with SMTP id
 ffacd0b85a97d-3a206b2e7cbmr6254769f8f.28.1747131053188; 
 Tue, 13 May 2025 03:10:53 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d68585d1sm163142375e9.31.2025.05.13.03.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:10:52 -0700 (PDT)
Message-ID: <9cc2fd4a-2b8c-4cdf-ade3-ded482fff1c5@linaro.org>
Date: Tue, 13 May 2025 11:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 35/48] target/arm/machine: remove TARGET_AARCH64 from
 migration state
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-36-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-36-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
> This exposes two new subsections for arm: vmstate_sve and vmstate_za.
> Those sections have a ".needed" callback, which already allow to skip
> them when not needed.
> 
> vmstate_sve .needed is checking cpu_isar_feature(aa64_sve, cpu).
> vmstate_za .needed is checking ZA flag in cpu->env.svcr.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/machine.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


