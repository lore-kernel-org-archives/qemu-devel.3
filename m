Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4E9C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wunBR-0001pM-Cr; Fri, 14 Aug 2026 04:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wunBM-0001p0-Vv
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 04:22:29 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wunBL-0007c1-HK
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 04:22:28 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so822883a91.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786695745; x=1787300545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OzPTbr5W9I3uHTFntkfjo5xfeIQxbJCZBUMEDG07isQ=;
 b=Po8qtgSiaJuvWGjxMICDUf2RnD2u8UfDrxmd9Zk6VAGWqaJ4ttqVd/b7nP3+aICVhc
 rmTHYXvskv6p19DOGKavXRa2wX27zcx/CBJ9KQlDodXvIe2xt82Y1EgupZ8b89tdC2X5
 1OjCH/FHSorINfhc7vE++2/+g0b5ITkZU1Dx5NPAWZyXpY8fHt2IDOHKCT/Lh4nqYnTC
 3jg6iqGI/6nhvvTrcD54KPTtAFCXG0JSS8rjD8y/h9k+b/JarT2tYPe7JlzMbb8xDrl5
 u18c4fTRartLQ/nej5Ky9UxjZU8qxCnAQzW9tEu1ga8jjsam9jhgaSdNM5i9HJu9g7nx
 OhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786695745; x=1787300545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OzPTbr5W9I3uHTFntkfjo5xfeIQxbJCZBUMEDG07isQ=;
 b=el3t6Qo+Cj0WU0ZCwkScZEQwXzw7LK65VNQCGxdFNpXJ6MXnQKgodV+peaDPy8kfPu
 hd5feC0NOUJwvDtEBfEYBhhmP41VDC951S6Pnz6buQQvFQUT1w2Ro64qdcxiuOPFB4dX
 hTOGtIdtMmK+fZoxOqqTrWK/XEmcuS3JUrGYSIJFQaTS0IucvIiMuqdCyU/VnsodNsW+
 bTi8bEndPM/edZ/Dge3dSNpXF/BSDOMrfWyLfisjmcISIYuwMwSItfL/0sU4inFGzNjS
 cIk8vCgDBPrG4HTHgEID5t49yWCBNErAD5XQsiJYLF5zFTKxlfiA6PMUHQYl0+vpMj81
 roVA==
X-Gm-Message-State: AOJu0YzmoeFGam/1xfX/C+BTJJUrbuC+WZIlJLjEev95ijUDbA8drhvL
 thV8U9H/G9LVjGp6c51tCXC399SMfBqAz6/N/u1C9LfI+14VuiNS0eRP
X-Gm-Gg: AR+sD11OPTJukup3KMkz6l8wEFehuy3rloeFi3nTAO21NLLAKXVSj+yZEpo/7xHt5I6
 1414RatSemKb69TKdGTtjGqQGevkM50NiFeRCNFu/JA/+c191E9fLqhGpalrioj/yyFmfDjiCgm
 9XxClrJrAz99foWkm2v3AOiZc2bQxCme/Lqyk+b0YKA2gvBr+/hgPzocQn2gajtjlNDb3Qrr0Ju
 Cd+MEPHHZhqDCcJExvtFQ92taPX+sB5Kkyr6b49MbVXdA3IfcfvDsJ7fJ+H6fjFxFkplGpAdAma
 DG2E6h7iwGQf9eL9gDmaoaIaHvWGhbgqES2s4K6bwKnI2ggc5Vvu1r2PqDsK6Qn+zjeoe8ZADlr
 T/yu/xNV2LTipjGjQR0/XRwPXUHwn5Lt1pFtMAge8v4YpRZ/aDoaYqZzvt6R6H4djv3j/lX5xMv
 YWfJQYxNUpk/RV13FSYUXEsylHkUpFpPrqtb6B4MIwSX3ljYfseIRKsIpt
X-Received: by 2002:a17:90b:58e5:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-3933caf3a05mr4347580a91.7.1786695745458; 
 Fri, 14 Aug 2026 01:22:25 -0700 (PDT)
Received: from arch ([112.133.246.3]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320d60eb8eesm1829287eec.10.2026.08.14.01.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 01:22:24 -0700 (PDT)
From: Abhigyan Kumar <314abh@gmail.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH] target/riscv: make cbo helpers [ms]envcfg gating in user-mode
Date: Fri, 14 Aug 2026 13:52:17 +0530
Message-ID: <20260814082217.278685-1-314abh@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=314abh@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Current implementation of check_zicbo_envcfg is wrapped in an if-else
macro that eliminates the function during compilation for user-modde.
But, the zicbo spec states that [ms]envcfg gating is to be used.

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4107
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
---
 target/riscv/tcg/op_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index ba3c7da..bc899c4 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -160,6 +160,11 @@ static void check_zicbo_envcfg(CPURISCVState *env, target_ulong envbits,
     if ((env->priv < PRV_S) && !get_field(env->senvcfg, envbits)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
+#else
+    if (!get_field(env->senvcfg, envbits) ||
+        !get_field(env->menvcfg, envbits)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    }
 #endif
 }
 
-- 
2.55.0


