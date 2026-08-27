Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D36AC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRzE-0007Qt-1Q; Thu, 27 Aug 2026 00:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRzC-0007OW-Cd
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:45:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRz9-0005sf-5v
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:45:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-85339ed040aso197229b3a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787805905; x=1788410705; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dUc517X/lwRNQQa6yh3PrvH95m1tesFhSmMz/oKNuv0=;
 b=mmyb56u04Xs/nSYi11Cncp+RZFl8DXSL4UiVEm2xIzPFFJbrg0Yb971azDu2mSn++z
 bLXkVUAcjVbqxz+Ztg8MVxXyFELdectsN/LzGkKutf4rE836vO6RXsfaZwz6N4/huLEA
 KZb6KMyIkGgjN8XlYIPtZsZJcS2FcmxIFPVwSo/2T4hVArKrkBdrxFF7jqaO59VejyiF
 0LDArD1XKnz6bxc29ERpj7s/TCKoUWMTRpInFaYtDNGxi86EwguSxl96zBALqWqf5T/r
 ecXFETbqxuR6rEFZpAIT0c5JPoZzm1zuYd/GAA6Gr1e8iKS1HjgCRyP5oNkOyXmGB4Sr
 9hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787805905; x=1788410705;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dUc517X/lwRNQQa6yh3PrvH95m1tesFhSmMz/oKNuv0=;
 b=a6nmworR9PN6UZ6nYL3swO9w31zZVGC+1EoloNOpC4rCqYQvxWg8xEzAa5koCjKpic
 KkzcqGW/bkZursoecf7OYwgjnheXAA0RlBl0lZjm2oo2a5hT7OPdb+7Df8RgBobLhKvf
 x4XDyJ1x+74IABtxL3T9FyB1gBnkB5PdAjN5TdXAg9oiBr27kbjRAEKU9ywnqiA8W7vp
 3AsGjxLN1ZHOHMfEkk4VrXDpaIDPeDO723/DDhd6kdBUiqTryENvxYX69OD/DS/mUW0j
 gJhhBDAbriFunUE+DhP8koHAC2meObQJjKhEmoWxW5JNgsssr7s6Ssmf1FiZJRvdT2y4
 gdzg==
X-Gm-Message-State: AFuF++kxYbvEprVtQJh3LxufKuD/gOPGpXpr/Rn644d61mCN6a9nKvTs
 GIVq+oPfTm5ikkCH6Ec6rLPBBudnnt/tUsO6AC0wdlRYbYTb8MZI09HJjiMVVz7SoQ/Tq1nGDFC
 plNgT3lY=
X-Gm-Gg: AR+sD11XBz1q4KOu0Kx6r+fw/q5+aG/MZNhukPFDiqVtV8AH50E4D2rr13PBHjaEyee
 KzeZOqulMkKQ+H5yX7jv1z5xora7A51h5ekaNr6lfupI9H25Oy8dUF9PSck+TXj9q5izZLg5C/W
 eFVpZdR55ejCf37axq8ri7tDApeurArGGqTBh63jCBIBMrCAatpcWBzdR67dbyBIGo+jZQCeaJx
 zwKuNChdXCLYhrapN/HsR3SIkzlrfmQNRuf8bj7y5QKSmV/HML+ro32/OWJNnw5TdrxHHDgq9gW
 znm6umG47KXdQLbBdS0T0PQnSLHMgagW5su4WAqL7wv8MQ8yjwI6StHj8Ujry49b5q22mYGVPzm
 AoIuXEpMfsq7aPU4t6wrzbD9zkG/dSdpiI+PgO6IlFsv1reDBLDxhwFveHi+X5xDqI6zsczWXJb
 7jaj9treeH3qCyOB1jBcnaoF8KLjyyxXp2IlUR5m/nQ1+JL+fhSwSXpSsMzP0YF/RNSv8RnPmnu
 ORWBnufYFqUB9++ow==
X-Received: by 2002:a05:6a00:4289:b0:84e:2382:f4f0 with SMTP id
 d2e1a72fcca58-85372ea2586mr24635485b3a.4.1787805904642; 
 Wed, 26 Aug 2026 21:45:04 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm1606003b3a.44.2026.08.26.21.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 21:45:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/4] tcg: Fix typo in tcg_gen_hswap_i64
Date: Wed, 26 Aug 2026 21:44:59 -0700
Message-ID: <20260827044502.778915-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827044502.778915-1-richard.henderson@linaro.org>
References: <20260827044502.778915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Fixes: 288d39e26d ("tcg: Simplify bswap/hswap expansion using bitswap")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4229
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 28d3b2a847c..2c88f4f7ca9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1887,7 +1887,7 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
  */
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    gen_bitswap_i64(ret, ret, 0x0000ffff0000ffffull);
+    gen_bitswap_i64(ret, arg, 0x0000ffff0000ffffull);
     tcg_gen_wswap_i64(ret, ret);
 }
 
-- 
2.53.0


