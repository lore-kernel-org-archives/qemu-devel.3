Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6102C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLga-0006jy-Jq; Sat, 02 Aug 2025 19:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLg4-0006I4-QP
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:13 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLg3-0004oK-0K
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:12 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so3139176fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177409; x=1754782209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKGJxaYCwBv8dhLSz8gkA8y5eKHpB1dn5bXnuAxni/8=;
 b=HTkj5fi4OxRqBDTiN/JzbE9YrPW/ayvQOGwfn6x2akx6qzHEDM7lEyFXD7j769ufY+
 PxMO3hE4DXxoHaDD/h22FU5X/cFRmwuUmf0j0zuLi4XgwYgkIgzMrcHjnw7BMVBeqTYV
 NrpeEBkErAPNQt9TvP/iMq87tGTnIzheO+R0HotLipEiaJdcZiFb38wGVw9uU39KhZKw
 JN7Qd/uxUAYtG4JlTn8Tzi20edsi9TVbuUBrBlQ/oX5F3h6DH7gYO/s3SftfpJi6Jt3j
 qgLTVF89eUAjHFLXEkQram5W/lqWZSoT72Y6kIwelHZ4krDpYDD47KBEj7XkxjQH58sc
 WyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177409; x=1754782209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DKGJxaYCwBv8dhLSz8gkA8y5eKHpB1dn5bXnuAxni/8=;
 b=AkRKDNntBR7SHBwDvNHcPvzVQGlduHSXFIwq0/M39AwYvRVzN3EvSpZXV79v1yt4MW
 4o727EJ6JDAgLQvCX/tmZg1C0ZN24AMg4BOhh05h2/FZnei+deSxB1pSyj6H8WNir+YG
 +pMSG59qT8dhZBF9HVdhhBGGAFMW2dbmTKd2+U7C4ouWdT96g0GO+eQJ/bzD2vB4zs/o
 XZfXqpiFubk/pfZjUd2cg/xQmX55f76uxv+QjAO0b0ue7Jhu43lWJiC/eMqorAqVY5LB
 EhiimDeJvLoo3pOifgPh67cyIYfhQuc3NC/N9h5nWvnA/W8J7PQ8leVfPoIzyvjrktzt
 qQUA==
X-Gm-Message-State: AOJu0Yw5zrw1kiLdqvuZEpcnIPgZjH/6pr9xG5h6WG0T3D5njSwbKEaJ
 fM4Vo76meFO8iOfCH11+qA5fJplQR1CGnIzh8RmhKsw+jmElcgsDS1huId15r3zgVZrRi4m19P8
 fmUFVdqg=
X-Gm-Gg: ASbGncvtkAhUnZ7UBs84Wv3EjvkWt/cpwHTjcxBL2ZI3keXqE92hSmYCmfTagfBlwDL
 ShTUOAfBNGnvqZpVhdepyolh+mjoXQNvtMkUjnRjGGSceG+FxO4DRhmfsnoIdDfGH5KLRBEYKRV
 guIFmOzeZzUYDrNlXgLNhvQzbnxNXtgdm25qHmgMTTP4xnDRN6ZWwb4sQ2BOZkkMcyOUs2kpHax
 wEZex1rops9moY85pvuGwanPUdETOMvr515HuHCeO39FH1R5TBM6XZE5NcPTStOgTCdecD24mw0
 WIGrP4ccw0oPn9+VtkU8r9bGobs0KDJfGuFC7w0GgQcRqk8EOTVciD3iNsaYrqfDEuVYBgd3JWN
 mv7jSEjceJtAyoDoY7KA1e5a+1xtE9M3S3HNbj5YGNXIwHSY0VplnOrYQaFJ78ok=
X-Google-Smtp-Source: AGHT+IGIcze9F9GmU2PAssW9dXbPdSb5w6MdKsYUh5KEBe1TxvBXYKQw7vuWhxAAEPatvFCSZ+r55A==
X-Received: by 2002:a05:6871:73a3:b0:2f7:53e7:1131 with SMTP id
 586e51a60fabf-30b66ad5a19mr3066749fac.10.1754177409544; 
 Sat, 02 Aug 2025 16:30:09 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:30:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 01/85] linux-user/aarch64: Split out signal_for_exception
Date: Sun,  3 Aug 2025 09:28:29 +1000
Message-ID: <20250802232953.413294-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 84 ++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index fea43cefa6..85d455d018 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -27,11 +27,56 @@
 #include "target/arm/syndrome.h"
 #include "target/arm/cpu-features.h"
 
+/* Use the exception syndrome to map a cpu exception to a signal. */
+static void signal_for_exception(CPUARMState *env, vaddr addr)
+{
+    uint32_t syn = env->exception.syndrome;
+    int si_code, si_signo;
+
+    switch (syn_get_ec(syn)) {
+    case EC_DATAABORT:
+    case EC_INSNABORT:
+        /* Both EC have the same format for FSC, or close enough. */
+        switch (extract32(syn, 0, 6)) {
+        case 0x04 ... 0x07: /* Translation fault, level {0-3} */
+            si_signo = TARGET_SIGSEGV;
+            si_code = TARGET_SEGV_MAPERR;
+            break;
+        case 0x09 ... 0x0b: /* Access flag fault, level {1-3} */
+        case 0x0d ... 0x0f: /* Permission fault, level {1-3} */
+            si_signo = TARGET_SIGSEGV;
+            si_code = TARGET_SEGV_ACCERR;
+            break;
+        case 0x11: /* Synchronous Tag Check Fault */
+            si_signo = TARGET_SIGSEGV;
+            si_code = TARGET_SEGV_MTESERR;
+            break;
+        case 0x21: /* Alignment fault */
+            si_signo = TARGET_SIGBUS;
+            si_code = TARGET_BUS_ADRALN;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case EC_PCALIGNMENT:
+        si_signo = TARGET_SIGBUS;
+        si_code = TARGET_BUS_ADRALN;
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    force_sig_fault(si_signo, si_code, addr);
+}
+
 /* AArch64 main loop */
 void cpu_loop(CPUARMState *env)
 {
     CPUState *cs = env_cpu(env);
-    int trapnr, ec, fsc, si_code, si_signo;
+    int trapnr;
     abi_long ret;
 
     for (;;) {
@@ -67,42 +112,7 @@ void cpu_loop(CPUARMState *env)
             break;
         case EXCP_PREFETCH_ABORT:
         case EXCP_DATA_ABORT:
-            ec = syn_get_ec(env->exception.syndrome);
-            switch (ec) {
-            case EC_DATAABORT:
-            case EC_INSNABORT:
-                /* Both EC have the same format for FSC, or close enough. */
-                fsc = extract32(env->exception.syndrome, 0, 6);
-                switch (fsc) {
-                case 0x04 ... 0x07: /* Translation fault, level {0-3} */
-                    si_signo = TARGET_SIGSEGV;
-                    si_code = TARGET_SEGV_MAPERR;
-                    break;
-                case 0x09 ... 0x0b: /* Access flag fault, level {1-3} */
-                case 0x0d ... 0x0f: /* Permission fault, level {1-3} */
-                    si_signo = TARGET_SIGSEGV;
-                    si_code = TARGET_SEGV_ACCERR;
-                    break;
-                case 0x11: /* Synchronous Tag Check Fault */
-                    si_signo = TARGET_SIGSEGV;
-                    si_code = TARGET_SEGV_MTESERR;
-                    break;
-                case 0x21: /* Alignment fault */
-                    si_signo = TARGET_SIGBUS;
-                    si_code = TARGET_BUS_ADRALN;
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
-            case EC_PCALIGNMENT:
-                si_signo = TARGET_SIGBUS;
-                si_code = TARGET_BUS_ADRALN;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            force_sig_fault(si_signo, si_code, env->exception.vaddress);
+            signal_for_exception(env, env->exception.vaddress);
             break;
         case EXCP_DEBUG:
         case EXCP_BKPT:
-- 
2.43.0


