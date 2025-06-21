Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1EDC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zJ-0005F4-3s; Sat, 21 Jun 2025 19:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zG-0005Dk-Tp
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:06 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zF-0004Xd-9b
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:06 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so1423464b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549864; x=1751154664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OvcNqZpqGH9XBaDHJ1dDa8sDaz4RcHNr3cOyPAB5POA=;
 b=MgItRfGsQ3cB9rRIU0NLnusrj1KByuWqjjOobViY22p1afgHYXcJwtJuHnIoVZsDEq
 W0VQ+87Wo6qMiTWaGTKbpqa+HAkqCB+KT8blL9tn47LZ6Y6CW+zdjZC26gRBZCPK8zdw
 30/UKEE935P6/cQSCdFoPCCNR6+xftGq0X9HDO9mswDT+E9J2s7ewno+N/GIOAiVo6lv
 S4TGKFyPs/J2KAf1XRGTWx41h9LX/+bXBOKlLFLSyFP6wju65L8oOiI0VrHJQz/03SCR
 cR/QOawS9i3c5VLWxVwyRvs48bI1hfpComfUPpMzjYbbDa11URVj3RevwLLFACAATAis
 gLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549864; x=1751154664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OvcNqZpqGH9XBaDHJ1dDa8sDaz4RcHNr3cOyPAB5POA=;
 b=pYb4V0QDvUt7v944KYuF4+zUBBREQJv4+/hA3rC2l9nPdqWGDqqXE0V2wLJwwbLk9Z
 xbNU4X9WDQDAetV1ZSECG70XyQhO8LxXflbr3HkE2DG+2KgPHeDz99NWCEjjncBu0mWT
 CeqkdWaPDbQl3yNQPpMLH529kRx5Z9xWonSvTFo4ysctkhrN9Vm8YaRM9Jd0GCufULwJ
 Bnnu+XWVM/1USxTvc5hMSUp+cB6W2oI94h62ev//+rt1wDv6OWcgHSuk9VuaO/btbAj9
 C6SiAbEQEPQJyamlU+y7LXHGookGlZDOAgM0mOR0OLoEZfVixWd3vv6p5YIwQTOmqOiM
 U+cA==
X-Gm-Message-State: AOJu0YzjDGZvQwYg+CMVBdcPclzvub9am1E8PX5Edm1uWrxJefBXhPgO
 33wFq/QiebQeQmlD/KzGzdAjbNEhMADAr5MPULtucDplxFXiymcOXLx2c2OihYIpYYBJf77BXEU
 s16YJ
X-Gm-Gg: ASbGncvffdf42Pxz3Nj802fnYWJxdW8lIzOlq2dMjDoxN04KGBU7ReVOWXN5P4DFoXK
 8DA0d2t78HDMqMBcTaTaXuum4uAjqDmw31C0fIqwnSvxL9Io8gAQ628vrWnQx2aNSoaXDnSYPf0
 oIB2fcw45GIOLS35ys2F32DkQkdZGRHYOaOASZG74woT2ZgxOppQInU/uLZ05MI4Rx6Xf/WObqI
 fyWRmOjPmYce8nedhawu/zMhgPb0t3rQ7Sc7YtpPt5jSDvtpsGr8g+dA0M1t4Upg43OG+5SIGb+
 fGwcTjZKd/gf9KzFoidyi9A6Bg6i9M165Pke/bDCN2qhnc6JWj52OJw+c3H5rzh1B1olWhizrzR
 hMusOi2lQ0gdHIamjSKtNgqGqpMF5ulc=
X-Google-Smtp-Source: AGHT+IEsMfapM02t77QGOArZ3x/d5nvvqrVwC5WFZ5eNfyHQNywRKn5pYlI4OlpI3UfXx/A9Qj8aEw==
X-Received: by 2002:a05:6a21:511:b0:21f:86f1:e2dd with SMTP id
 adf61e73a8af0-22026e92d01mr10842986637.11.1750549863978; 
 Sat, 21 Jun 2025 16:51:03 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.51.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:51:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 039/101] target/arm: Remove helper_gvec_sudot_idx_4b
Date: Sat, 21 Jun 2025 16:49:35 -0700
Message-ID: <20250621235037.74091-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Add gen_helper_gvec_sudot_idx_4b as an expander which
swaps arguments and uses helper_gvec_usdot_idx_4b.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper.h     | 2 --
 target/arm/tcg/translate.h  | 3 +++
 target/arm/tcg/gengvec.c    | 6 ++++++
 target/arm/tcg/vec_helper.c | 1 -
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index c459eba079..2702627eab 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -622,8 +622,6 @@ DEF_HELPER_FLAGS_5(gvec_sdot_idx_4h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_udot_idx_4h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sudot_idx_4b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_usdot_idx_4b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 8cf6324e2f..90a03a4642 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -627,6 +627,9 @@ void gen_gvec_urecpe(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_ursqrte(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                       uint32_t opr_sz, uint32_t max_sz);
 
+void gen_helper_gvec_sudot_idx_4b(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
+                                  TCGv_ptr a, TCGv_i32 desc);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 01867f8ace..c182e5ab6f 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -23,6 +23,12 @@
 #include "translate.h"
 
 
+void gen_helper_gvec_sudot_idx_4b(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
+                                  TCGv_ptr a, TCGv_i32 desc)
+{
+    gen_helper_gvec_usdot_idx_4b(d, m, n, a, desc);
+}
+
 static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
                             uint32_t opr_sz, uint32_t max_sz,
                             gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 8beace8147..7904159d57 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -867,7 +867,6 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
 
 DO_DOT_IDX(gvec_sdot_idx_4b, int32_t, int8_t, int8_t, H4)
 DO_DOT_IDX(gvec_udot_idx_4b, uint32_t, uint8_t, uint8_t, H4)
-DO_DOT_IDX(gvec_sudot_idx_4b, int32_t, int8_t, uint8_t, H4)
 DO_DOT_IDX(gvec_usdot_idx_4b, int32_t, uint8_t, int8_t, H4)
 DO_DOT_IDX(gvec_sdot_idx_4h, int64_t, int16_t, int16_t, H8)
 DO_DOT_IDX(gvec_udot_idx_4h, uint64_t, uint16_t, uint16_t, H8)
-- 
2.43.0


