Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F155ECA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNvG-00046h-C6; Sat, 30 Aug 2025 11:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELa-0005qB-Vh
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:55 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELZ-00044h-6D
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:54 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3278efed3b0so2120073a91.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532511; x=1757137311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iwhk1HGVIv53xO1tUgspGYJaTSrp9MM6iDeDwh0Ulxk=;
 b=AyQXkTAl6OXTW0QOwlV/XAotH1QOusAY1cx2LSdCCZ3EzQcxqJR7ww1+jLNXzf24MO
 UOweL+iC7ID86FqvMeSJ90keB60K2XIj0e844ZIvMKgT6XjMx5jJnBJ8ldL8m/WXFghQ
 IVAxTYAAT1FeP9892vHMqvVswlMweJLJjWvm0WNSBzW0IaAuFytb4yXtQ1HSTTFpblj4
 FMaPw/jFo/ohyDqriAnBfUOo9htcZClUY7zPa2XBZ4I3Rlk8S3xrdgnDRVk4DQ0d9cKI
 Iaf5onB3h48slKGtkKxeSGWKke4B3Pwv7NJFUvc7bdMKD3nKu0WPPzku28JX8Uws+U0f
 dufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532511; x=1757137311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iwhk1HGVIv53xO1tUgspGYJaTSrp9MM6iDeDwh0Ulxk=;
 b=YMnD25ZiDMSwLf4PnK/n3brAHbWDFbUpGIAJE1+rHvi8Z/LHBIXFSah9HPnxqA9hg2
 zm34jN1TGYTUj6EfEfBCSU39lMUWbyh3NpCQmEuVsJWJebSqFML5ck9WgNFlMl9gmEEF
 XAXTBh6Zbu71jGZrjp/RLBPM6bns9FM1cewPGSv0e1sqE7/PIX+jMvwk0T4JSOokBGqj
 0Rl2I0vgjUoweRqLgfN/oGHz0M59sCRAvJbogi10eq2y3bbb/2evBhACCuoVyYJEOEzi
 hnSiZ+lFfKlT4Kqa+5DWV06ynwsR7bin5FmqhuBYtPLyY5KfP4F0qeYIa1mI9055o3Ms
 g1oA==
X-Gm-Message-State: AOJu0YxhdViYQk2a7o7vSiRjeF7PyqT8EH0XCxXr4ZcdzGGFVMVKPwh0
 KyNDWrqwNMJWdkj+qlY8lLHokeXxeE41XNHvTb3n63N0cROgNUiDUA3Lw+aLwBRlK8kGVkXNYsK
 7tckmJJ4=
X-Gm-Gg: ASbGncscPWdzsLoySxIwf+EhelFESxCm4OuXC0yjBhWzkpybg1D0maPP+QU9d6XamIx
 SJP3uio2N1JKy5CZdIJfIYGP16/zzSCjJiMQhcrKbyobfrc4iiQMvhjkUyOBM+ycs4VGGzCYm13
 VcchHjL+Q11hlrpGpaGyb1ILR8D+z7IokhqcPMiBXc9iY+UvUJ51GaLZvvf1lem1HA4qKNc3P6q
 3aI/rPKKUWIJdfO9qC4zXEdfqTv8PExwEoy1Ohn+yOSs99mefQTRyCp9dPVNXxJS9sFZ61kBNu9
 GM5W06hUcaAPSKIxSoqEwem1wLWCcZqUUlTrXBkfDY3j03iX4v8jRggxyns83BH3twvi+S5yA1n
 NvUQrFD8RsRxGTThNStZd7v1F5m8Yc2jluQc9t75vHdSN/ZLlQR5ChDeZTamMMU0EhKrA0us=
X-Google-Smtp-Source: AGHT+IEZ+RJB4/2vLFUV6OggUWyyd9VqDey0ACNrvjRIeKm1Hd+dpw/QQzkDKYMxJxvc+vIEmtfjBQ==
X-Received: by 2002:a17:90b:4b8d:b0:327:c9d5:257e with SMTP id
 98e67ed59e1d1-3281543c7a0mr1756181a91.16.1756532511576; 
 Fri, 29 Aug 2025 22:41:51 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:41:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 06/84] target/arm: Skip permission check from
 arm_cpu_get_phys_page_attrs_debug
Date: Sat, 30 Aug 2025 15:40:10 +1000
Message-ID: <20250830054128.448363-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Do not require read permission when translating addresses
for debugging purposes.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d37c0ce0f1..5d85610de2 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3646,7 +3646,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
         .in_mmu_idx = mmu_idx,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
-        .in_prot_check = PAGE_READ,
+        .in_prot_check = 0,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-- 
2.43.0


