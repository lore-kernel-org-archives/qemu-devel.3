Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883DFC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdXI-0000NW-MZ; Tue, 04 Mar 2025 20:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVe-0004To-4e
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:25:21 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVW-0007QL-BS
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:25:12 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3910e101d0fso1839209f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137908; x=1741742708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfDhx6dXYnykeldUX+NORiuKe1+4dgkAJvvKMJwXJlA=;
 b=uoxAaEA/mgd0E0DYys9gVHhJB2TvbpFZvKsMDgaAfjE1JAlIBkQA+IkAv5SQV4lV8+
 LCfZ0OAJVXHEzGVTTf4N8Bem3LX6+fMLY9kIMm2O8kcg/b27iICtLXtXBadrRJcDG8Cn
 KTu7IOs/SXSvZzmQHddsMNoa2YAk4cALFYvqhJGzHa3keU22CPD7Fch24EfywnbwSQ0q
 qdGiTqRhevqH4UbBLkbEB1KDCLtygw5mJcrlCm6LsfX6eekpUT9m2nVYmlfwVFKIjlzh
 qANwUyPXaOuHMPRa8yzkX4Oh9HMrHaWZHKuI82JPhNEcR3uia9WAo11EFJgMwj/FmXRN
 GFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137908; x=1741742708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BfDhx6dXYnykeldUX+NORiuKe1+4dgkAJvvKMJwXJlA=;
 b=ElqtnIhjwRW6MIEsaZlH+FTBv2F7s4KXtKgaz9gj6WDE/KvPp9QiV/VatQL2rb/hqr
 FjwPsAEslHT9WZGvDm81J/IkVxeewVWn5UBzKh3mvmBB4UnD7qwoTpDlWSUnra2RGvUn
 Mrf2kgOVJbEsTtlVbs9q70Uy/tOMCCd6BE5G4uIKFxSt3X/wRXaztRNkW8o9tzeCdReF
 c4WpcYychQBU2kB+93I8iBTtyBuQrsyiqBH3hwedpHYZ7lXQIxlIp9uTEyya9a4vaeBC
 YrsRNt+7XcN8sw+dxRcUcETc8z+CDgSikJyeuP21U7kTUqWOIsZ1DFjCiKej9x8e3XjH
 K5CQ==
X-Gm-Message-State: AOJu0Yxz7avBqlj70oNDhLbDxe86FUTC1U6kik1hIZKv8EZVbIwrpYGY
 ifdC+i34luz9KidvWFnn04m8CgYm3UlI7e7VQoX0pVFOhbBbkCLao7+S+PnJRVBpe9KDArP3+o+
 JPnU=
X-Gm-Gg: ASbGncsbjsG9TygWz7M9qGGyViGoemWKgZwZNeZ1qqaLwZwCyV71FP5LdgyKytPfeZr
 uo4neqYmSaehcDqQSYAkCa/BRKgc/GlVQqy5brx0z+2I7Tqwz8975k1c6aiyYGzoFSRMUz4+zw4
 Zgmm0cvjgHw/82N+yxYo46r1JIm/4GkPSnEMI7ft4uAUmhi873r9Ts8iZeI6LfGQfWKBRT7+hLJ
 CLF18/GvtY4UBNeD508nJLKntWPvr+M6GhiozcEZbwqbRHa74I8uETPaeqt5ozTh54iTAbdBvDr
 My+de9HkjN5AnBb2nUo9I80Weytq6Kktt++DA4nwYeEPul78pACl58TgvarnMdMemccsDYjgRBE
 DkNVxI9eCkveJ1BUPlQk=
X-Google-Smtp-Source: AGHT+IFdaDJC26axO68WBbQYWgB5Uxwn5n2ntVK/vCHtuezXOnVByz5M4l4YaOKWNvOKy8oicfsviw==
X-Received: by 2002:a5d:47a7:0:b0:38f:3224:6615 with SMTP id
 ffacd0b85a97d-3911f7265d2mr608397f8f.7.1741137908148; 
 Tue, 04 Mar 2025 17:25:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844a16sm19320417f8f.79.2025.03.04.17.25.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:25:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/41] hw/nvram/eeprom_at24c: Remove ERR macro that calls
 fprintf to stderr
Date: Wed,  5 Mar 2025 02:21:54 +0100
Message-ID: <20250305012157.96463-40-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

In the realize method error_setg can be used like other places there
already do. The other usage can be replaced with error_report which is
the preferred way instead of directly printing to stderr.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <637b92984795a385b648a84208f093947cc261e4.1740839457.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/eeprom_at24c.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 2ae03935d47..9f606842eb6 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/i2c/i2c.h"
 #include "hw/nvram/eeprom_at24c.h"
@@ -26,9 +27,6 @@
 #define DPRINTK(FMT, ...) do {} while (0)
 #endif
 
-#define ERR(FMT, ...) fprintf(stderr, TYPE_AT24C_EE " : " FMT, \
-                            ## __VA_ARGS__)
-
 #define TYPE_AT24C_EE "at24c-eeprom"
 OBJECT_DECLARE_SIMPLE_TYPE(EEPROMState, AT24C_EE)
 
@@ -75,8 +73,7 @@ int at24c_eeprom_event(I2CSlave *s, enum i2c_event event)
         if (ee->blk && ee->changed) {
             int ret = blk_pwrite(ee->blk, 0, ee->rsize, ee->mem, 0);
             if (ret < 0) {
-                ERR(TYPE_AT24C_EE
-                        " : failed to write backing file\n");
+                error_report("%s: failed to write backing file", __func__);
             }
             DPRINTK("Wrote to backing file\n");
         }
@@ -203,8 +200,9 @@ static void at24c_eeprom_realize(DeviceState *dev, Error **errp)
         int ret = blk_pread(ee->blk, 0, ee->rsize, ee->mem, 0);
 
         if (ret < 0) {
-            ERR(TYPE_AT24C_EE
-                    " : Failed initial sync with backing file\n");
+            error_setg(errp, "%s: Failed initial sync with backing file",
+                       TYPE_AT24C_EE);
+            return;
         }
         DPRINTK("Reset read backing file\n");
     }
-- 
2.47.1


