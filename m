Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EE6C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvVt-0007cj-Rw; Wed, 02 Jul 2025 07:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvVs-0007bx-DA; Wed, 02 Jul 2025 07:20:28 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvVm-0002NQ-Aq; Wed, 02 Jul 2025 07:20:28 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-235a3dd4f0dso41655965ad.0; 
 Wed, 02 Jul 2025 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751455220; x=1752060020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGagJ9raKAPmcJyXmW93lh9+2lhFg+AHjUBxVVIGA34=;
 b=Z+JauEeGTzeFBNG2rT5TvIPJ89NwgrvDhYZ5puHWWQ5pjNbR+EcVjrXE2oHn+50PEk
 usRVaRYgDN4VsLJWBLQi6ZeB7Zs4qDaA9MZxuanZUIpvyev0BAKJS7EU1CHCWQq0Ubcw
 dK5NQ+KbIiwMpRwpbyOo1qeYOISjUaq817UFMl82DubRok1G39kvzGNvZk44451blGXT
 i3VnyrQhgdBf9TosEsIjQcK2bsrA5jY+38+hb5EVP+TbaF7ZKbbnvfrSCr1085ejFJkm
 mNQaXCg99Bh1N3tb6omaJfv4SYc+jqpr+vm0rZCUpml62X0dWeAh10HNfHy0VQB6NyAf
 UhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751455220; x=1752060020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGagJ9raKAPmcJyXmW93lh9+2lhFg+AHjUBxVVIGA34=;
 b=YZ6MSOrm+H1QAMaXWMvMWZ1CDimhT0hTJJq4fEs2nr7DD+sF3a1+TKlgTgrGzMrEec
 vVaYhBCA3t3cSm/0AG4m3a++B6lqS3a2eabk5sxoc9bnADnpTFZwp/VYfAED1c/xWZ6X
 cvh8dGaMLLw80rLPSJZNZX2EzstDMbmp9y3+VJ1/+LnR7E8CY/A0Mhikqu5yby915hFU
 OT7boPXXiRXwt5mGTPrz+sGH+fl6kBVN9FR6IvpxqrAlGuHR57p9Gq0lhAFEupuLKAob
 6UtXlQU1FC4li7Xo+3BVpzOLEVdYzHa8g+iPjFhJ/RLa4GK1z/11BCboSYapgxx3QYJO
 GatQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwdR13zOcZRj4EQA7SFZwjkihWvYAl0rYpXjs1OXbkBAshWIbgCOrbuIiKx7QVpi+/pt4HvGbC8Q==@nongnu.org
X-Gm-Message-State: AOJu0YzSvzS3wAYL5maoUTdzOVQ03WNjNLBxKnD1ofrvP0DYKON5iPAJ
 jeUf9ui/OExjYofXqpnLJp29L2ccOKHc4f3MWlGE4WQiSMXWKKDnXUNv1OEk0rVpvCQ=
X-Gm-Gg: ASbGncs5KVfwu68MO0JN4jz6lhY5/fofitQlRvp4tOVi/XF55qqKkmFAIQCd//hd2B1
 G4pVAo7eCGV1HVwh/wJqNWKldGlfJUcMtlHZbKwEivPPszvKPTO0RfnGBHJTCGvqxk6BGKVw0QM
 fNKjncUG70SMABnXGioBZicP2UrxZezLcmT4cA6/up7hBXHcumuEuZXNr8GsMJYfMTNyjJCjrzw
 105I2NZulO6bvREya+UP6zLqG/XYn3Au8xszYGBRNO1N0tOC7BfIHh66ah7eBnFE4S/RUxXr+rK
 nsDhnDwApCBIYEr8RNaPLakdNy4bnznSg3uHW/EFqrr+/JDELsXav0fAZ8x22BnKEGNuD6BCkQ4
 mH3Vyys+Y0To2AGCrcdYninKpbHekFtgFLxB1F92UhNglxiww6sZyzA==
X-Google-Smtp-Source: AGHT+IEv+yHJX5YAWNBIKiA7PBLl/DQVOObERCF9GEd5iErXg7FG9dJDITor928KsaRt9t2q7ZzHTQ==
X-Received: by 2002:a17:902:fc8d:b0:234:a44c:18d with SMTP id
 d9443c01a7336-23c6e5253d6mr38625505ad.22.1751455219921; 
 Wed, 02 Jul 2025 04:20:19 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23acb3c94b3sm125892915ad.245.2025.07.02.04.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 04:20:19 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v3 05/12] target/arm: Fix VSTR helper store alignment checks
Date: Wed,  2 Jul 2025 20:49:47 +0930
Message-ID: <20250702111954.128563-6-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch adds alignment checks in the store operations in the VSTR
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
---
 target/arm/tcg/mve_helper.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 1db626bb26..9156cb8f9f 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -172,15 +172,17 @@ static void mve_advance_vpt(CPUARMState *env)
         mve_advance_vpt(env);                                           \
     }
 
-#define DO_VSTR(OP, MSIZE, STTYPE, ESIZE, TYPE)                         \
+#define DO_VSTR(OP, MFLAG, MSIZE, STTYPE, ESIZE, TYPE)                  \
     void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
     {                                                                   \
         TYPE *d = vd;                                                   \
         uint16_t mask = mve_element_mask(env);                          \
         unsigned b, e;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
         for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
             if (mask & (1 << b)) {                                      \
-                cpu_##STTYPE##_data_ra(env, addr, d[H##ESIZE(e)], GETPC()); \
+                cpu_##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
             }                                                           \
             addr += MSIZE;                                              \
         }                                                               \
@@ -191,9 +193,9 @@ DO_VLDR(vldrb, MO_UB, 1, uint8_t, ldb, 1, uint8_t)
 DO_VLDR(vldrh, MO_TEUW, 2, uint16_t, ldw, 2, uint16_t)
 DO_VLDR(vldrw, MO_TEUL, 4, uint32_t, ldl, 4, uint32_t)
 
-DO_VSTR(vstrb, 1, stb, 1, uint8_t)
-DO_VSTR(vstrh, 2, stw, 2, uint16_t)
-DO_VSTR(vstrw, 4, stl, 4, uint32_t)
+DO_VSTR(vstrb, MO_UB, 1, stb, 1, uint8_t)
+DO_VSTR(vstrh, MO_TEUW, 2, stw, 2, uint16_t)
+DO_VSTR(vstrw, MO_TEUL, 4, stl, 4, uint32_t)
 
 DO_VLDR(vldrb_sh, MO_UB, 1, int8_t, ldb, 2, int16_t)
 DO_VLDR(vldrb_sw, MO_UB, 1, int8_t, ldb, 4, int32_t)
@@ -202,9 +204,9 @@ DO_VLDR(vldrb_uw, MO_UB, 1, uint8_t, ldb, 4, uint32_t)
 DO_VLDR(vldrh_sw, MO_TEUW, 2, int16_t, ldw, 4, int32_t)
 DO_VLDR(vldrh_uw, MO_TEUW, 2, uint16_t, ldw, 4, uint32_t)
 
-DO_VSTR(vstrb_h, 1, stb, 2, int16_t)
-DO_VSTR(vstrb_w, 1, stb, 4, int32_t)
-DO_VSTR(vstrh_w, 2, stw, 4, int32_t)
+DO_VSTR(vstrb_h, MO_UB, 1, stb, 2, int16_t)
+DO_VSTR(vstrb_w, MO_UB, 1, stb, 4, int32_t)
+DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
 
 #undef DO_VLDR
 #undef DO_VSTR
-- 
2.48.1


