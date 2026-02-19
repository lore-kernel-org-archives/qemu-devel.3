Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2ECC531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBAk-0001eE-JY; Thu, 19 Feb 2026 16:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBAj-0001bk-3u
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:02:53 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBAh-0002Xg-M7
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:02:52 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2aaed195901so6801855ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771534970; x=1772139770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4HiPS4mXdhcS58AryKMyjRnI9yZcRoYUd3hZzH/iLSY=;
 b=S2Gt5tM6tUHloj1XfyTA/WLcV6n0qE9JHucS29SuR91ItBNZprXr7cIgOi3AvFU1ln
 MEl1g5oSSxJTWUYFx5ooPfivWdcpX3JCmO+mRj1pU1Z8zcS9gi+cK//rVAhlpnR2bcKG
 IMLXvOjwoMMGcLZXftDRvLtEJKBnc4jUgTYL/sNQBt5bqTOX6MS+AqdPPAtJ0eCleYwU
 DEX1FPVkGoQOZqNAzmTpbbnX/fiocCMTCXgjKBKwt2DbP5kri2d9TH0QQavnFY0lDrbs
 EoDJG4ig9ZCmEgl4NDlGIefMdgmfbKua48CbtOjxNWXnOdrexrHd3OtrBuXCoT9vIYQk
 xSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771534970; x=1772139770;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4HiPS4mXdhcS58AryKMyjRnI9yZcRoYUd3hZzH/iLSY=;
 b=b5D9L5p+a7L5eJyrc+CM+DkShC6yCgFPDMNzyZNbcsG1kevk6VY1dVCasj5IGR2f0q
 sMktVSlzCMrO+SHjftGPcm1MD1OiSrcHfAsZPwIEG3fB1NnNEXdHj/XVziqWOw73zY8u
 Cp0Hyy4WssJiC8wwrZQmw4k8b6Rn3WdDd7pkO4lOjpGhqQaYBGNjPCWw6+o9WS6JJiuX
 PPrW7UkzLxBXQUH7g6pHmeSTNFn9CVxe2ZtpLOl0RPGrHqofsiHljjsOYzM4Xe8A5ET7
 9nxSggqoxB2PAuBP6yKxc5ZfgH8zEv2IbZnjI/8rZRB5Kr2CMynSqF3Ycsm1Z7ynO6LG
 ku1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHV01geyw79SICDTxwRuizP2KSpdmmEcao5IfoshseGQwc1Da11CiXjZsz/IpTd2SHvIaQC5ZIYFeE@nongnu.org
X-Gm-Message-State: AOJu0YylVxAmJO9eH+yWhNrH/kltNtXXza5lpED87Q+xSdbPsnblXRsS
 fQ5VIfHMXpye1TgnGGg+Uywqs5tZx37emlFXeYMp7iWBNHVrWX/xMvVGjxbkuRBlZCA=
X-Gm-Gg: AZuq6aLhtdSIMxzIcux6Nx8K1nZ9PQnzAzvYIi22+fSmcEkJmXUiC6lu470DjPqRLFY
 T9zHGZZ/5Qgfa9Ai4YY5GaDScxiXa5NjB8VL8CEMzboKUKQp9liNUJ2Bxdr9RHG+iOtya1hzu5g
 vgNnhcTP+sNMyzx27LvLRCKvbLGtrU34kG7t/bF0Mg6h7RSNI74jKGWNmayTBSAcowdZENG+yYy
 3r/gldGQirKW7B47YcCs89nZMxP6a6MEt34mILN2ddUWjidhw1S7PIAdZMgBl6yfBl78PZd7XVe
 XxN3DDaB9BQKZQ0qz21Dc24MGz47ABljg+qT+M0lbaGdBfjaU/TsLc1zURcgxrfvxFlVWGy9dmj
 w5kDeVQbrh24C6qN4WPkS5DMlSr8nwP69sNpUb4FyWPCurs3+NtLtCUVKwtHbbKIVK9ttLsSJ7O
 fWuTccY5ZaWmJIDimPsSvXlNCgnHnalwUNMbZXCLQh+wuXYqdQM3ug4ofFZxpWzfI4P8Xk
X-Received: by 2002:a17:902:e852:b0:2ab:230d:2db4 with SMTP id
 d9443c01a7336-2ab50521f3emr217876585ad.12.1771534970279; 
 Thu, 19 Feb 2026 13:02:50 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad416ee045sm90992515ad.90.2026.02.19.13.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:02:49 -0800 (PST)
Message-ID: <c5a64297-8807-494a-baa0-da4ccc8eaffb@linaro.org>
Date: Thu, 19 Feb 2026 13:02:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/50] target/i386: Inline GDB_FORCE_64 definition
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Directly checking TARGET_LONG_BITS allows to remove GDB_FORCE_64.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/gdbstub.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

