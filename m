Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C3CCF2592
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pa-0007AH-Mq; Sun, 13 Oct 2024 18:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pT-00078Q-HR
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:47 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pS-0000uZ-1t
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:47 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2ed59a35eso2377336a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857565; x=1729462365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5sM2rASXzZfAaByCSG4X7yOvvA/fFZaOvGmejFsljDo=;
 b=bHUh/ahtyWr/9PjKNFVAJETPLg3uykNiwvNVeJlL1t958/vxKuLEnYXNG8WjEDh+Y2
 SbC1mcsBMJammrPg2jHVHWwWIXMzJZXgAAKFM82Pgd1l7azeuK6hSRXFFg6d/RkCI6n1
 eWuQipNKk9FCdEPO6gOm9MxKxPTSptXQZWYEBgmizmz05uaQ/oaeTm8VPUp7n6U4lHph
 J9lfLnhW72zWIFXnXhtSpKtGg69VSY3muMV1HxUw1oKDCjVUIrp9S+y6EvGPWD63nKGb
 2WHGqfj0orADKPW10F3PKIuzpdXsIaVgeH9u0WZJj6qtclQ3YIYKlROpRYSpXO1l/2/n
 rnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857565; x=1729462365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sM2rASXzZfAaByCSG4X7yOvvA/fFZaOvGmejFsljDo=;
 b=lYbOgK2B4mPZQywvJxJ6drgE5kWHlhScRDiUfvlqbskK7VTQ6yaKChWZkeGRJTZad7
 KmDFC40yMjRFBMWIWZhVW5SolQy4a9tqpUzHCBA91VQbzrpYICTSAelrBnV+pVWBgdyJ
 du+7Ti2uZG1zL+M8v4pMrOBwfKoQPnJyPQAqxVEsD00LkUmXR9XFfBegqhBd6QP0NtXG
 mmW8+qQpl7HD/kpBBJdH2/2MrCqvvyG40Xqw1yEvgaoZdbMfgsM43epCA3R7NQWSN4sj
 26kMWFKXfQw/RbTeA1wZ5iG6NDXHplVMPEtCCRpweRkLNJXbU7xSveaC7N78anLefTcM
 5XpA==
X-Gm-Message-State: AOJu0YyIqxjgf47RERqrW+wYDwtOkd3kTcDzC/J/GUaFdpZQF0KWMQaf
 7lcyOdOKrCZsy42Z5vJsYZMDdN33QXpdmqExcKw0C5eUklLKlGUYnHEfiiKfeH+rjCBr0KmKVhi
 I
X-Google-Smtp-Source: AGHT+IEhdVIv1IYvBtZa8N/hMCtkNnq/cd3OO14Urwgh/PkgCabwXsG2+Phzfp1rNratvIdtJJ2xpg==
X-Received: by 2002:a17:90a:68cb:b0:2e2:d74f:65b6 with SMTP id
 98e67ed59e1d1-2e2f0a6838bmr13199352a91.10.1728857564810; 
 Sun, 13 Oct 2024 15:12:44 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/27] accel/tcg: Assert noreturn from write-only page for
 atomics
Date: Sun, 13 Oct 2024 15:12:16 -0700
Message-ID: <20241013221235.1585193-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

There should be no "just in case"; the page is already
in the tlb, and known to be not readable.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 117b516739..fd6459b695 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1852,10 +1852,9 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         /*
          * Since we don't support reads and writes to different
          * addresses, and we do have the proper page loaded for
-         * write, this shouldn't ever return.  But just in case,
-         * handle via stop-the-world.
+         * write, this shouldn't ever return.
          */
-        goto stop_the_world;
+        g_assert_not_reached();
     }
     /* Collect tlb flags for read. */
     tlb_addr |= tlbe->addr_read;
-- 
2.43.0


