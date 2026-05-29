Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC26CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 08:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSsbL-0001Ok-8f; Fri, 29 May 2026 04:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSsbJ-0001Ny-89
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:29:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSsbH-0005QD-LS
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:29:52 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so8568540f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780043390; x=1780648190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+G/zHWkR0QCdbSyAQf68yG2AhF714TiDMy1VuhRq9nA=;
 b=pSU0+LeD1KrtzdaI1GfPkbeeQMdTwV/897hnmjKybkQVzSCRsjC53WViVOb0yyLW04
 FI/TWMlBxMO4/+CsSIJMZMi200vy0WkwQbIJRTUy5ZjO5f6dLay9dOnE6PxkSb6kYR5l
 g0QKBGyvpI4YTATVbvzCQ4t4xyhgIg+FXWTZkqIkZJzpyR45pmKK4yhCI08wM3R9mbrx
 Zy/C928KKt+pfXVtSggkkZqUlTWBeNdJFpqu9Wd/rwTDptCCrzZiqhAvx55faDl+hido
 52n8XlYSuvxNOqE8CumhZCXXheNODmwnrhYFslN8Dx/AYTaMbdhWfeMMorrGdOHv7ww5
 985Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780043390; x=1780648190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+G/zHWkR0QCdbSyAQf68yG2AhF714TiDMy1VuhRq9nA=;
 b=oCNMtlQIxIrADVcmY1ztfqJbFJickXQGCEDBuZ+Cc/DxLST9IkAsdQIRpxiesx/zVu
 0VT8Aqw/aDo7iS9iteRoONdWWAwwFlQb7wLlp0nhVRbm2IpVzFdZ9GPkSYd0x+h1zIVJ
 jA1SS2N7sHVWWNV1qk2iwGlghIKAwDW28Mw1L3vnZy6bv8BheuX3qEhSPyOfypY0/1e5
 6oM74kR5UHwhmnOzZTGs/Xb0E6ZmzjYppfn6P96bGdTU8F9xr9Ds35FDgZ6ii4w9CEfa
 Af8a5ZTsvrYOz8hxEjQdbdtRAJDu4L7jBxALbTQQxxvZUFMzV0tLcpLj+XkjcG/yWEUp
 M98Q==
X-Gm-Message-State: AOJu0YzUTQaWAAPINzYtSN9cHadJtTD1N8wCquSGUhv3WpznnKjG1j7/
 TgvQKHEUi0nxwDooRLX4yc+pOT8DYPSvFxttyzgEpyUMt9sodjCyoZEKqzhMPX1IlNI=
X-Gm-Gg: Acq92OFG8rCxQIFa2E8WaI4VA94J+qFVEpkl2iGhxzdR822U1UxY/gubrb/cnRr7hNQ
 Axjog3YZhHISzDqVliPAhMXvjZbObLeCXpINvK/AMmEVNF42t6hDitjsRkO8m4wfkQGe8JWo/yO
 l6QAr/Mv763YZuHLqRbxN7dbQPAJFiVvQiLiPOCyFx8pxp+gPV+Tv1kVfkGv3wUclvL1UNXWzNq
 LrS1XCyBL8ow0Xvjn2zzVnMOM36PmLO15D8G5SndLnWxOZg+q3f7Joj2hh4Q6RjcEhEaK46lf8l
 AuuSgaioTvIHpWp03uhsJvuhTudNOsO93Bcs256OvxO/36UqDHjVxEHcW3rEN5lmdM5cU5ixu6N
 8Fw5BZlYb4wqgruXzCN+Fa2MT+YxqfbldIVGetz4Phs+WYXbBfvJ2Xzc2OszlgoCpq3jE1XrFi1
 HGQUGPmncb0k8N2ImNHQ/5dXQu/sVKgOmnvQ3R9FSH12J9
X-Received: by 2002:adf:e612:0:b0:45e:edcc:f6dc with SMTP id
 ffacd0b85a97d-45ef14053e3mr2409052f8f.6.1780043389791; 
 Fri, 29 May 2026 01:29:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34a0403sm1967087f8f.6.2026.05.29.01.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 01:29:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 386435FA5C;
 Fri, 29 May 2026 09:29:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 1/8] target/arm: fix WFET typo in syndrome
Date: Fri, 29 May 2026 09:29:40 +0100
Message-ID: <20260529082948.363931-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529082948.363931-1-alex.bennee@linaro.org>
References: <20260529082948.363931-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

A stray x slipped in and we didn't notice! Fortunately we haven't
implemented WFET yet so nothing is affected. But we are about to so
lets fix it.

Fixes: 4575da5ecb7 (target/arm: report register in WFIT syndromes)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v7
  - mention how we got away with it
---
 target/arm/syndrome.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 4d1f1c529e2..0eb54c15ce7 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -674,7 +674,7 @@ typedef enum {
     WFI = 0b00,
     WFE = 0b01,
     WFIT = 0b10,
-    WFET = 0xb11
+    WFET = 0b11
 } wfx_ti;
 
 static inline uint32_t syn_wfx(int cv, int cond, int rn, bool rv, wfx_ti ti, bool is_16bit)
-- 
2.47.3


