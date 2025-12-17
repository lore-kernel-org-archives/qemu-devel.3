Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24CFD66B85
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 20:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVyC4-0007Ir-Np; Wed, 17 Dec 2025 15:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVyC1-0007IL-St
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:32:18 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVyBz-00075z-DN
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:32:17 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0bb2f093aso45005295ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 12:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766003532; x=1766608332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RDrfrGhe5yHDJZVhHTjPc1szatdXyIQTGYYhVv3SiVM=;
 b=PMQ+M55N+cmqVQqwpDfcYa1TpCteuLBJxH6Ca9TuiyGEowfyK+ZH9Qu2Cu5KSPSGeX
 NdmYhurV53+sdAjxWUvCo/bi3kENqa1qJc07/qZOFYiQpsGrtuqMu/NG1OzEeTucoBkn
 sfvM+rJU463fwvBbyRRe4mi/qx9PT8F2Xe3R0GFaXpfVQCzreJf0InU+yEueHamVB2Je
 9yw7vNfS2rXMEHk4F4pxVFx7Mal7f88ElTGXLobRSMvNqhBoYM9IY2UPKUb1g1sxacoS
 9WxpEuM4SN+7F1xz+o5OMBNeIDRUtxK0uUHzA2O3fOByov/d32bEtR/Aa5WPskSnUWZd
 JyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766003532; x=1766608332;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RDrfrGhe5yHDJZVhHTjPc1szatdXyIQTGYYhVv3SiVM=;
 b=JoRWDW9oBuAeIDq7c1lSZRm0N49tBBsmsvgLVn+22QB5WgC160kkTnskC8cvi1xHAV
 Jz3tB55TLnOqnaZTqx7wheDR/Zzxx2I0p1OTuqZd5d4maecBd/FrqJZuDQObxDSZxZgY
 Ft1xaolqjmuKkqwae1fRJuh98aEI5sZmBtX4xC8W0emCSQ7NdpxvRdKyaoU/SYsHQqgQ
 ulFToD3iBn7aSl5QaFwH7JHscmV5sNyNBuOestvcgeTeKi9nr+sG2Yw/ehgEhUUOaqg3
 iWZfttwhND+4uPzSBAUsJ5ATLm6Hdouwn3NOnGQixDlvY8NfLj3+VGJlSTHl0txG6Txv
 B6iA==
X-Gm-Message-State: AOJu0YwsPWH9utEcInkXAKq35z9OGGipFzpze9KMgFt70HzfFolE0GyZ
 qKfn7ghC5L4vHhFmIm2iXAh63sBvVvt+sgkct7oO5QLc9yiNkeQ/lJ1v0jHsbOa2SPM9HbMgg9C
 2QJhGCig=
X-Gm-Gg: AY/fxX4authaDnAsnMcNdadvdJpzo9om1QsDgCeS+SLB1oMvvqO1Wxckv5I3MK+gKSQ
 wa1/9reG2MfEPReul0SGT+jK57/meg5A1b30ikpEP4LPFuZDirNFceJ3bxR6JYigD2v6ilDNR2s
 l6iHQQjMGLPH8QQUr40Jmkwzo/WGXvd0R6R2ifEZ0PDkaSJBlnaIaj4t+P9Nz9D2k/xBDs4BVR+
 hcJfVR9h9hzc/UReg1mCEHcpHER7F5uO1W0SnOnQma/Es3AtU1fJjZOGp3DOk8YoHzVwpr5ADjj
 U8BYr3mwxSUGn0m/GSRq0TtzRIzT5f5iQrmAXtX25uR+EyqLg5PD5+7+P8T60lKRjN8lXD+HC/T
 T9xxOmrDTowtlwJ1pteiE6lYhAVCm25lm5YZgkye/47j+xbPdv1GuvS+d8citRkVcyBcsh1f7yN
 frXQKTnyJfqi2QxUKte2OCnC2uTDDL8g==
X-Google-Smtp-Source: AGHT+IFgW67nsPptXvmjW8xeUVVLcF+4tRMs2LatORBn1we95Zexz1deKoMi43ckYJYFXjDT2LpfJA==
X-Received: by 2002:a17:902:ef03:b0:295:8dbb:b3cd with SMTP id
 d9443c01a7336-29f23b7868amr183448805ad.27.1766003532164; 
 Wed, 17 Dec 2025 12:32:12 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d1612ab9sm1894545ad.53.2025.12.17.12.32.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 12:32:11 -0800 (PST)
Message-ID: <a8168c16-1f0e-4c92-a83e-f2c46c3c452d@linaro.org>
Date: Thu, 18 Dec 2025 07:32:07 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] system/memory: Sort methods in memory_ldst.c.inc
 file
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-15-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> For clarity, sort methods by access size (B, W, L, Q).
> Fix coding style. Only code movement, no logical change.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   system/memory_ldst.c.inc | 86 ++++++++++++++++++++++++----------------
>   1 file changed, 52 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

