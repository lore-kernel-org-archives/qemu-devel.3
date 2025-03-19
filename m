Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570C7C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 21:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv0et-0008WP-8b; Wed, 19 Mar 2025 17:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tv0eX-0008TJ-UE
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 17:08:46 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tv0eV-0004mF-Ee
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 17:08:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-391342fc148so27917f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 14:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742418517; x=1743023317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r6cJ46NE+6C/N/b361UCE3m+ImUZLXl6nCDVIvsVByw=;
 b=e40P0k+WBCj442N8kSevkWNdeysy9CNe4zcYF3mIbvfnGv0C6L1u0FGGt7tzTYLNxY
 AQFY6PQO+aSWDyJN+7M7HvMeO7kCxwjBBzinymNzzXetujq3qWsN7JdxASVxhBEx3gLc
 6rirPqVWbcfsBqS8aKYxEZa3NNVaBx4CzXSdqrUlZ5znm3MLecIm9phsFJZKPO4WCZei
 nCEAFXzDvCCFX86ejB2taneKdHDV14vgczbKMIUNkOmZDwZGmqurqqLazvclEQjdOJZh
 FxFXcrCiw+sHwGLvLAs1p4pErX8Yf/QLc8ZToZjdH5DLoDbiCDEumYahBaO5WtQNklXA
 2bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742418517; x=1743023317;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r6cJ46NE+6C/N/b361UCE3m+ImUZLXl6nCDVIvsVByw=;
 b=RukkujLcKtotZDKeeKfWNjlx5UPHizp0E3+aCVd5pBqLPqeWyk+fA49lbNR+X8QoJO
 9IP+I+hdL6SPxWcSBTitIZV0wRTzVVvA+svaIBlba/ozUmtimPTAMx7h7IfpQ9jCsaX+
 Ophda3BpHMN+AMtFCnpcvUZZ7gyhIvJQqmvBZHsg/wvg+/SyU2Y2M2fFv5G+05Ji1O63
 f3Pq21wDw+BV90DMVGJ3o56duJZp25CxenU/RrePBQ7ODGgaVjZUX4FoVoEVFgW312u3
 oLHx0A0GLXFPmbeDYRDHOfEXnMqA9f3EjH+eai88i0Nz8XR/s1m4gV1v5Xp//1AdNjh7
 AQgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFmsnyCd8troQoxcnbgsm56JLPxA9emCp99hwd5mK8+EOGPxbY/wARWXIwYkXylBb2dPbRyrvGjepe@nongnu.org
X-Gm-Message-State: AOJu0YxAz3hHSBvPvxrxD3bye1COpRmhZv/sauBDwv7/IGHkOWJSuRWU
 1y6St4vwfOpgLqD3AlkgZYC13ov6ZztF6rKaUbAKZSGUSa7HiyI9PrrRe7Nd7Mo=
X-Gm-Gg: ASbGnctYKKGWSMDz6VIDBkpj7EBo70oF/FxISpYquBaiIMT8J2W0TJ7hcZUgbPRPed4
 bZP+vC/+Mda8uKWK92JGb3gRs6CDsvtIzjY9FWBhG6deEOhboV0Hx3wRprYrDRtNdP5ajFprMDz
 Enj6VvQ/1CdLzdqMvC9EIWDPIpSuHzI16mMhnTF31e+j7W4Js36rMIIFKI4icWhN3fleYp+H30m
 mgsBoaKAqdYRxLAUVljFWcIMrcVdSeMf74UskOpBUVTKbuydNhkE5xSlAliEL3a8mwX4fPjIjrD
 xFbOo3//tsvCxu8SENS00heUn7CtZ4AyXY4XTt/4QX8K6DKhMfounelmMG4uGB2PldXdruOUibe
 o7xrhGLsRH+1lrjMV9JTpNjc=
X-Google-Smtp-Source: AGHT+IGaC3kvdJCgsW76CjCrW84nx/1GEcZRp0izrKUfRfnkx4Ba+uzDbJd9iTHUyJ9a0Ty1Ip+hIA==
X-Received: by 2002:a05:6000:1a8b:b0:391:6fd:bb65 with SMTP id
 ffacd0b85a97d-399739b4dbamr3787546f8f.9.1742418517251; 
 Wed, 19 Mar 2025 14:08:37 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c4f9d59dsm21982208f8f.0.2025.03.19.14.08.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 14:08:36 -0700 (PDT)
Message-ID: <15664032-67d9-4a3c-a567-5bf13d30dc96@linaro.org>
Date: Wed, 19 Mar 2025 22:08:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: Kconfig: Factor out whether PL011 is Rust or C
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>
References: <20250319193110.1565578-1-peter.maydell@linaro.org>
 <20250319193110.1565578-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250319193110.1565578-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 19/3/25 20:31, Peter Maydell wrote:
> Currently every board that uses the PL011 duplicates the logic that
> selects the Rust implementation if Rust was enabled and the C
> implementation if it does not.  Factor this out into a separate
> Kconfig stanza, so that boards can go back to simply doing "select
> PL011" and get whichever implementation is correct for the build.
> 
> This fixes a compilation failure if CONFIG_VMAPPLE is enabled
> in a Rust build, because hw/vmapple/Kconfig didn't have the
> "pick the Rust PL011 if Rust is enabled" logic in it.
> 
> Fixes: 59f4d65584bd33 ("hw/vmapple/vmapple: Add vmapple machine type")
> Reported-by: Tanish Desai <tanishdesai37@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/Kconfig      | 30 ++++++++++--------------------
>   hw/char/Kconfig     |  6 ++++++
>   hw/char/meson.build |  2 +-
>   3 files changed, 17 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


