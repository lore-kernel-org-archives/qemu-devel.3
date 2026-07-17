Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E0AC44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkrtj-0001SA-Hl; Fri, 17 Jul 2026 19:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrth-0001Qb-Hg
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:13 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtf-0006wz-5H
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:13 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38df94d4dd8so3595868a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330590; x=1784935390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0XTzqP1IaisVAsyNJ2xKnLKxlyIiY6j16WEFEoC9ZrU=;
 b=oa9ZbTDEAN+yiZv9Szfjf43LT1OWCBve71lURXs30so0gMO+9qWnPvo4inAHapKuWY
 WPJ3Pw9AeSc9+stsIb2BUesSm2aFn5q0Ba3KAiO+Mhb6kh7AOibTIRFqsXMcVe0/C6n+
 sSgAq5woShbidEFVBDr5BW1b1OXbH5niIxADfmK3MjG28bRVq3J6MCxsIIBZPqFc1Zk/
 HQXjXk9adu7X9MhGOAbBWLtINkqc5WyTs8vCiWKxEjalauabGJFrPUcblyxKLvNCp/jr
 8cmb5vYNuVN6XQ4a5HQdvQQ9YjPLzVotBY94cxu3iFSX6llG0XcyxJIjoM3u2RA2FGq9
 6WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330590; x=1784935390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0XTzqP1IaisVAsyNJ2xKnLKxlyIiY6j16WEFEoC9ZrU=;
 b=gLXoIJ1RMZlpx8zzn2NBgNAtlNAMGMQuTuAvAcqHhmRvqlsy01aGt95zVoFzP35zEc
 y4sm0/41BBUzVouoEtIGtGuWNz0pkdYNWT24XKNl5xL0y5bQaYQ5pYsFPtXJDhLZydOO
 WWD8b2Ed24321m6HD1rhKcYsAT4R8L/ua/VEJDUp2Ez3bxgcwkYMRl2fGE3W9tE6OUlF
 gG7IJf1kAqNn1vMmX2e8DdXhnseB5iC2vX871iylq/4ERJD0H50qlxLz8sup0+3M9Xgt
 whzxzl3C1wCVMBLBMBJk3a33EU2QB2bGNodXGooDPEdGm0yFge1qeueL691RGtjxpTJY
 5O/w==
X-Gm-Message-State: AOJu0YxEjD5TGbWPvexuXnMfON+sKHYY4jtPqn7aILKg83rlFtsNYnU4
 5gPYJ7X3RdWABH6FG1tAerJ39G1LNV9rX5ooPmsavoabQUnAdHHuxzmkVMxz57wxdj6GkI/DI+2
 YqZb6
X-Gm-Gg: AfdE7cn7uEvtIZ6XUwK+blgd9eleV2rsymdjjn658PqyNAXoY4KfYiINGFZl0RsMAHk
 5uVZLF3V20ZL4dPZMOK0VXR8JOBUYzRb/tc7KIReVpLQv5BvxJwmEn9v8jK/sKrMIv/0cYkWPtQ
 4pdwLhau3muufR10rLTRI2cnrFUDoT5Xq0IyPKZhwFdYzQwbELLu1r9LdRu+kf+L8h9BqKDq79Z
 7cIlMTYnvStZ1sX/+aP23jNxLp3m2fOeJRxNBwYUVgXw2xSKNuvr3ufQENrjYTYWTalbCJJp2Xx
 q0HcpUqT0PyU6Uf21I9bzbKN4m5lVGvZnwpLsPf2MI+iO9D1y0P/XOhYFFOPHY/WcBCJBMYod2P
 qVG+bqUo7XY/cnFbWggqJGvv+IVf52fhJ6zmNEHYgWpZw8EFwTWUicfin5f5wwn5TmkJLuI7doe
 LI8oRAwEg=
X-Received: by 2002:a17:90b:2e46:b0:38e:2a4:cffc with SMTP id
 98e67ed59e1d1-38e4b507f42mr4855302a91.25.1784330589626; 
 Fri, 17 Jul 2026 16:23:09 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 01/17] include/user/guest-host: Include exec/abi_ptr.h
Date: Fri, 17 Jul 2026 16:22:48 -0700
Message-ID: <20260717232306.378988-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

The COMPILING_PER_TARGET block uses the abi_ptr type
without including the proper header.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/guest-host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/user/guest-host.h b/include/user/guest-host.h
index 506efc097e..f136f81f5d 100644
--- a/include/user/guest-host.h
+++ b/include/user/guest-host.h
@@ -80,6 +80,7 @@ static inline bool guest_range_valid_untagged_vaddr(vaddr start, vaddr len)
 })
 
 #ifdef COMPILING_PER_TARGET
+#include "exec/abi_ptr.h"
 
 /*
  * These functions take the guest virtual address as an abi_ptr.  This
-- 
2.43.0


