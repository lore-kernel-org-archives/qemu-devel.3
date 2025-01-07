Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28BFE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4YF-0002pf-QZ; Tue, 07 Jan 2025 03:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X2-0000Im-6Q
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:44 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X0-0002xc-Eo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:43 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2163dc5155fso218365935ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236899; x=1736841699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=do98P1KZQUj6jNGj9g1kAHANixJsuA3aUdkphgcKfEw=;
 b=TagmS/R9xOXLEKYVgSwAjCqGzYKQQD0Mw67tSYcLs6j6SbWFMMCI4dtRg4STJb7gdC
 gib5R45XAVPZ37h1QTjvFQdEggaNTcT7CrPoklw9uJAv63PkK9WYLoCJCwgV+LlmHFzM
 0QEJ6LrXN28WatP+62diruB787w/qOGMqUtSnrn2x903eVUHgYCnmwUij1IfKsmEvNh2
 go9DgPv4KFeUTh/2f9LXENYHOr0KvDxk6j+UgdVdiTHFvyPKqTDnPBgc4mAr7o8n9EfL
 dT9XSosWzf8uX8WKBh5pWyCCUVn8unuteq7qM1xaqO0Vds+tumFYKxw92cSE8dK0xbTp
 VUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236899; x=1736841699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=do98P1KZQUj6jNGj9g1kAHANixJsuA3aUdkphgcKfEw=;
 b=gPyBN2QohUpYNcpLU8YUnbU9g23gscF+QytwQiuiJ8umNyCWeuwBaug+JvefD+muxi
 An8birro7LrFMHUpUtULNmSSgO71JZ+jxCYP6n9SZz4j3Sz7Gb8V6DXYaPHTRnRIERK/
 Wvl1efUAqgRoPGtK72DurLnIRa4TLlTcQY3+R5ofoMs+qYhOupTZ48x4KY5LaONcUuAP
 WBcpxoz1dQ//0XfrHEcjtZhNMvR5FArrGchH9/okpL4/AKg130MPBrvzUt/9rkQ4OM2j
 sXnR3blkAuWNHSIbubnkFfsk+UAhFX0NW7icvMZ9IxzPCjLZ3fTRAOfHb265JJzbUjq+
 Dd9w==
X-Gm-Message-State: AOJu0Yz+nmMlJ7qtHPQPvR/RCC7jTQEOvJ7pGHXfkV6lKna6WSH75VFI
 xUxVm7K10RkNkvx+GmzWjefb8TP5Zla1jppqqKvjm1nVedUtinj7VnT+4ILFkopHRb6f4WHXVwx
 y
X-Gm-Gg: ASbGncuIpwv8YxT7s+VCG5PcUvdb9W4odj6iuFm7TfnC0ITAsVpesMt3OlPTbpjPe0G
 XqDf7hzmBLjNTzTMImnuzVLjqUoWDc7b17FyRPDA3S4RhQe9lXNvkeqOH7qjQ3Z8s/FGi26UjEI
 FvJBtX319yN75VfOZg4Nc/3UtGWipY55BmNJ+trRrEoZ3DUsr8xsf0QTQvbeVzoZBxdfFKM0unf
 NyEItH343hSzFlulOpd07gFNN/h81Y9T4JWtBxOQ12e0v4HiZgwjCtiYRLesJHfZMbYZ1HHu+l7
 2o72Vo1NjEglVgKfQA==
X-Google-Smtp-Source: AGHT+IEH7zXV82AnX513ORiWmBEa0O0q6rcAGZq+tUg224g+6QHyLxIUW9z1Wrd67hf8k9MOHRxGVg==
X-Received: by 2002:a17:903:2cc:b0:216:5867:976a with SMTP id
 d9443c01a7336-219e6f1176fmr786008915ad.45.1736236899473; 
 Tue, 07 Jan 2025 00:01:39 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 24/81] tcg: Constify tcg_op_defs
Date: Tue,  7 Jan 2025 00:00:15 -0800
Message-ID: <20250107080112.1175095-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Now that we're no longer assigning to TCGOpDef.args_ct,
we can make the array constant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 2 +-
 tcg/tcg-common.c  | 2 +-
 tcg/tcg.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 612260a528..1b8bb49aa8 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -716,7 +716,7 @@ typedef struct TCGOpDef {
     uint8_t flags;
 } TCGOpDef;
 
-extern TCGOpDef tcg_op_defs[];
+extern const TCGOpDef tcg_op_defs[];
 extern const size_t tcg_op_defs_max;
 
 /*
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index 0f30e5b3ec..e98b3e5fdd 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -26,7 +26,7 @@
 #include "tcg/tcg.h"
 #include "tcg-has.h"
 
-TCGOpDef tcg_op_defs[] = {
+const TCGOpDef tcg_op_defs[] = {
 #define DEF(s, oargs, iargs, cargs, flags) \
          { #s, oargs, iargs, cargs, iargs + oargs + cargs, flags },
 #include "tcg/tcg-opc.h"
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 234e837e39..f72a8e5a47 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3364,7 +3364,7 @@ static void process_constraint_sets(TCGContext *s)
 
 static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
 {
-    TCGOpDef *def = &tcg_op_defs[op->opc];
+    const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGConstraintSetIndex con_set;
 
     if (def->nb_iargs + def->nb_oargs == 0) {
-- 
2.43.0


