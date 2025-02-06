Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFEEC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg86G-00039A-6G; Thu, 06 Feb 2025 15:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83k-0007ut-8m
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:17 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83e-00019Q-U2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:11 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f9bd7c480eso2412560a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872054; x=1739476854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wW4uG74PqCG7VWx+Us1183tBz6G7qBgoVXgP8+QW23g=;
 b=jboIveYwXOvUMqKFjvttQfSwynD3Znf5XtmRHePUlTTTWtC5TxO0KKF02uO+24irhi
 F8fLg//fnhTXlkfTHA6ZBX11MekmXkvHM+FNndGLk0EcZvwMpiNSnmi5DnQ1OCjz92Xy
 bjurORpXiOoZ+wIPpFQNdFo+To8711t9waeGKM42rqHwMYjmEYLsNCmKZ7Ox0gN2DEyx
 qFW5FG6LgVAx3UsdDk7oqtHpE44MBM3NWtGgKwXElkxE7qB92CHbYixiUNwJGqvw0E2w
 rskdeoZofYaPsbvrS/W2v7x9+wJj3dy02Mkhwg6gd8vetJa+AbSUz+ehHK7velqrWrVM
 N5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872054; x=1739476854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wW4uG74PqCG7VWx+Us1183tBz6G7qBgoVXgP8+QW23g=;
 b=lcGYm3yE62ZqLx3n2QbX9WZ9hZyF0eetlJMzo6I2a0HqYpROOBe5QFPkndVPuXsBE7
 d+P+4dMkT5woC5jeHsQ2gG7+icwHmIyDZc5X2sOb10eZ9zOSr3alFtqNWuRdql9pXrj5
 CxxCvAEW1gJT3X933w1CDocoJu7UxP0MxT/Xf5x5MCbKypL/4GW/ZCCpKyxEGmSukDqJ
 6pPUmV1X4S2IoUABjA2y53f45UUbT8Lwo2yBF49R0Z0lIurhMEawBzTvusOzrIN3GVzB
 i2/+jKIOS69wZoZRaag2+Z+yjZoUAa3DXoxTst3zhULbRiFKDCcLSfhGFafnmmugh8Uf
 Y3EQ==
X-Gm-Message-State: AOJu0Yz7a3hoGzLtDjmQqKird6iyYgdM+7bdB6qx7JEEgLVcRzmdCBtS
 IFp7a1aOMQA43hD5fUc065UsbpYU5fe24fmoec/OSKOZk77bRpB3NP1xMvipuYW6UntX5xIoiNS
 u
X-Gm-Gg: ASbGncvrmwm0Jo77MMEmS/gbH4BMDVhooAocNSDAtUmcjyelS8NDM+UqMY0VcNHPFsb
 QHKDqWsDQjQM6RCEFVTt6mjKFeJT+FTAKG6wDjXtWu8k1RsvIaVHvMoxWgbokUdY/j3JigisbWj
 OeJZ477GYwaSMOzg/5/qntK93qN+q/xyecI9tMywUXdFhcs6r8No6ZFEUZmYJEK6N2XjkIgU7ja
 9WmGDDaQH7hhZpZNuv2YMjULE6eoX7KwNf9gUU8SuUNRTsCdIMvaCVJ0+FeK9sGhl5jTyPJ3P5f
 /wgZj+KjOif5jk9BmY9Efu9Q/IdPl82XNYJC60abYFnHiao=
X-Google-Smtp-Source: AGHT+IHvyxWUCHoBlDK1EpdhI8oluio51OCLHHs/kMpyGekoE6rTQFHen4Pw/w/5CSeUgX79Z0b/qQ==
X-Received: by 2002:a17:90b:48ca:b0:2fa:2124:878f with SMTP id
 98e67ed59e1d1-2fa243eefedmr515989a91.27.1738872053725; 
 Thu, 06 Feb 2025 12:00:53 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 49/61] target/arm: Implement SME2 SCVTF, UCVTF
Date: Thu,  6 Feb 2025 11:57:03 -0800
Message-ID: <20250206195715.2150758-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
index 4b45459e77..a993870812 100644
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


