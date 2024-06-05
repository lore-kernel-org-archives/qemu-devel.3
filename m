Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500D6C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExz7-0000hj-MY; Wed, 05 Jun 2024 17:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyw-0000dT-Lr
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:44 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyk-0003Q5-OC
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:40 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7023b6d810bso199757b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622129; x=1718226929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eAoOiYM0ExI1FMuz9eK9AmdYVnEbXhJzPvY/2SnngcQ=;
 b=QtgsMBIp6h/xkL8VDLa0Mj2Vh2tbESFm8q3i+Zr9uKPcbUY2e6YVvOMhYLz7Kvionk
 n5jLUIBTFz8wDfthJlZJjkiwfujawyAfClE2+Ms/OjA0VfsLuUcLbH/6+uMyPodJ0DV5
 4m97hEPEv2krQ3Dz60x2tzSH/vDDrwS05NckABC2DsX9RgUkA6jDp6vYntBmMjECF97H
 UDiM4v0SN3Ey4YclN3UWRejIlpq/alpxlfE8XsHjQj59b+1IKjl52GLv8swfPrtg9i12
 AzcxW0C2uT28w1fvfpJrs1Ya74RlRmjAtMDKHoqMkw7T+SQXVjGKvKAfb5Z3Zh4fKJJ+
 hGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622129; x=1718226929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eAoOiYM0ExI1FMuz9eK9AmdYVnEbXhJzPvY/2SnngcQ=;
 b=JTTfOu0nDc4gq17Y7gknl40u/1ytj85gFQvMnAJ8IZuMdeA4P2V+f1NOfTjP4gP+t4
 h/Npg/2KveIE7Slkt1eS2iIGsZ9s6S0CF/hU46WcGdZzP6pkWdSFCzfAbhC8csdIjiOG
 Ko9uNUstEro0wKrdpPz4f2byofsxARblSx8/MSPrN8uoROI8krMd5LuF1EnPTQ9LLk7v
 LVh3H092Uz2vNgwwlf9WvgfU1sEunX5M5+vU7A9L7tlOWAyh7CQOlqBa6tWJ0AEhRDMV
 xXCij99WHYXOlV7tdQN5QmZlQGvmoma3fqw+eZtnbcznZdq4Bjlzwr6anM02eS0jelzR
 1ieQ==
X-Gm-Message-State: AOJu0YwYG/ZuDjz/xUkobW1ffq42WrW5YGlBXKwvM1lgjssowBJOHmJs
 FLp7VAoJLNiu7grW/jlE8npBIy5PreFHxUqkF1ouwNxf5S2Ml4h26wp61GuOTWJzC7inlfcUmJy
 F
X-Google-Smtp-Source: AGHT+IH3ybJlW15ky/Q2pdBdpr1TzhiM5dVXrLSi+zDa1fW4qvrCDANDTG6zyEih+2Tyxvx4zUndhw==
X-Received: by 2002:a05:6a21:8195:b0:1b2:710a:5cfc with SMTP id
 adf61e73a8af0-1b2b71790c0mr3595401637.57.1717622129084; 
 Wed, 05 Jun 2024 14:15:29 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 07/16] hw/ide/atapi: Use qemu_hexdump_line to avoid sprintf
Date: Wed,  5 Jun 2024 14:15:12 -0700
Message-Id: <20240605211521.577094-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
Using qemu_hexdump_line both fixes the deprecation warning and
simplifies the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240412073346.458116-10-richard.henderson@linaro.org>
---
 hw/ide/atapi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 73ec373184..fcb6cca157 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "hw/scsi/scsi.h"
 #include "sysemu/block-backend.h"
 #include "scsi/constants.h"
@@ -1309,14 +1310,9 @@ void ide_atapi_cmd(IDEState *s)
     trace_ide_atapi_cmd(s, s->io_buffer[0]);
 
     if (trace_event_get_state_backends(TRACE_IDE_ATAPI_CMD_PACKET)) {
-        /* Each pretty-printed byte needs two bytes and a space; */
-        char *ppacket = g_malloc(ATAPI_PACKET_SIZE * 3 + 1);
-        int i;
-        for (i = 0; i < ATAPI_PACKET_SIZE; i++) {
-            sprintf(ppacket + (i * 3), "%02x ", buf[i]);
-        }
-        trace_ide_atapi_cmd_packet(s, s->lcyl | (s->hcyl << 8), ppacket);
-        g_free(ppacket);
+        g_autoptr(GString) str =
+            qemu_hexdump_line(NULL, buf, ATAPI_PACKET_SIZE, 1, 0);
+        trace_ide_atapi_cmd_packet(s, s->lcyl | (s->hcyl << 8), str->str);
     }
 
     /*
-- 
2.34.1


