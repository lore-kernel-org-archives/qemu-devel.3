Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A78C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJUZ-0000qL-RT; Tue, 06 May 2025 10:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSE-0006q6-S4
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:34 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJS7-0001Mq-SO
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:28 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a07a7b517dso3742139f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542357; x=1747147157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/fyCoBA0tWbab3gBiKQWh21M4Tnr1243A7o99XgmYbE=;
 b=DyHxCtfbJlJSvguaipk9HIVskXyozTYw9Orhl65rLUH/+rD+dDanPogYZbMGZti071
 2UEUzU0Jde0lJD+GYkzvo9rfaeCYTBco41ntLI6eJEpVuurt53H+YaWa6GkiVEOw8Y6C
 RaE90MM5GvINJlhth+0zmhQs9mhF5Iu4Uu324e0AyYE/jNYvW8Fp+ejJ1/HYkrcdZeo3
 8kyhup7vkDlWGSud+MbhneEiC+18IAwTf2OxrbAfN6LCHzB5PwEsmpl/NWXT+L2pn6Bc
 +RkqFRfuY0CqUoFvflkLiON1aMI1sQQSMIQqQXxg2NHiq24znrN7Nthn2BMfXCiTrwwY
 m7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542357; x=1747147157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/fyCoBA0tWbab3gBiKQWh21M4Tnr1243A7o99XgmYbE=;
 b=pppsfxf53NukZdqd7z9DP+9U+iLkJq+ClY74xyyZm/Oju4OuPqpmxHeDgDnsUmC5Gy
 9VIss8QSY4btLKjlotANcNSyhMJizhD7JfWLAb5NhItsLyHIQzMgO4ROOtAhBle+TxuF
 f0D2QtcGyS2mPS+8CqU3D49DRaA1RDF62Kvdvqe7paclAxw5gtGOeCCJYlHzhnVgkPUb
 uUHlfjG2tPAmugLQMQY5bCJhNt8cRWeGYU0EJ3dDnqVT1g/lpHq6R2xXUXasDOe8sZSg
 KJPfLzLViOb94QyKLGXpr9BcQxyb/ZbEsg2ALLBpz/hAS8Kpj6PmAHub0QN6nEcHHQa6
 nGKQ==
X-Gm-Message-State: AOJu0Yz7nCJfyqhcVlrELwpMQtksFdkMaADcNFatc5NAkzuavneWYL+o
 t+LHNqs3+O+EOGLLR2ZQfk+BP54TVdRJhUqxOQEcMqqOtnQLKNfDFIEG3KPjBY2m4me8DGI2cvC
 D
X-Gm-Gg: ASbGncvc//TYC0jEE6c/5LD9G8/FndQ2EJn9PzWOy7wcENeohSIBG2EDXYnFBwVXKQJ
 uhE2GXgYxnO0FwkjK75CWgHdBpOGHOwiddYJt9mgSZttYaBqnmRmWJZ9HvmW+Few8qr2KGuFbCK
 UaSeaXgd4GgEf6W2i6yQt6xAJ6CZr80C6U0AiJ7W10+skGEKY+IL6YNzSYBI8rsRKR2PXcqZ7zz
 85nDacaxWFx4wMSKx7sWXeDUhO1D1OR2JbXzEjnI08xN57Sg81l2t/L1ZwXth0W2BDaLilWUg6D
 5KSb+Y46QeJoYm2XuO3VPk0ZBDfml9EypOsi4wEg8uEoOsjSRt6TOIgToX+GxlFvuObBlSeOE/2
 h4JHb0IsrE6G52eGiRz9aI3QBgFNHfD8=
X-Google-Smtp-Source: AGHT+IF1/+Oi2SnEXoyODMCGZZJhiiLNAPvJ/doCDJp/AXlzYwa/wmaRJU+0FyCx71tc4UusUawHow==
X-Received: by 2002:a05:6000:1867:b0:39f:a553:3d98 with SMTP id
 ffacd0b85a97d-3a0ac3eb316mr3073477f8f.56.1746542357212; 
 Tue, 06 May 2025 07:39:17 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b20aa6sm220489865e9.27.2025.05.06.07.39.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:39:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 02/19] hw/i386/pc: Remove
 PCMachineClass::broken_reserved_end field
Date: Tue,  6 May 2025 16:38:48 +0200
Message-ID: <20250506143905.4961-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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


