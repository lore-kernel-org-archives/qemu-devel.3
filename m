Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F19C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLq-0005tZ-Uj; Fri, 04 Sep 2026 01:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLh-0005fy-Gv
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:25 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLf-0001Gg-E8
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:24 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc1c3c90074so643046a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499222; x=1789104022; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pE3jSbysYufL9tVf8Fk9/z0nH7+2XoWlVhKnm6U3J3g=;
 b=PL7TMO0XTUKVga3vKbVorQonliKzC+ZbQMhF/sLSLZ+RfeiaQVlg3oPQ462wkAifr9
 g8Ck6MjH70lhivvPFB70kMb73XfY6ninUG0oPt1yVFZ7TUpTQg5SYf2FU2kdpOJutdDc
 yX1dz0EwoMWGyKj5cdNZpeHbbL9xixJf2yh4XWdjjUiNCncjZGrEEPXEuY3xHNaWKZQt
 DbaMoj0iskQNZP4wr4fqYgO6h3jT8qJbGOnuSpNKLFQu5bYkeuk2dYMes9c0JWc3C8Rj
 yOliAgMVI7dYwbYxfCyo4ZYC+OhH9M7Z0YngUoa09R5rDkFs/vzC4mZNjr2a+3X+86nR
 B/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499222; x=1789104022;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pE3jSbysYufL9tVf8Fk9/z0nH7+2XoWlVhKnm6U3J3g=;
 b=BWyqSSLjzw0e5dQsFLVkxo2W79f4N4C2Ff40x9xJdlK07xG0L5/rGbLgWF+X5csDfL
 Wq8lD17WuFk7YGnAPNqwOIWuBvLbTaPTuyPKywQZQN77v0OT1+JvQG5O/KVxK8ACeeST
 nXOKs1tlb+ZM3CtWXW+rTZw2s9+SLGnxCZhkTFVhAl2xwdDiw0AvBxMRnmR6Olff0yhJ
 4LPfQNPsMqBrdalsPON95h0+E9ifv9J/f7bAMPTPAaXc/I7dpAdIrULCBJgShHaOEcbH
 Z4hLwB8OCRRNc2mUrJ45wxkvDEAO4FYmAskfn5Jc00B/E58x8ugt4h4sR6DUl7roTjXO
 34Pw==
X-Gm-Message-State: AFuF++k9f1WIWgwAUvCrgD+lcYOemGo5JoQQ3ol3AsLar/9xOBxrLkmE
 OE7JZwzYPfY2Wt3FwJ9Wl3o3+IhB1V2u8M4PTqmRnjzEkJCRZOkd5Qdcw/Anjg==
X-Gm-Gg: AYBFou1T9TQpEx5qEJAUfkQ+raDyAv4q6nNZztXt28lqGNy2NmGRgSjoz04e8dR7G2U
 fzuJ4je0Nd7aazZx2v1PEh596CCVunwzNZTkRlM9W5k4vvbpZ4Vk60u2Q9B14NqLmejS5jiV22t
 ycxzVbGX5R8yFmligyDmaJn4cNK5uZvxFP2dJ/DyanIR6BrQ55bzyfNq2Z6n98UbsMo8xeQa+OF
 YXmgOVdx99+AvlZ7yrZGkbB7ZnfF3A1iabcoUPY7yjD/4XazjkXGLjv0IEZBuAgwHae0fQYP+ff
 cG9IAYuIIzX/fSMazLVBnB0395sXEbjwe79E2buQnWND3Y8prPNCdVrLNrWuLepA/HNysStBMwL
 ZBMfsRAehzNHsx9pFv0+zOniUyNPAvb6sXMC++o977kbWXx3w6benjfk95yLuqA4aABATEcWfvn
 eF3G4i+i54r/jG1cbA48E1v7PAlCYkzQDD3OBHcJTxQqmCI3dbkA//WHAWPhnkJSCbPyTNdgtSl
 6AN+g==
X-Received: by 2002:a05:6a21:3989:b0:3d1:af47:5f80 with SMTP id
 adf61e73a8af0-3da39f77bd4mr5362726637.11.1788499222013; 
 Thu, 03 Sep 2026 22:20:22 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 09/47] hw/riscv/atlantis: Document QEMU-only I2C device tree
 nodes
Date: Fri,  4 Sep 2026 15:19:05 +1000
Message-ID: <20260904051943.799041-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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

From: Joel Stanley <joel@jms.id.au>

The QEMU only I2C devices have a comment next to them, do the same for
the corresponding device tree entries.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260824055642.41098-5-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/tt_atlantis.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 7d02868b22..4fd8679ae1 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -355,6 +355,7 @@ static void finalize_fdt(TTAtlantisState *s)
                        aplic_s_phandle, periph_clk_phandle);
     }
 
+    /* I2C peripherals: qemu specific */
     create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
     create_fdt_i2c_device(s, 4, "ti,tmp105", 0x48);
 }
-- 
2.55.0


