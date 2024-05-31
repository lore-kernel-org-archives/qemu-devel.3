Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346E4C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 20:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD8ra-0002tp-Kh; Fri, 31 May 2024 16:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rY-0002t0-TR
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:32 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rX-0000ov-Ga
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:32 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7024d560b32so604926b3a.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717187310; x=1717792110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KXPUShG6rusll5cdC9KmqLcPTHGDdIHocBnKSC48v8=;
 b=nwqFhnLUptKhOr5CwTo6/cqDnowN2EWBO/r6yb8hhBjxAwV8MLZtnNKLA+ndW4TKPI
 iE/H0RPvPN4brN26NYbPLqGrob0vK7xz9NJSJR/V952Ul7jh7LyPTlfMe0NL0Pg8zRL2
 ImyqkFCHjCFAFcFCUYMO5ljxeY1Z/G2yARkhi+BU46pyXzYOozfQkDssHEoyy/XkCRmr
 zlQVFIFa+4RoilpxQprfoYoFXSQNmksldengSuP6oSmzI0/XqDgA7THowMFfN/JYfbjy
 Xn97/8NRY9vks9G49DAu48mGkgqQrT11fS99qhEJvvvRbg4/Jz1H4Fy+IpHUpRMoSVu3
 oV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717187310; x=1717792110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9KXPUShG6rusll5cdC9KmqLcPTHGDdIHocBnKSC48v8=;
 b=IM0K9m1IbqBZpIPN72hdbK98V6xObCZ5jyezqUxjFgY4ma5j9i80IsknUf4xygxPZq
 mGAT8HdzEHxCqrpJYXiQsqXtgpU+vIkpjN/rgZsyZOjmOPcEXuUkjLzNxQW4kKnjAZ0L
 /uBqNrFTRx6qjPT5B2+Tif0krdDcTlEejmg+hFIk4EP84L0H+3vTCc4VOkwQKg7siLBa
 /Av5DU9m4tyT/boz95OQtwMkjqZ9deZ3plvbXCQSQysxw4d2NPeZloBta3JOR3NNACck
 JuAzEpEyEk6QbtCVfmT+j+4mRG/r9PgGjo9f4qgP98k2bZFa1kd/QRyTYv8BQqguJZRG
 ghdA==
X-Gm-Message-State: AOJu0YxMo4+bUlu0Zlb6RjPWvH8IHLR9NllzJ2xa6+l4ourtZA/Yiyhq
 EMrS2RHThiuE9iP3JhlvRmECH+Z+Tpb2dVIamjOxbKM1Usdvr7EHFRtksbc+ZKpmjSYDK3EuYxz
 1
X-Google-Smtp-Source: AGHT+IFobnGI5sFqVbxy80mIo0jzYafACQqRLu3QHCc9QyjPdqa2s2dCJfC620sVm+N93+G9YB+Y7A==
X-Received: by 2002:a05:6a00:8813:b0:702:4a1d:c4a4 with SMTP id
 d2e1a72fcca58-7024a1dd1camr3700513b3a.10.1717187309762; 
 Fri, 31 May 2024 13:28:29 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (189-69-160-78.dial-up.telesp.net.br. [189.69.160.78])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b09133sm1819691b3a.178.2024.05.31.13.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 13:28:29 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 apatel@ventanamicro.com, ajones@ventanamicro.com, conor@kernel.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 5/8] hw/riscv/virt.c: aplic DT: rename prop to 'riscv,
 delegation'
Date: Fri, 31 May 2024 17:27:56 -0300
Message-ID: <20240531202759.911601-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531202759.911601-1-dbarboza@ventanamicro.com>
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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

The DT docs for riscv,aplic [1] predicts a 'riscv,delegation' property.
Not 'riscv,delegate'.

[1] Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml

Reported-by: Conor Dooley <conor@kernel.org>
Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 366fe042cc..0a18547c6d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -640,7 +640,7 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
     if (aplic_child_phandle) {
         qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,children",
                               aplic_child_phandle);
-        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
+        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
                                aplic_child_phandle, 0x1,
                                VIRT_IRQCHIP_NUM_SOURCES);
     }
-- 
2.45.1


