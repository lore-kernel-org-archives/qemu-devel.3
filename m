Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9D7C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIt-0000KO-FD; Sat, 11 May 2024 07:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIr-0000JN-Ms
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:13 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIp-0006yS-Ql
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3504f34a086so1337674f8f.1
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428450; x=1716033250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMtGB7SdOO69qhWqUoEC0VG8+kqB1EisNhBCOHuP3kg=;
 b=mUPRLVI6FX5E0XkZkpwku1p+C8OVUBr6373mCqg8W6Txv/t8rTjU1jlWk0xZLeEGAo
 YU9m97BAEKKdNYHN0JJ8hxY6ksi1r+77vDqSX0Zj/BXqGznNSiA+m78KKnH0/vPYnbC9
 s4iptqU44iYejg+EMyhIgTJWtoOUsGOrmSbahogtdqk9V6gEtfAKHD0p0njpOJr9Slqk
 PW51YwI9qaP6RIaDnOVIX73/0UJS1G0S9jL4BPqVCJ2jjI5kuPJmKeXFzhLp6/ydLyOX
 XeM+GezaYvyEnovEaH2GEGJw8tOD6jtw2aT7aamkR1s43/pK+Uvdq9QRvTqz3QzjbdZT
 FZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428450; x=1716033250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMtGB7SdOO69qhWqUoEC0VG8+kqB1EisNhBCOHuP3kg=;
 b=SYS8MQ+psxHkCoVjpiLQWH0EvHsR98RQklGaOtuLQp86ZTsy7xKPw9uksm6Mbur94n
 Ti08YUxQQCUkTMDpoc9J2hBGFX8UwOGAnu/xN9MOdwFS3HbeOJi0fyj/E+WO+dDey3DX
 qMC8L/gDvAUL2NF/12fLV2cXVdwcCgaMrAP0VCn2pOO5VthKl8yogW5EWIn3VASZEDOi
 UE9NlQ5DN8H/XmSRZdYpLCI4sYiCQtqP+a8mkBn5JzpwK9lnNmI9K7lCWfm6KzCgcpqy
 qX+zgDugx/fS6HfxyyuZ3pploeC+Efee+zZVa1hfiHO3bBk0Xu3X/465YGvo94AZvkdg
 a0pA==
X-Gm-Message-State: AOJu0YxJ8KAdd+l5zaKH40trxrmfutmVBsxkEeyxWVvIBvK4DJsuBiWk
 y9aDDbwVNH37/TKuq5ODvAuJGXTKFs/ZCVliXNzgnT/kDQ5Kn13uQZ+7yvzO92pQ6+strXeVKQI
 Xznw=
X-Google-Smtp-Source: AGHT+IFYdfEMVbDqUwGL9dZZEosJ0J9+/IiaKIhl6shyMkoeI3hlio74PUAs5QhGAbZ/7LiQXAK2gA==
X-Received: by 2002:adf:f8c4:0:b0:34c:6677:b7de with SMTP id
 ffacd0b85a97d-3504a632e11mr3986688f8f.2.1715428450334; 
 Sat, 11 May 2024 04:54:10 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 08/17] ppc64: Simplify reginfo_is_eq
Date: Sat, 11 May 2024 13:53:51 +0200
Message-Id: <20240511115400.7587-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

Since we now only copy into reginfo exactly what we want to compare,
and since we zero all unused padding and reserved space, we need not
enumerate each field for comparison, but defer to memcmp.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_ppc64.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index 109b87b..e0c650b 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -67,36 +67,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
 int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 {
-    int i;
-    for (i = 0; i < 32; i++) {
-        if (m->gregs[i] != a->gregs[i]) {
-            return 0;
-        }
-    }
-
-    if (m->gregs[XER] != a->gregs[XER]) {
-        return 0;
-    }
-
-    if (m->gregs[CCR] != a->gregs[CCR]) {
-        return 0;
-    }
-
-    for (i = 0; i < 32; i++) {
-        if (m->fpregs[i] != a->fpregs[i]) {
-            return 0;
-        }
-    }
-
-    for (i = 0; i < 32; i++) {
-        if (m->vrregs.vrregs[i][0] != a->vrregs.vrregs[i][0] ||
-            m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
-            m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
-            m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
-            return 0;
-        }
-    }
-    return 1;
+    return memcmp(m, a, sizeof(*m)) == 0;
 }
 
 /* reginfo_dump: print state to a stream */
-- 
2.34.1


