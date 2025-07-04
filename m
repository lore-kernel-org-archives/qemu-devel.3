Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EFAC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjDu-00089w-HV; Fri, 04 Jul 2025 12:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDs-00087V-L9
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDq-000640-P4
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4537deebb01so6524235e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646309; x=1752251109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KOCKZ7GQe2vYAQmySn/4L9JFTEe27uBhSfrOZQSpCoo=;
 b=M6BTLoYsO+BB7+8HjAzWl8po3IK0hHTdlsjwnCG8GtL4vyxlroxINyQgBG5LXtC3eW
 f5RtJ+rjccK7zsPbMkEnnTBEgUcjNq9a5WI29rXMXZXX9m2oV8/WLspFTlmNXh2BP+Rf
 NsZA7IAi4QLhIYOv/Gy2GeuH4wS75i2y/VyGzAf/vWrJFCPdcA4bVWeNqngKZb0JHKWg
 Bz+ijKjKoqv6PgKSRVMmdsYEF22FMPpo5Q7JqB4znr/D14wBy4OVCVdBlC9c8ogfsL1l
 Rsn5NSY7q0EAeZD7oDZAswGCIhkbSK4NTUSXU6sJ/y+UB3u0Cs2ysSzx3OqtOacU0CDg
 HSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646309; x=1752251109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOCKZ7GQe2vYAQmySn/4L9JFTEe27uBhSfrOZQSpCoo=;
 b=CTtqFza6OFewZdG+24Vwfhmb7H18QHfjn4ZnlPYYusBygMDG4MBSnuorg1Th7ZjJMX
 lex1do6loPxtCxVOWvqRVi6rIBFqO19L36jRtvN62TBy9rJc3KZfmdjZTxT82lS9VZhB
 VDB+eNRym/80yjXnGhMBP/v4Ocbgg+chM0GYMe6r5LKz/eWXXUH2Xqo9tNf+iDICz0f3
 wYMc4VNIokIT7jaxqbOpjDojvmlakR1yXMYBWRt2ioNpy/sb+N/8LBXWE91bpyBi6QEZ
 1G1+wRO3TRfYkgc7KgP9QV0ZabVXBts0woUkS2Dav+RyndyfQ9inta08A0VqFg1+GvH0
 WoFw==
X-Gm-Message-State: AOJu0YxoCpLd39uFsfWWnQd4v349zSRZmKJi7Ptu91jfVQNXd5DXAQQv
 SGVnMh7toWP8b9OQLgZ/WAhqZY0/S8C4KobFM1f1ac6DhyvxZjAL6LEiqCSVFjQPpGcveOQv4bj
 LICFp
X-Gm-Gg: ASbGncv807kb2ECH8wBtxQ1HwfsdnzHK1eUeHRjn6cRVSZetqmD0J5iFrEdbXmxximL
 MCAR8Lf1F42DvrlkHEx4mLrJLC2c2j7I6SNbLX6VqW6VM7xR70HrgbQ+rUnqkC8RKovw8YCmTNZ
 OptabS35dWTZg/5D7/o/6Amc94JE8tUFvZdpp7S7Ap9Yvi5I/bNS3pNATooim4qyO5zqFulH1kN
 DzyYnWr9D0pbkGLhO4pjz7jmSw+DWSYe+0jQtomKyiNQQdfJcuc2l9DytqEeHX+JaU7WDBTWvDp
 VGIGad1VflF7dvUAT7or5yE2v6rgSAa7Lo2T1aP+nzDXDynAB4X847b5U2RsSCvi4kWYSxxt5VW
 Z56s=
X-Google-Smtp-Source: AGHT+IFBR+47XjhjHSRVMIfAfaTDEKhfs2iAgegyY0KWMSk7thG8865ZtS4ggZ0QB2sARzWuEjhjNw==
X-Received: by 2002:a05:600c:4f49:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-454b8b37c22mr12934755e9.0.1751646309158; 
 Fri, 04 Jul 2025 09:25:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 006/119] target/arm: Fix VSTR helper store alignment checks
Date: Fri,  4 Jul 2025 17:23:06 +0100
Message-ID: <20250704162501.249138-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: William Kosasih <kosasihwilliam4@gmail.com>

This patch adds alignment checks in the store operations in the VSTR
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250703085604.154449-6-kosasihwilliam4@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/mve_helper.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 8834523c23f..9587f2da7da 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -172,15 +172,17 @@ static void mve_advance_vpt(CPUARMState *env)
         mve_advance_vpt(env);                                           \
     }
 
-#define DO_VSTR(OP, MSIZE, STTYPE, ESIZE, TYPE)                         \
+#define DO_VSTR(OP, MFLAG, MSIZE, STTYPE, ESIZE, TYPE)                  \
     void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
     {                                                                   \
         TYPE *d = vd;                                                   \
         uint16_t mask = mve_element_mask(env);                          \
         unsigned b, e;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
         for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
             if (mask & (1 << b)) {                                      \
-                cpu_##STTYPE##_data_ra(env, addr, d[H##ESIZE(e)], GETPC()); \
+                cpu_##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
             }                                                           \
             addr += MSIZE;                                              \
         }                                                               \
@@ -191,9 +193,9 @@ DO_VLDR(vldrb, MO_UB, 1, uint8_t, ldb, 1, uint8_t)
 DO_VLDR(vldrh, MO_TEUW, 2, uint16_t, ldw, 2, uint16_t)
 DO_VLDR(vldrw, MO_TEUL, 4, uint32_t, ldl, 4, uint32_t)
 
-DO_VSTR(vstrb, 1, stb, 1, uint8_t)
-DO_VSTR(vstrh, 2, stw, 2, uint16_t)
-DO_VSTR(vstrw, 4, stl, 4, uint32_t)
+DO_VSTR(vstrb, MO_UB, 1, stb, 1, uint8_t)
+DO_VSTR(vstrh, MO_TEUW, 2, stw, 2, uint16_t)
+DO_VSTR(vstrw, MO_TEUL, 4, stl, 4, uint32_t)
 
 DO_VLDR(vldrb_sh, MO_SB, 1, int8_t, ldb, 2, int16_t)
 DO_VLDR(vldrb_sw, MO_SB, 1, int8_t, ldb, 4, int32_t)
@@ -202,9 +204,9 @@ DO_VLDR(vldrb_uw, MO_UB, 1, uint8_t, ldb, 4, uint32_t)
 DO_VLDR(vldrh_sw, MO_TESW, 2, int16_t, ldw, 4, int32_t)
 DO_VLDR(vldrh_uw, MO_TEUW, 2, uint16_t, ldw, 4, uint32_t)
 
-DO_VSTR(vstrb_h, 1, stb, 2, int16_t)
-DO_VSTR(vstrb_w, 1, stb, 4, int32_t)
-DO_VSTR(vstrh_w, 2, stw, 4, int32_t)
+DO_VSTR(vstrb_h, MO_UB, 1, stb, 2, int16_t)
+DO_VSTR(vstrb_w, MO_UB, 1, stb, 4, int32_t)
+DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
 
 #undef DO_VLDR
 #undef DO_VSTR
-- 
2.43.0


