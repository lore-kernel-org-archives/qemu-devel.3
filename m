Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680BCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 18:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seIXQ-0005Lr-4M; Wed, 14 Aug 2024 14:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1seIXK-0005Bd-Gd; Wed, 14 Aug 2024 14:15:55 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1seIXI-0000BN-97; Wed, 14 Aug 2024 14:15:53 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3684eb5be64so103093f8f.3; 
 Wed, 14 Aug 2024 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723659348; x=1724264148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PSWabqmMSPNuyrCef/bxoDt40mO7++0ig/XfeMli7rs=;
 b=K/RIqLPPVRaeXy2AXy+bvt8DVp4vVI5W8VMc76b15oqN1Ir4QvN5JjbWaZBkflghXM
 wGFaNikDCrd+p7AMQ+t0w1NrX4PRanFhwWgVBZ7GoYglgaIozJtFqMi50n6g6Kx+v4wH
 novMUncD3Opy8Suj2ciWg9F/q4RNhZyteZk32NUAXgNNNe5tjAU643gImCUfHMNvQel4
 HITct7IYjKKsweG4hk9FIoTUr842EcYR0RRauiPgzkAY+RyL79ui3+La2e0ZbV++a4GN
 sYsmU/pbQKekjuOTQINups2BR6dx7nef2bNQuIH4hpnx7vAbJhrzw/pk/ixN0gU1MwmK
 X7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723659348; x=1724264148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PSWabqmMSPNuyrCef/bxoDt40mO7++0ig/XfeMli7rs=;
 b=Zel5S9nkOnSeGwUyBnegPGBldBCpAmMm+xOzrkmY85HVI9GGKLO6UpJ677dCb4AFeW
 l3Ax8CEmLi1N7OvcxB21sWPOuJ+2XNyPUXqlFG0DlFLDr1WVcHjI1TRMflk4NIWg/ghq
 98K2M7E42VcAbuGJmeL3aAmlMsPvxt3p4eRpchkTV+tB53rjaMIlTd41Nw+ym0/QgHVE
 Kw7pqw68QcTnmlxWHzWLEPuyNI3ubc8oz6sEz5OlX3qnI292LDVM/r4H7wQhnMh+AvwU
 YISf5uOxPb40oj13ZYXxBjY9KUifYBsS7lUd6VrO6uomHaouc+JL3KgIxPdRK1/PbOdX
 +29A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdcEW+yQFFUyNFp0JnsD+4e1o9fHmbCNOVt73rTFy2DP8ZhbAa6WUqY/BJMlR0ZpNwnh643tiC5l4UJkDnL9gFRQHOyAbec4qalb5MT1HWcqlcNpRGKNXXblifLE6kP8Y3gXzmKiW4dfrrSyU3dZI=
X-Gm-Message-State: AOJu0YxqyNoJVpOuYZZRlZ//Fzyiy0EtImoR4RD3ekd/mQHesOGr8+jN
 K0KK/VUMKwbw18o2tvdfaIeZdr8cgbuR4nUwkHGa/ZpS+MUji9FSLVtbpA==
X-Google-Smtp-Source: AGHT+IEQP6rxpvHVq+oPpo9q52svzEbTT12R6XzH+X2rh299C3bfP2GCBDmvxyE0csH+CCYP3zQ/SA==
X-Received: by 2002:a05:6000:1a48:b0:367:96a8:d94b with SMTP id
 ffacd0b85a97d-37177820468mr2101517f8f.57.1723659348381; 
 Wed, 14 Aug 2024 11:15:48 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-049-243.78.55.pool.telefonica.de. [78.55.49.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937bb9sm13557625f8f.34.2024.08.14.11.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 11:15:48 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stafford Horne <shorne@gmail.com>,
 qemu-ppc@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Joel Stanley <joel@jms.id.au>, Eduardo Habkost <eduardo@habkost.net>,
 Sergio Lopez <slp@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jan Kiszka <jan.kiszka@web.de>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Jia Liu <proljc@gmail.com>,
 Helge Deller <deller@gmx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-riscv@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/5] hw: Remove unused inclusion of hw/char/serial.h
Date: Wed, 14 Aug 2024 20:15:30 +0200
Message-ID: <20240814181534.218964-2-shentey@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814181534.218964-1-shentey@gmail.com>
References: <20240814181534.218964-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
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


