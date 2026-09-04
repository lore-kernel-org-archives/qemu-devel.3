Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF8CC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TtE-0005TV-To; Fri, 04 Sep 2026 09:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtC-0005SV-Gg
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Tt9-0008GO-FJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-495590dde14so13880825e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788528206; x=1789133006; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=38O+MEy871yA8vnt6T0mZIKkwh6RpFE6oR3N9+JfK1Q=;
 b=ZceGfcCGkfXaSdKWwNloFSQVra4X/vERzRKglbglTsqyVCuPycDaubE5xMhLqAJwXh
 Cx6uQweBWkbKx5wvNGSgQNA8ibm3PS93Peo/YMIXUO/RVhlc0NMKofIPWGe2y1i8XpYH
 jIDRAwrhloTO13HYsfHIZV7YIUs8bI3x2KZawSifYdUuZgzYYkwL2Uko6xO9Fd3pjjE5
 WFhirxekf4ycZuzJPkVgrWQzaMgAo2D58v9ueEka1Mp+udnGPqjoPPvf2y7WD7JiajfB
 CzXxTYqxzGSPdyAyvXkRBcZpD2cznqWdLZj2xsIEE6p3KsANN+yzRBac3OlZFkRQNWFs
 +Ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528206; x=1789133006;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=38O+MEy871yA8vnt6T0mZIKkwh6RpFE6oR3N9+JfK1Q=;
 b=VZxPVnLLg28mgnYTNB1tb3YPSQzTGKYAibRNbtjN6LJycTNqXtnDv56fMN2RdoOn5y
 APYzW8fZwPTIbKbznFX35MqqHIRJS9IijcSKpuChm04Tp5PS1xJhCDGnQWZvM2prTGPS
 EJEskX8w58Y7tih/nbWRxWHTJ8Hpa7EzgOMhBrTle3Pbf1hqdmXSTejgyhlZkKUrCWyP
 V0+gvwVvnQq+GnvQqAr0+687e/FWlEKObvrNJvf4SEiIQEIK+awJmXuyx9g1sMWy3yQP
 lbfwtnnB2Wf2G2EBRB3XMImowELS6w0lwMiyCZkGKPro/F7Nbu4RLXKGPiXMje+z+Eor
 1jfg==
X-Gm-Message-State: AFuF++m9uBVw9B5tzmOufTySzUJ/36JVObZghZsS4D3B/OwpZOKoTfjL
 51sVAAoFMqNhGa/9sRa7SdE6YyV3J0ttzMjBS0GNvqyn9Gk+MnK8l5XP1aedU+iu2PE=
X-Gm-Gg: AYBFou1tE4k5AXFP2zHT4LZzZ2kBvLzsFmORqlH1veHhyPyyiTpUpkLv7JEs9iFyT/5
 xAg1o8Br7bijjjO/J2ztMGHZVQoMjQ958AeDHeuvHDxy86MT/enHL2LbVqvx5dmWpLvXn4waEpD
 LEX53oEOavafzIWer92JIMj6EOdt0gYX0sfC8VQUp0AGbwR6XKm4O7ktkPsw6oz9SDpnt4FA7EF
 UNxsMWbqLzRjJ0hlof5cdnX4Cl9SKOk2RPjmCYTHzpWF7Kjxs1ISRNNbz/ZOhylnC8cqWGKuG5G
 7YVvR29AsBpr6YiZQ27j5ehcaezDrZM0C4UerDUc/wILBLpcnLaljSMYBK0jUiQiMatW1mnFfr+
 2/SimcaC44XAS5lj8UsLuNe9m2TbQWL6QifuicSLoFIK2UHnCK2I3UJ9doGGXb2yDBIGJRt+LYx
 OG/zgTi6/VfUs4VhE12XkOrY3ZhBXMbX9l1cYcIFGZ9Hxdb3pfGIqOXK16aJsu
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id
 5b1f17b1804b1-49cf81e6cebmr87925705e9.4.1788528205720; 
 Fri, 04 Sep 2026 06:23:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858ab73c2bsm4907196f8f.22.2026.09.04.06.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:23:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B263E61D15;
 Fri, 04 Sep 2026 13:46:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Stafford Horne <shorne@gmail.com>
Subject: [PULL 069/105] tests/tcg/or1k/test_addic.c: remove unused variables
Date: Fri,  4 Sep 2026 13:45:23 +0100
Message-ID: <20260904124604.2207440-70-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-70-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/or1k/test_addic.c b/tests/tcg/or1k/test_addic.c
index 857aaa13302..27939c64ff1 100644
--- a/tests/tcg/or1k/test_addic.c
+++ b/tests/tcg/or1k/test_addic.c
@@ -2,7 +2,7 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a;
     int result;
 
     a = 1;
-- 
2.47.3


