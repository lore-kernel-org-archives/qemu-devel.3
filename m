Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0182CC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEn5A-0002QX-0p; Tue, 13 May 2025 06:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEn57-0002Pl-RL
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:41:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEn51-0002j1-IT
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:41:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a108684f90so3321984f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747132905; x=1747737705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FZfg5AI2wrxSnX+jqnGfkFMNeBi5XS88rO/72M9QLbw=;
 b=efX2m0Hi/SLAiiO3HitRSLll5COfZoj2Jq3PN3X8wKeSyFbIhuEHtS/BCxOeCawPF4
 jqJrLHBdgHLk++A3C3LE4L/Du1wLEb7+/gWkdJv33TJnLtegOLRzh+YFTmyME5ywHeCX
 hODpXlpEt9+Qdmy9+ceTYicDF92J9QksXuYNR/Wb//a/8DJEC6eCLNCdDP23BIs+sPna
 uAx0Bh0TvbicFna2thD6xvSxxO0h736cOyojH8koJ/Q2elI39ppd6lehlnnYBNYYWDaV
 dQ5ijptJonEaIOSDsMBtVzrRIfjr3+SLoPHwCdi8aKG3f8N3sOl1km029MMCv7cP4fAC
 H0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747132905; x=1747737705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FZfg5AI2wrxSnX+jqnGfkFMNeBi5XS88rO/72M9QLbw=;
 b=nbAOLzpRvWk8frp8ew07+TCZOSeMUVx7foNrdQ9foJatxNzakibwkzPTtUQUyEl7rJ
 8FdAMQIhyR6VLPw7fBNzL2YgLZMAQfN6Dc+U420dymiUWmf1aJ/DIx5CG/7ffCQCMIHt
 cjfavPdOtXks3OGYb1R7IU0XxJ2DSqB3m6K7bTKjGJxthfbn40hfgrvr4AAwwTBUWs+5
 13aULBl9NZaoh2F16bFNoAlq/blV81MGYZqBkkDsqoj49zBJPYKZmMgblEvkcf8FeRgY
 LBl6QRUYw9qvLJy6Dd01tWsWTzg90LDdEYLMJqjtBGNiIPRu71FhYLlqMdhok03p60M6
 FwMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD6wZBvB1faQrRV2zXayrRt074ld0ONvnCfD/6coU/gsCfoUpSnhVoggAjKJPLQysK5AnfHzUg96Kr@nongnu.org
X-Gm-Message-State: AOJu0Yy+60W2YRqLJvyrKCN0SR1bb+F0w2V/XPZYZxYfqMC0MTSZAOjF
 ESvJh9KWOFe266WF1tn3rp5ybdtAZEGfCnaZNlIFoxkUz1avhX2MPrbK0DtWpfg=
X-Gm-Gg: ASbGncu7QtjFG3Vl2z1DOPiN1r5B2dqIZ414f78wy8HSwxXOUsLNegzi9ggaw9juhDJ
 SrMUkm16vEmYPWMKiCtfYnsj3Px9g/xiHNBwN18sbZEbubs/xQn6wiIzbL0BUx8ARrtiX7JoqzP
 oFO0Ac6UJW/RcyDCCodTiK5RDrTlxsyI31q9OkIn4GyZE7almW/MC9yGqOkgK/zdbKtlA2z8UnB
 CKm92jXH1x25+MMEjrAyY8MgvYh9rWq+yLXPTuvLKL5Ifd/LYIIk4wDp3vP8Dh/Mc3aiOcrFmoY
 Jzs1gvlH08CJZf742N2Eaz+ZIY6QgFElJamZFC69639j6f1UhXxm1203pSUkqTK/floxJEtiWAA
 9IPhmYg0eDcB3LdJTQCrqRJoIveeo
X-Google-Smtp-Source: AGHT+IHtjDxcFamTEzcXxzi/hHZllWxOf6YDpL1W23amCk7IKRTeNkY7wBHcB/icbLzMl2A/GC0boA==
X-Received: by 2002:a5d:64ce:0:b0:3a0:b8b0:441a with SMTP id
 ffacd0b85a97d-3a1f643ba6bmr12118934f8f.25.1747132905377; 
 Tue, 13 May 2025 03:41:45 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2ca31sm15841490f8f.65.2025.05.13.03.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:41:44 -0700 (PDT)
Message-ID: <91cd9b9a-8c67-47d3-8b19-ebaf0b4fab5d@linaro.org>
Date: Tue, 13 May 2025 11:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 30/48] target/arm/ptw: replace TARGET_AARCH64 by
 CONFIG_ATOMIC64 from arm_casq_ptw
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-31-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-31-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
> This function needs 64 bit compare exchange, so we hide implementation
> for hosts not supporting it (some 32 bit target, which don't run 64 bit
> guests anyway).
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/ptw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 68ec3f5e755..44170d831cc 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -737,7 +737,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>                                uint64_t new_val, S1Translate *ptw,
>                                ARMMMUFaultInfo *fi)
>   {
> -#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
> +#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
>       uint64_t cur_val;
>       void *host = ptw->out_host;
>   

I'd feel safer squashing:

-- >8 --
@@ -743,2 +743,5 @@ static uint64_t arm_casq_ptw(CPUARMState *env, 
uint64_t old_val,

+    /* AArch32 does not have FEAT_HADFS */
+    assert(cpu_isar_feature(aa64_hafs, env_archcpu(env)));
+
      if (unlikely(!host)) {
@@ -854,3 +857,3 @@ static uint64_t arm_casq_ptw(CPUARMState *env, 
uint64_t old_val,
  #else
-    /* AArch32 does not have FEAT_HADFS; non-TCG guests only use 
debug-mode. */
+    /* non-TCG guests only use debug-mode. */
      g_assert_not_reached();
---

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


