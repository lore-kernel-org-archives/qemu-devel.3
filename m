Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA97D18157
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 23:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0UGS-0008Fi-3h; Mon, 14 Oct 2024 19:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0UGQ-0008CG-3d
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 19:14:10 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0UGO-0005wA-Ch
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 19:14:09 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c9978a221so41060305ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 16:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728947647; x=1729552447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pXQBuAZKywzfUs36+koDCPX/MRuY55CmVQA/lOZEgyA=;
 b=bgQWuWTzX4JG52LFANWOZMMKJSDwQudvAMh20VN0Zkjbq+KuVx4fFiDuPJ9663PFhu
 DIZBfssbsRW/fxWmWYnIBSAYAaNNjDGO4gxeO0y1xQCPIx6WnpamEr4kxSeoH/RswlG2
 NKaBAXld2pV7QdkkXHJz8rlLd2MEnsJRvzX/1kUwVhy0cf3+XDui+Ye2ExPw7Y7xlLpR
 4dLtjXRfOQFcRBYDlCLMkTxFe+TN13zkn7X8yKw+9ldbJlCBGhsxwnxcsov0fKTtCcnK
 RMoVNEbeRudvr0w9ReEVFVh88AYz6IH/MZrZ0Xyl7IyZb94/bkVhmTZ/GW77p0eQioeo
 GSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728947647; x=1729552447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pXQBuAZKywzfUs36+koDCPX/MRuY55CmVQA/lOZEgyA=;
 b=GSQbtw72nD27dqk2DpGQ5UIg/ErXzOAbq7tfI3d8nGeJiBdDUqyMrpThDSrgluOdwL
 98wHfu0YLO3qtsMHSDKdmp70AzELTywJoCWhKCBSDK66imfFXg4talHRYEnoOGNHllRo
 pbQ3bnQOmUF3UFZlZ3r3/tYFwTHdgVRI/zp/di0Pj9BXziI+HRts5e5cAeiYOP6Fzr1W
 KGb3dszzBTfhOOPIQLUQA53NDyXYOY1eUCqclUpixNV5NS+ZwpQ4nnj7zCounGgf9v8f
 wCcbZNnU7K7cOWhLB2OCTR9lCuVRPvOodw2iaIWxLluRC7U/g7aicaUGz29on9lLGAdY
 vWzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMucgf6dDyNXVQmiPEv+c3Y3LyCulj/iIgzdRLlCExjtl5nuiesUeoVycnFv0OAtaJiGHnVpMn+QeO@nongnu.org
X-Gm-Message-State: AOJu0YwWHzv4wbgaS8aEIuisgfkBU2u8DpCvpGCt6WtACFbdqJRnTzw7
 +wwz7B/KX8ftQDBfqCVjS1gMscOmnZNBVolBwaAhwT5HDyw/KJRQ/HzLS2Teav2Jz5kEUmojO24
 /
X-Google-Smtp-Source: AGHT+IGfRHTYpaH9ieSleo+Bsh3RuZodVnJrmNsKEyQt6bb7XOcYhDIwW/FIxrXYam1IJnNk/tSnog==
X-Received: by 2002:a17:902:e806:b0:207:6ef:d983 with SMTP id
 d9443c01a7336-20ca16c8db8mr153660145ad.39.1728947646830; 
 Mon, 14 Oct 2024 16:14:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b729sm574745ad.215.2024.10.14.16.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 16:14:06 -0700 (PDT)
Message-ID: <61be3ab4-be7e-4a25-842b-3ca1f391a1d0@linaro.org>
Date: Mon, 14 Oct 2024 16:14:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: fix qemu_plugin_reset
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org
References: <20241014223353.900481-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241014223353.900481-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 10/14/24 15:33, Pierrick Bouvier wrote:
> 34e5e1 refactored the plugin context initialization. After this change,
> tcg_ctx->plugin_insn is not reset inconditionnally anymore, but only if
> one plugin at least is active.
> 
> When uninstalling the last plugin active, we stopped reinitializing
> tcg_ctx->plugin_insn, which leads to memory callbacks being emitted.
> This results in an error as they don't appear in a plugin op sequence as
> expected.
> 
> The correct fix is to make sure we reset plugin translation variables
> after current block translation ends. This way, we can catch any
> potential misuse of those after a given block, in more than fixing the
> current bug.
> 
> Fixes:https://gitlab.com/qemu-project/qemu/-/issues/2570
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

