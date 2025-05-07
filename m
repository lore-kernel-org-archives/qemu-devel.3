Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697CDC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoPz-0000NQ-Sb; Wed, 07 May 2025 19:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPi-0008Lj-BL
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:58 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPg-0002U9-6z
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:57 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-30a8cbddca4so496490a91.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661375; x=1747266175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IIdA4T0anNoDoCvg3AtaMVguafAAS4gjefvUsXl2qzE=;
 b=AwcHkXyoExwViKZMLusBTSNoIOjmFp/Nol7bnNEqPiEOXnqOWyaEhrr2VU85P8TUjC
 Rf/KNoOtPqw8IrS7ObijgVtHH6d8BFNmG5d/oGSnPXFJANDxngAWQ6E0D1jUoKU4RJYj
 AYQuErTLjtDXUKxNJWl2oB+3iOADln2Vrl7/8MElYiT3tG5dj2mJOWU5GdFGVt1BNpUZ
 YOEAaAov/BJqOFPdYwqoQbwBO4wxU4YZ49VRLq1VhLTOxbAoC4edxzdX+ZwVm7Q7w28v
 N+c+dcpSRsa8Wggy4OWM/AD0CGW/kfoBC48yVgsFSYY7AQDN5snlqCcwC0dMFoMnjIPF
 cLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661375; x=1747266175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IIdA4T0anNoDoCvg3AtaMVguafAAS4gjefvUsXl2qzE=;
 b=qcNmGknYK7i5G5jJB1HlsdwhK9nS86ffofgGktsdbxAo2jR8cPtquosujJOcbuBvgV
 9fipbECVFnQHROA0HmGCEadZJ7CWMyHu6Jz1AegF2CvofbqohPEgPFf6rM1PCosP+uYE
 0sqnJgNRACw1NiRYhrrOpoHCQ8PaXBWFqWOi3JU9yJ6Iwkzu4om0FaGRls1olQjAeH/1
 egrnO05bZzSs33ZorOC0oPj2B0+UjhMIDR0vIveTUDLwfvOXXlxs/BYcntXtb2pYSe4G
 e0dOB5jLKtYWyaxKh6OsEyFu9aJhfWzG14fxXisfIOXP0faI79zty5cuAEW25WH4n+nq
 6pMg==
X-Gm-Message-State: AOJu0Yz6X/MzmonfmRmS2i1AgiERqe38EUtl06XNfY8hs4kkkOyWi2O4
 WxDar9GXQkYbybuBvp7zlDilTq0ErpF8dLAzcj6YzwtyEVHhtUPRe1H8D9+ZJPihjIgGW5TOabX
 ZUCrWmg==
X-Gm-Gg: ASbGnctFAEIHtq+cUyb5w20T+xYKJ9tSTIcTL7OsEx8OIjQHeGpstTVzbjMAcRAGvg5
 QdcHkg3DQoFn/xjt1tpeuSGPCS8JQ2Oi4lyRuQXXK+Dx8/68g8YfTQSvlfZdbGr2HsfG4aFjQzV
 uRF6lHDRmVpCQPbutbN1fiqJt3C3ff8yxVfJpT7obswCtIl5RqPvF6bufa9+lqI24mr3TE4rPls
 qTmVMaVcZ8k1LZmJ+D9IApVx59BJCgjnsppHOYr635f3HW8pTRFyuZ3IqIrnJN84gFgiw3SADu/
 bd9Hj+xfBRuWAp7+bAg5kwAP/j5kIThps42f4Usp
X-Google-Smtp-Source: AGHT+IE4SdOlTduCOg7Y2FOUnmos397XeU5l2GkAQ9tyD0x8ukmGUjgShIh0T8CHvCr2QiUOb/m4DQ==
X-Received: by 2002:a17:90b:1d03:b0:2ee:53b3:3f1c with SMTP id
 98e67ed59e1d1-30b28ce2bd5mr1427945a91.5.1746661374817; 
 Wed, 07 May 2025 16:42:54 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 13/49] tcg: add vaddr type for helpers
Date: Wed,  7 May 2025 16:42:04 -0700
Message-ID: <20250507234241.957746-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

Defined as an alias of i32/i64 depending on host pointer size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/tcg/tcg-op-common.h    |  1 +
 include/tcg/tcg.h              | 14 ++++++++++++++
 include/exec/helper-head.h.inc | 11 +++++++++++
 tcg/tcg.c                      |  5 +++++
 4 files changed, 31 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b439bdb385a..e1071adebf2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -14,6 +14,7 @@
 
 TCGv_i32 tcg_constant_i32(int32_t val);
 TCGv_i64 tcg_constant_i64(int64_t val);
+TCGv_vaddr tcg_constant_vaddr(uintptr_t val);
 TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
 TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
 
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a8c00c72cc8..3fa5a7aed2c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -189,6 +189,7 @@ typedef tcg_target_ulong TCGArg;
     * TCGv_i64  : 64 bit integer type
     * TCGv_i128 : 128 bit integer type
     * TCGv_ptr  : a host pointer type
+    * TCGv_vaddr: an integer type wide enough to hold a target pointer type
     * TCGv_vec  : a host vector type; the exact size is not exposed
                   to the CPU front-end code.
     * TCGv      : an integer type the same size as target_ulong
@@ -217,6 +218,14 @@ typedef struct TCGv_ptr_d *TCGv_ptr;
 typedef struct TCGv_vec_d *TCGv_vec;
 typedef TCGv_ptr TCGv_env;
 
+#if __SIZEOF_POINTER__ == 4
+typedef TCGv_i32 TCGv_vaddr;
+#elif __SIZEOF_POINTER__ == 8
+typedef TCGv_i64 TCGv_vaddr;
+#else
+# error "sizeof pointer is different from {4,8}"
+#endif /* __SIZEOF_POINTER__ */
+
 /* call flags */
 /* Helper does not read globals (either directly or through an exception). It
    implies TCG_CALL_NO_WRITE_GLOBALS. */
@@ -577,6 +586,11 @@ static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
     return (TCGv_ptr)temp_tcgv_i32(t);
 }
 
+static inline TCGv_vaddr temp_tcgv_vaddr(TCGTemp *t)
+{
+    return (TCGv_vaddr)temp_tcgv_i32(t);
+}
+
 static inline TCGv_vec temp_tcgv_vec(TCGTemp *t)
 {
     return (TCGv_vec)temp_tcgv_i32(t);
diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index bce5db06ef3..5b248fd7138 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -58,6 +58,17 @@
 # define dh_ctype_tl target_ulong
 #endif /* COMPILING_PER_TARGET */
 
+#if __SIZEOF_POINTER__ == 4
+# define dh_alias_vaddr i32
+# define dh_typecode_vaddr dh_typecode_i32
+#elif __SIZEOF_POINTER__ == 8
+# define dh_alias_vaddr i64
+# define dh_typecode_vaddr dh_typecode_i64
+#else
+# error "sizeof pointer is different from {4,8}"
+#endif /* __SIZEOF_POINTER__ */
+# define dh_ctype_vaddr uintptr_t
+
 /* We can't use glue() here because it falls foul of C preprocessor
    recursive expansion rules.  */
 #define dh_retvar_decl0_void void
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 648333a9fb7..ae27a2607df 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2367,6 +2367,11 @@ TCGv_i64 tcg_constant_i64(int64_t val)
     return temp_tcgv_i64(tcg_constant_internal(TCG_TYPE_I64, val));
 }
 
+TCGv_vaddr tcg_constant_vaddr(uintptr_t val)
+{
+    return temp_tcgv_vaddr(tcg_constant_internal(TCG_TYPE_PTR, val));
+}
+
 TCGv_ptr tcg_constant_ptr_int(intptr_t val)
 {
     return temp_tcgv_ptr(tcg_constant_internal(TCG_TYPE_PTR, val));
-- 
2.47.2


