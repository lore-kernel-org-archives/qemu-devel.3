Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0904C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 07:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbwyW-0005Co-HQ; Sun, 26 Jan 2025 02:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyG-00053K-0W
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:16 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyD-0004H6-BE
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:15 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2a3d8857a2bso1998267fac.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 23:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1737876130; x=1738480930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tASVrIccjpjGo5aQU+tv0k2R2dmH/BJlEbyo67iKaFg=;
 b=fcPDDF7yyTJ2uld7WOCoBw6bwnFD/+Pd6ENa7ognalCu0yeqz1SBV5ZEgK/gammS7T
 u4WABp0RZYLxHpSNrzWX0gDUjDn+BtCqejDDPe1am+nZNVHus2j+0WjBDzvkVp/wymgd
 WdtIoMdxFOU8wfdxfGJulu/FERvwbEzOlJzuGJkOE5nwOUfR6pDL8ABiEGn/DX9tfUvY
 gey3D6UFTi0HzgRWXRgiPYqE9ICQZ5I2o+xtRn5XJS7zUGf0GEHolZYRxoEjzRc81W8i
 jag1RCPacgyDkX1r4FE05U2yJ3Y4rkGSLOqXqyTAXSVAH2dwOylNHgB2gniVFqKLqz6a
 Qk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737876130; x=1738480930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tASVrIccjpjGo5aQU+tv0k2R2dmH/BJlEbyo67iKaFg=;
 b=IirEKj34zQ8tkZVKjpadTTo6Cu0M8WUjmuosjyagiBSEeUhhCr/Ie9d1dRR9acqY/c
 AOtbyIUdpJSjnsL8A1tLpWZSOhHTmW3OKoszEDGf+zvHruRelFJuAVpxeKW7Mcw0QahI
 qkY1/TXfQwUO2N/QziMpfjdth07OmikUsP9Spvs1Oy89i41TB6YNYiaT53j4ZSNVzwrH
 S6Drr/AYOVCBXzAGB+g5w1eQmE5tQrT8EBjyJ/qQGZrnSp53Iaw04TAfNBNAOt6oeCa0
 bfWQt+DlwY3JLrCsleGiJJNgpj+ZdiWEnsyRhsP/Ilcmf54Lp4+TN54SVe+yaF/Yu7lc
 z/FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk7GoXIX2Xl5qiCg9rUrXoqWl8tMFbQEsbnPJWwO8wuy1W9EZqLVDh4nJdopGn0r+Z3rjZhsmfBGo9@nongnu.org
X-Gm-Message-State: AOJu0Yy+RG9/BkkxjWtcrhpBKPGHVL5uIFq7Nmva8tdQfpJfOXp5UGvA
 uVFZuk3gCBCk5v6uoGpf/rhf3yUiEFlTpHu8Wu74wuu/YyAZYq1ftL7MdFLZTgI=
X-Gm-Gg: ASbGncveBRgfAG/7sIcL4jnypon1c4+gKpZhk9TbZqw/+pO4xyUMQ9HzLcKMoccC8pP
 erOzNTCBZXuRkuQSCbVrQa8x98jaeFYDUvA08JyjX1cvWqlIftMSLJZVOCqqI44ADXGIzxqYfUB
 kkkE6Rb0gRJRfF/IrLdmf9fmcii4N8bZaGoZhPQwFtnWKR050gaNrvDW10r9pwu1yZG/5VQtJ2Q
 JAx7Zt1zznd5LjjneAnbCJoG1uZr2P0FIuYP753UTPD+3wc4Ya7aF0JtDxRSBNtf9q6+xzmsPi9
 Da8XiVMQFZpKHSd3nVeNB+mxYXIjadeACVw0kpY=
X-Google-Smtp-Source: AGHT+IE7lUZ3M28kpAixBI1dfSSf4oPN5O+kG0GIWbEegrXgyK2iOw5tmSjIaaigTxEdkDyqIh2QkA==
X-Received: by 2002:a05:6871:4608:b0:2a3:d9b3:3d01 with SMTP id
 586e51a60fabf-2b1c0b50794mr23350888fac.29.1737876130542; 
 Sat, 25 Jan 2025 23:22:10 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b28f1d887csm1814281fac.29.2025.01.25.23.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 23:22:10 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 01/12] target/riscv: Source vector registers cannot overlap
 mask register
Date: Sun, 26 Jan 2025 07:20:45 +0000
Message-Id: <20250126072056.4004912-2-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126072056.4004912-1-antonb@tenstorrent.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=antonb@tenstorrent.com; helo=mail-oa1-x34.google.com
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

Add the relevant ISA paragraphs explaining why source (and destination)
registers cannot overlap the mask register.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 29 ++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b9883a5d32..20b1cb127b 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -100,10 +100,33 @@ static bool require_scale_rvfmin(DisasContext *s)
     }
 }
 
-/* Destination vector register group cannot overlap source mask register. */
-static bool require_vm(int vm, int vd)
+/*
+ * Source and destination vector register groups cannot overlap source mask
+ * register:
+ *
+ * A vector register cannot be used to provide source operands with more than
+ * one EEW for a single instruction. A mask register source is considered to
+ * have EEW=1 for this constraint. An encoding that would result in the same
+ * vector register being read with two or more different EEWs, including when
+ * the vector register appears at different positions within two or more vector
+ * register groups, is reserved.
+ * (Section 5.2)
+ *
+ * A destination vector register group can overlap a source vector
+ * register group only if one of the following holds:
+ *  1. The destination EEW equals the source EEW.
+ *  2. The destination EEW is smaller than the source EEW and the overlap
+ *     is in the lowest-numbered part of the source register group.
+ *  3. The destination EEW is greater than the source EEW, the source EMUL
+ *     is at least 1, and the overlap is in the highest-numbered part of
+ *     the destination register group.
+ * For the purpose of determining register group overlap constraints, mask
+ * elements have EEW=1.
+ * (Section 5.2)
+ */
+static bool require_vm(int vm, int v)
 {
-    return (vm != 0 || vd != 0);
+    return (vm != 0 || v != 0);
 }
 
 static bool require_nf(int vd, int nf, int lmul)
-- 
2.34.1


