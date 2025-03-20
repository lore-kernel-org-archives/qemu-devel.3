Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F3FC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvF0C-00079B-QR; Thu, 20 Mar 2025 08:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvF0A-00077c-GN; Thu, 20 Mar 2025 08:27:58 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvF04-00081K-W2; Thu, 20 Mar 2025 08:27:58 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso10587365ad.1; 
 Thu, 20 Mar 2025 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742473668; x=1743078468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8GIxHSSMgptgJX4WGjpNP3O9KJzROFOMOVwOmjVspaY=;
 b=BJ+CVqZuylzR6bI+CRqCCkYhSkVUF2O5jGyiETB3XHX5CAUWIRXy/8bTZqYU4nkS8P
 LJLcbJLSzS9jHbYDVIvWLVQiGF9NSXtoh7GCKi9cXLAu4Tx2pw5HQTx/ASVZYvjxpGIL
 8tA0CDqF22nTezkFkMreqj62k5OP1oVz/jdWIrvSvX9VhfADbzeLZ1i8WWeddz2zrJ8i
 7eiwpe9o6ERV5ijxLID3RWAizp8JuCqA9Ebd+FE3nWV9W7JOovfCN9ARc70oGspATLIp
 qclLfw/tg4aqDwgV1CRy5XxFTe4Tzky8YUUsw5oh0RT3mEQDfv3d4liCrze11CClj9OT
 rnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742473668; x=1743078468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8GIxHSSMgptgJX4WGjpNP3O9KJzROFOMOVwOmjVspaY=;
 b=gnA7ypn9RSUfWuf+JXJTckqMQ34t5QWAyEPJk02Bg+tT5x0hOUxWeOw2/hY4NzM5J0
 wPyBR8f/TWQzUpdl1xBf8++gy8A2pd1z/JATegONRO3ufDCHnpA9oaGRif+Wa4htYzkm
 imm//WPzAIgZdGB4yJceBb7Hlm0S6G8pycUzp9T+sRYr3dj1dd+lFY/fjgp0EZ9e/6B+
 e8Dzwy841lK7furQE7hWKgmqUD8img3JJt3KjVfKu0foEgr0TUZzCAiB4ipWcjkwUFpE
 zjte9PJB2cf1ekmC/ojkqvkGYPn7VLU0xnLa0jZHVyzq2y9hfKd9APr84fALn6YIFXw8
 vmYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6LNl7cyaGvwbg3Cv7G4SuuvvvUBXOHDGhN0JTQ1at1Y2y+Ey0u5p2JW97+6lDYDll8wgWuwsXhQ==@nongnu.org
X-Gm-Message-State: AOJu0Ywr8jqc9yb806Y9PU8nPY7aF5iLQybdQWpAuz/9NCSE+ypJ/2BT
 QHl1kcILKYrZmPum3UYTsuAA/you7WRHlH9VdI/GUy/yLvOGRv5l4kcxnQ==
X-Gm-Gg: ASbGncsgzh/A91/G1DnifFMoFEEeC71zuLcV6TH6ByirexQeFZzu3Umy8uN6CHYC092
 O5eYw+HvkkGGb/frjoPYqNjKgGTJciVfclzsUj4mVyIN1stqE3/tLuk6MGMCgvbMWU+KyXOtkdU
 dGauyG62+mZwgKPpgekFqbRUgSAQiznW4keNH6dCtoSVSbs16PQ+bY4bSI5Zz96ljjrNrDx4WPO
 VwoEKU/uVzR9P81xfhXqekVOs7hvVbNiGcavB+PTIdC8JJe2a5hVXytfaCdQhVIppwiAnNOk/DA
 M77ECf8ZmXbckBCYz2C9w7QiL61XINy7/r1dU///Mj/Hfq3J4g==
X-Google-Smtp-Source: AGHT+IHLjlJ1UyzI5n3W9KywKFSZerT8BkEH7oKaRIOqhw2+09EtLtBbMyrJ6otrT9vF1BsKC/Up6g==
X-Received: by 2002:a17:902:da8c:b0:21f:6dcf:fd2b with SMTP id
 d9443c01a7336-2265e67f76dmr40015105ad.1.1742473668361; 
 Thu, 20 Mar 2025 05:27:48 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbca45sm133489225ad.166.2025.03.20.05.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 05:27:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 "Author: Roman Kapl" <rka@sysgo.com>
Subject: [PATCH] target/ppc: Fix e200 duplicate SPRs
Date: Thu, 20 Mar 2025 22:27:41 +1000
Message-ID: <20250320122741.109111-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

DSRR0/1 registers are in the BookE ISA not e200 specific, so
remove the duplicate e200 register definitions.

Cc: Author: Roman Kapl <rka@sysgo.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2768
Fixes: 0e3bf4890906 ("ppc: add DBCR based debugging")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8b590e7f17c..7decc09aec8 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2744,14 +2744,6 @@ static void init_proc_e200(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000); /* TOFIX */
-    spr_register(env, SPR_BOOKE_DSRR0, "DSRR0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_BOOKE_DSRR1, "DSRR1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
 
     init_tlbs_emb(env);
     init_excp_e200(env, 0xFFFF0000UL);
-- 
2.47.1


