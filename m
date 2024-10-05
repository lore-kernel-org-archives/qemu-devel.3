Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAACDCF34C4
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fb-00026t-Qh; Sat, 05 Oct 2024 11:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fW-00023q-Ig
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:06 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fU-0002Nq-P7
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:05 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so27185265ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141963; x=1728746763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZFSB9ZUy/VXACo96L3HUXARpyVU9ywq9XNxX+p9inM=;
 b=k8e89w4ChnXsaaKuSvUeLM6mkPAACCHbS+9FlidKqQgd+wb5Q/DAcEuxSea960KejT
 vtM3vjfD9pFXwr3cUBleFYsWycRv36cwKxbj1Ehbl/Q5KiQ+XBJKBxNttCSyfWYduI1I
 FEXsYM791iSqMo1rDKcqyOc5Sx6d6egYPPwEZ5GbzZ3MexPW77E9LF6CGZpjzrcuO16N
 eFm6SUdQbSCjd16ngAzqzS9KuqG2tDhnccNIGagQTKk1oPe6/4vZPE675OFQy2Nz+RGI
 7tgLm++/8FpCltRLMHyLVGm7Iik67QUANJ7RbtqUNqHFrIWYT/vsfbXm9hX9VwOD55se
 ub+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141963; x=1728746763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TZFSB9ZUy/VXACo96L3HUXARpyVU9ywq9XNxX+p9inM=;
 b=PRavDROkaZXjn9UKMcMBcHRZngGl1X0J5p1tU56GLleY0dCUYyIF6HXFpICZgNlvrw
 XwhXtawtqsvWEdoi9EVCw3P18k/gE324m+Y1jXShi3gtiGBOd7RmI2kHI0dxYSGHQ0CP
 0Zmaiv+dir7r6HDqXGWaiRxDFW4lHPJgW3x9YTIASRIx/ROHWTrbBrdM9u/INJb3/Nhu
 LCP15Fe0UTsuuRjsFA2rndcY3fWFmK9tmyWgHBduOyFoqTHITqerFB0qOhg8h1bPap59
 8OsfxDgti+LgdR6/xeGTowUIx8Ykc0IwmtCpyTM6yJfBl5VBD6x/a0mEw0kJaBhqgYle
 MHyA==
X-Gm-Message-State: AOJu0Yz78vBajtdtRwRHRUFjNNbgesPMpENJp5KuicX/4K6YlwbVPzLb
 d0I/3q6787meHMUzV1zZAioOYhTFuMEXwNdME77+4U7Qkin80hWNb4xfhwE47pc7QiSXuLbWWsP
 n
X-Google-Smtp-Source: AGHT+IHoHMOdQJhz/hk6oo5QEC16Z8Yklqh5lMZB6Txlb+2L2pMHFtFjRuBs6OrzX6SPGfE0OUkqtQ==
X-Received: by 2002:a17:902:f788:b0:20b:8ed8:9c74 with SMTP id
 d9443c01a7336-20bff1cb9d3mr97600185ad.49.1728141963574; 
 Sat, 05 Oct 2024 08:26:03 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:26:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 11/20] target/hppa: Handle alignment faults in
 hppa_get_physical_address
Date: Sat,  5 Oct 2024 08:25:42 -0700
Message-ID: <20241005152551.307923-12-richard.henderson@linaro.org>
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

In Chapter 5, Interruptions, the group 3 exceptions lists
"Unaligned data reference trap" has higher priority than
"Data memory break trap".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f71cedd7a9..d38054da8a 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -221,7 +221,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
             g_assert_not_reached();
         }
         prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        goto egress;
+        goto egress_align;
     }
 
     /* Find a valid tlb entry that matches the virtual address.  */
@@ -323,6 +323,11 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         }
     }
 
+ egress_align:
+    if (addr & ((1u << memop_alignment_bits(mop)) - 1)) {
+        ret = EXCP_UNALIGN;
+    }
+
  egress:
     *pphys = phys;
     *pprot = prot;
-- 
2.43.0


