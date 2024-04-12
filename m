Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93CBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQ6-00070R-Tb; Fri, 12 Apr 2024 03:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ5-0006zo-T7
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ4-000786-CQ
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:57 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso6364615ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907235; x=1713512035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWTBmrF16GSaydEzWRv0Zn9YqSFsjsSSjgb9YwJ02w4=;
 b=Zuz3gB39RFRPXjjhlMe00Gye62SaGQL9MZHWpfKIzppFAiGXWsnI1oqea+lJUC9vDI
 KdrbE3r12I3nIQhES049JHCTs8xbWHpLoxRGVEGxjfjdVzc1IZ42X/sejepJ/stMfScG
 Qi+MVCORtIQBXUYbF8yp0bBupNMnD6u8kewKSuunjmKJ6WqMERrTLgWWXI8YoAMD3IlM
 Yxu+uwMuM4aJT+C6J3XRvg2s0XHrnEVwwnmz126O4ImNpFeAcO8d1tHslTfAFUF//BHy
 E46FEh3pD7zFQtJEb79g3KWZnhp8y2jIA+3roQbWGuvngF6OKsF44aQ5nNMnErLWfYsT
 YtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907235; x=1713512035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWTBmrF16GSaydEzWRv0Zn9YqSFsjsSSjgb9YwJ02w4=;
 b=Uo3UIrwI38THwhwHMCA+WWH79pcoXnzZZC7Bb9JQ8TbC+4qXqcTlQ+j4ytrxLE+Olm
 fxVclEvBBQbpL9/OtTNtPdZGANLZOEURZKXr2o0e+ayUzetbUpmFc3Sqia6yyVppadMV
 Ja+Jua+dl7OT6sidSjiC1T+0qLz1GKW2wPx8oH74L+IHs2OId/CwOTzuYa5F7ILUv2q2
 X5kN0LCpQpaRcIn0hZIwGux2G7u5of+85RvqiTfLjfwIdhLlmXDnANEnpkZDwRU5iV/V
 l9YGHJ3w0ZuYhT1zHsXffFOsgU4+LoruBzPLe01CdjMJZCgL04Vd8M8ivGokHYAGlqjc
 NxYQ==
X-Gm-Message-State: AOJu0YyP17coF7LsZfvfK7V1hm20t77ln2KGc+31Ff+gjRch/L/d8SOH
 COd7wp+mTNKp98XDva6dwrp+gZtWCXlh2MVLKeRxFyMz3PIalATGPFmAj7RM7hukv31KA8Mite2
 o
X-Google-Smtp-Source: AGHT+IGsxKRM8R7Pclaj2h3kb6YavwQ6drPmrrbSr59Iij5QFltY/IbyeEiK2HE5Qh3BfyebQKo05Q==
X-Received: by 2002:a17:903:2289:b0:1e2:81c1:b35e with SMTP id
 b9-20020a170903228900b001e281c1b35emr2143992plh.54.1712907234841; 
 Fri, 12 Apr 2024 00:33:54 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/27] hw/ide/atapi: Use qemu_hexdump_line to avoid sprintf
Date: Fri, 12 Apr 2024 00:33:28 -0700
Message-Id: <20240412073346.458116-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
Using qemu_hexdump_line both fixes the deprecation warning and
simplifies the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


