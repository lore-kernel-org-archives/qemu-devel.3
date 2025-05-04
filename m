Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16A8C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRv6-0002AJ-VH; Sun, 04 May 2025 01:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuy-000255-2f
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:36 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuw-0004KY-5P
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:35 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso3370861b3a.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336572; x=1746941372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2AIxKY+FMiPJgej6tAa266T+4QbSc+CiL7TGNxQcGc=;
 b=luLjDPjUq/4h+yKeLgMmYF+me+ay1CRAcxHJGy8GTm6SsWiEtyDLoYpRNKQBa1qiRe
 wlRfP3PRVirA8FBVj/fM+8p9uTEsKjKz9sLkZO4QPgeNzjKul97EvZKvS4ZUa5UQP2qw
 +2NObW5lVR1tV47Uokyv9Cdnufwc6M31FRpT0f8n2SAX8IPIthqAwYN7rgEqX5p8hE+g
 SHYL/kNkuj+jth7nCfP+nkQZfRok/AwQapeDgcohqorVRudAZZsZwFTnwrfEaNV4LyTD
 8G5CiSuZV/kaU67pw4OSEXtQkbbVIHylmVnfnHJ5NwerZ4vQz8cz/w4Vwes9P34SSyei
 YIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336572; x=1746941372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2AIxKY+FMiPJgej6tAa266T+4QbSc+CiL7TGNxQcGc=;
 b=rcsZJbaNk6yPznYwze30KHCggG7ybKXPKwulLv2XYJKrps1bI7M4b9dpWf+Mzeb9Zp
 aA5a9HKU9L9vYX1pSXjXrfy5pvk9l+zQvlsljhjHrm9otuMO8lkIFYEY0OwIcFVuSAeS
 FYLcL8syffIpn+zwCHtzq5SND0DsQ3zyQjDCqwFq8txdcHpuBHdxuJhF2n+9h5+VemY6
 8dlvxzylAu3oa84MYnFRrgMMGb2bEvsUKgNSZjQDQzpj3VqFU7nrIsHgRZouMsoB/P2P
 80sEJGlI0Pj+C+S1d/nDmziPPdwdzjPEIKVAe8XXALYS36XFPI+zQinHk1myhdnC/0hY
 hDFg==
X-Gm-Message-State: AOJu0Yyjiy2bYQavtWKwm/NjlPFhH0UB2WSx87EKRkGFY/q5g7BzaSl8
 el4HP67CF0awqQqKpEsdEZGfH+4Q2UK6tMq9J4dhVRFAvYHfZNDYpm1DIZR14uW56umft1WnM4d
 fZuo=
X-Gm-Gg: ASbGncsi328wtBYRpjuYxtIiqNep8UIMo3pRjJT1LJFOCHbnOFsUOfHsM7eX+rpP/mG
 4IPOU05yojnNAhvmXiXMTROOXQ9bjHSrioZhRvffsanmvi2OGbYYMhqmvmQJQfu8d5WkU0qeoDf
 C7UBu4Frkzr/dSIZrQRT0DbgYP4ItwxEGaijTbjyfrphT+rYmVkC7yT2bSSQdqUEwFh3IA0cXiV
 woHkmwPa6v329XsPRjJ1tOiV+7QYUIFTUdTW/dFtw2zXlA2Yz427DXSpyno9vBRTeO6X1RHjFSq
 MXVIMRPU5l9tEEUcgru++c4VJqWjgtKMSiJwD/ta+3J/1/3LJIM=
X-Google-Smtp-Source: AGHT+IEU6HbixXtpyc/R49r3cZVRH0CTjPwr5pxfq2u4SUp++XWmysJGYYMZORx1y251tL8QRfDM8w==
X-Received: by 2002:a05:6a21:6d8e:b0:1f5:97c3:41b9 with SMTP id
 adf61e73a8af0-20e9620551emr3117470637.5.1746336572592; 
 Sat, 03 May 2025 22:29:32 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 14/40] tcg: add vaddr type for helpers
Date: Sat,  3 May 2025 22:28:48 -0700
Message-ID: <20250504052914.3525365-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/tcg/tcg-op-common.h    |  1 +
 include/tcg/tcg.h              | 17 +++++++++++++++++
 include/exec/helper-head.h.inc | 11 +++++++++++
 tcg/tcg.c                      |  6 ++++++
 4 files changed, 35 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b439bdb385a..7d7375eef44 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -14,6 +14,7 @@
 
 TCGv_i32 tcg_constant_i32(int32_t val);
 TCGv_i64 tcg_constant_i64(int64_t val);
+TCGv_vaddr tcg_constant_vaddr(vaddr val);
 TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
 TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
 
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index aa300a2f8ba..0eb033aa7d1 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -188,6 +188,7 @@ typedef tcg_target_ulong TCGArg;
     * TCGv_i64  : 64 bit integer type
     * TCGv_i128 : 128 bit integer type
     * TCGv_ptr  : a host pointer type
+    * TCGv_vaddr: an integer type large enough to hold a target pointer type
     * TCGv_vec  : a host vector type; the exact size is not exposed
                   to the CPU front-end code.
     * TCGv      : an integer type the same size as target_ulong
@@ -214,6 +215,7 @@ typedef struct TCGv_i64_d *TCGv_i64;
 typedef struct TCGv_i128_d *TCGv_i128;
 typedef struct TCGv_ptr_d *TCGv_ptr;
 typedef struct TCGv_vec_d *TCGv_vec;
+typedef struct TCGv_vaddr_d *TCGv_vaddr;
 typedef TCGv_ptr TCGv_env;
 
 /* call flags */
@@ -526,6 +528,11 @@ static inline TCGTemp *tcgv_ptr_temp(TCGv_ptr v)
     return tcgv_i32_temp((TCGv_i32)v);
 }
 
+static inline TCGTemp *tcgv_vaddr_temp(TCGv_vaddr v)
+{
+    return tcgv_i32_temp((TCGv_i32)v);
+}
+
 static inline TCGTemp *tcgv_vec_temp(TCGv_vec v)
 {
     return tcgv_i32_temp((TCGv_i32)v);
@@ -551,6 +558,11 @@ static inline TCGArg tcgv_ptr_arg(TCGv_ptr v)
     return temp_arg(tcgv_ptr_temp(v));
 }
 
+static inline TCGArg tcgv_vaddr_arg(TCGv_vaddr v)
+{
+    return temp_arg(tcgv_vaddr_temp(v));
+}
+
 static inline TCGArg tcgv_vec_arg(TCGv_vec v)
 {
     return temp_arg(tcgv_vec_temp(v));
@@ -572,6 +584,11 @@ static inline TCGv_i128 temp_tcgv_i128(TCGTemp *t)
     return (TCGv_i128)temp_tcgv_i32(t);
 }
 
+static inline TCGv_vaddr temp_tcgv_vaddr(TCGTemp *t)
+{
+    return (TCGv_vaddr)temp_tcgv_i32(t);
+}
+
 static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
 {
     return (TCGv_ptr)temp_tcgv_i32(t);
diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index bce5db06ef3..b15256ce14d 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -21,6 +21,7 @@
 #define dh_alias_f32 i32
 #define dh_alias_f64 i64
 #define dh_alias_ptr ptr
+#define dh_alias_vaddr vaddr
 #define dh_alias_cptr ptr
 #define dh_alias_env ptr
 #define dh_alias_fpst ptr
@@ -37,6 +38,7 @@
 #define dh_ctype_f16 uint32_t
 #define dh_ctype_f32 float32
 #define dh_ctype_f64 float64
+#define dh_ctype_vaddr uintptr_t
 #define dh_ctype_ptr void *
 #define dh_ctype_cptr const void *
 #define dh_ctype_env CPUArchState *
@@ -91,6 +93,15 @@
 #define dh_typecode_i64 4
 #define dh_typecode_s64 5
 #define dh_typecode_ptr 6
+
+#if __SIZEOF_POINTER__ == 4
+# define dh_typecode_vaddr dh_typecode_i32
+#elif __SIZEOF_POINTER__ == 8
+# define dh_typecode_vaddr dh_typecode_i64
+#else
+# error "sizeof pointer is different from {4,8}"
+#endif
+
 #define dh_typecode_i128 7
 #define dh_typecode_int dh_typecode_s32
 #define dh_typecode_f16 dh_typecode_i32
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c4e866e9c34..e86576120c0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2368,6 +2368,12 @@ TCGv_i64 tcg_constant_i64(int64_t val)
     return temp_tcgv_i64(tcg_constant_internal(TCG_TYPE_I64, val));
 }
 
+TCGv_vaddr tcg_constant_vaddr(vaddr val)
+{
+    TCGType type = __SIZEOF_POINTER__ == 8 ? TCG_TYPE_I64 : TCG_TYPE_I32;
+    return temp_tcgv_vaddr(tcg_constant_internal(type, val));
+}
+
 TCGv_ptr tcg_constant_ptr_int(intptr_t val)
 {
     return temp_tcgv_ptr(tcg_constant_internal(TCG_TYPE_PTR, val));
-- 
2.47.2


