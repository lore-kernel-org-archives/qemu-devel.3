Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A7AC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk74L-0000Ve-NY; Tue, 12 Mar 2024 14:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk747-0000OI-HP
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:32 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk743-0001Mt-IX
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:29 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dd68d4cff1so32852915ad.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268886; x=1710873686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSI45wyG1DbBDtEQROhzFaiavHjfnzmEgOAjYFnm1qw=;
 b=uv8pXXY5LZmJeZ10/oX9Qu4atJaJCx4cIIYqBtPlBF+zck7nvBavXNa8xvBrm6YpbY
 R/0x1atZPyw6hQ+BVbotcLL8kqpApHg4IneenuOeW8Ug6bDPx60wMy581GEV8qWRGeGr
 9TeezimiltM8qDxSfhTM2Q+aybE6IxXFrAHQRQAhE5keLX5CLCw8rU8XmAkFUWVVZ+EE
 Lbe52Jm+amxwm/aWT/lvmMBQm7ye8mr8Y+c5gLBbjvDpb+zRSMOsXiyDmnWdBSNYJ7ac
 FYvVkzslCWohVxGeH0YsmpChZxm/PAOCrz0qmYJJQBqdO1q0golF6NFKOrRedBQYHVqE
 hYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268886; x=1710873686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSI45wyG1DbBDtEQROhzFaiavHjfnzmEgOAjYFnm1qw=;
 b=VM9jNHakqkyI81ieq+draToHPSOORga0nEJ80jFuDxNOKc7Ur0T6w4UMLFJKZetwcm
 5UpgxTP0eEhU8MhqpFUvzPIBFzQEk6QpeQIJDe0iPEmbLN+/gA1vNKtHHQ7D5DPGy6r9
 uiAQqstzZq2TQdZnG1M2wPLSLsoacQZBxsZn2nxEnAih++XuialKEG6e20l2zQalRTId
 PhSky2qLAXnj1OP7azCz8Qiw8PGnFjjBquSIIDIV1kwTMxqlXRgqj+WiJ8aAMGe79Mc5
 9vtewalcG67ZOVp5PeSPQG9vM1Rg3bjYz07zcD/Cm/uaNGfVaJGOKoAQNV4sZvtrymoM
 Ejww==
X-Gm-Message-State: AOJu0YzlMAkWWwXg8h6E732ULWTpaKn9qKTFfyOo4wwEVnrP8ZUm3gEA
 ZeaupGmo/5tNAbqpO3P5nmRxZdul1DMnYOOjzY+EuVEXjRjUN6EYeuMOW98foHH0HVzWThC1WhP
 G
X-Google-Smtp-Source: AGHT+IG3lKnM4Py5NA07mZGnQn+n8riV7sNMW9M+S6zI6e2Jb7I/Ib26UBU4FyoCCE39w4E4y7wmig==
X-Received: by 2002:a17:903:2292:b0:1dd:96dc:dbad with SMTP id
 b18-20020a170903229200b001dd96dcdbadmr7967522plh.22.1710268885916; 
 Tue, 12 Mar 2024 11:41:25 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001dca40bb727sm6951739plh.88.2024.03.12.11.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:41:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/8] linux-user/elfload: Fully initialize struct
 target_elf_prpsinfo
Date: Tue, 12 Mar 2024 08:41:13 -1000
Message-Id: <20240312184115.365415-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312184115.365415-1-richard.henderson@linaro.org>
References: <20240312184115.365415-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Fixes Coverity CID: 1534962
Fixes: 243c4706625 ("linux-user/elfload: Write corefile elf header in one block")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 26d4c1d6b3..60cf55b36c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4204,7 +4204,14 @@ static void fill_prpsinfo_note(void *data, const TaskState *ts)
      * may well have higher alignment requirements, fill locally and
      * memcpy to the destination afterward.
      */
-    struct target_elf_prpsinfo psinfo;
+    struct target_elf_prpsinfo psinfo = {
+        .pr_pid = getpid(),
+        .pr_ppid = getppid(),
+        .pr_pgrp = getpgrp(),
+        .pr_sid = getsid(0),
+        .pr_uid = getuid(),
+        .pr_gid = getgid(),
+    };
     char *base_filename;
     size_t len;
 
@@ -4217,13 +4224,6 @@ static void fill_prpsinfo_note(void *data, const TaskState *ts)
         }
     }
 
-    psinfo.pr_pid = getpid();
-    psinfo.pr_ppid = getppid();
-    psinfo.pr_pgrp = getpgrp();
-    psinfo.pr_sid = getsid(0);
-    psinfo.pr_uid = getuid();
-    psinfo.pr_gid = getgid();
-
     base_filename = g_path_get_basename(ts->bprm->filename);
     /*
      * Using strncpy here is fine: at max-length,
-- 
2.34.1


