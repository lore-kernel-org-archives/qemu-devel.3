Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5610FD31A03
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 02:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfqGS-0003RP-0p; Tue, 13 Jan 2026 21:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfqGP-0003Nn-5P
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 21:05:37 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfqGN-0005lU-7F
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 21:05:36 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso56845845ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 18:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768356333; x=1768961133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=mKj2neoZisAVb6tMyb0P0QhBqhER2dYpcgJ5z2QE/T0=;
 b=fnM316DruM8XN6sRXbyJJUpgjI2rUFuknDYm4xKk2qEgTgvnsgxMAk5zq/F99keu7O
 0ZbmJgCFcP68ARsWC87xLr6MuCXcQniWxO6dTquE/MmuX71OZQkYD2E3Y3wugBpE/jE8
 VEG3PLJCReq9eezDBIb07/2R6xakkqTxBT2Vhz4tPlAnuayC6zHt0zlPJ6pUY/cNUVhl
 qeTWT8TpI03RWNloi/uNaHaH7wz0ki1mbYntC1dkLwvAHTn4WVsLgTWUcOpd6DLLlcy0
 eNFEdOi5lNOjyWa9n2taBTh6u6fJBnhXlrz4Cu1Lfjlh6lOWhvCrzzJwVZ7oUC2Gyw1v
 hxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768356333; x=1768961133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKj2neoZisAVb6tMyb0P0QhBqhER2dYpcgJ5z2QE/T0=;
 b=v+4n2f14bHRKxEHa3IB0a3UIbxNTPvAUXj0SY2pwz7xfq+Dj0b5mFVFW7KBnO51ZX5
 V+EHPH5259B86rkZOF8qmnLvtz85bQNx86QCnpBntgC0Ml0JtSU0OW5OZo2sTxzxw3Xg
 pYIQP2oa4QyhGec6FqbYj3NZvS+6LF3c4NTxv+C+VVkuJjIEJF9QNq4+0EtEK1pooV+f
 s01noiasbA3X0T0Kq7H8Ca9tHQJvIIdudZNc8Ii1HAn/Yjq1OIEiD6zkRLAnb7pRkmn3
 ngg1wGB+Klp4tcvbPl/qm63rLXx9CmwHg8yKxVrIoBOd4W9dIofJnMtEtzTONxkGWO1+
 0kWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZet3bLYFd51EGLSmlPF34+5K8dnv3puZ6+6fy+QewZAlNq5Q5Qq4ojpGnLKqvB2XtQ+VGYD/JEKf3@nongnu.org
X-Gm-Message-State: AOJu0YypysYd+caS7h0u1yEDJLDCvusBu7ACpaIScSbhzSmQgF3aD2Xx
 Z2dKdiJvakfn22wbk5J6qfDg0BgaR2EyyC7jUFuV0R5DIAADc9F/TzKGMjI0QA==
X-Gm-Gg: AY/fxX4hnAlv1oKeNLX30GJGAbLgH28ManLLaP2iN8QQRcS+tWgtlDESh+Ozax7YqAk
 R33y1Jnce7/jlvWJFv6nld9yfejojnHvekyVb1griOQ5CANZgSymdUUHpLMaIUyLZWGF8SUqV3J
 20zBd3mVUD9dPsR4OqYB6u8s4M6+LMi3JDbJchzmT2hnQTtU5js5MQzY+zpSeEy+w8Z7TkOUk+9
 KkH+mAih3MVPSyGCXCY6+mtrHNq2bfofpfSTdjPLLQ5UsqVvnebS3SjjFHcqVg3a73XuaJkCtO2
 y4SSOIj5NK5NnTar0tE3x96kekL6PIMalW4Ci/jLuMKG5faDHHED9/9tTOatvti0MXr3IaRfQfG
 VcyLBDd2Mo1/UggX0R6d415u/4PN2k7MsiO24TcEl3PxqqLughnWbkuEC9hAxWy0leJgtFGVzHC
 wb4KYlvAA3gAMFha/tYlTv
X-Received: by 2002:a17:903:228c:b0:2a0:835b:d17f with SMTP id
 d9443c01a7336-2a599e4fc57mr10434185ad.54.1768356333154; 
 Tue, 13 Jan 2026 18:05:33 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc9e7e8afsm20923080a12.29.2026.01.13.18.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 18:05:32 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2] target/riscv: tt-ascalon: Add Tenstorrent mvendorid
Date: Wed, 14 Jan 2026 12:35:15 +1030
Message-ID: <20260114020516.982305-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

JEP106 has two vendor IDs for Tenstorrent. We will use Bank 16, company 33:

  ((16 - 1) << 7) | 33 = 0x7a1

As JEP106 requires registration to download, the number can confirmed by
looking at the OpenOCD sources[1].

Alternatively, referring to the JEDEC document the hex IDs are listed with the
parity (MSB) bit added. Company 33 has hex 0xa1:

 ((16 - 1) << 7) | (0xa1 & ~0x80) = 0x7a1

Add it to the Ascalon CPU definition as the mvendorid CSR.

[1] https://github.com/openocd-org/openocd/blob/1ebff3ab33c77e3f8fb4e1ddda262b606b572af1/src/helper/jep106.inc#L1935

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Michael Ellerman <mpe@oss.tenstorrent.com>
---
v2: Add r-b, and add mpe's explanation as a public way to check.
---
 target/riscv/cpu_vendorid.h | 2 ++
 target/riscv/cpu.c          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index f1ffc66542a0..751a13aace47 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -8,4 +8,6 @@
 #define VEYRON_V1_MIMPID        0x111
 #define VEYRON_V1_MVENDORID     0x61f
 
+#define TENSTORRENT_VENDOR_ID   0x7a1
+
 #endif /*  TARGET_RISCV_CPU_VENDORID_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ffd98e8eed46..81ad21a6bf73 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3190,6 +3190,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_svnapot = true,
         .cfg.ext_svpbmt = true,
 
+        .cfg.mvendorid = TENSTORRENT_VENDOR_ID,
+
         .cfg.max_satp_mode = VM_1_10_SV57,
     ),
 
-- 
2.47.3


