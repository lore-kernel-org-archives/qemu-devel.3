Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F11C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBDm-000070-W1; Mon, 19 Aug 2024 18:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBDj-0008RA-AO
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:27 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBDh-0000fR-6J
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:27 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-371b97cfd6fso1223856f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107883; x=1724712683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cABVR/iwvRF5rjxi/ggX4bv+0ymSrfIpGmDDKhz/Kik=;
 b=EAWeAZZ1IMQElqhd4yvAmBIiFi7JDc942OxCNFeXwBYrbnKE1zeib37XdU913+ttfn
 YH9/yyKtAHwpr8SjPPbLcTtGPbd3VFA/jx7EtiLmRv7SLQw/3EX34kai42gZVcF5D8um
 KN/VH3K+6r7wd1Rnxl0iqsfDnYJqriEoQl6EhArcTGS770mehipF4JaH0aDneafe3I6U
 3xkVL7diVMwjET0Opiv5yyJNTdS3iuiom1dvBHjQXDGgDvb7ObtlOLVUDMYtXWmVScPA
 KJv5/91l7KVfNuXYMf0erPvUFVC1fkII8LfdtFK4+rR7vxh4eG+2kAeJH3Uf+3EY8FCb
 nFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107883; x=1724712683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cABVR/iwvRF5rjxi/ggX4bv+0ymSrfIpGmDDKhz/Kik=;
 b=naXPoD0QBqhnMIAlYPgB33NOXTBKEKz9Csf4Yg51PuHRMptPVEJmO32EYhz41p0cmL
 3tOArfqN9EjJhYAET4RVcy89CPZS8JldyPwr2paQyCjlac+uaKywkQbkM6QGGrpQrtSv
 zvtoD7Q3mIALCv/pFIZeVvwBCPQmhhld1GXpM3PbtPJMGzdi3N4WIG0uEU1Jo2EqT2ZN
 qwr0VIPt0ECG9DFnN/+RXgShiSQdC4XF09DhMrJzX+mYAuFMGfUZdqQisYoRypJXT4c0
 VEapXCTX380XnCZ6KefgJ2dSJCGAgDXcMN+knkCKA00NPKubaJ4Sb67IrI9O7n09oFk2
 8vTA==
X-Gm-Message-State: AOJu0Yz7Q79saETOc4/r8tfbL4Kb2pYYStZYPu/JD4v1UXhUt8lF5Afs
 mfn0EKd++Fz1dV3WBzmihpon2KE6PGX7mJ30zJBIUwblPxOmbmBldXuNyJ5jV6LO8m/gAoOrKkR
 CVis=
X-Google-Smtp-Source: AGHT+IEV5+eF3IBsD8EaWcdJ5RVlrubTMeVYcJoCyzCKWIiCsaOqVO6wBNWzGDsc8MFKMBVEHlBvwA==
X-Received: by 2002:a5d:4bc2:0:b0:368:4e4f:cec5 with SMTP id
 ffacd0b85a97d-37194673878mr7725191f8f.35.1724107883091; 
 Mon, 19 Aug 2024 15:51:23 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189896a9csm11586898f8f.79.2024.08.19.15.51.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:51:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/20] hw/mips/loongson3_virt: Store core_iocsr into
 LoongsonMachineState
Date: Tue, 20 Aug 2024 00:50:57 +0200
Message-ID: <20240819225116.17928-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Link: https://lore.kernel.org/qemu-devel/972034d6-23b3-415a-b401-b8bc1cc515c9@linaro.org/
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240621-loongson3-ipi-follow-v2-1-848eafcbb67e@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 408e3d7054..27a85e3614 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -97,6 +97,7 @@ struct LoongsonMachineState {
     MemoryRegion *pio_alias;
     MemoryRegion *mmio_alias;
     MemoryRegion *ecam_alias;
+    MemoryRegion *core_iocsr[LOONGSON_MAX_VCPUS];
 };
 typedef struct LoongsonMachineState LoongsonMachineState;
 
@@ -493,6 +494,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     ram_addr_t ram_size = machine->ram_size;
+    LoongsonMachineState *s = LOONGSON_MACHINE(machine);
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
@@ -586,6 +588,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
                                      iocsr, 0, UINT32_MAX);
             memory_region_add_subregion(&MIPS_CPU(cpu)->env.iocsr.mr,
                                         0, core_iocsr);
+            s->core_iocsr[i] = core_iocsr;
         }
 
         if (node > 0) {
-- 
2.45.2


