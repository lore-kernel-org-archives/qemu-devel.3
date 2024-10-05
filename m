Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84E0CF34C4
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fb-000279-UP; Sat, 05 Oct 2024 11:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fV-00022q-EB
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:06 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fT-0002NN-Va
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:05 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20ba9f3824fso24155255ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141963; x=1728746763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=posPbKSzdb+ffX+WhfgYFaW0pAyKjx4IZlbzVQLaTuc=;
 b=Ma6AlayfgwVm9xWhtnJUF07prxdyJ06l4bjxt8TmBR3Es11DIO4P1llmZRnWMj6x77
 lTaXuAZbYaK4C7lN2CK2Giag5OHlxKh2Kf+oFgIbma4zzxghDT7+C/cUrFOB/IspAcIb
 SvcrM9O1iJ3z6xb5s8n7OwXppA7X/LSEmu5Gke/iTyQp0TpdFlHe72oUd4vIaqrwN2yL
 F+7lybRIBI5lg7dEAmSSPBSnKGqKPJ1FwB77BEk/3eTDO3ETHeXNL5X49hmZCfo+GqoD
 pwv2VhSsyoj24F7LqAgNTyDq5w8QgfrKphfWNANnx0go3F4vwLtuKKU5Ljm4bWSJDdRF
 bP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141963; x=1728746763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=posPbKSzdb+ffX+WhfgYFaW0pAyKjx4IZlbzVQLaTuc=;
 b=DGbTl3pRVs7FnyhBd0UkpqYV6+nBiuotZKEu6Rl0f9R/7V8SGbjOPYc0gHYFaFkpvL
 cU4Et/7YUhbV1UL7wia4CYeDVlov/CyxCogu9j4yCSgmQVtV3mjYuPuEk5dm/YaFRPzz
 pZDfiYMRbBCJSqNQzTsefIZH+B1RZKXuB4rhvNq/i8M9gf+d+Iu8GxaAAwGDndM98aKI
 PB0d4o0OEQ1DbyWKSrhi2b/ZxYu1h0HrPS2gO/k3EALpwulYrAjgP+zkyNPTeRn0rPlv
 Zu8Aq5qbwY8Wp1abeXhqHyVksPuzjnxjiaXAdRO05OjSUkGxoiU+Ve1YTzxYwexvTnez
 18xQ==
X-Gm-Message-State: AOJu0Yzp4d3w904GfJYPYFSZbrO5N/9BV37uM1DdASO7xG43gSuqxvSu
 buONyea2xF1CgmXmASGqHaWARcPy6b7Fx81BPF/B0G65eOceFIhZM1k+2em1Xw4BQcBhIHlh24j
 F
X-Google-Smtp-Source: AGHT+IHBX41nPwo6covULM+vMbiWEGGIhbj1kTBPJ81VMsZIIlt+W/XQXaPT0SdsNmz4Xr77GlztTw==
X-Received: by 2002:a17:902:d2cf:b0:20b:502f:8c2e with SMTP id
 d9443c01a7336-20bfee333acmr92469555ad.51.1728141962599; 
 Sat, 05 Oct 2024 08:26:02 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:26:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 10/20] target/hppa: Fix priority of T, D, and B page faults
Date: Sat,  5 Oct 2024 08:25:41 -0700
Message-ID: <20241005152551.307923-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Drop the 'else' so that ret is overridden with the
highest priority fault.

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


