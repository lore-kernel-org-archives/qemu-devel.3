Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A09C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwOJ-0004It-SU; Tue, 25 Mar 2025 00:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNx-0003nR-0Y
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:36 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNu-0005qC-MG
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:32 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3014cb646ecso6658655a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878769; x=1743483569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rvUTTGe7RSowwob33glnfX6lSJ/LNSVbNxwketpLmc=;
 b=E46pVlgffJE0YrHPRPU/+n9wmcpldQsM2nY8vJYE2rSuhSX73IG3A9iwgEuSOrIhQ+
 pjTEsAZP0fVGaG1ww/0I/83YOWtp23vRlFWNoFRKy2DUeKUVfh3K264T5izv0Dnxk6n+
 0t2aqcuUyaOfufDSwQR3lUcrFMUh/haCWwDBYrLV6+s9XznpGHHk4Q54r8p+mZcj9rZd
 HL8QrM/uVcWMtXX0mEc+u2xMUyCpE5HEoTAgu/1kFCqv3ToIL4MlwwnpnVBb7IPncaMa
 BZOs1I/fG05Q55NbyME83AaH9E/VgDkf94LoeMzgug1UD/2gan/LneDPmGBH5ryyWDfd
 tmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878769; x=1743483569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rvUTTGe7RSowwob33glnfX6lSJ/LNSVbNxwketpLmc=;
 b=CDW94nPOTDh5fRz0H5ipUEG8bUVoxsmfOhihyu1nBoITZQVZ+oqcI6gRa10xe5971I
 RtC2RhfNByCYhSqp4qW/58mBEp4Q0BABeUCafzzGgHkA+QFSS8FCr16/j+8rL6L3dKRP
 uFCfkojrDqOBamAh3PvEkKgZ881Lyr2VLpusTGdnPLdrCuaZpR/fnt/W7vYC5sky20VF
 WdFII6U4KSYUeRaUFWMCRz8VccpXhyn3ljoQqmMv8VY4R1IZeXLrthtaUYgp8251+Sa5
 Z4x1LJrb0tDDYfcj3Qrkh0dpi/FqQPH5cF0gSAzlD8Qj3gTSv4axJt8EwparfTBOpri/
 XgnQ==
X-Gm-Message-State: AOJu0Yzj0kgk2cIB0AGAgYi7JD10WmyF0qV0ROhQrJTgkkA7KCMHAmWc
 Ix3ydpD8A7YSQ+x/GTfrRsKlweWYQD7yjRntVNiySyZ4MMxfAkjJDjQo+IhB+y77GMDi5capt6Z
 o
X-Gm-Gg: ASbGncvNDn05znH38Xw3+pSXoaghUHzrzy3/tOfFVU1U6Ks9JoTZQ/FBpeh+s7jYiVo
 I4j1tS89KszCWfCwQwYz1FQM2wN214A3UYtKKj6ImTuDllQ9fG2BbiFExshpuGYUFwAwI+RtyN5
 j+KMLz/ovIPXWm2cQqjsqw+X1lAPTJ9s4sZ+YER8GJx2VWwybzklgJ+vVG/eIVfFsaZP33JWSyI
 Ibhkr2tITiwH4k0Wyg7dYATO9u8r6MEMAn0qyqz+XiAdZIVBAqerkBCZ/ca/53+OIx4M5sE2D5B
 3+P2WQAScAMbNofLX/GgRmbmmK7b9LtH8rAs5h5WPH2V
X-Google-Smtp-Source: AGHT+IGd5UXWo/Lkrytq7CX1i0u6UBOb0hauVyNgTE4qX82WgibZ4vfYtc9KuC+rTMrhj/xFHAo1Dg==
X-Received: by 2002:a17:90b:35c4:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-3030fe75747mr22925455a91.8.1742878768857; 
 Mon, 24 Mar 2025 21:59:28 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 08/29] exec/cpu-all: remove exec/cpu-defs include
Date: Mon, 24 Mar 2025 21:58:53 -0700
Message-Id: <20250325045915.994760-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e5d852fbe2c..db44c0d3016 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -23,7 +23,6 @@
 #include "hw/core/cpu.h"
 
 /* page related stuff */
-#include "exec/cpu-defs.h"
 #include "exec/target_page.h"
 
 #include "cpu.h"
-- 
2.39.5


