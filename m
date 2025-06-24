Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91A7C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 01:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTsJe-0000ac-Iz; Mon, 23 Jun 2025 21:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJZ-0000Yx-GR
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJT-0005mz-Cs
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:09 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-73972a54919so3953444b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 18:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750727941; x=1751332741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPdTg3mTyrHOh2KwK9/hiLGU0SNJfuYE0WsynkUI5MU=;
 b=xlXwoHnKve2EwpUGthO96x7DIRhtH5mZcnpZ4FgwAUCUklsTnF2px6FqMqXsgKdO7D
 IgzMg7OI9aSHS/+yCHZhHu7qGK1b7KZwXtVJE/CYlTRJy17drpkSV5+FSce2v4eDZlBK
 CjdqO4iUHSanqAxzH7nDyY0Px4lk0+bOjlPYArJG1oCn0bUi03C2CTUTQioPMmAwZAIV
 idjlY3frA6N/xi7JJWdK2GlLhpxwIg/8EResIHpXsDbCysHILqPUh98vn8Y3fR4GV+Ye
 nCdfW8pfjTrwwhAcFW7ZbJnocWNN0/1b7S5uu6hrbtBoHynplTkQBtYbOPBjkDrGqEWM
 omhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750727941; x=1751332741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPdTg3mTyrHOh2KwK9/hiLGU0SNJfuYE0WsynkUI5MU=;
 b=MtRo9qRFhXe51oCsbBopMOnHGH4VMEoX1F6ZOhOuy8W0zT66txiFg+RftR034SqNcQ
 sMNti20jZYmM2whcxMQytyQcvHpIP9L2s4QJ3Tw3XQXkrsB+x1C0IumASxma40yQPgyt
 PvoQMbiVpehI6MTeAZIgBRyq5oMMp48KJjtTn9LietVqtWGHOw7RZSzivVIjQN9IRK2/
 ro+UdMYX/OqSd2W6Wz3Cr41ZTe0z64rLR0eeCbCcanj/3CEQVv5zv/P72S5954ekWRTz
 qXqEgRZm2ywQkwt1KbQNWgLoYyfupj82PnN1jXGOvqL0VzN4kHazAuzMIaf+DM9HyhM8
 tC9w==
X-Gm-Message-State: AOJu0YwnMeMivDumuS93BhHZSS4DNSae/QElFsKjYpA/GtiDzyMqxbkp
 W5EB9WII9/lX1xqT7B7PvQh2K6rN4ofxecr04SdXdIvdCbNs+OuQtTOOI8lZA5Mi1SJfD2cP/4C
 z2+bKtic=
X-Gm-Gg: ASbGnct/2LlsMw5EV1GJ4qV/fhA9KC0dPmyfeCPA0KxgFeg1EQC/RbdoLYq4E6yS8Rj
 RqUdblJPsGaeBLxgCvPjokanRnl73ai7Xn6MQt5afgyH+N9tIst0s85siivHxp6vAa0+IjGSzb5
 R9PI2wJ7fSWPRhIx+KC/VCjW7MvY7tvv8IkV9V/UYZGdSdX5g3pUpTAvHoteoo4ttUT1l1iZy1a
 8uR7ZH+qEmenINGUORo58q5zHJKUejGnuAsWTUZ2+woIb23UyIY1k5YTXD6HexI4YgZKyHDwDB6
 mN+3OQ4c/otsHRbIqXx8O1/uhtPXx/NPkI49e266JwD6Il9dkfeYd0/YL7zXU+oE8mDZHH7jKfr
 N+eG93DmSz4KMqoKuAPIJ
X-Google-Smtp-Source: AGHT+IHHxGSjJmp4QENNJrmSB1FsL8v/0NoXsxfJijq+9qyygZ1B6Tm5gkqso5C86fLPbKmcwFXnjA==
X-Received: by 2002:a05:6a00:2789:b0:748:ff4d:b585 with SMTP id
 d2e1a72fcca58-7490db30e09mr20333697b3a.19.1750727941384; 
 Mon, 23 Jun 2025 18:19:01 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d28sm412080b3a.28.2025.06.23.18.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:19:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/11] tcg: Add dbase argument to do_dup_store
Date: Mon, 23 Jun 2025 18:18:49 -0700
Message-ID: <20250624011859.112010-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624011859.112010-1-richard.henderson@linaro.org>
References: <20250624011859.112010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index d32a4f146d..1aad7b0864 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -483,8 +483,8 @@ static TCGType choose_vector_type(const TCGOpcode *list, unsigned vece,
     return 0;
 }
 
-static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,
-                         uint32_t maxsz, TCGv_vec t_vec)
+static void do_dup_store(TCGType type, TCGv_ptr dbase, uint32_t dofs,
+                         uint32_t oprsz, uint32_t maxsz, TCGv_vec t_vec)
 {
     uint32_t i = 0;
 
@@ -496,7 +496,7 @@ static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,
      * are misaligned wrt the maximum vector size, so do that first.
      */
     if (dofs & 8) {
-        tcg_gen_stl_vec(t_vec, tcg_env, dofs + i, TCG_TYPE_V64);
+        tcg_gen_stl_vec(t_vec, dbase, dofs + i, TCG_TYPE_V64);
         i += 8;
     }
 
@@ -508,17 +508,17 @@ static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,
          * that e.g. size == 80 would be expanded with 2x32 + 1x16.
          */
         for (; i + 32 <= oprsz; i += 32) {
-            tcg_gen_stl_vec(t_vec, tcg_env, dofs + i, TCG_TYPE_V256);
+            tcg_gen_stl_vec(t_vec, dbase, dofs + i, TCG_TYPE_V256);
         }
         /* fallthru */
     case TCG_TYPE_V128:
         for (; i + 16 <= oprsz; i += 16) {
-            tcg_gen_stl_vec(t_vec, tcg_env, dofs + i, TCG_TYPE_V128);
+            tcg_gen_stl_vec(t_vec, dbase, dofs + i, TCG_TYPE_V128);
         }
         break;
     case TCG_TYPE_V64:
         for (; i < oprsz; i += 8) {
-            tcg_gen_stl_vec(t_vec, tcg_env, dofs + i, TCG_TYPE_V64);
+            tcg_gen_stl_vec(t_vec, dbase, dofs + i, TCG_TYPE_V64);
         }
         break;
     default:
@@ -574,7 +574,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
         } else {
             tcg_gen_dupi_vec(vece, t_vec, in_c);
         }
-        do_dup_store(type, dofs, oprsz, maxsz, t_vec);
+        do_dup_store(type, tcg_env, dofs, oprsz, maxsz, t_vec);
         return;
     }
 
@@ -1731,7 +1731,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
         if (type != 0) {
             TCGv_vec t_vec = tcg_temp_new_vec(type);
             tcg_gen_dup_mem_vec(vece, t_vec, tcg_env, aofs);
-            do_dup_store(type, dofs, oprsz, maxsz, t_vec);
+            do_dup_store(type, tcg_env, dofs, oprsz, maxsz, t_vec);
         } else if (vece <= MO_32) {
             TCGv_i32 in = tcg_temp_ebb_new_i32();
             switch (vece) {
-- 
2.43.0


