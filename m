Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055FAE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgD6-0005LA-7l; Tue, 17 Dec 2024 17:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD4-0005KL-Sb
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:34 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD3-0008Py-CC
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:34 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21619108a6bso44649785ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475111; x=1735079911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpYSyAxaLUq+FGwtpjTxiPWQf+sG11OxsgGPSOFXX90=;
 b=RpVSQbpdWQtYS7GSDup6V/gJGbHnXQOc6EwCfYkYq9/JUC+N+guasQ9JPO++lVwH2a
 aG46RKmUNBa98xhFgRqHFmkgsmpVq6ZUc0OgC+rpBZJzU/RCyNOZWHsP6xBEGIaYNAC5
 DrR85nd+eaVO9VQd3IlS1HgT2MeMLieZEXrAZ6hSazpBgNsCkq4GB8LEe3zyO+rknBXv
 KmjS35kV7APxF/9p+J4quE7FbaIvHMk0m5j1KmfjeQkc6rtPk4WPF+Cx3sE+pF3gkEqo
 S4NPpzpxUFSiogMghgGWCAm81fz3AWPQY014IySEA9O8ZeeaD/zI/GtWF5AEKQvEjVTr
 RDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475111; x=1735079911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cpYSyAxaLUq+FGwtpjTxiPWQf+sG11OxsgGPSOFXX90=;
 b=gUg1unI4tjvtDv9x1bggSXBvQrPAm9U17QqK21EZfc0J9Dapwh+DlXqJjnDOJllSxd
 XtejdZbE1gSFHGKPeseT/grxJnMDk0mPpihGMirc+WCn83/mwT6R8zaAqDUXnFIMOSZk
 +vw8zFVN239O0Ed95/qUQ3wCcLZ68m5e9flbhhLrYGp6J0pj22+CdEA6Tje4CBGVC8vH
 IziZZRheLOfhHhRdx4TEt34GmjpBU1PRJ0TJ3BcsWopwca0cimbiZfnv1UyAc1GrVlO8
 LgymLoTyYuHU0cgNYQvv7zrn4w2NMoPJDX0Rgrskmvt1Fwxb0hXPJGWoRvsTw9G1jRsu
 1x/A==
X-Gm-Message-State: AOJu0Yys6yCf97Zl3s+ZRZhVb7wVOzoujxVX+2DcaqG1ei1frjDwlE4A
 g5aifaEUgnniYT0XbhNHrDH6K1mgIdA9x0WTYIolHTSPVz9MsLPsVPN+eG1HjhVUvBTLeOvd92x
 loys=
X-Gm-Gg: ASbGncs9DuhI036Zx2cpzUCNM8A3eKYtAvYGVvXixtxPmpRStkrn+cvIfmzeXXXaJ3+
 m7zesD+VJ9WkUYkgzXTFau4ryKuig7RX0PMn1Rchs7UZTEv5r8a15zkABQQ0dRsVVPZ7FPhvGuS
 I4uzyPpVbTm3xN5XcLtO+lcMh7ND+PaUeRxQ0ri6EIuQD/VEOLUrRyistSGYreZbYhCdO2lAzqO
 mH19QMwdrSM82ZtRYAhmIg+WIyjsDHi8s4617icyq3Tc8HjqkvDXDIZ
X-Google-Smtp-Source: AGHT+IE0aMTaRppZDa1Iz1fHeMP6RwioW0BWFwnykOB85WKRLdUstEN9COtwp4GYcFX3gcXWVd6NRQ==
X-Received: by 2002:a17:902:e88e:b0:216:6283:5a8c with SMTP id
 d9443c01a7336-218d7249598mr7645705ad.39.1734475111497; 
 Tue, 17 Dec 2024 14:38:31 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dccb03sm64869465ad.98.2024.12.17.14.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:38:31 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 01/11] tests/tcg/plugins/insn: remove unused callback
 parameter
Date: Tue, 17 Dec 2024 14:38:15 -0800
Message-Id: <20241217223825.2895749-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
References: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
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


