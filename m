Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878D6C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoPZ-0008Vx-GE; Wed, 19 Mar 2025 04:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOr-00082H-Vg
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:43 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOp-0004RG-4v
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:41 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225a28a511eso111789325ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742371417; x=1742976217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GZozLRxbDuwVPT+dECukr5ZKZWvyjcyqsgsCIhcR3E=;
 b=XuPql9n16ZSuHQ0myhj9eAj/vVCaqZde6TsvOdY3hyGaRjzTYPePZeoCsyWtCgA1dM
 lCb8iuNpw4cpmxvzqc5gvEfTnDn2pOJJmXZhKnmugRJkdUVh7y4eABG9BqlDBUf3sUEz
 tKbV2U7X/ud2T4Q7tYzitMneHMO53tvzmmaj6u+wbxuPj6bR6LuI0rL6pj0V5Uhpyn6J
 Kt/zmHgT2rsDxqA7E6cokHej29vsmf+MS3JQrzXh9VJaJ8s4wFZlMM0PIioFe6/qhQbo
 dmnBqyGf/57P3kF/GgYpFHBJNcw9ULAd/pZ++l+cR8ofgtlTqPNjyBDd69/4+UvMmH4H
 wtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742371417; x=1742976217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GZozLRxbDuwVPT+dECukr5ZKZWvyjcyqsgsCIhcR3E=;
 b=YmjYep2EUI0fIOKJMuLZPa5o8WSsIbZwogrBs/tezKUVRcO1KWZDdRbphN3hI/mq6C
 SrbsoBpE8QJGZya6DwU9J5S+LyM5IgtTTENSeMtC8Q6QN5H8zdHHFs4WN6qlhNhGzck/
 EwtPCha5lW8TUQqKqU0bKgDHatSQ3jLkzCLSFUNlx6VkCJwAHnK5p/CnPOnSuA662kJO
 i/6epFwKLXNOcjHt+xuJ171K0bHKdxMhGamUiG3sLeKo+9BcmbBd//FRkCMz5FMGPqZ/
 wx1saFLoYs1ljU/ZxFBewrL+3kAlaDjT77T9lsxLHTpGBo4Xzou/F0MLc2DCwYusknEi
 Ps2g==
X-Gm-Message-State: AOJu0YyukVAn+sI2QL492Q/UZoGYGyKocwYXR7VKlSn0L2TlOF2urD2Q
 7EfJrD2V9dtvdVrm77kL3u7cTuf1R0gomzOcE3LIZtXkV26n9jGXpEjCfA==
X-Gm-Gg: ASbGncu3A7yONudPsjVLz9okZt3yUrc8ltHwAmk7vG96F9HL/Z+7mYqWzx9dWIsAsTv
 ++BHtNYwVktbj7YY1hQiPgCzwXQHpfZHAX9wDVmC+lM0Eq8EHs+uLNVgfR9LzoU9OZvXqKV/EqF
 TnR7QIH4ejCOxobewUJvXK/Z+oznK8w8zJFYvsKkItPZlbew3cYNZUS+yPuh4gqILP9h8/FQsyn
 0KUnALe9p1oDLT7RmI/Ji2P17uiVuiLOXqml9ACV6lKPkrb6TS1MijzWX775dWekXM7M7igsfNX
 KPwgeiKOgUp4tgitAnjdOliwg8THf+Ce3GDVkzdgNFsrU1zMFBLS8tdLV93XKXrhLStTFRJ8mk2
 rS1W5OiBzmM33goB7URO3QnuxdIVXc46W84stIg/zz44y4ZEZeNRGRCmt+LY=
X-Google-Smtp-Source: AGHT+IFbZzDVtHTsEDT9QgzcFVV+kFKqdklPoZeadT3PI+tmzCntb72wHw/9fZXutZ69lQ9G3n5Nfg==
X-Received: by 2002:a17:903:1cc:b0:223:60ce:2451 with SMTP id
 d9443c01a7336-22649a2ee7cmr25429335ad.15.1742371416750; 
 Wed, 19 Mar 2025 01:03:36 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c8dsm107725255ad.156.2025.03.19.01.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 01:03:36 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/10] target/riscv/csr.c: fix OVERFLOW_BEFORE_WIDEN in
 rmw_sctrdepth()
Date: Wed, 19 Mar 2025 18:03:04 +1000
Message-ID: <20250319080308.609520-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319080308.609520-1-alistair.francis@wdc.com>
References: <20250319080308.609520-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Coverity found the following issue:

  >>>     CID 1593156:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
  >>>     Potentially overflowing expression "0x10 << depth" with type
  "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then
  used in a context that expects an expression of type "uint64_t" (64
  bits, unsigned).
  4299             depth = 16 << depth;

Fix it by forcing the expression to be 64 bits wide by using '16ULL'.

Resolves: Coverity CID 1593156
Fixes: c48bd18eae ("target/riscv: Add support for Control Transfer Records extension CSRs.")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250307124602.1905754-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8225e9bb4b..7948188356 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -4302,7 +4302,7 @@ static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
         }
 
         /* Update sctrstatus.WRPTR with a legal value */
-        depth = 16 << depth;
+        depth = 16ULL << depth;
         env->sctrstatus =
             env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
     }
-- 
2.48.1


