Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7272E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZC7-0008OF-KM; Fri, 06 Dec 2024 09:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wannacu2049@gmail.com>)
 id 1tJV72-00074w-Ol
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 04:59:05 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wannacu2049@gmail.com>)
 id 1tJV71-0005Jj-6l
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 04:59:04 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e9ff7a778cso2426549a91.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 01:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733479140; x=1734083940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6hhdywC7D5JRaBsBgD33rZ4eiOcKwqdK5waiOdjt6Qo=;
 b=CcAHCFXcN+vL52dammOU+4gJdR38eTCrdbCVpGBgiQXIEPBFHdO2TtMoguSdMg3aa7
 R/myaQpN6+TCGUO+rE5nuQskrjVNPn2EH/Ws8suzMWAvRpUPSmO3wlbDAyPeYjnkkoww
 MfP8NQBksoGXmH5DXWi2rV6iOQuqDfrE4jR0fMDVlw6+Stgn4fYRCKblTiKuJ12+11O/
 GsaqKoYlrUMbobCREmyrljqSEmrzsche9O878CY8m2piNVZkpddSG3+9HEyRIq14PdRe
 WxTaAOhHJ5lBEghKWfjaUi+zvEfbnx8F1E1QSspKZ+86jnguwi+I77dk4OgNJBEXezJG
 f+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733479140; x=1734083940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6hhdywC7D5JRaBsBgD33rZ4eiOcKwqdK5waiOdjt6Qo=;
 b=H3A24TJ2ccpnGMjcPgQYisFsQDkb26EOpUVGh90/F3B6F0v1zYjZHU69DF4dNpW/kx
 WFS5EPPpuUrgfGOLX+Xo/tOYIit42Znjgkkay8RhJ93x9sHis8dXxhreDzkLWUu5zrZm
 tDobbavqHAQCFuEb+2KxGvcsBMSZWcgxdXL3lNFY/6lY8VPXuTd6ooOKkmc3uKjUmaXP
 hbjWLBEEXO5Lt+OYboKSJlrwr5kGusghXYQSXlrfA7pINOv+FWIo5CyG1NaSCnoJ+t8l
 9zbc5wZ/0Lg1hHH9Q3SrS83z8VB41u6lqqvc/1/MH0TMfUpH3HDlbnycef1GgvoAy85V
 01gw==
X-Gm-Message-State: AOJu0Yw6ZyU5rT7+Iv/YqhwJteetNb9Gv1E/h2bzvy6sOJwi6yt9Aezh
 e7u61MN8L6j4Q6ejqiXy9T91LHYlLPpASVLA29mIkE1bKR6XJ53KfacuDZ0l6HVQQg==
X-Gm-Gg: ASbGnct7ovsE9RTJ/n0/SPn6k/weSOSvfTQveIryM4Brcm7q+62NTz8YWh66j7eH9Gu
 W36NsDSnhoc5wlwCGIe0Lit41nBqxR8Lo55XqL1Wz0T0qnydDJN8TOpLjfRov4cpxCFV/GVUd1Z
 Nh4Qx3+dFBK6ORLvuzhrvtMm3QBUbU1vKBBhy/55vHTbKic0h6w1PlLpflyZ1tN31P4f+SMvdP+
 aSSLFUbV9FZc/GzYAUVYS43TQRMo9pHw44siMsj6+4K+2WESmGG+4D/phjDYXU=
X-Google-Smtp-Source: AGHT+IE7iKEerPKFM7IOBOrFEhkktFUVh5dirNiMNYG+HB78zL/QOhkUbnsg+v3Iy7/L4Z9PpkYr1g==
X-Received: by 2002:a17:90a:e003:b0:2ee:7862:4385 with SMTP id
 98e67ed59e1d1-2ef41be554cmr11676656a91.7.1733479139658; 
 Fri, 06 Dec 2024 01:58:59 -0800 (PST)
Received: from localhost.localdomain ([61.183.83.60])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef45f7d7b1sm3052950a91.6.2024.12.06.01.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 01:58:59 -0800 (PST)
From: wannacu <wannacu2049@gmail.com>
To: qemu-devel@nongnu.org
Cc: wannacu <wannacu2049@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] tcg/optimize: Fix constant folding of setcond
Date: Fri,  6 Dec 2024 17:58:24 +0800
Message-ID: <20241206095824.281216-1-wannacu2049@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=wannacu2049@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 06 Dec 2024 09:20:34 -0500
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

The `z_mask` field of TCGTemp argument needs to be
properly set for the upcoming `fold_setcond_zmask` call

This patch resolves issues with running some x86_64
applications (e.g., FontForge, Krita) on riscv64

Signed-off-by: wannacu <wannacu2049@gmail.com>
---
 tcg/optimize.c                   |  3 +++
 tests/tcg/x86_64/Makefile.target |  1 +
 tests/tcg/x86_64/setcond.c       | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 tests/tcg/x86_64/setcond.c

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e9ef16b3c6..e580b8d8b1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -834,6 +834,9 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
                              ? INDEX_op_and_i32 : INDEX_op_and_i64);
         TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
         TCGArg tmp = arg_new_temp(ctx);
+        /* Set z_mask for the follwing `fold_setcond_zmask` call. */
+        arg_info(tmp)->z_mask = (ctx->type == TCG_TYPE_I32
+                                      ? UINT32_MAX : UINT64_MAX);
 
         op2->args[0] = tmp;
         op2->args[1] = *p1;
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index d6dff559c7..085efa01e1 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -9,6 +9,7 @@
 include $(SRC_PATH)/tests/tcg/i386/Makefile.target
 
 X86_64_TESTS += test-2413
+X86_64_TESTS += setcond.c
 
 ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
 X86_64_TESTS += vsyscall
diff --git a/tests/tcg/x86_64/setcond.c b/tests/tcg/x86_64/setcond.c
new file mode 100644
index 0000000000..317a7e74d2
--- /dev/null
+++ b/tests/tcg/x86_64/setcond.c
@@ -0,0 +1,28 @@
+#include <stdint.h>
+#include <assert.h>
+
+uint8_t test(uint8_t a)
+{
+    uint8_t res = 0xff;
+    asm(
+        "lea -0x1160(%%edi), %%edx\n\t"
+        "lea -0xd7b0(%%edi), %%ecx\n\t"
+        "cmp $0x9f, %%edx\n\t"
+        "setbe %%dl\n\t"
+        "cmp $0x4f, %%ecx\n\t"
+        "setbe %%cl\n\t"
+        "or %%ecx, %%edx\n\t"
+        "cmp $0x200b, %%edi\n\t"
+        "sete %0\n\t"
+        : "=r"(res)
+    );
+    return res;
+}
+
+int main(void)
+{
+    for (uint8_t a = 0; a < 0xff; a++) {
+        assert(test(a) == 0);
+    }
+    return 0;
+}
-- 
2.47.1


