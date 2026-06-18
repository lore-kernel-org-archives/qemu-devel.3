Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDBBCD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIqM-0003yK-01; Thu, 18 Jun 2026 15:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq6-0003tl-CU
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:50 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq2-0007yB-E9
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2c6bdb8a8bdso8665885ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812545; x=1782417345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmlZevgFhXIJJdsn/GrE/B6w1KsZRwMA3LkvTnWXOzc=;
 b=CWwhrWqk21RAPCHQpjBtYLI23fzWmWUC0rrcCp/pq+b/X9qc3elbJZVU/GzGk11xSm
 OVdlbFn+gL6xJFwg7OH1lSWuMUAQjgP4XqYO7adQQFKjI7Mmpcm7nyvDXBVtjH/UpOLE
 Uooe4LiuZJtMGvhao0DW0XCUENOQt+A/3xBTiHFdLC3bFXMY8R+1AxRPvsP71WXHv/PZ
 SZyPj7oXc0OaqAT38byeg9l62MmsoMTHk5bZ/diVCsnaSCfnDA0H+LLVUHh+zgHu/7CV
 pVvv6jQhodbJf672XM9abU4O/2781k+ly6jou3qqxmR3/HqHwpxKzqPzdN6YtRR5u+0n
 2+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812545; x=1782417345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tmlZevgFhXIJJdsn/GrE/B6w1KsZRwMA3LkvTnWXOzc=;
 b=nLoU6OHTCApCn/U3KrqF26xGigNh/otqwfUbFE6iXVZE+5G3Px8oZCI19bPe3U3Xi2
 smptLPH2ug+o+lVBIuqWTgBylxbU3ew2HLTbi+4DaVF5bHvTuOh5bx/qYHfFSXFh4bkG
 GGjFJRBSh5XiyAhMnwcx1I60dCFSG9i+yeQaDfpYCIXyQ3YuzuNEGzLA3i5XsFChAFoe
 S2LCQFNcbT1piyJIZdLolOO+Qgv5lc2XBOzSEGmezR5HLxe4WjPiwfhLV51VPylIABvQ
 sQHAwuN5Vv3+iVBLtphaa+SKJove0ve4zDDxNuzFZEPvhdjicMv/aF4VesgGJMCuZqQH
 JppA==
X-Gm-Message-State: AOJu0YyiPpPdnluHXyIaAE+rvMXA1aurhGlc0nKPknCZkOyZXmo6xPKR
 bm6sF6EVVNXiQZI3FqMThOQwjp+R6OIdfGiKqKJIrU/NzpukcnipkVO5f5mPE9o/hSg6r5Wd9lP
 uTGQ9
X-Gm-Gg: AfdE7cl9RDL/PkjJCHYgM58IxxgfnqWOsth6bDOAE0ozMY01e8dhDbAqUxJYQV6g4Gb
 PfV1AJ3xVHMsWrK9PLZQuetSAQ5wwHcbef/qKVsRUHmqH+ofLZA0ryPPK4QLU2wKMPvr/0msyZ0
 qu//XxU6N+rNyMC3YE04xaqPIlIZZzObm/Tmfy9yRUbLKEJYKyKuOfaPQTNbvwYdOHCfGEmQkjd
 +e2b2Z04KFeAHjX0jgD6ulh9ejJV/gvJYVOkBJJKGZ4sD6H5vSStHaX8PGPrlH+o69XJbTn8TOv
 NSd598vDSZu3RIBeU1xNRfzYgQA24qGd1ex0hHFGlSAGl8GqfCU3Pbf3QdPjHEaB+LGR5H5Hcll
 pTExCsiBpNZwca3cp+8M6WsT3rwZZ8pQYVDkzDIs7YB8K3AYZfyd0vm5Dp076WfpcAD3Th4HPyK
 TSMDxREo3l6TvxSwb3kZvot1hnWdadbpM+eXSBD6LBX1x92vdiBA==
X-Received: by 2002:a17:903:90d:b0:2c6:b3dc:b82a with SMTP id
 d9443c01a7336-2c718fe4c07mr6635575ad.24.1781812544965; 
 Thu, 18 Jun 2026 12:55:44 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205732965ad.55.2026.06.18.12.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:55:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/13] include/user/guest-host: Include missing cpu.h
Date: Thu, 18 Jun 2026 12:55:14 -0700
Message-ID: <20260618195520.589907-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618195520.589907-1-richard.henderson@linaro.org>
References: <20260618195520.589907-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This file dereferences CPUState without including the required header.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/guest-host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/user/guest-host.h b/include/user/guest-host.h
index ef83ad8a18..506efc097e 100644
--- a/include/user/guest-host.h
+++ b/include/user/guest-host.h
@@ -10,6 +10,7 @@
 
 #include "exec/vaddr.h"
 #include "user/guest-base.h"
+#include "hw/core/cpu.h"
 #include "accel/tcg/cpu-ops.h"
 
 /*
-- 
2.43.0


