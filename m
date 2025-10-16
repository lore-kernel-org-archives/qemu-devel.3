Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F4ECCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mw2-0001aC-LA; Thu, 16 Oct 2025 08:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mvj-0000CV-4c
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MvX-0008N9-Ct
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:02 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso397726f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617065; x=1761221865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XVN6tBw0gmk97WCd+6dwcTNW4D6/bgAb0sKGBCNOIqs=;
 b=H88As4ISQaZNkGwY12cwpiXaIIC/97UrYJGa4/90uxHei/3jntVqDzqotmj73PVNGs
 J17p+Zt+SjD2YjaSsIUH++fIxHRyMekwb2AhTzNuZPXBbGVK++O9wquY2NGBeMeHHN+7
 qjbRqOxcRQnOaWivcG6ZgyD1rXk4tUho7+xruhqJzjRCwH6aIwH+AbGxLYrJuzGr6Lwk
 vSuGELmeb4t0XVNSLd0bqG7RU8xSXcFfvrXI8uVEcmDwYKnGQ55aR0uDbXjUFcgM1k69
 8RUibPKIiG8Any6Gxog+DL9M8y+pzIXOR28V5QyLiAAYaqbz614OBleKcp9SvLgv8gtb
 jt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617065; x=1761221865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XVN6tBw0gmk97WCd+6dwcTNW4D6/bgAb0sKGBCNOIqs=;
 b=xLU2cYDINuN4Baiu4x3b68eOHDXUjiB3AgsHpov5cFibssIixUHCs+Tbl6p5qad0Rb
 s9tiVMeg1mGbCXoLpktf9buIku4DYPhlsvfSqwH5BYw8bYw3Cfk15q0Jn9tKodkTwWKR
 +Yw5eIqDrtDF8uz41awUaW3Uv+j5baan8y3Penp83hTKf3gQR5Aj/ZSty1fD1cys/q1u
 nTtDxLZopXOBTQBR/IzxcOF7158ClueftgCMtzZyA5FSTR3SucQz3q0A/j0ZdqD62qja
 XADJ77EHlAKUQvCJWkmosydMxgDEetjHiervsia9kFGjyD6yARun1ISOuupPZRWyhs0y
 UW8g==
X-Gm-Message-State: AOJu0YxX5fObLOlM/4dkBBwB/jq1Ag2a3i9g+mBXpvxqnCdROZVr4KXD
 FCCbwUxcy1r32tvCWn5CN6Buv5G0xpQ1hnV3xbGEJIVqNwZqG7J4AiHyRbNXAaFr8SwhZq/L+bC
 qpAuGw9g=
X-Gm-Gg: ASbGncvkQm/zzUNpJRBvRAdhD1S4bafQ4iso2WAm8DjSpTdC7qR/UrJn0gflGu8j03K
 uug/0MTefrcMAi+CD7GMy755eSXw2slm3vhmtNQpsQk5M/4UGSvA4mGWniT/bglXDae9XlYe07/
 mt2Cbs7YsOSJW3rqWsHTbZSz8t05qvKYfq+xRy6l+4j1fK8gYvajcoFfMraGH5UHUyHBtt0DvFf
 F55LJ9Gbkl5Hmv//VvBFMv1YHmk7k9JXJngoiK5+p2wtA+DK1c7kbGn9EhXtxn0BQGnN53CWuQu
 egGPLU/KUdsk/OE9X4CM2G4cE+ctHNoZeaRkhb6kgrv3nX39VZaDeQvl0uQvcKpQ0Zpk4K4RJBw
 OlRkNrkMiDs75EqG8yyA05/nfm49OmyZMEZIenLfcXnQCciw3Qo1r2nbdCI2qIpeyUSIuymKTko
 Mb6FjOrjdRnyU7jJSJ4d+81ZyAXSwTPG56MFNRgpYvd0dT7pLEmjBtIpjs05AerpWm
X-Google-Smtp-Source: AGHT+IH9M3/VjmgcX6ic5cwQqY29v+TUZ6OX1NLHZCCz0p2S7ey5fkqLj2GcGxL1iiBwNEZ4JUbmCA==
X-Received: by 2002:adf:e18a:0:b0:426:d81f:a86 with SMTP id
 ffacd0b85a97d-426d81f0b0amr14856660f8f.58.1760617065194; 
 Thu, 16 Oct 2025 05:17:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426f6773726sm8908074f8f.49.2025.10.16.05.17.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/75] target/openrisc: Do not use target_ulong for @mr in
 MTSPR helper
Date: Thu, 16 Oct 2025 14:14:44 +0200
Message-ID: <20251016121532.14042-29-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

OpenRISCTLBEntry::@mr field is a uint32_t type since its
introduction in commit 726fe045720 ("target-or32: Add MMU support").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010070702.51484-3-philmd@linaro.org>
---
 target/openrisc/sys_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index b091a9c6685..ad59939db3b 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -45,7 +45,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     OpenRISCCPU *cpu = env_archcpu(env);
 #ifndef CONFIG_USER_ONLY
     CPUState *cs = env_cpu(env);
-    target_ulong mr;
+    uint32_t mr;
     int idx;
 #endif
 
-- 
2.51.0


