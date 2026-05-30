Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A75CD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrS-0000I0-41; Sat, 30 May 2026 19:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrQ-0000Eu-0v
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:56 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrO-0007Yi-Ei
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:55 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36b9d265355so1573855a91.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182773; x=1780787573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JX7+OeeD2FN1dxWerp/I3Ll3/ZlzCTLqZCteUU7Y4Pk=;
 b=M13BaetuOc0OZLXHzV57TRPk/ebdq0lLAX9he1SnYft+88y0oN/q+4FKYVZpUGg/q0
 f5VewJJQCaqxHrLn+wT4/t4Hxk50fqoNHr3HpGcU6Q8IyidHsPKaLTWXZqo8m5eyDJFK
 FBK7DfhVAFnDgQmOMxSZ2VMv+plLPlYnaEfpa0UF/Q+ZxTIlrWPxz4W50SZXmb9J2tdx
 a6E0JIO9AUnx9Bb5wQD2NYyXbaOpo3XW+3P5fpzZv0z/OF9o7pPNpXEffsWi5JgjSgi+
 0E2KaI7tV0mMMMOCAYUlLy0cTyctZdCKhtL8IxuFY5dn39OY6bkTTfnwkaEYK29Z+R7h
 cMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182773; x=1780787573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JX7+OeeD2FN1dxWerp/I3Ll3/ZlzCTLqZCteUU7Y4Pk=;
 b=rjSUCynMHD2qdJRv5fiimkEPCy9f4G33FZ/GxbA/TYwPsFE6IlJ/H4FRvKwiXIp1+A
 ht5A4zQhk6OsYHJ5dv4yA8CYDYb0gQOkxTrlA9vtyoPLzcYoO4OoLbpr+HtikOzERHVm
 XRhcSs4a1xGdjuqQaafPWM6PN3mttON9QWOQ2OzBV0fUWXQ31QjOgHA5QtTA8Fm6amcn
 /LD0cJBzg+ExwjcC177Gr3MYn+xmV2ztnLpZNdpGviTtu/mgd+Ppwowqdbjc21vmUSgv
 naDJRrSY2en43nnxhs4sIy6/o0xS29nXNFcvNjKu6boHQYjDq0j+xxjflSEygzrvHMeG
 90ug==
X-Gm-Message-State: AOJu0Yz7jNfJ/hO4kC2ac00rI6QAZwWeZXjJYuYlfwmwAiKjbbXyvhxR
 WZsCfbLmKV2rB5AF+h5t66FLwqJnslUZJL0feVH7JtQmKxogx/v9PcYkT6q9+sPb3VI4DiCN064
 3lEEibS4=
X-Gm-Gg: Acq92OGrOoSRr04fFU0N3jxHKDWFE3uzD3GUOByArJb/Awqa1WRq6jZd+m/BcF8tHHO
 t4s0dR9r2JVhY3kfpnlNiGf/AeuzXMP4xKHgYwA453aMDy3wnmkr6A9ty4enUimmfPqM+Qk+LU7
 jxy8Py7OIYOer8PeZD/JN7UU8o0FBL6bqj4kqs9NUAdmDtiOuPEUs3hJDXF1Io9Bv569ei16x7M
 doYnmAJ+2iueYNJpusWoGSrUMao9v9fopsn1I+l73KfilFIP6quu+V1LujfXKPEqcIEBbUutz6J
 C2JcTU+ktHhyYwQpYKPD8WKvUFnmK7mzvqRqMjpbw/GXd/Nqc8Msj3AnCH1m8/PteI2zxmtYpcs
 x+PuQnIPAmLx8gbf1tixNapx7Owp/M940ErBl4JWswyP3TUM2glR5JBmuC3/oOK7j0IKh//vrnm
 wVnolVmXssWCqUbKuD8ktItyQqR1gsxQDIWipPOz+zxGHm0jEQLw==
X-Received: by 2002:a17:90b:574e:b0:36d:633a:e8aa with SMTP id
 98e67ed59e1d1-36d633aec7amr3361391a91.13.1780182772958; 
 Sat, 30 May 2026 16:12:52 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v8 21/41] target/arm: Update ID_AA64SMFR0_EL1 fields to ARM M.b
Date: Sat, 30 May 2026 16:12:09 -0700
Message-ID: <20260530231229.400441-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b220ed3437..3a754f8d61 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -397,17 +397,28 @@ FIELD(ID_AA64ZFR0, F16MM, 48, 4)
 FIELD(ID_AA64ZFR0, F32MM, 52, 4)
 FIELD(ID_AA64ZFR0, F64MM, 56, 4)
 
+FIELD(ID_AA64SMFR0, SMOP4, 0, 1)
+FIELD(ID_AA64SMFR0, STMOP, 16, 1)
+FIELD(ID_AA64SMFR0, SFEXPA, 23, 1)
+FIELD(ID_AA64SMFR0, AES, 24, 1)
+FIELD(ID_AA64SMFR0, SBITPERM, 25, 1)
+FIELD(ID_AA64SMFR0, SF8DP2, 28, 1)
+FIELD(ID_AA64SMFR0, SF8DP4, 29, 1)
+FIELD(ID_AA64SMFR0, SF8FMA, 30, 1)
 FIELD(ID_AA64SMFR0, F32F32, 32, 1)
 FIELD(ID_AA64SMFR0, BI32I32, 33, 1)
 FIELD(ID_AA64SMFR0, B16F32, 34, 1)
 FIELD(ID_AA64SMFR0, F16F32, 35, 1)
 FIELD(ID_AA64SMFR0, I8I32, 36, 4)
+FIELD(ID_AA64SMFR0, F8F32, 40, 1)
+FIELD(ID_AA64SMFR0, F8F16, 41, 1)
 FIELD(ID_AA64SMFR0, F16F16, 42, 1)
 FIELD(ID_AA64SMFR0, B16B16, 43, 1)
 FIELD(ID_AA64SMFR0, I16I32, 44, 4)
 FIELD(ID_AA64SMFR0, F64F64, 48, 1)
 FIELD(ID_AA64SMFR0, I16I64, 52, 4)
 FIELD(ID_AA64SMFR0, SMEVER, 56, 4)
+FIELD(ID_AA64SMFR0, LUTv2, 60, 1)
 FIELD(ID_AA64SMFR0, FA64, 63, 1)
 
 FIELD(ID_AA64FPFR0, F8E5M2, 0, 1)
-- 
2.43.0


