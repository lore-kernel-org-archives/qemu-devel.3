Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB10C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82Y-0002ll-8E; Sat, 21 Jun 2025 19:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82L-00025t-2V
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:17 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82J-00051U-2F
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:16 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so1423918b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550054; x=1751154854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TshQtMzubIKcLX+2QrStrz2qiNfNJwibMcbE5aC3YZ8=;
 b=cmN+zWGI1D+o8gnQjEN6QkcZRnPDEL1D8Tj7RQ7Z8alkBESeWk9S3h8FOmmc825tyN
 yvHHEk0+hOlrbgv/3mipXvoGiACXFO7Cpp27w0GXdPrJAOwCbfu4/ZYM3ojZZ2LfB5qB
 lWkAM7KYzSCZ6N8rh2t0ZW9S8VlbKsEo56JbpkV/rYdfS22V86mDc0ZKkto9BB+qqVYh
 +R0D+EZInJQUghUisGJlvIkMX+G2VQLYwMEqfpaOgXiEfQiczsiyDcFp+ck4sVRnR00M
 slWflxR0HT5hXmxJoH2L3/TjTWzZMPnB677pH5wGS5gMsd7JK6ALJv9NiKnNwwa2m0vs
 diVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550054; x=1751154854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TshQtMzubIKcLX+2QrStrz2qiNfNJwibMcbE5aC3YZ8=;
 b=e8eLIhvFMcBJIjiGiDaPyP278D/VG/ydXVI617U1XzgnU57hYFxnq5mHiwAR2/8jPj
 eViPNRNOUECUsLF6Fx2mLGDK3vpmnrJ+9sBXRFjrePzDdR2eELhNUlKEO+W35zU/EJ+j
 gDgYs069uOBEQyX6dDHR8u3q0yzWbl2+9oPnzm1ko/Lf6tmZ7YSUmQbmYSU3EzjcDhAV
 n/xEjq8HVfu0fI9zfXeyEB1eGrhc5Cmi8eY4/CgovaKHSxHCUlS8aw2MkjN00GNRdtf+
 TdYlMRrzYh5ENg9XoqpB5zP6nLv2SwaT0lWmCbPhlCd8EqJk4aGo6h6YO2qq8+VOJrL7
 QUhg==
X-Gm-Message-State: AOJu0YwROeD1UH5ZKSIzrWi/K7HvEQS7h4Y4hXikRykn5FzNgEZcsRV0
 gwE8TY3yyX7libmbQGVhiBfDngwFYFiW0gcR0Pv/RQrQtYYldhu3pc0TFF1/8ubyTlgWl+P8nDz
 erT2Km08=
X-Gm-Gg: ASbGncvYgi2oYxwA5FL7GcVGXg04bajQn7G22Ml+h6sTp+L1bGtN3gwWPvn29ImG4gl
 wCFzGRW6yZN6kegBLQkFb8s78xlARWxGZlsYYYxSf6n2EdAlaSinT78RBgq2NjUPFcNV4h+VvWL
 rCVL+4H+MhkVCcDyispG5Tcc3u6HOmQgqYqf1lp1a7Bcpl3nei/8IcFD9NpgrNxA7uKhaJgtXiK
 /tPQW0jDIkXuzfLWWoV/Yr6PJOMr840WiJpwHg6qG1NzQvSQeoV08jRQBExo8O+GuzU69O/O+b1
 nB1hOOJ7+TZShMxM31ep6KQ2M/iWfHp9MXISEs/iHGl44/o2EH3W/liucZFL/tXKPdyZZ+8WL8d
 1cf5fD2M67MmtldjvPUUE
X-Google-Smtp-Source: AGHT+IFdenYI3bzCcBLkOYeZRNuGMRn/QZsAoT4p6WUtshu9o2GJIrz2xlUP6GF3JdbNnNAezonnTQ==
X-Received: by 2002:a05:6a00:2e21:b0:748:e5a0:aa77 with SMTP id
 d2e1a72fcca58-7490d75fca2mr10438421b3a.13.1750550053613; 
 Sat, 21 Jun 2025 16:54:13 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 054/101] target/arm: Implement SME2 SCVTF, UCVTF
Date: Sat, 21 Jun 2025 16:49:50 -0700
Message-ID: <20250621235037.74091-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 5 +++++
 target/arm/tcg/sme.decode      | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e5694a398d..733b7a0743 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1298,3 +1298,8 @@ TRANS_FEAT(FCVTZS, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_gvec_vcvt_rz_fs)
 TRANS_FEAT(FCVTZU, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_gvec_vcvt_rz_fu)
+
+TRANS_FEAT(SCVTF, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_gvec_vcvt_sf)
+TRANS_FEAT(UCVTF, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_gvec_vcvt_uf)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index bb985f6f61..e2d3668567 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -745,3 +745,8 @@ FCVTZS          11000001 001 00001 111000 ....0 ....0       @zz_2x2
 FCVTZS          11000001 001 10001 111000 ...00 ...00       @zz_4x4
 FCVTZU          11000001 001 00001 111000 ....1 ....0       @zz_2x2
 FCVTZU          11000001 001 10001 111000 ...01 ...00       @zz_4x4
+
+SCVTF           11000001 001 00010 111000 ....0 ....0       @zz_2x2
+SCVTF           11000001 001 10010 111000 ...00 ...00       @zz_4x4
+UCVTF           11000001 001 00010 111000 ....1 ....0       @zz_2x2
+UCVTF           11000001 001 10010 111000 ...01 ...00       @zz_4x4
-- 
2.43.0


