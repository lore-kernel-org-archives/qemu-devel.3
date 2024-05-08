Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987FDC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lVr-0001Bj-Jg; Wed, 08 May 2024 13:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVn-0001An-OL
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:28 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVl-00028b-6J
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:26 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a599eedc8eeso2561466b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715190923; x=1715795723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xf3jKnS45LzINVXGJFDGMTra3RQ9wnYhNqwEpjOfSQw=;
 b=U/caoGQc0R+whRnIdOAbAGoUUyVCJyvbzzC1sK1BAIe96OPTy5CR4snNyZo7/Q19Kl
 Cu6dgXsbp8WTztS2wyAGNEsbhZdBO07AlJwAGRkotbIvSVyh2ifRjDn04R0w1/VO9Ndl
 scbTBL2cdJEhANfGNckUCzJMVg8zdazU1+SnJso+gyELyhTcjn9cARPmBRmOaKjuXzN3
 wR1hG80UDHPUURL7COLT+iDeS+IZjEOZqpeumTHaQZjAF8FL686AR4jsKAhnuZvLTV9l
 tYnMD2ogFadGxvha+r1U4tN7f/qUswPUaNrNgr9l80Jgk/79LgWNQ/CpbiWK+rnx1Ae9
 bgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190923; x=1715795723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xf3jKnS45LzINVXGJFDGMTra3RQ9wnYhNqwEpjOfSQw=;
 b=VAavroGZ1iV8P7IulAZ+Tckh240nZWrA3I3i5WUimAg9HQkSRq8BzNm+k3XnimNDmR
 fIvg3HqvAcs15R2EU35c9L+avH9D5vW4kYoRQoxhGT3C3OHORv7kit0zye7Yia8iqj1C
 lZGglsgIwFl+0YRCZRECiiH8isOEZOtBjLkjYDeRkuf47k/hoIFpHQvFs4wDmcSnPbBu
 B6nf8R5vILarysyp6hsKDhM5BG5LBXI8ipYK3nTw9V+LohITsCPheo7A5iJyP3Xek9RE
 +QZks56wtTCLTFfolXWV3SoumOSNi5wGNzvEWfNhn37A0V+vSn2+ywVvx7X0Cve4y4Ne
 sQFg==
X-Gm-Message-State: AOJu0YwvdDmDLqRJQ0xmO8pFWXiIV7uaqGEOHdu2Dnsp7HrAfbE90cNm
 SdmiTQQjCm3XoiFuYsFpxfk9FKbkUCCi6xIdKX5wpf/ENy8Gm9sJxhE5uQ==
X-Google-Smtp-Source: AGHT+IE6Q5x3GxRyUV0pwEaQzA9Cp7ogOewGCA5jqk2rYBF7tkPPFViQInZeNi555vFN/70sl3EnOg==
X-Received: by 2002:a17:906:2352:b0:a55:a895:46ae with SMTP id
 a640c23a62f3a-a59fb9d061bmr199009766b.63.1715190923065; 
 Wed, 08 May 2024 10:55:23 -0700 (PDT)
Received: from archlinux.. (dynamic-077-013-167-103.77.13.pool.telefonica.de.
 [77.13.167.103]) by smtp.gmail.com with ESMTPSA id
 a24-20020a170906671800b00a59c5a129basm4483821ejp.80.2024.05.08.10.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 10:55:22 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 5/6] hw/i386/x86: Extract x86_isa_bios_init() from
 x86_bios_rom_init()
Date: Wed,  8 May 2024 19:55:06 +0200
Message-ID: <20240508175507.22270-6-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508175507.22270-1-shentey@gmail.com>
References: <20240508175507.22270-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The function is inspired by pc_isa_bios_init() and should eventually replace it.
Using x86_isa_bios_init() rather than pc_isa_bios_init() fixes pflash commands
to work in the isa-bios region.

While at it convert the magic number 0x100000 (== 1MiB) to increase readability.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/x86.h |  2 ++
 hw/i386/x86.c         | 25 ++++++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 55c6809ae0..d7b7d3f3ce 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -129,6 +129,8 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
 void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp);
 
+void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
+                       MemoryRegion *bios, bool read_only);
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 29167de97d..c61f4ebfa6 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1128,12 +1128,25 @@ void x86_load_linux(X86MachineState *x86ms,
     nb_option_roms++;
 }
 
+void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
+                       MemoryRegion *bios, bool read_only)
+{
+    uint64_t bios_size = memory_region_size(bios);
+    uint64_t isa_bios_size = MIN(bios_size, 128 * KiB);
+
+    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+                             bios_size - isa_bios_size, isa_bios_size);
+    memory_region_add_subregion_overlap(isa_memory, 1 * MiB - isa_bios_size,
+                                        isa_bios, 1);
+    memory_region_set_readonly(isa_bios, read_only);
+}
+
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw)
 {
     const char *bios_name;
     char *filename;
-    int bios_size, isa_bios_size;
+    int bios_size;
     ssize_t ret;
 
     /* BIOS load */
@@ -1171,14 +1184,8 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     g_free(filename);
 
     /* map the last 128KB of the BIOS in ISA space */
-    isa_bios_size = MIN(bios_size, 128 * KiB);
-    memory_region_init_alias(&x86ms->isa_bios, NULL, "isa-bios", &x86ms->bios,
-                             bios_size - isa_bios_size, isa_bios_size);
-    memory_region_add_subregion_overlap(rom_memory,
-                                        0x100000 - isa_bios_size,
-                                        &x86ms->isa_bios,
-                                        1);
-    memory_region_set_readonly(&x86ms->isa_bios, !isapc_ram_fw);
+    x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
+                      !isapc_ram_fw);
 
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
-- 
2.45.0


