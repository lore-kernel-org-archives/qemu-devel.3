Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D7BFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKD9Y-0001SE-HA; Tue, 05 May 2026 06:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKD99-0001KN-5N
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:37:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKD94-0007wJ-7w
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:36:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so34074015e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777977412; x=1778582212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyZKew4HYVFYSLa3t/vamd7rM3LzAyISeCAdtoKuGXA=;
 b=Ekp2u3j2fLLQtCo5/Yjk3A4L7mqf/JPOurH3RPdkyhBbJWqJ2F1R7t9+gx4yFIpSxs
 eoPLxfVOlIaF6KM/d5ixCqB+lhZ0+7P748Of2Xwcreya+pQzAToxy3Rv3tXzRePlm+V8
 PKNcdGtz6qPdsdHJgxzBVig80wA0sUiHwVmhW8EvM3bEqHE9b35d5OrkvUej6sNUFZlP
 GTqwsBaNKYv4GG+YCutP77/OvuYU+4mlOM2pvrpRFuTkjonbfJh+52yUGxBuUlg2FJy3
 z7sTt7VPbdHBaRSEhsYaGOQcjW9cI10tri/Bn0XgXb4kp5WYWviitx6kj1aT7C9a2raK
 b1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777977412; x=1778582212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NyZKew4HYVFYSLa3t/vamd7rM3LzAyISeCAdtoKuGXA=;
 b=XqK4bkwHN7761ok64MWzuZqAVVbv78+ZpsqPpZNz/c17+v50iHCmAnYkSSTe+Tg/oE
 q+pH1PH6VJRs4rdt+Yiuyq6lVu16yUlRKqBf9MumI5UXxSwOxlezLny5BaXUyF29yMA4
 PWu022CIDagzmEAN5amAjzpyoxxQXowjuosQIWqT9hm/6wN/sLtkGIT0yU1x7kdvHEnu
 h4ul3PkJ3ULxes2tSu1tEmMDKKTqpLqZUlsosofec5xuoj4zTgiJjYCk5hTi1iyPZvCR
 Zp4O8PlnhUKUYnzHSNVUXmJ8ZYI67YZtn6mxhWxUyS4ktNSySp4TmZ3Nsh2zqxJon87X
 GODw==
X-Gm-Message-State: AOJu0YyHrWyWq2L7UHQN829a++zF6un0CRtxKaRT3+AtxOUNdMfAlLZR
 dVk9FxBifmfiLFLvxJm4CZ1sFAJe6DAjS7PDyYEGRNfSSPqLGJA90z2VevEgVylituM=
X-Gm-Gg: AeBDiev7eveRkykEejO4NyC0xi8cNn9iJCvvg2uhMkWPkrTTg8P0hgWc0hZrsYN9FOv
 0gthoPfDIBwdN9nqidr/00tLypRERzSSQMwCpfcB0QDfk98R65kQC7fb7aPQX57IOOPzLkiYpEq
 +6xJjXreahk/uyppXluW4LbdYcqlJ7CuGFp9+8bcAW0iESL0LI8fg7OXiCHnL4z5A/ZJ24c1Zcu
 O8gcBAvdxiaooR/81TUrQTi6GswR24/n0fLfP0+x1T4b3HHGxel2o9Rcg3gp5Litc9dwLE8i0Z1
 LLbQqtd78XeQ3i74FgJ3WfgyzrsjbLX9cr8SxxLFFxMvP+Kkgw3DmmBIJo4ckxZm67NuvNZ8wV8
 vRxC3N6q1omKbTbcjOzaoAnXfunz41E+kSQRAh56K7yAS9274UQ/MlUmG5vrvXz7w53icMZ72oS
 kijGC1QRy6myHd4rFbnd6LvY4DXdVIRkgCMw==
X-Received: by 2002:a05:600d:a:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48d142331f5mr41076895e9.5.1777977412167; 
 Tue, 05 May 2026 03:36:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb3427fsm560770615e9.0.2026.05.05.03.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 03:36:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF4DE5F94B;
 Tue, 05 May 2026 11:36:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] accel/tcg: move jit thread manipulation into
 do_tb_phys_invalidate
Date: Tue,  5 May 2026 11:36:46 +0100
Message-ID: <20260505103649.68361-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505103649.68361-1-alex.bennee@linaro.org>
References: <20260505103649.68361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

To invalidate a TB on MacOS we need to enable write access to the JIT
buffer. We were doing this for tb_phys_invalidate__locked but that is
not the only path into do_tb_phys_invalidate. Move the manipulation
into the shared function that does the work.

This enables watchpoints to work in MacOS TCG guests.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3444
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/tb-maint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index cd7c32361bb..9a648f97865 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -925,6 +925,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     uint32_t orig_cflags = tb_cflags(tb);
 
     assert_memory_lock();
+    qemu_thread_jit_write();
 
     /* make sure no further incoming jumps will be chained to this TB */
     qemu_spin_lock(&tb->jmp_lock);
@@ -954,15 +955,15 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     /* suppress any remaining jumps to this TB */
     tb_jmp_unlink(tb);
 
+    qemu_thread_jit_execute();
+
     qatomic_set(&tb_ctx.tb_phys_invalidate_count,
                 tb_ctx.tb_phys_invalidate_count + 1);
 }
 
 static void tb_phys_invalidate__locked(TranslationBlock *tb)
 {
-    qemu_thread_jit_write();
     do_tb_phys_invalidate(tb, true);
-    qemu_thread_jit_execute();
 }
 
 /*
-- 
2.47.3


