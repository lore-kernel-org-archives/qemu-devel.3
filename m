Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBE6FD006D
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0v-0000VA-M2; Sun, 01 Mar 2026 09:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0f-0000P1-GB
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:43:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0a-0005lD-3u
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZGky8xMD3dSn1WaLy+RU0xJNdQ/dzGO2Gz2ecqpJwgk=;
 b=GktXUXbzcncEBXPPtAWeX7nWiU9rEUstg6nyVs1LP2aRXuRSYbKtPsovspFNcMoT+PK8G3
 ivedMOLNrJFubG3bYLhQnS77Coco04WmH6otiVVl6teTKmoAM8+jBDEYFTNcnFoHdn5tqI
 HNYU9yHdr+zFTIKDxdklBjNfMJ/mt6g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-at_JVB7CPNWE_v3JgHvZ1g-1; Sun, 01 Mar 2026 09:42:58 -0500
X-MC-Unique: at_JVB7CPNWE_v3JgHvZ1g-1
X-Mimecast-MFC-AGG-ID: at_JVB7CPNWE_v3JgHvZ1g_1772376177
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837f288194so25714335e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376176; x=1772980976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZGky8xMD3dSn1WaLy+RU0xJNdQ/dzGO2Gz2ecqpJwgk=;
 b=MzvR99mbDQduPYtlBXCBDQ9UVPkDfcbzHJLTeMWZjl6BjQzRAVwXf/XoSfMI7g8ueL
 VqUeZ9KZ6yK+I5+k1aRZyv26jJbcqXTLszhGUnfXhhFW8x5N7pBNBAWIuWz38EHQ9KRF
 ZOHsMLamW8mebbMi57/3QqXFCr0xnGo2iBBAUIrjttdrNhvK8WsmwtF5NU+NoZl5ElUw
 oi+6E1+OUziOe2o51MqFqU0hg1eetzfbQOLjgLPSB+nAJ1YFPU6NumOlUWReie+BleS9
 6FLRUUHg08HCL1zIbEowGi2QvY/KJ6wikUVntsKQyJmBUM5/UKDTFeX8ztBH4rnupkNa
 fkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376176; x=1772980976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZGky8xMD3dSn1WaLy+RU0xJNdQ/dzGO2Gz2ecqpJwgk=;
 b=deqA/iGjOgxN5eZIF9nlPbfuywPwQKCywg235ghhq7EwvwWDKgTX0wZ+Oan1kYEnfH
 9WEWgbFA/R4UggTU9mRg2J8vIZAQCgS+jEDzAuzLanw+a1iW0ZE+Eq306NnqJWQsWrdk
 xWY5GsgbwWxBEjPwjf8SGine4QIH6FKHrJMpQAg/kIIbAfIvA2NQXiaswo7XL3bq2VLS
 9KMPFZQMdIkn3c70oPN9OII8ZRXJ0N0hqTI81joYaIU/gdybYYnaFq6M++V0zprsRLYg
 rJkQwtD8a6O7s7YbsTVaFKSCNVJ+AZjoAXKZ1UJg1LNxWntEAP9+qnVnUe9jV9EM0UzQ
 Rj2g==
X-Gm-Message-State: AOJu0Ywu5FSXUwnTY+dahsq8i9RYq1rlfwF6inoJmQxXKXS72wjmHEHn
 uVs2AkpYrtoYJRBTY/2cZz8nMRGFc8nOO8AtLBMo9YKGX5ryLGbZ6hTq7SN5/VVw7tG103pB4xN
 jGJ+XsQHGcgifkZS+chTnZejGSYAYMgUZp3mYINszB5kYHm+hjcDYNws3jqFUvlE9k3n6ktjnH3
 axolngZk/+QkfWbdykbHV+DsavnPWGxhAzrqKVy9ZQ
X-Gm-Gg: ATEYQzyh7U6n2+qJyKK/e3o0zHAVV0tdAMEfW9d26pT/B+izvrT00FluLdDM3z0ncS+
 hvhvwkkblGUuE0+3xkDd08KnC36yVuv6BqRBesjxJ5f9ozP2RlwGAcX7duJ8+vxbenFCsA2UQOy
 Z9lAbNAR4PM4ymTAgpHwL79mqesjQklVKBcyV4BnVzWU8iER8RwDd9RU4dvU4YOjz3Y+LjLfgwr
 To9KQmY8K54EFyVnKCV0Ozo0nsXKBdE3XohrB+LWwKd5ZQsWriknKV+ZER7SlJz1RniZsSg4Rae
 uUh0oI3Th98g94V+oLRogMYVgTBLIsoGFG+rvkGA51YdgL+G+u6brBpFwa7J3UU6roBqt+7h+Y2
 6GQIeHHgxwhb7lEhjx5JSNMjuieDJGMRDZ+e7pHZxgYCxK1qc3FtJsZuDSR6V2BZadlvpsixfF9
 EqebgzHWPIMbQiY/0h3PP/c8vtoRE=
X-Received: by 2002:a05:600c:46c4:b0:483:7ae2:1737 with SMTP id
 5b1f17b1804b1-483c9c1bbe9mr164728565e9.17.1772376175778; 
 Sun, 01 Mar 2026 06:42:55 -0800 (PST)
X-Received: by 2002:a05:600c:46c4:b0:483:7ae2:1737 with SMTP id
 5b1f17b1804b1-483c9c1bbe9mr164727615e9.17.1772376174663; 
 Sun, 01 Mar 2026 06:42:54 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b485a0b6sm4048856f8f.39.2026.03.01.06.42.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/18] target/i386/tcg: decode APX instructions
Date: Sun,  1 Mar 2026 15:42:16 +0100
Message-ID: <20260301144218.458140-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The bulk of the APX implementation, comprising new map4-specific
encodings, extensions to legacy root and 0F tables, and the
implementation of new instructions CFCMOV, PUSH2 and POP2.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h             |   1 +
 target/i386/tcg/decode-new.h     |   1 +
 target/i386/tcg/excp_helper.c    |   5 +
 target/i386/tcg/decode-new.c.inc | 356 ++++++++++++++++++++++---------
 target/i386/tcg/emit.c.inc       |  55 +++++
 5 files changed, 320 insertions(+), 98 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index 3f67098f11f..99cbbacadfc 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -57,6 +57,7 @@ DEF_HELPER_2(sysret, void, env, int)
 DEF_HELPER_FLAGS_1(pause, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_3(raise_interrupt, TCG_CALL_NO_WG, noreturn, env, int, int)
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
+DEF_HELPER_FLAGS_1(raise_gpf, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_1(icebp, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_3(boundw, void, env, tl, int)
 DEF_HELPER_3(boundl, void, env, tl, int)
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 1c7ed73c437..de35fb44a37 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -53,6 +53,7 @@ typedef enum X86OpType {
     X86_TYPE_nop, /* modrm operand decoded but not loaded into s->T{0,1} */
     X86_TYPE_2op, /* 2-operand RMW instruction */
     X86_TYPE_LoBits, /* encoded in bits 0-2 of the operand + REX.B */
+    X86_TYPE_ZERO, /* Constant zero, for CFCMOV */
     X86_TYPE_0, /* Hard-coded GPRs (RAX..RDI) */
     X86_TYPE_1,
     X86_TYPE_2,
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 32f2784e923..6a7a9fc8d56 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -36,6 +36,11 @@ G_NORETURN void helper_raise_exception(CPUX86State *env, int exception_index)
     raise_exception(env, exception_index);
 }
 
+G_NORETURN void helper_raise_gpf(CPUX86State *env)
+{
+    raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+}
+
 /*
  * Check nested exceptions and change to double or triple fault if
  * needed. It should only be called, if this is not an interrupt.
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 18b1b6845c1..32eaf582623 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -184,6 +184,8 @@
     X86_OP_GROUP3(op, op0, s0, None, None, None, None, ## __VA_ARGS__)
 #define X86_OP_GROUPwr(op, op0, s0, op1, s1, ...)                 \
     X86_OP_GROUP3(op, op0, s0, op1, s1, None, None, ## __VA_ARGS__)
+#define X86_OP_GROUPrr(op, op0, s0, op1, s1, ...)                 \
+    X86_OP_GROUP3(op, None, None, op0, s0, op1, s1, ## __VA_ARGS__)
 #define X86_OP_GROUP0(op, ...)                                    \
     X86_OP_GROUP3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
@@ -275,8 +277,10 @@
 #define p_f3          .valid_prefix = P_F3,
 #define p_f2          .valid_prefix = P_F2,
 #define p_00_66       .valid_prefix = P_00 | P_66,
+#define p_00_f2       .valid_prefix = P_00 | P_F2,
 #define p_00_f3       .valid_prefix = P_00 | P_F3,
 #define p_66_f2       .valid_prefix = P_66 | P_F2,
+#define p_66_f3       .valid_prefix = P_66 | P_F3,
 #define p_00_66_f3    .valid_prefix = P_00 | P_66 | P_F3,
 #define p_66_f3_f2    .valid_prefix = P_66 | P_F3 | P_F2,
 #define p_00_66_f3_f2 .valid_prefix = P_00 | P_66 | P_F3 | P_F2,
@@ -856,28 +860,30 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
 
     /*
      * REG selects srcdest2 operand, VEX.vvvv selects src3.  VEX class not found
-     * in manual, assumed to be 13 from the VEX.L0 constraint.
+     * in manual, assumed to be 13 from the VEX.L0 constraint; EVEX-APX-BMI and
+     * EVEX-APX-CMPccXADD are also pretty much the same; the difference are
+     * reflected in chk(nf0) and in the M operand type.
      */
-    [0xe0] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe1] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe2] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe3] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe4] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe5] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe6] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe7] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe0] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe1] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe2] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe3] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe4] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe5] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe6] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe7] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
 
-    [0xe8] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe9] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xea] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xeb] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xec] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xed] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xee] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xef] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe8] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe9] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xea] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xeb] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xec] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xed] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xee] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xef] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
 };
 
-/* five rows for no prefix, 66, F3, F2, 66+F2  */
+/* five rows for no prefix, 66, F3, F2, 66+F2 - all VEX13 instructions extend to APX */
 static const X86OpEntry opcodes_0F38_F0toFF[16][5] = {
     [0] = {
         X86_OP_ENTRYwr(MOVBE, G,y, M,y, cpuid(MOVBE)),
@@ -910,22 +916,22 @@ static const X86OpEntry opcodes_0F38_F0toFF[16][5] = {
     [5] = {
         X86_OP_ENTRY3(BZHI, G,y, E,y, B,y, vex13 cpuid(BMI1)),
         {},
-        X86_OP_ENTRY3(PEXT, G,y, B,y, E,y, vex13 zextT0 cpuid(BMI2)),
-        X86_OP_ENTRY3(PDEP, G,y, B,y, E,y, vex13 zextT0 cpuid(BMI2)),
+        X86_OP_ENTRY3(PEXT, G,y, B,y, E,y, vex13 zextT0 chk(nf0) cpuid(BMI2)),
+        X86_OP_ENTRY3(PDEP, G,y, B,y, E,y, vex13 zextT0 chk(nf0) cpuid(BMI2)),
         {},
     },
     [6] = {
         {},
         X86_OP_ENTRY2(ADCX, G,y, E,y, cpuid(ADX)),
         X86_OP_ENTRY2(ADOX, G,y, E,y, cpuid(ADX)),
-        X86_OP_ENTRY3(MULX, /* B,y, */ G,y, E,y, 2,y, vex13 cpuid(BMI2)),
+        X86_OP_ENTRY3(MULX, /* B,y, */ G,y, E,y, 2,y, vex13 chk(nf0) cpuid(BMI2)),
         {},
     },
     [7] = {
         X86_OP_ENTRY3(BEXTR, G,y, E,y, B,y, vex13 zextT0 cpuid(BMI1)),
-        X86_OP_ENTRY3(SHLX, G,y, E,y, B,y, vex13 cpuid(BMI1)),
-        X86_OP_ENTRY3(SARX, G,y, E,y, B,y, vex13 sextT0 cpuid(BMI1)),
-        X86_OP_ENTRY3(SHRX, G,y, E,y, B,y, vex13 zextT0 cpuid(BMI1)),
+        X86_OP_ENTRY3(SHLX, G,y, E,y, B,y, vex13 chk(nf0) cpuid(BMI1)),
+        X86_OP_ENTRY3(SARX, G,y, E,y, B,y, vex13 chk(nf0) sextT0 cpuid(BMI1)),
+        X86_OP_ENTRY3(SHRX, G,y, E,y, B,y, vex13 chk(nf0) zextT0 cpuid(BMI1)),
         {},
     },
 };
@@ -1023,7 +1029,7 @@ static const X86OpEntry opcodes_0F3A[256] = {
 
     [0xdf] = X86_OP_ENTRY3(VAESKEYGEN, V,dq, W,dq, I,b,  vex4 cpuid(AES) p_66),
 
-    [0xF0] = X86_OP_ENTRY3(RORX, G,y, E,y, I,b, vex13 cpuid(BMI2) p_f2),
+    [0xF0] = X86_OP_ENTRY3(RORX,       G,y, E,y, I,b,    vex13 chk(nf0) cpuid(BMI2) p_f2),
 };
 
 static void decode_0F3A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
@@ -1363,9 +1369,9 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xa0] = X86_OP_ENTRYr(PUSH, FS, w),
     [0xa1] = X86_OP_ENTRYw(POP, FS, w),
     [0xa2] = X86_OP_ENTRY0(CPUID),
-    [0xa3] = X86_OP_ENTRYrr(BT,   E,v, G,v,          btEvGv),
-    [0xa4] = X86_OP_ENTRY4(SHLD,  E,v, 2op,v, G,v),
-    [0xa5] = X86_OP_ENTRY3(SHLD,  E,v, 2op,v, G,v),
+    [0xa3] = X86_OP_ENTRYrr(BT,   E,v, G,v,            btEvGv),
+    [0xa4] = X86_OP_ENTRY4(SHLD,  B,v, E,v, G,v,       evex_apx p_00_66),
+    [0xa5] = X86_OP_ENTRY3(SHLD,  B,v, E,v, G,v,       evex_apx p_00_66),
 
     [0xb0] = X86_OP_ENTRY2(CMPXCHG,E,b, G,b, lock),
     [0xb1] = X86_OP_ENTRY2(CMPXCHG,E,v, G,v, lock),
@@ -1499,12 +1505,12 @@ static const X86OpEntry opcodes_0F[256] = {
 
     [0xa8] = X86_OP_ENTRYr(PUSH,   GS, w),
     [0xa9] = X86_OP_ENTRYw(POP,    GS, w),
-    [0xaa] = X86_OP_ENTRY0(RSM,             chk(smm) svm(RSM)),
+    [0xaa] = X86_OP_ENTRY0(RSM,                          chk(smm) svm(RSM)),
     [0xab] = X86_OP_ENTRY2(BTS,    E,v, G,v,             btEvGv),
-    [0xac] = X86_OP_ENTRY4(SHRD,   E,v, 2op,v, G,v),
-    [0xad] = X86_OP_ENTRY3(SHRD,   E,v, 2op,v, G,v),
+    [0xac] = X86_OP_ENTRY4(SHRD,   B,v, E,v, G,v,        evex_apx p_00_66),
+    [0xad] = X86_OP_ENTRY3(SHRD,   B,v, E,v, G,v,        evex_apx p_00_66),
     [0xae] = X86_OP_GROUP0(group15),
-    [0xaf] = X86_OP_ENTRY2(IMUL3,  G,v, E,v, sextT0),
+    [0xaf] = X86_OP_ENTRY3(IMUL3,  B,v, G,v, E,v,        evex_apx sextT0 p_00_66),
 
     [0xb8] = X86_OP_GROUP0(0FB8),
     /* decoded as modrm, which is visible as a difference between page fault and #UD */
@@ -1584,9 +1590,9 @@ static void decode_group1(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 
     if (op == 7) {
         /* prevent writeback for CMP */
-        entry->op1 = entry->op0;
         entry->op0 = X86_TYPE_None;
         entry->s0 = X86_SIZE_None;
+        entry->vex_class = X86_EVEX_APX_cmp;
     } else {
         entry->special = X86_SPECIAL_HasLock;
     }
@@ -1613,6 +1619,9 @@ static void decode_group2(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     };
     int op = (get_modrm(s, env) >> 3) & 7;
     entry->gen = group2_gen[op];
+    if (op == 2 || op == 3) {
+        entry->check |= X86_CHECK_nf0;
+    }
     if (op == 7) {
         entry->special = X86_SPECIAL_SExtT0;
     } else {
@@ -1624,22 +1633,22 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 {
     static const X86OpEntry opcodes_grp3[16] = {
         /* 0xf6 */
-        [0x00] = X86_OP_ENTRYrr(TEST, E,b, I,b),
-        [0x02] = X86_OP_ENTRY1(NOT,  E,b,      lock),
-        [0x03] = X86_OP_ENTRY1(NEG,  E,b,      lock),
-        [0x04] = X86_OP_ENTRYrr(MUL, E,b, 0,b, zextT0),
-        [0x05] = X86_OP_ENTRYrr(IMUL,E,b, 0,b, sextT0),
-        [0x06] = X86_OP_ENTRYr(DIV,  E,b),
-        [0x07] = X86_OP_ENTRYr(IDIV, E,b),
+        [0x00] = X86_OP_ENTRYrr(TEST, E,b, I,b, evex_apx_cmp p_00),
+        [0x02] = X86_OP_ENTRYwr(NOT,  B,b, E,b, evex_apx p_00 chk(nf0) lock),
+        [0x03] = X86_OP_ENTRYwr(NEG,  B,b, E,b, evex_apx p_00 lock),
+        [0x04] = X86_OP_ENTRYrr(MUL,  E,b, 0,b, evex_apx p_00 zextT0),
+        [0x05] = X86_OP_ENTRYrr(IMUL, E,b, 0,b, evex_apx p_00 sextT0),
+        [0x06] = X86_OP_ENTRYr(DIV,   E,b,      evex_apx p_00),
+        [0x07] = X86_OP_ENTRYr(IDIV,  E,b,      evex_apx p_00),
 
         /* 0xf7 */
-        [0x08] = X86_OP_ENTRYrr(TEST, E,v, I,z),
-        [0x0a] = X86_OP_ENTRY1(NOT,  E,v,      lock),
-        [0x0b] = X86_OP_ENTRY1(NEG,  E,v,      lock),
-        [0x0c] = X86_OP_ENTRYrr(MUL, E,v, 0,v, zextT0),
-        [0x0d] = X86_OP_ENTRYrr(IMUL,E,v, 0,v, sextT0),
-        [0x0e] = X86_OP_ENTRYr(DIV,  E,v),
-        [0x0f] = X86_OP_ENTRYr(IDIV, E,v),
+        [0x08] = X86_OP_ENTRYrr(TEST, E,v, I,z, evex_apx_cmp p_00_66),
+        [0x0a] = X86_OP_ENTRYwr(NOT,  B,v, E,v, evex_apx p_00_66 chk(nf0) lock),
+        [0x0b] = X86_OP_ENTRYwr(NEG,  B,v, E,v, evex_apx p_00_66 lock),
+        [0x0c] = X86_OP_ENTRYrr(MUL,  E,v, 0,v, evex_apx p_00_66 zextT0),
+        [0x0d] = X86_OP_ENTRYrr(IMUL, E,v, 0,v, evex_apx p_00_66 sextT0),
+        [0x0e] = X86_OP_ENTRYr(DIV,   E,v,      evex_apx p_00_66),
+        [0x0f] = X86_OP_ENTRYr(IDIV,  E,v,      evex_apx p_00_66),
     };
 
     int w = (*b & 1);
@@ -1652,12 +1661,12 @@ static void decode_group4_5(DisasContext *s, CPUX86State *env, X86OpEntry *entry
 {
     static const X86OpEntry opcodes_grp4_5[16] = {
         /* 0xfe */
-        [0x00] = X86_OP_ENTRY1(INC,     E,b,                           lock),
-        [0x01] = X86_OP_ENTRY1(DEC,     E,b,                           lock),
+        [0x00] = X86_OP_ENTRYwr(INC,    B,b, E,b,                      evex_apx p_00 lock),
+        [0x01] = X86_OP_ENTRYwr(DEC,    B,b, E,b,                      evex_apx p_00 lock),
 
         /* 0xff */
-        [0x08] = X86_OP_ENTRY1(INC,     E,v,                           lock),
-        [0x09] = X86_OP_ENTRY1(DEC,     E,v,                           lock),
+        [0x08] = X86_OP_ENTRYwr(INC,    B,v, E,v,                      evex_apx p_00 lock),
+        [0x09] = X86_OP_ENTRYwr(DEC,    B,v, E,v,                      evex_apx p_00 lock),
         [0x0a] = X86_OP_ENTRYr(CALL_m,  E,f64,                         zextT0),
         [0x0b] = X86_OP_ENTRYr(CALLF_m, M,p),
         [0x0c] = X86_OP_ENTRYr(JMP_m,   E,f64,                         zextT0),
@@ -1696,37 +1705,37 @@ static void decode_90(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint
 }
 
 static const X86OpEntry opcodes_root[256] = {
-    [0x00] = X86_OP_ENTRY2(ADD, E,b, G,b, lock),
-    [0x01] = X86_OP_ENTRY2(ADD, E,v, G,v, lock),
-    [0x02] = X86_OP_ENTRY2(ADD, G,b, E,b, lock),
-    [0x03] = X86_OP_ENTRY2(ADD, G,v, E,v, lock),
+    [0x00] = X86_OP_ENTRY3(ADD, B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x01] = X86_OP_ENTRY3(ADD, B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x02] = X86_OP_ENTRY3(ADD, B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x03] = X86_OP_ENTRY3(ADD, B,v, G,v, E,v, evex_apx p_00_66 lock),
     [0x04] = X86_OP_ENTRY2(ADD, 0,b, I,b, lock),   /* AL, Ib */
     [0x05] = X86_OP_ENTRY2(ADD, 0,v, I,z, lock),   /* rAX, Iz */
     [0x06] = X86_OP_ENTRYr(PUSH, ES, w, chk(i64)),
     [0x07] = X86_OP_ENTRYw(POP, ES, w, chk(i64)),
 
-    [0x10] = X86_OP_ENTRY2(ADC, E,b, G,b, lock),
-    [0x11] = X86_OP_ENTRY2(ADC, E,v, G,v, lock),
-    [0x12] = X86_OP_ENTRY2(ADC, G,b, E,b, lock),
-    [0x13] = X86_OP_ENTRY2(ADC, G,v, E,v, lock),
+    [0x10] = X86_OP_ENTRY3(ADC, B,b, E,b, G,b, evex_apx p_00 chk(nf0) lock),
+    [0x11] = X86_OP_ENTRY3(ADC, B,v, E,v, G,v, evex_apx p_00_66 chk(nf0) lock),
+    [0x12] = X86_OP_ENTRY3(ADC, B,b, G,b, E,b, evex_apx p_00 chk(nf0) lock),
+    [0x13] = X86_OP_ENTRY3(ADC, B,v, G,v, E,v, evex_apx p_00_66 chk(nf0) lock),
     [0x14] = X86_OP_ENTRY2(ADC, 0,b, I,b, lock),   /* AL, Ib */
     [0x15] = X86_OP_ENTRY2(ADC, 0,v, I,z, lock),   /* rAX, Iz */
     [0x16] = X86_OP_ENTRYr(PUSH, SS, w, chk(i64)),
     [0x17] = X86_OP_ENTRYw(POP, SS, w, chk(i64)),
 
-    [0x20] = X86_OP_ENTRY2(AND, E,b, G,b, lock),
-    [0x21] = X86_OP_ENTRY2(AND, E,v, G,v, lock),
-    [0x22] = X86_OP_ENTRY2(AND, G,b, E,b, lock),
-    [0x23] = X86_OP_ENTRY2(AND, G,v, E,v, lock),
+    [0x20] = X86_OP_ENTRY3(AND, B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x21] = X86_OP_ENTRY3(AND, B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x22] = X86_OP_ENTRY3(AND, B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x23] = X86_OP_ENTRY3(AND, B,v, G,v, E,v, evex_apx p_00_66 lock),
     [0x24] = X86_OP_ENTRY2(AND, 0,b, I,b, lock),   /* AL, Ib */
     [0x25] = X86_OP_ENTRY2(AND, 0,v, I,z, lock),   /* rAX, Iz */
     [0x26] = {},
     [0x27] = X86_OP_ENTRY0(DAA, chk(i64)),
 
-    [0x30] = X86_OP_ENTRY2(XOR, E,b, G,b, lock),
-    [0x31] = X86_OP_ENTRY2(XOR, E,v, G,v, lock),
-    [0x32] = X86_OP_ENTRY2(XOR, G,b, E,b, lock),
-    [0x33] = X86_OP_ENTRY2(XOR, G,v, E,v, lock),
+    [0x30] = X86_OP_ENTRY2(XOR, E,b, G,b, evex_apx p_00 lock),
+    [0x31] = X86_OP_ENTRY2(XOR, E,v, G,v, evex_apx p_00_66 lock),
+    [0x32] = X86_OP_ENTRY2(XOR, G,b, E,b, evex_apx p_00 lock),
+    [0x33] = X86_OP_ENTRY2(XOR, G,v, E,v, evex_apx p_00_66 lock),
     [0x34] = X86_OP_ENTRY2(XOR, 0,b, I,b, lock),   /* AL, Ib */
     [0x35] = X86_OP_ENTRY2(XOR, 0,v, I,z, lock),   /* rAX, Iz */
     [0x36] = {},
@@ -1768,12 +1777,12 @@ static const X86OpEntry opcodes_root[256] = {
     [0x76] = X86_OP_ENTRYr(Jcc, J,b),
     [0x77] = X86_OP_ENTRYr(Jcc, J,b),
 
-    [0x80] = X86_OP_GROUP2(group1, E,b, I,b),
-    [0x81] = X86_OP_GROUP2(group1, E,v, I,z),
-    [0x82] = X86_OP_GROUP2(group1, E,b, I,b, chk(i64)),
-    [0x83] = X86_OP_GROUP2(group1, E,v, I,b),
-    [0x84] = X86_OP_ENTRYrr(TEST, E,b, G,b),
-    [0x85] = X86_OP_ENTRYrr(TEST, E,v, G,v),
+    [0x80] = X86_OP_GROUP3(group1, B,b, E,b, I,b, evex_apx p_00),
+    [0x81] = X86_OP_GROUP3(group1, B,v, E,v, I,z, evex_apx p_00_66),
+    [0x82] = X86_OP_GROUP2(group1,      E,b, I,b, chk(i64)),
+    [0x83] = X86_OP_GROUP3(group1, B,v, E,v, I,b, evex_apx p_00_66),
+    [0x84] = X86_OP_ENTRYrr(TEST, E,b, G,b, evex_apx_cmp p_00),
+    [0x85] = X86_OP_ENTRYrr(TEST, E,v, G,v, evex_apx_cmp p_00_66),
     [0x86] = X86_OP_ENTRY2(XCHG, E,b, G,b, xchg),
     [0x87] = X86_OP_ENTRY2(XCHG, E,v, G,v, xchg),
 
@@ -1804,8 +1813,8 @@ static const X86OpEntry opcodes_root[256] = {
     [0xB6] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
     [0xB7] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
 
-    [0xC0] = X86_OP_GROUP2(group2, E,b, I,b),
-    [0xC1] = X86_OP_GROUP2(group2, E,v, I,b),
+    [0xC0] = X86_OP_GROUP3(group2, B,b, E,b, I,b,           evex_apx p_00),
+    [0xC1] = X86_OP_GROUP3(group2, B,v, E,v, I,b,           evex_apx p_00_66),
     [0xC2] = X86_OP_ENTRYr(RET, I,w),
     [0xC3] = X86_OP_ENTRY0(RET),
     [0xC4] = X86_OP_ENTRY3(LES, G,z, EM,p, None, None, chk(i64)),
@@ -1813,10 +1822,10 @@ static const X86OpEntry opcodes_root[256] = {
     [0xC6] = X86_OP_GROUP3(group11, E,b, I,b, None, None), /* reg=000b */
     [0xC7] = X86_OP_GROUP3(group11, E,v, I,z, None, None), /* reg=000b */
 
-    [0xD0] = X86_OP_GROUP1(group2, E,b),
-    [0xD1] = X86_OP_GROUP1(group2, E,v),
-    [0xD2] = X86_OP_GROUP2(group2, E,b, 1,b), /* CL */
-    [0xD3] = X86_OP_GROUP2(group2, E,v, 1,b), /* CL */
+    [0xD0] = X86_OP_GROUPwr(group2, B,b, E,b,               evex_apx p_00),
+    [0xD1] = X86_OP_GROUPwr(group2, B,v, E,v,               evex_apx p_00_66),
+    [0xD2] = X86_OP_GROUP3(group2, B,b, E,b, 1,b,           evex_apx p_00), /* CL */
+    [0xD3] = X86_OP_GROUP3(group2, B,v, E,v, 1,b,           evex_apx p_00_66), /* CL */
     [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b, chk(i64)),
     [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b, chk(i64)),
     [0xD6] = X86_OP_ENTRYw(SALC, 0,b, chk(i64)),
@@ -1837,37 +1846,37 @@ static const X86OpEntry opcodes_root[256] = {
     [0xF6] = X86_OP_GROUP1(group3, E,b),
     [0xF7] = X86_OP_GROUP1(group3, E,v),
 
-    [0x08] = X86_OP_ENTRY2(OR, E,b, G,b, lock),
-    [0x09] = X86_OP_ENTRY2(OR, E,v, G,v, lock),
-    [0x0A] = X86_OP_ENTRY2(OR, G,b, E,b, lock),
-    [0x0B] = X86_OP_ENTRY2(OR, G,v, E,v, lock),
+    [0x08] = X86_OP_ENTRY3(OR, B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x09] = X86_OP_ENTRY3(OR, B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x0A] = X86_OP_ENTRY3(OR, B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x0B] = X86_OP_ENTRY3(OR, B,v, G,v, E,v, evex_apx p_00_66 lock),
     [0x0C] = X86_OP_ENTRY2(OR, 0,b, I,b, lock),   /* AL, Ib */
     [0x0D] = X86_OP_ENTRY2(OR, 0,v, I,z, lock),   /* rAX, Iz */
     [0x0E] = X86_OP_ENTRYr(PUSH, CS, w, chk(i64)),
     [0x0F] = X86_OP_GROUP0(0F),
 
-    [0x18] = X86_OP_ENTRY2(SBB, E,b, G,b, lock),
-    [0x19] = X86_OP_ENTRY2(SBB, E,v, G,v, lock),
-    [0x1A] = X86_OP_ENTRY2(SBB, G,b, E,b, lock),
-    [0x1B] = X86_OP_ENTRY2(SBB, G,v, E,v, lock),
+    [0x18] = X86_OP_ENTRY3(SBB, B,b, E,b, G,b, evex_apx p_00 chk(nf0) lock),
+    [0x19] = X86_OP_ENTRY3(SBB, B,v, E,v, G,v, evex_apx p_00_66 chk(nf0) lock),
+    [0x1A] = X86_OP_ENTRY3(SBB, B,b, G,b, E,b, evex_apx p_00 chk(nf0) lock),
+    [0x1B] = X86_OP_ENTRY3(SBB, B,v, G,v, E,v, evex_apx p_00_66 chk(nf0) lock),
     [0x1C] = X86_OP_ENTRY2(SBB, 0,b, I,b, lock),   /* AL, Ib */
     [0x1D] = X86_OP_ENTRY2(SBB, 0,v, I,z, lock),   /* rAX, Iz */
     [0x1E] = X86_OP_ENTRYr(PUSH, DS, w, chk(i64)),
     [0x1F] = X86_OP_ENTRYw(POP, DS, w, chk(i64)),
 
-    [0x28] = X86_OP_ENTRY2(SUB, E,b, G,b, lock),
-    [0x29] = X86_OP_ENTRY2(SUB, E,v, G,v, lock),
-    [0x2A] = X86_OP_ENTRY2(SUB, G,b, E,b, lock),
-    [0x2B] = X86_OP_ENTRY2(SUB, G,v, E,v, lock),
+    [0x28] = X86_OP_ENTRY3(SUB, B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x29] = X86_OP_ENTRY3(SUB, B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x2A] = X86_OP_ENTRY3(SUB, B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x2B] = X86_OP_ENTRY3(SUB, B,v, G,v, E,v, evex_apx p_00_66 lock),
     [0x2C] = X86_OP_ENTRY2(SUB, 0,b, I,b, lock),   /* AL, Ib */
     [0x2D] = X86_OP_ENTRY2(SUB, 0,v, I,z, lock),   /* rAX, Iz */
     [0x2E] = {},
     [0x2F] = X86_OP_ENTRY0(DAS, chk(i64)),
 
-    [0x38] = X86_OP_ENTRYrr(CMP, E,b, G,b),
-    [0x39] = X86_OP_ENTRYrr(CMP, E,v, G,v),
-    [0x3A] = X86_OP_ENTRYrr(CMP, G,b, E,b),
-    [0x3B] = X86_OP_ENTRYrr(CMP, G,v, E,v),
+    [0x38] = X86_OP_ENTRYrr(CMP, E,b, G,b, evex_apx_cmp p_00),
+    [0x39] = X86_OP_ENTRYrr(CMP, E,v, G,v, evex_apx_cmp p_00_66),
+    [0x3A] = X86_OP_ENTRYrr(CMP, G,b, E,b, evex_apx_cmp p_00),
+    [0x3B] = X86_OP_ENTRYrr(CMP, G,v, E,v, evex_apx_cmp p_00_66),
     [0x3C] = X86_OP_ENTRYrr(CMP, 0,b, I,b),   /* AL, Ib */
     [0x3D] = X86_OP_ENTRYrr(CMP, 0,v, I,z),   /* rAX, Iz */
     [0x3E] = {},
@@ -1892,9 +1901,9 @@ static const X86OpEntry opcodes_root[256] = {
     [0x5F] = X86_OP_ENTRYw(POP, LoBits,d64),
 
     [0x68] = X86_OP_ENTRYr(PUSH, I,z),
-    [0x69] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,z, sextT0),
+    [0x69] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,z, evex_apx_zu p_00_66 sextT0),
     [0x6A] = X86_OP_ENTRYr(PUSH, I,b),
-    [0x6B] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,b, sextT0),
+    [0x6B] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,b, evex_apx_zu p_00_66 sextT0),
     [0x6C] = X86_OP_ENTRYrr(INS, Y,b, 2,w), /* DX */
     [0x6D] = X86_OP_ENTRYrr(INS, Y,z, 2,w), /* DX */
     [0x6E] = X86_OP_ENTRYrr(OUTS, X,b, 2,w), /* DX */
@@ -2047,9 +2056,151 @@ static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entr
     decode_REX2(s, env, entry, b, opcode_rex2_map1);
 }
 
+static const X86OpEntry opcodes_EVEX_map4_20to2F[16] = {
+    [0x0] = X86_OP_ENTRY3(AND,  B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x1] = X86_OP_ENTRY3(AND,  B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x2] = X86_OP_ENTRY3(AND,  B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x3] = X86_OP_ENTRY3(AND,  B,v, G,v, E,v, evex_apx p_00_66 lock),
+    [0x4] = X86_OP_ENTRY4(SHLD, B,v, E,v, G,v, evex_apx p_00_66),
+
+    [0x8] = X86_OP_ENTRY3(SUB,  B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x9] = X86_OP_ENTRY3(SUB,  B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0xA] = X86_OP_ENTRY3(SUB,  B,b, G,b, E,b, evex_apx p_00 lock),
+    [0xB] = X86_OP_ENTRY3(SUB,  B,v, G,v, E,v, evex_apx p_00_66 lock),
+    [0xC] = X86_OP_ENTRY4(SHRD, B,v, E,v, G,v, evex_apx p_00_66),
+};
+
+static void decode_EVEX4cc(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    uint8_t modrm = get_modrm(s, env);
+    int mod = (modrm >> 6) & 3;
+
+    static const X86OpEntry setcc =
+        X86_OP_ENTRYw(SETcc, E,b, evex_apx_zu chk(nf0) p_f2);
+    static const X86OpEntry cfcmov_nd0[2][2] = {
+        { /* NF=0 */
+            X86_OP_ENTRY3(CFCMOVcc_ld,  G,v, ZERO,v, M,v, p_00_66 evex_apx),
+            X86_OP_ENTRY3(CMOVcc,       G,v, ZERO,v, E,v, p_00_66 evex_apx),
+        },
+        { /* NF=1 */
+            X86_OP_ENTRYwr(CFCMOVcc_st, M,v, G,v,         p_00_66 evex_apx),
+            X86_OP_ENTRY3(CMOVcc,       E,v, ZERO,v, G,v, p_00_66 evex_apx),
+        },
+    };
+    static const X86OpEntry cfcmov_nd1[2][2] = {
+        { /* NF=0 */
+            X86_OP_ENTRY3(CMOVcc,       B,v, G,v, E,v,    p_00_66 evex_apx),
+            X86_OP_ENTRY3(CMOVcc,       B,v, G,v, E,v,    p_00_66 evex_apx),
+        },
+        { /* NF=1 */
+            X86_OP_ENTRY3(CFCMOVcc_ld,  B,v, G,v, M,v,    p_00_66 evex_apx),
+            X86_OP_ENTRY3(CMOVcc,       B,v, G,v, E,v,    p_00_66 evex_apx),
+        },
+    };
+
+    if (s->prefix & PREFIX_REPNZ) {
+        *entry = setcc;
+        if (EVEX_APX_ND(s)) {
+            entry->s1 = X86_SIZE_q; /* optimization for zu */
+        }
+    } else {
+        *entry = (EVEX_APX_ND(s) ? cfcmov_nd1 : cfcmov_nd0)[EVEX_APX_NF(s)][mod == 3];
+    }
+}
+
+static const X86OpEntry opcodes_EVEX_map4_40to4F[16] = {
+    [0x0] = X86_OP_GROUP0(EVEX4cc),
+    [0x1] = X86_OP_GROUP0(EVEX4cc),
+    [0x2] = X86_OP_GROUP0(EVEX4cc),
+    [0x3] = X86_OP_GROUP0(EVEX4cc),
+    [0x4] = X86_OP_GROUP0(EVEX4cc),
+    [0x5] = X86_OP_GROUP0(EVEX4cc),
+    [0x6] = X86_OP_GROUP0(EVEX4cc),
+    [0x7] = X86_OP_GROUP0(EVEX4cc),
+    [0x8] = X86_OP_GROUP0(EVEX4cc),
+    [0x9] = X86_OP_GROUP0(EVEX4cc),
+    [0xA] = X86_OP_GROUP0(EVEX4cc),
+    [0xB] = X86_OP_GROUP0(EVEX4cc),
+    [0xC] = X86_OP_GROUP0(EVEX4cc),
+    [0xD] = X86_OP_GROUP0(EVEX4cc),
+    [0xE] = X86_OP_GROUP0(EVEX4cc),
+    [0xF] = X86_OP_GROUP0(EVEX4cc),
+};
+
+static void decode_EVEX4_66(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    entry->gen = (s->prefix & PREFIX_DATA) ? gen_ADCX : gen_ADOX;
+}
+
+static const X86OpEntry opcodes_EVEX_map4_60to6F[16] = {
+    [0x0] = X86_OP_ENTRYwr(MOVBE,        G,y, E,y, cpuid(MOVBE) chk(nf0) p_00_66),
+    [0x1] = X86_OP_ENTRYwr(MOVBE,        E,y, G,y, cpuid(MOVBE) chk(nf0) p_00_66),
+    [0x6] = X86_OP_GROUP3(EVEX4_66, B,y, G,y, E,y, cpuid(ADX) chk(nf0) p_66_f3),
+};
+
+static void decode_EVEX4_8F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    int op = (get_modrm(s, env) >> 3) & 7;
+    if (op == 0) {
+        entry->gen = gen_POP2;
+    } else {
+        *entry = UNKNOWN_OPCODE;
+    }
+}
+
+static const X86OpEntry opcodes_EVEX_map4_80to8F[16] = {
+    [0x0] = X86_OP_GROUP3(group1,   B,b, E,b, I,b,     evex_apx p_00),
+    [0x1] = X86_OP_GROUP3(group1,   B,v, E,v, I,z,     evex_apx p_00_66),
+    [0x3] = X86_OP_GROUP3(group1,   B,v, E,v, I,b,     evex_apx p_00_66),
+    [0x4] = X86_OP_ENTRYrr(TEST,    E,b, G,b,          evex_apx_cmp p_00_66),
+    [0x5] = X86_OP_ENTRYrr(TEST,    E,v, G,v,          evex_apx_cmp p_00_66),
+
+    [0x8] = X86_OP_ENTRYwr(POPCNT,  G,v, E,v,          evex_apx cpuid(POPCNT) zextT0 p_00_66),
+    [0xF] = X86_OP_GROUPw(EVEX4_8F, R,d64, /* B,d64 */ evex_apx_pp2 p_00),
+};
+
+static void decode_EVEX4_FF(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    int op = (get_modrm(s, env) >> 3) & 7;
+    if (op == 6) {
+        entry->gen = gen_PUSH2;
+    } else {
+        *entry = opcodes_root[0xFF];
+    }
+}
+
+static const X86OpEntry opcodes_EVEX_map4_F0toFF[16] = {
+    [0x0] = X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
+    [0x1] = X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
+    [0x4] = X86_OP_ENTRYwr(TZCNT, G,v, E,v,        evex_apx zextT0 p_00_66),
+    [0x5] = X86_OP_ENTRYwr(LZCNT, G,v, E,v,        evex_apx zextT0 p_00_66),
+    [0x6] = X86_OP_GROUP1(group3, E,b),
+    [0x7] = X86_OP_GROUP1(group3, E,v),
+    [0xE] = X86_OP_GROUP1(group4_5, E,b),
+    [0xF] = X86_OP_GROUPrr(EVEX4_FF, B,d64, R,d64, evex_apx_pp2 p_00),
+};
+
 static void decode_EVEX_map4(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    *entry = UNKNOWN_OPCODE;
+    static const X86OpEntry *opcode_evex_map4[16] = {
+        &opcodes_root[0x00],
+        &opcodes_root[0x10],
+        opcodes_EVEX_map4_20to2F,  /* includes SHLD@24, SHRD@2C */
+        &opcodes_root[0x30],
+        opcodes_EVEX_map4_40to4F,  /* includes CMOVcc/CFCMOVcc/SETcc */
+        NULL,
+        opcodes_EVEX_map4_60to6F,  /* includes MOVBE, ADCX/ADOX */
+        NULL,
+        opcodes_EVEX_map4_80to8F,  /* includes POPCNT */
+        NULL,
+        &opcodes_0F[0xA0],         /* for SHLD/SHRD ...,CL */
+        NULL,
+        &opcodes_root[0xC0],
+        &opcodes_root[0xD0],
+        NULL,
+        opcodes_EVEX_map4_F0toFF,  /* includes CRC32@f0/f1, TZCNT@f4, LZCNT@f5 */
+    };
+    decode_REX2(s, env, entry, b, opcode_evex_map4);
 }
 #endif
 
@@ -2066,6 +2217,10 @@ static void decode_EVEX_map4(DisasContext *s, CPUX86State *env, X86OpEntry *entr
 #undef vex11
 #undef vex12
 #undef vex13
+#undef evex_apx
+#undef evex_apx_cmp
+#undef evex_apx_pp2
+#undef evex_apx_zu
 
 static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
@@ -2519,6 +2674,11 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         op->n = type - X86_TYPE_ES;
         op->unit = X86_OP_SEG;
         break;
+
+    case X86_TYPE_ZERO:
+        op->unit = X86_OP_IMM;
+        decode->immediate = op->imm = 0;
+        break;
     }
 
     return true;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 685972060c0..a1c3680db3c 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1644,6 +1644,30 @@ static void gen_CMC(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_xori_tl(cpu_cc_src, cpu_cc_src, CC_C);
 }
 
+#ifdef TARGET_X86_64
+static void gen_CFCMOVcc_ld(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGLabel *label_false = gen_new_label();
+    int cond = decode->b & 0xf;
+    MemOp ot = decode->op[2].ot;
+
+    gen_jcc_noeob(s, cond ^ 1, label_false);
+    gen_op_ld_v(s, ot, s->T0, s->A0);
+    gen_set_label(label_false);
+}
+
+static void gen_CFCMOVcc_st(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGLabel *label_false = gen_new_label();
+    int cond = decode->b & 0xf;
+    MemOp ot = decode->op[0].ot;
+
+    gen_jcc_noeob(s, cond ^ 1, label_false);
+    gen_op_st_v(s, ot, s->T0, s->A0);
+    gen_set_label(label_false);
+}
+#endif
+
 static void gen_CMOVcc(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_cmovcc(s, decode->b & 0xf, s->T0, s->T1);
@@ -3141,6 +3165,24 @@ static void gen_PMOVMSKB(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+#ifdef TARGET_X86_64
+static void gen_POP2(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGLabel *aligned = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cpu_regs[R_ESP], 15, aligned);
+    gen_helper_raise_gpf(tcg_env);
+    gen_set_label(aligned);
+
+    gen_lea_ss_ofs(s, s->A0, cpu_regs[R_ESP], 0);
+    gen_op_ld_v(s, MO_64, cpu_regs[s->vex_v], s->A0);
+
+    tcg_gen_addi_tl(s->A0, s->A0, 8);
+    gen_op_ld_v(s, MO_64, s->T0, s->A0);
+    gen_pop_update(s, MO_128);
+}
+#endif
+
 static void gen_POP(DisasContext *s, X86DecodedInsn *decode)
 {
     X86DecodedOp *op = &decode->op[0];
@@ -3338,6 +3380,19 @@ static void gen_PSLLDQ_i(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+#ifdef TARGET_X86_64
+static void gen_PUSH2(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGLabel *aligned = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cpu_regs[R_ESP], 15, aligned);
+    gen_helper_raise_gpf(tcg_env);
+    gen_set_label(aligned);
+    gen_push_v(s, s->T0);
+    gen_push_v(s, s->T1);
+}
+#endif
+
 static void gen_PUSH(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_push_v(s, s->T0);
-- 
2.52.0


