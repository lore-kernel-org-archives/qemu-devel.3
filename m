Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9D7FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFAB-0005KT-4M; Mon, 27 Apr 2026 02:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFA8-0005Fl-9B
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:44 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFA6-0000mM-Md
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:44 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35fbca04006so4855517a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777270181; x=1777874981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QzmSXQzvIocyTUqrSl/Yo2kZKcCTxCeTL1AZ3pifw8=;
 b=N++eiavMUnoPacwWTcnAelfL+UsztEoi8uCf+Alo6gjcMbQiiD/g5/Cup+FpZt2T0j
 bI4jXaXvzER0PDK2IWn3SRDeHUtbWj/gG1i5d3FqE8iEExRqd46mbE626Q/wCL4fSuPi
 cyMfCSiOOAWzM12OWB7OENNRKy7prWPXpQWSrvBuuyqsJLuQx8idKGs0CtjwztmJZaCL
 I75WsDeJMiD4lQZC1lgiZjZmREfxv4/9Q88yk3QabvTvt//bNovUimtLApLZs7BEL8A+
 J1FfqamDjDJD2jp4rAoy1A15JDZQtSL6WL7pxc+QKL7KzqwTj2mjUAstGtlcFqEYM1qO
 XU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270181; x=1777874981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2QzmSXQzvIocyTUqrSl/Yo2kZKcCTxCeTL1AZ3pifw8=;
 b=bP35leApJo7UkcX6QZ4uW9iVsc8wCqcirYLZRVnqzo8lL3Ke4lx0IAZPZqElkEx/8Q
 30h7za69utrvZ+ZSqlV8+5NtOiCheKG5ysBUydbK2jdawoFfsqN8c3LO5wqmvBLq0kp8
 dAQze+bn5hbn/DhJ2DVpy69Yht/c9Q8v59bYS5vh3LnvCEtu6bSI0Y0bbi9V3q/UpLRE
 SpoOE6R5aWJyxYY9TEOEpJIKzQOxUIEb4pb+SMq8rsnmmFADAVRnyyUwVyQjPIS4c2DV
 0T9B8Gh0vJaTQQA/V8jX8AtSvCQ0vIeQ40+QQ4YEJlCRcyU3dSXPIhETri2UDP5d39tW
 2iag==
X-Gm-Message-State: AOJu0YxHIGAKH5Gvaw/oYLRxmqVsIa+9FdGrhk4e6fOfsLNP/AS6rW5a
 fxiypGVRncUIboxvspgJAWYmItvDO/z4XyxJv35JnSf+g14qyQKHWdcNkQMULHgE4TuObtvKajd
 acaJ4Je0woVXoQEQAyOIEioU+RazEoBXvkI42xLJ5pZj7BTOeMEWYnN3Cl4e/d+Cm0VbR2E1Yk7
 7YoNFCVImRNhXNlnBDDxjKDDQf6Ox1aPS7aru/IVE=
X-Gm-Gg: AeBDieuwBpPq0VT+9d6y4XG12UQnKmm7YDRQhsUzUCPtKxgWIieBXJq8ZLKeWyrznxB
 x+I9eyF1GhskTCt4VoYMPAUvaXXPkTBdL0SOzVPSRV21akQF0VbvU1c6YaZEPX0GKwGwufXcrMr
 mjGczevhtaLKhm2Yf+01PyA9WcJCuefDBDMV8BbHZtOKQ198QptvQBCXpFrbQqAe+HRjdggNkX7
 M9LSb3V762DHWf2sWRdUqrbfuv4cN6FU0+Q29mBpFVxplpmjsmodsBvU9KqXA3CdWHKFg9JXAPi
 YZyvDSnXFkP4xZ8NKbb4Vf/2kApcH1XEI+cCfZYE7HI8mB7JF2V+eHwieUq3BiMjJMMkg1PIob2
 SSF5DEw4WpZPof1udV44/UGiXpzQRi0NzvidJ4y9j1P4mktJSico8fBX0tYn3VBmYb8r6sM/2OR
 TIEhzBm+L7MVeTeyBg+zSQWShqTiKaPYq/Z32rcodYvQdF5KrD7y/eGMvscYGTfpN8cBpGcDLDt
 vUuO+1XP9e7SEuZqltalpe6XnHuoJaueYkiyw==
X-Received: by 2002:a17:90b:3f47:b0:35b:a7be:ae47 with SMTP id
 98e67ed59e1d1-3614048ee93mr46474407a91.21.1777270181116; 
 Sun, 26 Apr 2026 23:09:41 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bac6dsm30290710a91.14.2026.04.26.23.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:09:40 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 1/9] target/riscv: rvv: Fix NOP_UU_B vs2 width
Date: Mon, 27 Apr 2026 14:09:20 +0800
Message-ID: <20260427060928.2322570-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427060928.2322570-1-max.chou@sifive.com>
References: <20260427060928.2322570-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1036.google.com
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

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 538168efc9..60e2d42301 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4973,7 +4973,7 @@ GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v, 4)
 
 /* Narrowing Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
-#define NOP_UU_B uint8_t,  uint16_t, uint32_t
+#define NOP_UU_B uint8_t,  uint16_t, uint16_t
 #define NOP_UU_H uint16_t, uint32_t, uint32_t
 #define NOP_UU_W uint32_t, uint64_t, uint64_t
 /* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
-- 
2.52.0


