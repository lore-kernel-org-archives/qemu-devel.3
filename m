Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC048CA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2zx-0008Gm-DY; Mon, 01 Sep 2025 07:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zP-0007O9-N1; Mon, 01 Sep 2025 07:46:26 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zF-0001M2-Gg; Mon, 01 Sep 2025 07:46:23 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7722c88fc5fso2387746b3a.2; 
 Mon, 01 Sep 2025 04:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727162; x=1757331962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKRYcSwafDNcekCgV+d38XwpLUOrhRn0ySHzx6DTOfk=;
 b=e9mkQQveZYZttx45r0QAbepTFEnh4/ksbLthEm+5p2PC6pGHH1Ie6MUaMafCeEiC8n
 CfVeiVJIgLV+c/1yan2UpUf3Ixs8cjHzjM4e3+neHNCZ604qgdR4/ghmfrQ3JHD05PYt
 RVyPzXyQscWXVx+rkzGBxldqcrygfDeBCkQMto0Shj4jnQfkoLhg4JkrBaJbltVEdqFo
 AAbHsbPsNzbNo/ut5YPPRGKAUQCA6MHyofWbAPUK65gXqb2NlSvkC9V8ioxofhbsgKmY
 gePGsYXT0zCj5z/CIJS1RlLJWypj5OP0s/syXJJQFGNbq0RwRUyyHyQRbGEnbfRg+V7Y
 weDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727162; x=1757331962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKRYcSwafDNcekCgV+d38XwpLUOrhRn0ySHzx6DTOfk=;
 b=US09Ya+rvyslys86aNfPt6i1WqWTOKaoLquTHu3tHmmroLy2GJ566OfPMlU79faDQt
 /AZqozyZ50rvBoz9pfaYe1YFMvqt0zJZvUABWpixG8VxU0iTc8udLK4t311Cf9aQTF8L
 Xvkjc8nPtzju/AO0U88LM93j6L3Fi4DsBsSbZAywNSQXjgi55XZY1l92uMzPezn3ohdm
 z9jPvebEdU4XpHpV6xvA2QhvKuNazGIs9+/jq9+9rTIaqyfJRxtLhdEthuL2XKXpf3jY
 MgWoAy7ymLLd48WidJsN1lyYIuxTdpsUAiE1E6bXCNgWq1FIeWdSPW/YXQsGv97rvjMa
 WILQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWTPSGcvEUlr59MTeDSoD0zQxXGs0PdIsH5M4dCQ12ZnPic06sd6X/c0BFEx4LC7mVEJyDm1nQlA==@nongnu.org,
 AJvYcCVPJdHWAOf0nCjesMj5esE7mgu8SERaVINSu7UNm1LbwJML2keLY/9dA3eQ6/luxH+eO5tHjvgnhpbw8w==@nongnu.org
X-Gm-Message-State: AOJu0YxE6a91tJPNBdBi/9T3BFIdf/e5V2s5K2VFxWoEeQyEufpTO2DM
 M4+lV6SV0iTUcXYxx9uazHocjEcYn89Rp6pGFR836baC36WMfUL0Y75mH5VOKQ==
X-Gm-Gg: ASbGncuY23+IcUT/1g/PSQ6GQKVoCkZ4aBAsMScNmxkv7JoGx3oFgTxkqiNO8EAT+gF
 Lsc5OdQnESAHepTnK7ssOftn5+2wuRhA3hqtrN5eA1WWsZyvnF3IoDuMEK1hN3hbRt4YHkaYnPz
 fBtn7hVNuVtCtlRyuoUzl1zdyUSk5v+7Zn1xqkwXb4AUdOZ2LMP02OCz8u0YsVuKihS/aCfLoZR
 THR6623E0eElwYsQOtmoF0ruzfpF6610Zyc65WGvRmByOwIm/B0yjmUwMMgb7N0K9cRyN+9T/fU
 r3CmN9DrfR/MbK077Bu9O3Ne4Wvuq7F2PEaJteOIKEh2bAUDVR/X1bFsuoUB5oKKJQNL/LXFy7X
 qv5fl6DXvdstWWEl5qwnEqA==
X-Google-Smtp-Source: AGHT+IFkunATfldHnVpyrPyJFgoJXLdJxX35nxoCHS8d7asV94Jq+xrer2nXFHFLBVHakqvytMDG5w==
X-Received: by 2002:a17:903:2301:b0:237:d734:5642 with SMTP id
 d9443c01a7336-24944ac6b51mr105348515ad.41.1756727162233; 
 Mon, 01 Sep 2025 04:46:02 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:46:01 -0700 (PDT)
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
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v3 07/35] tcg/wasm: Add constraint definitions
Date: Mon,  1 Sep 2025 20:44:09 +0900
Message-ID: <d935ea00f23ba6b4ea5624a57af0056214c2f495.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The Wasm backend integrates a forked TCI so its constraints are defined to
remain compatible with TCI.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target-con-set.h | 19 +++++++++++++++++++
 tcg/wasm/tcg-target-con-str.h | 14 ++++++++++++++
 tcg/wasm/tcg-target.c.inc     | 13 +++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 tcg/wasm/tcg-target-con-set.h
 create mode 100644 tcg/wasm/tcg-target-con-str.h

diff --git a/tcg/wasm/tcg-target-con-set.h b/tcg/wasm/tcg-target-con-set.h
new file mode 100644
index 0000000000..0dc41ebe33
--- /dev/null
+++ b/tcg/wasm/tcg-target-con-set.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Wasm target-specific constraint sets.
+ *
+ * Based on tci/tcg-target-con-set.h
+ *
+ * Copyright (c) 2021 Linaro
+ */
+
+/*
+ * C_On_Im(...) defines a constraint set with <n> outputs and <m> inputs.
+ * Each operand should be a sequence of constraint letters as defined by
+ * tcg-target-con-str.h; the constraint combination is inclusive or.
+ */
+C_O0_I1(r)
+C_O0_I2(r, r)
+C_O1_I1(r, r)
+C_O1_I2(r, r, r)
+C_O1_I4(r, r, r, r, r)
diff --git a/tcg/wasm/tcg-target-con-str.h b/tcg/wasm/tcg-target-con-str.h
new file mode 100644
index 0000000000..21ddbcc01a
--- /dev/null
+++ b/tcg/wasm/tcg-target-con-str.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define Wasm target-specific operand constraints.
+ *
+ * Based on tci/tcg-target-con-str.h
+ *
+ * Copyright (c) 2021 Linaro
+ */
+
+/*
+ * Define constraint letters for register sets:
+ * REGS(letter, register_mask)
+ */
+REGS('r', MAKE_64BIT_MASK(0, TCG_TARGET_NB_REGS))
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 3affc17232..0b12c4ea03 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -75,3 +75,16 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     tcg_debug_assert(slot >= 0 && slot < 128 / TCG_TARGET_REG_BITS);
     return TCG_REG_R0 + slot;
 }
+
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
+{
+    return C_NotImplemented;
+}
+
+/* Test if a constant matches the constraint. */
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
+{
+    return ct & TCG_CT_CONST;
+}
-- 
2.43.0


