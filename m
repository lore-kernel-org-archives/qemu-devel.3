Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C734C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLPG-00069o-4H; Sat, 02 Aug 2025 19:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOg-0003vi-Kw
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:16 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOf-0001rF-7v
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:14 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-610cbca60cdso1074507eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176332; x=1754781132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WlpguNAy1db+19GMtuU2rYn1N1mDvWtUCnEpEfy+tBw=;
 b=flq7j0l2qA1zanuPfZVbaNuEUgjMB2ebcVNJnuGXh0tPreoV2wn+SAJScmxFMcdO+B
 skSEhIhHeOHk4aF26NKQbZvWH6jlcdk7WyPCLVKVkwrxGG0Kbf5/GHN0FnvGCmyQWW6k
 JeI2732gt7X7u+/JmzVGNm+3zR+G+UqLE+5ENpVfqil+SLIUpDnsRb75b9n/aPtNLNU2
 zUZwFUMTVk2VxPEQQdgFwIpjDATH5MI/DGIRvGY7AhWjWJTDvs3IJnUtRt6AWJCF4njU
 f1fd+ZkYCnvdnr+18Dx73YTmX1RQ8aLJ9mtekbz545QHZW6vKIYPzBSubHcpnqETqRGp
 HGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176332; x=1754781132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlpguNAy1db+19GMtuU2rYn1N1mDvWtUCnEpEfy+tBw=;
 b=tk7OsBYjg/tLcqXS0aINqJYYskogZ26gqdxYxtZqRCgSGuOZoSUv2dVzVbpJ7sdmpV
 FJbSLGbVNNMl+pLMyjVXrbXYSfGXnG94j18jkyFQmlmYlPYo1ITBfmac39zUf/Eh3vCm
 iGNBLr8LFFm14qR6CRftO4W0xxUjX+BRySmAnH+DeAusH8eZtkxlqbqUHmNFDhUJeYWi
 5TMeFC46gJqEhug84C+UrcbJk6NJ5ziEI2i06X5gJ3qKXNqEqTlFJYq1rpBKF64aWD6z
 1ImTCD+QQ3zEdlgEqcoU1jfKNE2ZVp7qv1noQ2K1B6M+7cdSgskiN+pW4T5/N/C5hr+v
 SBLw==
X-Gm-Message-State: AOJu0Yy47VHN7BmQPsp8OiSSFek6IC5n0+dE+7wrXfhPeQhREqiK7Blm
 /fZdowSln63HRj6oyK18uEDu9CfUXDdcBo9/7n/MxyBgiHeSg83IzPWGP5C0McohVWv/XPx1gtk
 ir0ZYeJA=
X-Gm-Gg: ASbGncuqZ0+YO+CmU5l3S27Y02sB3jPKerZ/YR/cZlZVddWEu9t5egUNKc5mFIfVGTB
 L+dFz7MaaT2ryt/KeNNzshwqiqf2iagxAFsftG8F7efvlDG+Sl7WbjsusgkGZjZb6RgcSe0iboy
 P1IDHryADnWCsm13D9F1QyB1FoQAWfnjVLi81cimk1qoDEuIsxz2qYELx8j7aRAOjDZcPSDpUQs
 uGyN16aVlGkXb4SYK1PV/DBjl2FY/bZXhss9zzsne6FVpKxHYRZKRuOBv7Jy+xZsRt7qBJ0DFIK
 m6eAGM4QTgVx9/02eNASSO0U0hNW0bYD9i212UFjOSapQ0QUZ++49RMNcIVxeUAM3FUSPWlulNl
 kUZao2K2+aO9oRFhJINskT5vN7odsWreOpkQm/e60lKcQI9BUMlu5
X-Google-Smtp-Source: AGHT+IGXOb/EHPRPWSvonvy0Qb3pnNPs5xeV6CxPjFdgJp68TKJq3SwREXa2z7EZGdMyrLohHsK30Q==
X-Received: by 2002:a05:6820:3093:b0:619:a34b:3e32 with SMTP id
 006d021491bc7-619a34b4375mr806346eaf.0.1754176331977; 
 Sat, 02 Aug 2025 16:12:11 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 68/95] linux-user: Remove redundant ELF_DATA definitons
Date: Sun,  3 Aug 2025 09:04:32 +1000
Message-ID: <20250802230459.412251-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

We already provide ELF_DATA based on TARGET_BIG_ENDIAN.
Remove the extra definitions from openrisc and s390x.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e700bc7642..44fe1322dd 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -305,7 +305,6 @@ typedef abi_int         target_pid_t;
 
 #define ELF_ARCH EM_OPENRISC
 #define ELF_CLASS ELFCLASS32
-#define ELF_DATA  ELFDATA2MSB
 
 #endif /* TARGET_OPENRISC */
 
@@ -333,7 +332,6 @@ typedef abi_int         target_pid_t;
 #ifdef TARGET_S390X
 
 #define ELF_CLASS	ELFCLASS64
-#define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
 #define VDSO_HEADER "vdso.c.inc"
-- 
2.43.0


