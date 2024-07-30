Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DED4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcIA-00029a-9t; Mon, 29 Jul 2024 22:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcI8-00028Q-Vl
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:08:45 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcI4-0003EO-MZ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:08:44 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-39865a15900so14992145ab.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722305319; x=1722910119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvF0s1jQIBySSeBKtBCNdIkStj9P9gT/o0jVZTBUvsc=;
 b=SRfgQLDSCgy+V4bj1tnzi59BhqeBMwpPT7/WuQSo3ISmvtT4RjStcBnlAVSQtur7Za
 rGJet5HsgZHjDlmmXouXudrwU1l0EiHgElOQUVcnlcoUfUMJFQTDn6h9/0HwqjBBxMxP
 07bD25YrZ91gfojAxtjFvbxuQiWKOruraf0IXp2UfO30xDEvzxrFVJHzsjY1nUjRytu2
 hxF8tUQiJ+J1/1/UCZp/SKnXku/bcrlOJT1VeUVSgbmiyLDS/c11jv2qKkIFNWSitk3n
 OlQZ2EZKSumcOGKY4MG2dPYaAWp3cX8XVqhKUaBqxNJe4QxWiAkY4/v5gczM/4WtreFH
 cusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722305319; x=1722910119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvF0s1jQIBySSeBKtBCNdIkStj9P9gT/o0jVZTBUvsc=;
 b=j/v33bAtyrEPLg3K98waG9+kIv+qz0uwR4OYvdq6qXB/kCzGgFsPSCZdqE4zFIH5wk
 KowmrgGWHOx3jrvxzL1stoXJ5ITNtjoo4XYWQD5pQ7tMGYMpmFTMzQCmYRJTLe/X1Cuy
 KMFGrNFk/NcEJs7F6WQCRlK4uUphv5yAmPM+5aLIpy3Sjku0waeOM857E3+7JbyPPIYU
 SIeimbHtjWmyIdB8W1QZx/L6HCobZ4AcTAgs/f0YgOVMWRW3yuwE/Il/1/8UXrrM/1Nh
 C9VTbP49z2ruwSc6CO6tWLsIZKT2Is+R8kPIj3fPNle4DRKby8VW9Y06+bRQUpghUhtW
 JGCQ==
X-Gm-Message-State: AOJu0Yw3ngQ4v+VgXDJvX7suVNnBfBpfw8HZELUsslB4S59Hf/YllHqH
 MxhTK9KPVwRealKNuqClINJ6G2xmFaiEU7HJe0Rs3OQu035b3gFDtu7zgqjbSnkgVVmcxaUvHtZ
 O4aM=
X-Google-Smtp-Source: AGHT+IFTIf7LOeBm+FjgWoD0szE5P73hRxwPZGfNUF9Ox3Ri/JAmTT5m+cx07MMpvDb2M0XFQ+cyAA==
X-Received: by 2002:a05:6a00:2443:b0:70d:2583:7223 with SMTP id
 d2e1a72fcca58-70ecea2ef3emr11413551b3a.17.1722301934907; 
 Mon, 29 Jul 2024 18:12:14 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c6ff4bsm6750206a12.4.2024.07.29.18.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 18:12:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vivian Wang <uwu@dram.page>
Subject: [PULL 2/5] util/getauxval: Ensure setting errno if not found
Date: Tue, 30 Jul 2024 11:11:59 +1000
Message-ID: <20240730011202.480829-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730011202.480829-1-richard.henderson@linaro.org>
References: <20240730011202.480829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
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

From: Vivian Wang <uwu@dram.page>

Sometimes zero is a valid value for getauxval (e.g. AT_EXECFD). Make
sure that we can distinguish between a valid zero value and a not found
entry by setting errno.

Assumes that getauxval from sys/auxv.h sets errno correctly.

Signed-off-by: Vivian Wang <uwu@dram.page>
Message-ID: <20240723100545.405476-2-uwu@dram.page>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/getauxval.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/getauxval.c b/util/getauxval.c
index b124107d61..ad4f6686a8 100644
--- a/util/getauxval.c
+++ b/util/getauxval.c
@@ -95,6 +95,7 @@ unsigned long qemu_getauxval(unsigned long type)
         }
     }
 
+    errno = ENOENT;
     return 0;
 }
 
@@ -104,7 +105,10 @@ unsigned long qemu_getauxval(unsigned long type)
 unsigned long qemu_getauxval(unsigned long type)
 {
     unsigned long aux = 0;
-    elf_aux_info(type, &aux, sizeof(aux));
+    int ret = elf_aux_info(type, &aux, sizeof(aux));
+    if (ret != 0) {
+        errno = ret;
+    }
     return aux;
 }
 
@@ -112,6 +116,7 @@ unsigned long qemu_getauxval(unsigned long type)
 
 unsigned long qemu_getauxval(unsigned long type)
 {
+    errno = ENOSYS;
     return 0;
 }
 
-- 
2.43.0


