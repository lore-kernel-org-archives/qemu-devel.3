Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBC6CD1292
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 22:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtEas-0003N9-Gv; Sat, 06 Apr 2024 18:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEar-0003Mk-Ld
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEaq-0006gY-1o
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:01 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e2178b2cf2so30600875ad.0
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712442778; x=1713047578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+n5c7Yxg8Vn5seTMJXxw9ptGbTW4ezPBKl3xezctxZM=;
 b=s/cUR2YeZate0zQhDZYSpxe9C8JimrO0ZJzCgJysH3RG2Dc2fv8TeTwzkVa4fwQsXL
 S+kYg3LSA7onYadCxEOiJOITKVU6Y5k/XwQ676F8eVSLezR+gHTUJ0/0zjxxKmUpLOd1
 AKTlwW7VbNNuWl23l4XSQkdEYKqT7AJTO5J+OcPOD40QBrEcJnEkBpXGv5QedyX+pxOK
 yk+FOY1KYrRYiwfNhlifrsVVSBBQb90HjljF61hCJ5Wv22kNCsJ08j8j0awTdlCTLDjQ
 7vBDTt/rl0QOLzzQfKmSQ2NEH37855mzsGW+oQgZroWTQetc2++h1XcOvje1Fcxsg9UE
 JD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712442778; x=1713047578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+n5c7Yxg8Vn5seTMJXxw9ptGbTW4ezPBKl3xezctxZM=;
 b=sgZJTabVoE1aZ9UiSpimaUB5COrl1hQpYIoEeckSSW5sDOya265lG3bjlV3bPhYGWH
 G8C/SICVIyITGE22+dt0abDP0zuUfquEj7zealcB9G0QvidKKhP4cnTNk+PA9XqG8Rog
 dYix10DzHjNzYjS2Pdp3bnDcLzNzkD7mXkm5wxvWot7LfGu5EAbaiPaWoawOClIi+yPq
 9fPoVFB6EiiEEhOkhhf3wuno8c5MHorev9FY+gFjSgH+kiWouPEY3/Am59ASvoKnN77s
 X3jwnS1orutujUjd4lX0arcy49bCkCnu92JjxVRAvEL5Bj9kGVVLHXrVmFjmDQiJbfml
 AEPA==
X-Gm-Message-State: AOJu0YyTbzB6vw6g//BZNcDG5omf87zUIpr1hq9IRvUDox/Nz5/LB49b
 laVoCWdHBeYsXTSDlFFd6pC1l2AEFXzUmFQMKUQcOtjhpYtS9BbQLXF8qbgt9CG6gKEYjNhZZT/
 7
X-Google-Smtp-Source: AGHT+IECsFtB+N+jqMU1g/THG5NcNWkWpYs1ZikTHMVxfD9Jpit6UqTKaKaRMDwwebgxM6ymSwRFeQ==
X-Received: by 2002:a17:902:efce:b0:1e0:983c:d686 with SMTP id
 ja14-20020a170902efce00b001e0983cd686mr4702554plb.20.1712442778661; 
 Sat, 06 Apr 2024 15:32:58 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 15:32:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: [PATCH 4/9] target/hppa: Use insn_start from DisasContextBase
Date: Sat,  6 Apr 2024 12:32:43 -1000
Message-Id: <20240406223248.502699-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406223248.502699-1-richard.henderson@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
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

To keep the multiple update check, replace insn_start
with insn_start_updated.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8a1a8bc3aa..42fa480950 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -44,7 +44,6 @@ typedef struct DisasCond {
 typedef struct DisasContext {
     DisasContextBase base;
     CPUState *cs;
-    TCGOp *insn_start;
 
     uint64_t iaoq_f;
     uint64_t iaoq_b;
@@ -62,6 +61,7 @@ typedef struct DisasContext {
     int privilege;
     bool psw_n_nonzero;
     bool is_pa20;
+    bool insn_start_updated;
 
 #ifdef CONFIG_USER_ONLY
     MemOp unalign;
@@ -300,9 +300,9 @@ void hppa_translate_init(void)
 
 static void set_insn_breg(DisasContext *ctx, int breg)
 {
-    assert(ctx->insn_start != NULL);
-    tcg_set_insn_start_param(ctx->insn_start, 2, breg);
-    ctx->insn_start = NULL;
+    assert(!ctx->insn_start_updated);
+    ctx->insn_start_updated = true;
+    tcg_set_insn_start_param(ctx->base.insn_start, 2, breg);
 }
 
 static DisasCond cond_make_f(void)
@@ -4694,7 +4694,7 @@ static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     tcg_gen_insn_start(ctx->iaoq_f, ctx->iaoq_b, 0);
-    ctx->insn_start = tcg_last_op();
+    ctx->insn_start_updated = false;
 }
 
 static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
-- 
2.34.1


