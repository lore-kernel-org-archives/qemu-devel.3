Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2626C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ldc-0000ZN-Lj; Tue, 29 Apr 2025 10:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lda-0000Xn-PY
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:08:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldX-0006Ej-Jc
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:08:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so5527191f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935717; x=1746540517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/fyCoBA0tWbab3gBiKQWh21M4Tnr1243A7o99XgmYbE=;
 b=Yl5L8NmC4RYYfD3th7N483rNT0hYxpDnufDzJlwEkiADXpC+fRy2lYOunF77HO+ad4
 wR/JNSLSDfMmvNlsLNFv8736cqdLV9JPnpes7xJtSw00K87ptaJCh05NDEBTPj0RJFZZ
 ZtlVn/uLaY3IUaZvPLa1u8OykcV+i7covs1z5UQN5wj3U2oMRvKQESJJ6dg00hKYaoED
 nNsQC1XPeXSgpt9zbuNgKf92cWnfTazmYXBeF6lypqvJRi7ZMlunmpaafGXDqdnrjiQf
 LpqjRhxXZsLipXyBMiNYQYZLPMU1+Qg6szM5tQN3mAQW9N4ojkOP+K+6sZ9SSVK/YjwP
 20VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935717; x=1746540517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/fyCoBA0tWbab3gBiKQWh21M4Tnr1243A7o99XgmYbE=;
 b=mR3shrfw3w/Rq2U0qhG93jyfGw3o0r4r22VOLKs66fQcNoiXT63ceZSeBofSVLuQVc
 gCtTUrCuy75Tt7CP+3i0vRmJpQ7Putu+fWrXWHQiM6sbK2sMHJNXTTO81tU5QfrWcLSF
 uWKJoMghEgGTjgFaZUqedQ2GzNdxlDz/lRhxlnGZII02GLvonP8eOhPcPgqPVBoUnRi/
 fzGm+bnLDsSiTEntVQbGRJuVXM0khqW8XAA6rkjnqjXGU5pqqawCGTPKzoOBzc6pkv9O
 Xh+Zbv++XrSTNtVlt6pM2VTiOuWAC7iwJwU8Qhd28bYrr4+WQSSRwuXyowX1up+8LA4x
 iWTA==
X-Gm-Message-State: AOJu0Ywn135uB32jWgcIjEZvz4I8blhAWCCRyuBSXTHUFsDc5+kW7lHa
 BR7+aDKh4HHxJ0lTdzWFiIAWv4kYiQxmsyjGVwPgPmvxiOV+7qh6k/lzvhejWnGwlpKAVkSANoH
 U
X-Gm-Gg: ASbGncttMR42ITLSoPFw0Ex8gkpFG570wDL1OgG/c/vfCU8Nb8nbMJyEhx1zrVBJoIP
 2/NZYNM36rMrQYRkk1aJmezj7Rbnb1wV5M2RHjhQWzwMMIWQigEMB1aWgkSYTn5xpV3GH+F7EsG
 qPd7X7nD7FFekov3QvrEGk+9jLd0oDVlhXCn920KsDFcjVPrkOBL48Nre53rvmAhi3OqbjI1xLL
 1KOYgTt+ecPatu57tjmn8IqUhlaYpVL6fIsGzvips6ePJSO4B5EeyU6n+iBdO6fdc9WEFqx/WOf
 LETVsQDY1hbOiwUG7gV2hyLJa/2gAONGk0/KzI7LYDCD0kSKS9ZwN1hTa8fFppDGDsMtq6ZUMs1
 KXiXSo/oaW+dI58PHLJqVKlzWLAURoKM=
X-Google-Smtp-Source: AGHT+IGxwNGZqzN3N5fqP3XhpSbMFiSPv55y+L0ZHJEuMsvopZsKHzkF7yroosJigv1sZcYFN6RQnA==
X-Received: by 2002:a05:6000:401e:b0:39c:e0e:bb46 with SMTP id
 ffacd0b85a97d-3a07aa5fd30mr8824514f8f.4.1745935717318; 
 Tue, 29 Apr 2025 07:08:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4f88sm13718668f8f.29.2025.04.29.07.08.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:08:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 02/19] hw/i386/pc: Remove
 PCMachineClass::broken_reserved_end field
Date: Tue, 29 Apr 2025 16:08:08 +0200
Message-ID: <20250429140825.25964-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
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


