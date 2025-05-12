Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14554C3ABCC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXXY-0003S7-RL; Mon, 12 May 2025 14:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWp-0002RN-MR
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWm-0008Uc-5O
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:27 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2301ac32320so15177675ad.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073123; x=1747677923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IIdA4T0anNoDoCvg3AtaMVguafAAS4gjefvUsXl2qzE=;
 b=yj+3JbdcmzRIzVbaI62ZY5obXOHkGRcv2O/6yb1xo60ZEQwQ0escEfrCRS7/TVq8cZ
 tG/cBX9YfC9k3g4TthFHOKQ5Krm4iVuka4M1HPERFieLliqZLwUBv3Z9Mx/ZM4eODV7f
 rwWRMh6yJDDcfaEm1e0lnmqvoDNpQNFhiI598GpLoiZKDBQEHpBeMb4X428MalivDdwm
 gawgREnl+5QJ5aM+DwbG2ZjgWTdFsrQCr6flg3SQxf6BtXEZ3GYCGT+IJavIyC+8XaCu
 pfwpHXeezLbSJjH/I4bRvjoe166JPowjiD732Mzx9CE4tOdvCn62sa+S06o7LRlovB3Z
 dD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073123; x=1747677923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IIdA4T0anNoDoCvg3AtaMVguafAAS4gjefvUsXl2qzE=;
 b=m4Qc+4y00hylxe9djEApccs3SsG4tt2Kml0pzSRypgvyc6DoJW8EXxx60oEnGjUP0Q
 f8aTfLXgssaOYo6PshVdpiuswPF3N9oe/ODTGhnzurOcynSezcbyaVAoxoJFdSPrP3ce
 FreCMlYumiSdcUf8oN8nIhgi3aUiZXd3xgz+kmcAmlxmfbdlf2F+gz/WGAHnwz5ilRuZ
 EbPQS/f+dk5EnwqC2LPbJZXTvzxT6DGYagVxBDXozbMNzxTJBENmzzt40x9Xg0AG2ARJ
 r1RlX8ey0BefCISm2oxlR5HAI1OevJSi6mAdJ5/Z8/gjbZJbP8x9drO4/uLXZxyHYzmm
 BItQ==
X-Gm-Message-State: AOJu0YydsYM1KqLOaN+nnsCcCyuMZfWntw90td57vIHIQblS+OjMorrJ
 gIxS63h885ON4RCMWyD9dApMCJ7sVwqLtvdDA5ZUwP7U03zpFwNCwHiRYyV8naKszvzrhjIjnFe
 l
X-Gm-Gg: ASbGncumXX+5td1AC2u8zBCQoFZs43El9DwZHURVMZOmEBY5mD8wWqNVQnihv0Te9A4
 ngar3seLueyqVBp4jDR7GlmVk4OQgi5ZQVXn/cnNZFLupYBeLErPeAcx/u5C6FOSsVQmgcThXAM
 Pjam6hbfIByhkvo3Vp90Ox4XKd7Ac+T6Wc3mW1P3NRvp5rnMxm7/+Z3PSd12Sl4j6zpggiFCo7K
 eJ6Dk+qyRXtKSqeV/iZVERPPJwYIvnoQrtz1/gZZXDMdkTMSj2O267tJZahsfSsadWUR0Fq1oNh
 D+8SJbtapQYwvPpJs7gvaEYTAGMOvZDDjVmq95UPD4SKqQX3kxE=
X-Google-Smtp-Source: AGHT+IE4KyY2sjUciM2QtMe6xqm8Ao/CMZro9JcL3u4sz8QtHZGkRvfqtH/L0/tgDzL1c2LWymKJtw==
X-Received: by 2002:a17:902:e88d:b0:226:38ff:1d6a with SMTP id
 d9443c01a7336-22fc8b1b1d6mr194043645ad.7.1747073122675; 
 Mon, 12 May 2025 11:05:22 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 12/48] tcg: add vaddr type for helpers
Date: Mon, 12 May 2025 11:04:26 -0700
Message-ID: <20250512180502.2395029-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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


