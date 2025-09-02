Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C011CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQnm-0001Z9-FZ; Tue, 02 Sep 2025 09:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnX-0000ye-Qx
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnP-0004Yc-WB
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b8b02dd14so14158145e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818692; x=1757423492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x1UdQPyDFb8iGOnyNpIrVOFPur9SX4XEImJiKpCsTc8=;
 b=bCVfH3QZN0WF5x34IuLU4xsjD1aeMkCgV9VwpShzzogEEqWGu0OShxWxNbG6KZCtpF
 nNShd47ZczgxjWrPDksxSkWqvTIZb8hWpSlowTTieA7r4ifIkJfGgfwDsJnfY4FbaXKm
 iumce04C4iWl4IbbR0Wv1FJsRnqjB5QDXnRsMqMBbe0pnPXwqYU2EnJcS/FLb6YBD/yo
 ksk+SAOBl4BfLEg+x/M3kHHt9Wr9IkMfvm+AcGh0OZaJjxnxIF880DLJEtF9QokJn4s7
 DWJlquTbnBzhc8RXGZdXBAbwMbbEK3hTat7cY+W+8O6KdytPrQ+KThTlO8WBpvTyiskb
 zntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818692; x=1757423492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x1UdQPyDFb8iGOnyNpIrVOFPur9SX4XEImJiKpCsTc8=;
 b=d+9v71motjgkxOCzXRU2Aa1No2d+IIjdFkUfwjqyW00vEOm2pI1rR0iahNV0aHUIOX
 2BqZ6RWw7mf61djkUrC3E/k8G6EQqSnXtViSZztTQlLgnl5xi0HNQe4oYwmiUCHUVqbz
 FmR+nnppk+il+l4PVAthzFhjRCICtkXvsCzr+JDShc2fvDhd5iBzr5Zsq8acYpsAfJY2
 pa72HRc0aHi+HnNH69Th4fT9YHo0Obr7JbWpjsB3kZdCsShJJt4qB3ZNN9Fezq7Cxf0V
 iXn1vk+tYQGlAdc8+IHmaMCSm5Ve3g8ykqEZJkGIwyJgmLpWHVKTDolOh7ktv7x4C9Us
 y/qA==
X-Gm-Message-State: AOJu0YwqG8+eIpojRrKUfocCiBbbCg2ngC6mKaHe8jjiBdPP4dDYe599
 iafAtO8cpBRz6oPcpdr0Scyitk7xT7GTSQKKCu98o0QzfzVzsr3t8uXuK4eYbQSJCo4lcPWXI2e
 YzEJp
X-Gm-Gg: ASbGnct24DHhUYykuoKNml2nGsK03hNt3IscObflXy1fhpmGpOTP4CDKbo3qIxG2Q4J
 csIoMt7NQuK0nj9IaDX1qmTK3QhyoRnhNh7R5rqGAAxSbe07ceeJbJkU6/HpjGCuSlR1R6JsyWW
 JVPfy2fqeje6gSRik0ZDEOnJeSAjTUUOMgePqmxJjjiLHCg0RxVf92Rt/eDxzlqq+ekjJ4jisa8
 EIiC6ACsXVWcyVxx1iBJbRJi8aQmJ3x41kgEEyC4NOURtsa9nX4d0wr9ggjeozmcTdVXyu1vMV6
 NUIrgOJwlZteRiDANCBYZnVX3oz498snwUj0rE+2R57T9iUbPyj6IlpqcuJ+OpIkxuNxMD6cTQD
 qNECjukAWlsK5TfwokEUE574MgWCXTDngMhG6GJoQmkdSpk9pi5X1or/DAM1NeK+E2AdyHwBA
X-Google-Smtp-Source: AGHT+IHlxuwAvZe2wq7WHO3yuyk1GupusewJ6fomccX2Pa/by4mT/HfjL0YuBNePAgQ6fDuM81gzBw==
X-Received: by 2002:a05:600c:4513:b0:45b:7eb4:cee4 with SMTP id
 5b1f17b1804b1-45b8557b769mr83420205e9.32.1756818691900; 
 Tue, 02 Sep 2025 06:11:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf275d2717sm19670467f8f.15.2025.09.02.06.11.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/39] linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
Date: Tue,  2 Sep 2025 15:09:53 +0200
Message-ID: <20250902131016.84968-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The 74Kf is our latest CPU supporting MIPS16e ASE.

Note, currently QEMU doesn't have 64-bit CPU supporting MIPS16e ASE.

Cc: qemu-stable@nongnu.org
Fixes: 6ea219d0196..d19954f46df ("target-mips: MIPS16 support")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3054
Reported-by: Justin Applegate <justink.applegate@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250814070650.78657-3-philmd@linaro.org>
---
 linux-user/mips/elfload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index e0c50f50ed2..6f1880befcf 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -37,6 +37,9 @@ const char *get_elf_cpu_model(uint32_t eflags)
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
         return "mips32r6-generic";
     }
+    if ((eflags & EF_MIPS_ARCH_ASE) == EF_MIPS_ARCH_ASE_M16) {
+        return "74Kf";
+    }
     if (eflags & EF_MIPS_NAN2008) {
         return "P5600";
     }
-- 
2.51.0


