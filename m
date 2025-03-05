Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D20DC282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpe0E-0002dT-KY; Tue, 04 Mar 2025 20:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzO-0008NP-MN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:56:02 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzM-0000XO-Tm
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:56:02 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22349bb8605so121890605ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139759; x=1741744559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAz0w2Fj1wiUkIo5uE4zLw8kc6g0zMh9BHxqDhSaD/4=;
 b=hdf4MiMKu5pWMyTr/OamRh9rc+sxEwg8U6XJiikXdQs3uxl/UezQkGjU4dJL6Rksgl
 HPgE11bzAZhH17xbK7ISZ5t0yO8s3IOCnkLaEzhzmPHAVVLuCMfNz9DmVtrkRgfYh76y
 IrmUOhAIeXPiRMl7x3bXWUFjoH6bVdYWVt4S98ZUfXq6OzfNY0Gw3nu6aDRb7nsWE7/Z
 JLGP1y4jl95ojVr7CYXmET0Rsm3xC+auG4VcrJxfbZ8+6HHtPMtVlb4lsfkrFJWmpQEa
 IJdcyqYAI5FYvg+Ttf87Hq2Fg5VInz6UVYSvXj6no82YMQeWgJsMtleGMquI5Hbt/nV7
 8g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139759; x=1741744559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAz0w2Fj1wiUkIo5uE4zLw8kc6g0zMh9BHxqDhSaD/4=;
 b=FmgR+KKhHX67xZyaFDL+rHT6Q7oHxzmUH4xwIXoAQp75bdMbknJokJVezVEv98cj84
 IXPF9+I/zJ6XlXbOxxdwJsliTiaE8b6h223YzdH18VJxwS39cP9+O3GuUqxkFQ4u2948
 MuX/ioqGYz45MCmd2nlk1bVeNMXKDgQ02PxDQACs5RXXI2K++2ujsTXuEM+McWTlqY5+
 saw2nBGjtnAozxVbyPQeAhTxrxMpStshp4CUPXXuCXogZo2kr6nCrVhJOrbRqwBYQ3D9
 fDuDiIojaXVPNosUYfd1x6V5dkpsI1RcFF4eQxTDvAdDMCgCHbYrgBdV0m/HOceOHubF
 Fz7w==
X-Gm-Message-State: AOJu0YwsdkkYmIW61MaU8d9+qM8JceYfAZC1BDqbC8dQ6t0XUX/bU08Y
 hR7EyAYPZ0HLSaG6MRqwx3KX6QzkQeUn5ezeKJq0WkqwKw/ptl6sYy8ThXADtqY=
X-Gm-Gg: ASbGncs4k1STJNayOVPsvftxoXJ76eAtDnoyfYoa9s6rLY7hPPl67Y56+E7RlWEdNSK
 qEPbLvOQxs0jGZQQCMTiqVyC4K81Qt2CzAfJpMr4mKCOc5pENH+7Eav+yvv4Ceb7kW/gfD6P6Qf
 KWhRTTAi4fhCbB7IZOTzQt7Tg4hMnT10xmQPUH/7NOcqATcABgBb4pSJjtTEfu78kSNSdgiCqvc
 pGEK3mBUQDw7yk+Onieb1v7koEUOT9RbHhft6Z76DyK4joRDAGjtYNYdiK6HAnaGcCn7Xl3coQs
 iyxfBe9qwAHuuWyzw6OjzAkzic/yNoxEVG1Y9h9XTd3HceDw541vJlHf0thp11bnDkeleLwDPKx
 4oHABBBmSU9mZIB1zICLk6qYxBtapz4ucRAgH3HhYid2JRx2pPRw=
X-Google-Smtp-Source: AGHT+IGjFeKe5oU+8GcnXHr7LTkWz1JzXvqeXogGKhqYmxwJZ5W+PuCNvvMP6QGO67d42IKQUsic9A==
X-Received: by 2002:a17:903:183:b0:223:569d:9a8b with SMTP id
 d9443c01a7336-223f1c82585mr15700715ad.18.1741139759279; 
 Tue, 04 Mar 2025 17:55:59 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:58 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 56/59] hw/intc/aplic: refine kvm_msicfgaddr
Date: Wed,  5 Mar 2025 11:53:04 +1000
Message-ID: <20250305015307.1463560-57-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

Let kvm_msicfgaddr use the same format with mmsicfgaddr and smsicfgaddr.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250224025722.3999-4-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index e5714267c0..5964cde7e0 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -181,8 +181,10 @@ void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
 {
 #ifdef CONFIG_KVM
     if (riscv_use_emulated_aplic(aplic->msimode)) {
+        addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
         aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
-        aplic->kvm_msicfgaddrH = extract64(addr, 32, 32);
+        aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
+                                 APLIC_xMSICFGADDRH_VALID_MASK;
     }
 #endif
 }
@@ -403,12 +405,17 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
         }
     }
 
-    if (aplic->mmode) {
-        msicfgaddr = aplic_m->mmsicfgaddr;
-        msicfgaddrH = aplic_m->mmsicfgaddrH;
+    if (aplic->kvm_splitmode) {
+        msicfgaddr = aplic->kvm_msicfgaddr;
+        msicfgaddrH = ((uint64_t)aplic->kvm_msicfgaddrH << 32);
     } else {
-        msicfgaddr = aplic_m->smsicfgaddr;
-        msicfgaddrH = aplic_m->smsicfgaddrH;
+        if (aplic->mmode) {
+            msicfgaddr = aplic_m->mmsicfgaddr;
+            msicfgaddrH = aplic_m->mmsicfgaddrH;
+        } else {
+            msicfgaddr = aplic_m->smsicfgaddr;
+            msicfgaddrH = aplic_m->smsicfgaddrH;
+        }
     }
 
     lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
@@ -431,11 +438,6 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
     addr |= (uint64_t)(guest_idx & APLIC_xMSICFGADDR_PPN_HART(lhxs));
     addr <<= APLIC_xMSICFGADDR_PPN_SHIFT;
 
-    if (aplic->kvm_splitmode) {
-        addr |= aplic->kvm_msicfgaddr;
-        addr |= ((uint64_t)aplic->kvm_msicfgaddrH << 32);
-    }
-
     address_space_stl_le(&address_space_memory, addr,
                          eiid, MEMTXATTRS_UNSPECIFIED, &result);
     if (result != MEMTX_OK) {
-- 
2.48.1


