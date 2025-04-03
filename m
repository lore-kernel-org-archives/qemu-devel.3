Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F875C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 16:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Ndy-0000Wz-AL; Thu, 03 Apr 2025 12:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0Ndx-0000Wq-3y
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:42:17 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0Ndv-0007w5-7v
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:42:16 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224341bbc1dso10936005ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743698534; x=1744303334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+9lQ42wWYA/XCTB9WFcBiOun/012rY0RtJo7eYnxpSA=;
 b=YuSTgngbaWJLtLYCCHA1TSyCLs4xlWELCWbX86kGOv1I8Bs58whC6g5jyoRStNjNLU
 OWpq4tCxIULyBgwxXdR5pgL0Lq0KfiJSrXxrq+46yirfH2gBrYbFSCY5vx8R0H9hdPE5
 klO+RSsAWgnO4PzwDDkj9+rIwZ9N6I57NRe6zkhRLuBH9IwSoXqCT4ItO5q3K8+tKaP3
 PzGa4zJPfizlHR53s1f2qNd01rHQApSD3saaNJJaj/ao3DWC5OXP0+sUwL1gYaG/plmg
 ZjCTmxN8mMISNzvo7PvFULacIRxaJz3TOBRi8i4rgyWzptfMHP1wdgwrc/0/W3F+pkJt
 ThnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743698534; x=1744303334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+9lQ42wWYA/XCTB9WFcBiOun/012rY0RtJo7eYnxpSA=;
 b=Kyv6CrMvVdy2dBDG1xgYIrB0LDdThEKNL5TeV3kRCXGzI5o9Bs+Yl6/KdGajYwwG3X
 r0twpC5iOd2e+jQwxm2xRUV5E0eVPGM0/hMBMETz9hGXuopXa4LtT+U4WNDPCqa+SHDu
 CNxroyp4GHRgoCShsHjOr9FxeUIbZ9Hlcq5Ju8DepFyz3vZzE7dpoB1HSrT3IfmygAF6
 D5tDup0HPuzGF+Qv71SRvGt/abAj+GnMNNaLdQeE4VejeYjckC6jeuAzAn6Eb9t0fJdG
 D1uYNniKG/RG4Vw08T3XHbUkjeSHWYEtXgrgjT0nnat0mGEvJnfHjJsMqt/4d7eVkm9W
 mlDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeTn5OwFtDq7dF9pFqYAU6W/pnUnDtXhq2MJEONyoAq5pEl+6g6TxJWm++ZpVjWmpAdZ2BBiPMQdpZ@nongnu.org
X-Gm-Message-State: AOJu0Yx38mPBbiVb1gVFqOAxVeye4o3fXGLlj4g8KTwjP4kEVSlroopB
 1bUN8oPobFV+OWJGyYBiz83G/7Ee7B7Km7AFXzde9USucqC1Bk0Bqz0cNbLBU7Q=
X-Gm-Gg: ASbGncvEcs12sq9ialPJmIhYjsqnSzjytLFraBI+htLAqLbCclnCVDvmyQXgnOi1+NJ
 EcPuCcEOlcA9kjWcR8pyKqyoBEJC/0Yzmb7Tz+sF5Lgr/rJT50G93SVXVCFOxHTA5digjxBTygH
 c/CAkvHcCrAUEP7kjeB4Usa0Ggx/S8iljBI+nPMlKBcV241+r3BkEUDCp3Dbw9X1f+/kIP8+Hgg
 GpX9CEapZh4ZB+YMH97Wke+gOOxE3tmH22sWj1E0lC64CngpWGEQuu9ZaNHB3LAqWQWwA84uxXF
 Tn/byPeJ78nl6M8+ad/YDvWePJMTvMH06SArzvq9ouNJ+JuGMB/ZtABTJpCMl6HOzRPZsoYyVX+
 SsL2yUSIg
X-Google-Smtp-Source: AGHT+IFBSFjioK9p7VLpFJ5MjTOl/Znb94I3XzRtcPmmaxpNjM4BW0heaAfHF1/tQcPcN1LxF07uRg==
X-Received: by 2002:a17:902:d488:b0:223:3bf6:7e6a with SMTP id
 d9443c01a7336-2296c65fd88mr90416955ad.12.1743698533778; 
 Thu, 03 Apr 2025 09:42:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229787763a6sm16777005ad.241.2025.04.03.09.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 09:42:13 -0700 (PDT)
Message-ID: <9efdc346-f48c-439e-be71-efe59b758982@linaro.org>
Date: Thu, 3 Apr 2025 09:42:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 02/24] accel/tcg: Introduce
 TCGCPUOps::mmu_index() callback
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250401080938.32278-1-philmd@linaro.org>
 <20250401080938.32278-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250401080938.32278-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/1/25 01:09, Philippe Mathieu-Daudé wrote:
> We'll moveCPUClass::mmu_index() toTCGCPUOps::mmu_index().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h  | 3 +++
>   include/exec/cpu-mmu-index.h | 5 ++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

