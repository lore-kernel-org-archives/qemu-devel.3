Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D859DCFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 04:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNNmD-0008FO-Nh; Sun, 23 Nov 2025 23:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNNmB-0008Dp-Kw
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 23:02:07 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNNmA-0003JO-0p
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 23:02:07 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-477b1cc8fb4so21542165e9.1
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 20:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763956924; x=1764561724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Ag186/Duxi1QrTx73gaJvoeNSOx3x+Fko0RiH98G3o=;
 b=kwrFBX4mrv/4r0F62njc+T0nyEskJBDKKhTPH6A6YEUF4jRqab2/5Iz4FR2fItHbGs
 iKUqHFy9qosC2I+p1voxrbcDLhDMyvC88Zn7SLpCqkLDc5Vr1YVVaHFqbSqBNljuPGRO
 sDX6XwSc98SGQuIo+WMJ469+9/X5dOmu0JDCelL2wgeagQW2wrNwI8gfkZh3hnCbN3bJ
 IIG+UbNZcwQlp5Y9U0GYJ9YzynzgpBozI5v0rNZkHaJ3r1orqf546M3le7yigVNg4bZ2
 kogK0Rme9SoJgKmsUD6F3hUwn0rhklGx3Z+MlFmxvSZERepXSDVYd+epG0vndIV81Ke+
 T9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763956924; x=1764561724;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Ag186/Duxi1QrTx73gaJvoeNSOx3x+Fko0RiH98G3o=;
 b=b7dVXP8V03FOcE2viYKDme2XLjsHXYu97TiL/0bnNnpfAfIcy1HXZfW/CQhyTGODDT
 FFIQ3eNQXrAZRLQSu2S+cuTAtFyMR+EtRi4AhHAKFCaIZ7OGk+mdRd+cc69VqqEO+c0l
 /V7KEL2wLlbj6MgJVAb2gwFOLctudRET8cwIJL8Yt/aHTTR5m7VegfN5a8wvpkgQAEgA
 VkjRTxUgApPKQX6yYZg4kHc2dJRv63yPQry3CieSLufVmO9dNhKLpixQl3nwimX5NYhK
 e0Ucee9hrMbXLiukyiZHOFKPoZ0NcAp7S4MRZwx5Idx1fqjk3Sov8iKnliwQhbZfbi+W
 re+g==
X-Gm-Message-State: AOJu0Yz4Myw2nITl/j40+ibQ4XzDBZTWEDXBp6QKexMM5MfFEMni/E/i
 ChpSqBQy4jZxVEz+tZxHjkaHBmF6n2269BY/7rFLK44L5qav6Q1VAqAFB4JjokVIcqpoBZv0WpZ
 hnIoqw/UAWorm
X-Gm-Gg: ASbGncsQUWEQ3PB1bASPP9tukQhogQL4p4HCBhkN1ATXwPzh+UpQfchAZbgc7Wj1dso
 Y2AoWPVWZ1dACEcUHKjhwn0EXas2nN/WAOPwm0JiESY3qJKKnJhrd88rFn4Vh1Gv9mIMuBXDxhP
 IR7PYtT4hGPyHWM8y9aLB/Sa2yLtGl7RWVQR+jkvGqhOaeqVVuCN2C8DQD4LbgB49FbLdwJMMez
 NVO52MdLGDLqFMaE4eG2zi7NGEVGSBaeVxFb5y4+nj4kLP2uil19J7EDms6BJzorIX1HVDxVoql
 qWr6NrREIpED/ROcd3zwiEUieEghkmHfrCQY2jJ9Yz7qEP0eUVb8UVU0JcGvMmoV52RRWzVrbd3
 adsmA9iqOz3ouCqAXBRBMSA/aA52fWxRshtRD4EWo0vgiJMdcphJaHMiKEDBCm4EPgEXlMV9Ezn
 P7n9I7e4UOYKHwTWq2ZwCuG5l6VZMz5xVK7VX43R1nZknzBNkrzky9iGCM1pgo
X-Google-Smtp-Source: AGHT+IHgz72xQNjtbc49aan4nHlti6RW96v4rpjYW8uSq5Iirr7v/CyXqEjK1ayP3dZK9t1L92OhoA==
X-Received: by 2002:a05:6000:40e0:b0:429:b525:6dc2 with SMTP id
 ffacd0b85a97d-42cc1cbb56cmr9899811f8f.17.1763956924031; 
 Sun, 23 Nov 2025 20:02:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3a76sm25980802f8f.24.2025.11.23.20.02.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Nov 2025 20:02:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.2] hw/nvme/ctrl: Validate PMR memory size
Date: Mon, 24 Nov 2025 05:02:01 +0100
Message-ID: <20251124040201.55117-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

Per the PCI spec 3.0, in section 6.2.5.1, "Address Maps":

  A 32-bit register can be implemented to support a single
  memory size that is a power of 2 from 16 bytes to 2 GB.

Add a check in nvme_init_pmr(), returning an error if the
PMR region size is too small; and update the QTest.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvme/ctrl.c          | 13 +++++++++++--
 tests/qtest/nvme-test.c |  2 +-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4d150c7206a..1df5e88dbbb 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8819,10 +8819,15 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
     }
 }
 
-static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
+static bool nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 {
     uint32_t pmrcap = ldl_le_p(&n->bar.pmrcap);
 
+    if (memory_region_size(&n->pmr.dev->mr) < 16) {
+        error_setg(errp, "PMR device must have at least 16 bytes");
+        return false;
+    }
+
     NVME_PMRCAP_SET_RDS(pmrcap, 1);
     NVME_PMRCAP_SET_WDS(pmrcap, 1);
     NVME_PMRCAP_SET_BIR(pmrcap, NVME_PMR_BIR);
@@ -8837,6 +8842,8 @@ static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
                      PCI_BASE_ADDRESS_MEM_PREFETCH, &n->pmr.dev->mr);
 
     memory_region_set_enabled(&n->pmr.dev->mr, false);
+
+    return true;
 }
 
 static uint64_t nvme_mbar_size(unsigned total_queues, unsigned total_irqs,
@@ -9055,7 +9062,9 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     }
 
     if (n->pmr.dev) {
-        nvme_init_pmr(n, pci_dev);
+        if (!nvme_init_pmr(n, pci_dev, errp)) {
+            return false;
+        }
     }
 
     return true;
diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index 5ad6821f7af..4aec1651e6e 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -149,7 +149,7 @@ static void nvme_register_nodes(void)
         .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,"
                            "file.read-zeroes=on,format=raw "
                            "-object memory-backend-ram,id=pmr0,"
-                           "share=on,size=8",
+                           "share=on,size=16",
     };
 
     add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
-- 
2.51.0


