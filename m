Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C302C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxC0T-000480-JF; Thu, 20 Aug 2026 19:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxC0S-00042Y-9H
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:17:08 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxC0P-0007ai-H0
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:17:08 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2d032846c95so5068105ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787267824; x=1787872624; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K4PttROwzfD65LdoSoGFqNE1dKR3I+aL1/VrUtik2/o=;
 b=MEKPQ7mSUnKWMoiedBof3HiyoSQKrMCuNMxU2LHTBRskUWXlgMrlmfQDC9dt+7LhtE
 W/iYz9Ty3bdkXnlZDMXEv9nr9oD8wAIAMgvrD51b8zGs+lgzqTZksWPK1C+/afxPWl9m
 uJCCZDXEzSG7btocu7GBCm0paD4XCpBPorqQCKrmkfgwxRfffQ+rCDHyEbabY3CA7cil
 aldDSW7w4fW1f0+K5TqTciNiqLqKHukgM+vLCsQjLOuaLhDPJ3793DPKTv0+uDuDhAGB
 3TP1M+I+tXPH683VB002vJdBXDdhzPuzJKTtH2sCcwsbDInEibEdx0G9OYfXPiFOiQPt
 Xcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787267824; x=1787872624;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K4PttROwzfD65LdoSoGFqNE1dKR3I+aL1/VrUtik2/o=;
 b=lSC8Z0IND8s9025CYTIVJPMCHLm02EsW4gTLmRy8FvIu7r2OaeUWorIaPHbGC3CoTq
 gsM76KsMFmGO5D7dbphj5S1o8YXRMilbQ5fy3R6AnH/5CPYX28soVjf3AabGcVcSj5v6
 stectpyuBrEigKVR7uKRi27CGigc7uuzXFyHg7ICHLZZ2O3rNz7IcipPSI06++5i33xN
 5ico5rhETw1+YRIlyBzOiPdTNDYHmoyrfSF2ybn7gkVLxD9O7dlOKHS25gAvt6DfpBPO
 7/RDyaYxnS/NdVYS+DOs4fw9cNyARCLIMnduYpEoDzp1bLhQj2l0BR2t1GpegNwgtqY8
 DE+w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3Hbh4RwmnclJpTiU+R5NzRubGfTMGZ9Tv1qk2LxGAm2VnouEP0ZzhgeVaVHGf+uCEheE9s9XUKH6h@nongnu.org
X-Gm-Message-State: AFuF++ng0XNyT+RJzORYJ2eOKxyyMkn30avzJmqh5yvFTkdhhUUOL4OR
 yZDsNtFdrwQv56I/Bo+WRga9uRIZ5ba7HYZt0YrAyY2KHH/YjZAhGN5Mo1cM/7HrXiY=
X-Gm-Gg: AR+sD10zpCXDjVtEEviImLzXLkR2aA6WsKQOWPhwroiWJfzAD8PIHbWsj3wsqWPyuEJ
 QLvWx9YnitbVSUfYUrsE3xmfhgfrE9BpWNnHxIDuzIAIOCvZWPJpE7wGZGlxG2yK2eCoFJEFDBj
 9sZ6LhJtk8GZP2UxmBJIPFXaKlkLxsAYSC6xMC2VUU2mzrd8v8xYPiYjkOGzI8Hevt5MfZDprWB
 cfS+IXf3fWfuiHFFp22IVor0f78s3+YOd1MS2lOHMCliQlNUkxju/H30Tr2Th7CS7pH3vpJlu4i
 5kknjlXeCBWOKF+PM9Hby/P/o60xTuEX0bVV79Mz4EHp3znWKOdscKzzqRoZCEIIBaB/8iXvx/T
 ZVTRRa4u8SG8D9kXKlvydKH8ldLWRLjl9Tla8PZMnKhII2H3VVWcJOhz5muP0I67UtMDuVuco7D
 CWZFubwv/ftNcmwreObWF/ETwk/uQy7eTf/jGWiUe2lKJ06gti5ylzRQ7HhR54thXQnzNJkF+HN
 9Vc
X-Received: by 2002:a17:902:e784:b0:2cf:ba10:6d6 with SMTP id
 d9443c01a7336-2d64af6f8dbmr43305195ad.4.1787267823862; 
 Thu, 20 Aug 2026 16:17:03 -0700 (PDT)
Received: from [172.20.6.151] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62e3d2f09sm12434385ad.78.2026.08.20.16.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 16:17:03 -0700 (PDT)
Message-ID: <25229622-88a8-4a54-9a45-45cc53aaa78d@linaro.org>
Date: Thu, 20 Aug 2026 16:17:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] cpus: Add const-qualified CPU environment
 accessors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260820201356.29775-1-philmd@oss.qualcomm.com>
 <20260820201356.29775-14-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260820201356.29775-14-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/20/26 13:13, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé<philmd@linaro.org>
> 
> Use _Generic() controlling-expression to add the const-qualified
> variants of cpu_env(), env_cpu() and env_archcpu(). This allows to
> safely access CPU architecture state when it should not be modified.
> 
> Alias env_cpu_const() which is still used.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> ---
>   include/exec/cpu-common.h | 30 +++++++++++-------------------
>   include/hw/core/cpu.h     | 17 ++++++++++++-----
>   2 files changed, 23 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

