Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A2DC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLh-0005hN-Ud; Fri, 04 Sep 2026 01:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLa-0005YP-0J
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:18 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLY-0001G7-AQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:17 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-ca80d708489so465274a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499215; x=1789104015; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i+lbHZu0vOk68BrSHeUI2CsfqMRKiCih6wgnX4qBAs8=;
 b=KE7X2VUhWECioo5/ZngVglKgWEhHV7sFBPxMm8xTiql53NOtXQUDcEzcLJ8TyZgggO
 /nO6NZPt+NyNXEnGiB3vUDk704b8ZLjpKvC/gznHntEsQGhUgF6QT0yYpVnyMhADtG+X
 1RCwnP9rvrdtfCPO9aVCq/zBKL3jkzh34Srf+lqeCqbaehuXGK1wjV3XeNjylg89H8Cu
 yCqOFfOD2b5LgAr8Gw8uCk4gOA1LxwUJ80eQcYYJVkRDORXktqFxO1XqcgLyJmmgdr6i
 +otVWBOpSOAdhVokBmoI7QdcevNowDjZkQyw+eZ045fmx44fJ+wAdqy9xA0sgYVDiCgK
 zlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499215; x=1789104015;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i+lbHZu0vOk68BrSHeUI2CsfqMRKiCih6wgnX4qBAs8=;
 b=nj5BOnWPldMy4BrBPJJeGURP7Td/K6uccE1GtQcIz0usrxS9CdlgK0fe9vcy3yf5Z9
 ppMYCYoAdDWhlDPxCIXKnNjUHQwXQj42VDavhRdA1PXYF9ybKA2qwuxM02Cl4xzh07Av
 WqudSW2yx23msJLqIFuFyMC9SsgkKB49vPA2bPl9xSkr+nWzDUKpo5duNsNBWJ7Cn5AP
 giB43ZcJ+G63sZD/f7dQPTTIqbZDeGaQj19ZuJ04VGgbgNdT5c9npeFuxQJ0tUTbdJ2K
 GyoQCPAr5IxuItHp+1TAwxpLKfxmy74DNZ1eTePkfjj9p23dbl1ApbGRh2jhO2pAryLp
 wdlw==
X-Gm-Message-State: AFuF++njdQJvNCMPKbRbmmEzdS+X0WOZ+LPKtCQgOSyuEiZifumB0nR+
 6bIoNo7VvZa9l3zeGk+5z9N83SSvIR4/QcQmuJVoRNt5jbIWA8FdRPCNQqCwfA==
X-Gm-Gg: AYBFou0hHePUu/tmlHHX/LD+LU+OLqV+XNAs0eiyZCjwJ4naFneXnK0oUb1aMc5+UzY
 OtRi+J45ZtYiNC7nAc83xmKzHB05rGOM8ylq9XG9bBab53eVlalDXX4tIsikfRncAva2tNnfm5Y
 v1MO/Jlcg7o5ClmPqBD7l3sGEvnvNPQeKTlL7QlXHYDJGBvrZNRurGJQ7u/ZHL19V8SK4tng0rq
 2q+fO+hZBtjwlxLRlbf75OLd6ixTEHCXbCocExuFRlTadpn0hTlzro9gBbHgs2hgtFu7uIKHEuI
 woVefJZgcbamdtoce+opdbaok+Vv7aAYkQR5XIPl8yPbwXylQITAnT0dyGGqBd+673nj/BQE3nF
 MMIxPxDe3j613sYSQsBMlPCI0hDeb68/WaRIXXOSVmeruq+6yLOc4dhQtCXK18479/LII39xlDM
 MuhQIlnqYACua95g5yoiZvutcQDkMCFZ+y2BUntyYWX8HfeVPxs/DfnX0hJJ1ahVAeATsbmV9k9
 +HQ9PXlW+yvRdVj2TI=
X-Received: by 2002:a05:6300:389:b0:3cc:dce8:1109 with SMTP id
 adf61e73a8af0-3da213c8ce5mr9612436637.3.1788499214838; 
 Thu, 03 Sep 2026 22:20:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PULL 07/47] hw/riscv/virt: Use hwaddr for IMSIC device tree address
Date: Fri,  4 Sep 2026 15:19:03 +1000
Message-ID: <20260904051943.799041-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
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

create_fdt_one_imsic() hard codes the top 32 bits to zero. Instead take
a hwaddr and populate both the high and low cell.

Suggested-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Portia Stephens <portias@oss.tenstorrent.com>
Message-ID: <20260824055642.41098-3-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index dd39641017..a5d2452d97 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -382,7 +382,8 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
     g_autofree char *imsic_name = NULL;
     MachineState *ms = MACHINE(s);
     int socket_count = riscv_socket_count(ms);
-    uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
+    uint32_t imsic_max_hart_per_socket, imsic_size;
+    hwaddr imsic_addr;
     g_autofree uint32_t *imsic_cells = NULL;
     g_autofree uint32_t *imsic_regs = NULL;
     static const char * const imsic_compat[2] = {
@@ -402,7 +403,7 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
         imsic_addr = base_addr + socket * VIRT_IMSIC_GROUP_MAX_SIZE;
         imsic_size = IMSIC_HART_SIZE(imsic_guest_bits) *
                      s->soc[socket].num_harts;
-        imsic_regs[socket * 4 + 0] = 0;
+        imsic_regs[socket * 4 + 0] = cpu_to_be32(imsic_addr >> 32);
         imsic_regs[socket * 4 + 1] = cpu_to_be32(imsic_addr);
         imsic_regs[socket * 4 + 2] = 0;
         imsic_regs[socket * 4 + 3] = cpu_to_be32(imsic_size);
-- 
2.55.0


