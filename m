Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B14FC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgmj-0006ps-Af; Mon, 24 Jun 2024 06:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmg-0006oT-U2
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:50 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmb-0007hE-4i
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:50 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57d15b85a34so4241182a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224324; x=1719829124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAfr/ztELiK85W31P9IhL6FxEJ0DWBMMSKgHmbUooPs=;
 b=KOfxYaAFT1UKAmg4PtNEYKJLeVpQId1II0wF4//OI2nQz9HG8eWEGR7ditNAUJ4WM0
 DRhGp5X0AHgbTeOxND8vJsyTCytj8S/9EtxULxP2+dCs+EI8RjeOxMxek8w0N/od+wHB
 XCd+sNWIwK4STat6GugT7z6Pj+B9wzFqKR9v+Eclpazj2BJ/cxDYgER7vci/hcl3Kg3T
 ZsbpbFKdXH7hIBbkPo/kF2U1Su4l2lBuQ9AU4b+o88kUAjz6LcEk+D8Zn5YNTWWokuqT
 sC4ovrGDbUCiLtKDYq+28LZtDXKib92HTf9sgLOWYyv7CwO8+vt6Z2TeyQB51Xk5HnSX
 sb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224324; x=1719829124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAfr/ztELiK85W31P9IhL6FxEJ0DWBMMSKgHmbUooPs=;
 b=qIGOUKb3/ugrb+ynJDU05ikpCnqn9jCV8ymSDUor7Heru5IY42p81OGVhUfpMN6/8A
 oUU6+ORx3ZwKvGuFDweg+qWRXdpkDspH5LLbirUprjIeUMV+qB7DSbTP2as/U2JEF7Yl
 pMTPJFwdyw+IyK6wNFtHEYvH9qehve3SinGWka82noDQWegknUiBs6zuNfjba0KOyIgN
 XPgE+AIFu+lEhDLgwv8Qxv9JaI8b0vUDvP99mSteVcCAGR4rRmgspFjjNqUXxnlLG74h
 T4+9eXOxNR9kGtxXIh8hjZ87JTREKQKPArwU0nAG3kONClVWQW4dDP7lu4/Gxga+GBqg
 hXoQ==
X-Gm-Message-State: AOJu0Yyk4yTMe+ZZCg/J+M6p/eOIPa1GryE0SabXooBbZ15k8vSz5CYw
 OzeJvUN1VPv1ypvlyoMaJw+z7RKUiMf4Mc2A8FLJO+6eY1dIaBfjHf3C1eyJo6o=
X-Google-Smtp-Source: AGHT+IHywj9LUyqeOsx78e4BQlmYW5gn9KolicYOr/jxUBNZHGqIPULzIO3kQe4lYDSbzE50McHCwA==
X-Received: by 2002:a50:c31e:0:b0:57d:1756:6bb1 with SMTP id
 4fb4d7f45d1cf-57d457f622amr3054576a12.31.1719224323540; 
 Mon, 24 Jun 2024 03:18:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3053510asm4546151a12.74.2024.06.24.03.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:18:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 66EB55FA2D;
 Mon, 24 Jun 2024 11:18:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 11/12] plugins: fix inject_mem_cb rw masking
Date: Mon, 24 Jun 2024 11:18:35 +0100
Message-Id: <20240624101836.193761-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624101836.193761-1-alex.bennee@linaro.org>
References: <20240624101836.193761-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

These are not booleans, but masks.
Issue found by Richard Henderson.

Fixes: f86fd4d8721 ("plugins: distinct types for callbacks")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240612195147.93121-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240620152220.2192768-12-alex.bennee@linaro.org>

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index cc1634e7a6..b6bae32b99 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -240,13 +240,13 @@ static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
 {
     switch (cb->type) {
     case PLUGIN_CB_MEM_REGULAR:
-        if (rw && cb->regular.rw) {
+        if (rw & cb->regular.rw) {
             gen_mem_cb(&cb->regular, meminfo, addr);
         }
         break;
     case PLUGIN_CB_INLINE_ADD_U64:
     case PLUGIN_CB_INLINE_STORE_U64:
-        if (rw && cb->inline_insn.rw) {
+        if (rw & cb->inline_insn.rw) {
             inject_cb(cb);
         }
         break;
diff --git a/plugins/core.c b/plugins/core.c
index badede28cf..9d737d8278 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -589,7 +589,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
 
         switch (cb->type) {
         case PLUGIN_CB_MEM_REGULAR:
-            if (rw && cb->regular.rw) {
+            if (rw & cb->regular.rw) {
                 cb->regular.f.vcpu_mem(cpu->cpu_index,
                                        make_plugin_meminfo(oi, rw),
                                        vaddr, cb->regular.userp);
@@ -597,7 +597,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
             break;
         case PLUGIN_CB_INLINE_ADD_U64:
         case PLUGIN_CB_INLINE_STORE_U64:
-            if (rw && cb->inline_insn.rw) {
+            if (rw & cb->inline_insn.rw) {
                 exec_inline_op(cb->type, &cb->inline_insn, cpu->cpu_index);
             }
             break;
-- 
2.39.2


