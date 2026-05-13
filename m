Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E723CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 03:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN0f1-000599-3g; Tue, 12 May 2026 23:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wN0ez-00058V-96
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:53:25 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wN0ex-0006pU-Oc
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:53:25 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-837b39eb078so4271518b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 20:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778644402; x=1779249202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIHI27bIT+IWRmOWe+Bud2frYYGUpQft7mpXqlK4M0g=;
 b=OrVrNE3e2LeXx0hJPilDUm+sIXJZtsvJa+6jD1phayPfM9Nh9kKESxU/cwTh22YzVb
 f3FSHBhdrxQEiWQ1IoxNzNaWBSrcjqNaQVK0GNegxInUEGb7E/EafJMP7l+cA+sVSeeT
 0AJqjsFRuuCOWla8SFYVhQPyH1kilbGKDiP3Z93eZOP8v+UNnoYPbydZ+ARx/rr8bYaY
 tr9hnsr2F91hlfTApMCoLuaP2c94ScHXCRTjDPjSkM3yk8PFmXwIQr0FXvTI0E76YT8g
 EfrcvUB0V+YDT354jzibT6wF17qVviFORtqivJULPmvXFJv9jsfCmlNlCH0jQMJ6ba0c
 883A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778644402; x=1779249202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LIHI27bIT+IWRmOWe+Bud2frYYGUpQft7mpXqlK4M0g=;
 b=Zbw3EsHl9Uc/MkkbcA+U0Z/OptssHh1iR+zSRM3T51imQJhI+MNIQtDh5A4o96rrsE
 Pe3en4dB1XIHMmZDBU2TKEo9rYgKs27TQt4GpbR6rK7+Q+kbFJJgCtwRQDroQHQEQzmm
 NZIS1zGa7xfj8C0i6rOBfnZq7ts6Lsm785lFeAO1dlWniKqWmL6j4OFIYs+oIHXXXmCE
 TpUgocQSqcMCJFky5BjcxPG/j5Jbiq0egE4MBsDeEG3oVPgioMoZ26tRnng1A2kHILzP
 2743PYa5L4yOcoLKZbOTkQg62J2sdF3OL9ac1pPS8i+SCqCsJEEzRUXPstbBph4tVgFJ
 3gqQ==
X-Gm-Message-State: AOJu0YytDrAot9PFioVm9hPe3esnh4mETRnv4vXwY61nO6f4CrZNOZsc
 cg+FNO1RPo68DZYwd2+Tu219+2ATv0RbD6s9OZd7UzuXlYMlRddqDXBPgAQi+dIjW2wKGcpiuy+
 5hcqvu2Dj1r95ZrV61AXQRCHmPhZwiE1FkF5g0uHACfLf+j3vcqlgKFa8XfbNQl4I3EAWb45u6q
 g4qR+eeMfwXKIZBRCwcrlBGzepx2YAPge0ZYvfqTATWbkmtjmY
X-Gm-Gg: Acq92OEHBmag+8ULIQxNzXh0+cDN5LhyRIhscOFU/Y0JAeLeURDhliUHxbl5QDjz2rU
 LmM6Xglq+LxxF6L2mwJ2vfdwUvRo17LF3Rh79RFE0WccQ39KF2jjdWD8z5hByGjtNN9mTN4Oczt
 8DkJ7iiRU5ZaP77y/oKnsWwXJkMidO+wMhSGcWJfqpt8gow8SmE8PtAiSFJoojP37Cx8ii8GXxW
 kycYJ0qI5o9rxuBKAenJPcFjZqftQ/Hwu1miWiOWflUsoWSVMlqcclpJ98j164XX579daCCgu+s
 Wb1WKpsJF0mXUe7QfGhVN3ouqmhZEz8Uj4dyoqM3CXUs5yixXFbfjbgNEzxHBYecFTQE1fqenv9
 6KsQBFNd0YcWL5HNUYQjfmq38gudvAG7eHbPYz8JWviFaGGF77Eg0EtZGKjSbqVVmWP0Bngikuv
 NuUXHeEctHtZoilzZnEakuXA4zCmQMz0ZwG7ey+SikvaCO+IgVPg==
X-Received: by 2002:a05:6a00:439b:b0:838:127d:a161 with SMTP id
 d2e1a72fcca58-83f03fcc5afmr1527293b3a.18.1778644401719; 
 Tue, 12 May 2026 20:53:21 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbdfb0sm24317872b3a.45.2026.05.12.20.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 20:53:21 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 2/4] target/riscv: Support raising misaligned exceptions
 for scalar loads/stores
Date: Wed, 13 May 2026 11:53:08 +0800
Message-ID: <20260513035310.3764218-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513035310.3764218-1-frank.chang@sifive.com>
References: <20260513035310.3764218-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

When the Zicclsm extension is not enabled, raise misaligned load/store
exceptions for misaligned accesses from scalar load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 2c82ae41a77..2662fc5c2a2 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -413,6 +413,9 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         out = gen_load_i128(ctx, a, memop);
@@ -524,6 +527,9 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         return gen_store_i128(ctx, a, memop);
-- 
2.43.0


