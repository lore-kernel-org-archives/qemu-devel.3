Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F6CC5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtCBJ-0005xQ-CS; Sun, 09 Aug 2026 18:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBG-0005vU-T7
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:46 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBF-00084j-Cu
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:46 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso1642234a91.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786315184; x=1786919984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0lRDNSDUDQZKTjH9ncofcENwlBstnuafbn8Teum35fE=;
 b=D+bQk6HYbx0iEc6MXp08aWl0/TjbyfP93CaIU8wdTHRdbZ+hJTjNUcHE9h1QTNfGRs
 ipXXSmb4RMeQgTcB+XttUPLhxHm0io20WB51skZAGKdbGbtgbQLqDMhKUhZmQkRczXcm
 6opbfCva6joKzqEy55Bjh6SK/KZx75KquDaC/KGhBDDtPerDverGMCm9unN0Qbwa/nD/
 ljTgC9jgp8i7Z3QPL6G18Qzt11soC5no5euznXn+ga+GwXNOfFmyNUwrvADWfDYRjcpJ
 8frkP5WmNyVc4qEEoy5k0XBOMX6ixeHQ6l0kZFwZuO/EoiCY2UifaHc6HaMBaRjpwBsx
 E2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315184; x=1786919984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0lRDNSDUDQZKTjH9ncofcENwlBstnuafbn8Teum35fE=;
 b=sSyEgyfDv/No6Jye9gplJmnLyVve8AyvEBFUiS13d6kG+dMWFjHWqV3+D2Wj+nyV3k
 4b9bH0u4jew7byb5y2VLt0Az9SovIarHddtBnNjXa/8pAqgmYy2RpX/Fr4euZfgNbykr
 gNO0zrnI7RbfgPiMmEBLAX7xFhCBH8L3DSZ4v/O6bOZPVjqS1jLZgpcX/sf3OV1sZqUK
 jDukw+nnKTr+xGfDNAoVnoVMS553pTTI4bF4ztiscW0/0h638gJdNiJxurMBiAEgsQu/
 10vPv4ZMdcyyqXSQx5/iTLnjFRiKtuoTCQbfN+mMumUB2SrNQ7MEflqwr0cAGXGdeY51
 ohTw==
X-Gm-Message-State: AOJu0YwFKWy+yYVZx6p8VXZb9DR/aRQF/qWSU60b1gY/mfaN9GMMvJqk
 3vDJg5UUyJUV2sAN/k91vaenTrzyT8tYAXD5JVEuXtRWdPb33o8qg4oMNNZbkS/Rr+lVnwlVv8N
 4Ra/H
X-Gm-Gg: AR+sD11OnvcFI9F25/BPSt1Vm1jnb4xpGf1t4tDXq7sqH8TYzGk3TayyjDM0aA+P1hv
 JsDZFcF8mV/AcqJdIOQACqpejxPSNa4eTxtxYFdKpjRYz/K3WFD+iU7konQJVFjIXI/9MEXNCxi
 o98E8VII1DV+YNo49vgXXbTTPEZrHcYYDsrhmHmSXSACIVVoqNk7W9pIChs65NaBH1AgU2cX79i
 5jiBGb/LbG2xIGmBhAu7u7SoUXefPQuu1ElWGxJcQl60nHiWCZU0NDpW3F55TA/jMAtIjYdbcUH
 QFUxa9DKRIeoNWsfQcVX6C80mrtmbJW8NnTHy3d3elyAsph1t6EJX40Y+vIp3Ept2dQc+o/oc9H
 2wXvK7AEazAccG7nzrcYsCTd333GX+l8ReYvM6mPMoT/xewMkI7SLsf6IRZ4391SCK53gGAuplm
 YOxFi2thnK/+crAYCGHk/AB+BugZMzQSKSj6ons752Qmx72g9+X7G4eyHC97JCiznQAOlSUYE4G
 kidS2f97Pwy+hfdUf+n
X-Received: by 2002:a17:90b:2788:b0:38e:64b0:8bce with SMTP id
 98e67ed59e1d1-39262309a8bmr20357489a91.20.1786315183785; 
 Sun, 09 Aug 2026 15:39:43 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1573defsm4264430a91.1.2026.08.09.15.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:39:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 48/56] disas/riscv: Move rv_op_illegal to riscv.c
Date: Sun,  9 Aug 2026 15:35:37 -0700
Message-ID: <20260809223545.730664-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

illegal is no longer used in other files.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h | 4 ----
 disas/riscv.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 241dd47d7f..5ac8c41616 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -200,10 +200,6 @@ typedef struct {
     uint8_t   rlist;
 } rv_decode;
 
-enum {
-    rv_op_illegal = 0
-};
-
 /* instruction formats */
 
 #define rv_fmt_none                   "O\t"
diff --git a/disas/riscv.c b/disas/riscv.c
index 4141741d79..f0b3bc6be7 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -29,7 +29,7 @@
 #include "disas/riscv-xlrbr.h"
 
 typedef enum {
-    /* 0 is reserved for rv_op_illegal. */
+    rv_op_illegal = 0,
     rv_op_lui = 1,
     rv_op_auipc = 2,
     rv_op_jal = 3,
-- 
2.43.0


