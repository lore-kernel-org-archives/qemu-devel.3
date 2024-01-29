Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E85C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadw-0006Tb-6e; Mon, 29 Jan 2024 18:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadn-0006Ay-Um
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:13 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadl-0008Rf-IS
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:11 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3be90c51299so67889b6e.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569327; x=1707174127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Gt1CNQckx8yO7WR3bedyoAfBxjm8E850nOtIhoFZIA=;
 b=liAm0qEGAT5CPMNMTF74YVhX58qk/Y+umBrY6r48Wv6mtypzrWQBknZg5QpoUhPAIm
 iU2R5S7FwgySpQiZKA0azdRl2Z4ZtW7f8NKpcf7r4nwll4u+Qc6fS4uJxOtsWk1AjhPA
 /9tbi12o2PODK2tVgt1fifrOT6HIjBvzWjd+tYt0773mMjl6DRnb+mbKwkTcC0TqWQKA
 HwAFm5RNl8Y9a8+TP797R/FkFniivc7k/edb3q2DbUlMic92ZpzL6TazShwBApcJxyGo
 AU19mSQQLab26c7pWd7DZxtAmXc/A2XefqMuNTZvAlidv4uNDwUopNQKzX5GbEYYYgga
 P+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569327; x=1707174127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Gt1CNQckx8yO7WR3bedyoAfBxjm8E850nOtIhoFZIA=;
 b=YK7lrNKtVAjeNM/luNaHliBKANDQMlHAamDqbPvWFR9dUfzLUIEL2djGDP+Gnp+agj
 +EAk7vBq4NIF3Moazi0i9AKQrc7dQTqVoLRCzm0KBjyaMEPu2vzb4VRSA6lEvSHKZA73
 pp6QS7/b5d81Ki1ETKzLas8Te7QqEcd/7OWbq29QR3aaVlxQUZgbPXdob8V4E+2RwDPD
 ejeXbtHBbhlA9M21pBPksZH1AfajuVrUC/69DmO9Ytue8hSQZfNQnfD8zwgB0bX17+oA
 htQJG2cgmP6QvMo0KGQhxzZLQfUIKvhJ56XfVgCr3kNoNK1YjLxb+ajK3g637OEhU0bv
 OoKw==
X-Gm-Message-State: AOJu0YxredOa74n3WJw/CejsiT5zAlKU6saRXvpWthKITD+01a6tethv
 jqdlFCfoih3sGhWEcgWy6aAxzBfKlc/xvM3RRrD8TlHz++OAbnLV6qoxiXx1YDdzGeBECssAKR8
 uQy8=
X-Google-Smtp-Source: AGHT+IGl5qkCFKV8jIy/9n/R/wMnz/o+NTrEd9xwkYZw7NxskIbfImC4zvTj+MHBOr5qf8iaojxL4w==
X-Received: by 2002:a05:6808:1805:b0:3be:7a42:cd5a with SMTP id
 bh5-20020a056808180500b003be7a42cd5amr1782905oib.46.1706569327067; 
 Mon, 29 Jan 2024 15:02:07 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/31] target: Make qemu_target_page_mask() available for *-user
Date: Tue, 30 Jan 2024 09:01:05 +1000
Message-Id: <20240129230121.8091-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Currently qemu_target_page_mask() is usable only from the softmmu
code. Make it possible to use it from the *-user code as well.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20231208003754.3688038-2-iii@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240124075609.14756-2-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Split out change to accel/tcg/perf.c]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/physmem.c       |  5 -----
 target/target-common.c | 10 ++++++++++
 target/meson.build     |  2 ++
 3 files changed, 12 insertions(+), 5 deletions(-)
 create mode 100644 target/target-common.c

diff --git a/system/physmem.c b/system/physmem.c
index cc68a79763..5e66d9ae36 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3431,11 +3431,6 @@ size_t qemu_target_page_size(void)
     return TARGET_PAGE_SIZE;
 }
 
-int qemu_target_page_mask(void)
-{
-    return TARGET_PAGE_MASK;
-}
-
 int qemu_target_page_bits(void)
 {
     return TARGET_PAGE_BITS;
diff --git a/target/target-common.c b/target/target-common.c
new file mode 100644
index 0000000000..903b10cfe4
--- /dev/null
+++ b/target/target-common.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "exec/target_page.h"
+
+int qemu_target_page_mask(void)
+{
+    return TARGET_PAGE_MASK;
+}
diff --git a/target/meson.build b/target/meson.build
index a53a60486f..dee2ac47e0 100644
--- a/target/meson.build
+++ b/target/meson.build
@@ -19,3 +19,5 @@ subdir('sh4')
 subdir('sparc')
 subdir('tricore')
 subdir('xtensa')
+
+specific_ss.add(files('target-common.c'))
-- 
2.34.1


