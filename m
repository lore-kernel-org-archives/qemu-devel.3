Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C2DCF042D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCW-0004NT-7X; Tue, 08 Oct 2024 20:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCS-0004Ik-A0
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCP-0002rr-UR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:07 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b0b2528d8so70928005ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432304; x=1729037104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8E2Z9ZSy95UZsg9Y2N2fIiaRxpU5aj12TR1V9ijHxjM=;
 b=QG1nPvj4zfH7GnQRIAAQz9SpYqyAdJ5/aBqi8aSG/EaefoDDj7yWs6OFacxEwDP2ai
 tR9ershpLoFZxu1NkILKtVfj1X1cK/T7SAcI+2kziJOwd3MG4YFOxbWIL0ZqK5djDCes
 ewTgma/GjFGN9TU2gOwg9GXTR9tc1z/RJS2Szt5So7YMTsMcLDvIzsUsDEK0NTz3UtVC
 7N1NpBwFwNUTP6wE7lYy11M/FkSVYFVuv9VjCbzuNpLbFMCIDkuTQvGxdBBE0PS4iQcY
 obsNdtMY5tQmOEMwkAI+cO2Z/jD7wmN+0YJtxPurj3FYEU4tKbiEFCwPKfTrv0NY+hC0
 ANzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432304; x=1729037104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8E2Z9ZSy95UZsg9Y2N2fIiaRxpU5aj12TR1V9ijHxjM=;
 b=ldLWUMJUO713iHwXJsTuem63Z3i1WbTRU02hS68egDcRUZCHQVWlDixrxMfnZdN7tM
 YnnY6tnoVIjc66bedybeAwHhch0OrBw4emSX2cP0eEHSh1hnBYEf5F4W9Iq0JNIQOK44
 VGui7wU/+cWokYCwx1ny8AtjL+nqvkmdU5y82y7sedBd8mXM0QQamQtjLfmI8lyVNSH3
 2dRLT+zB9aWR8zTxLNBRoqmaxXjcy/y6oAnUrvPqplFb2nu3PPlDTgMeM4lxjIUkHrA+
 GUSYaU1aiVF0DiYyMMvw3FF4qyU0V1Gq5jVhfDr8j7gSggc12Z1ZYz/SLuEvuRctv28D
 fZBA==
X-Gm-Message-State: AOJu0YyIfQsxlApBeXxlzJRMk9bp5hiZMEdwbO4h9R8H1IAI/J7S2h5Y
 ouvRSjufYMRN+G+MtxwRRVyYjZyU6uiy8YqWsmHgXpIN7oj5+VoLbEdO1kpA5Om3l4PFb15k8et
 Q
X-Google-Smtp-Source: AGHT+IF0ZLww/QirXn6eqf2utM1nSiZwyzsJ3soHtkS1Z0DxnmXSBaV1UhTlgasVQznyDC1QSh7zOg==
X-Received: by 2002:a17:902:dac7:b0:206:fd9d:b88d with SMTP id
 d9443c01a7336-20c637986d4mr11253965ad.61.1728432304454; 
 Tue, 08 Oct 2024 17:05:04 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:05:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/20] target/hppa: Fix priority of T, D, and B page faults
Date: Tue,  8 Oct 2024 17:04:42 -0700
Message-ID: <20241009000453.315652-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Drop the 'else' so that ret is overridden with the
highest priority fault.

Fixes: d8bc1381250 ("target/hppa: Implement PSW_X")
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f027c494e2..f71cedd7a9 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -288,7 +288,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     }
 
     /*
-     * In priority order, check for conditions which raise faults.
+     * In reverse priority order, check for conditions which raise faults.
      * Remove PROT bits that cover the condition we want to check,
      * so that the resulting PROT will force a re-check of the
      * architectural TLB entry for the next access.
@@ -299,13 +299,15 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
             /* The T bit is set -- Page Reference Fault.  */
             ret = EXCP_PAGE_REF;
         }
-    } else if (!ent->d) {
+    }
+    if (unlikely(!ent->d)) {
         prot &= PAGE_READ | PAGE_EXEC;
         if (type & PAGE_WRITE) {
             /* The D bit is not set -- TLB Dirty Bit Fault.  */
             ret = EXCP_TLB_DIRTY;
         }
-    } else if (unlikely(ent->b)) {
+    }
+    if (unlikely(ent->b)) {
         prot &= PAGE_READ | PAGE_EXEC;
         if (type & PAGE_WRITE) {
             /*
-- 
2.43.0


