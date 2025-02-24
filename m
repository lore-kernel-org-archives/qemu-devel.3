Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3514C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc2p-0006vt-1w; Mon, 24 Feb 2025 12:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2j-0006uF-2t
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:14:58 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2h-0005YM-KP
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:14:56 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220c4159f87so65443935ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417294; x=1741022094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2HaYqJT69Ht9+zo6HYnPhOTRdY5KEIxgJgRpsxEoW4=;
 b=iuH5gg791w59iR7fPMWM0ur6bvVRAG1nOJOmgDHkoeYlVtzjHDQRuCcSJQkrifO/Wa
 TgIJWYBm2tsBHreh7lIafe0QPpdrYHRsTCjcN/bylMarXJnbW/8hSzv90LohfbWwDWzS
 krFLflNE/VIsXD/8XkySlMofyY/XK8b6aSwvCk7EW1yY+4/G2ctJXjWJ+0PrbVVAd+7a
 ySBC5gjZWpbdIEY/TypCgdGr5u06bLO2Yi0jJIH3M/gUjnDcmKiKcIzI9zqwHJBCGsYy
 XMqWOXs2zsqnlIiR8yWuT6x6C84j8ZsAxQpmmlB1ee/EQtvnJr6tOxFHNeSC/CxRQ/HT
 03mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417294; x=1741022094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s2HaYqJT69Ht9+zo6HYnPhOTRdY5KEIxgJgRpsxEoW4=;
 b=NFj8jP9YnB3z/KU0519mPIuHoPA0rvgGFUtJeb037bTqTJAowKsiIgraYtdqPfPxr+
 k8pmH8VNTs+rv5x3q0psmJ+rW45lsuGcZQKrtHrN6qWpssGpRhoT3BL5qaXrZMUxRneh
 oF11eY4IClk+hqfraJQlJAcoirJZSebx3A02hP85i4Q0RFOxo2ug9S9RWMzFY7wSUKC6
 mieiz8G9HfikmHVE1i5Ge5qHePVBXK0dmobdL2ODbAe/SUhdtd1yQ/B1d2qYZ+JArzYM
 2V0QlmDkPt7lLzNy3iPtPcT4cCmZ2vv2CaP0bTkgGOm7IZSIgB6mko6WzgDzhNXpPAOu
 vKEA==
X-Gm-Message-State: AOJu0Yw3kcSZbWFum+2uiHyGkoLC60aiL/ez9QltSQyqJB0Xw6apXGQf
 eBz+YV5gNkhEfqIf93DniHGp6/g6EdEocLo5EHEj09L7e3bmKiD8exFeMgz+y2o5KQmSudHeXrl
 J
X-Gm-Gg: ASbGncv1YxynHjIicnu5IZ5KyBvA3q+nFGg58bJWhvb73rUSEdXlaZmBS62oIB0O46E
 4a8JDabI0G93tXyGHD7nVFKg9QnxtcCi7+ybI+5WWDYTALvJCTQSQgjS0kskwfenfOX7Vh7ZmMW
 rdBACmHEWx/mSGHN6hjfzGckVgdQE1C3xd579qP2rdc08AsDtxkz6MEemolObByAu8v6T2MaGbP
 T2bUCHoc+4NmBpAQYbT4MVJc+gF0qGScNCSYoydkxfxTSwOk34+7zQKwi9wKv2G3pCXj9ysx05x
 uMmx/Pyid9TzevJsMdY+/O2FeV8SQpzKLA8=
X-Google-Smtp-Source: AGHT+IGX4mRo7qYFOMs38SxV6FS2LKauAlLhX3B7iuLAq8x6Y+pNWI0vNpzzNkUzypywXwxbzRai7Q==
X-Received: by 2002:a05:6a00:a01:b0:734:b8f:a425 with SMTP id
 d2e1a72fcca58-73426d9884amr21047313b3a.23.1740417294407; 
 Mon, 24 Feb 2025 09:14:54 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:14:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v4 05/24] target/m68k: Update FPSR for FMOVECR
Date: Mon, 24 Feb 2025 09:14:25 -0800
Message-ID: <20250224171444.440135-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
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

This instruction sets CC and EXC bits just like any other.
So far we do not properly emulate inexact for the various
rom entries, but we can certainly update CC correctly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/fpu_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 206ceeba16..2fa0752277 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -426,6 +426,7 @@ void HELPER(ftst)(CPUM68KState *env, FPReg *val)
 void HELPER(fconst)(CPUM68KState *env, FPReg *val, uint32_t offset)
 {
     val->d = fpu_rom[offset];
+    HELPER(ftst)(env, val);
 }
 
 typedef int (*float_access)(CPUM68KState *env, uint32_t addr, FPReg *fp,
-- 
2.43.0


