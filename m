Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F85EC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmh-0005B7-BF; Wed, 23 Apr 2025 20:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmf-000591-0c
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:45 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmd-0004J3-A5
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:44 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so337747b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455781; x=1746060581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxyuRypmtO/qMdbERqKxpEE+x505tOJO18IE2EpCobs=;
 b=b5j1rgicJzrtqP2R2WCf4AAMrEyUjzxied2bC+u35zNRa/dC5GrxClrM0PrkA7vSeS
 ql/Wzu/4eWDmvNZbLg63+jCj2myK1mNEoboUtpMAjZPlTgRP64PfFmlwTUnDsYkNU1i5
 BZAyx8Mhq46enYCSBBvsLOyOUJaQV2Q05MTVYs9of1hSiosvfmyDmGcTCvtxcao52/Sw
 YfXOlgGXrjW5WbEwNiLhnGkgoko3MkvIEIrjGptgPfuOPTf1KTFLmcNj59izrYIVcwFr
 gwbtrV8RO/ErVnolhT26OvuI/4gkMlTG3+Xj/bnqtwI0yhAyJ/LoRpr4Pu3zzJO79y3Q
 iWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455781; x=1746060581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JxyuRypmtO/qMdbERqKxpEE+x505tOJO18IE2EpCobs=;
 b=oyCctjPda9r0rH9HDrfzNzJsqwZX0z+dFiPo9p6ANbmVV/eKWFCNsg3mJWvnyy4tJI
 wLUECKg3Xc+7ZITgkgssIdejSAwjs2ah0nkSS8X72uD8ajV6wqOWbylgQjs4RUMGEWx1
 E40+33+6mEPchp2RtMD1wmZfHLejZnsZAjvJtjzfH+CZd/JyoH2CSQ25UpHCORzcDEuO
 6VnVMG6cMIJEp+QmkxGP3/HblYFOVCoxNX4zzAmjNlq4y7EY/d+dnZLjyuyE9tNAINFD
 OxEHFre6OSxZUeX4SVNs8DgaOyHeynTHKZogPYOc5DcumSxEPnvy8deIq4IfxoS45EDd
 4d2A==
X-Gm-Message-State: AOJu0YxZIXRaa6W1Fvy/cnTUPaHCZFVhccqu+eeXV9YBU+LAQpPa/EmE
 AoKRDUVLj4K1ICw5ZHX4fDM/pLOLCFIqwAfPkhg/u1IUp+N/379TPD3s34UMO0IoA4u0LijwhDF
 Q
X-Gm-Gg: ASbGncvtjtgjjWyPtBIsCuMLaVeWx04u3+SoT2kxExmwHEyPKfkz/XoP/MvIWY5hjcS
 acDGGyTRwnTx3kEVGu83OVUoaj5mVmo4ZTA3mpCve6tSaUa8V/QpZwwURHq7Sza+UI319Ye1wGy
 rhYJPbtkcCJCKOz1f5D4f6E6qjR60WrnUE/kX1Ft6GQxpZePQlrkOxfyql7+K9i30bVxE1U8Coe
 fs4n9U/JCcXQndnnMIXn8Lyzl/nWacDg1nsKnrB93KXxPOhwcqfGPYs7t8tMcZkcz1vAU1qGG8Q
 Hn5YpDo5gyzYCecxo99PRRQFs3aSD7nwzDttUvnYWYU4XPSjNvzdJEtoa76StjuaX2uKYKMsOhA
 =
X-Google-Smtp-Source: AGHT+IFaZTG/U1wAL/P6H6dp3fPe4QNqPc1xoX5KKdeQURCaihhaSQx3tTin3u+4fD659jgtsBcZOg==
X-Received: by 2002:a05:6a00:2da6:b0:732:5164:3cc with SMTP id
 d2e1a72fcca58-73e24ae120fmr872724b3a.19.1745455781330; 
 Wed, 23 Apr 2025 17:49:41 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 009/148] exec/ram_addr: remove dependency on cpu.h
Date: Wed, 23 Apr 2025 17:47:14 -0700
Message-ID: <20250424004934.598783-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Needed so compilation units including it can be common.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-10-pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index e4c28fbec9..f5d574261a 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -20,13 +20,14 @@
 #define RAM_ADDR_H
 
 #ifndef CONFIG_USER_ONLY
-#include "cpu.h"
 #include "system/xen.h"
 #include "system/tcg.h"
 #include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
+#include "exec/memory.h"
+#include "exec/target_page.h"
 #include "qemu/rcu.h"
 
 #include "exec/hwaddr.h"
-- 
2.43.0


