Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B229DC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwf-00050y-8r; Thu, 27 Jun 2024 06:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwe-00050E-9l
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:36 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwc-0001dn-Kk
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:35 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-70b2421471aso5492570a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482492; x=1720087292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QU4i8l0CHf3BaV0XsBQvH3OwC1graQuHSr1WC6y7TUI=;
 b=VNJhOCWs3rfVj2aY/0IAtddvdu9/mu6qyIA59U0vEP49c93Q5F035nJm3+2O2vnWXw
 B2elf4zpXqXqpr7xpPie2XDYxXQ/ofNzmP4PKdpTc/vn935nB7ZTmwmn2kN70joYAZyk
 oMCYxhEObBKHiwoGsjRgiLD/29pvVDd+I1aEsdqsu9c+yOPvI8JoWCEvU71t/XSx7ra/
 96oWXkirgVZ6Ssng41ohXKrD+KsfhVv/2w5/vroXfa6bs8oh/Rr7NXI37rxTvi0w9qUi
 aqe90KpZwnd3eweIXOLcu77g0Uuze1zR14UctS9PMFBUC8FLBzq+SXViV60YZ+vINFpF
 EYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482492; x=1720087292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QU4i8l0CHf3BaV0XsBQvH3OwC1graQuHSr1WC6y7TUI=;
 b=oHH/SANnfs4+VAlu1Nx3toOmwl4Qn/GKPwyN9zamGEFua829Hhk3/8F807606G54VL
 6SYBMhRpKHD4j4E1wLkf3VeQ2Ud3rTzMZXyNF3RO1vWJ+c6XXMK9ax5Bwjegw+QGIrpR
 DRCzRELpGOsLEczlmXE97lpimFDtP3tREqDA4W2W/l0pacPa6jUULzII5cA6igIlc4wA
 P/GL/2hyzbkITtAFrFffGB18gZOr/laGxD8FBiTQt8Rc0Bt9gPG7ON33SiI/dwjnYwPZ
 hJXnLRIiTwICVJfG5tWtCXr1RP80MutHuHddYUyFGb4NZKgS98SZAwjc4H9Xvt9mD+kd
 5GEA==
X-Gm-Message-State: AOJu0Yxldh9gcHH07upTRNovbV2T5VtkzHYCHgw4z0NahFVmRisMtFH+
 fYzS1VR2fLXBGcVXxJkI8ZP4s/ixvlQBf+sW1OKXyMvr6mks29vzUS0a9AXn
X-Google-Smtp-Source: AGHT+IEH7XsxyLynGCWLyoMFRpBeoo20IiYHETZrBSFrYKwLLfTyI0H//zfxmdyOyO+D8QNsdWlSew==
X-Received: by 2002:a05:6a20:6387:b0:1bd:1e0f:efa3 with SMTP id
 adf61e73a8af0-1bd1e0ff0dbmr6675761637.4.1719482492263; 
 Thu, 27 Jun 2024 03:01:32 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:31 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/32] hw/riscv/virt.c: change imsic nodename to
 'interrupt-controller'
Date: Thu, 27 Jun 2024 20:00:30 +1000
Message-ID: <20240627100053.150937-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

The Linux DT docs for imsic [1] predicts an 'interrupt-controller@addr'
node, not 'imsic@addr', given this node inherits the
'interrupt-controller' node.

[1] Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml

Reported-by: Conor Dooley <conor@kernel.org>
Fixes: 28d8c281200f ("hw/riscv: virt: Add optional AIA IMSIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240531202759.911601-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9c6b39b7df..376e362a68 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -538,7 +538,8 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
         }
     }
 
-    imsic_name = g_strdup_printf("/soc/imsics@%lx", (unsigned long)base_addr);
+    imsic_name = g_strdup_printf("/soc/interrupt-controller@%lx",
+                                 (unsigned long)base_addr);
     qemu_fdt_add_subnode(ms->fdt, imsic_name);
     qemu_fdt_setprop_string(ms->fdt, imsic_name, "compatible", "riscv,imsics");
     qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#interrupt-cells",
-- 
2.45.2


