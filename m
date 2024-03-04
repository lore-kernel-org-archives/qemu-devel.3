Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE480C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhDkw-0003AB-O0; Mon, 04 Mar 2024 14:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhDkt-00038q-7m
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:13:43 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhDkr-0001bA-KE
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:13:42 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412e90ef887so4755165e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709579620; x=1710184420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJYQlLP/RL1iB+sA/9wIyNkwvTTFBy7MlRN8CyxoDMQ=;
 b=kMvLpFNqOFNsVYFlz3ZGajF8LmJqeBHlm91kdfK6x+9WUm39izGbcoQ6uwc999opOS
 1pZBiiV04BjBNOouWdx/j6CPoaj3dJqyFTrSDX7lDodY6n9U10wtNcLQS2RNiA+CUU5R
 ZyzBoKC1/e51ZXqGTf8Vg4Fs2XNcLXtiQgHlqmI4nRA+GFjplUcy6rOXlfOBjeiGiJyv
 NFClGK2HTHcrkocNg7WwIkHBOixZxOzkFbEzH5E2J2PLf7yinL7FOE50kpQZaxtSfzE1
 pMQT8QbbSz+kv6UHZThUVu08CgoClsSizt/AMeREoGoQfQc0/ck4TJSA96oxoS6pGhqz
 uB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709579620; x=1710184420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJYQlLP/RL1iB+sA/9wIyNkwvTTFBy7MlRN8CyxoDMQ=;
 b=Rj8Hn8jPHNEXDL8of1jfvuAZgGl1hEY+oFa/fSIgglBOXx0Ib8BeDXclFSz2w4cHM7
 Moo2yIYXipG1+qCjlgaSiHO3HrtixWBs3dn+oPaUOxCXa8lklbgVJFR+lAoXkiQ3Nd2h
 dveEhOqPTiIGfAsoYk54YJpax3RbYFABYwqjJdc/2DRyeOAnFJbN5m0fhOK+rhiSnoJP
 +5Ao6QbMoHDx+wSy4UCuvxtmyGAjg9Nje/A1B1ZYQcr6O9Tjf9CAEVOe9A6T817QpxEo
 lKoqZk4hoXQeMquNWPXX9MxlkKtPc3DzX0s9J6ZUuTZL9zAClx8jGKBv2MO7McKDM9++
 asvw==
X-Gm-Message-State: AOJu0Yxb9zMZtIpXzku7o0xZT8g97meDeG7snKuL3QLSU0sBjH6ZAqXT
 vi9G6XJNPqEJOPL0XiBlB7aKoAr3UNAIQxhUETWpYshJJbRkcfTz4Xn/ZMl339s=
X-Google-Smtp-Source: AGHT+IERLtrDLm32ZVC8EJ4rDiuWMW34PKbr4XqqthjGS23jirsMlhjrsDD9XlQMwcqq8BgUVP1MUg==
X-Received: by 2002:a05:600c:3111:b0:412:ada8:85a6 with SMTP id
 g17-20020a05600c311100b00412ada885a6mr7674285wmo.4.1709579620151; 
 Mon, 04 Mar 2024 11:13:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fl11-20020a05600c0b8b00b00412e2bb56bfsm4458708wmb.3.2024.03.04.11.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 11:13:37 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E4515F954;
 Mon,  4 Mar 2024 19:13:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/4] target/riscv: honour no_raw_bytes when disassembling
Date: Mon,  4 Mar 2024 19:13:37 +0000
Message-Id: <20240304191337.3101411-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304191337.3101411-1-alex.bennee@linaro.org>
References: <20240304191337.3101411-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

This makes the output suitable when used for plugins.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 disas/riscv.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 8a546d5ea53..86028efea85 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5192,19 +5192,21 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
         }
     }
 
-    switch (len) {
-    case 2:
-        (*info->fprintf_func)(info->stream, INST_FMT_2, inst);
-        break;
-    case 4:
-        (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
-        break;
-    case 6:
-        (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
-        break;
-    default:
-        (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
-        break;
+    if (!info->no_raw_bytes) {
+        switch (len) {
+        case 2:
+            (*info->fprintf_func)(info->stream, INST_FMT_2, inst);
+            break;
+        case 4:
+            (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
+            break;
+        case 6:
+            (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
+            break;
+        default:
+            (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
+            break;
+        }
     }
 
     disasm_inst(buf, sizeof(buf), isa, memaddr, inst,
-- 
2.39.2


