Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10055C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJH-0000yb-8m; Wed, 16 Sep 2026 09:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJE-0000xg-0E
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJC-0000GJ-IN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:19 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2dd68a16955so22289855ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563857; x=1790168657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K0rAvylJFCDebhzyBWGh1HPRhJRm/GjXARu1Rx20O7U=;
 b=vzBJVPg6ZK7rMZGB7sKLAozdrmcFhmSUZz3jFM/oYyR868WFdt7Dyj2YfBcdwAbbvq
 6MJymQeiIgYDss7BOiaIXD2e3dVZhdX9OFAAZaNw0BYRL8aw2RhuxvmGdHvMqbnIWvRk
 Rajwak0ycdsx51oTBPt0XUS2qMzgiz3Ea9ndBEH5gpdBpJZP9KfaiDG4g1JsZ0DzynWQ
 FeMlk+w2u267xPD2EL8ji0KMDIi9f9ro5VvqcsMFiNtE19n0CLDRZibIfWhTKowyIvbz
 e1R2lhDU24u82zyHdKNTvh27Ss4d/h6Zp7bh94yZepeD0lC3G9s9E5ptj2BoGpaSkF+x
 ciXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563857; x=1790168657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K0rAvylJFCDebhzyBWGh1HPRhJRm/GjXARu1Rx20O7U=;
 b=dJvaoZqT141qelViOBp0GVrN8YKpBjyV9ov/lcHHavmClUtRAElsOBqvKTvOnVg86L
 dqqwBd1VSklwiIqeYWYfcY8ftMjfrdk//ItGCmxaNr47nLRf6ao5GyskmCxZPN2U0S1X
 aZEsRdYJeYb8imUFl/R6Smef5ExxcelzqJJtKbkutQGHwRPsaBXDrhAZ17X07jfiPz2O
 aASzTK/yyphbpGFXxnZXEKJj05V5Ka5SqktHxX48vPgTLkhAQvBNtxJSld1TRuUP1c2w
 KOmW49J1HxbuPK8Jr/MWMVUxENBesugWzuak/2dudH2TTgv/+U+B9Y8vMb1LAHKK/CsP
 HcTw==
X-Gm-Message-State: AFuF++m+OFQgkxrELd1+fS2WMGvfPWyJS+iYK0svW7dlye/ikk6JdESF
 1/5G509nQPODFcsJctQxfAGmi1ZL6OE+CY7tpieTpSftPzOw/H+xaotBLYFxNU5VjGgHsqaow8q
 /7j/B
X-Gm-Gg: AYBFou127KWmcRvt/D1VwnbJH0zosbc23KS0gxJpktQ3scpTblQqTRBt1EFS2LuP5CL
 ThJ7TZVLeiMYXHHenAZCZIBc7woqB6lCdf96yc9LkKeBrbFe0McLgh6u2il76OzT+uBpBGUEKGP
 v9b2l7czRshMb8vcrliw/xQzITgRMkBqgqLsdTcIm4fMTGCRe6IgPppEPFXzb9DzGMZuXNZhOra
 QKVBHrb36lvGwLEexIzouvxZdiGCDOubQtVlE5f6PAUq1ia4Y+GxPgs5RcMTe7r0jMfKRztcnbp
 90lneME+2U60Ndvf97TV7pyaX3yVrZnPsU5GU7kFQdbKnM+9Mf6uUJ2b+eKyLZwwWDZFrHxfW5E
 XD0BTI9faMPAh1mgMdtxPOwtIVyD+twt1Zyc6MHDWy9HTz0sdoEY7mhHpLbKbv2n07ion3vejKW
 3TBk2Mj7rpAyJfOLDwG3tfK0YrYH1+g1vwo5srVcQGyI2vDLP7iREMufGb2Juso72Kivb0uUtm+
 97UNgY=
X-Received: by 2002:a17:90b:4a11:b0:38f:a81:15b1 with SMTP id
 98e67ed59e1d1-39dfe188cd9mr11810840a91.19.1789563856589; 
 Wed, 16 Sep 2026 06:04:16 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/92] include/qemu/compiler: Add QEMU_*_NONNULL attributes
Date: Wed, 16 Sep 2026 03:02:36 -1000
Message-ID: <20260916130409.3382710-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


