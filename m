Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08547E7718F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQB9u-0002lv-Ic; Tue, 24 Dec 2024 15:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9q-0002kp-TR
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:36 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9o-0002Y1-V3
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:34 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso57354525ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070732; x=1735675532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MvL7unhiDd3lPuRXr6mq82bN6R8xw9zcqDFlejItlQ8=;
 b=YkAKyEFepi1p/NeYSv+IOTBD0qRrkdC9/sEd6CrACfgjNhpTEpEvXZfIdbIGtJI+kL
 tmD/KuAK53eZaotCkhOBWHoeYQJ05u/kIiQ8BnD51+nQDx41CgazTUvZQMahV5GZrGN6
 WDHMHCXOAVzHoCrvxGDzQ0WPzg66T9G7kXO0bTrUiJ94E6AIg/QAGq6ZVi23qKwFIsuW
 aZj1AGl4ebudsogynIS/BHJMxniucyTCL95IIRbDu6rJL5ioTHZYO/EIs6aUNmSsK90C
 yyGAL1yFWK7lM0tawhauPEv7THWbIimnoU/O72ezFT1lE6oZ1pNkjXwMyZf54Lp6acLb
 b+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070732; x=1735675532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvL7unhiDd3lPuRXr6mq82bN6R8xw9zcqDFlejItlQ8=;
 b=RDLEhlX7kq/YAp40EZwuMrHWSM95/a1SgNwS36nhII+Ighil1jXfZh+XDjZQcJDusj
 c5bUodfNJtoxkULwxqKj4j+EsV4LPwrbjrTAV9ShJFHYisXkEibBQALm3v9jYBaFvNm/
 06oOSjMODtTbYK7lHHktFza41TLfckbkwb+VtJyW+DoHID7E3pj58GD3hOiyenbgpftz
 W6rfibIDCVsFLdT8+YUoCzTAPV1f810Ly6Q8+Z1HeFO7PHXYRUxN3jvvjZzwAxcBFCGx
 73dE4wKkR8cs0konGtypoCu0gqwk/AmgFTQievzDqdgt56tFlbnF38scjgwIX2NLp/1b
 JkSw==
X-Gm-Message-State: AOJu0YxibKUj8OOGAicXcUoYyt63c5aTrA9du3vaf6+urRTDLdlbCChg
 y0n7KGRbjZP5toam1F1gcXHrak5Dp+rSBrRxsdtdWwcj7tI3ZETtsiQXUWFCblbyIUzZB+8ZMO/
 nebc=
X-Gm-Gg: ASbGncuA5EJZC6SGvBe7J08SUXe2aIA3FCkY/zFptly5yR7d70orfzOB5Mu4b27wG08
 WzG1XJSqBORq+BTmqJK9c97t2gW75tJQwy+S2MEqcj1t12HHC+190rf9Ec8dBXzJM8cpH6d7GM4
 iIqN/bv4ODkGTXGdofNLWAC+OGO9k+PzuYC5G4oS/HYcpLyb1+BC1IqHRdsAveRceL5zT7XkTJi
 ecMJBXCeodQYcG9gKnm5bwoP9W9miJoZHlMIfK2aExCGe1NpQy2/u1L+AsMEvIlvZgv0zuIhDjw
 9/IZdc3G8td5xoYG6noSPmGA8w==
X-Google-Smtp-Source: AGHT+IGlX3g0MvRaO6P/lnK4DKugPeSK3ZhiOpZsbNYpmcU0lge7Ar+61RqRxOqKnfllyDz2ch3g/A==
X-Received: by 2002:a05:6a00:4ac6:b0:725:e015:9090 with SMTP id
 d2e1a72fcca58-72abdea0803mr21685710b3a.9.1735070731748; 
 Tue, 24 Dec 2024 12:05:31 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/72] tcg/optimize: Introduce const value accessors for
 TempOptInfo
Date: Tue, 24 Dec 2024 12:04:19 -0800
Message-ID: <20241224200521.310066-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Introduce ti_is_const, ti_const_val, ti_is_const_val.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 26d1c5d4a1..5090f6e759 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -79,15 +79,29 @@ static inline TempOptInfo *arg_info(TCGArg arg)
     return ts_info(arg_temp(arg));
 }
 
+static inline bool ti_is_const(TempOptInfo *ti)
+{
+    return ti->is_const;
+}
+
+static inline uint64_t ti_const_val(TempOptInfo *ti)
+{
+    return ti->val;
+}
+
+static inline bool ti_is_const_val(TempOptInfo *ti, uint64_t val)
+{
+    return ti_is_const(ti) && ti_const_val(ti) == val;
+}
+
 static inline bool ts_is_const(TCGTemp *ts)
 {
-    return ts_info(ts)->is_const;
+    return ti_is_const(ts_info(ts));
 }
 
 static inline bool ts_is_const_val(TCGTemp *ts, uint64_t val)
 {
-    TempOptInfo *ti = ts_info(ts);
-    return ti->is_const && ti->val == val;
+    return ti_is_const_val(ts_info(ts), val);
 }
 
 static inline bool arg_is_const(TCGArg arg)
-- 
2.43.0


