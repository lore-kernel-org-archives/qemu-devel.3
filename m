Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D47CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIPjp-00032y-4p; Mon, 10 Nov 2025 06:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1vIPMm-000276-6L
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:43:22 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1vIPMk-0006yr-HU
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:43:19 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso3390937b3a.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 02:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762771395; x=1763376195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gbMlt3DSI0uZtH+10OBQTzEYaRlKTH4uyYf1ABYmTaY=;
 b=idkCdv1o2dRZsrOXUOrqNX1mcI/JeWpQDOlfjWQ0VvR3JPnAV48BhUk3HSqMGbZebK
 EDXcFrGnLcFFhMExRdRz2UowfHJIivS18P0IFV8DGQIUPG9d71N/IemAxyBojwZX+M3G
 GjMoPVXV1qYAnlUKZNMBNmcDqDqc5f+s8MdPw+HwIeYiuEw/7n/dSUj63EKboX0yKm/I
 sqd4M/2R69bLSL91rtdJ1lrwtTuB6408eBXlZm5oQyaOOZ4qp6ICSZlYi+eX2hP+Ntan
 ym5mUhG7dV4xKjDnrSi1pEXa66UOSSqCvy36xLGMRqzduxXmN6Y+HT1dgzGly4GXWByB
 KS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762771395; x=1763376195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gbMlt3DSI0uZtH+10OBQTzEYaRlKTH4uyYf1ABYmTaY=;
 b=hamjYcMCE8DFJ5YP+B0a7V1K10sYnRrDtnnQWwQeFS3YiaYdgDtO8rAg23U0m4gRIp
 KRi85b4wxjdBDf/1FvPzU/Ho/MKwko4YqAxlYN7LNXNkRbLQ8NRgg1dKgkjyh9wE4muH
 833PFF4upNm+SgTUeSK6ZxyBkN/puiRG/0LNn/3lAI4Ih6lI4QHmFFB1oy3Q5esW+eFj
 w6V+H8IXMcIqlxQTBJxwFsWJP/OuFkvDm7oEIhW7rUoW9hQWgUhCu+1ebobA80XoEHfi
 Y8oB6AyikazvfA2pAS0EewNaif41LdbNa9xhnxxT8ggQCcryVJVut3YI0M+0fiaDFXgD
 CuPw==
X-Gm-Message-State: AOJu0Yx/8PzrlgXJDEBJyRRv4P5SZOjodqdpXYARFbDagRMCpPxI7N8v
 VDeMlNVbihHiSyjPspiP4iBWXWUimLG9s/E+OA9Anl7LPvrRkHhaoLbX7WuRWb7umOQ=
X-Gm-Gg: ASbGncvJ5XPZs6/r+msJNNDCAO7iSzH5ghhQlp0tjsRNc0Ut7BGOreuz89pita8k/Cy
 fwryR2ubbMFrZ26MPsfFgK8QLv7XlqupBkkwn2MRjsHmd+psFzk4DDcIyKkt8gdeGtvvu01Bfr8
 GCy7eqtTOl15b2NfhAutUVZ23wtX7ylZtrDMQa7+83qKN9gB34aD3OsXGp3YkON1WJGbR8Gi1Fa
 j5v+PaHApYUZKtbi/eFS3T8TYf+RI4T4mj5zPVBt5Md2nT4/c4+J6V3Yxrsz7ZSz/dmNmrDUXgU
 c3CtNnlOteFecZIhDnDJuGclQ2sdKly+CRwgvHMoE1MmbP0O10YPcx/GMGY3W1kBixFqEd1+zcG
 RuAOfF9CtQ6YQj4ZumHZo8uhYiuSyZpluuVnud8lv2focOVFE+KKxpt8CkhvktRbU/EBwNpRads
 IdYiUHJA==
X-Google-Smtp-Source: AGHT+IGs2lDWJe0imMrVhGTwpOSdlV4hsjJ8AC5iqnKZKLHlvI7ziTrfCBKNAYZhctf5+mieytJ4BQ==
X-Received: by 2002:a05:6a00:2d83:b0:7ab:2fd6:5d57 with SMTP id
 d2e1a72fcca58-7b227382d9dmr10556531b3a.32.1762771395297; 
 Mon, 10 Nov 2025 02:43:15 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0cc17784bsm11571163b3a.47.2025.11.10.02.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 02:43:14 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/sd: Remove unused header includes in ssi-sd.c
Date: Mon, 10 Nov 2025 18:43:11 +0800
Message-Id: <20251110104311.1640772-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x42a.google.com
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

Remove these header files which are not used by ssi-sd.c

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

 hw/sd/ssi-sd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 3aacbd0387..1782fb7431 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -16,14 +16,10 @@
  */
 
 #include "qemu/osdep.h"
-#include "system/blockdev.h"
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
 #include "hw/sd/sd.h"
-#include "qapi/error.h"
 #include "qemu/crc-ccitt.h"
-#include "qemu/module.h"
 #include "qom/object.h"
 
 //#define DEBUG_SSI_SD 1
-- 
2.34.1


