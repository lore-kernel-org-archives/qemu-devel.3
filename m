Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46209FC5904
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 07:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvVdy-0001Wa-6y; Thu, 26 Feb 2026 02:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvVdm-0001Qu-4M
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:18:30 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvVdk-0008OK-1t
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:18:29 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so597913b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 23:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772090306; x=1772695106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzQ24LYJCjsa082SEUjYfwtD5gvfrzKLrKMBM8lmaK4=;
 b=dv/h6zn+J8F9OUMx3i0R8I5ypNTC9HGLxGHONG6Z89ImmOo4Ty66+TyakxIVCD3gDa
 iVDH3jvUuYgJ5vBoOB+zcu+xjn3+bQq2w5MEOSsWo8vQyRJbugox+ooPSLt00vI572+R
 lyVMeC0OcRMtHIlWevQFcLnTB5RtXn3tC/AFbg6ZeMKTBN5OrxqJcH2ZYVthhEiHv9qn
 0szbvFjnnx17ahQzkdQ9W9vHwJh/FlKxttA0vXQIR/KIVMiwWvUydTYK1e5stdbE/xam
 +d2iaCgmQs72m7aJzDNTdn0C1QehbgCkKz8eKfpo/hVGKb4Eo7J1WXohJUyY3HD5d+OV
 wiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772090306; x=1772695106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xzQ24LYJCjsa082SEUjYfwtD5gvfrzKLrKMBM8lmaK4=;
 b=sf9xBm3fHAQcex3oRkUB9YMl1rK4qU6NR4lPvXxkmrHIrPei6ll8MoG+Tna7uw1cEc
 T9IoMZX+1+iLW46EXSgVCrrHU0wjabYNVsdeAHBllt4hOwEfrD7a4ILLEcx2uaXtAOWe
 xf0MOJ7nH7V8CsYo85hyyV0We08aeIGMHyZQ3HDQSrzW7xV7r4LyGqHnXJaat6MnkVkd
 H/xsCI/ULvkGYm1zBiN/WhsrcXyLwCRjmhmkzhRu5wSOOzxDMno4tzT1HVpz0rGaIqBN
 OwH18ANYSA7JjMz4SgyQRcoTLPklLc9zfu3wu5muUCt3+T1RrYFTHYk/kvMEyoEUJfiq
 lXpw==
X-Gm-Message-State: AOJu0YyIPG+dETNtwyiKBV3k/Va2fFduQt2hg+PvRNonCVY1cyWrMw/k
 42Oc5CHhY9KZpsKTNtcdxwIT6+Q43oMLVheLJdOeFVXSNBvJobpKO6eW74evJVcaWbe1646u5FR
 c1YZWinGiS29zQQvkRvt3qPa+XxrxaIt2xt1W74+4ziH2Y0S8Rjm9NtvNGAP4KpwYd60eS8PDGa
 MVN+RWriUFo/ku8mOCooOQjzwhixUsCdetN7wB35KUok+u
X-Gm-Gg: ATEYQzzU6JgRt5WklYKVy+cGhTSdNcJC15Qql3h1dzqb+WObdEozd4KJcCOYy7B9JXO
 r7PU8Ck3FXndKxDC7AZzh7bwBLJtHIv7ZMf7xJQxHcnZAysr8oOjc2fGrRSjdyLfXbw6hk5zuqx
 zja0oth5jCL+8nreh/QK7JAp8ND6cM3e7XIDP+wXqCJ3cJQBK+3Ph4D6dpTrTcjYda7Dq4TMl28
 x4pmpOiHmOCVBTJttlmWk3LOwD2Ts8bdsNO7i5bcV0m772DFP4cMiHl8aJYLByffA8ef1bQANg5
 7nWr+1m4u/qCdJDfLOzVOon6ThhQ5s3gooZ6MaAscdUVB166U5bAVAFdLW+Yg7TgzqvbrRroKbH
 t8kQ83SbYCigyUQTvPtCWDZdvHxFHE2YW7TJdbQdCq+PagsQPt0msuoVbqN2B0yUJn2s+y6rW2k
 ceOQo4eVZdBxn40DMEllI31RmEcpq61IwQEvRUPxTk8dschqgJhosvyibfLrc8HkYOq+O2ObjBv
 e90F+1YEHnUVaHSOuPPvlQyMfc=
X-Received: by 2002:a05:6a00:1d8d:b0:824:a5f4:fc3c with SMTP id
 d2e1a72fcca58-8273bc84fe0mr1104542b3a.19.1772090306456; 
 Wed, 25 Feb 2026 23:18:26 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739ff37f1sm1296179b3a.40.2026.02.25.23.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 23:18:26 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Max Chou <max.chou@sifive.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v2 2/2] fpu: Fix unexpected exception flags when converting
 infinity to OCP E4M3
Date: Thu, 26 Feb 2026 15:18:15 +0800
Message-ID: <20260226071817.1417875-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226071817.1417875-1-max.chou@sifive.com>
References: <20260226071817.1417875-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x430.google.com
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

Infinity is a special case distinct from numeric overflow:
- Numeric overflow: finite value exceeds format's max normal
  -> overflow|inexact
- Infinity conversion: input is already infinite
  -> no flags

This commit fixes the unexpect exception flags by relocating the float
exception flag update flow to be outside the uncanon_e4m3_overflow.
And raising the overflow|inexact for numeric overflow in uncanon_normal.

Fixes: 27e989f99c ("fpu: Add conversion routines for OCP FP8 E4M3")
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat-parts.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index a738758aee..3c323c0cec 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -277,7 +277,6 @@ static void partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
                                           const FloatFmt *fmt, bool saturate)
 {
     assert(N == 64);
-    float_raise(float_flag_overflow | float_flag_inexact, s);
     if (saturate) {
         p->exp = fmt->exp_max;
         p->frac_hi = E4M3_NORMAL_FRAC_MAX;
@@ -388,6 +387,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
                 if (exp > exp_max || p->frac_hi > E4M3_NORMAL_FRAC_MAX) {
                     partsN(uncanon_e4m3_overflow)(p, s, fmt, overflow_norm);
                     exp = p->exp;
+                    flags |= (float_flag_overflow | float_flag_inexact);
                 }
                 break;
 
-- 
2.52.0


