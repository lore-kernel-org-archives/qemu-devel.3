Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511D2CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJH3-0005aO-U8; Tue, 21 Oct 2025 16:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGv-00052n-FR
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGr-00016x-EG
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so63482475e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079670; x=1761684470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EJemuqupst2Ai9qCdTK6nCWULI+YOTVngNae3E/sjFk=;
 b=GqRkBD8ephUjoG2C6H2jAKCULHjoTHRraRvaP+Vl+ysuaI75Uic4VA7nsFoLWOm3rt
 lN2g/x6ou/wvwbVReuqxIrqy62v9xaI/Sqlw5P70oEFoVx6kpekLk+vj8Pny9gDxwqgz
 RVvM94L68w8i0/zM3B3hCvljc/RQ3x4MEsV8dJDZyvX0L2MfOjpMXOfNXhyYenhtgzVp
 6ogSfqXUoGGnQxslOaFKA5SvU9dZmJWvUtyK9OoZEjuwdjXV4pKxKhA9o/BJPvB7oEIx
 lH/d6wgLKY3ovrzmSv1WC6fkc2QJEClVVRHHUk2sUb3Oluw3Eg1/G4GTN0D1r3kCANUN
 D2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079670; x=1761684470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJemuqupst2Ai9qCdTK6nCWULI+YOTVngNae3E/sjFk=;
 b=NI2q8zqvo6RryQEfMaCxRbhh0UCmfIljX95GMCM7RD722f3wq8Bk719fon/zVaWm0m
 jVKAXWXC6fYR37yp1B32/sPOyoHtE6tUjXCMlrbsJrXzJg/vkN1+SUEM6txAv1C7GOGH
 kbEYjF/WrdDNgLgmzwiKWrzPEiCZU0p6+z48iPKedPZTRNKgI8UarUMMEagcmdsBhkDw
 t59u/vxefFb//npyehvYL5XDnVfKqzybWxdP8/Dsj/vZwqA+Zvw9921TZIdMb+0ePCzE
 FIrYWnzZmGRllFkhMsEZJkLUU/nU0Ca8cNQK+DvoisElXakS3naIwenJ/0sclZt/4Jb9
 C6mw==
X-Gm-Message-State: AOJu0YzgS+/+vp1NH5szE3eGSCkTQqAvanr9R4//ltIgnQu6TPxACSwN
 hqIe7bdRAzLunkjOnBguFSfHzlTsrH7Ics13dEMOhQCnG2zKQM9r8PUOXGQAkMIzlcaqpcSCSnI
 9o18r10k=
X-Gm-Gg: ASbGncs9XGpxaWTDzJvPqquCBacMlfsfJ/XvxoUxumL8Og0uW6rxa94RLYK6j0nD8lR
 BWzQplHLqJWU2vM0aMj9GloVztM/q43XkYI/2pTV725drEMGEx8fnPQVji882arsZzKeIHYoCti
 ndAVOj4mczoGadFtBxfoowgUGeVfMrHHkUML8O/nPnK6W9pzOUxx6sgy3JjGjov8cZby4565ukn
 G73IyDsP8oLQOAhpP9rhr5NQmMCNGBa7LMZoT6EDQEMhn6kJ0awA3cZeHjGSXa9Wbfua68ICb3a
 2X2XNl4ZSfzd1fNVy9mZ0FyCSTIOZXvIL1VCA7VON++6lB97ORgBMnY5/AERG6wgKl19IVQl0fR
 NOBrmYdxWEirv6ejKWPfQyx1nS4EvUa7sBYziWa9QfDTa594IEqPzxdu2E7z/bc1vBO7HNAfEZg
 6IscaLVL0sLsMoSN76QMCjVtPHjv8yJAbL3EqHKAVhTR3utp83ag==
X-Google-Smtp-Source: AGHT+IHSORdgmZcUET0S8ZpPmEAoJpYctNxZHRpLR6bSm9ZYyor4wKtdDsPVf3sfNgHtvgspHPLwYQ==
X-Received: by 2002:a05:600c:818f:b0:46f:b42e:ed86 with SMTP id
 5b1f17b1804b1-4711791fbdemr127820105e9.39.1761079670289; 
 Tue, 21 Oct 2025 13:47:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c429e7ecsm9577485e9.10.2025.10.21.13.47.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/45] hw/boards: Move DEFINE_MACHINE() definition closer to
 its doc string
Date: Tue, 21 Oct 2025 22:46:24 +0200
Message-ID: <20251021204700.56072-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Code movement to have the DEFINE_MACHINE() definition follow
its usage documentation comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20251020220941.65269-3-philmd@linaro.org>
---
 include/hw/boards.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 014007920dd..a214e3322ad 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -506,6 +506,23 @@ struct MachineState {
  *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, micro, _, tag)
  */
 
+#define DEFINE_MACHINE(namestr, machine_initfn) \
+    static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
+    { \
+        MachineClass *mc = MACHINE_CLASS(oc); \
+        machine_initfn(mc); \
+    } \
+    static const TypeInfo machine_initfn##_typeinfo = { \
+        .name       = MACHINE_TYPE_NAME(namestr), \
+        .parent     = TYPE_MACHINE, \
+        .class_init = machine_initfn##_class_init, \
+    }; \
+    static void machine_initfn##_register_types(void) \
+    { \
+        type_register_static(&machine_initfn##_typeinfo); \
+    } \
+    type_init(machine_initfn##_register_types)
+
 /*
  * Helper for dispatching different macros based on how
  * many __VA_ARGS__ are passed. Supports 1 to 5 variadic
@@ -765,23 +782,6 @@ struct MachineState {
         } \
     } while (0)
 
-#define DEFINE_MACHINE(namestr, machine_initfn) \
-    static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
-    { \
-        MachineClass *mc = MACHINE_CLASS(oc); \
-        machine_initfn(mc); \
-    } \
-    static const TypeInfo machine_initfn##_typeinfo = { \
-        .name       = MACHINE_TYPE_NAME(namestr), \
-        .parent     = TYPE_MACHINE, \
-        .class_init = machine_initfn##_class_init, \
-    }; \
-    static void machine_initfn##_register_types(void) \
-    { \
-        type_register_static(&machine_initfn##_typeinfo); \
-    } \
-    type_init(machine_initfn##_register_types)
-
 extern GlobalProperty hw_compat_10_1[];
 extern const size_t hw_compat_10_1_len;
 
-- 
2.51.0


