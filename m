Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78DFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcOg-0008J4-Ef; Mon, 29 Jul 2024 22:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcOf-0008E1-4C
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:15:29 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcOd-0005Op-DY
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:15:28 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7a103ac7be3so2266765a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722305726; x=1722910526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pH+41rL90lFjbVWqrfAC1Tzfsae8MNVaqTWvWuyk3aM=;
 b=WoSRAcf9cnJN3yCilx5XNjA4wos0JTF8TrlhYe3RCMjB166Enspeiy4BL6XtzN+Ck/
 owaUNjIDiboxYuezc/41syLkHwvA2qG8lNP7oOooY52+szhI/zzK2KsPgtV4V9OiNQPg
 WIIK3ms75MLKrZ95VNBcYsZlbDI4/fjaOcZwwJETsjVt4gnNkZVCR63mx6BRfwRwiSIR
 kgVcrMrX2JPnIS/j6bZkKsvVD5yD2vZNN1TvQKcGoVheaHKqXleU+Gyb7E+06/mndYHW
 49TdQgeWFYTEgk3LAoDqTqWxHSS4I0bzvxqA3rvHnEDwzqd9a73QOtEnNf3AQEAnXY1W
 8Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722305726; x=1722910526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pH+41rL90lFjbVWqrfAC1Tzfsae8MNVaqTWvWuyk3aM=;
 b=ogFpPs1xcWoackUuzb4nXVVVnDNKF3x1QKQP7qGEphdqWd54mqr/nNkjXJyliMR0aJ
 HjXS4A64voa0gQrp46ZuqwH6Xr+iyrPbrS5YqOfx6smTTJg4Gs0zz54ReONbxoJLI1JS
 J7sPE15MgcfZUF261s6+SYYQooLFJb5zjS+2hZfZc1hXG0sWVF64pjdOo8zDPFZBkDTQ
 xwYakm/TFwh4tsar/6MA1uA4IllX75aLAyu4+aC5GHW/FRu43CITox9/vC7Mzv9sU9m+
 wL2H26jQe4ik7OjtQ/Yx/Thj4ws9NVleC/8bmha5CBRIeWtnoH1/OBLNKbjeG1PMnWBg
 QMLg==
X-Gm-Message-State: AOJu0YxjAWZQBBTjhsivyj4lc7WtsLXyWXGdKRAtHsdPZ/GDA5eVa6zc
 zKdtqYWQO3xqISfDFd92NSZdO3SF86+6hW7/jwWW0flZORXuO8hj+dIzYmjbZDmHZ4tTnTsLNjh
 D+JE=
X-Google-Smtp-Source: AGHT+IEriPcKSuasBU2TvkAdes5dggN2edS16cT0kZQzwQVIjC2YzfjHLjc3UXZmfpY5Kxx8xdT65Q==
X-Received: by 2002:a05:6e02:20e1:b0:39a:ea89:22ec with SMTP id
 e9e14a558f8ab-39aec2d76a3mr110796085ab.9.1722301930485; 
 Mon, 29 Jul 2024 18:12:10 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c6ff4bsm6750206a12.4.2024.07.29.18.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 18:12:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 1/5] target/rx: Use target_ulong for address in LI
Date: Tue, 30 Jul 2024 11:11:57 +1000
Message-ID: <20240730011202.480829-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730011202.480829-1-richard.henderson@linaro.org>
References: <20240730011202.480829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Using int32_t meant that the address was sign-extended to uint64_t
when passing to translator_ld*, triggering an assert.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2453
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 target/rx/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 9b81cf20b3..9aade2b6e5 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -85,7 +85,8 @@ static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
 
 static uint32_t li(DisasContext *ctx, int sz)
 {
-    int32_t tmp, addr;
+    target_ulong addr;
+    uint32_t tmp;
     CPURXState *env = ctx->env;
     addr = ctx->base.pc_next;
 
-- 
2.43.0


