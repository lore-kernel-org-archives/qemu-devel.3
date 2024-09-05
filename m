Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC25CD4F5B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 07:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm74v-00063P-AT; Thu, 05 Sep 2024 03:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sm74s-0005xv-7x; Thu, 05 Sep 2024 03:38:50 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sm74q-0001d7-C9; Thu, 05 Sep 2024 03:38:50 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f50ca18a13so5339211fa.1; 
 Thu, 05 Sep 2024 00:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725521924; x=1726126724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3hJCn67cTUCpVwgmEIKrSd2Kdb4ezcdEcinf9XDw6Uw=;
 b=BmRNx684DKHuGAN7Dj53UtG3HdyEiuYTRpqN2c5TeEiShbuTN8dUJhGQQQP8uxAB61
 SnF7BraGLYOZk/wM/V4rSQ7u2pd4fM7Lr6G0rTrtq+H8DwRwFQcM0tT9iKLas45i7yRJ
 S+Uq1hZgcqh34Lpa+7rGeaU4QgymWpOjBnFNNx35NIQa01KgS6P+VU/1mjdvQiOjoAus
 FWenOXaHVlgvg/iInNsu9RahTQGizStHh3mUBiXwov37cQNmjQ8gl63pz8q3+bXzfun/
 v9R97nxYYSqpSgbCvkPw0p4rZy10OTbmeJaols1Ocs170q3b+TUmVn1SwqXPfFvLvUuz
 plag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725521924; x=1726126724;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3hJCn67cTUCpVwgmEIKrSd2Kdb4ezcdEcinf9XDw6Uw=;
 b=azJvslL1Q6qXovaJv0m36BtMmorpQj+gYhHBLrjTG4YL4smO4bxkwBgMEZj+jxrYFB
 lA+TqN8kBq3Zb/XqD4uEum4brxfCuSesVl2kE1Vm6ydaNGi0mV6tkuDLo3nZyaARbE8J
 HrjgOT5ZoWNOs+tlA7wlAyBrleyAc412oSp4paIS6fCj7HJavw1wlBkZxcbniSFeJgI8
 nLbU6vKYlLHZFyLQv/EXhXoD4iVgT7AzY8PJzDiQCPBr6QZgmWR4vRE6DQfABQhiYyir
 be8ViaHD+RtvgTsILoEk4GOrYnBukhn9u82TVoctcps7gyRwjYQCWPWX8k25XCEU2bA/
 yXPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHGsToIVzxJDY07waMv9nIVs/o+orFEh38xczt96NhKcjxXuBPPWblhdrvQ0w+K2/lKY/zhDlo9BAkVA==@nongnu.org,
 AJvYcCVsCfR2C5cy2vJO2oIp3UOaYPhcZJSJqLq0Adp2rStyFqz4XWCgROpPBpZF79KJ2ZBiU8iSi/fqNYM=@nongnu.org,
 AJvYcCXiUcstNZL7KmGjzDm5frX3V+eOrPq3EdJPCeY6b6Mhr9bQrbJJ+0BU0HAFmRU7do2CzX0VIQa02A==@nongnu.org
X-Gm-Message-State: AOJu0YxVhtQjYILxKaUpfvwlL7x7pc9UyzskKHgMHMKzBdxwilVYeMng
 qqgXNF85v1gqBL62Sj4r9CXwtbEZdC9v92gZck5RXJ9b3Ndx1fLz0EHwDg==
X-Google-Smtp-Source: AGHT+IETYJT5S9DS58zZp1cMjFHdamAN5etleNMklxPlfU0tDL3v9EoKnQETPmwktbHWJtJqe11Pmg==
X-Received: by 2002:a05:651c:b13:b0:2f1:6cb1:44c0 with SMTP id
 38308e7fff4ca-2f61038c633mr176590001fa.6.1725521923294; 
 Thu, 05 Sep 2024 00:38:43 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-092-224-047-179.92.224.pool.telefonica.de. [92.224.47.179])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc5689d9sm848755a12.43.2024.09.05.00.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 00:38:42 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Serial device cleanup
Date: Thu,  5 Sep 2024 09:38:29 +0200
Message-ID: <20240905073832.16222-1-shentey@gmail.com>
X-Mailer: git-send-email 2.46.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x235.google.com
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

This series extracts TYPE_SERIAL_MM into its own module and introduces a=0D
dedicated header for TYPE_SERIAL_ISA. The result is that no board directly=
=0D
depends on CONFIG_SERIAL or includes hw/char/serial.h any more.=0D
=0D
The first two patches are only paritally reviewed and would benefit from a =
few=0D
more R-b tags. Since the changes are mostly mechanical this may be "boring"=
.=0D
=0D
v2:=0D
* Rebase onto master which eliminates patch "hw/ppc/Kconfig: Add missing=0D
  SERIAL_ISA dependency to POWERNV machine" from the series (already applie=
d)=0D
* Drop patch "hw/char/serial: Remove unused funtion" (Zoltan)=0D
* Add Mark's R-b and Andrew's T-b tags=0D
=0D
Bernhard Beschow (3):=0D
  hw: Remove unused inclusion of hw/char/serial.h=0D
  hw/char/serial.h: Extract serial-isa.h=0D
  hw/char: Extract serial-mm=0D
=0D
 include/hw/arm/aspeed_soc.h         |   2 +-=0D
 include/hw/char/mchp_pfsoc_mmuart.h |   2 +-=0D
 include/hw/char/serial-isa.h        |  38 +++++++=0D
 include/hw/char/serial-mm.h         |  52 +++++++++=0D
 include/hw/char/serial.h            |  28 -----=0D
 hw/arm/allwinner-a10.c              |   2 +-=0D
 hw/arm/allwinner-h3.c               |   2 +-=0D
 hw/arm/allwinner-r40.c              |   2 +-=0D
 hw/arm/aspeed_ast2400.c             |   2 +-=0D
 hw/arm/aspeed_soc_common.c          |   2 +-=0D
 hw/arm/kzm.c                        |   2 +-=0D
 hw/arm/msf2-soc.c                   |   2 +-=0D
 hw/arm/musicpal.c                   |   2 +-=0D
 hw/arm/npcm7xx.c                    |   2 +-=0D
 hw/arm/pxa2xx.c                     |   2 +-=0D
 hw/char/omap_uart.c                 |   2 +-=0D
 hw/char/riscv_htif.c                |   1 -=0D
 hw/char/serial-isa.c                |   1 +=0D
 hw/char/serial-mm.c                 | 157 ++++++++++++++++++++++++++++=0D
 hw/char/serial.c                    | 126 ----------------------=0D
 hw/display/sm501.c                  |   2 +-=0D
 hw/hppa/machine.c                   |   2 +-=0D
 hw/i386/microvm-dt.c                |   2 +-=0D
 hw/i386/microvm.c                   |   2 +-=0D
 hw/i386/pc.c                        |   2 +-=0D
 hw/isa/isa-superio.c                |   2 +-=0D
 hw/isa/vt82c686.c                   |   2 +-=0D
 hw/loongarch/virt.c                 |   2 +-=0D
 hw/microblaze/petalogix_ml605_mmu.c |   2 +-=0D
 hw/mips/boston.c                    |   2 +-=0D
 hw/mips/jazz.c                      |   2 +-=0D
 hw/mips/loongson3_virt.c            |   2 +-=0D
 hw/mips/malta.c                     |   2 +-=0D
 hw/mips/mipssim.c                   |   2 +-=0D
 hw/openrisc/openrisc_sim.c          |   2 +-=0D
 hw/openrisc/virt.c                  |   2 +-=0D
 hw/ppc/e500.c                       |   2 +-=0D
 hw/ppc/pnv.c                        |   2 +-=0D
 hw/ppc/ppc405_uc.c                  |   2 +-=0D
 hw/ppc/ppc440_bamboo.c              |   2 +-=0D
 hw/ppc/prep.c                       |   1 -=0D
 hw/ppc/sam460ex.c                   |   2 +-=0D
 hw/ppc/virtex_ml507.c               |   2 +-=0D
 hw/riscv/sifive_e.c                 |   1 -=0D
 hw/riscv/sifive_u.c                 |   1 -=0D
 hw/riscv/virt.c                     |   2 +-=0D
 hw/sparc64/niagara.c                |   2 +-=0D
 hw/sparc64/sun4u.c                  |   3 +-=0D
 hw/xtensa/xtfpga.c                  |   2 +-=0D
 hw/arm/Kconfig                      |  20 ++--=0D
 hw/char/Kconfig                     |   4 +=0D
 hw/char/meson.build                 |   1 +=0D
 hw/display/Kconfig                  |   2 +-=0D
 hw/hppa/Kconfig                     |   2 +-=0D
 hw/loongarch/Kconfig                |   2 +-=0D
 hw/microblaze/Kconfig               |   2 +-=0D
 hw/mips/Kconfig                     |  10 +-=0D
 hw/openrisc/Kconfig                 |   4 +-=0D
 hw/ppc/Kconfig                      |  10 +-=0D
 hw/riscv/Kconfig                    |   2 +-=0D
 hw/sparc64/Kconfig                  |   1 +=0D
 hw/xtensa/Kconfig                   |   2 +-=0D
 62 files changed, 322 insertions(+), 225 deletions(-)=0D
 create mode 100644 include/hw/char/serial-isa.h=0D
 create mode 100644 include/hw/char/serial-mm.h=0D
 create mode 100644 hw/char/serial-mm.c=0D
=0D
-- =0D
2.46.0=0D
=0D

