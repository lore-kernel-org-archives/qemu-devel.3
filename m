Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33A1C624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20Oe-0008TU-OE; Thu, 03 Sep 2026 01:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20OZ-0008Op-Jc
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:55 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20OY-0006XB-19
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:55 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-85339ed040aso1639721b3a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414832; x=1789019632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x1RKetAYUO6DQYUtxx7Wjswe/LX2S4835vuil13oPxY=;
 b=FsAMsirK0sKPSOEtisTMw0vKvlmkqX0IbVoqPNbDyEHE+S6FmbcFO9601s9+M/LdD0
 w2IZ6lW4bD7aSfh0Y1EMJRxN6VoRsfMYARYmMfoXqBkOYRkXMc5iPqyyIJTXZOPEpiBD
 TAgoL3ld2XwRVv1/Wk+Hhr6KfGu5nFGLhUa6liDk8ja7H7KV7BdsslUxUNI4CwZzprAV
 0iGN5OTwRq3aXA2HzBBBzqfW/TC9l55q9037BwHcWprvyNXJmkU2ZcEYn3r75Wd9x5LR
 3+8Gdide+TpjfIhscePNEZ32h1W7u+PVCSsWoBrflm9B2ZV+LNFDPjpoOWKz+Ol1/9xP
 gj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414832; x=1789019632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x1RKetAYUO6DQYUtxx7Wjswe/LX2S4835vuil13oPxY=;
 b=WPym7PWTXhiAFFA1/SM4v32gOCl6AOq+muiG3tjcHFUOC4TiHmR4T5mePs4MpTO+L/
 7UC8Q86MvijzYi3v3kHf1x0GqTpclXGRHa39WNJwW2tN/vEukeeAmg6uN+gThTigc0+i
 yJAlKVFzaSMgQHo5dFoNMlh0CaA6fzSypCn8WYM0/XirGw92FGBskP8a+Z6rWkN/pe8i
 UU6bf5bHdQhDWVhe+0ZT2tbpcZn8jIWWFliQXlvpEmK220IM1JFkFDdGzVrM3CH9amPK
 BKi2OppKBNEiC4Xe/7UMiUNcKWD8ConeerLA9rUB264lpxVmLFXTKsXh5TKqE82GNLR+
 sIpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0oEuJqw1B5wk52aSTHwxecTi5YnCF8QRitAY1TujjQfjVweuWXuOSPzLLiDSrlDERfoKGQl+vovx8@nongnu.org
X-Gm-Message-State: AFuF++n4owwBxK4+KIfz0lWact4B0P34YWunCankrz3e0kul4UeQxnfr
 xvliEJ3ID+68ab3KZXbZPELTE1zeKLddlhGait+SsJacvDXzNVWaYJUT
X-Gm-Gg: AYBFou0kWnbJC8rUUGgphxpNxw9EUzmvcpRlz3r1uvT2o4uWA8bE/fjqA38rV56NlaA
 GMwmcNQc5BMMs04iF6Fdw9J3cXAmSgOk+ZkQXjvL5zdlpTmpuZzF8jL+z4xTXL50QuFk+LLz96C
 6REXbIJUd1BNtf3Hq4a+3g63rc3aA5nF/7Ko4WiogbwvcsaoVvxGTlwsQahpZXBug8zHMMwqMvj
 lXqxIh5PIE21CrvaELfuHyoacu0mIlryVHCUlZq8dP0pz0tntXeXl4j6A7gNEwzbgiuA0qWAba3
 cOkOyaKC4h22rwuRex+Ctzu/ezn7tDHZdkHngOIY05CCk8qMIQ0etAFeJUQVISmY3/Nw4Nr+eIU
 rmh3em302+P7UEg0/1j+bd7cZlS0Njgg7MD5bAIb6Wo3SUT/5phuqgF7/PSFvakJQHD6rP541ov
 MdP2c1G3U9YVr49U5tSu/lrnhUCwj+oMIVKEBz65i+84T/yzKz839PDU+65Y1ixhpy8KKAkMVHG
 65ktcy3oCmEm/CBlQqtjzwjmUx6m9mIHxdoM6rKjpgX6QJN1kB73D/AGU8+2E78yg8+trDlcV6A
 /SA/fPUaTG6oaO7zmUw3
X-Received: by 2002:a05:6a20:6a1a:b0:3d3:b02a:61a5 with SMTP id
 adf61e73a8af0-3d9b0a3a286mr12173308637.28.1788414831639; 
 Wed, 02 Sep 2026 22:53:51 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:53:50 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 16/16] hw/riscv/atlantis: Map the SoC through a memory
 container
Date: Thu,  3 Sep 2026 15:21:30 +0930
Message-ID: <20260903055131.257903-17-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Give the Atlantis SoC a 'memory' link property. The machine creates a
container MemoryRegion, maps it at address 0 of system memory, and
passes it to the SoC together with the machine RAM. The SoC maps devices
into the 'memory' container instead of system memory, allowing
TTAtlantisSoCState to be composed together with other SoCs in the
future.

This prepares the machine for adding other microcontrollers that share
the memory bus with the Ascalon complex (aka the Atlantis SoC), but with
their own view of the address map.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |  1 +
 hw/riscv/tt_atlantis.c         | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 5d4e4d133bd9..3923308b7c89 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -53,6 +53,7 @@ struct TTAtlantisState {
     /*< public >*/
     Notifier machine_done;
 
+    MemoryRegion soc_memory;
     TTAtlantisSoCState soc;
 };
 
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 6c46121287c7..c6f235a7eac0 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -504,8 +504,10 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     ram_addr_t lo_ram_size, ram_size;
     int hart_count = s->num_harts;
 
-    s->memory = get_system_memory();
-
+    if (!s->memory) {
+        error_setg(errp, "'memory' link is not set");
+        return;
+    }
     if (!s->dram) {
         error_setg(errp, "'dram' link is not set");
         return;
@@ -524,6 +526,8 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->cpus), "resetvec",
                             s->memmap[TT_ATL_BOOTROM].base,
                             &error_abort);
+    object_property_set_link(OBJECT(&s->cpus), "memory", OBJECT(s->memory),
+                             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpus), errp)) {
         return;
     }
@@ -615,6 +619,8 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 static const Property tt_atlantis_soc_props[] = {
     DEFINE_PROP_STRING("cpu-type", TTAtlantisSoCState, cpu_type),
     DEFINE_PROP_UINT32("num-harts", TTAtlantisSoCState, num_harts, 8),
+    DEFINE_PROP_LINK("memory", TTAtlantisSoCState, memory,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_LINK("dram", TTAtlantisSoCState, dram,
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
@@ -634,12 +640,19 @@ static void tt_atlantis_machine_init(MachineState *machine)
     TTAtlantisState *ams = TT_ATLANTIS_MACHINE(machine);
     TTAtlantisSoCState *s = &ams->soc;
 
+    memory_region_init(&ams->soc_memory, OBJECT(machine),
+                       "tt-atlantis.soc-memory", UINT64_MAX);
+    memory_region_add_subregion(get_system_memory(), 0, &ams->soc_memory);
+
     object_initialize_child(OBJECT(machine), "soc", &ams->soc,
                             TYPE_TT_ATLANTIS_SOC);
     object_property_set_str(OBJECT(&ams->soc), "cpu-type", machine->cpu_type,
                             &error_abort);
     object_property_set_int(OBJECT(&ams->soc), "num-harts", machine->smp.cpus,
                             &error_abort);
+
+    object_property_set_link(OBJECT(&ams->soc), "memory",
+                             OBJECT(&ams->soc_memory), &error_abort);
     object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
                              &error_abort);
     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
-- 
2.47.3


