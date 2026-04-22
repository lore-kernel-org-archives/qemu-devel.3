Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E81F9EDC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX4i-0005yI-0o; Wed, 22 Apr 2026 08:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4e-0005wn-7Y
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:00 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4c-0005Sk-Bn
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:52:59 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so45458065e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862377; x=1777467177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8D+Vwc6j20F82XkTXJvqmESw0OfURlyV19jvdfWNbI=;
 b=uJdikQrq207nQD0n5viMs/2f2NxZv7M0nP+MxnweOV0v5reKqr80jipCLw7n8+Z0rf
 j2pM0HdlFKGna+bFR2oC5X67Dt5WE32aDDjA7Qqfdcg0ClP4T1MTQIsQx7UyK3A9TfUg
 vFBNHDghaKigZ0WUEQ8XpIUx5E8XCNv0kNoboyTTp41zBGj5dYz5usd0fV8hJUS4SAJS
 UcbUV1D0hSOCzGQN2NXLMFF0ApGm5zCc2dIKkciDrrMa/OK0vdE3gT+WQtFbQMIbF9v4
 m0YPdPSUevXMeSSajiMxvuYu4cQC9R4pYz4J8EHvcqakqRmBj4b+Js5ran4NmgvwJt6C
 yctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862377; x=1777467177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e8D+Vwc6j20F82XkTXJvqmESw0OfURlyV19jvdfWNbI=;
 b=fSHaiZ5A+Gu4+IGbuuq6JdDZMr2R73c0ng4Pz5SOOghxB0819BOB+H5CsTVxljtLjK
 cv3fF7QA/6s88rWxdBw2gJp9nTCmCEgeTGe5t8wim5l/yBezDw2LgmCVjmUQvd6mompX
 u/y4OUdOlguBotNoyuTRZVPJZj9mWdmhxN7vnrHKi8clta3aqibD+cjRaUWwICTvszfx
 Ajt3a3yJenlR0ILYfbS2R0xnjMX1IIihy5yrCUurzaM/2bUuRFEFGhOEycUlUog1vng1
 IsyYHn9WD0YANgH6+Lho5e892hHCgM1r4KFpKfjgy6/3svSjRAbUu98SflkdJVLkMp9s
 7M+Q==
X-Gm-Message-State: AOJu0Yy8njd/5GtYwdwTMhwlzCNve14XMWtJReuONikRg7MDxmQSgUZv
 eOSkmnYkD3yLu8EhX6uZJr9lnYhkzjVYvLLCfBh/PBXCt99FGgwdD5eJCYyv+sEDU7o=
X-Gm-Gg: AeBDieuIvsCsrg8Lexs4EpPTvusGXesZTZ1ewFizJEvMRvoEbfLA+vbK8GzC8bGILOe
 9QbpQ82PJ/eAat1/DKGe01lkogNpEFyJ/yX+oPLR4Eg3D9rCMx3bHYIGlhbHfXX0O3XHJhvyvrZ
 pCz/v4VQ1OgkuPdJb5DKPZzCD51sPkIKyxJpcpax2kiKMVq0dVRSPp+5CcLRbg4Vmkw5644vNl6
 382ZIbyhWOBSB1utDnn6nbNVgJLMvusqujoPJzdbJphHI59kflVjxLIRyuEH/Kqp57Yv/Oag4Xw
 fzldAByTg+NLCL3tYy7MnYPoyUMw1vZBVnx/ai8nL/nd7Hua471InyoZYfu3dySoMMNBKtUXISv
 esxt/XzbATXFsuAEGNF2CSkeh0N4adp5G5XFFhZ37vSQQVQ4Klw04KD8XYfm4LUW3KqmcWmW+z4
 uvGUZT5Z+3yprCe9H6m+ydQnZIhIKSIjCuWw==
X-Received: by 2002:a05:600c:899:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-4891a635125mr125689055e9.0.1776862376580; 
 Wed, 22 Apr 2026 05:52:56 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc17f642sm409465435e9.5.2026.04.22.05.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 91B0160E72;
 Wed, 22 Apr 2026 13:52:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 08/32] target/arm: migrate BXJ trap syndromes to
 registerfields
Date: Wed, 22 Apr 2026 13:52:25 +0100
Message-ID: <20260422125250.1303100-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an Armv7 specific syndrome for chips with Jazelle
functionality.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 52a6745cb23..6fcf0ac7572 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -440,10 +440,26 @@ static inline uint32_t syn_btitrap(int btype)
     return res;
 }
 
+/*
+ * ISS encoding for trapped BXJ execution
+ *
+ * This is an Armv7 encoding.
+ */
+FIELD(BXJ_ISS, RM, 0, 4)
+/* bits 4:19 are Reserved, UNK/SBZP */
+FIELD(BXJ_ISS, COND, 20, 4)
+FIELD(BXJ_ISS, CV, 24, 1)
+
 static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
 {
-    return (EC_BXJTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-        (cv << 24) | (cond << 20) | rm;
+    uint32_t res = syn_set_ec(0, EC_BXJTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, BXJ_ISS, CV, cv);
+    res = FIELD_DP32(res, BXJ_ISS, COND, cond);
+    res = FIELD_DP32(res, BXJ_ISS, RM, rm);
+
+    return res;
 }
 
 static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
-- 
2.47.3


