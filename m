Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B63C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCjA-0000FS-RM; Wed, 15 Jan 2025 18:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCj8-0000F2-V3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:10 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCj7-0003pT-39
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:10 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so164680f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983387; x=1737588187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9FN0qJ22bg0qGnD5rjIKTXdHjku/v+6uYThnjNFqFg=;
 b=F2xVcYjt+x+VH3H6+KZY3o+wL1OA85s71X5rt//4NCfJVuRfB/UR/ei+oasZBgue7U
 M66AWo3vh1hU2ESjKtdiJWL1FFnHD5lto4Sc1yAeymGTbeBeaScoFbt5t6Kv3UJceiYU
 Ysk8IhHCTGhjnGDpt30SJIaWTr1aLSPjKGtB2Goy4OKq6AZaUH9IGkH1/BgCMBYaP2Fe
 ZEvX1BUIaw6bqXxV7AqwvI6Y6loyb7cXKt2mqoikpbIRgua4ru7T8ZpYpHLqiM/na90Q
 ajEMY4MbMvZjwbFCvRlE+SeGmyIQsrsS1utnHpBYbeOxVqSId/d8zt0mO/nomxWxm3bl
 tzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983387; x=1737588187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9FN0qJ22bg0qGnD5rjIKTXdHjku/v+6uYThnjNFqFg=;
 b=lMx2RMp+0ppeM61x7WCo+87hfjxdColoXhXJItRg6qoZXA9yVQbOHTH57TwwVdzydY
 nWJqmUZQs20fVK5tMIc5cL1Fbpy86+3MoUL9qJ9/XQivBgnlsOGUlUXIaCG7xdE+vc+Q
 Y3uvIp0F4a5se9Xa3Wk4ii8GxdUKlRXDXjN830wkyt5oELBYeXapoZsJsdiV9rneCeAp
 ERFtu2B48iMcx3cK5G7DsZ0+9eUBYwaE2WKV3AGklxCEnle4FWRuUa5QOjVKJ+eva5yr
 P/iMYW5E9yn70Fion8mNQoA2F9dWcVAfpHFuIz3QOyyICSxyJd2JFMTZGA1B96P0o0YF
 qWbA==
X-Gm-Message-State: AOJu0Yw7ryUuY5RgxusfDw3LDG399t2ja26FbVwHzwTsvV/8BuhLIUDA
 qdzU2eG5VFwK6oZoBhCsB0IJxNeXJab1gkAj3QvfiHxyXPTemjGB6mBrXfjlgYoIAa1pVQzl7fT
 WIIw=
X-Gm-Gg: ASbGncuNI7Q2ZED+5nIJXLUVaWYFH5BCwjqYzjcr7cMiCeMIXxX7nWh/RVl2uVLHeV/
 kD/jSpxM5U/wZvy5ROQCZkfMMPyuBccrIf0KuQN7nEUnEFpLiHCNMmBzj/+CsNLApxFoXv6d517
 aIIv5FPVjSxc7E+STqEi/PaP0LLntAoHdTMMijYfpltp9KZI4bUw9H5FsnTwKVmNnq8h1jaRW5J
 3QFScgQ4YPBGyDAZ07ZuWvJtQJPl8HeKDWtC24baQsDVuo9mhuhEJhDG04jJ/2f56IGro3AFW3R
 sKbQqru9+1pBU7ZXSAkqiFlQUgrdjhs=
X-Google-Smtp-Source: AGHT+IHfRdzsNdSSx/psFMJNDEUC9uhsLiPN2YFVUCodqTxoZhMflfjkT/TXkCm/r9aiCZeV1RtQZQ==
X-Received: by 2002:a5d:584d:0:b0:386:4a16:dad7 with SMTP id
 ffacd0b85a97d-38a872d2a33mr30326533f8f.10.1736983387087; 
 Wed, 15 Jan 2025 15:23:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c7aesm19207819f8f.53.2025.01.15.15.23.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:23:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 03/21] hw/i386/pc: Remove PCMachineClass::broken_reserved_end
 field
Date: Thu, 16 Jan 2025 00:22:29 +0100
Message-ID: <20250115232247.30364-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

The PCMachineClass::broken_reserved_end field was only used
by the pc-q35-2.4 and pc-i440fx-2.4 machines, which got removed.
Remove it and simplify pc_memory_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  1 -
 hw/i386/pc.c         | 13 +++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 103b54301f8..7fc34bb4a34 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -107,7 +107,6 @@ struct PCMachineClass {
     /* RAM / address space compat: */
     bool gigabyte_align;
     bool has_reserved_memory;
-    bool broken_reserved_end;
     bool enforce_amd_1tb_hole;
     bool isa_bios_alias;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9334b033f65..bf5308160e4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -994,14 +994,13 @@ void pc_memory_init(PCMachineState *pcms,
 
     if (machine->device_memory) {
         uint64_t *val = g_malloc(sizeof(*val));
-        uint64_t res_mem_end = machine->device_memory->base;
-
-        if (!pcmc->broken_reserved_end) {
-            res_mem_end += memory_region_size(&machine->device_memory->mr);
-        }
+        uint64_t res_mem_end;
 
         if (pcms->cxl_devices_state.is_enabled) {
             res_mem_end = cxl_resv_end;
+        } else {
+            res_mem_end = machine->device_memory->base
+                          + memory_region_size(&machine->device_memory->mr);
         }
         *val = cpu_to_le64(ROUND_UP(res_mem_end, 1 * GiB));
         fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*val));
@@ -1039,9 +1038,7 @@ uint64_t pc_pci_hole64_start(void)
         hole64_start = pc_get_cxl_range_end(pcms);
     } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
         pc_get_device_memory_range(pcms, &hole64_start, &size);
-        if (!pcmc->broken_reserved_end) {
-            hole64_start += size;
-        }
+        hole64_start += size;
     } else {
         hole64_start = pc_above_4g_end(pcms);
     }
-- 
2.47.1


