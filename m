Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5103CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 00:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1w4Y-0002Pc-9V; Thu, 25 Sep 2025 20:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w4S-0002O6-MN
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:20 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w3z-0005Ek-HO
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-279e2554c8fso15792515ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 17:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758845501; x=1759450301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12OXoTcuOfeVdlm2kWXUtr2dlbq5Ty9b8Q3kksNsxiM=;
 b=LSXCfFb9Mc9RcjMnRyZn2zk0W4dHscdMRgOVVrhPW2SwahaDiUrrK0LOWg//tQE1Q3
 ZagFeKtp1G/w7dcYB2rqp6BiRSnzED2GNj2ONg5zWo0NSpi3UrE+vpiNAM+Z/VvK1IFY
 vnMeDWeAUP8awZu9QABzN+XIQxVOJmNYEZb5jGVxh/c5d9LijgJ6qWBmtODKkXI+r3hQ
 1jo76guTwYFQopo2QL0kRb7Fw8104RrQoAu08qicTMZP+elcsFGk7klU2VYUQar76qVN
 ZROWNnGOYJVvZVTxcZz1odwU7z501R04bKppnKrRc2fTkNLnhj8/m+iOoxCmiNikobJ6
 XStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758845501; x=1759450301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12OXoTcuOfeVdlm2kWXUtr2dlbq5Ty9b8Q3kksNsxiM=;
 b=AQDq5zvKUhr8ZgKfw3N2MUciuk4wGfIu6MRcB0zcrHQ/PYakwSjUM3JzBclqSe2SF8
 C8vjfEHP24U8xvnmAGD4uTru3KPTdl8zP9VuZsEumxkNBf6I3qG+BM6x0yFpZSjusTsX
 nYeR3aNgJWrz9/l1/yK0UhknvStdlemgXATu3OwJnPezfjEf8OUWSIAqzurOHQJm2ldb
 7LgLfbpVHi2DS6P07Z4UOCTl1Q5Wkzl4IxHB8S1sx0uV+AoTHwnQN8BJVefk5xuM8q4V
 cHfiAcVQnwTGXCRL/fTF3JW5Ly14gWZi2PpD22tC1rMMA2NjDC/Q0UdyG3fRBpvk+1lW
 9vxQ==
X-Gm-Message-State: AOJu0YxH8BwKkowVIdZOrlQD8LcjopAFB5HTJX2h29xatIPlMjAPXuf0
 G4WlQji//ASCgSxXC6g1AIJpi2IyvNLC6+XRSn0MATmDE8/27/2wJyz0Opqf8DLlwDCOT0sIuN9
 78aNx
X-Gm-Gg: ASbGncvvP9ZbltLPIUoYRhKyeL0JVpqum6BK/sdhrz7P/ChvAHkBLUWpnwRk7vfYFUi
 bKZFSGMJiIuGYYXepFVQ8PfyNyS1YC/QgSUcpQGuePpewMVTblaSXT4GuzUjHZtYLZ5LuavaKkH
 Lz9hjYhXLpMGx385bkCvavu7hjtm87582TB8PxkMN29LM+7ZQPXXgYPQ/r099SHJ6/fxEK+7HYI
 OKb9aQdTZSzcZzfZoEDngEqw0O5eX1V6W4Sk9CKhoja3ERx7/8FYhR7r7XX4Qq2YC9/3whV+Tay
 KpvAyQA6ZxKcfhxSR4nJIgHTUG8E81RHx7u3fs7tUM6BXOe9rm6Pod+0kVaSdUVXBlhS1BbR2O3
 jDopoSdYATcHyVQEzd7REvEiARMbz
X-Google-Smtp-Source: AGHT+IF4nIUT+sqlY0OI9lbNQStI1igOHWyxYUlDk9nmSA8Fg6S9XSOSqM/cvQy3hdEFBSC5zmDCOg==
X-Received: by 2002:a17:902:ef09:b0:276:76e1:2e84 with SMTP id
 d9443c01a7336-27ed4a06b49mr54469815ad.3.1758845501607; 
 Thu, 25 Sep 2025 17:11:41 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ac37efsm35829425ad.137.2025.09.25.17.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 17:11:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/10] target/arm: Fix GPT fault type for address outside PPS
Date: Thu, 25 Sep 2025 17:11:32 -0700
Message-ID: <20250926001134.295547-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926001134.295547-1-richard.henderson@linaro.org>
References: <20250926001134.295547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

The GPT address size fault is for the table itself.  The physical
address being checked gets Granule protection fault at Level 0 (R_JFFHB).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 36917be83e..236c3a9569 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -413,7 +413,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
         if (pspace == ARMSS_NonSecure) {
             return true;
         }
-        goto fault_size;
+        goto fault_fail;
     }
 
     /* GPC Priority 4: the base address of GPTBR_EL3 exceeds PPS. */
-- 
2.43.0


