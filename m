Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9267CC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 22:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEz4d-0005cd-Cl; Wed, 05 Jun 2024 18:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEz4b-0005be-8W
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 18:25:37 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEz4Y-0000a0-Re
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 18:25:37 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f8ec7e054dso227418b3a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717626333; x=1718231133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4BXgNd5mbAZzdgvAl/4xSksxb0/U+w+FNHu31ZnnMs=;
 b=doy5j/XhYUX6+9kyK34C20wLUjW3MH+L9OXcmCykHKp9QY0Alo1dFSpHzx4SOleF8+
 i5jio2KLIRlq+PGI3ILZAcGzCbPRLeNi7HmCdLwqMJMDB9+YKZAVuy1LAe/YrWAVXc7p
 B5uK9xQhNSt1nZfS8yBJusRpEfxEYLf4FiPi3+RPf7xvXvwCjT5lh0KAyMt9Z0NcY5bh
 RtOPypFJqq+k0bY1mUfphE9CnKvM+Onsfrky2m4sXUZ8SzWUJNeAuW29GO0O0hRXbpl6
 CmjYBGrQi0fXM+jJZKPt0ZTzj3rMCKAiu40Vgs/z/vUNG6Fm6be9yxynyMD9xQ7bkiTM
 bLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717626333; x=1718231133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4BXgNd5mbAZzdgvAl/4xSksxb0/U+w+FNHu31ZnnMs=;
 b=KEdRrAOCmJjB5oejr1Rzvj9sxDRBO8UbsuV/LwmB3nXw10bdCuEB7CWLSUxq0H4MYm
 h+vXdNZGZtI+Xi+vK7zgpysdA4ENYwM6eRjXv7ckB3HStCFPRAGriNRrFiL2MGaqBrqp
 ha6qC6FBvjrFP0wdLh3xJftHT59LK5S5G5Mp5Jo3O3CxHRpuPUCF5hcwhPc7iDDb6rX2
 lYnKG0V4jpDSejwNbFz3Y8Fo/n6O48YqYp/2olX22Lqn0tegR/OVB5tTwGLMoMwAPf4T
 G86XtHq/6a5E56HE8x9wlxQyJuf9yvZnBnDImiIWjf+bDMMHtv84QcXPgRdr4Y9B1Ux3
 yIhA==
X-Gm-Message-State: AOJu0YwljbsLhreRgCuPKds7JohcgAttDGUdkNZPCEODBC/CD5hTOvmH
 8GRK2ONGNS34L3OPKprmMEHX4BfrOGA4Am3yCi22CV9n5frJ9ID4o9iL77F0/tmxWhHf6/QP5kF
 e
X-Google-Smtp-Source: AGHT+IGcxlM2ZUTW72j4ScyntcdCqENKNj0NDZeTkGpj73SS5fxuyZnyYoZTHi8ESQnddMQ9wcFXaw==
X-Received: by 2002:a05:6a00:1903:b0:6ea:f351:1df9 with SMTP id
 d2e1a72fcca58-703e5a1bbf2mr4613217b3a.23.1717626333182; 
 Wed, 05 Jun 2024 15:25:33 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd3721edsm11775b3a.13.2024.06.05.15.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 15:25:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH] accel/tcg/plugin: Fix inject_mem_cb rw masking
Date: Wed,  5 Jun 2024 15:25:31 -0700
Message-Id: <20240605222531.28399-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

These are not booleans, but masks.

Fixes: f86fd4d8721 ("plugins: distinct types for callbacks")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.34.1


