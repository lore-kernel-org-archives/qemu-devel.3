Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC0FC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 23:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rheNp-0006da-Ie; Tue, 05 Mar 2024 18:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rheNn-0006cq-Kw
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 18:39:39 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rheNm-0001WA-44
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 18:39:39 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc0e5b223eso53860035ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 15:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709681976; x=1710286776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GOolTmzYeE12+ps8/v2gwrBliAlhC/9M+kqd6Bq+ehk=;
 b=OFwlLqqj5fnU4z/rv3fuC48dQAnXuMY+fM457ZHeSCyn2+0D7YI2WdQ/fxdneMuUcP
 O8BvnPA7cy5cQ7lQaUHVnr4YmF60VmBTncILE9V5RRBYlccdC1zTrTZA4/sYDevdjatT
 SMRYeUU90fx9J+jlDLvp2XEF1+qs5noSnnBaiAodSKfU7AEkdvXdcPmGcl5Tr7Xa9plZ
 UAtUEsIJptFrGJz7WoEEVHCRdyNJLEFdDJUYBD10abGo/b/IM6lUU8qR4S9c+HS1qP/Q
 9gTtcbJaAqhQuK6dJ+7NzbGbGXf8drakd6/RO9ZFvDC3dL5DYH54XZ4mEQVC5SZonetf
 3hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709681977; x=1710286777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOolTmzYeE12+ps8/v2gwrBliAlhC/9M+kqd6Bq+ehk=;
 b=LKuxU47tajWa7KooGMOWEdpbAsYWYKPgbLKE0hUJggCWR9bizNiM9ik4RuycXAFPMu
 qHuLdUpbi9zxNQwvsI+iZGkMp9Rgop4jaECvssd70gbJIMhsUXgDEOOshLAmyR4yPFxT
 h7SS+uozJGPHqvzR+aORFNpzA/Sx+sAhhLBT4pXiMi1w9S+e1lUBGabzNnKNpTXtPN+A
 U1KReXuQJptSOfYP+g3BwdwyoAUr4A0lrUF5IbNvG4xJRgyJsXvoBfc3Bhl0K9/ghyDc
 jl+ButRBqteIqPOnjPVJ2jazBuGO0ofW1p8NWIx+Ruz/c4kF2wqGvn6gHUeAa5u9njXj
 PO2g==
X-Gm-Message-State: AOJu0Yy2PvON+U0grNxEgMgOW9sTcuBYjpyVhewcxwpV2q+TV3NhZxPQ
 JiDndHNi1ww9sNkYyC8MR0AFdsKHbQB7H4EOXnK4U8ArBPYqSBw53UecRJ5jMrFxTxvvK+qRctu
 M
X-Google-Smtp-Source: AGHT+IFHsQRY4a0tZJkZsSoaS5BfXGM8ih1sPBX0hcKfsFqj1IlsuBjacH242vfiVFf2qKv84ihfuQ==
X-Received: by 2002:a17:903:1209:b0:1dc:4199:a31d with SMTP id
 l9-20020a170903120900b001dc4199a31dmr3817103plh.53.1709681976682; 
 Tue, 05 Mar 2024 15:39:36 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a17090ad48c00b0029aac9c523fsm10047291pju.47.2024.03.05.15.39.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 15:39:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] linux-user/elfload: Fully initialize struct
 target_elf_prpsinfo
Date: Tue,  5 Mar 2024 13:39:31 -1000
Message-Id: <20240305233931.283629-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305233931.283629-1-richard.henderson@linaro.org>
References: <20240305233931.283629-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8565b9520a..a9a6f55d6e 100644
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


