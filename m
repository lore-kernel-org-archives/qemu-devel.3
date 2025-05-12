Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7857AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOj7-0007wi-Cd; Mon, 12 May 2025 04:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOhz-0007Eb-AX
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:29 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOhu-0001hZ-Nx
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a0b6aa08e5so3195000f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039215; x=1747644015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IixRHUe01KuZJgZLnpgydiMWWiime3ZZSmn+E7k3wcw=;
 b=dgyKQIBzJbIjjW3nLerrqaOjaINT9MvaHMVSuz/XCF65FiY5BbyWUF4Na4doKOWgRc
 bbeEdRjiGTEnWVQMEfrLU3/3tD7Nl6L44q657xnQAGA20K41moUzJ7h8Usyf45/TJVDa
 +T5kD7iAACA572N4wPDGAarbBFDa3vL/AFFh6cafrxKin5IrY8v9B6gjQAu8GnVkbrNW
 DPlCXRddFJkaKO4zC4r7schQGn32qR/p/vG4VUMu0P7FStvJmmj/IO9U8NIuPrwNRoEz
 enYheIimRIY6sgrgRzgv6eKbgtMNjpruRV7KMHIuhxtpgebN/SBx7iPEIJlzolEdcJJ2
 eRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039215; x=1747644015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IixRHUe01KuZJgZLnpgydiMWWiime3ZZSmn+E7k3wcw=;
 b=hOyKISo/Hzdnp6qaUwetvedS/cYxJRT3bhU0OdyZIOpPW0s0+GbWfURQNoYg2I07Q/
 4W/yOMk6GGG7PdqciELpQSxTEyjVEDzCGEyHFznW7uyfkv1jHvcY2kQVXoHWlurkz14K
 3vnPld35/9bNUv6Da7Vd88f93mhxCL9hZknLNRuT4WzxuExbxLy/JbYg/VvP7HRotC6u
 uZVjJN9Fpk09kkdedPpxt43H6W97p0Y81reosuEf6ONfpVQ7AAbtJ7HLXI/X3HA5KZaz
 UniB9cj91lAKEBhSFSzk2eKdFE3qV8GYkId3nkIjh6Lm1wj74/Yw9hJ10upAsoRFVCjE
 y2qg==
X-Gm-Message-State: AOJu0YxWad8/LCjuj/zwfyWvGI58fdcAXL8TobR5i8EOQTPlkiUA1nKa
 AHwcrTkZV0x9wlPL1Sf7oXxu0gXL/qsPA3xpwoUtjhmogCYg9N1PVfxrvw3bUDBpM0Ojisqosx8
 YYcRggg==
X-Gm-Gg: ASbGncs3+UBhvZRX/YauWavXWhxHtbwytCgpgdL1h5khAUr6k13JeM4WkuWuN1a6jxJ
 Fm5n+QmxQ+eXeFVapt+NLLz9TwPIYD7RrtJl47asaL9goF7GrIL5qR1eWzD9JWoBSyAIqnKKqk7
 6lR/Dq51Qlv3nvUm0o3Cr2xwAd+MSNmhsbe9g4MgIphbGOu8qwl0eBiSYfgb050fF2vtAEFu5y0
 gHcOe23Nco9TvdwcvH2fpAa71DQphaUFU8PRYMg1fBhQhT4PfoDY2fpsc9Ah95h95YY0wu1KIPP
 I04w/cQ75eHMAOUlWWUWosSqNutJSvh0yv8mHZoB6OBlj1zFQFed+b1ZbrhY+D15+00HxJpkJLD
 AKZFImokanNcyJvV0lU/XZTk=
X-Google-Smtp-Source: AGHT+IHkY14JnVVwWW9217caYP4D4Z9PTGzMMPlEo4dYveLcUClKds/kkRR6QTmqViyc1UR5EAhBmw==
X-Received: by 2002:adf:fdcd:0:b0:3a1:f768:588a with SMTP id
 ffacd0b85a97d-3a1f7685969mr7962231f8f.10.1747039215080; 
 Mon, 12 May 2025 01:40:15 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2fc4sm11835252f8f.56.2025.05.12.01.40.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:40:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 02/19] hw/i386/pc: Remove
 PCMachineClass::broken_reserved_end field
Date: Mon, 12 May 2025 10:39:31 +0200
Message-ID: <20250512083948.39294-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/i386/pc.h |  1 -
 hw/i386/pc.c         | 13 +++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 9563674e2da..f4a874b17fc 100644
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
index 70656157ca0..c8bb4a3ee47 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -999,14 +999,13 @@ void pc_memory_init(PCMachineState *pcms,
 
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
@@ -1044,9 +1043,7 @@ uint64_t pc_pci_hole64_start(void)
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


