Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9197AFB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Ca-0007Gi-SS; Fri, 24 Apr 2026 00:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CB-0006yY-IW
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:21 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8C9-0002nZ-7h
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:14 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-415b23dd6e5so2761766fac.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005071; x=1777609871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kor/kiazYWS2SmrFhEuLicDn7WflikUuqZMwHNLbJMA=;
 b=DwJr6clay0WTmoKxJvtWscQAuRr1UTqufWkFZrNeHeVO1KhR/DwBI8iC7dBpCV5diP
 hKCnQxhXlC/aw+UDz12RY7hiwuPh4i6qmjnslMVXLzlwIsbftWN9aC45rjBn/VB/4ztP
 JwYRgKj3JbHNWJyAwNd73WbNobNxMPiZ0CZZvj80aRV3h2tSi6pl5HP53+Hp38aEdDy8
 Utm5PSB7ftLNQafDgagOolI0uXqwcZkpcSc1652lgYXNcoyhm+GgcFln8TuMbkORsK+3
 taDHrzcaYE5+WiLCEmaXLNKmRqur/drrLP4CkdrX8PeaXtVTklh/jt2K92vDC5Lnw/CM
 mMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005071; x=1777609871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kor/kiazYWS2SmrFhEuLicDn7WflikUuqZMwHNLbJMA=;
 b=jNnvaJ6cOooU8PWoty8R7foFNKn2E+FxD6st8M49rtb7Qgzu3GY7JpE8UEjmmUmcaP
 w1tDcTciAeOZDEPiLtVES7gVU3SFIvdGA3dM8z4FUfg1c3BDi5OCbo/ZUjgwBXpPqPiD
 Du7kVBi9jKhVfSxdIWO0GDUPd26P+RLKZ7j0sZ3HT9sfA/oUuZd5uiGuYU3KHrT9rabl
 N5MQtCPDAuSDvtOlKIeHbaioE4tHc7Jx0w8vK686J3sO8J8YowiohsX+/KCXfGPAQeuQ
 Ib5zuCrNRGsjBxDCDS6jLFJffVaPNOOdhYcMd75dlWn7MZ4pe44r0kkmMpsleUT+Jwe3
 Xf7Q==
X-Gm-Message-State: AOJu0YxZabZUDW5XvonFtjRiPj+lIbmOgNWDXZtfNmYT4RSmju+CPcya
 uuOdz+Cbwpc2uOcle7GAB0EelvxkTq08wuksAgccQ0Sy7yg+s1a0zhw09JKDhm+dNY4TN7apZyG
 WMlOlUY0=
X-Gm-Gg: AeBDieuMaksctTmVIfG8q6LqjZo4NAVpme5WTW2i4MEkduvPYKAwbZ0uNX95fmhkcX7
 sOQRtyT8d5OA3wngdxkjwpfnv2Cq/e0zK7Sa43Uii/6PUQzMmfYvVc6kW1VQ9paw9LJcWPKaBgo
 lo10QHobz1fbA/K8/9wgmPSsO5Cm0GImj4AffJQRwXjTHbCb83cx7fshpQdXyQguIhIukpjIh82
 J577jMTspv1VrR4iZf950tirN38l6BRiWV2Y2eXaSyM3vJ2XCRb8rw//NGDrpt2bHOddJ9TgvNm
 Xjc0JjRb6GCqLStUkggIPpvfrIisJvL0AbvPl+qSWDhnGdQWz3Ji6hGJcz7U0U8aCR4DrE4BncL
 iupWKRMt5oVzXik5iSuRpJwj+k6i4iINavBr4JHT5HQUIL+jxDN0kWP1nIOpFDwru8wHa5SUxFz
 dxvovqJvjEu4FXjmTe2GqrdWm+B4FOkkLy8ais8qtHwwlccJA9bMMcPW7/cQbngQ==
X-Received: by 2002:a05:6870:2010:b0:42c:1b45:e8ba with SMTP id
 586e51a60fabf-42c1b468af7mr10447591fac.33.1777005070878; 
 Thu, 23 Apr 2026 21:31:10 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 11/40] target/arm: Clear FPMR on ResetSVEState
Date: Fri, 24 Apr 2026 14:29:45 +1000
Message-ID: <20260424043014.46305-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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


