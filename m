Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8C5E77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3Z-0008G0-OR; Mon, 16 Dec 2024 20:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3Y-0008F1-42
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:24 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3W-0004wx-I1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:23 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-725ea1e19f0so4061837b3a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397641; x=1735002441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpYSyAxaLUq+FGwtpjTxiPWQf+sG11OxsgGPSOFXX90=;
 b=BAmxLpaWwOebhMXJ9kmN0RLdGULlDqhR6LTk70deW7jMBwMOxKTuH+Iv2tJPf7cJGZ
 YVjNpKfleITGxjCxfHAmqTerH6neLR1F5xzJklD4nNTdlWjrp7M/PpA1MKpIJ+Vh27ea
 HzsfwYO4cOjDvkHH2apzJe1AM1mgSLSs5schFqbc1xwN2TnpWfiRXfoFNHwYJJR3+mGU
 8UJvCUujW60kYvCAWEQYVBz9vPOHfur4ueQ1p0dMMyagXSPW8vuDILia4C2FiOx6upcA
 AAutqQtC/a6VPmPT7o5WFlOXBaGGBbZKUqbnQmgZr7bakLmw5kF0VIBIVVblF8wRkztM
 cHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397641; x=1735002441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cpYSyAxaLUq+FGwtpjTxiPWQf+sG11OxsgGPSOFXX90=;
 b=uhcgrVA3Ze7zQAKQ3s7nwmwUbx002mF/6Q7aH3zKv9KyGVsrPDwm2OQGr4UPWhcYJ7
 0kBBYVvlAgxXdsvxL3FshEc9jvfBaSDiC4KjmCuRx44sBlv1ujEJiIiJP1aMlv+zSF0P
 ZfUsIh0AVvnKPHflXMvnyLF4cvTdIOq6XdhdUa+WeJZ0vgfNRy7HccJBF4P98SmnMj2x
 QaYSyGRjtOciz/3E9SsBmnjerEWK5Z27o3tWe3If81TjPmrAI+PR69vBqTkf67qnvs50
 L3Z39lYhgTcljq7leHWpoGbuTQBRtuWDVKlv73uwOW6BmUsGbXtLzs3WHcVIN/KsKCBG
 hW/g==
X-Gm-Message-State: AOJu0Ywt1EjQnNx7Ps97iTKHvTa306E8ZADJqG+lr8mY2lyKLUA9Hr3K
 D7pErUrgMK0IS09OarBnBK8eCQOuZTud5QNfwyFN2vLuE+WloimmteB/xCgxzRzEaMwHe1NmuKc
 3JWE=
X-Gm-Gg: ASbGncsk22szbEUqwlFy+Oycu+rBaml67pJkJ8UsRjh8NdiGQuMgSWHTg+Fn88L/Ik8
 FM0EoYBwrDKr8tNXmAzWQz82Qh3w+/6IyHIcbtO7DK0qG8HdArw249kGPxunzc252W3H5JTE38C
 3YOxMBf+Jd/ukzC89efO2swgMLTn/y5hWDLy9GG2RXeKurOLsv73eeaXnW7A2kDAQnZ09Re2By0
 yXRrlckKvYiikvRZQLxDMMspm6Da3w+nXQ4rr8QiVWA+i61waAB1lVhmjfgPIfKvs+U8ruvv6LR
 6nhDtr4o8UN7O5w=
X-Google-Smtp-Source: AGHT+IGgMwLIejFXHA2j+fWM6tnhOclw65kr1QPJbd5X1JjU6qa+UxtcQNaOJrCSBYQVQzaOzjJd9w==
X-Received: by 2002:a17:902:db09:b0:215:83e1:99ff with SMTP id
 d9443c01a7336-218929c7077mr182728545ad.27.1734397640793; 
 Mon, 16 Dec 2024 17:07:20 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:20 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 03/13] tests/tcg/plugins/insn: remove unused callback parameter
Date: Mon, 16 Dec 2024 17:06:57 -0800
Message-Id: <20241217010707.2557258-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/insn.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index baf2d07205d..0c723cb9ed8 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -150,10 +150,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
             qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
                 insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
         } else {
-            uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
             qemu_plugin_register_vcpu_insn_exec_cb(
-                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS,
-                GUINT_TO_POINTER(vaddr));
+                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);
         }
 
         if (do_size) {
-- 
2.39.5


