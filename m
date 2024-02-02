Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03D3C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWV-0006fB-8h; Fri, 02 Feb 2024 00:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWT-0006Ul-FK
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:33 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWR-00033O-WE
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:33 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d928a8dee8so19872575ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853330; x=1707458130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OishrheNzxUH4jK3pSUw3hY8ZUKqc85FNfgHLzLsYl4=;
 b=P4ozukAlmYLdMOPes77Ewylm0avBOR9eWTNgU1nFPt23BWiaWboXvJy1jFCYPdqWXR
 RRj6y1GUqbKaxggW63cbL4M+ikEMxjD/+KYEHiJn+dl01cIzcMSiYGaKy2je5jCvAolk
 Wo+1y2StXreW1U/gZ8jorFmvgtrx5dL9ImfqWKLjeojp6kxq6kx4bfxUOtObRvJzV179
 NagP89RDnILbQDm1bvHnSO90WXlFbvSfHIGoCetx1UQQUi536ACkXzKqJQWtJvFB/H1Y
 Qr7Je70HY/w6m3Z73nND1zzh0QcKqVxJoJ7aXz4hxG1m3YqgmhYt+4JF+VQb5tqNnc3z
 /3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853330; x=1707458130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OishrheNzxUH4jK3pSUw3hY8ZUKqc85FNfgHLzLsYl4=;
 b=Me9+OJL0bq1Sy4Nb6WmHX9J+cHG20ukSCFWGob9ITF5SfF2gjEdO2iYRiqmtsbh1gC
 hhHTU7JWuhP70oCfpBissGo9jmKte3gsrz9+ow0imBJWT0+1nzyMib1uzjzLcvQZyyh8
 Ow8gxZ75pMxIsxl8nsSNNPihbLrglBkSDelN8Uu77gwxNFSrvvF0ShS7C3TmQLQh663x
 yZRCNHG72H5fucrE5roYkbR73qhb8D+zP4iMA+8aKhiPzMTF4Dxqz4NmaYf0OheKcZpW
 hI1VCWCUkxTPiU97qPDD3cXsTK2Nn85/dUGkhZvPOr74HOuCJKmrEVB1L7MDzqepVh5r
 4UZA==
X-Gm-Message-State: AOJu0YxDxFj96EFgJ6g7cT7ZYCwFZzRBqE7ZjwHVLRilamv0H2RreWnO
 U2VQVtaCg+nC83eUzfkI3/IFSJloB5ljTQxUZSA4O0h/K6+dpQE5/iXq+dOwYUiS4bpEiImmPsM
 DVl0=
X-Google-Smtp-Source: AGHT+IE/nMmbl8LDWlJATjAVfRXSt5MM2ZeKcTPUNLXYukXCC8R6o7EKrCjZbijj1mhrrhNqbvaaWw==
X-Received: by 2002:a17:902:e5d1:b0:1d9:2e9d:8cb6 with SMTP id
 u17-20020a170902e5d100b001d92e9d8cb6mr2004344plf.15.1706853330679; 
 Thu, 01 Feb 2024 21:55:30 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 49/57] target/sparc: Remove qt0, qt1 temporaries
Date: Fri,  2 Feb 2024 15:50:28 +1000
Message-Id: <20240202055036.684176-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These are no longer used for passing data to/from helpers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-15-richard.henderson@linaro.org>
---
 target/sparc/cpu.h         | 2 --
 target/sparc/fop_helper.c  | 3 ---
 target/sparc/ldst_helper.c | 3 ---
 3 files changed, 8 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 1e076f6355..75c46e2736 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -509,8 +509,6 @@ struct CPUArchState {
     uint64_t mmubpregs[4];
     uint64_t prom_addr;
 #endif
-    /* temporary float registers */
-    float128 qt0, qt1;
     float_status fp_status;
 #if defined(TARGET_SPARC64)
 #define MAXTL_MAX 8
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index cd9b212597..7353a61237 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -23,9 +23,6 @@
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
-#define QT0 (env->qt0)
-#define QT1 (env->qt1)
-
 static inline float128 f128_in(Int128 i)
 {
     union {
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 52aa6c631b..1ecd58e8ff 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -66,9 +66,6 @@
 #endif
 #endif
 
-#define QT0 (env->qt0)
-#define QT1 (env->qt1)
-
 #if defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
 /* Calculates TSB pointer value for fault page size
  * UltraSPARC IIi has fixed sizes (8k or 64k) for the page pointers
-- 
2.34.1


