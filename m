Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7A6C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURZf-00011c-1T; Wed, 25 Jun 2025 10:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURZb-0000pH-PI
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:58:04 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURZU-0006rp-Ty
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:57:58 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b1fd59851baso4675584a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863475; x=1751468275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UPx+B44USLtoqHDCI0oh2iPPsvalAXfesbSEx5D71Zo=;
 b=ailBqIh6iNMeA718gp/Z2ge9oy3hmfTvf0P2JW1G9Hp6eNryjiiZ1fXbAAf6aVMB2P
 j1jokUHaeiOVYD3IhFQTUTu5/2LIYNnOxZmylydUycKt/6/tPfWgkhoD88mRw/LUBbQO
 nkJ3sX3ztNvtZeYNx42I4Z5gPeQtcHX2lDtQBLrjndAYyVyC7vsagEFRGRaxfOvKyqs8
 jj6KsmPzEQNgmJnGqJfImjKW1hhGL+J43e6XORTXDPhr3FHNcUvroLsYlMwk0EIwZmpv
 6rWdrx4Op7z0jsHyBisb4zGK/tfos90tz7kQ+MGpnO493LNpllG0dVwFhX7mxvoR4oXE
 v/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863475; x=1751468275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UPx+B44USLtoqHDCI0oh2iPPsvalAXfesbSEx5D71Zo=;
 b=kfDvxyguw3ggBhMgUKwq1GuFZ5D7gyODazuqwGx9jQnQ3Ef56Vfq+grOHgqK/iWW9v
 UmizCW/kKmwbHW3kzNPo4NU3nYtbjdfvMcaMIFNiytXxbwxpVXzvmKA1ZeiVeF/P2R/x
 XF3pw8ZxlS8l5IUf0c+ZwB54e4AncLcVkv6ZFYxkx0oVP3g84EVTDJIr10EA1vVEIgr9
 eBizuZnlqrsDitekfZ2UiHHGaa9xScmXbZuGmJOXSKnLuENPjaSJ/atj51ysM2jv4zqo
 Br4Haj9HDfVmJjYwMOJIIQxUYW6xqnhoNUn2Z/zqXSUzMBQLIs8YZUpXDc2xEzj21bHf
 O/qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSHyi7NAqDk0f9kNn7+1AKDbTpuyq2Co0NSXIyiCeSBb1mE4sTHUcXDLNJdYkLoms0+MyldCKKNVxv@nongnu.org
X-Gm-Message-State: AOJu0YxLIGvN1kFWBAxyddh6RzuwXCt0U2YsP+EUdMQtMTfMzqlsBMUG
 EVWN5fsLTLEA6JDjllBM1lBypNVePzOGV7wqglvkv5VdsgsCy2s/iaKlLVJ9D/TYHd8=
X-Gm-Gg: ASbGncuXY/tBUp7A/I+OLU0a0iPx49ntf+3Nq7JnrYQYcJOjFTMiLZhcoOvtBqrdFEc
 yKHxo08WY8c6FgI3Lw4ccLQfpGJeNpAIcHwtvqqlL0L8Lji9RihQYtF6LVDneXbSfjIoP5FXYyj
 vfnj39DC8nhnpPZKYeyJyxkMWeZRbaev43cRT3t01laWXM2TaKp7XRGQJB+ajTZRsZZMqGvMExA
 qZSJzxYf49g7seUmEkSwP+3HEeOE7k/IDWmfp4SoR4hKhcehrSFnQmefy7x6e9GCRb2qvxf4jcP
 +zaXZE9vum1YgWBMiHbKD+G5h0jhwGvqldkBEb5NJTpu8FyeZLNDei8NjRn04ogVE41ShoZ9q3E
 =
X-Google-Smtp-Source: AGHT+IGwQtbR2Y8R42ozZ3Okv/wfMrwfMyu/WfQxS15Ywd4dAu7SMi7Uhe7ouhVfcpQjR1wylMGJmg==
X-Received: by 2002:a05:6a21:1086:b0:1f5:8e94:2e83 with SMTP id
 adf61e73a8af0-2207f192067mr5948738637.8.1750863475483; 
 Wed, 25 Jun 2025 07:57:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c88387bbsm4871029b3a.107.2025.06.25.07.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:57:54 -0700 (PDT)
Message-ID: <dd1b1d20-5fc6-48ea-ab62-94a4fb7fe303@linaro.org>
Date: Wed, 25 Jun 2025 07:57:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/27] tcg/optimize: Simplify fold_eqv constant checks
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-28-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

On 6/3/25 1:09 AM, Richard Henderson wrote:
> Both cases are handled by fold_xor after conversion.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


