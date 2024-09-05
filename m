Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3B8CD4F5F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 07:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm74w-00068A-2u; Thu, 05 Sep 2024 03:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sm74s-0005yA-Ja; Thu, 05 Sep 2024 03:38:50 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sm74q-0001dD-Ut; Thu, 05 Sep 2024 03:38:50 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c245c62362so614837a12.0; 
 Thu, 05 Sep 2024 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725521926; x=1726126726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqq2+yKTgR47E2vybbP031KgJCA7S1tzDqwG9g6AEdw=;
 b=C/K0/TVsRSefv324SyjkaXVtPtG/7madbzi7vKcceeH8SQEE+Nh4qSpTAmMmZmt8VS
 CcKHV2eladhC9EcKuVarj7ib4yq5mzIMccdDtE4v/AyuGHHlaUS59Dh57JK8tfpARpNN
 8OyjvuY3HAYMPTCpOmNcbrQVf36dhHPhjOPJxWj04ThtvxwbxkCi7pgNRO9tp5eeHA5a
 HZw/X44dCNXb/7R4vPa9MtsAE7VBIxfM0N6NOleNN0zGz2cuVyMRlRGDm6qM1gJI36tF
 sja2LO4ADzpMI41g3n1rnKqVfDV0L4ZyfaY2gll+kO7aa4XmeQ0MsWmKEfzbOeKs+AiN
 xVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725521926; x=1726126726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yqq2+yKTgR47E2vybbP031KgJCA7S1tzDqwG9g6AEdw=;
 b=pv9hgBz6wQHHfvvmAWt6ik6FTbqcOxrc3+OUxjRhHUdnhSpaCUd4Jgt/Lb6T7U+DPr
 8O9lbxxbaEzPq4mgmr+timktk95LJaars//XnQ47gx2u/dSyeKUqCKLrNxnIpYIYxewI
 uLm3DrslABMoxemCezwlVTeosrMY3+qoLnu60Re69jrYyfCko6nS92e2WIDFLjmQ/hx6
 Sc2bDy9nO90Mv+nC7LnDVttv8tuKOwzfIvVoAu4aOPQSh6UhSouvbdTl0rafknUzFm7l
 0/lTStZ27PeIuXtJ5z7yf91aXt9f2OvD6YLenBvjxIeC1ZzLyU87cUENZGPo/dfRkO0a
 ctiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMMAzbqipcSX9DWGj7Kxv1l/iNmgnuqeCqhjULs53q65kpgblyhFBuxmKDjaSQh1H9zx8/QFfAjQ==@nongnu.org,
 AJvYcCWNXt5zkqpLE30Q8R+vK4Q4cGK8CXQtNbjyCxlQpmdjMILbh06Fxtr2qOhFWqWrk/ZNulz8xCaQC+F60Q==@nongnu.org,
 AJvYcCWR+Apfa32LNXJxlkO3xbCLDW+n9aNqSNEXtJoufZC+mZu05i8wBD8wY+8UsXIO1++XI/+gwNBw8xY=@nongnu.org
X-Gm-Message-State: AOJu0Yw49CBPmGuQfzZLXxFGIE/1yKH4stGVhmAnSGHkUXDXR7UhZ6+G
 gODznTkAEEx82tRmuv98N00nZV4bHkLXXhFPrhJD3bP95LQtWEQtRBaYXg==
X-Google-Smtp-Source: AGHT+IGT5d6gd/YfLzTes1ORJwZO7X3RLzyDLESDRFf6RFDXzNE4MDUJIMJknj/KsCHjLK80WGZ3RQ==
X-Received: by 2002:a05:6402:50ca:b0:5c2:6e61:fa74 with SMTP id
 4fb4d7f45d1cf-5c2757ce907mr4739436a12.4.1725521925341; 
 Thu, 05 Sep 2024 00:38:45 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-092-224-047-179.92.224.pool.telefonica.de. [92.224.47.179])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc5689d9sm848755a12.43.2024.09.05.00.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 00:38:44 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-riscv@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Tyrone Ting <kfting@nuvoton.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Sergio Lopez <slp@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 1/3] hw: Remove unused inclusion of hw/char/serial.h
Date: Thu,  5 Sep 2024 09:38:30 +0200
Message-ID: <20240905073832.16222-2-shentey@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905073832.16222-1-shentey@gmail.com>
References: <20240905073832.16222-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/riscv_htif.c | 1 -
 hw/ppc/prep.c        | 1 -
 hw/riscv/sifive_e.c  | 1 -
 hw/riscv/sifive_u.c  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 9bef60def1..54fd55c3e6 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -24,7 +24,6 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/char/riscv_htif.h"
-#include "hw/char/serial.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "qemu/timer.h"
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 4eb5477069..fb58c312ac 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -25,7 +25,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/rtc/m48t59.h"
-#include "hw/char/serial.h"
 #include "hw/block/fdc.h"
 #include "net/net.h"
 #include "hw/isa/isa.h"
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 87d9602383..5a1959f2a9 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -35,7 +35,6 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
-#include "hw/char/serial.h"
 #include "hw/misc/unimp.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index af5f923f54..efc8443c84 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -43,7 +43,6 @@
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
-#include "hw/char/serial.h"
 #include "hw/cpu/cluster.h"
 #include "hw/misc/unimp.h"
 #include "hw/sd/sd.h"
-- 
2.46.0


