Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9177CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXet-0004nS-IU; Thu, 14 Aug 2025 09:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXe4-0003Vp-Dt
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:29 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdq-0005bK-SV
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:27 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76e2e89bebaso698248b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176712; x=1755781512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bac99cWBoODM0lZjzPV8FafpKsc60jTDKb6XVoHXo24=;
 b=xf89rY2RdSFQ4itg5aju4P6bh8iTqLFUL61PBoDij4U4gw7UxVUBAzQv9Q9We2uGeC
 POnrl0RLD0nrRcFRlLTss+oAttu47MGWRmkii4SuqG5nmtX4VFaVjtKEvNevucuQgaHM
 edUrnz7Cd/Ob+8Mxo1X01Rkd7GM7ewUV/OIKrESWUBu1WCIxdaDYp3MUb1roZhLyqWnp
 CbBmbLDBAranYnCilnZFp+OobJkAapvTfBmHRStI///V9fHSErxQOKjSBrLNwhzX4Yew
 GPU3hcflavru6MB+r1gb7ivP9X8wGL92IZ+xb3JnmnOmnZ1bJV7zNwFCms3clc4ktcNQ
 tWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176712; x=1755781512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bac99cWBoODM0lZjzPV8FafpKsc60jTDKb6XVoHXo24=;
 b=vwHUvkrgirf/jDiTEqcOxsRYU62ZRioqnyHTRL0fhmHh4Wvm1BidDoEc7WoQVMsdCd
 d7hjNmSBNMlzkQTMX4fZHXhZCufGC5xsSYOXEIx0HuVMjS1UkxILOKcXp66srPenWIRQ
 mp0uPPMveAX7czvUaBCQ8NLRi75EJYtqaGsInlN/Gguq39mhFaouF8cfRo1PnuO+fmve
 2ru73fV0EfQjflnEzh4Iuv48uw7wiWFnLRUYUkjhbtgwVE6OZsPK70U0/cww3DrPbcrU
 oBJV5ZI1f+88Pb1syHlNR/G2AFWQwJCZrTr8XuthVp55Atn4cWJjaBoc0NrQzBAyi8o7
 lJ/A==
X-Gm-Message-State: AOJu0YxAZ5WpIMD13X4NiNrtNzhDJlT/fF20EJsOtCNrD/54SwdQBVee
 RRmh7u+cdhiHHsVbY3LAepxHb1m7OO16L3kILhYjamu1i9MUnwHFNVeV+hVNfqwvGyAxZ6oUPH8
 NMJKBIXA=
X-Gm-Gg: ASbGncvot90tM+6KPfc3wK5BZeEcmvXKr3gTwrGa2JfNZ2NVNcol91Gl7h2oqSoGgza
 ReQId8iYM5abMmcLydSPJ5NGoD0Yun0St+1FxHo7NmUBVUbbF4Dl1ly4PUOHAokJ4trBR1+HCyw
 jEm+Esmljf88bHvfQLOf3xUm1b1CRcnFLx+YCdRUrALcdtJeESKQCwcGPg87y5faYMSkJQtLtZ4
 0upo/DKdV+nCnpOnzXDOlcOUKl3+4BBBXZp3u8UsAv2KXD7tBT+GUdFUeYmrCrTLNIWOxQ7izTO
 az9FuHpDR/vXbV536OFKyGEbHj7KGwpe50C5QmhZNbxlQuOX4/x+yiLuIS4i2bQDu3X4khrRj9T
 5Yi0z8bEk/po76pVAbRhB1dGBh9MyshXcH74wWJJQery8C2g=
X-Google-Smtp-Source: AGHT+IFz1rg3YKil1wGP212tKnjrHGzwXOCKqk0XWfiExwIIMX+0YzDe0O905cvhAAUGDJI+6bgPgg==
X-Received: by 2002:a05:6a00:2311:b0:76b:ef44:1fa6 with SMTP id
 d2e1a72fcca58-76e31eb9cb8mr4346246b3a.4.1755176711484; 
 Thu, 14 Aug 2025 06:05:11 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:05:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 76/85] linux-user/aarch64: Release gcs stack on thread exit
Date: Thu, 14 Aug 2025 22:57:43 +1000
Message-ID: <20250814125752.164107-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91210775ed..dfe114ceb3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9309,6 +9309,12 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                              FUTEX_WAKE, INT_MAX, NULL, NULL, 0);
             }
 
+#ifdef TARGET_AARCH64
+            if (ts->gcs_base) {
+                target_munmap(ts->gcs_base, ts->gcs_size);
+            }
+#endif
+
             object_unparent(OBJECT(cpu));
             object_unref(OBJECT(cpu));
             /*
-- 
2.43.0


