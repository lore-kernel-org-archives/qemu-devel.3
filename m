Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FC8F9B608
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUXp-0006sH-V0; Wed, 22 Apr 2026 06:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXm-0006pW-CG
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:10:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXj-0000jJ-IY
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:10:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-483487335c2so52303875e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776852650; x=1777457450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUXCf79/aCPWP+oojaJHciitYmV1hJJUoyGLuPcbhOc=;
 b=b9JVmR8AMwavo9+B1hw0BF6tqDsQJ0x/F4/7DX1xnF/oRKKdxz2Q3Ks/FdJJ6g2eaa
 iZmGFNkgUDYahZZ7PEQb77k39pcdFcvLgINQL8Ub+dNDYIy0PlsoGyqO+t4dfC1Mzduh
 T6Koio8Uzo5lccgB6giIfD87IEhdQA0qKkhAgAB1aU7rXXQsmnRC9KuANRL5L1lUdQzf
 feHlj7H2t4tgbmRXOxsC4Z0UzGvMMhXMrL0Cq/XpmAryVayxXRMNFQCPMOjh0dF+rzHc
 udt6rqUrTcDf9/VBula+DqqcYgKRXzIqCOAqKAbT7Fm31YYTh8PhUiA3al2A3zSyTw1q
 7thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776852650; x=1777457450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rUXCf79/aCPWP+oojaJHciitYmV1hJJUoyGLuPcbhOc=;
 b=X2icI6cU6SCFipOvoc1t3yavoU9oj3O16dnxVrkgRec2U5jJgyjRu0xf41OQFTdxL7
 KlhxAeGoAIN5V9snfNo1y/rHPS+zdhixMG8PmWQQSMaS04kWFRCuPlT+0dL2fC3btQ0R
 RwKE6J0LJsdVUUe0J+7UXeJZplfDpxJx3Pdvb4wI3FEVjca94RW8XlEI7S8zxBbPTDge
 nhw7TZEJCeEp+UMS9TpU7DaZNx6GVFc3gKeO13J7y+D41Aq8GyYrf7Dw2RcsfkOhfBCL
 YNQ6VHyLkDJBLA/tVcFMNGVdd+w3KZtxX3U2xcoAXzdM5OJJ8p1a5xPfdkqZZg/B8g1l
 lkQg==
X-Gm-Message-State: AOJu0Yx/E+sxhhkGa6P/+2vMOURYSKdHGY4DELNpVZ72hOYod5FxhIVr
 UKAlhcgRUTNy/D5vddG73otxmFxuTRvzeYyDqmfY92u6JVyy+wL4e+aXMoFpq2sYnBw=
X-Gm-Gg: AeBDieuVeoN2Houpsp6qfhDcnhzhJ/sYTkS/c7pJeFBMpxMTX4vOPnkJ9otX4Wf+umk
 U3q1NYHagkUe/zZQEpRAibUtbfTALsE1+cWifK/t+VlfgLg6eGbmnnCNJV/YUPWu3GD+2jCbypB
 hCBdh2zuRnkhJFXiO0FkB1L2P3iPfPxEyHLETYzImxlHTd3Lfys6Un1Bf8JaBnykSa2R+c6he0Q
 W9mZb81YB2+OA9Rz0aLMoZfY3Y1e07Hza84JcLKRhNNAfMhEWy0e/8AUPKaxJDiJv533DOGAlMu
 PsLgxN1+UORrwpF0UNKIcfw1VuoJKThgRjWVDjM+L94iHAtZ72zGqZQp1PN9zDVkelfm9MY/Dnd
 zf7dr+N/AKO7WHn0cfOV2MVtrXCeFRMPHO8D6h6eFVfCt3eqfRwPGh/A+jWdsJ3SU/rv5C6rF39
 X5FX0A7VE6MgVri3HAFkwJFfhfWzG3dewYJQ==
X-Received: by 2002:a05:600c:a303:b0:48a:5576:a28a with SMTP id
 5b1f17b1804b1-48a5576a618mr79079685e9.0.1776852649757; 
 Wed, 22 Apr 2026 03:10:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc17f642sm399924805e9.5.2026.04.22.03.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:10:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF21960342;
 Wed, 22 Apr 2026 11:10:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 05/31] target/arm: migrate SME trap syndromes to
 registerfields
Date: Wed, 22 Apr 2026 11:10:16 +0100
Message-ID: <20260422101043.1234229-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is_16bit directly
---
 target/arm/syndrome.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 63c8e66ea91..61053475984 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -384,10 +384,18 @@ static inline uint32_t syn_erettrap(int eret_op)
     return res;
 }
 
+/*
+ * ISS encoding for an exception due to SME functionality
+ */
+FIELD(SME_ISS, SMTC, 0, 2)
+
 static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
 {
-    return (EC_SMETRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL) | etype;
+    uint32_t res = syn_set_ec(0, EC_SMETRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+    res = FIELD_DP32(res, SME_ISS, SMTC, etype);
+
+    return res;
 }
 
 static inline uint32_t syn_pacfail(bool data, int keynumber)
-- 
2.47.3


