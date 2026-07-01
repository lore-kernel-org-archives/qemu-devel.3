Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDFDC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2O-0002pR-QV; Wed, 01 Jul 2026 06:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2N-0002n7-GM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:23 -0400
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2L-0004ns-TE
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:23 -0400
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso824585c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901160; x=1783505960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x0/oaRy28fMuBPA07y5h4YdlLYT97Klt1rSVUyNJSsQ=;
 b=gMAr8WiIhVqH6IWVYys0c8wCD5EV3U5tCnQVXHbt6DeCA6Z45VOIY4zfwguaMGYgWP
 9NluHC7uTz2whXM6N9tCKE+nXhIn0+N9kBUCrQ8BUCORc1x9d23TZEId0dEsEg0yCuqD
 Jj0auMQwpRWnkpcLxFvuyvWwuKdBMTnlrk6eyQrzW0/1PJGXkqk6jFsSq8QlV2ciBYxp
 lE/C11BxjFLMhumFa+j2OJNLmEdvwwCwm+euhcm3KoyE500Bbe9/DNwo+GgBkSgD5HeU
 ehcGeLp0kOAoP2d3C627MOCJy8EjNurfC7+v7rBJf7aru9tSTbEqRbR7Cu3sV1e4+aXt
 vSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901160; x=1783505960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x0/oaRy28fMuBPA07y5h4YdlLYT97Klt1rSVUyNJSsQ=;
 b=AL/KpPRng8p//okLC6omE7q8dgMnuSndSpiXcw/VsvWGgOV8QwOsmo0x3oEh/8LVPn
 b+YNuhBy1hVuK62J1gaoAs1QhVi46PHWrrr3Tz2H/zKiB44e/9TRlP9NYpMNrYE739lp
 bhRynUbFMj19jBt1NY5Gun2Sjy/DktUmzWCo2dcDlnR/3aoioVgVHgCnofPW82mZwnoJ
 YQINAj1IhGf/N3lwpYesJR1T/oGUbTsaHDrqIFWikaBZEiUahKULSyk7wUz2ex9/Z9Lc
 qRYpl/75kPC/JlV6StGMsrc+JvoGPmZev6JuE0RrmUFpC/Fny6HJlTlxnOPsCAK6I5Up
 XhcA==
X-Gm-Message-State: AOJu0YyLZnRi/2ZT+t/hYlWD8ICslul60jjmROAsbEagiPagFbhrZI75
 016WB7Ax2RQcSKKYRrk8bOLwQCYEsw5ze5gCHkbAVmYxC6hkkf2s5cVVFTNgPQ==
X-Gm-Gg: AfdE7cnC6H+3Eo4FFV7hJUSgw3QVjLcCGJPqv4sKLqgpRi6CtWE441HBd9558qQ2ybD
 BN7bRsEY8297eIAdq4jAEsi3cuxqIQaGrF7HytjO5+n5W3ii6zHmJd0q1ym4LiP+rs1QJyVNTJI
 0qwjE+9OXSU/ngjkVLdL9smipxgr7f27txIskKW4NqqPtjSS86KisW3e4bwpeoHf96gnhWyvCuJ
 SdmaLSowilO2BPvCxc/PBDYDwP+sxUT4XDOnpARv/oSJZr+DC9NdQj/XU2jSvpuNov8hPZFz7+I
 TgidtgrWRF4Nf57bAL9gtPtlwHtTXdNJHDW7WrNQH2lMhenJz7FuV9TxzvEZt00i4RtK3ZPncLh
 ojLV5xpw72feLpVZt/tZTLKG9bMt/pvqi7nBYUKOc6nYWYL0/bKMTckO4w+YE1v2hlxW+itl6xa
 9skFXRaiBi0/T8zKl0BaZ85LCX3sB8Mu8=
X-Received: by 2002:a05:7022:102:b0:137:f58c:3cb5 with SMTP id
 a92af1059eb24-13b36e02d09mr1039987c88.26.1782901160261; 
 Wed, 01 Jul 2026 03:19:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:19 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/39] hw/riscv/riscv-iommu.c: fix MSI MRIF interrupt-pending
 offset
Date: Wed,  1 Jul 2026 20:17:37 +1000
Message-ID: <20260701101752.2522962-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122d.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We're doing a wrong shift when calculating the offset for the
interrupt-pending bits, off by one right shift order.

This went undercover for awhile because the calculation works for
interrupt entities 1 to 63.  The math goes wrong when using interrupt
entities 64 or greater.

Instead of fixing the issue and running we're also adding some notes
on where this calc comes from.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3561
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260626220529.3800372-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c65e273dbb..01f5634f04 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -686,7 +686,26 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
 
     /* MRIF pending bit address */
     addr = get_field(pte[0], RISCV_IOMMU_MSI_PTE_MRIF_ADDR) << 9;
-    addr = addr | ((data & 0x7c0) >> 3);
+    /*
+     * AIA spec section "Format of a memory-resident interrupt file":
+     * address offset 0x000 contains interrupt-pending bits for
+     * identities 1-63, offfset 0x010 for identities 64-127, and
+     * so it goes up to 0x1F0 for identities 1984-2047.
+     *
+     * Hence each batch of identities advances offset by 16 (0x010)
+     * for every interrupt-pending bits.  This means that doing
+     * (data & 0x7c0) will filter out the first 6 bits, then
+     * a >> 2 will turn the result in the 0x10 steps we need.
+     *
+     * E.g:
+     *
+     * - (1-63 & 0x7c0) = 0, 0 >> 2 = 0, offset 0x000
+     * - (64-127 & 0x7c0) = 64, 64 >> 2 = 16, offset 0x010
+     * - (128-191 & 0x7c0) = 128, 128 >> 2 = 32, offset 0x020
+     *
+     * and so on.
+     */
+    addr = addr | ((data & 0x7c0) >> 2);
 
     trace_riscv_iommu_msi(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
                           PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid),
-- 
2.54.0


