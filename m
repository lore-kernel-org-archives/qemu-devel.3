Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C53C54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riiAi-0007VM-8q; Fri, 08 Mar 2024 16:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAd-0007TW-MI
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:28 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAc-0001kt-A6
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:27 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dcafff3c50so18409195ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 13:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709934863; x=1710539663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ifjqeL0ePzjmyJW3x75LZw5Jfwo76HV/4EIwAihNfQ=;
 b=nSpssNZ59kDDkvY4yOszoOE8rF4SWFFpzrkyh8SVMe3vI97rtlHBqjsNOIUJ47sTKx
 c3O6wgUPEo+d1/LGzC/oQ0Rp+vVhJvGEv5ILLGh/Aim0McTyLgu4Ddjp0GuvvOAT76co
 0JWUO6KKnhyydRc6WGibYncRaj5AC6iX2CWjLWlmlRDfWtcrWX/BfqtFNU84581Hyy2w
 ckOrhrb3dtEy7Wa6nIz2jbF0Q3tDAjzPUPpVwusyqSK+//mR+86dKeF+PgbTSgHRmmUe
 w+i/yQFJ9FDCoTpGA2H+xRmGEaAkVj/UO8Dzb3801oozSn9gVb2X0ft/l/iM5x/1M3Pz
 URQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709934863; x=1710539663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ifjqeL0ePzjmyJW3x75LZw5Jfwo76HV/4EIwAihNfQ=;
 b=R3e7ZY6c1OotjJY6K5X1aMLqAbmnVO/qmt1DeZQEv0SGUORizn1+RXNVmxym5uPDcw
 DW8ra2t0YMUCZzI89ZDQ7IRGeSBP9HLUY1BQz8EJpYwf0Optc9rLEilFE6OEPmZOq5Wv
 0VpA1LC8HIOZb4KAJxLna8r1Cze6IZ3CK0CTXGmGc9gXYgHh7e+P0mszzmSn1bBOohPD
 Ni3hHbQaNiYsklLIB7aeLhZE8Mjlrd8bVVAPZa37HRGqt/Y/ewl2tl8NKWQW1rlUenDK
 OPNG1SB4UeBsssJLDpqtCZJVGicwq7i0yrgbfUnjMMZCqwwZlIGa06rQ4xgpF2NntfUl
 4/Bw==
X-Gm-Message-State: AOJu0YzoLgobJUmFVaNAgxWHnUe0fo9SyBeNiXfZc3hzsQmnhXAjTnXf
 05pGJU3GVsUNevMjPxxR3FmkbGtQdQwg8NSV9UtYr2e8m+PctktWDUYG/JFgVqlwYiAUvM9yKcv
 e
X-Google-Smtp-Source: AGHT+IFKH47hPg7SU0qGOs42dip/g9Si0BSONk+OyclQ1EdCKAVq83IoISJeDUC2iSiZLD3r/d1cWA==
X-Received: by 2002:a17:903:246:b0:1dc:efb2:95fe with SMTP id
 j6-20020a170903024600b001dcefb295femr381789plh.48.1709934863233; 
 Fri, 08 Mar 2024 13:54:23 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 d3-20020a170902b70300b001dd66e6ec91sm107702pls.140.2024.03.08.13.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 13:54:22 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 03/10] target/riscv/vector_helper.c: do vstart=0 after
 updating tail
Date: Fri,  8 Mar 2024 18:53:43 -0300
Message-ID: <20240308215402.117405-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308215402.117405-1-dbarboza@ventanamicro.com>
References: <20240308215402.117405-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

vext_vv_rm_1() and vext_vv_rm_2() are setting vstart = 0 before their
respective callers (vext_vv_rm_2 and  vext_vx_rm_2) update the tail
elements.

This is benign now, but we'll convert the tail updates to use
vext_set_tail_elems_1s(), and this function is sensitive to vstart
changes. Do vstart = 0 after vext_set_elems_1s() now to make the
conversion easier.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vector_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index db1d3f77ce..544234c2d8 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1927,7 +1927,6 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
         }
         fn(vd, vs1, vs2, i, env, vxrm);
     }
-    env->vstart = 0;
 }
 
 static inline void
@@ -1962,6 +1961,7 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
     }
     /* set tail elements to 1s */
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
+    env->vstart = 0;
 }
 
 /* generate helpers for fixed point instructions with OPIVV format */
@@ -2052,7 +2052,6 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
         }
         fn(vd, s1, vs2, i, env, vxrm);
     }
-    env->vstart = 0;
 }
 
 static inline void
@@ -2087,6 +2086,7 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
     }
     /* set tail elements to 1s */
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
+    env->vstart = 0;
 }
 
 /* generate helpers for fixed point instructions with OPIVX format */
-- 
2.43.2


