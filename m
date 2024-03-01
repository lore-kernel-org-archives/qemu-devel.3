Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8855AC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByS-0005vo-47; Fri, 01 Mar 2024 18:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy1-00055O-9l
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:02 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxu-0004Gw-Sb
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:01 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dbd32cff0bso25498775ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334412; x=1709939212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqsehmdSBpDx4+BqjLPOYj++iC85Ag1++NqdrWinVEc=;
 b=kjN7bXhdBvCQHfZD1myvv61PZ5P3Mms30wp0M3oOLD7oeVrQ+AWo7Pek0FubCM25jN
 QIwydxdHK87RDDJBqsqmNB0rnNllj/PTdnoiGb35FOOL0nG5lPFGguh1QV2uFbGzxAQp
 SoHXH9QoQHtr7kL+1PJoZSGKX+do2FFWu/deeZ6CO/599b1elcWDLM1rgxvDRhJe1iPk
 e+q9mSJY/UnbYhcI2r8l9RzZ6olJ7RKLQovtgtg1H8c9qNlgcH/IkcpGZjGvsDlwuSHD
 eTSJdy9tLd2X4z1O7U9dec6zEuK+wNdcG/7EfYBhKtuFa7t/aByvtw7Gu+mfOw3PfPuF
 FYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334412; x=1709939212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqsehmdSBpDx4+BqjLPOYj++iC85Ag1++NqdrWinVEc=;
 b=rytmZGn5ZiFnjlb7K1YVpJo8jgb0O8h3EfFiNIn2qvMhizyCrpJy3e61/GMfKTdj0i
 7OtlinWEtXp7nEElgSRuuqe5PfDf3y54vB+oXA6roUM1RzyRD6dWLTcnkw0g82RLUQpN
 EilrTKmo4lT87vwIkARDdGKGP1HpMLCL7ENkdsVkMUqUYszJj4oF4oPFBfx5tCv8/Hon
 yOm8pfePLu+E2RUTKizfXwozO03drF2qxXOqQEip2LY+MlJgkodHUtsWttocTwR3+g7S
 BH1JHFh2ablxivMOJjiYc5LXL26HVSkq3m8Jx8IIlWVpY5HXypogahTpXqeqaQ/NeGPB
 gsBA==
X-Gm-Message-State: AOJu0YyFY86z86py4wHQb5yBxAGliqWBuhufPXzhIjLkISt9SHmnGP2t
 ZGYR557X9x6TPN/3pfLYsKJft9NFCv88AzfzTNEfpY5YzhbYEVCqMxRGIiF1rmx7FRE4uTPhvCe
 7
X-Google-Smtp-Source: AGHT+IESjn05V6JS0PsuUxZpfiGLmZsV5mILCIWI/+fHTmvpfBtgUi6lzhXtxp2yCFjhmrBwIF6cqA==
X-Received: by 2002:a17:902:6544:b0:1dc:7890:72d6 with SMTP id
 d4-20020a170902654400b001dc789072d6mr2765881pln.22.1709334412565; 
 Fri, 01 Mar 2024 15:06:52 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 22/60] linux-user/hppa: Simplify init_guest_commpage
Date: Fri,  1 Mar 2024 13:05:41 -1000
Message-Id: <20240301230619.661008-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

If reserved_va, then we have already reserved the entire
guest virtual address space; no need to remap page.
If !reserved_va, then use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-6-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0f135f6b6d..53b61aac77 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1970,16 +1970,20 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 static bool init_guest_commpage(void)
 {
-    void *want = g2h_untagged(LO_COMMPAGE);
-    void *addr = mmap(want, qemu_host_page_size, PROT_NONE,
-                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    /* If reserved_va, then we have already mapped 0 page on the host. */
+    if (!reserved_va) {
+        void *want, *addr;
 
-    if (addr == MAP_FAILED) {
-        perror("Allocating guest commpage");
-        exit(EXIT_FAILURE);
-    }
-    if (addr != want) {
-        return false;
+        want = g2h_untagged(LO_COMMPAGE);
+        addr = mmap(want, TARGET_PAGE_SIZE, PROT_NONE,
+                    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);
+        if (addr == MAP_FAILED) {
+            perror("Allocating guest commpage");
+            exit(EXIT_FAILURE);
+        }
+        if (addr != want) {
+            return false;
+        }
     }
 
     /*
-- 
2.34.1


