Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AA3CFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2X-0006HX-SI; Sat, 05 Oct 2024 16:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2V-0006Fs-9D
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:07 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2T-0001iD-P9
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:07 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20aff65aa37so27611155ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158764; x=1728763564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=js9k8IR/cEhAqGc5dKpCioG/n/UgV+piB56d5dg8Aiw=;
 b=uiErL/iL5fiZsmvpRKLEV3mSd4tKAGuHXDlECqRIZFX6tC7NTj3TrDzKnEoVl5IntU
 nIWzxlgGgcdeH5ayoyRpGmAn1p5XhzhPjaZe3DAsbq2lJ05T6bDPFsT+eGbWbkrsrP0q
 XtL3mUHYl3f72OqIlzpyjLpbhlnDmefJo6jXzh3sDPgEKxwgRj01ZXHZ0kXwAlhyPhD6
 Ad5gEy55JNQG4LnIox0JOqcbVvxw0mvI/sa/V3e8+3p9HMGTaTB/JNIXeEBGJLP3dxVv
 yGxT6+8eto/YFjMNEeXTxImBqACYrpa04Kw7b5oZs3QbZWTJKA+LC5Tf+SAdkfEy37tc
 E5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158764; x=1728763564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=js9k8IR/cEhAqGc5dKpCioG/n/UgV+piB56d5dg8Aiw=;
 b=Tr/A8mpaiLBJN9JHJ42CMDhJTf/I6HQR1lAGWpbq8C732A9iYpSaqeaSlQ8fqLihbs
 yCpdkbIt/X3p7PcaNE2n0Jpqbd4QEUPSlpTfzTK4MPicBsEdBLtnuFKd1k6oNuyeVRp5
 ljeUHp3U9petwn83zEyEtEea5jXzdR1RuRG3c13WkHo23zitNOiWNsupN/fkf5nIxWma
 9p+q7pbzTtOPcR2obbvyMuO6kcOKqiJLtIuRsVSb7bH4PyNh0hUTqSeODj6o0uJcl4Km
 xHDCjZ1tKfZTciyO8Wqcy/EkEthKCTo3b01p9xJVjOhfbGgx7EeHZi3bDPwp1tZpKTZ/
 VuHQ==
X-Gm-Message-State: AOJu0YyEFhUq2clRFx2i5z5px2ofZxk5cxYd8XhPgf71swQPVRob28y2
 MSB/9vFfTgUGQfr6n5KtRzUuYwuiG3QpKZma4PgX/Hl79ppXMMWpCDJaLadjZmegzffb32Gq+nM
 n
X-Google-Smtp-Source: AGHT+IG2QzkqWQJ6aa5SACwUNhrBcwJqwMcmd6FgF+mUSPNCiyiBOS8ZrrP8asqO/lz2F3toxq/lxg==
X-Received: by 2002:a17:902:db0d:b0:20b:8642:9863 with SMTP id
 d9443c01a7336-20bfdfc268dmr105234565ad.18.1728158764343; 
 Sat, 05 Oct 2024 13:06:04 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 03/21] include/exec/memop: Move get_alignment_bits from
 tcg.h
Date: Sat,  5 Oct 2024 13:05:42 -0700
Message-ID: <20241005200600.493604-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

This function is specific to MemOp, not TCG in general.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h | 23 +++++++++++++++++++++++
 include/tcg/tcg.h    | 23 -----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index f881fe7af4..97720a8ee7 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -170,4 +170,27 @@ static inline bool memop_big_endian(MemOp op)
     return (op & MO_BSWAP) == MO_BE;
 }
 
+/**
+ * get_alignment_bits
+ * @memop: MemOp value
+ *
+ * Extract the alignment size from the memop.
+ */
+static inline unsigned get_alignment_bits(MemOp memop)
+{
+    unsigned a = memop & MO_AMASK;
+
+    if (a == MO_UNALN) {
+        /* No alignment required.  */
+        a = 0;
+    } else if (a == MO_ALIGN) {
+        /* A natural alignment requirement.  */
+        a = memop & MO_SIZE;
+    } else {
+        /* A specific alignment requirement.  */
+        a = a >> MO_ASHIFT;
+    }
+    return a;
+}
+
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 21d5884741..824fb3560d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -281,29 +281,6 @@ static inline int tcg_type_size(TCGType t)
     return 4 << i;
 }
 
-/**
- * get_alignment_bits
- * @memop: MemOp value
- *
- * Extract the alignment size from the memop.
- */
-static inline unsigned get_alignment_bits(MemOp memop)
-{
-    unsigned a = memop & MO_AMASK;
-
-    if (a == MO_UNALN) {
-        /* No alignment required.  */
-        a = 0;
-    } else if (a == MO_ALIGN) {
-        /* A natural alignment requirement.  */
-        a = memop & MO_SIZE;
-    } else {
-        /* A specific alignment requirement.  */
-        a = a >> MO_ASHIFT;
-    }
-    return a;
-}
-
 typedef tcg_target_ulong TCGArg;
 
 /* Define type and accessor macros for TCG variables.
-- 
2.43.0


