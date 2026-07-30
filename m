Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD65C55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpTcd-00043X-9x; Thu, 30 Jul 2026 12:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpTcc-00042x-LB
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:28:38 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpTcb-0005qu-7Z
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:28:38 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8484f229529so68407b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785428916; x=1786033716; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=37f0z4Tx4jHk8AtPKjFzCyCh6qsA3QXUrBmMPfUpMsM=;
 b=vUopMZ1I4Cd/tNoR1UsMWwSD1z1l71h5RduRvZ2Y+l0FI66aLDTI46vpvEUzYnWBxY
 RgQnmMStlohYspbyzQ/ZbLh9U6Kv1E5oClHhMVkYLLtWcwmjr/BEJgjsbD/xlP4ZVRp2
 xAYAQKvZLYN8RFArexwtYUmPWaONa5W57R6LfrWPOmQdE66MpyEXl7j/Z7M3gk339za5
 VJ9ZhocxMI0Bu1n4u+8L3LKSjDCpKggnrcc/naxFywO8Pul+JS28pE93kJOq+6S8H5B5
 J2A98qBiXswuSW3fPPydlCDhqgsAcye+WN/HL9udmprAGhkgY3FR7I60N7xCXAYK8tmj
 Fq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785428916; x=1786033716;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=37f0z4Tx4jHk8AtPKjFzCyCh6qsA3QXUrBmMPfUpMsM=;
 b=MU+0GUq8apIHHfP5pvn3b9wNz6BwUqQzCAmYc2MsR+0w8LFc54a5I5Z9cm6To7q6D1
 vV3PKjml7AMB9ipSSWACLIRwfrKEnVTXzhUp2maFkcM/hr0tZLxDyipUbl2KSDTSjjc6
 vIMznTG3BxNxhZXRW9dz6an7aWYEsb0cHsz/5RY9wCMsW+WPqemZ4Uby/BCXQF0Q0IV/
 eKBRw4lSkJmZxvHYw1UsJ42mCZ7M4HQ510aJMxh4TkTyE8YXep4MBA1PvmdUE6s5ovk/
 +AmS9ngV7Jh7PLuFa27hpCSCC3SDyTC+4nqFHjbVCiZCPZolGozY3KD2zbnLJd4rbLtX
 uj5g==
X-Gm-Message-State: AOJu0YyBYNCV3KYg5A+yUsw345ZcGG08uHgXY+FEaRXgvjH1mS5cRfA3
 YwPHIkZbr5Cmwyd3xKTz5sRfn4YNDRsPmPeGJElDMi5BwakXC9ywoiLTNguU1PwAR9lkEEeHjgl
 Ce4N6
X-Gm-Gg: AR+sD109/BhYhfHb6uZUVQTztiI8tVKKg3tVh6nH5CkuS1uwQp/NHPT8nd9HYwJWaSI
 HX3wMCPqNjGKs9ofohDA/D5iBAn3/PLBgL/h4X2l5i+xQwh7X4+8gRIY2qkiET4PUSaIyxsuKes
 4AM0+LXiumsla0JVcj91cQt0yYEEgq8DxPF4MoZ3bLTy9s6z5LAqTAamiBXuhfBcMwIjSoK/mtu
 pzmUiSCJxMinXVqPjXIuYl6boCPlNrzwgX4fTFjy06OCaaKVrpekIBnq+5AfQpZ4g3wf5HtCI+N
 VsIhY94T1SoV280FJFCMHWFtQoAPJFhU7BMJ++JGLamhW0doxqKLS297/P54Cs31cPEyeDj+ArR
 RjctZYSbHCPsX5yEh1Cn0I/84qxTMRMIX798Oshmms1HMXLyUMGtmGKwFIJZKYaUJdtVlOUTOjz
 MkVrRUBbOI4X9eJUmd3VSF8OH4lfh1tVTh7KticNZ69pbfhkyTDijdod1cK1XFy2nqWro9vSvTO
 Ac7+XLKUSgQwOFaMPGbnZEW+vZJ
X-Received: by 2002:a05:6a00:1793:b0:84a:2ec8:fca6 with SMTP id
 d2e1a72fcca58-84ebc40b024mr3035840b3a.52.1785428915672; 
 Thu, 30 Jul 2026 09:28:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea02fc6afsm3324617b3a.36.2026.07.30.09.28.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 09:28:35 -0700 (PDT)
Message-ID: <d36fe6ba-5d53-4b45-ac19-c831a6480840@linaro.org>
Date: Thu, 30 Jul 2026 09:28:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 43/50] target/hexagon: Provide env to tcg global mapping
To: qemu-devel@nongnu.org
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-44-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260730031025.12926-44-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/29/26 20:10, Anton Johansson via qemu development wrote:
> +cpu_tcg_mapping tcg_global_mappings[] = {

static const

> +size_t tcg_global_mapping_count = ARRAY_SIZE(tcg_global_mappings);

Drop this and propagate the ARRAY_SIZE to

> +    init_cpu_tcg_mappings(tcg_global_mappings, tcg_global_mapping_count);

here.


r~

