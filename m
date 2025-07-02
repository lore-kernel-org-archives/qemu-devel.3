Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACCAC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwhW-0001YX-1h; Wed, 02 Jul 2025 08:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwg5-0007vU-Of
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:05 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfm-00014M-FX
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:03 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-73af5dc0066so1561537a34.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459684; x=1752064484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DJLNfwuW/Zo+RPNp5mq/l1peWmKK7HstZBP41coj7M=;
 b=WJzLQhXGvPliLbNUTxx3433/k/Iq3nXKg9/xCsDDYG0acUgkX9Ez4skqgd33Ic5fps
 lEERt7CtfK9ulrHKAwwyl6ZpfHs+8VpgmpGYtJJg2WQ4XFjAJ99e/XMA/VK9UKEhmdVD
 XocOE5wkkvgh9jtM6W5nMDlnOnRO/U+Zvxg2TPEPXmE+NctMkcb+6r1PESsiZWK0ETDg
 DFfScE43N4PQfnRsPG3+cWOEQ+oqNuVwV01wS4C443ybhND0DvHrEsUc0+OBROk2DFRq
 KpRMg9LxATOAbddUoe34hoOBZDkuCLp2MAD0H5V9ULsRChfsgZ58CBRvcfionsfailSF
 /BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459684; x=1752064484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DJLNfwuW/Zo+RPNp5mq/l1peWmKK7HstZBP41coj7M=;
 b=fTKHKyPI/gHHD9iY0f+VRPukWWQb1UQ5gHg/ubdT/I4px8+bKaadGWw0vQ37LyrYJz
 xA+zNF8TNSnxVgyBu5DY7yMrLBB36fyrEt4WOzMZmOrh5Rh4BzyxTlkt4tTkZy2JO2CV
 qOca7VyvlfowOQivM+owdIh4RYoxMM01yqQfAhdTabY96Cz26O+W5rg6g+OOW1Z2gCrc
 kGJucij9dc5EoC6ubUUsu3fmu0HhPIz23diJQedHI77Y83AawsjES8Qqi1TUATksgWjY
 F0iWO24wj0NWzY2VTEk7GfLFLesNXEYGAir7DER1FerQJN3mm1OtY/XbuU1x+etdueaC
 qeug==
X-Gm-Message-State: AOJu0YzL7zJDs9HLqUoDRVkp438uAM9kp3zQWoMdvsSS+/Q9JSPSgisz
 rUlCfeim4SDwxpJGIlGx7cRk4WD6qD7L227KPFo0xuPwsispQRgWODpoUDvPt6z61GUl8b0PPCl
 UBkurY6o=
X-Gm-Gg: ASbGncsrD4VXZrqrL7/F0C7l2usJlEqxywJUU8DYQ86YFm2s4dC/ZlDDLOta7UtTz/X
 b1qVF1063eLRSaDTxJ9FeHFD107SLxz470bYEJfzv5yhbF7AHmUV1eemPJHGeeNWTPI/Gi8lGLZ
 ELMP3dexpNB7zBgdVsLLYv/ec79rLvQ/linh8BrY9KqsQ4YWHosXv95mpIkKX9yFO/IWFnQ8MU+
 bs+IuCb4Jv+3cSYZ+Wp3I0/TlVdup92viQtrcVfLa3HIvH8hbNp5uZ5GQIrwcL7V4H1WfPdGDUc
 joHwpYWvuioUfwz94O0eBTXhzAQLxE0BbAmjhxyYMVUgn+J1RGaNY2CZ3ynJb/Hq8fAzNA==
X-Google-Smtp-Source: AGHT+IHMt691dZbZeCRIy+QUzSXYOJiO1mzSzbTJX/l+x10pPNJEr5/ROBvmMSL0Cav1aAnpWrckDA==
X-Received: by 2002:a05:6830:648c:b0:73a:6904:1b46 with SMTP id
 46e09a7af769-73b4ca7b5f7mr2741164a34.8.1751459683926; 
 Wed, 02 Jul 2025 05:34:43 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 25/97] target/arm: Add helper_gvec{_ah}_bfmlsl{_nx}
Date: Wed,  2 Jul 2025 06:32:58 -0600
Message-ID: <20250702123410.761208-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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
 target/arm/tcg/helper.h     |  8 +++++
 target/arm/tcg/vec_helper.c | 58 ++++++++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 8c4705fc53..a05b63380c 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -1095,8 +1095,16 @@ DEF_HELPER_FLAGS_6(gvec_bfmmla, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(gvec_bfmlal, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmlsl, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_ah_bfmlsl, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_bfmlal_idx, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmlsl_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_ah_bfmlsl_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_sclamp_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index f3de26ca54..3ebee97e68 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3186,44 +3186,76 @@ void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_bfmlal)(void *vd, void *vn, void *vm, void *va,
-                         float_status *stat, uint32_t desc)
+static void do_bfmlal(float32 *d, bfloat16 *n, bfloat16 *m, float32 *a,
+                      float_status *stat, uint32_t desc, int negx, int negf)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
-    intptr_t sel = simd_data(desc);
-    float32 *d = vd, *a = va;
-    bfloat16 *n = vn, *m = vm;
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 1);
 
     for (i = 0; i < opr_sz / 4; ++i) {
-        float32 nn = n[H2(i * 2 + sel)] << 16;
+        float32 nn = (negx ^ n[H2(i * 2 + sel)]) << 16;
         float32 mm = m[H2(i * 2 + sel)] << 16;
-        d[H4(i)] = float32_muladd(nn, mm, a[H4(i)], 0, stat);
+        d[H4(i)] = float32_muladd(nn, mm, a[H4(i)], negf, stat);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_bfmlal_idx)(void *vd, void *vn, void *vm,
-                             void *va, float_status *stat, uint32_t desc)
+void HELPER(gvec_bfmlal)(void *vd, void *vn, void *vm, void *va,
+                         float_status *stat, uint32_t desc)
+{
+    do_bfmlal(vd, vn, vm, va, stat, desc, 0, 0);
+}
+
+void HELPER(gvec_bfmlsl)(void *vd, void *vn, void *vm, void *va,
+                         float_status *stat, uint32_t desc)
+{
+    do_bfmlal(vd, vn, vm, va, stat, desc, 0x8000, 0);
+}
+
+void HELPER(gvec_ah_bfmlsl)(void *vd, void *vn, void *vm, void *va,
+                            float_status *stat, uint32_t desc)
+{
+    do_bfmlal(vd, vn, vm, va, stat, desc, 0, float_muladd_negate_product);
+}
+
+static void do_bfmlal_idx(float32 *d, bfloat16 *n, bfloat16 *m, float32 *a,
+                          float_status *stat, uint32_t desc, int negx, int negf)
 {
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 1, 3);
     intptr_t elements = opr_sz / 4;
     intptr_t eltspersegment = MIN(16 / 4, elements);
-    float32 *d = vd, *a = va;
-    bfloat16 *n = vn, *m = vm;
 
     for (i = 0; i < elements; i += eltspersegment) {
         float32 m_idx = m[H2(2 * i + index)] << 16;
 
         for (j = i; j < i + eltspersegment; j++) {
-            float32 n_j = n[H2(2 * j + sel)] << 16;
-            d[H4(j)] = float32_muladd(n_j, m_idx, a[H4(j)], 0, stat);
+            float32 n_j = (negx ^ n[H2(2 * j + sel)]) << 16;
+            d[H4(j)] = float32_muladd(n_j, m_idx, a[H4(j)], negf, stat);
         }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(gvec_bfmlal_idx)(void *vd, void *vn, void *vm, void *va,
+                             float_status *stat, uint32_t desc)
+{
+    do_bfmlal_idx(vd, vn, vm, va, stat, desc, 0, 0);
+}
+
+void HELPER(gvec_bfmlsl_idx)(void *vd, void *vn, void *vm, void *va,
+                             float_status *stat, uint32_t desc)
+{
+    do_bfmlal_idx(vd, vn, vm, va, stat, desc, 0x8000, 0);
+}
+
+void HELPER(gvec_ah_bfmlsl_idx)(void *vd, void *vn, void *vm, void *va,
+                                float_status *stat, uint32_t desc)
+{
+    do_bfmlal_idx(vd, vn, vm, va, stat, desc, 0, float_muladd_negate_product);
+}
+
 #define DO_CLAMP(NAME, TYPE) \
 void HELPER(NAME)(void *d, void *n, void *m, void *a, uint32_t desc)    \
 {                                                                       \
-- 
2.43.0


