Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3092CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTHK-0005LL-E6; Mon, 24 Nov 2025 04:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEq-0004W0-Cm
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEn-0001cJ-Or
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477632b0621so27490665e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977920; x=1764582720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ap63lntzlR8GaDypuh4WetYAtZ4MTe+hzOe+jaSU4fc=;
 b=WipLM/r6hA2+pbG5nb7XvZvyJvrYIAWHQMRc1rfUgIuwVMLYPg0Wb0FIoniDIMWd0P
 zbTuoPF3YmDI3aJkgyxknGiYVFOo9vIhm5Br0rzbllsky8taGEe8zLJLPBch3F9K2dD4
 mHYJOnP+yVsyapdbBANWyxSDqswTqMWJrsAOM3doHj3HQoh+T2z8hUoQoAJshBbUTHMD
 EpBxWe9PtxvklAt3j/I2BUgFpSnoTHDpWQlxxuIJGOVppW7HdoHv1eboZlKNG0qdJWIN
 Ruu9N5AuIS6qWlOcfdwynq0uu5F9s2LbcnsUNK7UWNTSkvLnCem8m7HCLmu8MO/OVbX2
 uNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977920; x=1764582720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ap63lntzlR8GaDypuh4WetYAtZ4MTe+hzOe+jaSU4fc=;
 b=k8FdlSlr1MZrDdB8xx3HkrOnaGsFB5O9gScSK4ohJF7HRJWk8GeiAPjH9JII4QgsCt
 x6t6GMGNfbilNrarfbCtylLVdAa9m5uwWqJos+moI1mHyzeKd/n3EhVF+x+wECptQeXj
 KhIN/y/UwCUt0F281zqXGgsEAugBM4Qd7//X+fvYq+OAuKwwaeK69rVOg0+a0FTzSp65
 NP2/ie7KZOfL/6O9XOz9Rh3xryrfitJfcsADV7husB4mc0M3kwmsBqqD6nyQ3Oxgm4Aq
 DMlnHcX5Y1+eORedbdU7vxjasovrF7onW8f2g7VZgq5rUa6oFYGmydHwMKd4qiKoPLnA
 GS1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdDF0QJEL22eJohIRzSg82fz5SyoDku93Y4U/DdVQ/MkAt0PQgU+VVCCePh6qrUx10cQBaSXescLpw@nongnu.org
X-Gm-Message-State: AOJu0Yy2WxC9fX3/87tjM4ST6rBQS32HZAK2SK5B0nt5tsbVnMjVVJx1
 rkBXjwxcHOQii+VrKsQKKDEi+547yNeauxhMZ14QgqdSmCKzM30q80H8EY90uJ4HT+k=
X-Gm-Gg: ASbGncs8eZAlaB40LOMFQ40zQMcaDhEH2cjuXFZ7pilF0jAhL4Gctf/3CbtnUpwdUtM
 uWIocjw5elHkrymfANP3+/OyrbuBW4zIbgSB3pWzmJ7Nsuj18NQ58Oh/c3/VIh9dbnRxl9Gzv7f
 iLUKQ9RDD9kMFGhvG6ViaWvxylGXetjsENxYVbMvRCBZ1g375cKiU1esGmK9ttRIV9j5YYpQ9nd
 9W0z8eSCG6U3MrAfbQLm8j1vb17AppueaDhht/SPNgglAo0S+xXyYWhVAb9N9tAlttV/N8ieewJ
 lClrzWQOBbG7AvM6f8/b8WhpzND1tx4zUclQFK9suyd1U8/0volqGVszOxQ4iNSFaDrkFUQvNQ6
 cDRM+te6AqPEEu5C6yQCACY03u+18yGv1uLEIteEMXSc3AYC6Iyc8Qr2y0ceJNsdZgLyzncZNtk
 Q3gZtwKRmrXnl6K54D0oUFMnrEijZXswf1ao2j/TbHNp1/xEAnF8b6FHSV+OI5
X-Google-Smtp-Source: AGHT+IGxtwIUpPvVaKECTkaaEjbbbMFw7g3vro7n1phVNH+26EhavxI1fREA2NPZczBvrzvyL1XfqA==
X-Received: by 2002:a05:600c:8b35:b0:475:d8b3:a9d5 with SMTP id
 5b1f17b1804b1-477c10d6fdamr112297975e9.10.1763977919841; 
 Mon, 24 Nov 2025 01:51:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1df392sm189082925e9.1.2025.11.24.01.51.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:51:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 07/13] hw/sh4/r2d: Introduce EXT_CS_BASE() macro and
 use it for SDRAM
Date: Mon, 24 Nov 2025 10:51:02 +0100
Message-ID: <20251124095109.66091-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The SH7751 memory controller can access 7 external banks.
The 64MB of SDRAM is on bank #3. Introduce the EXT_CS_BASE()
macro and use it for SDRAM.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 12232fabbdf..ecbc1ec2a98 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -45,10 +45,11 @@
 #include "hw/block/flash.h"
 #include "exec/tswap.h"
 
-#define FLASH_BASE 0x00000000
+#define EXT_CS_SIZE (64 * MiB)
+#define EXT_CS_BASE(cs_index) ((cs_index) * EXT_CS_SIZE)
+
 #define FLASH_SIZE (16 * MiB)
 
-#define SDRAM_BASE 0x0c000000 /* Physical location of SDRAM: Area 3 */
 #define SDRAM_SIZE 0x04000000
 
 #define SM501_VRAM_SIZE 0x800000
@@ -256,7 +257,7 @@ static void r2d_init(MachineState *machine)
 
     switch (machine->ram_size) {
     case 64 * MiB:
-        sdram_base = SDRAM_BASE;
+        sdram_base = EXT_CS_BASE(3); /* 64M @CS3 */
         break;
     default:
         error_report("This machine can only use 64M of memory");
-- 
2.51.0


