Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6CDC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdyV-0005vh-50; Tue, 04 Mar 2025 20:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyI-0005HX-7z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:55 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyG-00008n-Kv
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:53 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2235c5818a3so88430055ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139691; x=1741744491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqop8PPVqxF5+D/vsaWdvEQZlfBAqDTL4yZtnsLbGME=;
 b=bIdNTOw/6FNTGGK/NNcxFDJyIkdty2hyGInqicnRKmZmgv0TKHlLzw4bzjKTj4Y3NH
 RVX8CPKmzV/j3LDcZXnr050WoTmoY2oUpcsq2VSVYTtAL8IakzXOlvesjV8qcD6DOzN2
 KjFl15q5V/nGfjXcSTLNveDoUvKcx8HKP2PZhPXZDv3AGczCsD/afqnNJc2E0ED/yGvC
 nmiD3uc9pCkmSr1blLXqTAUdihdupmvIymB4/UoCTVkChV2jVN/cnsI7xxva3p5Dgt0z
 xVsPIdi+FbuoLin7cmIkeK2NGM3Xb8yEjgtZIzBWpawnsTwbOncQjULliscJwJ2crrlB
 uvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139691; x=1741744491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rqop8PPVqxF5+D/vsaWdvEQZlfBAqDTL4yZtnsLbGME=;
 b=w4J0XA5YWfYqOt776V/071posCkWJyk/w614+zZAcAFhMidEJdeg2klGPqZVEfxd4A
 nq+mu8JDIq/jahJtk6vwnuEUlJp6NKQdqA6/TCQvSPxXdgtGKNTLTCvOGVBhY291aQlX
 7mgiLBD5VSMjhw/gzH3u1PmlzDArHVp7ny+OUrc+8Pp4MiAsiik8C/OOIgIu1wFU9Hkm
 ae0jP6Kkbmiads3PLOu8hpKtfAtxQYRsMPIzB6gM1lvj4wPSP5GLb/CXsTHf35elAnuE
 ch1jQfAglAgtC3MGxRU81ON4c71pdcLO/r9cXEkYTxl5uP+lWdsQ2c5Vf4DaZMHxueAD
 eL8w==
X-Gm-Message-State: AOJu0YzFGswUpoypDGItew59LP6YgAjIx/cjSUJokarO4GxEFtwaECak
 7Ay9Xsr4BAUgmMX00TMtIH5u4E1Wzmb/LWim0tPiX64hI1ZWtZjk0G1dxra3lmg=
X-Gm-Gg: ASbGncvEVcef1LOQhOfDz9dssKKiLYCWMBF7ZjEijrCg37+pL1dAKs9LgmRVacbvB7r
 Vmz8ts/zhyIswboRWX3xrmgO5p4vp3WovIpQ05dyLivcT9vqUGdkH54FzSXGEVXPTcuOdqQWp3O
 eb/HgnZVXEYbUniRGQAyYIKwB492RIlS1cld2UpXCqFqWVQ1W7/LkT6sJ6ozUTuFw8Zp38xVuyv
 ERrd3S7f39DIGL16nbqK4o9EAXflWM36nHlB9Hmkr1mgJAauDMtUlOXPX2IxZqofbRTHZjHQ2Fl
 QkootgC+QRc2HkC0KJ49eTy9z+kPVgQKN6u3n9k/UTL3bhQxCnv2AsI/WFIeU/Iw9MxtMJTXnN5
 qka8r69SoDRgx3QqJshO36+JICLVPxe7yK21rKAwcwA3SdhY/xFg=
X-Google-Smtp-Source: AGHT+IHykGsT2wYYk3LARp1CvuXPloYxEdvmquBWEQf2a/fcgcKCieRQejAwC3HL26TFjOeCXym8rA==
X-Received: by 2002:a17:902:f691:b0:223:5a6e:b10 with SMTP id
 d9443c01a7336-223f1ca5a0cmr20739215ad.27.1741139690994; 
 Tue, 04 Mar 2025 17:54:50 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:50 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/59] target/riscv: remove warnings about Smdbltrp/Smrnmi
 being disabled
Date: Wed,  5 Mar 2025 11:52:41 +1000
Message-ID: <20250305015307.1463560-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Clément Léger <cleger@rivosinc.com>

As raised by Richard Henderson, these warnings are displayed in user
only as well. Since they aren't really useful for the end-user, remove
them and add a "TODO" note in the leading comments.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250213145640.117275-1-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index cb9b504012..53c9998553 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1458,22 +1458,20 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     }
 
     /*
-     * ext_smrnmi requires OpenSBI changes that our current
+     * TODO: ext_smrnmi requires OpenSBI changes that our current
      * image does not have. Disable it for now.
      */
     if (cpu->cfg.ext_smrnmi) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
-        qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
     }
 
     /*
-     * ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startup to
-     * avoid generating a double trap. OpenSBI does not currently support it,
+     * TODO: ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startup
+     * to avoid generating a double trap. OpenSBI does not currently support it,
      * disable it for now.
      */
     if (cpu->cfg.ext_smdbltrp) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false);
-        qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
     }
 }
 
-- 
2.48.1


