Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFCED1815E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 00:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Va1-00022L-05; Mon, 14 Oct 2024 20:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t0VZz-00021x-Sj
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:38:27 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t0VZx-0006BX-O9
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:38:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20c70abba48so31165765ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 17:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728952704; x=1729557504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sKdTmWQZMuc+B9+0ZkccinXkQqU8Wb8KTqtA56Nb0ww=;
 b=gU5GreiVKkb7eQjWUok7okLqF0JwJa33WbKI7JU3uBx+QoJgh81TUWGfnE1h9riPxB
 dupkgbrP7X3iQSFUhE6kVPFgDxuuqAY9wI2UV7trK7vFM6NM8m/jhqhkdlvGSuRn+Gq0
 GzZFHm87ukM4S6sl1XGdkF1wtrun6jc5w5ob6Q/Totqfgetj57FMmiU03RV+U/uZlwcy
 Fqac14IJ2QeEJH8EPJahRJHHchTITQ0Y3+wchtYGjBIBeD8CTbE1AUV1k4+5m4Fb8aNJ
 BfsNKhYmYx5TNUacZzzUOd6Xrm38ZU+7oQyzO/utPxYuDqD9a2q3JLHQpF/87KLcagLP
 9Hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728952704; x=1729557504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sKdTmWQZMuc+B9+0ZkccinXkQqU8Wb8KTqtA56Nb0ww=;
 b=Zl+lwCJb4tNqiIr0Rm985YrK+/r4vRVmZX4MApqyQEZSgtJ3dxwHIQgxpus4cSV0i3
 +DBQDVGe4BLbPU6zpQUuAICWzHOC6uaWFRKIpy0KJ4q81auoTpRqUbFLGiJRqUICvWuQ
 ku4Bu+gp+EsoulS0KroouZeRYj+F2XR6sCRp9ntXYATe3wpf34Po/9izMHmvd4jC3FG5
 vN/MEeLjvJlyGBgUsGRvRVgwUsBvERfGfGmMdbgIfPBKSyVqXfghusIWuEYxzgesO/X7
 NT+TRLu2jG7Bu77VqM6OV0aZ3AcdLaB7f6G7HfY0Qnwspq/DoOylxrI7EkIzvOxZBc0k
 TWvQ==
X-Gm-Message-State: AOJu0Yy79paAtFKtvNfnUnUyVlEQwYejYHAljwer8fJGmlbgMWjDeOEX
 6mCpjtNgEX+/KsG1vhM6kxx5abfmt7zo5aqGIqBkRSMSLsrreGEm7Ck725dGup+utfU41pY2v3J
 QeI2+nw==
X-Google-Smtp-Source: AGHT+IEF/Nb1GjcoCsKN7q45hD2eSxOY4BCJEqVmuHgpOThhtCcQ/gpkFAF7c49lZcnJTJsEuUJCSQ==
X-Received: by 2002:a17:903:41c1:b0:20c:6392:1a7b with SMTP id
 d9443c01a7336-20cbb18355dmr181925455ad.2.1728952703750; 
 Mon, 14 Oct 2024 17:38:23 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b716sm1287345ad.202.2024.10.14.17.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 17:38:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2] plugins: fix qemu_plugin_reset
Date: Mon, 14 Oct 2024 17:38:19 -0700
Message-Id: <20241015003819.984601-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

34e5e1 refactored the plugin context initialization. After this change,
tcg_ctx->plugin_insn is not reset inconditionnally anymore, but only if
one plugin at least is active.

When uninstalling the last plugin active, we stopped reinitializing
tcg_ctx->plugin_insn, which leads to memory callbacks being emitted.
This results in an error as they don't appear in a plugin op sequence as
expected.

The correct fix is to make sure we reset plugin translation variables
after current block translation ends. This way, we can catch any
potential misuse of those after a given block, in more than fixing the
current bug.

v2: do not reset tcg_ctx->plugin_tb as it gets reused between
translations.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2570
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 2ee4c22befd..0f47bfbb489 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -467,4 +467,8 @@ void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
 
     /* inject the instrumentation at the appropriate places */
     plugin_gen_inject(ptb);
+
+    /* reset plugin translation state (plugin_tb is reused between blocks) */
+    tcg_ctx->plugin_db = NULL;
+    tcg_ctx->plugin_insn = NULL;
 }
-- 
2.39.5


