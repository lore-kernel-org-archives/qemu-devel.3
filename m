Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FDAC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 14:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEU4Z-0001vS-4w; Mon, 12 May 2025 10:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEU4Q-0001u8-KW
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:23:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEU4O-0006TP-SS
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:23:54 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a20257c815so1739588f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747059830; x=1747664630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mnm0wN8xrZwjJuPO6RBiswdxwHZWJnZCFCbrqWMXjdI=;
 b=SXbQG22mRugyR/FbSH+GeQDBJ39b8+EqzyobLdQWhgrsQkUceHrxM5tghk7Tn6TBMG
 WfIWNFkcCZRKbcugBkXpYCFxKn3p9pxQUGEfv/I4SNQjWLlYF3Aaw0H7xDTFdymI6I4N
 Im1dzicYsLQUsVNe7k0RiS281DDTF2Qn88Rl8ae8h5z3AKWBwef3aZTAg3xOU0yaryyh
 9BhBSRzaI7v5bnbhEsL7O4iH2GnsGe7XUaF8ExpWZjaRsz9FoDToaE0pju6mOXzMWhu6
 d0Cm2azfQwk7LMuTcECKLdTLJkaUO3zNw9KyuboKoUII/+ZbVkGuo7R64kRMHKPAFqWi
 JuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747059830; x=1747664630;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mnm0wN8xrZwjJuPO6RBiswdxwHZWJnZCFCbrqWMXjdI=;
 b=QemH9R+jkPRczLQW6PJ6tIdIyt6sTYEFjz0tjgA5PnMBpPkrvsTwYrl4uzscFgtLcv
 NfUsF6OCf3gaLTIkhPqPGxlJSS2Trc6iuyRhBrA1sT7eoqeTAuOqvHeJSb/OPRZvCsZo
 1zex84qztUelHilu3y80baYSf25Nz5Vpwi1jgY0hS+/PqGIZy6JN7kc5Mpswpt8L+VGP
 x3ov4w1CBAg4XLrhZOifm8IqKY9+iZAlBoiFVtS1wMgTRVX2jf7Mizd4ZBhcCfVOZP+S
 k1jh1FSvgXWbJoZBJ+fo+CAZ4kaGDLT8Phz0unwK9+vQlGlbYPU69L40KOkKdtwhZ1DB
 USkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnyXhAFLBJfikZsAAp8AjSasx5D45/03geYzwsowiZLCGtHq5JNzUC0jr60X3p0WVo+ryfyHeXmg7s@nongnu.org
X-Gm-Message-State: AOJu0YwD97jWC0M3wTswhMkOLBkIF0kDerLcRWku6XFvz45k1ORYs3ki
 FYV3XtU/DCpqxsUJUwrcHIzVAWwMIWJHUoEKD/wEMAxeGRwn2xPR2l+DL3/YjOQ=
X-Gm-Gg: ASbGnctD1+Od6ZnrkqDF5s7rmxD4aFqFRWfmQLfBd6NVvJyrcS0xEoHeom3sDU0ViQg
 MSg5ZSPrIvifHtrkxXIerWaAEOkx82K4hnYn4T5olkztecvDqzM6yz8XlaSq/+JRBh/MlMIljJJ
 dAff1cb0zMh34x9bCXXeQR/qT3z2Z7wWZzKvRnbjH/EJdD5mndX6q9B+l3sMVmPP/oig6N2d9Gn
 TknZglkG4QmZjJxOONDGK/BGRagAiasaLpGmU5oJct6UXGF8ghnzu0YQ+UfI/pBZOI3cJciThcX
 IcRSIZVT9zRyh2jvu7jo/4dSk5e8Q56kzaTZTIh4eUfZCm5whcR5ZdLIqF5rOKy9YNOYXZHZsfQ
 v8aYV3fvkXQTVLTBDVLwjswOZC2Pi
X-Google-Smtp-Source: AGHT+IEEFuCKwJXVAmg6+SzLiL6bJto0wLM8OgMOsJCQIzKw6re5dz1lV36aKI+saYxoHpzW6I4Z+Q==
X-Received: by 2002:a5d:64ec:0:b0:3a0:b8b0:43ff with SMTP id
 ffacd0b85a97d-3a1f64577bfmr11419296f8f.14.1747059830628; 
 Mon, 12 May 2025 07:23:50 -0700 (PDT)
Received: from [172.19.170.213] (90.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2ab2sm12424024f8f.46.2025.05.12.07.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 07:23:50 -0700 (PDT)
Message-ID: <f9ec4839-abbe-4bba-bf40-42126e95fc70@linaro.org>
Date: Mon, 12 May 2025 16:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/24] target/m68k: Use OS_UNSIZED in LEA, PEA, JMP
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org
References: <20250511203546.139788-1-richard.henderson@linaro.org>
 <20250511203546.139788-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250511203546.139788-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 11/5/25 22:35, Richard Henderson wrote:
> For LEA and PEA, while the manual says "size = (long)", it also says
> that the pre-decrement and post-increment addressing modes are illegal.
> For JMP, the manual says "unsized".  OS_UNSIZED is the way to signal
> gen_lea_mode to reject those addressing modes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


