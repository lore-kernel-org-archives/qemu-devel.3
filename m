Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A0CC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 08:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnafL-0004b3-7O; Fri, 22 Mar 2024 04:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnafI-0004ON-VL
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:54:17 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnafH-00012N-EL
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:54:16 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e709e0c123so1540232b3a.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711097653; x=1711702453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYRuYu6Nyn7zXJDQL50vurRoO71Bn8A9O+6ORi9MHIc=;
 b=WWPrwROg38cFGX1ky35ZpI7lJ8wzDtaM+zCSdGwC8VY8BZLtxDlDmkmiCcE7cIOjLl
 R1TJDMb+CRGRT1y4pNgY0MNaEs9fD5OWvONnZFbdkrMbmkj+5PqTZgYupyfWumAeEkUw
 vUicYZWD4YmOPuVnqtfANN9bhSnEr9cHvdzZd6/huq+tsVdZ/V/TFILFUn17sIGeYecq
 vBNIfIlkn/485y0X/vC0iOziSW5r4jrqBWHMY0At7pwlJXoaFkfInMngAtrUS2rw+im5
 4BiSOlGaOql59ZlBTRfYD4oXFnWOT8xZT3oHYAuzAHOUySUwgu0jmK1d7q+DbETgs33c
 hkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711097653; x=1711702453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYRuYu6Nyn7zXJDQL50vurRoO71Bn8A9O+6ORi9MHIc=;
 b=DSDKfF2KKA+ARkqRpVuEwOJBMh+Oio93RfLkTRJCOgjcXkY9BxgKRPUOj3MVHWbqVC
 t4Eg/IoUebnrMihFztmkey0NHp+LCTXs7lBMlRjk5QMcskNlsGlXVD3CoRblHW4IyuhR
 oEEZ3oVl7kzM2rSDwWEzY5AAydluzhP5A19LoluAoe95jAYCRBuHI8yMhWhYDULNsME5
 deFIeO4QF6c4mhQ1EIzq6u6O+nB0e70E4xXaJkbKT5HvSgYb4Xl8qGZd5/X7gY/3BLnR
 d6I9Q2t36FjWIEJYARJrp0iNHFksgtGB7P8+uoZXHvRvYgGAGZrgunDXKjmLi/GvgBiK
 bOCw==
X-Gm-Message-State: AOJu0YwHXOXq/lec+R4sSER+mOHIZyTwkt/Z/ucTzYFPWSVCmI+YB49Z
 n4DDR5Lul5iRROO78Yldr6Hhxxybu+Wtj4zUfIl5e3YFN0ojTi+aZXfjWYSqzbgezg==
X-Google-Smtp-Source: AGHT+IFH6/kCtfYWPkatpO2OdwfvTL7AFvu/F83LklLVrc89fsjfPZk99J5JAm9/EQvetj2f7cdjDQ==
X-Received: by 2002:a17:902:ec8b:b0:1e0:98f3:fe56 with SMTP id
 x11-20020a170902ec8b00b001e098f3fe56mr134456plg.26.1711097653512; 
 Fri, 22 Mar 2024 01:54:13 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:54:13 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/15] target/riscv: rvv: Remove the dependency of Zvfbfmin to
 Zfbfmin
Date: Fri, 22 Mar 2024 18:53:17 +1000
Message-ID: <20240322085319.1758843-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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

From: Max Chou <max.chou@sifive.com>

According to the Zvfbfmin definition in the RISC-V BF16 extensions spec,
the Zvfbfmin extension only requires either the V extension or the
Zve32f extension.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240321170929.1162507-1-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 63192ef54f..b5b95e052d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -530,11 +530,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zfbfmin) {
-        error_setg(errp, "Zvfbfmin extension depends on Zfbfmin extension");
-        return;
-    }
-
     if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zve32f) {
         error_setg(errp, "Zvfbfmin extension depends on Zve32f extension");
         return;
-- 
2.44.0


