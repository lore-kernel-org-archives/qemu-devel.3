Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A268EE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagzF-0001lF-G4; Tue, 30 Dec 2025 16:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagz3-0001Yn-Dm
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:27 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagz0-0002fk-Qq
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:25 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so78973515e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129018; x=1767733818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L50V/EzCjudz2Uvy5oJglYhqNvb4wYscqaxHo/WQGxg=;
 b=JlyII0pLPWp3dTevpaR7Wy5EGZXi3QDSeFB57fPcc2cBYeIopjWlx8mFu2s6ydnTDP
 hwiVNQ9p+ZLTFmOllD4FdphyXZSZA8MHcxMbvBqfIeixBe+4M8jvjfDkf/c+uch52KdG
 dPREM9uV95+0tcFyrGuqy7nr3LzJap3WiD69wU41Ka19koU0wId6qsDl70Oh24ejgTBo
 bzR9dlWNWfKuKVZty7lPsCAHgYdh3pzSDzV1n1u5drXWC6NV6I7HJ4fAy8ZVSGokfS+B
 PGxJ0175D+vutNpx9S8sbQxmaitsX1fLuF0jHsE7JLmsBQscBCbiJdGITmjNZUDz4xLY
 Xh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129018; x=1767733818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L50V/EzCjudz2Uvy5oJglYhqNvb4wYscqaxHo/WQGxg=;
 b=FEqEwDY0YUHpsTYZQoYoMFqp4CAZyuGL/IPplRNGZX/hVP0P5DYTFgJRxBKbLGEHRx
 vE0o7y55UstagEHhbAsQ50uQqygXB1VNc7kRB/qpAqydQMsF/XXNg/TzJnv15JTLPE1u
 FnuV0o8qOfxSmoaz9n0GVdxy2wQWLoINu99FG+LCEbgK1QUw0nK4nG2r6/PDVhx81PnJ
 4L2PHtQmLjkmXX4H17H6g0MKYt8UPaR+MzEo6QhU39DobVD9i8bkPMw3nymMXffTEzKT
 K76kFzCsJOM653LosqK586AUz0y4dKrTLpsBbi/uMVPs+8sK/wCE0DygkOQVR22k0yyD
 u3fg==
X-Gm-Message-State: AOJu0YzZob9pRm49nv4H01hYxhcx1zZHtIkUPlWLmKUQ2zIpETHCuV8P
 PHmcvP2mDmsZ+bmaDCMHYpOmcuyA5Ls6nFqs4+OybCnb4l5g4Jlj47FiFzfHyt51VYc1LOV+qHa
 fnRN3qU8=
X-Gm-Gg: AY/fxX7KJjt/scIljS6Wx+o9oYHaX4RUvu3xPa4AtjOCGevgM6xFSyjCBCUE7tiiAxv
 xlFMExo5vhi9dJNh41jyNb+uqFManCwoN9l0sWGqRu/dItC8QjEKsZ1Ono4pCb7hHk5NHQCWXeE
 Se6cuXcnB8xO96913wQmjNBq+KXLlnEi4NK7vToE0W1+Ktj7TXULl6tmHGhlXoyknAS5+qkcNiq
 hZprs6udF7NYyF5nGAbzKswlUDQbOa6pV0l2RA5/uiMJbH5JPrwUkoeKFMMQuL9o/P5PSm3/gox
 OoxNrhlY0P/WU1s2Ryv1hWinkIyZOl6noAWO8TLhSDF04Q4dyAWAFzT1wt91Sfja3elXSQYaLFI
 5abPGnBICHU7Y5NlJGOFv8vyARaXVqH3BQQNRqfGwCRWbiVFkXhGFIV6892fWhkly/0tFaLH+3j
 NZ8MSvr9KlyxDKfYx1HStFPVHb0UKQsxepHcp5Rfn3CO8gTq7hMizs/9LrBFtoyLvg7pwL4l4=
X-Google-Smtp-Source: AGHT+IHs90/+ssDgsmBL+qh/7YJDd7RoVqso1/aK2jBXtrxx0En8x67lERTxV9X6aRtisgJs3lJMGw==
X-Received: by 2002:adf:b605:0:b0:432:7d2a:2be4 with SMTP id
 ffacd0b85a97d-4327d2a2d3dmr19266331f8f.60.1767129017858; 
 Tue, 30 Dec 2025 13:10:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1b1sm69761949f8f.3.2025.12.30.13.10.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:10:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/34] target/sparc: Update MMU page table using stl_phys()
Date: Tue, 30 Dec 2025 22:07:43 +0100
Message-ID: <20251230210757.13803-22-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

stl_phys_notdirty() is supposed to do an optimized CODE
path store. Here we update the page table via the DATA
path, so can use the normal stl_phys() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224151351.86733-3-philmd@linaro.org>
---
 target/sparc/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 217580a4d8c..46bf500ea83 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -189,7 +189,7 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
         if (is_dirty) {
             pde |= PG_MODIFIED_MASK;
         }
-        stl_phys_notdirty(cs->as, pde_ptr, pde);
+        stl_phys(cs->as, pde_ptr, pde);
     }
 
     /* the page can be put in the TLB */
-- 
2.52.0


