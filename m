Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026C3CA0FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwHE-0003vZ-5d; Tue, 26 Aug 2025 12:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHB-0003v1-0o; Tue, 26 Aug 2025 12:12:02 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwH5-0007qe-6t; Tue, 26 Aug 2025 12:12:00 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b49cfd967b9so1756571a12.3; 
 Tue, 26 Aug 2025 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224711; x=1756829511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKRYcSwafDNcekCgV+d38XwpLUOrhRn0ySHzx6DTOfk=;
 b=elns5LEnbtz9cJCNCyC3qHZStr3MWMGQcKgwZB2t4EyJEMAScODZHnwCcw5N99OVt3
 ruNZvfd1J4eyGd0rh8xIzw1/6AdV21LBDM6euHRFnbBAXpZ34gDopGeFzSKNiIRLLi2e
 7X2iM7QsRmb8VAKsNDNOxQ24xJAqrxKtiHSLj3dZMajkaJWRSqClaM9GW247S2soHyLM
 CmFP7y5BmlNxdk8QYKBLm0j48W7Rsdykyk9DyIwCwdz8nLfQlvcqJka18H8Jd5Cr/o26
 L71ns7CEZ/8YMH25WAeof1I/52QAikH6Qh033W6Fgtza2mJMM969MkWRC9PHFdyv2bnN
 nvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224711; x=1756829511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKRYcSwafDNcekCgV+d38XwpLUOrhRn0ySHzx6DTOfk=;
 b=EjM0XdtcaJeEdNSTJX2PU4XcI3kqWJhvO+8KdZ9o8tj8pXIte4MTH7mWSPKIOx7O3u
 KZudtTSNjS2HPw6zHziYOzMjP7wTmkyuBoNcc8mt0jIRAin6wh227cPdlEs6PIwT90Qw
 u7o7iaq0JeQApRHBU/0sAN5FeXkuaTlr7GpEPopb8OSTXcfJqBGAt+EGYyZof0B2ny2M
 zkz6iDSk/BaYnG9ybWugX1t33DnZg6sEne1KbV4MDwvkbKPj5BN9p98apeum2+JwmRVJ
 q17E895s5cP/G8gNQGmV1YaSPapR7OEz8iisV9VKKLLaTBvkj9uEOqmmk/js3uwVS7VY
 ofyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbsqmDHFXmjVHQQrtjBNpYZGJN+1bbNd59wNwKyIsJ+hiOHQLJ75+FjpJj8PaNc4S0bPYbYb4DZAwPXQ==@nongnu.org,
 AJvYcCWD80H5QBBWiBcoc3nUmDzu+c0PquizGPPmZfkxakEi+0Pz9jOZ4hkDar5Ymb1sFeDzzS7eyJC8Jg==@nongnu.org
X-Gm-Message-State: AOJu0Yz1cP6+/0J2h9mDGIdrTCdCaLk573/sQQXW/FNkePIosPvzu9p6
 hetDB4cgB+D4faLe32l2WfhOtyDk+5SbW9LOzfQhq0Z4+T7FAlP59DG7+tuXbw==
X-Gm-Gg: ASbGncvN20XfHtcmle5Mi/dgISXHx/eHOWbillAb/DiGfAu95vh56V6ODTOdXSb4FrU
 yx0slAzU/ASW5qFKg9h//tQi9E5Kckn22zHcJfGztqff7fDcPvlDHwiI5TVcXV3RjeDyDFEbAsY
 CdDn3jcmJASFI6Q4oe9mSSsi4um404dKSa5reuTzkJUkOh8SLhTd/+t4GT54qiJ6DpwfaxU97ID
 vmzuSmkSGY6F+hZE0ol4O6bhIf9OUn8puVdnYx3yWspsIDl6xfKJHsLZ8ySzN+5v9dpoouhukmV
 1lqUQUTF8P1Fr65O0GSTIkvEwEsk9Gtu1jX1M1JYScaVOMzTcA9U4KnCpUSPV04PYWRhMAF7txj
 e6+R6+I2igzn8fLDwyJFb3xc+jmA/+A4p
X-Google-Smtp-Source: AGHT+IFF4HL9FOEk+e940IMNS1H+CIvQVkQ7XLzisbuQOTaCtjVWi11jrt71+T6TODkcZ89FOiOciA==
X-Received: by 2002:a17:90b:578b:b0:311:d05c:936 with SMTP id
 98e67ed59e1d1-32515eaee3dmr22437597a91.17.1756224711011; 
 Tue, 26 Aug 2025 09:11:51 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:11:50 -0700 (PDT)
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
Subject: [PATCH v2 07/35] tcg/wasm: Add constraint definitions
Date: Wed, 27 Aug 2025 01:10:12 +0900
Message-ID: <d935ea00f23ba6b4ea5624a57af0056214c2f495.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


