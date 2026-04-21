Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546A4F55805
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Rz-0008J8-9D; Tue, 21 Apr 2026 01:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RF-0007y6-QH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RE-0006Nq-B8
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b24fede2acso23730855ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748458; x=1777353258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kor/kiazYWS2SmrFhEuLicDn7WflikUuqZMwHNLbJMA=;
 b=hIBQR1dandDPBrTshfi248tuvCd+9wFnLnSShrDgZ1m7HLuVFMljcKiTW3ApDemx50
 v5BfazWuz8E2ZhQOO9e2DWxANasf1lLECZpN7zKc70x5jVJR/FPevAOLC9souQor3K+C
 u0H1fCCgo2ZcY0mEZQt0gJnPG0b10zdDh7RCLqpqMbMJq0hByNI+jhOMKvDkVXhpWw6R
 uMNtF4vPHZWKz2buz/0oYDBbFafDf3AURjXLa1NIXDlG7vd6VIPBdjs3x4q8Swy9A7e9
 NkOpqBS2aP70G/6xY2xTPTR+6niYiSgCY2emckhWBnBUi3t8JoBlQgL1fWtnf+Um3Bxm
 umng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748458; x=1777353258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kor/kiazYWS2SmrFhEuLicDn7WflikUuqZMwHNLbJMA=;
 b=S3I1Pl8gH6qNfUwNfj4/dfjWvk7l1op+NV+Bdkkh0z2hfooSFaUZWRt1S21eatVaej
 Y8Y9WvtKqKosxVEA5ECR/Hq5SVpAlDSfbFGBxkp+yqs3D6RG6v5PHUMpYTLxboZnuI8o
 Nb3xbDxiy/0I0xomd1YGFcyg38V7iv9i7CiGegbkioyRpoH4IUF24d//7cJSsLsMsSKZ
 rw0E2YmGRQufqlHDLiD8ANpV4Is8pBu4chufgRjkXrLmq2roPfDHLMAvfOYhX2g2jhto
 Mb5xxVQTNvfYT8VTWrUE8YEhm6yu5NjarPtjMJRRRFAuuWKWjqLcKahkkCqIabyuMRzu
 t6Bg==
X-Gm-Message-State: AOJu0YxRRDSV5bq8qb8tJmF4AQK5VJyWr/LoRY54e474xkIkf/USqMAr
 9KT4MX+N1g705GEZyEQqd1Hs1W/XU+RZ3Stv2UekE+VWx/QC5lYz+A6O42uiyOi5qFk6EJcaChZ
 Fm7wmdbY=
X-Gm-Gg: AeBDiesUfgf9Jq65sNcxpW7Pzz3CfYuFWWC8xedRVrrUvnfi4Z+d9lznqGiVhrMzFdi
 QdlaLYOZu1JiEWL4V5Z6spW4DAZcsuUGLwWkAmE7hoLlH3DZXv69jJ0rYhjempjEuVP90YugMz1
 56TFDtxcd2zQdepz7HKwXiDUslcLONzyzv7tcwBF8t8Q/cCjZgfCHdE9BVkOS+QjSGkhverNDL1
 OeVhCO+Olf+UJWpfM3aRPdbJToUtAOzAb/+n9k5H57ewAlrPkH9fcghgLqIfHkGEMhLl/92pJoX
 JAGd9BoOK5VcNQ4JsL4Ae6f4RRTUQ2wbXBe5pJWe7sy4k4qVKmzl7RvEqeQdAgn/TRypDhd/3yt
 QvEbRocAcBGEbUdO4z7K/RHelMvNhxpBfuzHuIaAqvrY1vmdIdu/z9eBS2AEEleMm/TC49AROZ5
 FveNK80ZKwU/Yu8GMNBnKUdSu+1St4s9Fe0A0sh9u0
X-Received: by 2002:a17:902:d590:b0:2b0:608d:d8a8 with SMTP id
 d9443c01a7336-2b5f9e8e4a9mr163007925ad.1.1776748458079; 
 Mon, 20 Apr 2026 22:14:18 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/37] target/arm: Clear FPMR on ResetSVEState
Date: Tue, 21 Apr 2026 15:13:20 +1000
Message-ID: <20260421051346.41106-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
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

FPMR is cleared when entering or exiting Streaming Mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 06b5fbbe55..6ebd121050 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4913,6 +4913,7 @@ static void arm_reset_sve_state(CPUARMState *env)
     /* Recall that FFR is stored as pregs[16]. */
     memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
     vfp_set_fpsr(env, 0x0800009f);
+    env->vfp.fpmr = 0;
 }
 
 void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
-- 
2.43.0


