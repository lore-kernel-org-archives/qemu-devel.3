Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B7BC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1P-0003h4-A1; Fri, 25 Apr 2025 11:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0r-0001fd-Ax
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0p-0003yA-57
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so20919145e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595045; x=1746199845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RuU8AtKetNHWTiYfP+x4IVHUbKHficL49y52z2FVyk=;
 b=Ole6G8F0gfjcxnzAy7tfhNpXPO3xB/7Q0XTMF83x5XTbIdYO+zwSTPvjwQ+Tb2Jxsz
 0xBBUVw0t98GEuht4/RGrrNQ9xMu/0+c3WJNLT6CkCxeu1/eTzp8ALUzyeL8rW9WLcqh
 2s4I1WwMmGc0AkXSPhVyNjQRu/cQBkeAdwyuafuRacrks9bEWhORFViNgcCzHnKhHm/B
 qVxjT/oeaIzCsx+QZZg55kC9dTPPHKqinGmR+XKUr2savEDYToNg6rDHMD+XW6ICLONC
 yMZerO6e62dNdcNowcfap6Kn+ptFL1q+7jufDZDKDzp9le30HRJMvpbOZWbZHh7DjNUT
 gIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595045; x=1746199845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RuU8AtKetNHWTiYfP+x4IVHUbKHficL49y52z2FVyk=;
 b=FPSNMyNRwjC8N4pVXzrq79F66oa3pcXa5Sw5z63JNG69lrDD4Ba2y62ZghqfI2c9XQ
 mt22m8HgDQgWqPv4tlBze5r8iO69lzIU2jQ3IFFPr637zQMr89/mSvcOai590ifok4iw
 5AcrNT9Gf95lC6Bumi6KliCoIiyNzMFfoe7oIbAm6DNFd0u4AsWlWKXy2rgQsXxhKgGP
 4nody0nvcgat5/fLk9MWbfI+e1A3JUYZIbaonDTbyBTWSW8mKKZmQL8NabFDdSNPCm5C
 Py7fM1LZ4Ux9hjG+UCPfEoLAnEXxF40yvHnIaVM+pf9Y9sPtZqQq7T2ycadbWR3pXfDE
 f6LA==
X-Gm-Message-State: AOJu0YwIfo6VRQonRnBF8Sqz750gSFJdORsiOGj0/Hp8IdBrisFxJNiI
 /V/vAzp16uTVi+yYSxOyWmLi4d+5Qc4+cZAdXyFnMAXPXGCvI33NoA7ho+HCkA81cL3eTVOMJUA
 j
X-Gm-Gg: ASbGncsVt2SA7H0UOpmSPls8OEjqF82ruUXqXZEXuZIlxr9lxkRhk5mw41ErP4mw0vA
 rYw9/VdOuEG5+pK0HBJNkTAbAh9OhrsrR9U4Q8+yZo3oV5Xp+/clcrCQOwtmO1VyKBPQ2UIncb6
 x5R0A005rfV/AA3+gHljTdoyi3RCflEBXrRgqy2m0tjdl8v7zd2jGaODtq3RfPx9desHX1BXq9M
 GZiGneXngj75dqddtnyJHdfZXlWvyL5pilvUBc5H0TE/Axr/mrqgJodOTc9dqOFY40tZ3TQp7qB
 aK7+4rxNuLqvBhxrmBycXfMiituvbIC4YK0zEg2Pxf5+Dmbt/vB7o3iX69SK7u5oMm63W0OQwNd
 nzEkf4OTxkI1Iyec=
X-Google-Smtp-Source: AGHT+IE229UQmGI7Ko/h8dvAnmf+lRtYW5wq30hNjawphyVsnHhTKcVKOYa4AUP5g8VYWebCvFICMw==
X-Received: by 2002:a05:6000:4202:b0:3a0:6a8b:ae4a with SMTP id
 ffacd0b85a97d-3a074d4f0d2mr2630580f8f.24.1745595044984; 
 Fri, 25 Apr 2025 08:30:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5219sm2644819f8f.27.2025.04.25.08.30.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:30:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/58] target/arm: Replace target_ulong -> hwaddr in
 ARMMMUFaultInfo
Date: Fri, 25 Apr 2025 17:28:08 +0200
Message-ID: <20250425152843.69638-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250415172246.79470-2-philmd@linaro.org>
---
 target/arm/internals.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 08f4bd16791..0818de530b2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -25,6 +25,7 @@
 #ifndef TARGET_ARM_INTERNALS_H
 #define TARGET_ARM_INTERNALS_H
 
+#include "exec/hwaddr.h"
 #include "exec/breakpoint.h"
 #include "hw/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
@@ -726,8 +727,8 @@ typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
 struct ARMMMUFaultInfo {
     ARMFaultType type;
     ARMGPCF gpcf;
-    target_ulong s2addr;
-    target_ulong paddr;
+    hwaddr s2addr;
+    hwaddr paddr;
     ARMSecuritySpace paddr_space;
     int level;
     int domain;
-- 
2.47.1


