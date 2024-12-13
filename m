Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B79BE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF9Y-0004ps-8B; Fri, 13 Dec 2024 18:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF9H-00049F-EC
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:43 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF9F-0003Ap-Ia
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:42 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436341f575fso8169465e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132759; x=1734737559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+FKK+MzoThj9yRh3UKNCCARWEWpodVhzuwrRKzUzmI=;
 b=Y9AIMNMn5K+HbEA0G0nlGLTPuwCya3/unefq5XdtFmEIzBTxjiOIPbEB/F//G3VP9s
 783u9dXfHi/7ovXo8J0mAKFcgsIQyCKF5IsBlK5mX3oI24zVTwKhFHnt7KKfG3na2jEO
 Fk7mHO4zzBnMCrW7ZlSzh4p8O0yvcFl2NbrjOATLRfcj5ortvXXP62Ub+HAGIASkIUIs
 J/Rc2IXeiFLxRc/Jadxn46aO7fxlh7PcU5zON+ZKUlIDbc0tOJ9bQPyA3fQaMOOFNHEW
 pzTA+YkaRfDtIofPEQ3ouBAJnRKuZRjM67dh1Hkp21/mMKzjZSmS0C2VSY8sXk4xB9KB
 KkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132759; x=1734737559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+FKK+MzoThj9yRh3UKNCCARWEWpodVhzuwrRKzUzmI=;
 b=hYJqEhTPBCD+Ku9bTGVPhi25NnOScYoOVyVbTVCdOPZTlllb48j6o2FxaGty1KeMTD
 ZXu2pqsfT+FyPkVNzb8YpaVi8+H7aNtR9rWgAN1CjakPQ53IaQmcLdQ6yvJQ6TWeVwWo
 h58xKK8ARjXuGOe92Ha5HOud2ji9EBtVo7axtwMWsnx86fHo6CTGs7z8ml7oUg6J/gVL
 XQjLRczaB8X3SsMGXtsi1L8CHtanplORIIUWt59tHBSgn2DU55rjP8i7doGrJpc9GUrL
 pq5GUEljLhZF+d0ICut9feOop8irtT6ppUeM3HdO8/JOpT0PAGs+NubxDfJWQ2n9y+tj
 IPWQ==
X-Gm-Message-State: AOJu0YzqaB49z7dMPIQ43It0WSjXRUVX3KSl3wTC+f3bUWmhoszBPiPz
 Q6aVlCqsEryKCIzABfqxZhZkkfZQyTBEdWBXA5XOLYJ9E/lT2OSO02fb7qzNOe7Idn/yBmiKOR0
 rJQY=
X-Gm-Gg: ASbGncut7I7XwW/1m1cXRW/dR3gRiwvyn3EbgZDx/O4m68K0j6Ku+KJn64uCDgcM2rb
 7uH2j7khl8K6sd2NBnNKuWsG1/fa9ZbKXVbaka6osVKcl6Z39cMSlE4w4SKbvjJCYESS9SuVjwX
 rOUbDY27RPrcr3fCbDm4Fi1YoDbLFTOoKgXINDeI8XoIazvRrERAT1NiGecqLCBzKDrQib4d/mT
 NY10pp1oKgqiM3PbanOUJC7EO5RpUfOGzHeSYA9KvBgoVBF/4yi27rvPsLHdP016Em60dKpAI0B
 CJCB7Q==
X-Google-Smtp-Source: AGHT+IHzlWluQd7Db73U7CRejk7ED7FLmdCjfQ8gNRuVj2DWv3IJy+Bpk3JDJAi2aDL7zAxmA5OSbg==
X-Received: by 2002:a05:600c:3b9c:b0:434:f739:7cd9 with SMTP id
 5b1f17b1804b1-4362aa362e5mr47575235e9.9.1734132759552; 
 Fri, 13 Dec 2024 15:32:39 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361ec75410sm78743755e9.1.2024.12.13.15.32.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:32:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/20] hw/xtensa: Include missing 'exec/tswap.h' header
Date: Sat, 14 Dec 2024 00:30:55 +0100
Message-ID: <20241213233055.39574-21-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

  hw/xtensa/bootparam.h:40:16: error: call to undeclared function 'tswap16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     40 |         .tag = tswap16(tag),
        |                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241211230357.97036-9-philmd@linaro.org>
---
 hw/xtensa/bootparam.h | 1 +
 hw/xtensa/xtfpga.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/xtensa/bootparam.h b/hw/xtensa/bootparam.h
index f57ff850bcb..4418c78d5bb 100644
--- a/hw/xtensa/bootparam.h
+++ b/hw/xtensa/bootparam.h
@@ -2,6 +2,7 @@
 #define HW_XTENSA_BOOTPARAM_H
 
 #include "exec/cpu-common.h"
+#include "exec/tswap.h"
 
 #define BP_TAG_COMMAND_LINE     0x1001  /* command line (0-terminated string)*/
 #define BP_TAG_INITRD           0x1002  /* ramdisk addr and size (bp_meminfo) */
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 398e6256e1d..2e264c61988 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -35,6 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "elf.h"
 #include "exec/memory.h"
+#include "exec/tswap.h"
 #include "hw/char/serial-mm.h"
 #include "net/net.h"
 #include "hw/sysbus.h"
-- 
2.45.2


