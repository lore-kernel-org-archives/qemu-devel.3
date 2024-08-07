Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663CAC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 16:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbj7i-0005n6-OK; Wed, 07 Aug 2024 12:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbj7f-0005fh-PC
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:02:47 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbj7c-0000om-V9
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:02:46 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52f04150796so2989289e87.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723046562; x=1723651362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=29HveLnaeU2oOZ9np2drPOdcZohlm2mSI+oDIf9MMDo=;
 b=mqPyoaz7PgO2sim6gPuN8Um+91oRtAYYKJHb861v8tSHwc4doa7OfkujydWZ5tWRj5
 KpJm9Pdkodf8EqvZmB+lKfXsRfxuPGHzyMJm1p5RlA5dTSCyPGmWiw7UxGwXs9YHdb48
 pvJxBV+Q2l9hGuASxhqX2JXncMlcFggD5La/z3dJsr45xSPaX2Z5bPBUia6yn5qgzLW3
 KVuROu4p2MvZPT/JV9IPl1om11JoXMycfBm2Yp4jQmYfJ1fZG7q/bheMtFKA70Yp/tBD
 kTD3sQW2CWzsiHNXJYGPPTsgVfpkzyRU9bTXTJWULXPvquBo5W9k6ODtQjTYg1H6SOYu
 MetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723046562; x=1723651362;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=29HveLnaeU2oOZ9np2drPOdcZohlm2mSI+oDIf9MMDo=;
 b=T7aTBvf59b5Ex2lJ5E7BGVFeSq64o9sIDISkPClB9AEegIh3p0eCn+VeemEYFu7r85
 3Fm8yFdvOU8UtLg/dLn7511w0iWIC0X8sKpfQanbPeUAIHy2NXDKrc164Z1s/YkZpGkm
 Ps1XFjmfruruG8RonV4kiAHV1uprRbJdDClkcnJSFr38B2vN54o13Xt4galUivFHu9t6
 M74MwDV/ac8jCSr/AZbJAa34Jd4JRoRAYNPhyuc/FJBLw0PttYzNt7WG4ORc/A7WxJpb
 cEFR0z2q1kpJpSFfRf91WCnhZ6jT5hMzJkiohiqop2kQ94evW9AeLB2rprFpQHcqhZla
 YCKA==
X-Gm-Message-State: AOJu0YwgkvrzKw4oCOqtM5S3/y0dxDejwFkrvgg++vTP0ATho7W7cXG+
 FZoLGXG3MoTIK/LfzN5Y1ZzYOlOQCA2piBhTGLLzzDGbmgQFjwiT4qwqZb7K7bvZlZTE8Dm84bg
 A
X-Google-Smtp-Source: AGHT+IGRoccyRk9WD/VamJ2PG57Ob3BilRZoqe3qe7zd+29uyF24/Q2Y7Ap/qwML+3gnhCgz17acXg==
X-Received: by 2002:a05:6512:ba7:b0:52b:c0b1:ab9e with SMTP id
 2adb3069b0e04-530bb367101mr12760532e87.5.1723046561341; 
 Wed, 07 Aug 2024 09:02:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d8a483sm648838966b.157.2024.08.07.09.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 09:02:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5777D5F713;
 Wed,  7 Aug 2024 17:02:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [RFC PATCH] target/i386: allow access_ptr to force slow path on
 failed probe
Date: Wed,  7 Aug 2024 17:02:36 +0100
Message-Id: <20240807160236.2478459-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12a.google.com
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

When we are using TCG plugin memory callbacks probe_access_internal
will return TLB_MMIO to force the slow path for memory access. This
results in probe_access returning NULL but the x86 access_ptr function
happily accepts an empty haddr resulting in segfault hilarity.

Check for an empty haddr to prevent the segfault and enable plugins to
track all the memory operations for the x86 save/restore helpers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2489
Fixes: 6d03226b42 (plugins: force slow path when plugins instrument memory ops)
---
 target/i386/tcg/access.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
index 56a1181ea5..8ea5c453a0 100644
--- a/target/i386/tcg/access.c
+++ b/target/i386/tcg/access.c
@@ -58,6 +58,10 @@ static void *access_ptr(X86Access *ac, vaddr addr, unsigned len)
 
     assert(addr >= ac->vaddr);
 
+    if (!ac->haddr1) {
+        return NULL;
+    }
+
 #ifdef CONFIG_USER_ONLY
     assert(offset <= ac->size1 - len);
     return ac->haddr1 + offset;
-- 
2.39.2


