Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39988E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEk-0007tn-L1; Tue, 17 Dec 2024 12:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEi-0007sM-Nf
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:19:56 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEc-0006B9-6q
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:19:56 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso40547475e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455987; x=1735060787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vrDwAbHNT4Cd7QvVHPbpgZ6d5UYILLlvDeKOUF5Nqdc=;
 b=N/guLylDgTa34HEz/hV5UXrtezGa4ykQwQxnMz0XAcpqF3JprQrtjNjgpE0/hPUsJ8
 rQcCHqN1450ojrvi4KJO2yy5U8+xyIfcRVGZ0woAOfrcx1pNCA7GIR8jTGtpu/g8QPcf
 5x/7KA70INXHHkJkLBrSpOxdmwgVxT6C49fiomV+Jur+NvpqwS8RJcaEFJWAts5wITAQ
 pNCm3/d6dLZEp6hZfAqgh6rQQ9oKEFEeKIydJE7IMFzeSXbgq+rglQC0DRE+TQRTL8pB
 K/B9bwNQ3CaDWt3Ir27iZofwjKjNK/ZfnhBIFMf9Rc92Jd5nx6jjynzTEM1rl/4XossH
 eVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455987; x=1735060787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrDwAbHNT4Cd7QvVHPbpgZ6d5UYILLlvDeKOUF5Nqdc=;
 b=m3XNMMFthKIXrT/CSdwpFAnPdNSVEXSyA4+95avKyluubWQrzGkBbcaAR1avbwXRi3
 dDTONkeD1tV2UCSGIosOv78fHmW8Ye2LmNq0lH2e4nics6XVzR6eaUg4SFyKzxUpPHvz
 LFPcjR7eDq8E9oKBVavB2jYPrpVJnaJvihq+8iwFX3Y8m65AnNqAMkydqgkI+yVqBBHv
 FQX7/TCn4eCWTQWFyI90oZPTeXfr5Gn1xK0h3BIx9hh8Vxzl0iJZr/Pyn7t0xZftlcT+
 HB7GYGmlfbTcSHm0WH7L//qnjZDrNkjuWPOvBjfNurGkJwhgIYYMPs7dpzZLu8dQZewv
 t03g==
X-Gm-Message-State: AOJu0Ywi0RxDINoMB1t8i97ihOFBkLpkKKu/6irhB1RB4OQaUfp5mZxz
 ov9VQwZ2XTjsSKR/YizVuYtEcxOlUG5802Edbk8BWToka/SYGxBpeZmJqxlMcmYaxsYpXfpvhmV
 b
X-Gm-Gg: ASbGncs+4mrjuGI7SQYeUHBsv5oghigYHnFgLd5UHqNW3ezebVdayH7lGmFS6UE2Vkg
 rerBXhFq8v7K6zE/33D3wiCm9K2/nfyQlLMffi0e2HXm+sUrOc6bithYfP5UWjeEGXaQ9B8pPo9
 TSvWkQa6UJ/uHVubBiznUj5PmxjOUSi8XF5GJP97lGB3jT8uYOqoOjkZzddK4QVPUSbJbacGByY
 6RsfqSzHtaPFiCbjwiBEmpWEJh1hB+YvrKjrW0kWIt/BEAxbpBO9wZ30vo+x0g=
X-Google-Smtp-Source: AGHT+IEfmANZ7uDGgG+8AFZb1NTOo0mwZLN/MQqYO1fwWahu9VCmwLNxhLUZRmCrqc6/abf9oBAU/Q==
X-Received: by 2002:a05:6000:4806:b0:385:f38e:c0c3 with SMTP id
 ffacd0b85a97d-388da380bcdmr3884223f8f.6.1734455987359; 
 Tue, 17 Dec 2024 09:19:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/19] target/arm: Convert sme_helper.c to fpst alias
Date: Tue, 17 Dec 2024 17:19:25 +0000
Message-Id: <20241217171937.3899947-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20241206031224.78525-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h | 4 ++--
 target/arm/tcg/sme_helper.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 59ecaa15485..858d69188fb 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -123,9 +123,9 @@ DEF_HELPER_FLAGS_5(sme_addva_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_bfmopa, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sme_smopa_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 8cf12654e56..a0e6b4a41ea 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -904,7 +904,7 @@ void HELPER(sme_addva_d)(void *vzda, void *vzn, void *vpn,
 }
 
 void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, void *vst, uint32_t desc)
+                         void *vpm, float_status *fpst_in, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) << 31;
@@ -916,7 +916,7 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
      * update the cumulative fp exception status.  It also produces
      * default nans.
      */
-    fpst = *(float_status *)vst;
+    fpst = *fpst_in;
     set_default_nan_mode(true, &fpst);
 
     for (row = 0; row < oprsz; ) {
@@ -946,13 +946,13 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
 }
 
 void HELPER(sme_fmopa_d)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, void *vst, uint32_t desc)
+                         void *vpm, float_status *fpst_in, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_oprsz(desc) / 8;
     uint64_t neg = (uint64_t)simd_data(desc) << 63;
     uint64_t *za = vza, *zn = vzn, *zm = vzm;
     uint8_t *pn = vpn, *pm = vpm;
-    float_status fpst = *(float_status *)vst;
+    float_status fpst = *fpst_in;
 
     set_default_nan_mode(true, &fpst);
 
-- 
2.34.1


