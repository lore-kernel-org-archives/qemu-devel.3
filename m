Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18519CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MzZ-0006L5-HY; Thu, 16 Oct 2025 08:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyM-00051L-Ar
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9My9-0000PC-Ic
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so8365325e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617226; x=1761222026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F1L3ryiAtOLForkSnlIx4a5mgTyNV+5oPHRYzmv/NWY=;
 b=XSeMDNYMvxJh69204A3JYt0BwY/AqePQvQlpeAbmV1u3Uxtc5WPHA5FlMNyS+M69Uv
 M91GWhbf/o3C4/l7TjEHNCv9oZENbaqJEOEuOvX/DO6EqqSYJ9pHXY9/a6wc7TN4O8IZ
 g+/xNm2JHxDxQD3VNdT2PRv9nG/0pnBJCy7r0kQYGLuTNXwUN2e2Beq1Ttnc+8ZHhv+D
 afO1r0lalZbeFQ7Zma13YuGBS6njfxNvNJPQBnKYKjh+ZVHHQfJrU00sRL1XplJWAZUr
 6JpHVYhWmeqJeUyiwt/5u8JWueQnFone0su88vTWL64qbTSMNPHmo6SkoGJEMrG6ZyJO
 um2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617226; x=1761222026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1L3ryiAtOLForkSnlIx4a5mgTyNV+5oPHRYzmv/NWY=;
 b=pwOmYdzchUleB8aa/sFNU8jwSVJuCaqbirPyylFME19puFGMzsPoYPIdM3xhD7nMMr
 WfxLVUlQy2BfsSCVNJkQiiHubjlfpK5auL8EjKK5UkKFSfMrKPO7G3OkYuSNgpOsk/8+
 In6zlpcprhjmQjqZY9FSsVIO40taGiwVS7TcY8SKTw58cvCGqcLufNTZ4pDovVgo/a3U
 5DKhhZMvtQE7nvTrja+Ko+GsXpi/UKRrVGsOm3jH+D8OMiLuWJe4j9e0UNqhDuiYi2Yt
 5/0t+Dbz1QAX9XPaiXX0C/sWrSSUe3IAzjd4ukyqXMfVIdbdApg5l+/JcoALquiQ9QF7
 zSxQ==
X-Gm-Message-State: AOJu0Yx8UylkfKISyEd3VwMJQoTX9ob0woNfYVNdrWECZufXBSeSWgLf
 BvtAr4garaR5Y7oTWyTPtmR4WrStvU41I2qALpLllnQ+pR2YHvJcduYuoch6Xj1RwF7Mzl0EKHT
 ANh7GTv0=
X-Gm-Gg: ASbGncuoT9ikcCzlrTziAMsxuMUslElWXUfFk8XMhCz1WZ/c1Uwxg5O6NjyBh4XkUYg
 GelqW00A1kiAfJESWf0nlpIIVMxuqnPLFSezaPG3l4PorE9vcCVqdH87Zg4U2U67ZgYLnw0cH22
 NiUzDqun2xOPzeTB89heOrWYIJWMQOQnN0X5sM7jthSEzW7MsRru+HBzzGDI5tPrOCjL5cDEXkr
 c7TKYXhsaxs1o3HdiM9qZwDNnsLlndemD4nIAGm1T7XnhNUwcifFxBGYIMR63mCRigKo0gR230z
 oW9QmrKiBOt2Pvv/YC3vn00ojKvapARVuFEx9F3F/ISs1uWMpAWvfn87cvJV8Yw4koUHruCK6mu
 t8h+F5X1C6IyFqDA+tvXOy58w766ksMdXs/l4x2fmMDJhr8yHd685b7cI6lCpiTA8ZItmv7QFq3
 ORq/BJOto40wX6bwY+ZxrnW85HvOUbTTcL1Sb+uShDXnfRYyokNV36gw==
X-Google-Smtp-Source: AGHT+IENOn6EMCz8Zbv+AJtQvUjFtQGjqM5FRsWNpBo0Nv4/tiVnOdiMTcEfrqIS8+hjPLNXV7tvAg==
X-Received: by 2002:a05:600c:3510:b0:471:56:6f79 with SMTP id
 5b1f17b1804b1-47100567214mr39723985e9.41.1760617226286; 
 Thu, 16 Oct 2025 05:20:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d49bsm36019552f8f.10.2025.10.16.05.20.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 63/75] target/tricore: Remove unnecessary cast to target_ulong
Date: Thu, 16 Oct 2025 14:15:19 +0200
Message-ID: <20251016121532.14042-64-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010052141.42460-6-philmd@linaro.org>
---
 target/tricore/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 4f035b6f768..04319e107ba 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -37,7 +37,7 @@ static const gchar *tricore_gdb_arch_name(CPUState *cs)
 
 static void tricore_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    cpu_env(cs)->PC = value & ~(target_ulong)1;
+    cpu_env(cs)->PC = value & ~1;
 }
 
 static vaddr tricore_cpu_get_pc(CPUState *cs)
-- 
2.51.0


