Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF20C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFA-0002pz-Vn; Sat, 19 Sep 2026 12:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yF6-0002pW-NZ
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:48 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yF5-0008EQ-DE
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:48 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b4bff33d18so736215eaf.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836526; x=1790441326;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3X5p8HsBP/JRwDiZ+tLss6J0kLBzgb+35YGZ9nZAIkM=;
 b=kauGC1nYmkI14z6tdEo/htVHLfuS5E/FBOyq8P6uIc6LudgX+jW/w6qKk483OhiuY3
 uM9HL3uBUssQKUTxu+jNp/ad6scQYfA6kHo93I1UNlXUSMWkmji5Iekjwq4YHw3dL6Db
 MyJgv5zwSfQk8IaFOLQuZr0m7TEmVSflh5/sp/s2OZMOZqaxitdeAWwCZOBf7wI0qiY0
 xj5rXTDlBMlUzTxjegN6aJ8l9YyK1xkH6VH8npnLtf/qsNqnz3OHTgjHdjNuNnAq8A1H
 acpwFOT7GYN5OPQUePhLoUrBKwql4jIa90t/vF8vpYxY6Z4gZ3LytVD0coNbRZYN0gSo
 pU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836526; x=1790441326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3X5p8HsBP/JRwDiZ+tLss6J0kLBzgb+35YGZ9nZAIkM=;
 b=XjTHQ4htLsKFx/dPJXtJupJMWd1Jv9YXUaIo6HvaLBp45FtycPIKhlBaDKCsYZqsUO
 aWmiSCWnlxTi/K78ZiGGJt1/JZEb4gMqEPi7YZShKC7fRZH9/InLUo/axrFuDjduddle
 cDFGzRwqJMh3zHMH2E1OEEf43AA0+YdYLAKm7LGlWWIPt4OY7Qy0q0sfAHx+N1vMLxtI
 N53GJC9NE9MmQL/H9jkQmPfNksX2zQ3c88PCfRiyp4QdQOXOkIsbbtr6eHmXaL8iwOEg
 w/Ztq6hEES252EeY0H0OH3jV6ylui+K0DJoJ3hj97H4SnKO0FR0r35NETosK/mWNokE/
 17OQ==
X-Gm-Message-State: AFuF++l8kuO+u1Hs6vofL8AXLyBH4OmlGnlkuIZJa8FzbZGu4yJ3KgrS
 Rb9M5wYfUKhk95sgOr3FdeOKP5n/tdTG8+olrkEjRIkQnwwSTk24dm4pzTyC9WajQ6WkVCTfl4w
 jFgJkZNI=
X-Gm-Gg: AYBFou2NxIujHrHaw0VihwzmcOjMHFJ17bcHA7MxIM3pyelFSpukkJgx9a1zqWEr4sp
 lJ1G8SXmOIkkLgfjKLQ43fHGbq/4jeVCLJ/BwExrBcSZt5gT0CL/JumZrQvs7X62PfXKvbbblCN
 NCD9vq5Y2/QpI4ow9C97ansk4boYraaPlyU95HMeLJufxbHI9U2Rra4rsFWYXIfvqBtsrtFOZLd
 MUL2FoxAvvHtfdG0d1nG3yeuKz7PvCcs5ioTVr4tzIB1UdKMHu4T5cLG6jczP/FDAcGHj6C0DjV
 sJSLNCH3hUt95JNqIKBZJaZTb3XijpZtuVVxnJW3+fKadA6OGMuWGXEVxE9xzROJo7jNGCb9bgv
 p54t0Snes52oJ/PObpPEluGGf4Jrp5av/bAlKTW7kMorgGpji/ejxSyQdzZlXw6V+AwxZGycoxY
 YukJxKeT60beYMgRK9vWiEfZh9vxhd0mvAI9D/nR3+i1XVzWZTfoeJbEjgNg==
X-Received: by 2002:a05:6820:207:b0:6b7:8396:f3e2 with SMTP id
 006d021491bc7-6ca9d652d06mr5442786eaf.68.1789836526236; 
 Sat, 19 Sep 2026 09:48:46 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:48:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/41] bsd-user: Move sys/uuid.h defines
Date: Sat, 19 Sep 2026 10:47:38 -0600
Message-ID: <20260919164810.70151-11-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo2-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Diff reduction to blitz. Move sys/uuid.h to the location in the blitz
branch.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 4af79669e2..47aa01fbb5 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -418,6 +418,21 @@ struct target_freebsd_flock {
 /* user: vfork(2) semantics, clear signals */
 #define TARGET_RFSPAWN (1U << 31)
 
+/*
+ *  sys/uuid.h
+ */
+
+#define TARGET_UUID_NODE_LEN    6
+
+struct target_uuid {
+    uint32_t    time_low;
+    uint16_t    time_mid;
+    uint16_t    time_hi_and_version;
+    uint8_t     clock_seq_hi_and_reserved;
+    uint8_t     clock_seq_low;
+    uint8_t     node[TARGET_UUID_NODE_LEN];
+};
+
 /*
  * from sys/procctl.h
  */
@@ -459,21 +474,6 @@ struct target_procctl_reaper_kill {
     uint32_t rk_pad0[15];
 };
 
-/*
- * sys/uuid.h
- */
-#define TARGET_UUID_NODE_LEN    6
-
-struct target_uuid {
-    uint32_t    time_low;
-    uint16_t    time_mid;
-    uint16_t    time_hi_and_version;
-    uint8_t     clock_seq_hi_and_reserved;
-    uint8_t     clock_seq_low;
-    uint8_t     node[TARGET_UUID_NODE_LEN];
-};
-
-
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.55.0


