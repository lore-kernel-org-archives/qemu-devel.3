Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601F2C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhIX-0005Xk-Br; Fri, 04 Jul 2025 10:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhHy-0004g9-Mu
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:18 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhHw-00057S-Mb
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:18 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2ea08399ec8so907715fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638875; x=1752243675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJkg5Eikh8pDdMpxJ6bol3squO0VoPxIikfVrqRqSHM=;
 b=Jq9iyNWOxkqTKZnnaZYl2lhQOE5VfbW61M0eKBbHJMI6CV4tFHWli4Bfk0RYPn47Dq
 RPzqkddXdBnkCw8VIbVLK1ZF7d2XjjMt9a9T9fQ/dduQgAX3hGGNb2C1wGX6PhZPYZGx
 yN7DELoruHfYwCb1qYCKUEiFck3R8GZJkQGAi6Nb+/fbkBJ0NSUIieJipybSyjNWK/xU
 ixsEckEheEDZJznxSqr1HvoZN7jeJYHCkYv7jcOpibUsDZpnx9Z76XxzovaeNHn31hQw
 Jk+gKxoIeOmgc/wbduSelQ0ISGkCx2+nwDFqsr90k5sI33uhW3Hb3BW6hNMaMInipH7k
 ZB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638875; x=1752243675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJkg5Eikh8pDdMpxJ6bol3squO0VoPxIikfVrqRqSHM=;
 b=TFjWjIhnINFIzu+MmKggiTKIhVz/cP7niX6/sww4Qy0nF9JKj6PddBn/T0d2xCpQq/
 drUw/pjEqMkfH79kvcP9W5V2fGwcXS62+5Uh04cWjgiF5RGCXcjfYO+Agl6ZgGudta6n
 TL1mGzY9o9Pr1ZTFH8D1GU/Foqfi0CcIcKsTt1stF7uZMNzz9HQxwBcBpo74SC++NJjV
 Crz4icpOJC/eSAyVeJDpkLP0MfJUIpodxtbleHQI/gbr10tu4f0Qhjl9ZK1EP5anTJ59
 p6EZ48+Rd0gPgdwj8+UyTofe6m+GljeIcS8gIjneIUzCYX94oC7d9rxexre5Wkok76dy
 +hSw==
X-Gm-Message-State: AOJu0Yxo8QblUvd3KVSIeGIo92H+VSePOg5xjhuPhePH5O9QI+H4LdtK
 ykHd3CWi8Z7mgDnPgF0ZlETjyiq4BKNUlQaETNhUljN82aFDlBKrvqKAPciOAYglGID1uUy3w9r
 D3cpZl+M=
X-Gm-Gg: ASbGncuMeyxZWDWIN8wyN9/h+MVHNxWu0idGSOdki2MfIHjvq/vV+7wZpQKmZieivUF
 ZQeIQ7kimkJtZFpf7GFn9f9NeX3Eva/MvOzJ1bDEWWkAAZA9EUA6pXV3oBRx/aaJChRGb3YSTNy
 NGxSo2xDnKotJwlkfl0MOumrWRkI8fYK/gfHR3d4UTU31sAW4LWdpxVn3aYwMklz+/xJpP5j94d
 oRnB08OTPYTF4sxFQX5Fh//NCDa3LoqIL+prcdY1Z+B/nakB6TSbp6eUOgmlrKRh+mVJydecu1x
 /SoQ6KEH/p69eBi0QHAD+2KxcBXFjUbhsVMoe2r0vrxRdSrP8I7tIdgv3P/w2n9nbyFnw7XLXpq
 hKVGGD+tuA5E65DxeF3bChhf+Qnl6BoTd8waW4kv9mU11fmX7
X-Google-Smtp-Source: AGHT+IHJLt4uR2pg4sint1PgJP492LgUJ1EL+gRJ62gqRQMARnytUNP2gpvSqFbpOkk39O0vmKhtYA==
X-Received: by 2002:a05:6870:3c07:b0:2c8:5831:8d4 with SMTP id
 586e51a60fabf-2f796e1b536mr1609909fac.39.1751638875231; 
 Fri, 04 Jul 2025 07:21:15 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v4 001/108] target/arm: Fix SME vs AdvSIMD exception priority
Date: Fri,  4 Jul 2025 08:19:24 -0600
Message-ID: <20250704142112.1018902-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

We failed to raise an exception when
sme_excp_el == 0 and fp_excp_el == 1.

Cc: qemu-stable@nongnu.org
Fixes: 3d74825f4d6 ("target/arm: Add SME enablement checks")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 815225b130..5c44a5dece 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1488,7 +1488,8 @@ bool sme_enabled_check(DisasContext *s)
      * to be zero when fp_excp_el has priority.  This is because we need
      * sme_excp_el by itself for cpregs access checks.
      */
-    if (!s->fp_excp_el || s->sme_excp_el < s->fp_excp_el) {
+    if (s->sme_excp_el
+        && (!s->fp_excp_el || s->sme_excp_el <= s->fp_excp_el)) {
         bool ret = sme_access_check(s);
         s->fp_access_checked = (ret ? 1 : -1);
         return ret;
-- 
2.43.0


