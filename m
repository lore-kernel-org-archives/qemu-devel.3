Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EFFE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF9O-0004TK-1F; Fri, 13 Dec 2024 18:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF97-00041B-M6
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:37 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF95-00038Z-TD
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:33 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso4091f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132750; x=1734737550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUpocUqRTSjyf3cCiIDYbPpX0/ouCKZXynrUVilzcxo=;
 b=hZjaegewo+Y9aBwm+xJEY9Zdm6dGhp17mDhIOpi7LYnDxttxHe683arYYqeXgAiZFW
 ChAyFlXHicvLNqkYRDIQ2jwlZdmxPyyULVlRU0mVV7hwoet22s8Yg+WVwi2FWYh0xEGV
 GPe6LyuGaDHT0ZTtCu60W6VY+J4O2LJU/mnfyvPf6mtSGvxb/W9WdnxfVI3L95EZEcRr
 iqkzw85EORu9oxNz5D0GhLIp4UwARZ1tPTH5WfMeVZaSS30OZRxtLDQ/2q4JY7lBLJ8A
 bSOJyyxRoZ34UARKLoWwaHBc23YE2COGTmwqd92sdbJxvVxul+f+5DdAdtiHd7ueBqko
 AT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132750; x=1734737550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yUpocUqRTSjyf3cCiIDYbPpX0/ouCKZXynrUVilzcxo=;
 b=MgrA+M17rOU1aktysGl0ikQUOtVDUF++zcWx7j9sdBSKPbZoKC/kuy+lyVLjuhDuf8
 EOWJn1lOPsr0SYQipP2e1aFUev9uxg4nRK53SCzDFTNObryMGFeh0XNW2Xf69yjBufKz
 JahpXXB+cn7L8WlmXvUwJr1xu5MQDry8nQHLz7Z/SFtQjsNsV0WhlQVxpKFs6kAfM1dP
 gEuj6G79rnJpxDSDjUWeq9228p2bPNVoMR39YpjA5J3BXtiIWdZEsxKJYi6ksSkLvB79
 +Spl+h6H3/j8dN7ZlLbs+kGtFc5T4O76fJp129hgybMnx7HW7p8o8fq/QZWO23EHanyd
 4yPw==
X-Gm-Message-State: AOJu0YzzRgDb/HOEc5b4dHbHAsK4ttZu8XrPUmSZU9KOavcxJ6jdcKvd
 hLfW0FxMBrcfu/Zd5/qELbewntIBLJzrZCxUtI1Nxq/Df+doMz9YwPaAQH5KgIgKWv/ZEFaEFAX
 G0RI=
X-Gm-Gg: ASbGncvaE/FQqj69FuaS04hrhpEFXx8LNvh4AJB0bl4F7/AokZuo9fAlJUxJMqNKuoX
 cREgecPzuvgV+CphytcK8ZA1ZbIjkDt4IrLzA61LjyzLAPZZg952YUD5HJjW3fzdvUWSQCQEk46
 QzTQijRMof/5jo+VZbJea9xa9B5UTpOTRczoELdc5+/NoE18k2nqSDEfFrDDuYhGuANt80VPyol
 NTcIs5Fq6P5RIVXG+Jhd7CfDumbSevVA2HH6KjXGMpI//OTvt1k6ho0zytgV5m5UAjtBpJdFHJB
 g3a7EA==
X-Google-Smtp-Source: AGHT+IF3YSDhnfol0mDhpcIG5mDDVIMIChAlcs5Q01loJYPryolrc7yiCl+W4irgtv/3lw08sJZqFw==
X-Received: by 2002:a05:6000:144f:b0:385:fae4:424e with SMTP id
 ffacd0b85a97d-3888e0c07b9mr2960020f8f.52.1734132749862; 
 Fri, 13 Dec 2024 15:32:29 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80120dcsm859443f8f.8.2024.12.13.15.32.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:32:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/20] hw/mips: Include missing 'exec/tswap.h' header
Date: Sat, 14 Dec 2024 00:30:53 +0100
Message-ID: <20241213233055.39574-19-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Some files indirectly get "exec/tswap.h" declarations via
"exec/cpu-all.h". Include it directly to be able to remove
the former from the latter, otherwise we get:

  hw/mips/malta.c:674:22: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    674 |                      tswap32((1 << 31) /* ConfigEn */
        |                      ^
  hw/mips/fuloong2e.c:89:23: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     89 |     prom_buf[index] = tswap32(ENVP_VADDR + table_addr);
        |                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241211230357.97036-7-philmd@linaro.org>
---
 hw/mips/fuloong2e.c | 1 +
 hw/mips/malta.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 7fd8296ccb6..904c10b90e3 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -40,6 +40,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
+#include "exec/tswap.h"
 
 #define ENVP_PADDR              0x2000
 #define ENVP_VADDR              cpu_mips_phys_to_kseg0(NULL, ENVP_PADDR)
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 198da5ba3d4..834636dae59 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -28,6 +28,7 @@
 #include "qemu/datadir.h"
 #include "qemu/cutils.h"
 #include "qemu/guest-random.h"
+#include "exec/tswap.h"
 #include "hw/clock.h"
 #include "hw/southbridge/piix.h"
 #include "hw/isa/superio.h"
-- 
2.45.2


