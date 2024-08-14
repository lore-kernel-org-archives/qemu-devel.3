Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A4CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 18:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seIXg-0006Nd-Q6; Wed, 14 Aug 2024 14:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1seIXN-0005EE-Qu; Wed, 14 Aug 2024 14:15:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1seIXL-0000CL-Es; Wed, 14 Aug 2024 14:15:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3687fd09251so118515f8f.0; 
 Wed, 14 Aug 2024 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723659352; x=1724264152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11Nnvyjma0LW0aPjYkftSgoF9PLHmiYBlPi+12DdlR4=;
 b=RdtEWmKdgFUQelz+nf0AFrv+YGufYXOnSgvAnTRv4h4tV548iFxGkKZP67et94MK57
 z5v5QVCqlndzIrcefqhHUjdKWkBL5NQCz8p9+4hh+AsfMt7+jNRJk249Uzfxfl342ivO
 5EE0vgll7YsstMngcZgjHGjDPGH+UpdEvENQoTx2uLaRZ2FLdtlW/nWAFNE3KVK8y5tt
 WHkZll50z5zKSk5FZaR4M18LooLQrvHVSY19XmoASOvzduuUbyZaE8OVE2TGpDT0SZhE
 ID5NEcbZ6LaPz9K84JUEuf6XIiZhchbAqt2V1bODw9JHr9ht4lxYhEVWr8/Gs5jPpmYg
 DWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723659352; x=1724264152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11Nnvyjma0LW0aPjYkftSgoF9PLHmiYBlPi+12DdlR4=;
 b=sFeetVIhfGF3TXCRP/PFFGZX7InTMsDzZ5p1Z1MLBc3mD/7qudwJD3RBB01pXNqHfw
 9iuXcFnCei93Fps3kevMZrNBw91TTl29EY4JVwrWrP57iC8ZIYb8EpHk6rJqebDFLmJl
 UgW+tHoEQ7v8YPdLSPGqKOx7PsXgw6dfCqvofPnfKxvESfETEEBBDUiYcAtOCOscO4FH
 M7g8Gbm0dtOFOc/zAbA561Z7GgxhP0ogbTU53Mr0bbZ5SpJ/3Auyo0MjmLzUFrlVjnpG
 08zGwDlLsA9lSuexXqe9tRrowcscSTCtxLTz7VGyaeimmRPKmxXEoKr/H2hdfVaTtKE8
 B1fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9TDOPnKPRZQLChL3DoMu87ZftCnvIKWWZx8Fcq/zGb2oNpueppUMk3LgAjfhJyVsTb948C3ve2IIu7DDZRUxGNwH2aKZudilSVdKuQijtRnrE1YC5xvEUXDQsgf4A50e5amChWRXUWIU8ePU2mJI=
X-Gm-Message-State: AOJu0Yzlzn5egxAY6T/wf0Z4/OMwyc2/P0y1gfJqrOJqtxZyAQVwZgmn
 zyYBiWuD8ibfVs25ZYhSe6ETMJXQb/BieFqat8iRmLbjsQPs2udydV4CYA==
X-Google-Smtp-Source: AGHT+IEQUT9AzNEaQSs5nL6Dkq+HgKdDGhOVtQRwodmd0eSoiPnYaCsNc2SaRo7lNX7fQpkvYFCjwg==
X-Received: by 2002:a5d:59a5:0:b0:36b:357a:bfee with SMTP id
 ffacd0b85a97d-37177749bc7mr2784809f8f.1.1723659352429; 
 Wed, 14 Aug 2024 11:15:52 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-049-243.78.55.pool.telefonica.de. [78.55.49.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937bb9sm13557625f8f.34.2024.08.14.11.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 11:15:52 -0700 (PDT)
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
Subject: [PATCH 3/5] hw/ppc/Kconfig: Add missing SERIAL_ISA dependency to
 POWERNV machine
Date: Wed, 14 Aug 2024 20:15:32 +0200
Message-ID: <20240814181534.218964-4-shentey@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814181534.218964-1-shentey@gmail.com>
References: <20240814181534.218964-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42c.google.com
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

The machine calls serial_hds_isa_init() which is provided by serial-isa.c,
guarded by SERIAL_ISA.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index c235519881..5addad1124 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -39,6 +39,7 @@ config POWERNV
     select PCI_POWERNV
     select PCA9552
     select PCA9554
+    select SERIAL_ISA
     select SSI
     select SSI_M25P80
     select PNV_SPI
-- 
2.46.0


