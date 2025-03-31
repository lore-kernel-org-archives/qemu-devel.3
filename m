Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EDCC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDsX-0008Ci-Jr; Mon, 31 Mar 2025 08:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzDsM-000896-K3; Mon, 31 Mar 2025 08:04:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzDsH-0002kK-3Q; Mon, 31 Mar 2025 08:04:19 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22435603572so81264095ad.1; 
 Mon, 31 Mar 2025 05:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743422654; x=1744027454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qtffgwyx0AwV3qpAIbOBPENMavt/bbk2jp2VaktYe+k=;
 b=a7i6Q9gGAECgP9YUTJsm4Of7EKIiwlYZRnmyV201kH98+nEVCkuQiY4yzo5E+J9DC3
 E4q6hIqwj1lmNcI7qfJSi2lwCHwmwCSULyLAZGQhqWY5yqCEe4pRY5Jaw6wJqtnW6cd5
 LY13S1eMQsOOGoRv68LGbrX6bp/nfYUIfUmqlnYjC58JnAStxR1+5B4SBJ5691Kpbdri
 LERTKeOvMe+cg3HN1T75VZMZLcpFbVCW4FTs5ZtXDZ3QpQBS/1Cd0adm7XwqoHTMbvWM
 CH5Zp7lztFey3ZQjotEyelJKkNu7NRE1v3WvYmD7gbvCKggnscAo6TGDMfHbms+IpD+s
 eteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743422654; x=1744027454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qtffgwyx0AwV3qpAIbOBPENMavt/bbk2jp2VaktYe+k=;
 b=fs1eZ0ZqKfb7+1/18WRTQbB4pMjXhz/OYchpdU2o0I/UcUboq9F6WHCehUF4bpW1Cu
 bYARTpOHQ+nwU7H5i4aFgJQPxWCFE1r1mitF056gtIDa+CrvuRYIQhChWrUcUSGbeFws
 njGLVPjl9wHGgplofWjdni7VjHyjEUj/7Li/Dku5KQXSIV18sShUjiDT/SS7Zc9p0yX+
 /IpkLiPoXypZ3/b8D4XGkEw0n0JxJaMiCrhsR9l+YnRUytwQERK/bHznz8zxEjyC8KpO
 4dkwKUWScdQwX5hiosLBlJkIYJrpPmqiH7cPJkNimG9XO3JG9ep/PquHyqy0+m3ihvlE
 q6tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9JZn1M4MyGqv4Z1QMPF9WZIR78EaVJdBxzUyWHC3Iqwl6hwZE/by+TFodDya7zGFjlNOKXEcLanmv@nongnu.org,
 AJvYcCXHH473/EB69Mwmi/ZBvGluh5YHhHn3VZh/lqejXU7S80JVD/ARW0MB/ecYo2WiOyWksZ91TUz2UvjvvoA=@nongnu.org
X-Gm-Message-State: AOJu0YwjKMGd3XZzLCP7KZO8VJNgNsGSchbUopk7Vi7wf1l7PfIM4aYM
 0H882pu9wrAJaGXyuX0dC+SFcSNbt1uZ146AIY2+GMJPIiGlvmqAMkBu5Q==
X-Gm-Gg: ASbGncscXyY2dgWhSP0tAAmhKex1vUuvwpUvBgotZaZjlQfE5g/Q6JQi5Oae21rKx0G
 pGR9brSLzsUbdTqEfNItfpv1dJXOaYRayFzt9W07b0A+wdK8cYsSxSHng1wuPNc74P23kKhey1T
 er3HiS+0vcespQ7HLah0ydo7dcmJdtxjNFACbDzW2z4NgcD7AV9Zj+Sa4ly0on2Vcj3HAztZ/wi
 2FHq8slAr0gzsQZXEmLsNYs0APMWsGwsfKlANeJJqRHOmDKuFkZulKWrGqxhZOiVke/6meXjzS8
 Wgkq3mCVudF+jDEBFMWs7npjZJwUaZxJwu5jsU9oc7GuX6yBFRm3DNr87Stv
X-Google-Smtp-Source: AGHT+IGAl1tfKuSycwFXbrgQHHGkWHZD5Fb+rCUSCQTNeybRYMcquuPLtbgnF45OX8PbAREogepEsQ==
X-Received: by 2002:a17:903:1a07:b0:223:37b8:c213 with SMTP id
 d9443c01a7336-2292fa07306mr127974935ad.52.1743422654242; 
 Mon, 31 Mar 2025 05:04:14 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eedfde5sm67526105ad.78.2025.03.31.05.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:04:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH 2/2] target/ppc: Fix SPRC/SPRD SPRs for P9/10
Date: Mon, 31 Mar 2025 22:03:56 +1000
Message-ID: <20250331120357.584561-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331120357.584561-1-npiggin@gmail.com>
References: <20250331120357.584561-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

Commit 60d30cff847 ("target/ppc: Move SPR indirect registers into
PnvCore") was mismerged and moved the SPRs to power8-only, instead
of power9/10-only.

Fixes: 60d30cff847 ("target/ppc: Move SPR indirect registers into PnvCore")
Cc: qemu-stable@nongnu.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7decc09aec8..f81cb680fc3 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5801,6 +5801,18 @@ static void register_power9_book4_sprs(CPUPPCState *env)
                  &spr_read_generic, &spr_write_generic,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
+
+    /* SPRC/SPRD exist in earlier CPUs but only tested on POWER9/10 */
+    spr_register_hv(env, SPR_POWER_SPRC, "SPRC",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_sprc,
+                 0x00000000);
+    spr_register_hv(env, SPR_POWER_SPRD, "SPRD",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_sprd, &spr_write_sprd,
+                 0x00000000);
 #endif
 }
 
@@ -5822,17 +5834,6 @@ static void register_power8_book4_sprs(CPUPPCState *env)
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_WORT, 0);
-    /* SPRC/SPRD exist in earlier CPUs but only tested on POWER9/10 */
-    spr_register_hv(env, SPR_POWER_SPRC, "SPRC",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_sprc,
-                 0x00000000);
-    spr_register_hv(env, SPR_POWER_SPRD, "SPRD",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_sprd, &spr_write_sprd,
-                 0x00000000);
 #endif
 }
 
-- 
2.47.1


