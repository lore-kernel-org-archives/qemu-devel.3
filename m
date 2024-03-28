Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD8ACD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps7l-00068d-Pk; Thu, 28 Mar 2024 11:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7k-0005wQ-4B
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:04 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7i-0002ca-AN
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:03 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a466e53f8c0so144806466b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641420; x=1712246220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBrGlAtp7IiqJxUt6Mnv7AOEnMWPJd0FVBqTzh3q09E=;
 b=I7d976MewaPvuYiDLCGsTimNZLPb8OOBAW6AroOgs3sUOA5qKr4UynSOrYTTjsWaYe
 A0nUtCh2qWsNaTPEr0xwY8lcIQD/tGYiJ9lTmigNh3taLsRyECwgBxkJjAu/HvnfEaux
 KZbwvNTt1SiaULh9SBNSqOHvVnmC4sio8LdEMmmzlRM+NeqnQBRm98C6d9sW7tOIrb7F
 aE+0CTowNqbfVE32ffNlPAn7ALg4y7aXQYF4fEikGBeeDnERnqL8Rje4N97fpMaZVXHK
 CIqglL7XCgnOVpv6gr7eDO9xrA6uw4p725mv+OIVAxc1TIetGTeueN89oLaYmvAhtpQA
 dD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641420; x=1712246220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBrGlAtp7IiqJxUt6Mnv7AOEnMWPJd0FVBqTzh3q09E=;
 b=tlajuQVX6bBKgxTdSTj2/OuEi6OjjegVBGYFu4+dW+PIz5RN3VvVPOK2LLrC22SWcP
 glAbBO0S0sDIg7zxJLUtM0knCPNU01860Yzo27iwNmhEmzqOIFIqmvMsRtdS93rPTdHI
 w+bg+SG+uNZWbiwhhzbhTkFpfGvihfh04uKe+Mpwm3tK8af3Stzowbx89H3/swOp371d
 uJYjOjEcbxTMZ9fehPGPaAgSo5JieD7RWKmRojnvtK0+gXDtYvWPEVg1PdG7ACJe8BJF
 hhsENu+cw6kJ1GJdo6rgbP4emG50xqjz1hPotz88OBcWTsBdXWn+e0WltENuSFU6RWYN
 7AHA==
X-Gm-Message-State: AOJu0YypXam0aq6uEBXfbwuawSTs0TbfHdrnMr2dHJpjktQC3z5OkL59
 5ZSnnyKBXoAJ387zT47qJt8+sMYUKZfRHabn8V+p3AaV8acJHCBOlMLExaLBM2+lwnXy1ge4fDA
 m
X-Google-Smtp-Source: AGHT+IEOvg34oYcu9GAIHQIWSpLYGC94raSmAj67zD4Gs/B4BPRdpoH1JkHeTSn1iij0r48HVMXasQ==
X-Received: by 2002:a17:906:3289:b0:a46:420f:8ecb with SMTP id
 9-20020a170906328900b00a46420f8ecbmr1904346ejw.62.1711641420490; 
 Thu, 28 Mar 2024 08:57:00 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 c7-20020a170906340700b00a468bf8586bsm906768ejb.174.2024.03.28.08.56.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:57:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 22/29] hw/i386/fw_cfg: Define
 fw_cfg_build_smbios() stub
Date: Thu, 28 Mar 2024 16:54:30 +0100
Message-ID: <20240328155439.58719-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We are going to refactor fw_cfg_build_smbios() in the
next patches. In order to avoid too much #ifdef'ry in
it, define a stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/fw_cfg-smbios-stub.c | 15 +++++++++++++++
 hw/i386/fw_cfg.c             |  4 ++--
 hw/i386/meson.build          |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 hw/i386/fw_cfg-smbios-stub.c

diff --git a/hw/i386/fw_cfg-smbios-stub.c b/hw/i386/fw_cfg-smbios-stub.c
new file mode 100644
index 0000000000..37dbfdee7c
--- /dev/null
+++ b/hw/i386/fw_cfg-smbios-stub.c
@@ -0,0 +1,15 @@
+/*
+ * QEMU fw_cfg/SMBIOS stubs
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/firmware/smbios.h"
+#include "fw_cfg.h"
+
+void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
+                         SmbiosEntryPointType ep_type)
+{
+}
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index ecc4047a4b..14a7dfbdc9 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -48,10 +48,10 @@ const char *fw_cfg_arch_key_name(uint16_t key)
     return NULL;
 }
 
+#ifdef CONFIG_SMBIOS
 void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
                          SmbiosEntryPointType ep_type)
 {
-#ifdef CONFIG_SMBIOS
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     struct smbios_phys_mem_area *mem_array;
@@ -100,8 +100,8 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
         fw_cfg_add_file(fw_cfg, "etc/smbios/smbios-anchor",
                         smbios_anchor, smbios_anchor_len);
     }
-#endif
 }
+#endif
 
 FWCfgState *fw_cfg_arch_create(MachineState *ms,
                                       uint16_t boot_cpus,
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index d8b70ef3e9..1a6e731196 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -6,6 +6,7 @@ i386_ss.add(files(
   'multiboot.c',
   'x86.c',
 ))
+i386_ss.add(when: 'CONFIG_SMBIOS', if_false: files('fw_cfg-smbios-stub.c'))
 
 i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
                                       if_false: files('x86-iommu-stub.c'))
-- 
2.41.0


