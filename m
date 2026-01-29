Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAF6D46BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtL-0000E8-Dg; Wed, 28 Jan 2026 20:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt5-0008SF-RF
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:00 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt3-00038u-Dy
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:59 -0500
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-34c868b197eso271626a91.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650315; x=1770255115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OH3PLjNDO92jjJzSdzMO4KAOeEUQIYziGK0Y9gQ2+fU=;
 b=f3Rpv77z9FrupjYLk6VLZgi4UoPwUSMrtHTY5TCvXhwgJpJ8vtDS9zc99pLTOPFeqC
 mP4eFu6RSjXZtynnL5kym+C9CD5x7T22BPd6hkkabNQjXnMHKMf+vSDhW5OPYYMmIXeG
 TfSwOBgx7l6bhBMpHg3QcGA2T5Uq14zn1ZI9Bw5XE3xwlcy8mV3oLsCzMGL+RyjIFdTH
 /awRYhUXcvK+XSt09WI0JYqtxhtASkNFXk+BJrIktCVbHd65M9FtRwJhq4QF130I6bLg
 mfkjXidI+A9vE71+4QKRYQVLziy9m61kYgI/9YACPZfLnkR/ZT7uS5YqOfyQrdPVnsei
 tIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650315; x=1770255115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OH3PLjNDO92jjJzSdzMO4KAOeEUQIYziGK0Y9gQ2+fU=;
 b=BAu6/SOyd+HkQeLsG513Yqrw5j4N5rhDn2xEipL6wC0u/lwC9nSgz7JXiQtDaTJ7AJ
 DmpOZkHp9VsrDcYZSIt3pYCxdZUxGu3pw+3D8utX917+ss/G3o+Q9ozLlFV/Ahzo4aqW
 tb0LqChaOjS7ACZH/46UtBI7Wf7X2hA8P8pS39WcEiQmYZFoxABDb2YF2qr44B0rWuxg
 s8OGyZgb80aJRws+kdTkXIL2+Kd5Y+T9KpU/sk0J6XTtSdJqGBM7dsIyBbc1cTLfxDgZ
 Paxt5xrhcl5ODbGwpzLWi8aqg9QwaRMEkAYFpC1n+R3/7aGTydIubxXj1gnBIYcAUn7n
 L+Dw==
X-Gm-Message-State: AOJu0YyYz0txZrp35Ga0JBXlUhgRG9SkK2ErhzQwRNFioSR/aCs/Yju0
 HwUosHC8kQVpOZFpPGICAx87NJ3CWyYQksm0Mrg8mxfrVKQG0jclsp+lM4JZ7XmKgbHBUBmGInU
 a+XgFkzw=
X-Gm-Gg: AZuq6aJuoxYlPXGvXjnroke7IB6BWFYKi4ymA9xgPlBJN5Vnx8P2oZu5zQqbPVoQwkP
 gDHBsCbm6QyhS//0qviygZACDFZIDzheS7dWFQMNeSK8Mg6wzwjgMyCID/wKa5oZBk1bx45nSxA
 K+Z1mTgVSE0ndGkUL6d8zkzKqVaperqe0zUI5mImGnf7odP/ahRVwdAjQYs7JacsoEb86eLAbI/
 qVVUccxPOFO3hdRZXiqX89gKdu9SntKTo3NKcXQz+rdl2VDLSLsfdsvn+9MOb24lRW2na3Zd42v
 ERmm7E5momv+VAQ4ddJy8zE+Bv2iUwqyWUoRtqktP26Bb0cnAciIyQqLNLvzA4Xy2XpFl3JobGU
 Kdw4M0IuOMFlDEGDwShXz0huhXI9mrV1unrpD3+4qmj8CsQSVcuR9P/Lnh0cimmYglGwGuuoqvi
 xjljFjmym6DIalpmPuj+hN/NlkgAKpEryUGYWCVn6iNfLWzVtk4+izesxa4rBUZ5f9
X-Received: by 2002:a17:90a:c2cb:b0:352:e796:bb65 with SMTP id
 98e67ed59e1d1-353fedae2efmr5901021a91.31.1769650315104; 
 Wed, 28 Jan 2026 17:31:55 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:54 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/20] plugins: define plugin API symbols as extern "C" when
 compiling in C++
Date: Wed, 28 Jan 2026 17:31:26 -0800
Message-ID: <20260129013134.3956938-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1042.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index eb6179ab1ab..7f449d1b50a 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -16,6 +16,10 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 /*
  * For best performance, build the plugin with -fvisibility=hidden so that
  * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
@@ -1245,4 +1249,8 @@ void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
 QEMU_PLUGIN_API
 uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry);
 
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
 #endif /* QEMU_QEMU_PLUGIN_H */
-- 
2.47.3


