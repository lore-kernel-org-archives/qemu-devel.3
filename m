Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D71CD6E74
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 11:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVSO2-0008Hb-9q; Fri, 05 Jun 2026 07:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1wVSNv-0008GF-TD
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 07:06:44 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1wVSNt-0005uz-Sk
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 07:06:43 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c0c1e0d00bso17380175ad.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 04:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1780657600; x=1781262400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4BOUEe+VamKGk6MRknmAp6o59Ee2hSdf7ohcP2aYG4I=;
 b=TvK3GRuK91TLw+5AKl1JqhSn7oJ7gd9Z/Rw9JxCd/kuF51eIKMwGqydturUgS4e4DC
 QiSdltLRYcaTij8yp4emdMjBDJZ8MTxmmJzSdPWpSEeQWUpw/gS1afN1S5/nSW7UK7pV
 3eDWdWo10wWZhKY0+jNty0eLqyBhRewZ9VPplTJY2u0nnUbwAsftlqId1UNmFvNZ/Ne4
 2NcACUgx+FxoqDf/CnzD9Kr9HUlKDtv3khTIMMoPNgdX5NfglBbhD2WBg9CdiemqouBH
 o7r02F7Nz89Zxr0goaFfGuavmn14Jfd4rTnZzYtwqDeXAwzYuCJRBa8DBiXwpYOmLaXv
 79RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780657600; x=1781262400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4BOUEe+VamKGk6MRknmAp6o59Ee2hSdf7ohcP2aYG4I=;
 b=rx1vCrPx9AGavfyUwJwRFWSMDi7BJNJTLP9RQr8pnKlHsxiCdsTow32IOdUfMyCrlI
 ZBeoEiIfsSFtFZ9YwoB4uvhWSTWB+Aj+FT+dRAPc6wuaJcWPiVoATknLLgikfpHtYz1R
 xTsD0GKEoyIy3A4HOtp8T4aeYoONWo1dg72c9HQuItOlsFFcAb51/QG/Hw/+t1jpf/mH
 Os0gfzf6eHGVZnEYbVO8pKQx7FKa7XCJIL9aubtjrnrjoPwVYc6LW/BqkkngF0c7x3YN
 jxUi6wLhfT/MyP1/AKUqPyDIr5PxU1qqQ53JjzgDfl2lUDpj1Ef66eeCjFiACt1TrkGa
 JFVw==
X-Gm-Message-State: AOJu0YyUUjNnMuIad0N1ETJev1eDIhIgi5cfGOYXOxchfUcFQCoCRDTd
 +5P0E0FRhklYfEFvZLI64yWxD5028WEfGzNHwhsIVSnppsEGZ8ZHvxAtCU3SeVZu64tUTYv8Vdi
 fZ7rPSSzghg==
X-Gm-Gg: Acq92OHHzMGK0jAQ5hkwUeYZa1caTN5vYK8Zg6MtaAIVlIgZpc6qhyLUJfMSGT8s0up
 se8pAg2TDWQYsgO3dm8XiBaHbOloWMplsdPp8GZhdPM0hh8dUbK1wwmE7oVQU+p3pqNZOMcLVxF
 D0B2y8HdHAYkVN6PJ4KTH8NIgti4XJZmxTxRgFtrAIMdERVNnEBxexMenaDhWXD5idoUMKy3J+Z
 Xfkg2qPpBL+dWFby7vbEukS+XZi2pt5e1VZyoM90avQhjnqzEDB+ieGvj/s2Ghz219SDXkMflBd
 u1lEoUUTq4goPkWSKaNCi+2FYVbgHF0HJciEab2S5ziKN1qiZoj+KoyGroVNQymJ2Ibboh4aUuh
 CIQzUtzsstmcI3ktHGYs9A+21BlzDsdlHRyFzqlErygsaaiMZEXxKVX9GVzAkrbnJ1eAHxc+R0v
 sWsm13hZeypec/siu4lZKHcMkQSnP5r18mtTSwbM7S88/KRqAS/xQt
X-Received: by 2002:a17:903:2c0e:b0:2b2:4d36:7aa with SMTP id
 d9443c01a7336-2c1e85cdd1amr36937335ad.35.1780657599768; 
 Fri, 05 Jun 2026 04:06:39 -0700 (PDT)
Received: from n37-012-226.byted.org ([115.190.40.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16629cf89sm88179605ad.56.2026.06.05.04.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 04:06:35 -0700 (PDT)
From: Qingwei Hu <qingwei.hu@bytedance.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jim.shu@sifive.com, Qingwei Hu <qingwei.hu@bytedance.com>
Subject: [PATCH] hw/intc: riscv_aia: Skip reset for KVM irqchip
Date: Fri,  5 Jun 2026 19:06:21 +0800
Message-Id: <20260605110621.644997-1-qingwei.hu@bytedance.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=qingwei.hu@bytedance.com; helo=mail-pl1-x632.google.com
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

The emulated APLIC and IMSIC state arrays are only allocated when QEMU
handles the interrupt controller state itself. With KVM AIA/APLIC-IMSIC,
the interrupt controller state is owned by the KVM in-kernel irqchip, so
these emulated state arrays are not allocated.

The reset handlers added for APLIC and IMSIC still clear those arrays
unconditionally. This makes qemu_system_reset(), which runs during machine
creation, dereference NULL pointers with -machine virt,aia=aplic-imsic and
KVM.

Skip the emulated APLIC and IMSIC reset paths when the interrupt controller
is handled by KVM. The emulated paths are unchanged for TCG and for
configurations that use QEMU emulation.

Fixes: 99bfcd329a ("hw/intc: riscv_aplic: Add reset API to APLIC")
Fixes: 766391483b ("hw/intc: riscv_imsic: Add reset API to IMSIC")
Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
---
 hw/intc/riscv_aplic.c | 4 ++++
 hw/intc/riscv_imsic.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index c2c67c29e6..84606e9f3d 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -910,6 +910,10 @@ static void riscv_aplic_reset_enter(Object *obj, ResetType type)
     RISCVAPLICState *aplic = RISCV_APLIC(obj);
     int i;
 
+    if (!riscv_use_emulated_aplic(aplic->msimode)) {
+        return;
+    }
+
     aplic->domaincfg = 0;
     memset(aplic->sourcecfg, 0, sizeof(uint32_t) * aplic->num_irqs);
     memset(aplic->target, 0, sizeof(uint32_t) * aplic->num_irqs);
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index ac59496c22..f1f23c3a3e 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -347,6 +347,10 @@ static void riscv_imsic_reset_enter(Object *obj, ResetType type)
     RISCVIMSICState *imsic = RISCV_IMSIC(obj);
     int i;
 
+    if (kvm_irqchip_in_kernel()) {
+        return;
+    }
+
     memset(imsic->eidelivery, 0, sizeof(uint32_t) * imsic->num_pages);
     memset(imsic->eithreshold, 0, sizeof(uint32_t) * imsic->num_pages);
 
-- 
2.47.3


