Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724FBC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thZFf-0005sV-MX; Mon, 10 Feb 2025 14:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZFX-0005lA-V5
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:15:24 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZFW-0005NM-1k
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:15:19 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21f3e2b4eceso89021665ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 11:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739214916; x=1739819716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2rINqM6AWA1dSx3iarDXYQiAdk8+zyqk2pdjc1SbpNI=;
 b=YziykjuRi/x/RvmR+gboNBzI6oKM+1oVAWENO+uFNgVnCk4jymPCJQRiL3UZbwoYIH
 KqmLI+OatQIlYn9g3b0bsX5lLh2ua7ggb90JxrBwyKt4qKqHsq6jC4lJ3RfRbaqoe07g
 zqtDXBmIL42Edb25GBpK8rt2pJsBdA5iazU72RICfRKvDUvOvO93V3Bz5341xYPqa9ng
 cLEIDqTJWkIq4l3KyO02kRxLBFUKoCDNicVYrgjRL9EvmmxkjjPo3E06nD0iTq2toCK3
 x+BTas76u4nkW44JeqRzt0+aUrCt91t1AVHbUmpsgAlxjZOl+G6l+bZfYG28B7VeCG/t
 q+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739214916; x=1739819716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2rINqM6AWA1dSx3iarDXYQiAdk8+zyqk2pdjc1SbpNI=;
 b=EUeUyaz/gb8OrLy76kbWN2f3MaCsdD5Dpvmy1zU5ruxIuFNN8hUrTE0OOj5nC05QZ2
 IAIessW9jQ6D5rqlnn5iKOyI/7ApEjD3atCVdPicKTKSLOiFT6z6eV9hwJL64VLo2Qt+
 tmYyGXyXeSl6dz298Bm0LzF/7EJGRPIKe+85oPPOIKRdeK/czCgZwsCRFX7EmOYXAw4d
 mBn+etjD8+PZ5oOURgybqE6TLLTHzFvDgg2CZ+BnwRmJ6V+BleYpR0eJgMfkJ6jiC1c2
 GZ4onGAibtRQLTnweBwXGmAd0VY7UELPw+ZanMHVpJps3n6ilXwdDt0sde2OCJK/q4a4
 +Chw==
X-Gm-Message-State: AOJu0Yx8hgb6Y+10rXHYVSD73gO2OENb1onxAEmcvuJZqIfC9rNsCBBH
 6RJjQvP26+4QaaMOu6j/vTWx2JSBKuV24Bw0gwCtIUVWPGrIAq2spqcjkIizsY6iNID0liek6pz
 S
X-Gm-Gg: ASbGncvMjmf3TpBRBjHIkFvfYKUZUuDfYsjYdownwJqcRtDaJYOg59KOEl9Aie7sr7b
 DPVsKhL//llvz19SP3fsUdFw3AlXQUihzUY92EQESV3lWlOtYD4SIWq9kuSb3uD9F7ekO5/bulV
 5tUhMkTiEgabJeRSrqkRYsZAFyNhfF8LnRuRhL2n7I9At7DeV0aRVEPVafk8pG5g3OfHWiY5R5A
 +L7X5LIKPRDe7fOnG99rCtNvACfkNwo9HpNv/8vAIN4gitcsI0nhu67nF5rCgnRk58UjGfC4xgU
 ywAg4ULzpqIUo5BdeQkzxSnn5rBSfg/tgzw9K1LgmMLmgRtes5Ff8Lc=
X-Google-Smtp-Source: AGHT+IFER1l1DpMTHxNQJsaHMMVGmaDP8nRdDVgupHlxHGSH6jnKNpFqWFxqlSMmjvc7OZjMaMDh6Q==
X-Received: by 2002:a17:902:ce08:b0:216:61d2:46b6 with SMTP id
 d9443c01a7336-21f4e6e5ecdmr236933815ad.25.1739214916417; 
 Mon, 10 Feb 2025 11:15:16 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3650ceb5sm82839875ad.24.2025.02.10.11.15.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 11:15:15 -0800 (PST)
Message-ID: <e6a4ef79-2eb0-412c-9648-4cf0a83caaae@linaro.org>
Date: Mon, 10 Feb 2025 11:15:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] hw/intc/arm_gicv3_cpuif: Don't downgrade monitor
 traps for AArch32 EL3
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/30/25 10:23, Peter Maydell wrote:
> In the gicv3_{irq,fiq,irqfiq}_access() functions, there is a check
> which downgrades a CP_ACCESS_TRAP_EL3 to CP_ACCESS_TRAP if EL3 is not
> AArch64.  This has been there since the GIC was first implemented,
> but it isn't right: if we are trapping because of SCR.IRQ or SCR.FIQ
> then we definitely want to be going to EL3 (doing
> AArch32.TakeMonitorTrapException() in pseudocode terms).  We might
> want to not take a trap at all, but we don't ever want to go to the
> default target EL, because that would mean, for instance, taking a
> trap to Hyp mode if the trapped access was made from Hyp mode.
> 
> (This might have been an attempt to work around our failure to
> properly implement Monitor Traps.)
> 
> Remove the bogus check.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 359fbe65e01e ("hw/intc/arm_gicv3: Implement GICv3 CPU interface registers")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv3_cpuif.c | 9 ---------
>   1 file changed, 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

