Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7BACCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC55Z-0005uo-Pf; Thu, 23 Oct 2025 19:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54s-000540-GB
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:44 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54p-0007T1-Q5
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:42 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b556284db11so1168937a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263438; x=1761868238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Mao6PD8wwENV7peOfswOR2w88gBwEoO4ue8fP0vqGc=;
 b=hOllIspj0dmdvptd7CYuQfcXbnuwVhPyPyUNxM6vYnXpaaNZ+gIL6rDadNnk9kNLNN
 +kgbXMkWVUdy6lOogqXSXW3DkEm1C8+mqfp6AOC3Qd5FwDLXJQ9JIylqU5yt9WddBa9Q
 IAUxdoQRVMHJ4XvkESr7ZGFnc8utcZNc5S88Hzhq66wd4D2tzblA6N2RrpFS7RFF5ILG
 OBP5n5KgeoFPM1ejp/uyDyI05pKy36dm5PQc0Ve9mnjOVfRtDC7y7kJfynP7a6vIVWSF
 /tH1gqzQUsWqMSEHzhczsDzcmV9Ln+lbp2idex3kNjFbirmDA2OqHfsFFX6z6pjyUqTt
 fHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263438; x=1761868238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Mao6PD8wwENV7peOfswOR2w88gBwEoO4ue8fP0vqGc=;
 b=VMQpz8mt3Dwa2JZ4yXHNOn72Me2NssPWdYJucE1XubaHDLGdfZGjWKvWKPsZc7TI8g
 wh8I8DlebjayGsJJ5hzlgma6XSB9N+fQUJqflilxze0qVwlHQc/yaVdqOTll/Dfz2eKS
 Gmuu8yPO2n7xXA5xaHfyLG41ApDKo7231zx8C2DNnTz+eUUSNtdqTaChp5p0QKUi0fSB
 fwL3zmgqAIyEBIiFN0xHVTIRRpx3XLsxvFMHel97hEKjsJolqVvArK6wgMXkJVjCOW6V
 KR8+xbAvOogFv6PLiernGoJqxKk3T5MVsMDR96tfZGvdGtrKg6mc5X5K3raP2sjySnHl
 6DnQ==
X-Gm-Message-State: AOJu0YwINuwbdoqWNpEz3goKYNKCwKIaNZx77BbFIpyrC7eLTvdeoswC
 kOeXmW3hUhc1xqQr5szqL5Lh2scS+R9Gu44QaNHwnyJLlNa16OoStZzlLiI0kA==
X-Gm-Gg: ASbGncstWTNIKIR3BvCAHTICjyCg9M/44Bjykl3ik+P0PzQNkCYL9qaWugN5GrQq7yb
 J3KaxZDu6cOYUWoyF7WY3Wf9i2DMGcSN/2t2vhmegfk8Ak0TI5uYqh4GcrnsgYdz2KaQX874Uvo
 We6HhSTtU5B7fA/L5nFspfz5lrHnOVKUHAPAYcvaIEoaDwmMw+q2VFldNexUYlli3wFUkxxg6Ao
 SQ+PBdMk/9c9TbiX1ji923gyg1NtYV9qe93w2/OXDoxdhRq1RhDSgBPrvcrq3ofC+cnQ6HMOBXM
 jgWT6zhI2OzR4AnqWqwfTA8Q26zbatV3vOmjEb7XeyI6TFXjDeQBVwwvJJZZMQocH804dgiDWgt
 s5Ddcyf8iKQ//H40VXS03VFdTxt04zUMCOEl9xguMt3/SDpSd+dWCb4H1UR/Afun2BkoR7LyiuE
 SodrGyUrnv7GB+vD5cliBOMBD76GvZEiJu/w4jaRcMqj2pviCgXX7jQcH/dA0s2jJxHMp/gybSP
 mXcxCuzgZU6XNk3Izg=
X-Google-Smtp-Source: AGHT+IEYEQYnCkd11txQqnaaiLQGwY1KqSQ9hdzV/D9DRL2hXuIm2BbvMdI3RsbJJW48/d9iq5Fj9w==
X-Received: by 2002:a17:902:e944:b0:262:9ac8:610f with SMTP id
 d9443c01a7336-290c9cdee1cmr281683165ad.22.1761263437735; 
 Thu, 23 Oct 2025 16:50:37 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jialong Yang <z_bajeer@yeah.net>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL v2 18/25] aplic: fix mask for smsiaddrcfgh
Date: Fri, 24 Oct 2025 09:49:20 +1000
Message-ID: <20251023234927.1864284-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jialong Yang <z_bajeer@yeah.net>

 4.5.4. Supervisor MSI address configuration (smsiaddrcfg and
   smsiaddrcfgh)
smsiaddrcfgh:
        bits 22:20 LHXS(WARL)
        bits 11:0  High Base PPN(WARL)

Signed-off-by: Jialong Yang <z_bajeer@yeah.net>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <44f3e0d1.161.199d0c338b0.Coremail.z_bajeer@yeah.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 hw/intc/riscv_aplic.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a1d9fa5085..6dccca73af 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -96,7 +96,7 @@
     (APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
      APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
 
-#define APLIC_xMSICFGADDRH_VALID_MASK   \
+#define APLIC_MMSICFGADDRH_VALID_MASK   \
     (APLIC_xMSICFGADDRH_L | \
      (APLIC_xMSICFGADDRH_HHXS_MASK << APLIC_xMSICFGADDRH_HHXS_SHIFT) | \
      (APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
@@ -104,6 +104,10 @@
      (APLIC_xMSICFGADDRH_LHXW_MASK << APLIC_xMSICFGADDRH_LHXW_SHIFT) | \
      APLIC_xMSICFGADDRH_BAPPN_MASK)
 
+#define APLIC_SMSICFGADDRH_VALID_MASK   \
+    ((APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
+     APLIC_xMSICFGADDRH_BAPPN_MASK)
+
 #define APLIC_SETIP_BASE               0x1c00
 #define APLIC_SETIPNUM                 0x1cdc
 
@@ -184,7 +188,7 @@ void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
         addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
         aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
         aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
-                                 APLIC_xMSICFGADDRH_VALID_MASK;
+                                 APLIC_MMSICFGADDRH_VALID_MASK;
     }
 #endif
 }
@@ -409,13 +413,8 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
         msicfgaddr = aplic->kvm_msicfgaddr;
         msicfgaddrH = ((uint64_t)aplic->kvm_msicfgaddrH << 32);
     } else {
-        if (aplic->mmode) {
-            msicfgaddr = aplic_m->mmsicfgaddr;
-            msicfgaddrH = aplic_m->mmsicfgaddrH;
-        } else {
-            msicfgaddr = aplic_m->smsicfgaddr;
-            msicfgaddrH = aplic_m->smsicfgaddrH;
-        }
+        msicfgaddr = aplic_m->mmsicfgaddr;
+        msicfgaddrH = aplic_m->mmsicfgaddrH;
     }
 
     lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
@@ -427,6 +426,14 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
     hhxw = (msicfgaddrH >> APLIC_xMSICFGADDRH_HHXW_SHIFT) &
             APLIC_xMSICFGADDRH_HHXW_MASK;
 
+    if (!aplic->kvm_splitmode && !aplic->mmode) {
+        msicfgaddrH = aplic_m->smsicfgaddrH;
+        msicfgaddr = aplic_m->smsicfgaddr;
+
+        lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
+            APLIC_xMSICFGADDRH_LHXS_MASK;
+    }
+
     group_idx = hart_idx >> lhxw;
 
     addr = msicfgaddr;
@@ -771,7 +778,7 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_MMSICFGADDRH)) {
         if (!(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
-            aplic->mmsicfgaddrH = value & APLIC_xMSICFGADDRH_VALID_MASK;
+            aplic->mmsicfgaddrH = value & APLIC_MMSICFGADDRH_VALID_MASK;
         }
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_SMSICFGADDR)) {
@@ -792,7 +799,7 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
                (addr == APLIC_SMSICFGADDRH)) {
         if (aplic->num_children &&
             !(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
-            aplic->smsicfgaddrH = value & APLIC_xMSICFGADDRH_VALID_MASK;
+            aplic->smsicfgaddrH = value & APLIC_SMSICFGADDRH_VALID_MASK;
         }
     } else if ((APLIC_SETIP_BASE <= addr) &&
             (addr < (APLIC_SETIP_BASE + aplic->bitfield_words * 4))) {
-- 
2.51.0


