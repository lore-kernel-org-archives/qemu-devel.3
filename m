Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69663C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYO-00007S-0m; Wed, 24 Apr 2024 20:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXw-0008IZ-DJ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:05 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXr-0006Is-0c
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:01 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e3f17c6491so3355955ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003257; x=1714608057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RnrM6xlTtlmtawC51lsQAVs42r4HEzE1iyIC+QHuURc=;
 b=B5w1n5Q4bUKfTJ7WZfK+zAPQngmi1Zbn5ft/Xnk0T7+wy9TYJawPe87ehjjpI1nMIy
 dMnGf0lBAvXyKUfQe+H1jGw/jIUzFJznV2laqPyWnwzOs5pEJFtLkOG6R1onJ+00at3f
 FMwlBx8EXBZYVtCrt3vrfNkxKt5f6BahBsyEMkfm2i8nH7dMb1VwdzONcOkW56e3OtCh
 Z2rYHfUeuh9smJKhwzARzngc2Lp4ZnWIHrs8rZA/MUtc5haP0BYtaYnkrfdKS1JoPyxg
 Mffe110c4bKIDdjINNckLK0rBRfY4WgtVl2rPFdfXgmoQbzGz3EwQwfV+wfIRX5NjpH6
 IDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003257; x=1714608057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnrM6xlTtlmtawC51lsQAVs42r4HEzE1iyIC+QHuURc=;
 b=ZoM8qfoSvZ1tQj/VyfQVUnlPHcoReO+gb6KlFwwK7gU+Rlw5lcdAPzS0APdIl6g32v
 5a2SmxHAYdGuN100tl+7YlF3jrCudVRAowWH8HW/nWu5IWfz6kOTdkR+HH6SrgkA+hv3
 1j+CuubzdRb9QrtwrTYsKWFrxMCc99CPQUbtvHXOoNpMXGxtsxPkSQ3MaILAfHpQlsq/
 PxlOTdeG580ikT6lvJpxaD+aRPHfsHkWIoQTVqyb9cDQjWESkkYCl2m6sdr9ALvuNXYO
 EOO1HftvzgNspjX/Hn+yZF4BXIiEe1ODqlXQl3pVDpqzcPbnEUqlBYr6dA/DHS5StLeg
 m9XA==
X-Gm-Message-State: AOJu0YyQcHhJhxlzFGzliajUsrN6YO6IJoLkAmpkjhV9hCnLgJh8TooX
 8pHQEz1FQqqoFIm90zJiaJ5EYQWR48su+H419JsR/R7m16Eo9Z304ztE9h/sZWbzZipadM6muY0
 /
X-Google-Smtp-Source: AGHT+IH6kv5IE7r83h9iSE//RGVv7X9VTcbf8foRPi3VQa3aX7PgJ65Cmx4QsqAX/ajMbs0hvv8lxA==
X-Received: by 2002:a17:902:b184:b0:1e8:37ea:d10 with SMTP id
 s4-20020a170902b18400b001e837ea0d10mr3367321plr.56.1714003257450; 
 Wed, 24 Apr 2024 17:00:57 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/45] target/hppa: Do not mask in copy_iaoq_entry
Date: Wed, 24 Apr 2024 17:00:11 -0700
Message-Id: <20240425000023.1002026-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

As with loads and stores, code offsets are kept intact until the
full gva is formed.  In qemu, this is in cpu_get_tb_cpu_state.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index cc409ffe13..fb5bc12986 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -636,15 +636,10 @@ static DisasIAQE iaqe_next_absv(DisasContext *ctx, TCGv_i64 var)
 static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
                             const DisasIAQE *src)
 {
-    uint64_t mask = gva_offset_mask(ctx->tb_flags);
-
     if (src->base == NULL) {
-        tcg_gen_movi_i64(dest, (ctx->iaoq_first + src->disp) & mask);
-    } else if (src->disp == 0) {
-        tcg_gen_andi_i64(dest, src->base, mask);
+        tcg_gen_movi_i64(dest, ctx->iaoq_first + src->disp);
     } else {
         tcg_gen_addi_i64(dest, src->base, src->disp);
-        tcg_gen_andi_i64(dest, dest, mask);
     }
 }
 
-- 
2.34.1


