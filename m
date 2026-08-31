Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02B6C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rYj-0003Lu-7Q; Sun, 30 Aug 2026 22:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rYh-0003Lc-HJ
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:15:39 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rYf-0007WP-QV
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:15:39 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc11a905ba5so2056497a12.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 19:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788142536; x=1788747336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ciIuJKjZ6j1nR/uMT+7qHvjI8S/CyEwP7dM8aiHQmjM=;
 b=XZKa/x2FmylDE+Cr4stzzQwTRyaiODBCaJOloFfLA2Sg3KMr/EumTZC3gy8chFPqRF
 ZVj5qbha98jRwPcrmZ2gTvnZTc6GlYvD3w1sBsmpSsHOlEnzFkDnfrgGdKTD/CzDYGEs
 lyntx21Sz68mUvWhRk1r7a0wSD3D6Rkj1Ttae2VlfvZPVNN6PD9bLXZu9/CTKPYhYnrq
 83K+r6OSvmNyycEk+mdr+vGdyOaUVZhUhjGcSN9Pv3q+oGGNNpMbu4zbpILcUA9noItM
 4lFyC8pwwqGJYVLgmfgQowePUYKe+XJaq9Fone8Vpq6MxB9RzYFFiIGwqkkQp+ixpLzJ
 SmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788142536; x=1788747336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ciIuJKjZ6j1nR/uMT+7qHvjI8S/CyEwP7dM8aiHQmjM=;
 b=SgYglwTr/OX5DatvRTp3UQSQrf7lzoU00lx2orNdLGUOIxwrfIGgpQ3wh2WdXOjNcW
 LMP5oixfO7g5m1E07E7lpqKg29LJAnl8fOOZ76RtULu4vHAuEfO6wTaJSzqiS3Z+fUGE
 OcKmWLP3+Nlce6+Io8E0br199jQSbg2lqgjPG8uJXCyKElZviTTaHXI2tvTCLh5eKCVa
 jfvdfCpe403+iNkdkvOP4AaOk0GN/hizjuD7kshyN+B8sr6cNOJH1dkcL8KGYY62Qpnx
 igJJ1RvuuAVbjMYCsyJNDU9dnS3/cS6q+Q9nfbW0yYeN6vTrIGIo6mXlSAwpxD8ePMZF
 WEQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1O6G2CBcgjTkz39Cmqiq+EdO+PRwfrxbxbuchmLPRWzedjKq2Hd1a1x6P4JsKmz952exeLq57bzD4@nongnu.org
X-Gm-Message-State: AFuF++kfuuJshaGelfOaylSuqPksCIHb57em+31rGswjW9Xljd1YIBkZ
 y39mV/+nUG14+0k802bX/8Q5UCAFhwTDQ6A4ooqaPBefmkdCJGTsIpYL
X-Gm-Gg: AYBFou0IqyC/SxTnU9b1m/Yfz7Lp/stPAyVw6+WltqEHQ3jfSY4Jw2bTXuZpD135TXp
 F7yJX1Qe5QA6zEk1vxt0U1vTn4tSdnJAHhsQkt/C3iVSQ0z+IAitY5TS9FXajEsuWfUjgR7ZHWm
 YUIflrMsEP2IZy7eL/lY5KwGVWlKbAPuDKK8oa+Wj2Mnh27lZ64zV2A+bpsuImQGJGGKf5Oetvm
 esOcqGOaspWlab7EuhX0Z3CuuHBTmT/OFV86B99y8Vq/38Ar7QFGr/gL7ChS46P6NPWzWpLe1vk
 /SBbcmIFRV8zYTo/xNL6RwgfnB1akRT7ud9edu0BVWS3n093IuccqpX2nVN6E5pNz9h6XZ455t7
 98Oo1my9s/GcKNRv4qVkfeXJPkmFG3rRe6TN3Di1vXwL8KF7Is2V7koq6hJqfb/NMp7VsoEuECl
 6AkLNYaYeqIslWrHJ152awwBC4eaKUAME7EGlmwrNbwVG+nYbDoF8kMC8wdYtwG2EnCnt8JCklX
 86kOdRqhKbgMuCFrrfnhn3xJkmDCkjrHFFRjTErNfVSV3frgmQC/uLCTdijBWcQWR1gZodMA67J
 h3c01YGwknjBlN4VPPxw
X-Received: by 2002:a17:90b:1a8a:b0:398:9bd1:3211 with SMTP id
 98e67ed59e1d1-3989bd135cbmr20127075a91.18.1788142536251; 
 Sun, 30 Aug 2026 19:15:36 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b186807bsm20071240a91.12.2026.08.30.19.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:15:35 -0700 (PDT)
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
Subject: [PATCH v2 01/16] hw/riscv/aia: Take a MemoryRegion for the created
 devices
Date: Mon, 31 Aug 2026 11:44:42 +0930
Message-ID: <20260831021500.82565-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831021500.82565-1-joel@jms.id.au>
References: <20260831021500.82565-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52f.google.com
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

Add a MemoryRegion parameter to riscv_create_aia(), to be passed on to
the IMSIC and APLIC helpers so a SoC can have the controllers mapped
into its own memory container. Both callers pass system_memory, so there
is no change in behaviour.

As the controllers don't yet take a MemoryRegion the parameter is not
yet passed on. Changing riscv_create_aia first avoids churn in the
intermediate commits.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/aia.h         | 2 +-
 hw/riscv/aia.c         | 2 +-
 hw/riscv/tt_atlantis.c | 3 ++-
 hw/riscv/virt.c        | 3 ++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 3b6d7f962506..82ab601bf188 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -13,7 +13,7 @@
 
 uint32_t imsic_num_bits(uint32_t count);
 
-DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
                              uint32_t s_imsic_stride,
                              uint16_t num_sources,
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index c1a5982856c5..651552c8f970 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -24,7 +24,7 @@ uint32_t imsic_num_bits(uint32_t count)
     return ret;
 }
 
-DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
                              uint32_t s_imsic_stride,
                              uint16_t num_sources,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index babce2b680f2..d69851df0a01 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -496,7 +496,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
-    s->irqchip = riscv_create_aia(true, TT_IMSIC_GUESTS,
+    s->irqchip = riscv_create_aia(system_memory,
+                                  true, TT_IMSIC_GUESTS,
                                   TT_IMSIC_STRIDE,
                                   TT_IMSIC_STRIDE,
                                   TT_IRQCHIP_NUM_SOURCES,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 329ccdb5a7b6..22a607ed10bf 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1411,8 +1411,9 @@ static void virt_machine_init(MachineState *machine)
             s->irqchip[i] = virt_create_plic(s->memmap, i,
                                              base_hartid, hart_count);
         } else {
+            bool msimode = s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
             int imsic_bits = imsic_num_bits(s->aia_guests + 1);
-            s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
+            s->irqchip[i] = riscv_create_aia(system_memory, msimode,
                                              s->aia_guests,
                                              IMSIC_HART_SIZE(0),
                                              IMSIC_HART_SIZE(imsic_bits),
-- 
2.47.3


