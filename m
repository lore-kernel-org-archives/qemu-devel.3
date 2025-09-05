Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA2FCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 11:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuUz0-0001bS-2R; Fri, 05 Sep 2025 07:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUyw-0001Zm-Go
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUyh-0003YN-Sz
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b7722ea37so10957455e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757073091; x=1757677891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlzJQOFlorrMw5CndfvG4jengOA2DFNt3pdatOiYndA=;
 b=d0puMIR9dvQmvt4Y2caxHiScWvI6PQMnH44my797pWyr2CeWmVfU0saq/S8M4/07LC
 hM1QAVs7Z0KCcR+BJC7OyMvmVu5hVwp9FiA0c3GE/3Fei0yWEJVVeQZ5kDmBgf5D0P56
 AUjOIT+5v1x4+RxI86tTHY8ppPj1LNuw/uFjMiDjZV4QZcfAU3RfGjR1p9fNx/VRgmY3
 Ar9JtzNWCvJWxvEL0Tc2+Oycv35WxsmddvQF7rKLU1n/wXeewyxVK65hNf+O+DvlwxQt
 4OEYR0R4/r6+Z137vgTRgAhAPiC9C/EwBdoVAruSBm3eILowuX8bR+qCRq7lT7YGm/07
 mEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757073091; x=1757677891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlzJQOFlorrMw5CndfvG4jengOA2DFNt3pdatOiYndA=;
 b=aDslgtHOv2z6CnnluEToOAuXbyypHKY03JDEAq0ggbokQFegsnzDiDQF511V0jGBwg
 2BG5WE6wwaEQg8W788dF4ImCDr3BlCiSX5PjX4OQEJGXyx8lz/SzRaDMP1wq1mZekw3H
 PdeFfVBhnDPZsXFT/nEaDKXi4zc4FfJyA9BEzDL+yBTQ4KxFeyqj3g3UiSZiE7y2ZzxH
 kX8hrb6yLMXUDKQWA+oWipnHQ+/xD3zX8ZfZRXXzbsoyDxXOsSxVzFtHcEWQxOJ/ETm+
 N53zMUf9p/rjGIt9Ve4rv73GbV0+IqqT8DGgXwI+BA9cnLKtz1NkNmkXN3g8lQv7A/H8
 OhkA==
X-Gm-Message-State: AOJu0YySIz8aFz7W2wKS1ZyUg1W8oaN2pjqMcGMv5d7WFOjdSkeqsXBJ
 DIyirqe7ewWXeD7TKKNgjLpROHh2FqU61JDlHBlz107FTOHeXLNKfJxkr0uTarm0M0QYmHTsgP7
 wTDMmBN4=
X-Gm-Gg: ASbGncuJUtVYi79Tp0NC5MI60FqnFoMCjxzD12dIqX+HrUfCR9E3M6VL+uc6XeN95oE
 UtycBIVVWaFxMujJlUzWGeEdELxf6uNIC7ykaxbQU40+bnSbqebEjKagfX0ozrRoCLy+SdDBpel
 adZ7gqdJGT6wIsIMljDojLV3ccY8iAGp0iDJCzQAAIKvILNQrw40X5x4uiaQnvHYqYY/A2UPeaI
 4zj9tDNR0dn0kp4Bbg9tkwECmA9M/oKsw9XmnIl4vbEIGnjI96hy9KtDrqczPJoUoa+CcYEUDDS
 LbuGxmUMbA/1JjtkgHwFTNgXOVHKsbuSEWX0CimRwvSJJOyuekI+C3OH0HB714BAiQ3LXF+k177
 woAGdHsazyWp7nZN7MUK7tAQllD6Puvm3sdCzuwGoU9bBy2eGAdGxwjFS
X-Google-Smtp-Source: AGHT+IEBa4QclhZsjHuBj4L+oqb4qsbaioZfkhBNDnOIMF7Jxb64n3elhC/sm1WQWRI5aIcSakTX1g==
X-Received: by 2002:a05:600c:8706:b0:45c:b523:5a09 with SMTP id
 5b1f17b1804b1-45dd5b52cacmr29819905e9.16.1757073091228; 
 Fri, 05 Sep 2025 04:51:31 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm194285115e9.19.2025.09.05.04.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 04:51:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH v2 2/7] target/sparc: Loosen decode of STBAR for v8
Date: Fri,  5 Sep 2025 13:51:23 +0200
Message-ID: <20250905115128.376295-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905115128.376295-1-richard.henderson@linaro.org>
References: <20250905115128.376295-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Solaris 8 appears to have a bug whereby it executes v9 MEMBAR
instructions when booting a freshly installed image. According
to the SPARC v8 architecture manual, whilst bits 13 and bits 12-0
of the "Read State Register Instructions" are notionally zero,
they are marked as unused (i.e. ignored).

Fixes: af25071c1d ("target/sparc: Move RDASR, STBAR, MEMBAR to decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3097
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c  |  5 ++++-
 target/sparc/insns.decode | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 336583beab..ece393fffc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2823,12 +2823,15 @@ static bool trans_Tcc_i_v9(DisasContext *dc, arg_Tcc_i_v9 *a)
     return do_tcc(dc, a->cond, a->cc, a->rs1, true, a->i);
 }
 
-static bool trans_STBAR(DisasContext *dc, arg_STBAR *a)
+static bool do_stbar(DisasContext *dc)
 {
     tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
     return advance_pc(dc);
 }
 
+TRANS(STBAR_v8, 32, do_stbar)
+TRANS(STBAR_v9, 64, do_stbar)
+
 static bool trans_MEMBAR(DisasContext *dc, arg_MEMBAR *a)
 {
     if (avail_32(dc)) {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 9e39d23273..1b1b85e9c2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -88,7 +88,7 @@ CALL    01 i:s30
 
 {
   [
-    STBAR           10 00000 101000 01111 0 0000000000000
+    STBAR_v9        10 00000 101000 01111 0 0000000000000
     MEMBAR          10 00000 101000 01111 1 000000 cmask:3 mmask:4
 
     RDCCR           10 rd:5  101000 00010 0 0000000000000
@@ -107,6 +107,17 @@ CALL    01 i:s30
     RDSTICK_CMPR    10 rd:5  101000 11001 0 0000000000000
     RDSTRAND_STATUS 10 rd:5  101000 11010 0 0000000000000
   ]
+
+  # The v8 manual, section B.30 STBAR instruction, says
+  # bits [12:0] are ignored, but bit 13 must be 0.
+  # However, section B.28 Read State Register Instruction has a
+  # comment that RDASR with rs1 = 15, rd = 0 is STBAR.  Here,
+  # bit 13 is also ignored and rd != 0 is merely reserved.
+  #
+  # Solaris 8 executes v9 MEMBAR instruction 0x8143e008 during boot.
+  # This confirms that bit 13 is ignored, as 0x8143c000 is STBAR.
+  STBAR_v8          10 ----- 101000 01111 - -------------
+
   # Before v8, all rs1 accepted; otherwise rs1==0.
   RDY               10 rd:5  101000 rs1:5 0 0000000000000
 }
-- 
2.43.0


