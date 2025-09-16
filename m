Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B4CCAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWcp-00005y-HG; Tue, 16 Sep 2025 10:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWan-0006BP-Ae
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaU-0008OC-QL
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-24458272c00so58878695ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032585; x=1758637385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJhr2YI6iB2xGTJI/fnQ7ZhqiroWE31mRa2JZAO6wpc=;
 b=DkyZ0KEbOHhbNvS6YiF6I1l9K306+pmiUnMIAbP1o5P1f02/j34jkVEjZY+YzsCQhW
 oa0vCXBlhkblrXBhWUeZY/+w1Fo6kRLhO0gTLChII8KFqSszeU3NFj4JkbUxQINGMB/L
 hA4x44Tf8bj/Y/uUiPYj4OMpLUZeXoT22xXFrX7pYiiDsde/7YDoiG096sMussNwoPSD
 RWaFAPvUJyZfPeX7yfiuQrMLajcO9w9rPvr3lUTKfQlqFxGfiV6IHUlk314qY/O4TOGT
 4RvDGYWryHCjBmk+5MtQ0p32dvjfaGFMPMI+tCRAXGYJWi8ldyYeu31R6aLSKK/p+viv
 7jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032585; x=1758637385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJhr2YI6iB2xGTJI/fnQ7ZhqiroWE31mRa2JZAO6wpc=;
 b=aQcgJs2Df/dPaoeJvU2WA3ejP/eEwGP1M6jzoFZSxEy0ZCDetYCuSRbVW9ZX485drz
 UFbjXFzaZsvKEvi37q4Sz7kAy5zOtzb70/8Zj9ztGJxNyk/M4fsTIQn5jRe5KwW7r+In
 eXqZOHWTh1ks6H0xM81mi6ma+AoP7sFs3PXLosO7gKm1IK6oNHjhK/tCGCCtZrn20Li6
 R8j4oTiObn51JOR1E8Y75HQdq4NoINTCA2tg00PxafDVDREFYdFj2U1reG1Ssvlk75WR
 Bl1XXPHErAxdBLZFVIpm49n4btn5PFcgb6Ts/6gpAekv6lf2eMSFX9qt6OeG4aEQtfJ7
 Ursg==
X-Gm-Message-State: AOJu0Yx9uvAsvgj8qaP88eY2TqYA91bvS8RGrIT8xyHHEvpp+hwLpM8h
 BTtWbx357AH0PRCCEoZVt8koXieoj5AHrSvh4DGJWJYuKpfH8QtAiI3Yn5HSI2pSTVHrqM8WhJA
 Ht2ai
X-Gm-Gg: ASbGnct+8ALKU6+PFNT81TJhK0XqHJgnRxbSyTmQ/2YzYIGLcCue+MJ0SciVIbgsswU
 +bLxLOx+ZAs9fPOKSvNfeeRnlOMbzRlPBUK/xA1H2zdWMupbJkcDjQr9jVv9G/56Gglc1wdevEE
 ZlviAyGcQy1nHTk6jXg+Wg7/9MZTrKSP45K5HoxDvGHW9qOj6TsIHKrbXIB8KQW9A2AUkMFqnMY
 7dWO8/JFla4A0TEe5pqvgbz61DdCSJzK+FdxUymTxT3lp0kfvYnbG5VUetSUYqITUZvfjwjYlZ8
 60Nkwhw588pQay5nU+oGYk66zH41fdIyMeDlifcuk/iDQs+04vZ/7FZCoDCGfqIOIJ52eP0N7rJ
 0I9txrE8bRqsTx9Vu7lUMufH8Xo4H
X-Google-Smtp-Source: AGHT+IGhEzeXjMpW0/gcNvT1rjfrJiTwVqmyvMwcbWvYdRG0lXVuWQb/QzeAQf6aqtXPmeqO0mBp9Q==
X-Received: by 2002:a17:902:ce8b:b0:24e:e5c9:ecfd with SMTP id
 d9443c01a7336-25d26a589bemr229082835ad.42.1758032585462; 
 Tue, 16 Sep 2025 07:23:05 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:23:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 32/36] target/arm: Split out redirect_cpreg
Date: Tue, 16 Sep 2025 07:22:33 -0700
Message-ID: <20250916142238.664316-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 599e7a36ee..c0fa2137b6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2455,6 +2455,19 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
     gen_exception_insn(s, 0, EXCP_UDEF, syndrome);
 }
 
+/*
+ * Look up @key, returning the cpreg, which must exist.
+ * Additionally, the new cpreg must also be accessible.
+ */
+static const ARMCPRegInfo *
+redirect_cpreg(DisasContext *s, uint32_t key, bool isread)
+{
+    const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
+    assert(ri);
+    assert(cp_access_ok(s->current_el, ri, isread));
+    return ri;
+}
+
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2603,9 +2616,7 @@ static void handle_sys(DisasContext *s, bool isread,
          * fine-grained-traps on EL1 also do not apply here.
          */
         key = ENCODE_AA64_CP_REG(op0, 0, crn, crm, op2);
-        ri = get_arm_cp_reginfo(s->cp_regs, key);
-        assert(ri);
-        assert(cp_access_ok(s->current_el, ri, isread));
+        ri = redirect_cpreg(s, key, isread);
         /*
          * We might not have done an update_pc earlier, so check we don't
          * need it. We could support this in future if necessary.
-- 
2.43.0


