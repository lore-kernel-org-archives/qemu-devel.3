Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35866CD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 04:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKqX9-0000mj-B9; Thu, 07 May 2026 00:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqX8-0000mC-KZ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:40:22 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqX7-00048n-3F
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:40:22 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82f8b60e485so136849b3a.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 21:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778128819; x=1778733619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6oozqUu/iNCcUUmCAX8dgQSxE6ySmyL4OGkPFVC2WQ=;
 b=eIJ6CT3U6BLVNVjBI+F2zzz2xNfauCinwnZpzynk/F5zqnMPmTov6FdL2VQ925YHYI
 Owl9S4ys8CT6wKeLqP2utZd1zSuw7yo+vgft+rXJn/h8UmhTDNZ2m1Y3MR7ogMEwmh/N
 MfYGQtD4BPWVFGcK1kV0IdoVb/IUwv9b0Abc3Byz5OuyuXQCSr6Nzo39lCNleHTwtUOF
 ZDWV9zftXgONpf7GgNDL53HlZ16HPwE12tDyOL+3+QyZFAiCY0woG39vqbl0vHqqa0zI
 Lh5qEdRuv2L/ZhsOo8r1vb8+dTbZw5XL/qSisschBbIR8XmTpa8kkl/VAy/JE8X1dQTn
 uVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778128819; x=1778733619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b6oozqUu/iNCcUUmCAX8dgQSxE6ySmyL4OGkPFVC2WQ=;
 b=Vv+bbMDSe8V/Os6ZD7Q34xij9SFkC25A7h5eTCEUsv83fyg13yKzCM7XGwgUC0Wfue
 SLlMkdEOs0SEgbcvNhgJ4gKFNyvODZ4idRX7WMRs85PFcxSLEd7quBk4G2qyyqD8D8fR
 ZfIPNCbdkC6w6UslLb0DjtrlGl6kazw9V+buPahhCiX9vYucuYSqjB4LuN4IF7igd5Nt
 UJ2PWdvopCxRZjKgCUxdaY0H/L0MwEwXbyqhm3VC+1Sb1vTi6EtZ3aEsv8UaTxpz2n5Y
 /wlGJwZDGHMX/re+md2P5xv3MDlWe9HjPpG4BC35WAuZbSkzCHN/yry+3t8WI3g4U7Bq
 ul5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ98HfmIhXQ4iTw6T3DO/eenAZQBhgGg50yh9ccwW8+t+1iV2UG0OII6wMpjYQudDBr3TeroeKoAE+A5@nongnu.org
X-Gm-Message-State: AOJu0YxjUIUtSsQeB2uW9F0i/e134lbUY7jNp81Ua7K+n6CjQrGsll8X
 6HAtdubiiw9a/v5dUrG79W2IrmUY03snL8oSASAbaAf/bpqHyrXOHt2t
X-Gm-Gg: AeBDietj3oXJjKbllE5FcnBc79MKmALxkzxx4edFwNw+HqLDmhu+yvydQNYh7MBzwqY
 3e9VMM9+408u8y/RqfnPNo6ar+Sp95KCkQCG296kVRdxI6SglN5e3N697IO18PuyCZV1J3W+w/5
 IS4iV0B4MGOf7KpYLDlSgpsAWc6gspk3pUtmLDYYoMavAxs7zOCryCN9EXQZG7tOFdv2HOnuRCe
 TQDlBIfZiE/5LRISpsnlfAxuOvOkRC63Bh8HPJ7k3CI7mepagCY9/x+NJ/rYCH7yMQ1VzjBjW1q
 97r1emcWMXVb+KlSnxIMorlkXZnOjkeqFDWkpfb7Ln6zeH9dh1vJx5zkh1E4gE0G4ff5vl44LnN
 rNuJQ4s/GX71/jc9KPFWCOMgCEIfR5vt5bGFZtWps0mJKIS/F4kM53Gs2qfZRqI8L2VfPQh2DeO
 VQPD1qXNQPQIeKOsylggngNzLXZJYdCCHBsHu3gL0IbaVLfxzi2O1WS1wHn16x+ss4+ZTIGsntH
 71R7Q0q
X-Received: by 2002:a05:6a00:7084:b0:83b:a723:d704 with SMTP id
 d2e1a72fcca58-83ba723e38cmr1321314b3a.19.1778128819484; 
 Wed, 06 May 2026 21:40:19 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965d36a12sm6575018b3a.27.2026.05.06.21.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 21:40:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v5 8/9] hw/riscv/atlantis: Provide a simple halting payload
Date: Thu,  7 May 2026 14:38:36 +1000
Message-ID: <20260507043838.45652-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507043838.45652-1-npiggin@gmail.com>
References: <20260507043838.45652-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

OpenSBI hangs before any console output if the domain init code sees the
next stage is not in an executable region.

If no kernel payload is provided to QEMU, the next stage address is
NULL, and the riscv virt machine memory map ends up covering the 0
address with the catch all S-mode RWX region and so OpenSBI prints
console messages and does not hang until the next stage boot.

The Tenstorrent Atlantis machine address map has RAM starting at 0 and
it loads OpenSBI there, so it is M-mode and not accessible by S-mode,
tripping the early check and hang.

Add a helper to set up a simple payload that gets OpenSBI messages to
console, until OpenSBI can be fixed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/tt_atlantis.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 43f47fbd75..789a66870a 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -384,6 +384,30 @@ static void create_fdt(TTAtlantisState *s)
     create_fdt_pmu(s);
 }
 
+/*
+ * This works around a problem with OpenSBI hanging with no console output if
+ * no payload is provided. By chance, machines with memory at 0x80000000 do get
+ * output, but Atlantis memory begins at 0x0 which takes a different OpenSBI
+ * error path.
+ *
+ * This can be removed when OpenSBI is fixed in QEMU.
+ */
+static void tt_atlantis_setup_halting_payload_opensbi_fixup(
+                                        RISCVBootInfo *info, hwaddr addr)
+{
+    /* Store the payload vector in little_endian byte order */
+    static const uint32_t payload_vec[] = {
+        const_le32(0x10500073),         /* 1: wfi           */
+        const_le32(0xffdff06f),         /* j       1b       */
+    };
+    rom_add_blob_fixed_as("mrom.payload", payload_vec, sizeof(payload_vec),
+                          addr, &address_space_memory);
+
+    info->kernel_size = sizeof(payload_vec);
+    info->image_low_addr = addr;
+    info->image_high_addr = info->image_low_addr + info->kernel_size;
+}
+
 static void tt_atlantis_machine_done(Notifier *notifier, void *data)
 {
     TTAtlantisState *s = container_of(notifier, TTAtlantisState, machine_done);
@@ -421,6 +445,9 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
     if (machine->kernel_filename) {
         riscv_load_kernel(machine, &boot_info, kernel_start_addr,
                           true, NULL);
+    } else {
+        tt_atlantis_setup_halting_payload_opensbi_fixup(&boot_info,
+                                                        kernel_start_addr);
     }
     kernel_entry = boot_info.image_low_addr;
 
-- 
2.53.0


