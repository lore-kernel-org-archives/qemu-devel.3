Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E598C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmXy-0008Jc-TP; Wed, 24 Apr 2024 20:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXW-0008AR-V8
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:45 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXU-0006B3-8l
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:38 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-60585faa69fso328465a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003233; x=1714608033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zvuJFJYhzHrJsCquoz1CbcaBtEBeZ6rJJCBGiMse0Jg=;
 b=nO6WpEkdoIkKL1cAgEckbmlXXq/kUoemNLzZxCrOgn2Qq4upCHuFrwzfFrOj5Z7TZi
 5vR7bJYQCLWIxc3LXFSXUi7/ZBbDTByGqeb+pVstYBrzHa2WLQiMjDeQqCxMUycic9ye
 kmVOtRucirhhgRZWPtOurXcqsH6uArNG+SiESFMd+WqyixefUy+bvf3v+VO/GQKQOoHv
 hWnTIA78h1zqPO4bjgNd0Dom4uPUVQ1Hl24ZVERk7PeObKwSsHLDO4wth5Ruqkt2nkoN
 2xwEpEvw93hKtvjNAt42lch8mZwQv27aeZCo1lAOi6kD4o1njz2Z9u5WRrN77gb4iZZ8
 sRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003233; x=1714608033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvuJFJYhzHrJsCquoz1CbcaBtEBeZ6rJJCBGiMse0Jg=;
 b=hL9dSy3TAA2G8wDjUIVFXjFt0x+1Hg45JzfhQ4ABmddJxp5N7AlZXBo7NyJ85eF7ah
 Y19Cv6Fm7UO8C/kpmfAgv5kePHTns+Y+Mr0X/98cO6YytFxyOK5sIaF6J2z07iGssARp
 e/CUd0t+g0tD+t4m/5ZGDOIgsyK9fBY0uBitMFv8eXWg4h0B3IHyu8vHdY3mF4TiN7zi
 1m002NSG42IFPL2zGtmdB1DDnnx7bxIul4Q9yqHiIS8QCACNVvKCOLs0kMMBA0Nx+SzV
 gptkFxVyRASNDK1iMoCUCnF/FnqobCMo8aD3O+U4I6SeBCYnG0F6NQG+bqN9eYJnEfeu
 IqeQ==
X-Gm-Message-State: AOJu0YxowR5P8HmYTEleY6w4ZGQNP4LZqESF7Vi6+O1vWPTphW6u4koj
 6JIPSzBVm1iY357DMT3sB0FsZDtmfVVQSuja1iYECCz8Paxv4ueZbdK+Trf3XYcB0mK3CC/JXQO
 U
X-Google-Smtp-Source: AGHT+IF6WG9QrHEup/o5OHLdXpN7VWtESckpMxqa1q1OZ8VlmQG7O/fuKAKANOGQQaemvYIneJOKjQ==
X-Received: by 2002:a17:90b:4d8d:b0:2af:c3ea:8122 with SMTP id
 oj13-20020a17090b4d8d00b002afc3ea8122mr587497pjb.7.1714003232116; 
 Wed, 24 Apr 2024 17:00:32 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/45] target/hppa: Use CF_BP_PAGE instead of
 cpu_breakpoint_test
Date: Wed, 24 Apr 2024 16:59:44 -0700
Message-Id: <20240425000023.1002026-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

The generic tcg driver will have already checked for breakpoints.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ceba7a98e5..dfdcb3e23c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -673,8 +673,9 @@ static bool use_goto_tb(DisasContext *ctx, uint64_t bofs, uint64_t nofs)
    executing a TB that merely branches to the next TB.  */
 static bool use_nullify_skip(DisasContext *ctx)
 {
-    return (((ctx->iaoq_b ^ ctx->iaoq_f) & TARGET_PAGE_MASK) == 0
-            && !cpu_breakpoint_test(ctx->cs, ctx->iaoq_b, BP_ANY));
+    return (!(tb_cflags(ctx->base.tb) & CF_BP_PAGE)
+            && ctx->iaoq_b != -1
+            && is_same_page(&ctx->base, ctx->iaoq_b));
 }
 
 static void gen_goto_tb(DisasContext *ctx, int which,
-- 
2.34.1


