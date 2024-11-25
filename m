Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ACBD58D40
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 13:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZ1X-0002Th-Tf; Mon, 25 Nov 2024 08:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFZ1W-0002T9-59; Mon, 25 Nov 2024 08:21:06 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFZ1U-0005oq-NE; Mon, 25 Nov 2024 08:21:05 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7f450f7f11dso3127484a12.2; 
 Mon, 25 Nov 2024 05:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732540863; x=1733145663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IdWvHR5b7t4vflEj+LY1CHfeckBBRyVCsURA5jMuHo=;
 b=A1trK9e4zdDfVgc2Sz6bSlDeOyMz08iLaZQ63B07h6KSnsgTCiwuBRB6P9fVSx5Eym
 C2iz5hs+o1Oi5ntIaOYfdzD1b5fAT0OsF3tS1kGdWKSjXuZw6CF/kjf9GIRo12yG7wds
 M+CjamAf3pP/kdHrfeOIU8ZGyxDVmj3m8R1DaTHHeew+c+8Xp6sxMN+i/Zc34H2aPeAQ
 UTJCHHhPShH/NYAuXFhHzysj5Pb1pM0VAehHA77kFokzW1Nu8B6t6h32dG0EOiU343pK
 VwSEQ8hsxk29LlZmrve8qot94bg0eCPD3YHg4au59spSlqA4ULMa23I+ANb7ke4XjMHe
 KWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732540863; x=1733145663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IdWvHR5b7t4vflEj+LY1CHfeckBBRyVCsURA5jMuHo=;
 b=aC0rwTZBZGkH8qCdmmsHrVuuXgcNNWQ1zE58WuzyU83CmhW7EWrT9jf4W6YnGGibTz
 H1yDi3XOlRHe92iHncwDfByWxfZITGlhinqPv1LRBdDmzlUIeBA44hmewGI7mONDDZyZ
 oVUEnebAD1N5khpdka/056Yjk+MKTgLv6tEkzTqAOYGuxwYkoZYwRux1TBKpoE7/FJa0
 AJ148EpjQefvGKU4KG/inTk+F5mLQKw7KsFa4YoZsQPsiBEAAGxFfisUmx2Ks1X4VsCv
 be4hnN1c0yvKxJh2VU/fONiWisih3+R+cSJaudtO3TARDEbvIn+5NtPjI8OTGSYqVx2s
 JEWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL48OFgKCpSpG1RAHEUGEf6KERt5LjGi2GHiITg2JDuLgoKVjuiPM20Jkppm2sUEoYyWaRwZF2M2YL@nongnu.org
X-Gm-Message-State: AOJu0YwGByCUN+luYlMcGFBTdsEtZiJuTfft45wDYujvNFj+sKsyJUQX
 8WloyfgOJPb4t7HiAmBKWVAQZ/VbPNuA9pHVPWCrH+Q8m+RKX/SgEdfA3Q==
X-Gm-Gg: ASbGnct1DL3XsT1VUwAlmDmbLRZbtfzT1Be6S+yXW4iGVn3MM/k81AcZ/M7BrmzXdE2
 oXZeh4qj3lr7WA65FMYucTXGi5nG8SJfnU4DcS9otQWdrljL+IxsXEiiGNe204aRw2zdR3ig83o
 JSFMLCE3xpaRJA2svbA1C7Gtk7thddUjPT5lyfHTIz/qJozCWHJ0qRPe9IKWHqwqR+QB5Jd33Vj
 nA0GPzPGdj247J/9Zd/Nz7S09vl0bYJRx0tzjb3ONs480MhvUWefraVSc31EA/BzqwdDCawXkVl
 QExyaA==
X-Google-Smtp-Source: AGHT+IHxUCaw/ZQPWI4iqqBUFwF1LBolZtaXndO+gpWUDCccz9wunrEjVlRULjLXlF6LnPGC34nUBQ==
X-Received: by 2002:a05:6a20:6a10:b0:1db:e508:cf68 with SMTP id
 adf61e73a8af0-1e09e46dd36mr21694414637.24.1732540862696; 
 Mon, 25 Nov 2024 05:21:02 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcc1e44d5sm5616721a12.32.2024.11.25.05.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 05:21:02 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PATCH 4/4] ppc/pnv: Add xscom- prefix to pervasive-control region
 name
Date: Mon, 25 Nov 2024 23:20:41 +1000
Message-ID: <20241125132042.325734-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125132042.325734-1-npiggin@gmail.com>
References: <20241125132042.325734-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

By convention, xscom regions get a xscom- prefix.

Fixes: 1adf24708bf7 ("hw/ppc: Add pnv nest pervasive common chiplet model")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_nest_pervasive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
index 77476753a4..780fa69dde 100644
--- a/hw/ppc/pnv_nest_pervasive.c
+++ b/hw/ppc/pnv_nest_pervasive.c
@@ -177,7 +177,7 @@ static void pnv_nest_pervasive_realize(DeviceState *dev, Error **errp)
     pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs_mr,
                           OBJECT(nest_pervasive),
                           &pnv_nest_pervasive_control_xscom_ops,
-                          nest_pervasive, "pervasive-control",
+                          nest_pervasive, "xscom-pervasive-control",
                           PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE);
 }
 
-- 
2.45.2


