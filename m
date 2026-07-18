Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E969EC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD6E-0008KW-IF; Sat, 18 Jul 2026 18:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD6C-0008D8-On; Sat, 18 Jul 2026 18:01:32 -0400
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.12.53.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD6A-0005Fx-Ty; Sat, 18 Jul 2026 18:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412090; x=1815948090;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qNvBAQnsropPFuCvMHAkpcPv/ub05GpIkFSZ2G7cECE=;
 b=fsovACCvlIyvL5l/qV3FJAmQt0WaYLFkXfkAl1KV4eR613Jx5DvsHJSH
 t59NoOwETVdAngDU8+uKKmpk9iSoapEtrVqSkGLgi33bEhg+Ysqr2W+Hw
 xVCMp2+nPh7MigvbKzmfYmQZ/CThHC+wb3n8ApYXMA+o1VFunRDqz6WQm
 36ADgaW3Hntb4KbId7eoESujLa/fmGINFZVoQ3AJ8tDuSp6TkqLhff348
 OQN9pdzTCSmFHa/UbBZ42RtKm9SBDd9495ua5qmMT2Az1SnHZZ6V6yFCk
 Rm8/A5AqsrC7BiDLz8tMGJRNZ3CEVxkbVfupiTmfIY4FJLk05hmH//DKi A==;
X-CSE-ConnectionGUID: IFy8SzVNTJ6KYUJKuSfx9w==
X-CSE-MsgGUID: hWjvNeiBRWKuLpvT0bPDiw==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23795565"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:01:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:15836]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.151:2525]
 with esmtp (Farcaster)
 id f004e84a-99c8-4385-9526-854b0bdd6e20; Sat, 18 Jul 2026 22:01:27 +0000 (UTC)
X-Farcaster-Flow-ID: f004e84a-99c8-4385-9526-854b0bdd6e20
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:01:26 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:01:17 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 087/137] cpu: Remove cpu_create_orphan()
Date: Sat, 18 Jul 2026 21:36:02 +0000
Message-ID: <20260718213652.37673-88-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.12.53.23;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

All targets create their CPUs with an explicit parent now.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/cpu-common.c  | 12 ------------
 include/hw/core/cpu.h | 10 ----------
 2 files changed, 22 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index eef243c1ad..829a044e9e 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -68,18 +68,6 @@ CPUState *cpu_create(Object *parent, const char *id, const char *typename)
     return cpu;
 }
 
-CPUState *cpu_create_orphan(const char *typename)
-{
-    Error *err = NULL;
-    CPUState *cpu = CPU(object_new(typename));
-    if (!qdev_realize(DEVICE(cpu), NULL, &err)) {
-        error_report_err(err);
-        object_unref(OBJECT(cpu));
-        exit(EXIT_FAILURE);
-    }
-    return cpu;
-}
-
 void cpu_reset_interrupt(CPUState *cpu, int mask)
 {
     qatomic_and(&cpu->interrupt_request, ~mask);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1b2ec1ab1e..544740a699 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -857,16 +857,6 @@ char *cpu_model_from_type(const char *typename);
  */
 CPUState *cpu_create(Object *parent, const char *id, const char *typename);
 
-/**
- * cpu_create_orphan:
- * @typename: The CPU type.
- *
- * Instantiates a CPU and realizes the CPU.
- *
- * Returns: A #CPUState or %NULL if an error occurred.
- */
-CPUState *cpu_create_orphan(const char *typename);
-
 /**
  * parse_cpu_option:
  * @cpu_option: The -cpu option including optional parameters.
-- 
2.47.1


