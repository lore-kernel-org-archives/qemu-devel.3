Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72709C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0gG-0005hN-AG; Wed, 03 Jul 2024 10:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0gD-0005g4-TV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 10:09:53 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0gB-0000Tw-U1
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 10:09:53 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-36798e62aeeso31835f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720015790; x=1720620590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K5DxLWZbkwEHo4OuCFMF9eIKQ96NRbe8p0tnyb8+JTE=;
 b=gtnUteBDGS4s5XaJOOvtFgWLpyngP6Dtzr4R0nobCarYiXrMmoly+YEY4fVIOE4asS
 zms2FzUm9ptDNnP1XofFSFe+ZgMjS4Hs4HxSFxvRqbb/JG8uCtH2PIu9cByLZuz+Yekz
 beOJccwfIz3wk2a0G1pEKC/2fC76quDw/Z3wZAzUsFbU3g0X5Llhva/QrUBJwX0Zw3lE
 WKKDesHFaB8mvdPwKMzo6bccI0UB1z8pkfLaYTDDLdUMAd4ZbGk0bnYfOFB8m4D3TR7q
 tXaju3mpzFVMySmyZ851twxxPC7KQT8mcqev+W/drHpcwKmm3iYOxITsHSSDaKOrye2Z
 /yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720015790; x=1720620590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K5DxLWZbkwEHo4OuCFMF9eIKQ96NRbe8p0tnyb8+JTE=;
 b=NPyqojF/o0Q9NsgQm+rOgaxIV+vPR0G7MYF1dCScKdL9T4vj0dw2LGRjR8xHTkwLm7
 lS7S8K29V7XEsZlB+uWTzcAGDNBeDn2LIiDqvvCrTqIfrJC+EAY4RA8QJ9NQuXGc561P
 BUE+1J7WV8GdxZAP4C1dBcdzSVRLFdRahXXp1XS/8pcVG8O7p872PUa+SovcEzRkZKec
 EG1p3DZP+qlf1e/MpeT/cc6UF9TwQjDhadllxUOz89ETdBLxic+lSIdvi/u81kRaJeWg
 xMEuTIdyaAFxL0Yhtt9tiT3NAOB9wF5H6s/eDMU0D5Uy9ebuqCoLTUdJS4uP0FgjeQuU
 /9tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoc11rAZ8KYIQyCqqzEKFSzvc7B4k23sLd8zsKAdu7YtpiayQDpv/QyztBT+5Ny9O5b4/gB9267K+D2mUC6mBFGqCt4ak=
X-Gm-Message-State: AOJu0YxQNlrbK2sdzXCO/mhbLJEEb0vFW6BIU3TCiYtghsgjsaOe1q25
 /NLXDE0TGrwpQQvCxlJ29MFo2Ln1gHyoBWA51LzTSamCYa/qmVkkD02JkpN9Nys=
X-Google-Smtp-Source: AGHT+IFH21yFzytjeBWgQsGghEHpLBJfPxc+ZzTtchYWwWlrbngVjYhG2ToAxhn1T/mxE43TKrcPoQ==
X-Received: by 2002:a5d:6c6a:0:b0:366:ead8:6019 with SMTP id
 ffacd0b85a97d-3677571b6c7mr10314817f8f.49.1720015790337; 
 Wed, 03 Jul 2024 07:09:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36796b3efb4sm982384f8f.96.2024.07.03.07.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 07:09:49 -0700 (PDT)
Message-ID: <693bb711-3f45-49e4-89f5-b7ee1b2d215b@linaro.org>
Date: Wed, 3 Jul 2024 16:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] tests/avocado: sbsa-ref: add FreeBSD tests
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240703-b4-move-to-freebsd-v4-0-07191f958530@linaro.org>
 <20240703-b4-move-to-freebsd-v4-1-07191f958530@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240703-b4-move-to-freebsd-v4-1-07191f958530@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 3/7/24 16:06, Marcin Juszkiewicz wrote:
> FreeBSD has longer support cycle for stable release (14.x EoL in 2028)
> than OpenBSD (7.3 we used is already EoL). Also bugfixes are backported
> so we can stay on 14.x for longer. Tests done on OpenBSD will now be
> done using FreeBSD.
> 
> OpenBSD 7.3 stays with Cortex-A57 test for local runs only.
> 
> Moved from Neoverse-N1 to Neoverse-N2 as sbsa-ref defaults were changed.
> 
> Timeout messages expanded to mention being affected by PAuth emulation.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 73 ++++++++++++++++++++++++--------
>   1 file changed, 55 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


