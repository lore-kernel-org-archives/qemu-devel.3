Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C184E7FDCF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnExS-0008IC-Vb; Tue, 03 Feb 2026 06:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx6-00081Z-UD
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:20 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx3-0005BL-7h
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:16 -0500
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-b884a84e655so808454266b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770119531; x=1770724331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbT8qqcdeI/gjCIg66X1LOjHgngepJa584e/oDIZWu8=;
 b=If6sZxreiAHlYUsc3i8S0cJGNqjNhF/cLqtlEagvSB7wNMyVNUFRc0yj/7/joLLwZx
 KZGVJTt8A0u/IMX2SyKeY7PbkniAmIFxzBR8yvIof5bFc8Fa4N9jXN76zHrNlWPqUH4z
 Yete8AwQsqvepDfQgw6GQ5MOhhIAvpDt1Jcw/DqsH0DZu/ZHQqJOFb6DAkbAZGLgrOpZ
 wFRhFFKKa1MOm0xNdqFXuRXNW5tnEJ4jNPWYizFNJNIOP2m5cMA+YODmik1s+ZZuqWL+
 XvnaI2Pn+eLkq3t+1t5Dvk5Nqg7CHslGwlmj4NKCzMPJ4rO1VMn120dUxIMmi7auINsh
 jHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770119531; x=1770724331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bbT8qqcdeI/gjCIg66X1LOjHgngepJa584e/oDIZWu8=;
 b=ZpWDbe6DOiru6s21BZotN40uNIzTzYHo/PgN1gNVVc3/+4p6/U8aOXO2K0mrm9iYvl
 p+ydC2QT6XfxPdPZSDOgHkhmdseymOuhHF5Hysr+E0W4N8ABoOLPjN9VMQ56RU53UfM8
 UDCcr2Y30wGl/Qt3fsQHs788WsYiJVhO8HxAlphuvrYccqzjtJyqGIIswxP/+W8VrpSz
 3b9oMx1GbTkF5SX2HjUp+3Q9oZtUBo+1V26rcXtkdtG3PSMoOJ0RdeSvClTV1sJBh+fF
 buiLbRhFM0Qaf4uJrDTuTT3wga0CavvfrUzMrjDrHhuWA6KPJLr8ujSH/X3sJTrk6lQX
 8ibw==
X-Gm-Message-State: AOJu0YxWsF8e81uij6h79GUdfMucguMw80eYMawlY4UsZzWi2sj2u7GY
 Z236XMXRSYzh1OAZbhXD8remaEDkv4H23PKAgw7WKWQc8Bw6nBZk5NWGrzn94W0DhB0=
X-Gm-Gg: AZuq6aJpn5dh/rvKWshMQXJxTl15P8/uLtiSGMo+l8EDJfqO+cd9ZIHVA359p7P4CrA
 MPXyMQhnQ+/Lp2mO3wxekWY23C049t6Gl7JZW0UkQSogH+UtbHiQFr4r8pESs9FR6iGiKCfCTJn
 R6Ufy2BpbnD4cTjB4BuZZpIB2ehNiWPu+hRymoRcIx87rOkIAi9AXzEi/CIMyXpCRZn16eEygV3
 RyZt4qnXTNaHrcU2RDscjLOXs/52GLFUBiQc8JRvhY5mkEw4IYPi8ZKBfseuJZR3ZANe0CWMl/F
 j3xe0qYFZ69izzDgC/6v6uIVGhreRh0ajyxq2p4uwpwwjhJFQyzIEER5GJC5z34FysByTz2/xvD
 rsISAqcrCYjHSmcvamHfoEVUDnI42vihU4aUDSzHbx+bxmJt3cosHGP8nK9XCBOpzDEf7HL/+tf
 N4USGy8NaUek8=
X-Received: by 2002:a17:907:ea6:b0:b8a:fc17:56e1 with SMTP id
 a640c23a62f3a-b8dff56b0d8mr1054983466b.6.1770119531446; 
 Tue, 03 Feb 2026 03:52:11 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbefc6685sm1004141966b.17.2026.02.03.03.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 03:52:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E8B716036C;
 Tue, 03 Feb 2026 11:52:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yodel Eldar <yodel.eldar@yodel.dev>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Subject: [PATCH 09/11] gdbstub/user-target: Convert host errno to GDB File-I/O
 errno
Date: Tue,  3 Feb 2026 11:51:59 +0000
Message-ID: <20260203115201.2387721-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203115201.2387721-1-alex.bennee@linaro.org>
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x642.google.com
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

Use host_to_gdb_errno to convert host-supplied errnos to their GDB
File-I/O remote protocol values, and use them in F reply packets.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2751
Reported-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260116014612.226183-4-yodel.eldar@yodel.dev>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/user-target.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index 43231e695e8..7ef0282f70e 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/commands.h"
+#include "gdbstub/syscalls.h"
 #include "qemu.h"
 #include "internals.h"
 #ifdef CONFIG_LINUX
@@ -315,7 +316,8 @@ void gdb_handle_v_file_open(GArray *params, void *user_ctx)
     int fd = open(filename, flags, mode);
 #endif
     if (fd < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = host_to_gdb_errno(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
     } else {
         g_string_printf(gdbserver_state.str_buf, "F%x", fd);
     }
@@ -327,7 +329,8 @@ void gdb_handle_v_file_close(GArray *params, void *user_ctx)
     int fd = gdb_get_cmd_param(params, 0)->val_ul;
 
     if (close(fd) == -1) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = host_to_gdb_errno(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
         gdb_put_strbuf();
         return;
     }
@@ -350,7 +353,8 @@ void gdb_handle_v_file_pread(GArray *params, void *user_ctx)
 
     ssize_t n = pread(fd, buf, bufsiz, offset);
     if (n < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = host_to_gdb_errno(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
         gdb_put_strbuf();
         return;
     }
@@ -373,7 +377,8 @@ void gdb_handle_v_file_readlink(GArray *params, void *user_ctx)
     ssize_t n = readlink(filename, buf, BUFSIZ);
 #endif
     if (n < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = host_to_gdb_errno(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
         gdb_put_strbuf();
         return;
     }
-- 
2.47.3


