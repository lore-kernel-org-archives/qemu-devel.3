Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B1AC88E58
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGna-0007OJ-Qm; Mon, 26 Jan 2026 02:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGf3-0002tL-Lz
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:42 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeu-00048B-Ax
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:15 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-81f4e36512aso4129078b3a.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411088; x=1770015888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmEhCMQFwYXprx7A0TkE7yYmCb0tF8cpp+0XtJ4tnk8=;
 b=RBI+F8Zhs0ppSEBrIUiGQeUyGoN6KrgjhAXaruo7e3YERfrrOK59/ydfAslf3M/szL
 Yk14XehU8IhFNj2BAqaTleFtWOPMUIkdx0XDQ+C62MbxsXzRxr85nOEDFMkIL4cbLJfK
 ryEl5BzgoOzm8o4tGSpz046IHVJHtGRCyIAs+cOImlORSliq3Ukihvyi004EouwbR6w+
 MpL6lj8m/ktgLWZTGfdARRzG7fFYtpql8tZ08HhTx6nt9eB+MqJootiAhSsub5SeGPX8
 hv0lpSMnOHkRfcfY9/symuIwpSdzmtyNGQMx/+p2B2koRwA5hMDSn0V8qYW8PL3H8S0K
 zJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411088; x=1770015888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gmEhCMQFwYXprx7A0TkE7yYmCb0tF8cpp+0XtJ4tnk8=;
 b=jybzVcI0JE30U9Pe0CEWosJd4ke6Rwb3IA1p1qBLlJWKWfcl3qx8JBtlFxU6A217hd
 d28HqHjCyLTAkUP9iSza72AZvYhizjLMHOyjNsfxPu3GPe3YMS85SJ3Ab7vLsf/0DSyB
 g7IPVeWdeyhJyP9GleYzp5ee9t4eq6BW5VxWM1UbU66ra6xx+fuKybFe8AUgdRwP/ZTX
 Yts5gY7J217C97Z/tacbRiWoGNZZG6eNxiumCHu3W62clqALabGtwHYsxhsneBQSvyfY
 LjZEODtVqvXv6HoZmaL2vMPPRsd4xqneLNfNwMUWmIUHIoJINoxr22rz2aVO6jyKjwfS
 pGsg==
X-Gm-Message-State: AOJu0Yy6DUecIRys8xUBcrRxQYJs0zhr7JRFSh8DFNgJpcgphb6xpsd+
 nKeNZDyvKwZU9GAVGOGtly/PbTSXdB2DEBFaWELdzQWpkM5AuoNpKVEXzr67lCWAwDs=
X-Gm-Gg: AZuq6aKktceXVmVjP7Wfape/oSdpnzi4Dbc1VDMB2u0BXDtP05ktFGY7TW7lH1IR3nS
 /crh5k8rzEozYigMAdPqttua2h/THKNfD033zLsYA7JMynscnPcWMA5UJYZfZJ1l8o3jI4Hyk63
 1wQqJ8beI2jLzDDqopTMOr1VTsa5SZAjvtY84ROsw5XOUsVH0jNst6OjkdQyUdxKe4/MHPcdQQk
 ebezIt/AzgVh1RHK0yxG6HjuLNZ6GIfepcQE8HXW7SQ4GsveYFC3dKZYRbXRkPTZYOYslAeznc1
 7eIxOGUIz3FvG669S0EXhODQR5r27jaAk2L4IC6AYnnl8FdqsEk3ZhRUJwh2NRlf0IRfBzGshe2
 X2OYMwSLkb51RqQAXTesBNjhkzSwHxScrXD8JCbcMpX1acBauq574ooUG8zAioM6LHaqedo4ZDP
 C30jDaSgNB9jH3yVdIlONTD+0eYndQYLlV3HWtmeWrIYcyUbTvRWjX
X-Received: by 2002:a05:6a00:2408:b0:81f:3e3e:c1fd with SMTP id
 d2e1a72fcca58-823411b854fmr3394964b3a.5.1769411087920; 
 Sun, 25 Jan 2026 23:04:47 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:04:47 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 09/33] tcg/wasm64: Add sextract instruction
Date: Mon, 26 Jan 2026 07:03:22 +0000
Message-ID: <f728d5885db1b40f95f9ba73d0e5a2c823ef36d9.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The sextract operation is genereted only when the corresponding Wasm
instructions are available, as specified by TCG_TARGET_sextract_valid.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64/tcg-target-has.h |  5 +++++
 tcg/wasm64/tcg-target.c.inc | 42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tcg/wasm64/tcg-target-has.h b/tcg/wasm64/tcg-target-has.h
index 7e3caf8790..cfb85388de 100644
--- a/tcg/wasm64/tcg-target-has.h
+++ b/tcg/wasm64/tcg-target-has.h
@@ -4,4 +4,9 @@
 
 #define TCG_TARGET_HAS_tst 0
 
+#define TCG_TARGET_extract_valid(type, ofs, len) 0
+#define TCG_TARGET_sextract_valid(type, ofs, len) \
+    ((ofs == 0) && ((len == 8) || (len == 16) || (len == 32)))
+#define TCG_TARGET_deposit_valid(type, ofs, len) 0
+
 #endif
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index 70de3bbf83..dd75deecd3 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -182,7 +182,10 @@ typedef enum {
     OPC_I64_SHR_U = 0x88,
 
     OPC_I32_WRAP_I64 = 0xa7,
+    OPC_I64_EXTEND_I32_S = 0xac,
     OPC_I64_EXTEND_I32_U = 0xad,
+    OPC_I64_EXTEND8_S = 0xc2,
+    OPC_I64_EXTEND16_S = 0xc3,
 } WasmInsn;
 
 typedef enum {
@@ -391,6 +394,33 @@ static void tcg_wasm_out_movcond(TCGContext *s, TCGType type, TCGReg ret,
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
 }
 
+static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,
+                                  int pos, int len)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+
+    if (pos == 0) {
+        switch (len) {
+        case 8:
+            tcg_wasm_out_op(s, OPC_I64_EXTEND8_S);
+            break;
+        case 16:
+            tcg_wasm_out_op(s, OPC_I64_EXTEND16_S);
+            break;
+        case 32:
+            tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+            tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_S);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        g_assert_not_reached();
+    }
+
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
+}
+
 static void tcg_out_op_rr(TCGContext *s, TCGOpcode op, TCGReg r0, TCGReg r1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -529,6 +559,18 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static void tcg_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
+                             TCGReg rs, unsigned pos, unsigned len)
+{
+    tcg_out_op_rrbb(s, INDEX_op_sextract, rd, rs, pos, len);
+    tcg_wasm_out_sextract(s, rd, rs, pos, len);
+}
+
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tcg_out_sextract,
+};
+
 static void tgen_shl(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-- 
2.43.0


