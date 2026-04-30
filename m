Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D224FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF9U-0006NY-RD; Wed, 29 Apr 2026 20:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9T-0006NA-Mp
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:11 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9R-0006Dx-8R
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:11 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c70e27e2b74so101312a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508468; x=1778113268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xQFL5qnJbTCMuaEBPieq6VTwctzd/ZwaJ3ywMslF2Q=;
 b=GhUeO3Cn8ik0sid1v+YmDoiHXRvQARtDMOl3UK0Es8C9a5WY27n+BASq7ngj3OCVYU
 tNMwlul821iLuJchvhGllNzKI1GQ7z890A/27HUGNf1Z78QLXWyy/WED0+265gGr9lNd
 YIMUEBM6g1DIhjY5O6IJ/DDyuFWne9gyYGUbXQqCYV2EYD8AMxk9/InENXEE3yA1tZUq
 i4cWXdl7izP1ioic0NZK3xNmvGp8VU81PTutI5e2bEOR6X7Gc3S8Z1lMm4Unk1zYSUGt
 5KZFtKjTr5sN4FNsv44eFd99h4IFOrTp1eZ3cspdAMtYDXMUkZkaul4OdztcGElXwWOa
 9ERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508468; x=1778113268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7xQFL5qnJbTCMuaEBPieq6VTwctzd/ZwaJ3ywMslF2Q=;
 b=tR+zthEpKYNVPJ1JIllElcmbzfD3JotEp+NRolNIjhx7LS3uYOboW/CF7IDiTCxdet
 1zl+aniZ8lTv6IBemG7uqSnKeelZSpiDl7PkQhoUsQbUM+WCdExu3Xn/YOC9F4NN3VR1
 Cn9GKWu7Nkr+fUTOAjqKAIDJuoFfhwLQKPERVSwSlj2O8ASJ8N39IIIy78+0m4cO7n4c
 KtzP8rMjIhhD6BlZ01byYRGe8ZIsl6IM8JWQMXV3qlZ4aqQ+Qdo3xrfRfpmvdXg9WGyJ
 zg0lhtwIdd8KW6IIdoTjd+wNf+OtqedzphXJDXQkNQErMZefn13F4QQ20MTJ8GYaOMjP
 ENjw==
X-Gm-Message-State: AOJu0Yxvf72gfv/dgSqgZQN+YjuP1vzYZg1VcpYzcoTWhaZkAn2iaoKR
 T2cqiZhI4/FLe28S3nc5GA8KYVrC/TiraaACX9VjySF/2tiPOlkydCcRf45OTEAWsUbIRRjAy0o
 1fjUpmyg=
X-Gm-Gg: AeBDieuJzuP8xlnaywsmN7+FXgC8EGwxo0IMsjsuA7Dor/E1Ab/ZcY2A7zGKY+9ki7C
 SHmUvRuB9b6I2MtubwQDMS3/fNpO1OQdWbKCpd2Ao6Di5f3NiI3xj6HVDD52z5ZVeJnlszz3/IE
 ayi/dvk9KfgGrhSq6MwBLTQC8DRcG5i/uxHaxdLgXfSFDFOb0Ea4MbHhtQ91etm7yUTthw+EdKu
 DfvJutZwZ6p6sGTU6WPVSb/C/XxCGauOFt2GPfbzkbHSuk/ZCoJkHR4R0D8L84V5aRYPcdOIt3k
 ihzYD2ZqbT/nUw03R09BIPtFnvuWz3OwS5LQT7Kuxze3rZL9fuK1lrN8tMxTF2ha7nQ5VfBZ8nj
 DobbScxykxWVEwzyiG2jl1jaCUMSltErL4MuBm333iceKs1xfd2zYk8aZ2KzIshlqu8M0Ski2/k
 b+cVd9aAQsTbGc7lBU5CPYtSLayJS6RW8hZLr1LXlA
X-Received: by 2002:a05:6a00:2d26:b0:823:9b7:9c0e with SMTP id
 d2e1a72fcca58-834fe201dbbmr659945b3a.34.1777508467763; 
 Wed, 29 Apr 2026 17:21:07 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 07/47] target/arm: Update HCRX bits for Arm ARM M.a.a
Date: Thu, 30 Apr 2026 10:20:06 +1000
Message-ID: <20260430002046.59739-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a632584a4e..6376ae1ca3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -258,7 +258,9 @@ FIELD(VSTCR, SA, 30, 1)
 #define HCRX_TCR2EN   (1ULL << 14)
 #define HCRX_SCTLR2EN (1ULL << 15)
 #define HCRX_GCSEN    (1ULL << 22)
-
+#define HCRX_ENFPM    (1ULL << 23)
+#define HCRX_PACMEN   (1ULL << 24)
+#define HCRX_SRMASKEN (1ULL << 26)
 #define HPFAR_NS      (1ULL << 63)
 
 #define HSTR_TTEE (1 << 16)
-- 
2.43.0


