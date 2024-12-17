Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762BDE77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEp-0007wR-OE; Tue, 17 Dec 2024 12:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEm-0007v1-N4
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:01 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEd-0006Az-Ku
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:00 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso60588505e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455987; x=1735060787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=77aXHSIuleHA43ssF3ea5OLmxRHAz2bF/UN/XmHqPaQ=;
 b=SOlgNap5Oq2IepWR/1wu0PBtu1NMS9Lgy+2Og62hUcLOLKA9zoT4H4IMnujXcPzdcx
 7vjdkqdi6L9d6Lckcf6YSweVzOCmRK/1KfB0SAvQrZWhHepSoabvq6nVclYOZMX2i493
 zEhfNi8xSUr8w32nejHg6ERcO2CAxstWWLmFvhXeLfyMgzGCpXKWQ4sTDcYqdv2H4dw8
 QxEf1zdRIZDKsb+E84wEUhJ/KfJXLP1ymSWcTCCqNaGwMqQLysVAe/WmQY61NorMEvBh
 0zxGvj2BmdOFN3n6rKx1ITwpU1EFJxteu/bUrXM9/Z7TO+9Rxvkekz0P01cbp0HctChJ
 c9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455987; x=1735060787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77aXHSIuleHA43ssF3ea5OLmxRHAz2bF/UN/XmHqPaQ=;
 b=UvRYmK6uXMJ04qEZFSsYL8uixrh1lfwP1ADsmdfEgRXV43w3sLNJAWtinf/yu8HDWy
 U+nZ+tfWRyV+H1ZVqnpFLnlrJ49IMkxpXp9oet6qJh+7mXrV/NdTYEMvZ8cEr7GMWmvp
 cTpQWMIu0913Ab89D9wRiStkoXNjwPF2krjeERJJcbgL4pZi+ptJvnsB8foeJCZoCB00
 3X17Sxfl9QJ6aaTaflesYxw8jSYgPhbZcwY7OgCLhpYwXXEGpf1OzkZKnjGuoOfbGBgp
 QZrwAubjVyNHa3yMYsp6m4QLD3Bwe+ANOyTOVZeD4rxYwwtESrnXSytzInoCsQ2b8Dg+
 QgJw==
X-Gm-Message-State: AOJu0YwEpPjCpKM2pvbddPbDcXQOESX4bA8ujkoGG6qhxKqdO+dU7lGt
 rcDL7DuJ2Ym/jqmq79Rng27RVntcXaECfKvJdVDYiPEZYp5UbziXxIs1IIQrmBJyMkBXufhwM76
 D
X-Gm-Gg: ASbGncujTTCSbnB0kDZQPd1Z5eZD7AXS9j4n25DacnM9Q4EnCyKh0zoaWyiQhb4qNVN
 SZ+6Qw8K0jquh0t/OHn4Cv5sUKdppJiWT8CU4r9F28VbpXObMQ5CzXB12Evb3wzb7g63LNTZXyF
 Ia79Xe61jAVIBlXvSt3KN49aS4CDglQbN5ilPdiAQSu/8ukAxcXB2Xbz0PXJBfdSYmtoKZ99Fye
 Os9uTJx/u9Qy/u7oDCisVDwfSRJ+VZTom72zGEOqhPaZQ0bDJo7YPM49GSprOI=
X-Google-Smtp-Source: AGHT+IHeInFNf90+YBH5mrrokQnf9dTYEFeFCWZnkI9IurvyOYHeceK7PkAmEG8c5guS1aPPqRyVmg==
X-Received: by 2002:a05:600c:cc9:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-4362aa27edbmr189989425e9.10.1734455986439; 
 Tue, 17 Dec 2024 09:19:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/19] target/arm: Convert sve_helper.c to fpst alias
Date: Tue, 17 Dec 2024 17:19:24 +0000
Message-Id: <20241217171937.3899947-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241206031224.78525-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h | 414 ++++++++++++++++++------------------
 target/arm/tcg/sve_helper.c |  96 +++++----
 2 files changed, 258 insertions(+), 252 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 1fdfb84d4ca..fea43b319c3 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -973,419 +973,419 @@ DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_4(sve_faddv_h, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_faddv_s, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_faddv_d, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_4(sve_fmaxnmv_h, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_fmaxnmv_s, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_fmaxnmv_d, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_4(sve_fminnmv_h, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_fminnmv_s, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_fminnmv_d, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_4(sve_fmaxv_h, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_fmaxv_s, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_fmaxv_d, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_4(sve_fminv_h, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_fminv_s, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_fminv_d, TCG_CALL_NO_RWG,
-                   i64, ptr, ptr, ptr, i32)
+                   i64, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_fadda_h, TCG_CALL_NO_RWG,
-                   i64, i64, ptr, ptr, ptr, i32)
+                   i64, i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fadda_s, TCG_CALL_NO_RWG,
-                   i64, i64, ptr, ptr, ptr, i32)
+                   i64, i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fadda_d, TCG_CALL_NO_RWG,
-                   i64, i64, ptr, ptr, ptr, i32)
+                   i64, i64, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_fcmge0_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcmge0_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcmge0_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_fcmgt0_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcmgt0_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcmgt0_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_fcmlt0_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcmlt0_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcmlt0_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_fcmle0_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcmle0_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcmle0_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_fcmeq0_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcmeq0_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcmeq0_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_fcmne0_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcmne0_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcmne0_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fadd_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fadd_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fadd_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fsub_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fsub_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fsub_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fmul_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmul_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmul_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fdiv_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fdiv_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fdiv_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fmin_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmin_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmin_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fmax_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmax_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmax_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fminnum_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fminnum_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fminnum_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fmaxnum_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmaxnum_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmaxnum_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fabd_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fabd_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fabd_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fscalbn_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fscalbn_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fscalbn_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fmulx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmulx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmulx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fadds_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fadds_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fadds_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fsubs_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fsubs_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fsubs_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fmuls_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmuls_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmuls_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fsubrs_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fsubrs_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fsubrs_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fmaxnms_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmaxnms_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmaxnms_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fminnms_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fminnms_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fminnms_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fmaxs_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmaxs_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmaxs_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fmins_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmins_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fmins_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i64, ptr, i32)
+                   void, ptr, ptr, ptr, i64, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_fcvt_sh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvt_dh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvt_hs, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvt_ds, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvt_hd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvt_sd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_bfcvt, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_fcvtzs_hh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvtzs_hs, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvtzs_ss, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvtzs_ds, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvtzs_hd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvtzs_sd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvtzs_dd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_fcvtzu_hh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvtzu_hs, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvtzu_ss, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvtzu_ds, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvtzu_hd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvtzu_sd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvtzu_dd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_frint_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_frint_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_frint_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_frintx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_frintx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_frintx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_frecpx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_frecpx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_frecpx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_fsqrt_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fsqrt_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fsqrt_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_scvt_hh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_scvt_sh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_scvt_dh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_scvt_ss, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_scvt_sd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_scvt_ds, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_scvt_dd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve_ucvt_hh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_ucvt_sh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_ucvt_dh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_ucvt_ss, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_ucvt_sd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_ucvt_ds, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_ucvt_dd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fcmge_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fcmge_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fcmge_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fcmgt_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fcmgt_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fcmgt_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fcmeq_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fcmeq_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fcmeq_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fcmne_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fcmne_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fcmne_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fcmuo_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fcmuo_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fcmuo_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_facge_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_facge_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_facge_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_facgt_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_facgt_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_facgt_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve_fcadd_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fcadd_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fcadd_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(sve_ftmad_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve_ftmad_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve_ftmad_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_ftmad_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve_ftmad_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve_ftmad_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_4(sve2_saddl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_saddl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -2582,39 +2582,39 @@ DEF_HELPER_FLAGS_4(sve2_xar_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_xar_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve2_fmaxnmp_zpzz_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve2_fmaxnmp_zpzz_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve2_fmaxnmp_zpzz_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve2_fminnmp_zpzz_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve2_fminnmp_zpzz_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve2_fminnmp_zpzz_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve2_fmaxp_zpzz_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve2_fmaxp_zpzz_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve2_fmaxp_zpzz_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sve2_fminp_zpzz_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve2_fminp_zpzz_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve2_fminp_zpzz_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve2_eor3, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_bcax, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
@@ -2682,8 +2682,8 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve2_sqrdmlah_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
@@ -2755,20 +2755,20 @@ DEF_HELPER_FLAGS_5(sve2_cdot_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(sve2_fcvtnt_sh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve2_fcvtnt_ds, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_bfcvtnt, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(sve2_fcvtlt_hs, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve2_fcvtlt_sd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(flogb_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(flogb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(flogb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(flogb_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(flogb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(flogb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 904296705c6..85fe3cae3ed 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -730,7 +730,7 @@ DO_ZPZZ_PAIR_D(sve2_sminp_zpzz_d, int64_t, DO_MIN)
 
 #define DO_ZPZZ_PAIR_FP(NAME, TYPE, H, OP)                              \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg,               \
-                  void *status, uint32_t desc)                          \
+                  float_status *status, uint32_t desc)                  \
 {                                                                       \
     intptr_t i, opr_sz = simd_oprsz(desc);                              \
     for (i = 0; i < opr_sz; ) {                                         \
@@ -4190,7 +4190,7 @@ static TYPE NAME##_reduce(TYPE *data, float_status *status, uintptr_t n) \
         return TYPE##_##FUNC(lo, hi, status);                         \
     }                                                                 \
 }                                                                     \
-uint64_t HELPER(NAME)(void *vn, void *vg, void *vs, uint32_t desc)    \
+uint64_t HELPER(NAME)(void *vn, void *vg, float_status *s, uint32_t desc) \
 {                                                                     \
     uintptr_t i, oprsz = simd_oprsz(desc), maxsz = simd_data(desc);   \
     TYPE data[sizeof(ARMVectorReg) / sizeof(TYPE)];                   \
@@ -4205,7 +4205,7 @@ uint64_t HELPER(NAME)(void *vn, void *vg, void *vs, uint32_t desc)    \
     for (; i < maxsz; i += sizeof(TYPE)) {                            \
         *(TYPE *)((void *)data + i) = IDENT;                          \
     }                                                                 \
-    return NAME##_reduce(data, vs, maxsz / sizeof(TYPE));             \
+    return NAME##_reduce(data, s, maxsz / sizeof(TYPE));              \
 }
 
 DO_REDUCE(sve_faddv_h, float16, H1_2, add, float16_zero)
@@ -4232,7 +4232,7 @@ DO_REDUCE(sve_fmaxv_d, float64, H1_8, max, float64_chs(float64_infinity))
 #undef DO_REDUCE
 
 uint64_t HELPER(sve_fadda_h)(uint64_t nn, void *vm, void *vg,
-                             void *status, uint32_t desc)
+                             float_status *status, uint32_t desc)
 {
     intptr_t i = 0, opr_sz = simd_oprsz(desc);
     float16 result = nn;
@@ -4252,7 +4252,7 @@ uint64_t HELPER(sve_fadda_h)(uint64_t nn, void *vm, void *vg,
 }
 
 uint64_t HELPER(sve_fadda_s)(uint64_t nn, void *vm, void *vg,
-                             void *status, uint32_t desc)
+                             float_status *status, uint32_t desc)
 {
     intptr_t i = 0, opr_sz = simd_oprsz(desc);
     float32 result = nn;
@@ -4272,7 +4272,7 @@ uint64_t HELPER(sve_fadda_s)(uint64_t nn, void *vm, void *vg,
 }
 
 uint64_t HELPER(sve_fadda_d)(uint64_t nn, void *vm, void *vg,
-                             void *status, uint32_t desc)
+                             float_status *status, uint32_t desc)
 {
     intptr_t i = 0, opr_sz = simd_oprsz(desc) / 8;
     uint64_t *m = vm;
@@ -4292,7 +4292,7 @@ uint64_t HELPER(sve_fadda_d)(uint64_t nn, void *vm, void *vg,
  */
 #define DO_ZPZZ_FP(NAME, TYPE, H, OP)                           \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg,       \
-                  void *status, uint32_t desc)                  \
+                  float_status *status, uint32_t desc)          \
 {                                                               \
     intptr_t i = simd_oprsz(desc);                              \
     uint64_t *g = vg;                                           \
@@ -4381,7 +4381,7 @@ DO_ZPZZ_FP(sve_fmulx_d, uint64_t, H1_8, helper_vfp_mulxd)
  */
 #define DO_ZPZS_FP(NAME, TYPE, H, OP) \
 void HELPER(NAME)(void *vd, void *vn, void *vg, uint64_t scalar,  \
-                  void *status, uint32_t desc)                    \
+                  float_status *status, uint32_t desc)            \
 {                                                                 \
     intptr_t i = simd_oprsz(desc);                                \
     uint64_t *g = vg;                                             \
@@ -4449,7 +4449,8 @@ DO_ZPZS_FP(sve_fmins_d, float64, H1_8, float64_min)
  * With the extra float_status parameter.
  */
 #define DO_ZPZ_FP(NAME, TYPE, H, OP)                                  \
-void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc) \
+void HELPER(NAME)(void *vd, void *vn, void *vg,                       \
+                  float_status *status, uint32_t desc)                \
 {                                                                     \
     intptr_t i = simd_oprsz(desc);                                    \
     uint64_t *g = vg;                                                 \
@@ -4756,25 +4757,25 @@ static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
 }
 
 void HELPER(sve_fmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
-                              void *vg, void *status, uint32_t desc)
+                              void *vg, float_status *status, uint32_t desc)
 {
     do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0);
 }
 
 void HELPER(sve_fmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
-                              void *vg, void *status, uint32_t desc)
+                              void *vg, float_status *status, uint32_t desc)
 {
     do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0);
 }
 
 void HELPER(sve_fnmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
-                               void *vg, void *status, uint32_t desc)
+                               void *vg, float_status *status, uint32_t desc)
 {
     do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000);
 }
 
 void HELPER(sve_fnmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
-                               void *vg, void *status, uint32_t desc)
+                               void *vg, float_status *status, uint32_t desc)
 {
     do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000);
 }
@@ -4804,25 +4805,25 @@ static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
 }
 
 void HELPER(sve_fmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
-                              void *vg, void *status, uint32_t desc)
+                              void *vg, float_status *status, uint32_t desc)
 {
     do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0);
 }
 
 void HELPER(sve_fmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
-                              void *vg, void *status, uint32_t desc)
+                              void *vg, float_status *status, uint32_t desc)
 {
     do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0);
 }
 
 void HELPER(sve_fnmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
-                               void *vg, void *status, uint32_t desc)
+                               void *vg, float_status *status, uint32_t desc)
 {
     do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000);
 }
 
 void HELPER(sve_fnmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
-                               void *vg, void *status, uint32_t desc)
+                               void *vg, float_status *status, uint32_t desc)
 {
     do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000);
 }
@@ -4852,25 +4853,25 @@ static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
 }
 
 void HELPER(sve_fmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
-                              void *vg, void *status, uint32_t desc)
+                              void *vg, float_status *status, uint32_t desc)
 {
     do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0);
 }
 
 void HELPER(sve_fmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
-                              void *vg, void *status, uint32_t desc)
+                              void *vg, float_status *status, uint32_t desc)
 {
     do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0);
 }
 
 void HELPER(sve_fnmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
-                               void *vg, void *status, uint32_t desc)
+                               void *vg, float_status *status, uint32_t desc)
 {
     do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN);
 }
 
 void HELPER(sve_fnmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
-                               void *vg, void *status, uint32_t desc)
+                               void *vg, float_status *status, uint32_t desc)
 {
     do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN);
 }
@@ -4882,7 +4883,7 @@ void HELPER(sve_fnmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
  */
 #define DO_FPCMP_PPZZ(NAME, TYPE, H, OP)                                \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg,               \
-                  void *status, uint32_t desc)                          \
+                  float_status *status, uint32_t desc)                  \
 {                                                                       \
     intptr_t i = simd_oprsz(desc), j = (i - 1) >> 6;                    \
     uint64_t *d = vd, *g = vg;                                          \
@@ -4944,7 +4945,7 @@ DO_FPCMP_PPZZ_ALL(sve_facgt, DO_FACGT)
  */
 #define DO_FPCMP_PPZ0(NAME, TYPE, H, OP)                   \
 void HELPER(NAME)(void *vd, void *vn, void *vg,            \
-                  void *status, uint32_t desc)             \
+                  float_status *status, uint32_t desc)     \
 {                                                          \
     intptr_t i = simd_oprsz(desc), j = (i - 1) >> 6;       \
     uint64_t *d = vd, *g = vg;                             \
@@ -4982,7 +4983,8 @@ DO_FPCMP_PPZ0_ALL(sve_fcmne0, DO_FCMNE)
 
 /* FP Trig Multiply-Add. */
 
-void HELPER(sve_ftmad_h)(void *vd, void *vn, void *vm, void *vs, uint32_t desc)
+void HELPER(sve_ftmad_h)(void *vd, void *vn, void *vm,
+                         float_status *s, uint32_t desc)
 {
     static const float16 coeff[16] = {
         0x3c00, 0xb155, 0x2030, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
@@ -4998,11 +5000,12 @@ void HELPER(sve_ftmad_h)(void *vd, void *vn, void *vm, void *vs, uint32_t desc)
             mm = float16_abs(mm);
             xx += 8;
         }
-        d[i] = float16_muladd(n[i], mm, coeff[xx], 0, vs);
+        d[i] = float16_muladd(n[i], mm, coeff[xx], 0, s);
     }
 }
 
-void HELPER(sve_ftmad_s)(void *vd, void *vn, void *vm, void *vs, uint32_t desc)
+void HELPER(sve_ftmad_s)(void *vd, void *vn, void *vm,
+                         float_status *s, uint32_t desc)
 {
     static const float32 coeff[16] = {
         0x3f800000, 0xbe2aaaab, 0x3c088886, 0xb95008b9,
@@ -5020,11 +5023,12 @@ void HELPER(sve_ftmad_s)(void *vd, void *vn, void *vm, void *vs, uint32_t desc)
             mm = float32_abs(mm);
             xx += 8;
         }
-        d[i] = float32_muladd(n[i], mm, coeff[xx], 0, vs);
+        d[i] = float32_muladd(n[i], mm, coeff[xx], 0, s);
     }
 }
 
-void HELPER(sve_ftmad_d)(void *vd, void *vn, void *vm, void *vs, uint32_t desc)
+void HELPER(sve_ftmad_d)(void *vd, void *vn, void *vm,
+                         float_status *s, uint32_t desc)
 {
     static const float64 coeff[16] = {
         0x3ff0000000000000ull, 0xbfc5555555555543ull,
@@ -5046,7 +5050,7 @@ void HELPER(sve_ftmad_d)(void *vd, void *vn, void *vm, void *vs, uint32_t desc)
             mm = float64_abs(mm);
             xx += 8;
         }
-        d[i] = float64_muladd(n[i], mm, coeff[xx], 0, vs);
+        d[i] = float64_muladd(n[i], mm, coeff[xx], 0, s);
     }
 }
 
@@ -5055,7 +5059,7 @@ void HELPER(sve_ftmad_d)(void *vd, void *vn, void *vm, void *vs, uint32_t desc)
  */
 
 void HELPER(sve_fcadd_h)(void *vd, void *vn, void *vm, void *vg,
-                         void *vs, uint32_t desc)
+                         float_status *s, uint32_t desc)
 {
     intptr_t j, i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -5077,17 +5081,17 @@ void HELPER(sve_fcadd_h)(void *vd, void *vn, void *vm, void *vg,
             e3 = *(float16 *)(vm + H1_2(i)) ^ neg_imag;
 
             if (likely((pg >> (i & 63)) & 1)) {
-                *(float16 *)(vd + H1_2(i)) = float16_add(e0, e1, vs);
+                *(float16 *)(vd + H1_2(i)) = float16_add(e0, e1, s);
             }
             if (likely((pg >> (j & 63)) & 1)) {
-                *(float16 *)(vd + H1_2(j)) = float16_add(e2, e3, vs);
+                *(float16 *)(vd + H1_2(j)) = float16_add(e2, e3, s);
             }
         } while (i & 63);
     } while (i != 0);
 }
 
 void HELPER(sve_fcadd_s)(void *vd, void *vn, void *vm, void *vg,
-                         void *vs, uint32_t desc)
+                         float_status *s, uint32_t desc)
 {
     intptr_t j, i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -5109,17 +5113,17 @@ void HELPER(sve_fcadd_s)(void *vd, void *vn, void *vm, void *vg,
             e3 = *(float32 *)(vm + H1_2(i)) ^ neg_imag;
 
             if (likely((pg >> (i & 63)) & 1)) {
-                *(float32 *)(vd + H1_2(i)) = float32_add(e0, e1, vs);
+                *(float32 *)(vd + H1_2(i)) = float32_add(e0, e1, s);
             }
             if (likely((pg >> (j & 63)) & 1)) {
-                *(float32 *)(vd + H1_2(j)) = float32_add(e2, e3, vs);
+                *(float32 *)(vd + H1_2(j)) = float32_add(e2, e3, s);
             }
         } while (i & 63);
     } while (i != 0);
 }
 
 void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
-                         void *vs, uint32_t desc)
+                         float_status *s, uint32_t desc)
 {
     intptr_t j, i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -5141,10 +5145,10 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
             e3 = *(float64 *)(vm + H1_2(i)) ^ neg_imag;
 
             if (likely((pg >> (i & 63)) & 1)) {
-                *(float64 *)(vd + H1_2(i)) = float64_add(e0, e1, vs);
+                *(float64 *)(vd + H1_2(i)) = float64_add(e0, e1, s);
             }
             if (likely((pg >> (j & 63)) & 1)) {
-                *(float64 *)(vd + H1_2(j)) = float64_add(e2, e3, vs);
+                *(float64 *)(vd + H1_2(j)) = float64_add(e2, e3, s);
             }
         } while (i & 63);
     } while (i != 0);
@@ -5155,7 +5159,7 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
  */
 
 void HELPER(sve_fcmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
-                               void *vg, void *status, uint32_t desc)
+                               void *vg, float_status *status, uint32_t desc)
 {
     intptr_t j, i = simd_oprsz(desc);
     unsigned rot = simd_data(desc);
@@ -5200,7 +5204,7 @@ void HELPER(sve_fcmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
 }
 
 void HELPER(sve_fcmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
-                               void *vg, void *status, uint32_t desc)
+                               void *vg, float_status *status, uint32_t desc)
 {
     intptr_t j, i = simd_oprsz(desc);
     unsigned rot = simd_data(desc);
@@ -5245,7 +5249,7 @@ void HELPER(sve_fcmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
 }
 
 void HELPER(sve_fcmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
-                               void *vg, void *status, uint32_t desc)
+                               void *vg, float_status *status, uint32_t desc)
 {
     intptr_t j, i = simd_oprsz(desc);
     unsigned rot = simd_data(desc);
@@ -7389,7 +7393,7 @@ void HELPER(sve2_xar_s)(void *vd, void *vn, void *vm, uint32_t desc)
 }
 
 void HELPER(fmmla_s)(void *vd, void *vn, void *vm, void *va,
-                     void *status, uint32_t desc)
+                     float_status *status, uint32_t desc)
 {
     intptr_t s, opr_sz = simd_oprsz(desc) / (sizeof(float32) * 4);
 
@@ -7427,7 +7431,7 @@ void HELPER(fmmla_s)(void *vd, void *vn, void *vm, void *va,
 }
 
 void HELPER(fmmla_d)(void *vd, void *vn, void *vm, void *va,
-                     void *status, uint32_t desc)
+                     float_status *status, uint32_t desc)
 {
     intptr_t s, opr_sz = simd_oprsz(desc) / (sizeof(float64) * 4);
 
@@ -7463,7 +7467,8 @@ void HELPER(fmmla_d)(void *vd, void *vn, void *vm, void *va,
 }
 
 #define DO_FCVTNT(NAME, TYPEW, TYPEN, HW, HN, OP)                             \
-void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc)  \
+void HELPER(NAME)(void *vd, void *vn, void *vg,                               \
+                  float_status *status, uint32_t desc)                        \
 {                                                                             \
     intptr_t i = simd_oprsz(desc);                                            \
     uint64_t *g = vg;                                                         \
@@ -7484,7 +7489,8 @@ DO_FCVTNT(sve2_fcvtnt_sh, uint32_t, uint16_t, H1_4, H1_2, sve_f32_to_f16)
 DO_FCVTNT(sve2_fcvtnt_ds, uint64_t, uint32_t, H1_8, H1_4, float64_to_float32)
 
 #define DO_FCVTLT(NAME, TYPEW, TYPEN, HW, HN, OP)                             \
-void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc)  \
+void HELPER(NAME)(void *vd, void *vn, void *vg,                               \
+                  float_status *status, uint32_t desc)                        \
 {                                                                             \
     intptr_t i = simd_oprsz(desc);                                            \
     uint64_t *g = vg;                                                         \
-- 
2.34.1


