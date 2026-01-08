Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57844D1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdx69-0006uD-SI; Thu, 08 Jan 2026 15:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx68-0006sY-Gu
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:59:12 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx67-0003Da-0y
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:59:12 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-29efd139227so27613075ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767905950; x=1768510750; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JTIlBmaVKPS0EfpswPF3Rk/IiQZrJmq9OQ/l5TWn3tk=;
 b=Bwl7WT01qswPggW1L27gnOHmguvJOsA/Lpspu5XmA6froUAXxa0PAEKxyfDPKbnQ/D
 NtpLMGffSoYm0gY/EQauOYOuppWzIQUIUCbQU+kDVL/mrwR1ZRDMA6mCRk41LMWROrbS
 GSZ3IM+2AnA92b8OlApDOwkq3VaNiiTseLAWVEUHYVuBvPUSUwfJ2/XjLQPe7M6U60Q9
 ad8o5wXmfrGJbrGIc6SIubvFdvrWZb6Evq+AXccDh2IrYuvEVuW9+1WhwAUdvIyn6D/c
 QjDyf16MlM7jmiUF0FZQCb76ErFHprCSZKlyUTJBWao9MMqtXuiJ6ZXbeh+tuAGCQDtL
 bVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767905950; x=1768510750;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JTIlBmaVKPS0EfpswPF3Rk/IiQZrJmq9OQ/l5TWn3tk=;
 b=nFKC2kvvd/0TfJvoEAts5JoAi+YTDHDDJlVsHp0sv53zCESRR9w/hDE/ARti2XvMc7
 Rq1HN9uUQ5oq1O/ST3STC73CTcfs/CbFb/A5ZGUaGVlNFrHTykGotdoyNc8hsr5JcJxC
 Gd2YgmwnO0G45c6i0KFZ5xHssjEPf9DAG9PFvFCCSQAfAFGICQf2rc0yhG5Klx7BeySD
 0o9C7NMG9cft+3M02ga9d02TuseO4e08MEgdrFPR1fIE7wxcmgU2UQEYvl4poyIFxLWE
 6MnBcFSWMtMBqmbPuvMyEn4n5h4tcUazoJ3NA8l5fC3k49+jJeNFgR4SIt4Hy1JcAoAx
 3LVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrIdjgCSwPGGSd020zrMDpMh7VKX2BDsc9baYk+YBp5Dge8f9VcO3h6LDxW3aX86z3Z6XH/4sJvMqZ@nongnu.org
X-Gm-Message-State: AOJu0YwwR9YjEPE0uPbvP3w3DBu2Zb2ZeI00TYWwu+ugNzngG55JWMEU
 0Uvqg1XgH4Fx9aTiJv79ZnLlKHVDxNWoufR4DjGkm8lMEKHyVUUEyUpaYs6v7fiDw1c=
X-Gm-Gg: AY/fxX6JcO6X42MNWoCnCWQnOvz0KKlaTIqgtKCBB9IixCYl5WVhg2TgvkVtqkjqOyZ
 8t2EDtZE4LXZ4+AHDNQgxUPEzQN2qqueD+3aX7NYcUANqPnS566v9P7Sj3zlAL0uvoDLjxumIhM
 7cECln1Mup6wocBXQ82oBlGmrXs3F7iq0tt4NMHGmqLG5jsWaFyeGodYQQJd9ToTTYWv0NcP4Ez
 1I9CZ1bBhIZm1S++5+DVU/Ucs1RzoO+uMi1Kp4Pnr3WF3iO401ms3BoOwqcNacWtmyxA9eWpAOy
 vV6JV4YbY/uHCJM8Ue7bLeAiuubWPOVfrZQvzovDLfvSajlGZyWah95hokmZiHL5ZRlo+pwQHI9
 yszYC1Gb1+mW9M0Nzy5wIMkDWD4ESxzOnk8DHnd65SsQ7xYxGrbS1xRfniQ704iCk8GF/dmrWu2
 QFbVTzIcJxkhxIwXaT3icsJBAnsmvcAEaQ1HyilypG7HPEAcFeKEUeoVim
X-Google-Smtp-Source: AGHT+IF9kR/3zL5DV3bDXCjfWn1rc6Q0zX3ocVgEBAb1zR7doiyT10Rix1MOLlq7whCmM6BAgZkwlA==
X-Received: by 2002:a17:902:cec3:b0:2a0:7f60:9786 with SMTP id
 d9443c01a7336-2a3ee45b745mr72560715ad.26.1767905949514; 
 Thu, 08 Jan 2026 12:59:09 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c48d77sm85563355ad.41.2026.01.08.12.59.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:59:09 -0800 (PST)
Message-ID: <2d7affb5-7540-4c78-8734-ebcffe37335a@linaro.org>
Date: Thu, 8 Jan 2026 12:59:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/50] tcg: Drop TCG_TARGET_REG_BITS tests in tcg.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-29-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 216 +++++++++---------------------------------------------
>   1 file changed, 36 insertions(+), 180 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

