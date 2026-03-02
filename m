Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B4DEF585D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzF-00056z-0b; Mon, 02 Mar 2026 03:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxp-0003hD-Ly
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxn-0002J3-Hx
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhBocWSJc19xl2W81VDGcWaIXhzaLef2h/kLLTGSy64=;
 b=W4MQZJzM3MLkp6/bHtJkWZy1iPdoRJvmXvHYF+WNfMVnWtAsNYJhZ8+bIGvoCx3l9e+sab
 PH4/4MfYYlwl+Ikzg1S8L0ihPlkHXzw914n8inyyhEJlyCfwlBAiOZiCf7n5qnqp7am23G
 Ymg0NxqU1iAuwAXr+Wo+3QOMGbpcB7k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-2qTB4JoVPYWNmnkZPeithw-1; Mon, 02 Mar 2026 03:49:13 -0500
X-MC-Unique: 2qTB4JoVPYWNmnkZPeithw-1
X-Mimecast-MFC-AGG-ID: 2qTB4JoVPYWNmnkZPeithw_1772441353
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48069a43217so41079985e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441352; x=1773046152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhBocWSJc19xl2W81VDGcWaIXhzaLef2h/kLLTGSy64=;
 b=QFTwI1KLkfTOaLQO9kItLB9XdnoYCPtb2ge3CanVWeSWUYkdlMMzyMLMJegAvqRTyE
 k+ROrgNECbGkeaDVfehW0yGLs1B002w9Y/o9P84h7K2ANrwHhMp2MCfG7ZmrFnhGmEkr
 L5gmuThEnQbqJB+ZIgrJVpZT3mIsJx7bOgMU8t+qByvntqPuiejgNQaGiRMJ/Hld/4CN
 ErS4X984ue8JVUmuGML988HMZ9RLv37AcLDoEY71caQWCuJ35agFwkaFh4pNpC56x/6u
 I1I46GRpa0y0hIBf9XapUBnStzlxuhezZVwUWu9RazlEaexVNRCPHSnKdmxfGmm9lYB/
 YLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441352; x=1773046152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qhBocWSJc19xl2W81VDGcWaIXhzaLef2h/kLLTGSy64=;
 b=KhewMsuvQXuqS5Z/ebHrB+CUbglZpxUCH/RMEdnWPLj6DohAQIk9L4l/tYYe3DOS5s
 BsJBpeGT3AdOdfE6DEwdxn13poOLBLneGoHX9CFy+qNUHRCEuyWi8fsA5h/RD70Gaghz
 auhiRxs2eiHc1Z0WTAPFdAJp8Bz8Yqlo7F3o67aIGuO/rsJbb29YB80Yj9JIBg8yrHTz
 DowKQG1Z+dIuXpzp1GNU2yXjSlL5S9e/TkhyALeicad46b9KS5PxCfS3CGYd/a9X0Y8p
 ZvHCEySz9pGMnZCvSl4Go0nkKqBO6CwsbdcIMXC1sjwAPYb4Zj2mst9VTKZQDMc8YkFK
 TaUA==
X-Gm-Message-State: AOJu0YynTpqA9QOPneRlZ7g+tsMM2/6aPK0+vJZyEnaYxJv87uZK7L/n
 urcSGFgQyYDhOr3JdH7hpLyUO0nQnH4XmjrlrWj3PR2c3X2NIa92iE4CD+ueFi51FQacbCbaqlY
 40G9ydjiA7VJ1aqa3XAnmNdTTPv5NFTJz2BRGR5seBxheGJc3z4nJAbYxXRhfOLZfP1NnIDfm+u
 2hzuaa7dakUWBc5DDGnzI2dV2MbI8+iyL1tyQZK1mZ
X-Gm-Gg: ATEYQzzYm994SZkqR1tXUqlEi98mrSUd8r81EA4g21NZjLAzkwSuaxky7Jgw/zpRWD0
 KXqvTABIkv6/ffztRRYDnRgHMcDLGjZUKmA+Z8sx3XWuna+x7IUX0zm0hnFm7CuTwjJaY27IOsA
 QIV3maHYbZEBEYLeKix1gCtTblwZG8cywHuceajxmiEWS1cRFcpp67rWyU/vMG8hMypquDXaegY
 iqi6pA6tSS4JIfOM4TXKmhy9Id+ZjjK0LC7OzZhR8+yZBpvoUH2WW5KQju6CG/7/6tjEZlHYuXE
 ORCpsNhXdxXFvdm9GU+TN5RElGZuqc+jms8wuuHlnAmNqvlx74Dz1Q+xNiylfoXzN8OJhFylQ+O
 WFSVTFmta01g0r/Uv1uq/DHmQzVoS8gZblxrRs6MOuC/9KRP4Uqx+PMkU7FdP2jC01krvlWtfJf
 Z8sdzHn++BQKAZQHIgcShS0jwuFO4=
X-Received: by 2002:a05:600c:3509:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-483c9b9d9admr181458515e9.9.1772441351592; 
 Mon, 02 Mar 2026 00:49:11 -0800 (PST)
X-Received: by 2002:a05:600c:3509:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-483c9b9d9admr181458095e9.9.1772441351054; 
 Mon, 02 Mar 2026 00:49:11 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bffc17dasm233060645e9.2.2026.03.02.00.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:49:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 099/102] target/i386: emulate: more 64-bit register handling
Date: Mon,  2 Mar 2026 09:47:45 +0100
Message-ID: <20260302084749.474955-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260228214704.19048-6-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_flags.h | 20 ++++++++++++++
 target/i386/emulate/x86_emu.c   | 17 ++++++++++++
 target/i386/emulate/x86_flags.c | 47 +++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/target/i386/emulate/x86_flags.h b/target/i386/emulate/x86_flags.h
index a395c837a0e..7ffbbe5c122 100644
--- a/target/i386/emulate/x86_flags.h
+++ b/target/i386/emulate/x86_flags.h
@@ -33,6 +33,10 @@ void set_CF(CPUX86State *env, bool val);
 
 void SET_FLAGS_OxxxxC(CPUX86State *env, bool new_of, bool new_cf);
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAPC_SUB64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff);
+#endif
 void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff);
 void SET_FLAGS_OSZAPC_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
@@ -40,6 +44,10 @@ void SET_FLAGS_OSZAPC_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
 void SET_FLAGS_OSZAPC_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
                            uint8_t diff);
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAPC_ADD64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff);
+#endif
 void SET_FLAGS_OSZAPC_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff);
 void SET_FLAGS_OSZAPC_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
@@ -47,6 +55,10 @@ void SET_FLAGS_OSZAPC_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
 void SET_FLAGS_OSZAPC_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
                            uint8_t diff);
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAP_SUB64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                           uint64_t diff);
+#endif
 void SET_FLAGS_OSZAP_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
                            uint32_t diff);
 void SET_FLAGS_OSZAP_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
@@ -54,6 +66,10 @@ void SET_FLAGS_OSZAP_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
 void SET_FLAGS_OSZAP_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
                           uint8_t diff);
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAP_ADD64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                           uint64_t diff);
+#endif
 void SET_FLAGS_OSZAP_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
                            uint32_t diff);
 void SET_FLAGS_OSZAP_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
@@ -61,6 +77,10 @@ void SET_FLAGS_OSZAP_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
 void SET_FLAGS_OSZAP_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
                           uint8_t diff);
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAPC_LOGIC64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                              uint64_t diff);
+#endif
 void SET_FLAGS_OSZAPC_LOGIC32(CPUX86State *env, uint32_t v1, uint32_t v2,
                               uint32_t diff);
 void SET_FLAGS_OSZAPC_LOGIC16(CPUX86State *env, uint16_t v1, uint16_t v2,
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 8d35f3338c1..6c4ccc45383 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -45,6 +45,22 @@
 #include "x86_mmu.h"
 
 
+#ifdef TARGET_X86_64
+#define EXEC_2OP_FLAGS_CMD_64(env, decode, cmd, FLAGS_FUNC, save_res) \
+    case 8:                                        \
+    {                                               \
+        uint64_t v1 = (uint64_t)decode->op[0].val;  \
+        uint64_t v2 = (uint64_t)decode->op[1].val;  \
+        uint64_t diff = v1 cmd v2;                  \
+        if (save_res) {                              \
+            if (write_val_ext(env, &decode->op[0], diff, 8)) { return 1; } \
+        } \
+        FLAGS_FUNC##64(env, v1, v2, diff);          \
+        break;                                      \
+    }
+#else
+#define EXEC_2OP_FLAGS_CMD_64(env, decode, cmd, FLAGS_FUNC, save_res)
+#endif
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
 {                                                       \
     if (fetch_operands(env, decode, 2, true, true, false))  {\
@@ -84,6 +100,7 @@
         FLAGS_FUNC##32(env, v1, v2, diff);          \
         break;                                      \
     }                                               \
+    EXEC_2OP_FLAGS_CMD_64(env, decode, cmd, FLAGS_FUNC, save_res) \
     default:                                        \
         VM_PANIC("bad size\n");                    \
     }                                                   \
diff --git a/target/i386/emulate/x86_flags.c b/target/i386/emulate/x86_flags.c
index 6592193b5e0..3c4270a14c1 100644
--- a/target/i386/emulate/x86_flags.c
+++ b/target/i386/emulate/x86_flags.c
@@ -82,6 +82,10 @@
     SET_FLAGS_OSZAPC_SIZE(16, carries, result)
 #define SET_FLAGS_OSZAPC_32(carries, result) \
     SET_FLAGS_OSZAPC_SIZE(32, carries, result)
+#ifdef TARGET_X86_64
+#define SET_FLAGS_OSZAPC_64(carries, result) \
+    SET_FLAGS_OSZAPC_SIZE(64, carries, result)
+#endif
 
 /* ******************* */
 /* OSZAP */
@@ -107,6 +111,10 @@
     SET_FLAGS_OSZAP_SIZE(16, carries, result)
 #define SET_FLAGS_OSZAP_32(carries, result) \
     SET_FLAGS_OSZAP_SIZE(32, carries, result)
+#ifdef TARGET_X86_64
+#define SET_FLAGS_OSZAP_64(carries, result) \
+    SET_FLAGS_OSZAP_SIZE(64, carries, result)
+#endif
 
 void SET_FLAGS_OxxxxC(CPUX86State *env, bool new_of, bool new_cf)
 {
@@ -115,6 +123,14 @@ void SET_FLAGS_OxxxxC(CPUX86State *env, bool new_of, bool new_cf)
     env->cc_src ^= ((target_ulong)new_of << LF_BIT_PO);
 }
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAPC_SUB64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff)
+{
+    SET_FLAGS_OSZAPC_64(SUB_COUT_VEC(v1, v2, diff), diff);
+}
+#endif
+
 void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff)
 {
@@ -133,6 +149,14 @@ void SET_FLAGS_OSZAPC_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
     SET_FLAGS_OSZAPC_8(SUB_COUT_VEC(v1, v2, diff), diff);
 }
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAPC_ADD64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff)
+{
+    SET_FLAGS_OSZAPC_64(ADD_COUT_VEC(v1, v2, diff), diff);
+}
+#endif
+
 void SET_FLAGS_OSZAPC_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff)
 {
@@ -151,6 +175,14 @@ void SET_FLAGS_OSZAPC_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
     SET_FLAGS_OSZAPC_8(ADD_COUT_VEC(v1, v2, diff), diff);
 }
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAP_SUB64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff)
+{
+    SET_FLAGS_OSZAP_64(SUB_COUT_VEC(v1, v2, diff), diff);
+}
+#endif
+
 void SET_FLAGS_OSZAP_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff)
 {
@@ -169,6 +201,14 @@ void SET_FLAGS_OSZAP_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
     SET_FLAGS_OSZAP_8(SUB_COUT_VEC(v1, v2, diff), diff);
 }
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAP_ADD64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff)
+{
+    SET_FLAGS_OSZAP_64(ADD_COUT_VEC(v1, v2, diff), diff);
+}
+#endif
+
 void SET_FLAGS_OSZAP_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff)
 {
@@ -187,6 +227,13 @@ void SET_FLAGS_OSZAP_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
     SET_FLAGS_OSZAP_8(ADD_COUT_VEC(v1, v2, diff), diff);
 }
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAPC_LOGIC64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff)
+{
+    SET_FLAGS_OSZAPC_64(0, diff);
+}
+#endif
 
 void SET_FLAGS_OSZAPC_LOGIC32(CPUX86State *env, uint32_t v1, uint32_t v2,
                               uint32_t diff)
-- 
2.53.0


