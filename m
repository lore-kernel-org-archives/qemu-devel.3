Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6CAD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3SY-0005Og-Mh; Sun, 11 Jan 2026 16:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SX-0005Nw-1a
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:53 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SV-0003tE-CP
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:52 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a0d06ffa2aso42935845ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168730; x=1768773530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVaAl+5IUsLS+7adpLV4oBcC5fg9pMBam+ikbK+jV9M=;
 b=WiIgFczC6yujg2wIm8m+Y0L5f55CxThthtsXdiGN7awQlW0lr2XqDaU1QDhq0hbqQj
 g7nu+hsgA9hSFSK3dPyZubhod4tl/oSZxUyO1uNckK5w6ulsfyYIEbTb9hy3YOXjf4AA
 /x7bPHiVnBdFUMBiyN8lIHq9CtLLA7dGO7Toh9JHQ4v5PHfCb1LlDi7pDMUFydIkMiVW
 wAxqmUamUT7x25zIpENOstI5OXpdRhqvvku07SAxDEXLkOXqn8EUsRvUc+wly8q1hgnU
 NsW20tQSQrsXFG2mdXM9tNXj5nUQtS/y6vLb4MRz1LmsfjD6EXQwEm8a3PansGE3dnYt
 nVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168730; x=1768773530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GVaAl+5IUsLS+7adpLV4oBcC5fg9pMBam+ikbK+jV9M=;
 b=IhvGathdFMXBqsgWQ3Fyuok9ZCDTyXLbIlW0x2dc4tvy6TNGNG7LMjuzaHWi+B95GL
 dVp+Ge9DtKgWMUBRE8vSv8qMVq3AffE1BlkxQkMu49ye/cuqLUR1YN/XaQyw4hMmaqw7
 dzqAZRh2LxGVu9ZNj/+FqKs4/8mCsHRx+uPHhVnjFC2xMlE2dFgI78sihbw7FTJ9MWok
 jd454R7+NxhagnL28QuJFpWMm0EL+DyE+xcbcei8hdpa4oZ0syzfBZ73Tn/Rv/Eo80ys
 91ECskHsfENvk0YImAyWORtvI5xJSFYpk3cFyIzcudN9HwA89qzUmJSNLB/zyW93BK9V
 76Wg==
X-Gm-Message-State: AOJu0Yx9rtvCREmf2Iurr/09qEQM3mtXr+vKYCTJvLjLTY0Fwk0efS6p
 WRfctqot80n9p776saeYd+bTu3YOgnIlXqX9VABumw7D79o4gleqsFbuBv0qgVMzSULC3wENBWJ
 o7+RPwcY=
X-Gm-Gg: AY/fxX7uUDpwCmj2eyln7J8f6ZE5BhzGnn6m9NehzNRJYwfxFiA0fgsoIlNEVwEm1i/
 GJWuAUehQi1Ng3tx6Bed7gcLeOgd6Xai7XIXlnSvUcLHCcJWXtqp11jyRITrhyEOEbmpTHN29l8
 c/mhcH/BLGncRq5BaxAcLeB5lM2JU6kvMp4FXB6AlvUp54kCY8ikqFU1rbQFYKMGSZ46MzpWOe9
 +2tprruHNI8UZxZJq9DsTa03eoUvjWhyngDyN2ObZ5/Fb73DhNy9fuxDTxKDttfMVL1tK9jT9hR
 2oj2Nmze/KfsJls6iQquEINyHFd92E0+6pqx6xYiGFej6uZLxBc2nlDufC8evnkYLARJYv0hIrf
 OoOW/Y2pwaach8DJfTCdOr/QLUhaHxF4JktoxlzWMqfavARbliMmAtZE/lgQldKfPhmm/iyqYtP
 t/QwETnnmUDwgV14g=
X-Google-Smtp-Source: AGHT+IF7hStAS3u2JSfmTtsIL9eDbFwp1Lsc2e+e5g29O9a6FM6oX+flxICbzr1AtHn/2WyOoBZ/uQ==
X-Received: by 2002:a17:903:b48:b0:2a0:b02b:210c with SMTP id
 d9443c01a7336-2a3ee4135a7mr155016435ad.1.1768168729560; 
 Sun, 11 Jan 2026 13:58:49 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Lugg <mlugg@mlugg.co.uk>
Subject: [PULL 09/13] linux-user: fix reserved_va page leak in do_munmap
Date: Mon, 12 Jan 2026 08:58:14 +1100
Message-ID: <20260111215819.569209-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Matthew Lugg <mlugg@mlugg.co.uk>

The old logic had an off-by-one bug. For instance, assuming 4k pages on
host and guest, if 'len' is '4097' (indicating to unmap 2 pages), then
'last = start + 4096', so 'real_last = start + 4095', so ultimately
'real_len = 4096'. I do not believe this could cause any observable bugs
in guests, because `target_munmap` page-aligns the length it passes in.
However, calls to this function in `target_mremap` do not page-align the
length, so those calls could "drop" pages, leading to a part of the
reserved region becoming unmapped. At worst, a host allocation could get
mapped into that hole, then clobbered by a new guest mapping.

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251117170954.31451-4-mlugg@mlugg.co.uk>
---
 linux-user/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 6163f1a0d1..4bcfaf7894 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1029,9 +1029,9 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
     void *host_start;
     int prot;
 
-    last = start + len - 1;
+    last = ROUND_UP(start + len, TARGET_PAGE_SIZE) - 1;
     real_start = start & -host_page_size;
-    real_last = ROUND_UP(last, host_page_size) - 1;
+    real_last = ROUND_UP(last + 1, host_page_size) - 1;
 
     /*
      * If guest pages remain on the first or last host pages,
-- 
2.43.0


