Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA4CC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhWS-0007Ez-Me; Fri, 04 Jul 2025 10:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPD-0002Vz-Lq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:52 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhP9-0001Lh-6q
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:47 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2ef891cd058so857847fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639322; x=1752244122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29K9yY7dE+axUAoDft5EA1rREE381pcsMtG+hnxeQIA=;
 b=ke0Xg4Cp1bRGfDElZz3UwVbmSlAXzl3lAtHgry9byob9+R3JLSfgFbJ3GIEkkK9b1U
 iJ7lS3NsccPuQwIqCADNs4oJCuKhxxInR9HeU6cSjB5U0t91SpaPwSWdsARBM+w3Gf96
 olR44XSlkbaFyfuwK3gEQDVXv8lLxjr+sZZMJyzCIc7WTM7s/ZVgvp16S+dbvwiIEdaB
 Vc12oJOMIxw8Y2HGzQqUMTJYLMKxXIIOYuwHTpvhZ+lO6G3f/MHUQHsgvq1wQnbdsgr5
 hfclfRVznaNnp45eCukcx6flvMHbcqkph24qFN0Wsjl935OeJkXuu0q+vk3DDMX7cH2e
 LyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639322; x=1752244122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29K9yY7dE+axUAoDft5EA1rREE381pcsMtG+hnxeQIA=;
 b=JtFIAd2CdNgvAKieabkCdKWOJ1f2XdQs+gRSuy2Z6QKT4uvZuhSkwaFneSoFSThOFi
 Tp6sVEOioLfangt5JYVTEQHfdyhK7OSNrHUuWwKdtOnkKM9IJxGzGZUEBRanp7SCSo63
 cPfHUFBIt221JwZPELg/KkAIZ2yvGWbYQmAVQmQYMDeH9t+RrkORNUuZ1dmAuGgG0eoK
 5A57LhJDaL6sDJBeiDD49ob5MJYJ5YDtD3pOS7jtuSD4k0ip95Z5/UsRWw6ZcFRCF1VX
 9KYiX5pbzy2myRUSDL1eInvYB1xmUdpZ+EOQHVtNqzy7+znVv0X/p9tVmxH1bK6eEiyI
 J/kw==
X-Gm-Message-State: AOJu0YxMxRVKK/QBFo7BdPn+yZlxJUVTfo/O8h+/dE+/wMUWYCw7NfiR
 WjlHUERmzOOqSekUyReJ1NBrAImvxltGhWOZU59eaZmsB7/FpJ/3vnfCRHNhNaEe2eNZwqXXNRI
 LeHMPphk=
X-Gm-Gg: ASbGncsoFlzbPQLsWg2pdQJozVOLfufLNm08D5skoy11ydmMaxXqCZ95zpCBoLN65Tj
 npYopCLOnjRwrmUU1rQU225zRglGMeNNJ4xD4S4MNsl5dfIokNBLtzYMdDb2WKj4BA2w8PWyntV
 fOHR+Sn7JPwmjVHyeX2tvtOrQh/QPTbZRrEr0L+OKdUcj4ONboEKsdLPJXDNCKqmDNe0bV3MIOo
 zE2VAfvAhq5lbJgS7u+8Z7tG/IYJcbHi9cX4n/v+pvUDvbiz+CoCNdnT+SK3zMB6eFyvX6fEdoV
 sLJvkRMnFPOJsncbUWs2Xmv1Tn3NVd+SGbLAPeUKtcZMuwZpHJcZdCkaGYzRtfC/jAUP0si3u+P
 nhnKkLvf9dVGgFXR0luhpmSKOHeJqER4BjWaVOBcfuE2NHU0tBSXvIckLl9M=
X-Google-Smtp-Source: AGHT+IGQjKnnXX8zZZqAm9+/5GrrVe/j/B5oHJA/GRDGXYUd9C994MwzXoULGwmScQ0up+A8vUiQnA==
X-Received: by 2002:a05:6871:547:b0:2bc:7d6f:fa85 with SMTP id
 586e51a60fabf-2f796b2ed9dmr1688806fac.16.1751639321744; 
 Fri, 04 Jul 2025 07:28:41 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 083/108] target/arm: Implement SME2 SEL
Date: Fri,  4 Jul 2025 08:20:46 -0600
Message-ID: <20250704142112.1018902-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |   5 +
 target/arm/tcg/sme_helper.c    | 317 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  31 ++++
 target/arm/tcg/sme.decode      |   9 +
 4 files changed, 362 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 78ba3d1f20..467073ea25 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -313,3 +313,8 @@ DEF_HELPER_FLAGS_5(sme2_fclamp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i3
 DEF_HELPER_FLAGS_5(sme2_fclamp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme2_fclamp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme2_bfclamp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sme2_sel_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
+DEF_HELPER_FLAGS_5(sme2_sel_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
+DEF_HELPER_FLAGS_5(sme2_sel_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
+DEF_HELPER_FLAGS_5(sme2_sel_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 8a1f9fbf3d..c1166e4ffa 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2118,3 +2118,320 @@ FCLAMP(sme2_fclamp_d, float64, H8)
 FCLAMP(sme2_bfclamp, bfloat16, H2)
 
 #undef FCLAMP
+
+void HELPER(sme2_sel_b)(void *vd, void *vn, void *vm,
+                        uint32_t png, uint32_t desc)
+{
+    int vl = simd_oprsz(desc);
+    int nreg = simd_data(desc);
+    int elements = vl / sizeof(uint8_t);
+    DecodeCounter p = decode_counter(png, vl, MO_8);
+
+    if (p.lg2_stride == 0) {
+        if (p.invert) {
+            for (int r = 0; r < nreg; r++) {
+                uint8_t *d = vd + r * sizeof(ARMVectorReg);
+                uint8_t *n = vn + r * sizeof(ARMVectorReg);
+                uint8_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+
+                if (split <= 0) {
+                    memcpy(d, n, vl);  /* all true */
+                } else if (elements <= split) {
+                    memcpy(d, m, vl);  /* all false */
+                } else {
+                    for (int e = 0; e < split; e++) {
+                        d[H1(e)] = m[H1(e)];
+                    }
+                    for (int e = split; e < elements; e++) {
+                        d[H1(e)] = n[H1(e)];
+                    }
+                }
+            }
+        } else {
+            for (int r = 0; r < nreg; r++) {
+                uint8_t *d = vd + r * sizeof(ARMVectorReg);
+                uint8_t *n = vn + r * sizeof(ARMVectorReg);
+                uint8_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+
+                if (split <= 0) {
+                    memcpy(d, m, vl);  /* all false */
+                } else if (elements <= split) {
+                    memcpy(d, n, vl);  /* all true */
+                } else {
+                    for (int e = 0; e < split; e++) {
+                        d[H1(e)] = n[H1(e)];
+                    }
+                    for (int e = split; e < elements; e++) {
+                        d[H1(e)] = m[H1(e)];
+                    }
+                }
+            }
+        }
+    } else {
+        int estride = 1 << p.lg2_stride;
+        if (p.invert) {
+            for (int r = 0; r < nreg; r++) {
+                uint8_t *d = vd + r * sizeof(ARMVectorReg);
+                uint8_t *n = vn + r * sizeof(ARMVectorReg);
+                uint8_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+                int e = 0;
+
+                for (; e < MIN(split, elements); e++) {
+                    d[H1(e)] = m[H1(e)];
+                }
+                for (; e < elements; e += estride) {
+                    d[H1(e)] = n[H1(e)];
+                    for (int i = 1; i < estride; i++) {
+                        d[H1(e + i)] = m[H1(e + i)];
+                    }
+                }
+            }
+        } else {
+            for (int r = 0; r < nreg; r++) {
+                uint8_t *d = vd + r * sizeof(ARMVectorReg);
+                uint8_t *n = vn + r * sizeof(ARMVectorReg);
+                uint8_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+                int e = 0;
+
+                for (; e < MIN(split, elements); e += estride) {
+                    d[H1(e)] = n[H1(e)];
+                    for (int i = 1; i < estride; i++) {
+                        d[H1(e + i)] = m[H1(e + i)];
+                    }
+                }
+                for (; e < elements; e++) {
+                    d[H1(e)] = m[H1(e)];
+                }
+            }
+        }
+    }
+}
+
+void HELPER(sme2_sel_h)(void *vd, void *vn, void *vm,
+                        uint32_t png, uint32_t desc)
+{
+    int vl = simd_oprsz(desc);
+    int nreg = simd_data(desc);
+    int elements = vl / sizeof(uint16_t);
+    DecodeCounter p = decode_counter(png, vl, MO_16);
+
+    if (p.lg2_stride == 0) {
+        if (p.invert) {
+            for (int r = 0; r < nreg; r++) {
+                uint16_t *d = vd + r * sizeof(ARMVectorReg);
+                uint16_t *n = vn + r * sizeof(ARMVectorReg);
+                uint16_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+
+                if (split <= 0) {
+                    memcpy(d, n, vl);  /* all true */
+                } else if (elements <= split) {
+                    memcpy(d, m, vl);  /* all false */
+                } else {
+                    for (int e = 0; e < split; e++) {
+                        d[H2(e)] = m[H2(e)];
+                    }
+                    for (int e = split; e < elements; e++) {
+                        d[H2(e)] = n[H2(e)];
+                    }
+                }
+            }
+        } else {
+            for (int r = 0; r < nreg; r++) {
+                uint16_t *d = vd + r * sizeof(ARMVectorReg);
+                uint16_t *n = vn + r * sizeof(ARMVectorReg);
+                uint16_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+
+                if (split <= 0) {
+                    memcpy(d, m, vl);  /* all false */
+                } else if (elements <= split) {
+                    memcpy(d, n, vl);  /* all true */
+                } else {
+                    for (int e = 0; e < split; e++) {
+                        d[H2(e)] = n[H2(e)];
+                    }
+                    for (int e = split; e < elements; e++) {
+                        d[H2(e)] = m[H2(e)];
+                    }
+                }
+            }
+        }
+    } else {
+        int estride = 1 << p.lg2_stride;
+        if (p.invert) {
+            for (int r = 0; r < nreg; r++) {
+                uint16_t *d = vd + r * sizeof(ARMVectorReg);
+                uint16_t *n = vn + r * sizeof(ARMVectorReg);
+                uint16_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+                int e = 0;
+
+                for (; e < MIN(split, elements); e++) {
+                    d[H2(e)] = m[H2(e)];
+                }
+                for (; e < elements; e += estride) {
+                    d[H2(e)] = n[H2(e)];
+                    for (int i = 1; i < estride; i++) {
+                        d[H2(e + i)] = m[H2(e + i)];
+                    }
+                }
+            }
+        } else {
+            for (int r = 0; r < nreg; r++) {
+                uint16_t *d = vd + r * sizeof(ARMVectorReg);
+                uint16_t *n = vn + r * sizeof(ARMVectorReg);
+                uint16_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+                int e = 0;
+
+                for (; e < MIN(split, elements); e += estride) {
+                    d[H2(e)] = n[H2(e)];
+                    for (int i = 1; i < estride; i++) {
+                        d[H2(e + i)] = m[H2(e + i)];
+                    }
+                }
+                for (; e < elements; e++) {
+                    d[H2(e)] = m[H2(e)];
+                }
+            }
+        }
+    }
+}
+
+void HELPER(sme2_sel_s)(void *vd, void *vn, void *vm,
+                        uint32_t png, uint32_t desc)
+{
+    int vl = simd_oprsz(desc);
+    int nreg = simd_data(desc);
+    int elements = vl / sizeof(uint32_t);
+    DecodeCounter p = decode_counter(png, vl, MO_32);
+
+    if (p.lg2_stride == 0) {
+        if (p.invert) {
+            for (int r = 0; r < nreg; r++) {
+                uint32_t *d = vd + r * sizeof(ARMVectorReg);
+                uint32_t *n = vn + r * sizeof(ARMVectorReg);
+                uint32_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+
+                if (split <= 0) {
+                    memcpy(d, n, vl);  /* all true */
+                } else if (elements <= split) {
+                    memcpy(d, m, vl);  /* all false */
+                } else {
+                    for (int e = 0; e < split; e++) {
+                        d[H4(e)] = m[H4(e)];
+                    }
+                    for (int e = split; e < elements; e++) {
+                        d[H4(e)] = n[H4(e)];
+                    }
+                }
+            }
+        } else {
+            for (int r = 0; r < nreg; r++) {
+                uint32_t *d = vd + r * sizeof(ARMVectorReg);
+                uint32_t *n = vn + r * sizeof(ARMVectorReg);
+                uint32_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+
+                if (split <= 0) {
+                    memcpy(d, m, vl);  /* all false */
+                } else if (elements <= split) {
+                    memcpy(d, n, vl);  /* all true */
+                } else {
+                    for (int e = 0; e < split; e++) {
+                        d[H4(e)] = n[H4(e)];
+                    }
+                    for (int e = split; e < elements; e++) {
+                        d[H4(e)] = m[H4(e)];
+                    }
+                }
+            }
+        }
+    } else {
+        /* p.esz must be MO_64, so stride must be 2. */
+        if (p.invert) {
+            for (int r = 0; r < nreg; r++) {
+                uint32_t *d = vd + r * sizeof(ARMVectorReg);
+                uint32_t *n = vn + r * sizeof(ARMVectorReg);
+                uint32_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+                int e = 0;
+
+                for (; e < MIN(split, elements); e++) {
+                    d[H4(e)] = m[H4(e)];
+                }
+                for (; e < elements; e += 2) {
+                    d[H4(e)] = n[H4(e)];
+                    d[H4(e + 1)] = m[H4(e + 1)];
+                }
+            }
+        } else {
+            for (int r = 0; r < nreg; r++) {
+                uint32_t *d = vd + r * sizeof(ARMVectorReg);
+                uint32_t *n = vn + r * sizeof(ARMVectorReg);
+                uint32_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+                int e = 0;
+
+                for (; e < MIN(split, elements); e += 2) {
+                    d[H4(e)] = n[H4(e)];
+                    d[H4(e + 1)] = m[H4(e + 1)];
+                }
+                for (; e < elements; e++) {
+                    d[H4(e)] = m[H4(e)];
+                }
+            }
+        }
+    }
+}
+
+void HELPER(sme2_sel_d)(void *vd, void *vn, void *vm,
+                        uint32_t png, uint32_t desc)
+{
+    int vl = simd_oprsz(desc);
+    int nreg = simd_data(desc);
+    int elements = vl / sizeof(uint64_t);
+    DecodeCounter p = decode_counter(png, vl, MO_64);
+
+    if (p.invert) {
+        for (int r = 0; r < nreg; r++) {
+            uint64_t *d = vd + r * sizeof(ARMVectorReg);
+            uint64_t *n = vn + r * sizeof(ARMVectorReg);
+            uint64_t *m = vm + r * sizeof(ARMVectorReg);
+            int split = p.count - r * elements;
+
+            if (split <= 0) {
+                memcpy(d, n, vl);  /* all true */
+            } else if (elements <= split) {
+                memcpy(d, m, vl);  /* all false */
+            } else {
+                memcpy(d, m, split * sizeof(uint64_t));
+                memcpy(d + split, n + split,
+                       (elements - split) * sizeof(uint64_t));
+            }
+        }
+    } else {
+        for (int r = 0; r < nreg; r++) {
+            uint64_t *d = vd + r * sizeof(ARMVectorReg);
+            uint64_t *n = vn + r * sizeof(ARMVectorReg);
+            uint64_t *m = vm + r * sizeof(ARMVectorReg);
+            int split = p.count - r * elements;
+
+            if (split <= 0) {
+                memcpy(d, m, vl);  /* all false */
+            } else if (elements <= split) {
+                memcpy(d, n, vl);  /* all true */
+            } else {
+                memcpy(d, n, split * sizeof(uint64_t));
+                memcpy(d + split, m + split,
+                       (elements - split) * sizeof(uint64_t));
+            }
+        }
+    }
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b6316ac716..7407597177 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1642,3 +1642,34 @@ static gen_helper_gvec_3 * const uclamp_fns[] = {
     gen_helper_sme2_uclamp_d,
 };
 TRANS(UCLAMP, do_clamp, a, uclamp_fns)
+
+static bool trans_SEL(DisasContext *s, arg_SEL *a)
+{
+    typedef void sme_sel_fn(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32, TCGv_i32);
+    static sme_sel_fn * const fns[4] = {
+        gen_helper_sme2_sel_b, gen_helper_sme2_sel_h,
+        gen_helper_sme2_sel_s, gen_helper_sme2_sel_d
+    };
+
+    if (!dc_isar_feature(aa64_sme2, s)) {
+        return false;
+    }
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        uint32_t desc = simd_desc(svl, svl, a->n);
+        TCGv_ptr t_d = tcg_temp_new_ptr();
+        TCGv_ptr t_n = tcg_temp_new_ptr();
+        TCGv_ptr t_m = tcg_temp_new_ptr();
+        TCGv_i32 png = tcg_temp_new_i32();
+
+        tcg_gen_addi_ptr(t_d, tcg_env, vec_full_reg_offset(s, a->zd));
+        tcg_gen_addi_ptr(t_n, tcg_env, vec_full_reg_offset(s, a->zn));
+        tcg_gen_addi_ptr(t_m, tcg_env, vec_full_reg_offset(s, a->zm));
+
+        tcg_gen_ld16u_i32(png, tcg_env, pred_full_reg_offset(s, a->pg)
+                          ^ (HOST_BIG_ENDIAN ? 6 : 0));
+
+        fns[a->esz](t_d, t_n, t_m, png, tcg_constant_i32(desc));
+    }
+    return true;
+}
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index c4b85a36d0..0a2ceea8be 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -878,6 +878,15 @@ UCLAMP          11000001 esz:2 1 zm:5 110001 zn:5 .... 1    \
 UCLAMP          11000001 esz:2 1 zm:5 110011 zn:5 ...0 1    \
                 &zzz_en zd=%zd_ax4 n=4
 
+### SME2 Multi-vector SVE Select
+
+%sel_pg         10:3 !function=plus_8
+
+SEL             11000001 esz:2 1 ....0 100 ... ....0 ....0  \
+                n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2 pg=%sel_pg
+SEL             11000001 esz:2 1 ...01 100 ... ...00 ...00  \
+                n=4 zd=%zd_ax4 zn=%zn_ax4 zm=%zm_ax4 pg=%sel_pg
+
 ### SME Multiple Zero
 
 &zero_za        rv off ngrp nvec
-- 
2.43.0


