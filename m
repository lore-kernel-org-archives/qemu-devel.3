Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77775C624D7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ON9-000119-36; Tue, 01 Sep 2026 09:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON3-0000xn-25
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:49 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON1-00078x-GB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:48 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c25420fe973so145335366b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268666; x=1788873466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m3t5attEc6DBgbJ3tNga/MsrgOgKkBBlm9lBtl53/Sc=;
 b=lHHg25t3GH+g+uMWz8saYbVJOdJk00T48o0b45XIoWxgUrM+802gyZkXRyopHPiCpk
 F97SGMivZQ6kdjVF0vn9F1Lam0rc8LGqdu6gWMhLaBNaOggmJwBNoMcvUKWu32wLPabo
 NT+ndh3uUFkrkJ4xZhNyagS+AYMvAjzR+RKn5bp4CJVTaGywI7wSWGgHVzeJLNTC8kON
 HG0eAFlV9DA1nr3rdM8GXRnSLgwsVyrDh8NdbtxaZEXXR2/h8Ns5oh1e3uvlOjuMkAjs
 +skZIYSBdHjaxIqDtHw/tDnDTbeKHduIFFJTOmHNC69UKYMR4zu9DUvTuNgpxHhwHq7F
 C+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268666; x=1788873466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m3t5attEc6DBgbJ3tNga/MsrgOgKkBBlm9lBtl53/Sc=;
 b=f+PbmHK7Z3jx+FmWIeIXB8l5I7jgmXsXKJ9i1UrXD74tOIgfCt40jZ6TB1er2zimOe
 92Z0gM6Yg8PrD8xiJFORLskF9SJYbgOYaNR3Sc81z+GyVFHE4lja3R5Av5o2h0CYJ0bl
 9S2h3lUxRewCpqp2JtXtTKfO8O1zFOoq5t4X0nGX7A+jq4dtRZ5bhLQKq7qYyQJzbBIt
 rxDkZLo7+G/ob3PgOx8JmrwR9YIvnL7xDIzFpu70Y7vpTOkmNOa93XOhwgjaGtgZWYZV
 F9meydvYwAIj27cM33UiqBqqDW4CUJjrKks1offU8p/mwue2pHfPs7wUWAWtMjdX6vHN
 RMWQ==
X-Gm-Message-State: AFuF++mlQ7d/o2hrluv4l4/DsF77sgCzkMd5fM3i+yG5SiZGLir3aT0z
 FDv7pRBPUBaeLlfeKTMBNO8sFqO8F3RZFbPaTrxjqVGSOqU96LZEvs0Ldq/2QzTrRgNFBClXfZk
 WXKFlba0=
X-Gm-Gg: AR+sD126GQPmruglpE+akZ2B7EMOZLPfJ+qxnSHPWMG9d9jJl/oVj8zpXLazJ06vizs
 5fP1CoHchSTSfBGqFVIsDRDJ8SS8gjiLnn07BGfw7eyVZeeJ0p52TY5jTnTCEAd/q7+C59ZfL66
 GqaRtRQwzpQkSi4WN55Vj1yDUoQnQViPzcu1AL1+ld3XV2CilpZ938P27FvUdhMkFzyG91LIeXP
 r8MrYybbbxVYrjhcNBi9NrC/GPeHIINS5DmKT/iXSNKWvzHLcur28qONHgVu+GxJoz1eAcuzvvq
 FRt2CiNRIexUrx7b/7Lub0eRooGgUe5/CIvMR1rT1v96y5up4A6EPTF5tKQZshJ+QR2nzSGs+5D
 Uq5qCOuwogYfE6N12Lts+OZSlSbUo5jWYlCghjfS8ChVHCKL+HLvF3K1QwHArArwr8kc1doeWl1
 T6t6/oAhZJPcB51RH0hE8MeEGiixF2b56vuwTJk3enbQGlzeip3AedBi+1tBPwKkBF7Kn6si/SJ
 Mg6g2wQdxxzshJB6aSxL9JMsZEX+Y6QiU1NASTaB2frnBvJPZpzz1f0nVhN7FBoWf0rSA==
X-Received: by 2002:a17:907:9809:b0:c24:6f60:3f7e with SMTP id
 a640c23a62f3a-c2556fe8495mr2355910866b.2.1788268665712; 
 Tue, 01 Sep 2026 06:17:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/58] target/arm: Make CBZ/CBNZ UNDEF before v6T2
Date: Tue,  1 Sep 2026 14:16:45 +0100
Message-ID: <20260901131732.2263947-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

The Thumb CBZ/CBNZ encodings are only introduced in v6T2 (for
A-profile) and v7M (for M-profile).  We missed out the feature-check
in trans_CBZ(), so don't UNDEF on v5T or v6M.  Add the missing check:
conveniently, the ARM_FEATURE_THUMB2 feature is true for exactly the
cases where CBZ is implemented.

Cc: qemu-stable@nongnu.org
Fixes: 9ee6e8bb853bde ("ARMv7 support.")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260821132550.168896-2-peter.maydell@linaro.org
---
 target/arm/tcg/translate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c866148383f..1a7dd77a9c8 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5783,7 +5783,14 @@ static bool trans_TBH(DisasContext *s, arg_tbranch *a)
 
 static bool trans_CBZ(DisasContext *s, arg_CBZ *a)
 {
-    TCGv_i32 tmp = load_reg(s, a->rn);
+    TCGv_i32 tmp;
+
+    /* CBZ was introduced in v6T2 and v7M */
+    if (!arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
+        return false;
+    }
+
+    tmp = load_reg(s, a->rn);
 
     arm_gen_condlabel(s);
     tcg_gen_brcondi_i32(a->nz ? TCG_COND_EQ : TCG_COND_NE,
-- 
2.43.0


