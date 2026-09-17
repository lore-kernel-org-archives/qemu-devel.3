Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0EDC982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73k0-0003BO-Ve; Thu, 17 Sep 2026 00:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jb-000398-1r
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:32 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jZ-0006lE-Fo
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:30 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cebad4adso268247a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619308; x=1790224108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K0rAvylJFCDebhzyBWGh1HPRhJRm/GjXARu1Rx20O7U=;
 b=rtJ6QsyFgrS1tUo+8sak0N7D3USn4xhDFVGtmm6jirebnbuay8ufl7EujueYH9HDtw
 7H+NNzQAMYVgNYUaqwiHBYHyTcisxlGedxycLpd4X/K3/HJWw4anGu06FGlhLK5w0k7X
 w+7pXlDjKLaxHm4DI0Qch9eOduP3dnW0o/9fzAhigT6jo2SjXYC7hFY5NIYGbxEhVbm3
 464KmrLeHm+1nChirIkbp1xNZX4vL7IzlNjYNjb1yx0ZmVpbrEyv4qWDkeMQD2Sfiw8Z
 Qj6kr/jrpUrvcLkw/xa34D3PXxkAVIckZuAdFXyWkbEOvjulA2QPOdQ5x6y3SusZ41Pg
 /jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619308; x=1790224108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K0rAvylJFCDebhzyBWGh1HPRhJRm/GjXARu1Rx20O7U=;
 b=DmLOwXBe+bpAKXStZU+R4j37V9ZjidbU3HfCQLUl6QoULKdcypLSCWTLSTdmAb0tGm
 rBfFnFAVleXIlxmsxrm/YTfLWhC+jyFvrGrsPYKeidusfaEZ4mSjzYqyvEaAkqs6Qhcz
 xQAFByZhbM2x6Mf0ufO8D8MmpzACjmT3R0GlcpzDxQaUMkYa1y4ly52VQ0bakAEfhDMv
 4ULw6/h9QxPANf5J7v6LmQogEFNkFKWsgOEPqLhhw/NpcqUNkdB9pdnp1hYmVjgt+vyq
 veFzyGfHOd9HHghDHIkANEwyjq8/vFd9lHK2hjAMWoeLc9rReR2ohZW3gJAdeoQT/BSz
 HPJg==
X-Gm-Message-State: AFuF++mmiOdgTwZSghqQmOOONwKQFR7lm/Ku+pt+8jChRd5L1ZMblaG7
 cTpbjrIgwSTFhPNA78YtSB5Z9TSXyR67AL/Hg1WNBzFtP5RQlFSpqFlfL/6EJkelpq4BZYlB/C0
 pyERdunU=
X-Gm-Gg: AYBFou0I1k/2pC7IQ+4S74jtU/iSNJZlcF/uyCEhBwywiQkp3GOCBQHcrht/78jOx6B
 S7PEaV8aG5rtyZoa+yzAaYK7lQ8el78oJ2z6UN3IrBkR3EMPUjfPlXWDuIyokiTwu2KKTSJVoZk
 l06T+5Qx/ngDwZ5ZeJ+yCicvdvKS8N8fmr71H96hjytADSK+lhNEgnB39gmVqHwzNsXcKaibjqY
 DoL2IBFQ4Ho6HtcXVfc5Dt4IcIJguxLOMU041Oq//OmMLargYR4fhkNP4lqGCh2YWfFJSz+uXPy
 CIFwq8Ruu2QJR5ICey0Yq0HwQiJrZIuFNBCPlv3NMk9BYMwaNRfOxBZ9ODAL8SgnsKtR1ZbWaya
 2QKH3wObmdLL/5MwjSkc3ZVZoJKS1yYyN90BVaKt9pr7BxY81Bb9k3KknhERLhv6y9b8I12jlR3
 ei0FjmQdikSZO6gcjmWpTm21IS7VTycougvYA8K0Ko8ifqqoLr+LVAPzl+3bYfeBSPnlQUD60iQ
 f1WtFE=
X-Received: by 2002:a17:90b:4c09:b0:39d:ec44:28b8 with SMTP id
 98e67ed59e1d1-39e1e4674d9mr14479094a91.13.1789619307732; 
 Wed, 16 Sep 2026 21:28:27 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 001/101] include/qemu/compiler: Add QEMU_*_NONNULL
 attributes
Date: Wed, 16 Sep 2026 18:26:43 -1000
Message-ID: <20260917042823.542588-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 4c49f52eb07..3661dc5fbaa 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -25,6 +25,14 @@
 #define QEMU_PACKED __attribute__((packed))
 #define QEMU_ALIGNED(X) __attribute__((aligned(X)))
 
+#define QEMU_ARG_NONNULL                __attribute__((nonnull))
+#define QEMU_ARG_LIST_NONNULL(...)      __attribute__((nonnull(__VA_LIST__)))
+#define QEMU_RET_NONNULL                __attribute__((returns_nonnull))
+#define QEMU_RET_ARG_NONNULL \
+    __attribute__((returns_nonnull, nonnull))
+#define QEMU_RET_ARG_LIST_NONNULL(...) \
+    __attribute__((returns_nonnull, nonnull(__VA_ARGS__)))
+
 #ifndef glue
 #define xglue(x, y) x ## y
 #define glue(x, y) xglue(x, y)
-- 
2.53.0


